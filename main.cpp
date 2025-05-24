#include "src/core/Engine.h"

int main(int argv, char* argc[]){
    Engine* engine = Engine::GetInstance();
    engine->Init();
    while(engine->IsRunning()){
        engine->Events();
        engine->Update();
        engine->Render();
    }

    engine->Clean();
    return 0;
}