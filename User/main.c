#include "debug.h"

static void User_GPIOInit(void)
{
	GPIO_InitTypeDef init = {0};

	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
	init.GPIO_Pin = GPIO_Pin_0;
	init.GPIO_Mode = GPIO_Mode_Out_PP;
	init.GPIO_Speed = GPIO_Speed_2MHz;
	GPIO_Init(GPIOA, &init);
}

int main(void)
{
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);
	SystemCoreClockUpdate();
	Delay_Init();
	User_GPIOInit();

	while (1) {
		GPIO_SetBits(GPIOA, GPIO_Pin_0);
		Delay_Ms(500);
		GPIO_ResetBits(GPIOA, GPIO_Pin_0);
		Delay_Ms(500);
	}

	return 0;
}

