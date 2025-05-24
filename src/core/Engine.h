#ifndef ENGINE_H
#define ENGINE_H
#include <SDL.h>    
#include <SDL_image.h>

const int SCREEN_HEIGHT = 640;
const int SCREEN_WIDTH = 960;


class Engine{
    public:
        static Engine* GetInstance();
        bool Init();
        void Clean();
        void Quit();

        void Update();
        void Render();
        void Events();

        inline bool IsRunning(){
            return m_IsRunning;
        }
    private:
        Engine(){}
        static Engine* s_Instance;
        bool m_IsRunning;

        SDL_Window* m_Window;
        SDL_Renderer* m_Renderer;

};

#endif