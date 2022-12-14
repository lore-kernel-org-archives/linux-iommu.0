Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05E3BA24
	for <iommu@lists.linux.dev>; Wed, 14 Dec 2022 22:07:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CA6FFEC;
	Wed, 14 Dec 2022 14:08:36 -0800 (PST)
Received: from [10.57.88.237] (unknown [10.57.88.237])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBDF43F5A1;
	Wed, 14 Dec 2022 14:07:54 -0800 (PST)
Message-ID: <2690fe3e-d68e-5e2b-d9fa-31ce1ccf5ff9@arm.com>
Date: Wed, 14 Dec 2022 22:07:47 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] RISC-V: Disable IPMMU_VMSA on rv32
Content-Language: en-GB
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Conor Dooley <conor@kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
References: <20221214180409.7354-1-palmer@rivosinc.com>
 <8DACBAC8-F220-4DA7-BCC2-4E2ED9E3E03E@kernel.org>
 <b8665f9d-44cf-5719-c206-5eb622978b1a@arm.com>
 <OSZPR01MB7019D761845E3AC9E30F2D2DAAE09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <OSZPR01MB7019D761845E3AC9E30F2D2DAAE09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-12-14 21:40, Prabhakar Mahadev Lad wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: 14 December 2022 21:04
>> To: Conor Dooley <conor@kernel.org>; linux-riscv@lists.infradead.org; Palmer Dabbelt
>> <palmer@rivosinc.com>; arnd@arndb.de; iommu@lists.linux.dev
>> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Subject: Re: [PATCH] RISC-V: Disable IPMMU_VMSA on rv32
>>
>> On 2022-12-14 19:46, Conor Dooley wrote:
>>>
>>>
>>> On 14 December 2022 10:04:09 GMT-08:00, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>>> Without this I get a Kconfig warning and then subsequent build
>>>> failure when building allmodconfig on rv32.
>>>>
>>>> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>>>>    Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64
>> [=y])
>>>>    Selected by [y]:
>>>>    - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] ||
>>>> COMPILE_TEST [=y]
>>>
>>> This here is your problem afaict
>>> I got a report from lkp about it yesterday, "blaming" Prabhakar for it:
>>> https://jpn01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
>>> .kernel.org%2Fall%2F202212142355.b7vf3Jh0-lkp%40intel.com%2F&amp;data=
>>> 05%7C01%7Cprabhakar.mahadev-lad.rj%40bp.renesas.com%7Ca51ccd27ccda45e7
>>> 53c208dade16c553%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63806648
>>> 6632283001%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
>>> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=FshRCpnIoU0b
>>> c38MYnesotcgOV4JT%2FXVOidbDMpAWbc%3D&amp;reserved=0
>>>
>>> I hate selects, just ignores the dependency :(
>>>
>>>    && !GENERIC_ATOMIC64 [=y])
>>
>> I think the existing assumption was that ARCH_RENESAS implied !GENERIC_ATOMIC64. If that is no longer
>> true then please feel free to adjust drivers/iommu/Kconfig to suit.
>>
> IPMMU is not available on Renesas RISCV SoCs, so maybe something like below?

Seems fair to me, especially if it also means hiding a pointless choice 
for a normal interactive config :)

Cheers,
Robin.

> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -283,7 +283,7 @@ config EXYNOS_IOMMU_DEBUG
> 
>   config IPMMU_VMSA
>          bool "Renesas VMSA-compatible IPMMU"
> -       depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +       depends on (ARCH_RENESAS && !RISCV) || (COMPILE_TEST && !GENERIC_ATOMIC64)
>          select IOMMU_API
>          select IOMMU_IO_PGTABLE_LPAE
>          select ARM_DMA_USE_IOMMU
> 
> Cheers,
> Prabhakar
