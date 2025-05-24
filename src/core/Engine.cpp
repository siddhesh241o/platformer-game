#include "Engine.h"
#include <stdio.h>
Engine* Engine::s_Instance = nullptr;

Engine* Engine::GetInstance(){
    if(s_Instance == nullptr){
        s_Instance = new Engine();
    }
    return s_Instance;
}

bool Engine::Init(){
    if(SDL_Init(SDL_INIT_VIDEO) < 0 || IMG_Init(IMG_INIT_JPG | IMG_INIT_PNG) < 0){
        SDL_Log("Failed to initialize SDL: %s", SDL_GetError());
        return false;
    }

    m_Window = SDL_CreateWindow("Platform Game", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, SCREEN_WIDTH, SCREEN_HEIGHT, 0);
    if(m_Window == nullptr){
        SDL_Log("Failed to create window: %s", SDL_GetError());
        return false;
    }

    m_Renderer = SDL_CreateRenderer(m_Window, -1, SDL_RENDERER_ACCELERATED| SDL_RENDERER_PRESENTVSYNC);
    if(m_Renderer == nullptr){
        SDL_Log("Failed to create renderer: %s", SDL_GetError());
        return false;
    }

    m_IsRunning = true;
    return true;
}

void Engine::Clean(){

}

void Engine::Quit(){
    m_IsRunning = false;
}

void Engine::Update(){

}

void Engine::Events(){
    SDL_Event event;
    SDL_PollEvent(&event);
    switch(event.type){
        case SDL_QUIT:
            Quit();
            break;
    }
}

void Engine::Render(){
    SDL_SetRenderDrawColor(m_Renderer, 124, 210, 254, 255);
    SDL_RenderPresent(m_Renderer);
}