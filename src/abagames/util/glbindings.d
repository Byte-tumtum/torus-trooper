/*
 * Direct OpenGL bindings for native (non-WASM) targets.
 *
 * bindbc-opengl's POSIX loader only resolves function pointers through the
 * GLX API (glXGetCurrentContext/glXGetProcAddress), which fails when SDL
 * creates an EGL-based context (e.g. the SDL3-backed sdl2-compat on
 * Arch/Omarchy), leaving the gl* function pointers NULL and crashing the
 * game on the first GL call.  Instead of using that loader, link the system
 * libGL directly and declare the functions the game uses here.
 */
module abagames.util.glbindings;

import core.stdc.config;

/++
  GL type shorthands (mirroring the C GL headers).
+/
alias GLenum = uint;
alias GLboolean = ubyte;
alias GLbitfield = uint;
alias GLchar = char;
alias GLbyte = byte;
alias GLubyte = ubyte;
alias GLshort = short;
alias GLushort = ushort;
alias GLint = int;
alias GLuint = uint;
alias GLsizei = int;
alias GLfloat = float;
alias GLclampf = float;
alias GLdouble = double;
alias GLvoid = void;
alias GLintptr = ptrdiff_t;
alias GLsizeiptr = ptrdiff_t;

extern(C) @nogc nothrow:

// OpenGL 1.x fixed-function (kept for the GL_AllowDeprecated path).
void glMatrixMode(GLenum mode);
void glLoadIdentity();
void glPushMatrix();
void glPopMatrix();
void glOrtho(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top,
             GLdouble nearVal, GLdouble farVal);
void glFrustum(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top,
               GLdouble nearVal, GLdouble farVal);
void glMultMatrixf(const(GLfloat)* m);
void glTranslatef(GLfloat x, GLfloat y, GLfloat z);
void glScalef(GLfloat x, GLfloat y, GLfloat z);
void glRotatef(GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
void glBegin(GLenum mode);
void glEnd();
void glVertex3f(GLfloat x, GLfloat y, GLfloat z);
void glColor4f(GLfloat r, GLfloat g, GLfloat b, GLfloat a);
GLenum glGetError();

// OpenGL 1.1 state.
void glViewport(GLint x, GLint y, GLsizei width, GLsizei height);
void glClearColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
void glClear(GLbitfield mask);
void glBlendFunc(GLenum sfactor, GLenum dfactor);
void glEnable(GLenum cap);
void glDisable(GLenum cap);
void glLineWidth(GLfloat width);
void glDrawArrays(GLenum mode, GLint first, GLsizei count);

// OpenGL 1.5 buffer objects.
void glBindBuffer(GLenum target, GLuint buffer);
void glGenBuffers(GLsizei n, GLuint* buffers);
void glBufferData(GLenum target, GLsizeiptr size, const(GLvoid)* data, GLenum usage);

// OpenGL 2.0 shaders.
GLuint glCreateShader(GLenum type);
void glShaderSource(GLuint shader, GLsizei count, const(GLchar*)* string, const(GLint)* length);
void glCompileShader(GLuint shader);
void glGetShaderiv(GLuint shader, GLenum pname, GLint* params);
void glGetShaderInfoLog(GLuint shader, GLsizei bufSize, GLsizei* length, GLchar* infoLog);
GLuint glCreateProgram();
void glAttachShader(GLuint program, GLuint shader);
void glLinkProgram(GLuint program);
void glGetProgramiv(GLuint program, GLenum pname, GLint* params);
void glGetProgramInfoLog(GLuint program, GLsizei bufSize, GLsizei* length, GLchar* infoLog);
void glValidateProgram(GLuint program);
void glUseProgram(GLuint program);
GLint glGetUniformLocation(GLuint program, const(GLchar)* name);
GLint glGetAttribLocation(GLuint program, const(GLchar)* name);
void glUniformMatrix4fv(GLint location, GLsizei count, GLboolean transpose, const(GLfloat)* value);
void glEnableVertexAttribArray(GLuint index);
void glVertexAttribPointer(GLuint index, GLint size, GLenum type, GLboolean normalized,
                           GLsizei stride, const(GLvoid)* pointer);

// OpenGL 3.x vertex array objects.
void glGenVertexArrays(GLsizei n, GLuint* arrays);
void glBindVertexArray(GLuint array);