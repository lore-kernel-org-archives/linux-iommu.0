From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v12 2/3] ARM: EXYNOS: Change System MMU platform device
 definitions
Date: Thu, 15 Mar 2012 12:12:27 +0100
Message-ID: <20120315111227.GA2384@amd.com>
References: <000201cd0286$2e6fbb40$8b4f31c0$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000201cd0286$2e6fbb40$8b4f31c0$%cho@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'Younglak Kim' <younglak1004.kim@samsung.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 15, 2012 at 05:32:39PM +0900, Cho KyongHo wrote:
> Handling System MMUs with an identifier is not flexible to manage
> System MMU platform devices because of the following reasons:
> 1. A device driver which needs to handle System MMU must know the ID.
> 2. A System MMU may not present in some implementations of Exynos family.
> 3. Handling System MMU with IOMMU API does not require an ID.
> 
> This patch is the result of removing ID of System MMUs.
> Instead, a device driver that needs to handle its System MMU must
> use IOMMU API while its descriptor of platform device is given.
> 
> This patch also includes the following enhancements:
> - A System MMU device becomes a child if its power domain device.
> - clkdev
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                    |   10 +-
>  arch/arm/mach-exynos/Makefile                   |    2 +-
>  arch/arm/mach-exynos/clock-exynos4.c            |   79 ++--
>  arch/arm/mach-exynos/clock-exynos4.h            |    2 +
>  arch/arm/mach-exynos/clock-exynos4210.c         |   11 +
>  arch/arm/mach-exynos/clock-exynos4212.c         |   28 ++-
>  arch/arm/mach-exynos/clock-exynos5.c            |   90 +++++
>  arch/arm/mach-exynos/dev-sysmmu.c               |  457 ++++++++++++----------
>  arch/arm/mach-exynos/include/mach/irqs.h        |   25 +-
>  arch/arm/mach-exynos/include/mach/map.h         |   38 ++
>  arch/arm/mach-exynos/include/mach/regs-clock.h  |    5 +
>  arch/arm/mach-exynos/include/mach/regs-sysmmu.h |   28 --
>  arch/arm/mach-exynos/include/mach/sysmmu.h      |   88 +++--
>  arch/arm/mach-exynos/mach-armlex4210.c          |    1 -
>  arch/arm/mach-exynos/mach-smdkv310.c            |    1 -
>  15 files changed, 529 insertions(+), 336 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-sysmmu.h

This patch doesn't apply cleanly against upstream Linux (v3.3-rcX).
Please rebase to upstream and resend. The other 2 patches apply fine.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
