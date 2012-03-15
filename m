From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v12 2/3] ARM: EXYNOS: Change System MMU platform device
 definitions
Date: Thu, 15 Mar 2012 07:39:25 -0700
Message-ID: <4F61FF1D.5000502@samsung.com>
References: <000201cd0286$2e6fbb40$8b4f31c0$%cho@samsung.com> <20120315111227.GA2384@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120315111227.GA2384@amd.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'Younglak Kim' <younglak1004.kim@samsung.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 03/15/12 04:12, Joerg Roedel wrote:
> On Thu, Mar 15, 2012 at 05:32:39PM +0900, Cho KyongHo wrote:

KyongHo, I looked at 'Cho KyongHo <pullip.cho ...>' and 'KyongHo Cho 
<pullip.cho ...>' in this series, which one do you want to use?

>> Handling System MMUs with an identifier is not flexible to manage
>> System MMU platform devices because of the following reasons:
>> 1. A device driver which needs to handle System MMU must know the ID.
>> 2. A System MMU may not present in some implementations of Exynos family.
>> 3. Handling System MMU with IOMMU API does not require an ID.
>>
>> This patch is the result of removing ID of System MMUs.
>> Instead, a device driver that needs to handle its System MMU must
>> use IOMMU API while its descriptor of platform device is given.
>>
>> This patch also includes the following enhancements:
>> - A System MMU device becomes a child if its power domain device.
>> - clkdev
>>
>> Cc: Kukjin Kim<kgene.kim@samsung.com>
>> Signed-off-by: KyongHo Cho<pullip.cho@samsung.com>
>> ---
>>   arch/arm/mach-exynos/Kconfig                    |   10 +-
>>   arch/arm/mach-exynos/Makefile                   |    2 +-
>>   arch/arm/mach-exynos/clock-exynos4.c            |   79 ++--
>>   arch/arm/mach-exynos/clock-exynos4.h            |    2 +
>>   arch/arm/mach-exynos/clock-exynos4210.c         |   11 +
>>   arch/arm/mach-exynos/clock-exynos4212.c         |   28 ++-
>>   arch/arm/mach-exynos/clock-exynos5.c            |   90 +++++
>>   arch/arm/mach-exynos/dev-sysmmu.c               |  457 ++++++++++++----------
>>   arch/arm/mach-exynos/include/mach/irqs.h        |   25 +-
>>   arch/arm/mach-exynos/include/mach/map.h         |   38 ++
>>   arch/arm/mach-exynos/include/mach/regs-clock.h  |    5 +
>>   arch/arm/mach-exynos/include/mach/regs-sysmmu.h |   28 --
>>   arch/arm/mach-exynos/include/mach/sysmmu.h      |   88 +++--
>>   arch/arm/mach-exynos/mach-armlex4210.c          |    1 -
>>   arch/arm/mach-exynos/mach-smdkv310.c            |    1 -
>>   15 files changed, 529 insertions(+), 336 deletions(-)
>>   delete mode 100644 arch/arm/mach-exynos/include/mach/regs-sysmmu.h
>
> This patch doesn't apply cleanly against upstream Linux (v3.3-rcX).
> Please rebase to upstream and resend. The other 2 patches apply fine.
>

Yes, as KyoungHo said, this has been created on top of Samsung tree 
for-next because this touches many exynos stuff which has been changed 
from Samsung tree for upcoming merge window. So if you're ok on this, 
1st patch and this should be sent to upstream via samsung tree even 
though I can't find any topic branch for this yet. And if you want topic 
branch for your tree, let me know, I can provide it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
