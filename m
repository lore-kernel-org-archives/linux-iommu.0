From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 01/12] ARM: EXYNOS: remove system mmu initialization
	from exynos tree
Date: Thu, 22 Nov 2012 00:46:29 +0900
Message-ID: <50ACF755.9000706@samsung.com>
References: <002701cdc7a5$756dbdf0$604939d0$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <002701cdc7a5$756dbdf0$604939d0$%cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Subash Patel' <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Sanghyun Lee' <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/21/12 14:02, Cho KyongHo wrote:
> This removes System MMU initialization from arch/arm/mach-exynos/

Basically, looks OK to me, but I think, this removing change should be 
done after 03/12 patch :-)

> to move them to DT and the exynos-iommu driver except gating clock
> definitions.
>
> Change-Id: Ie29f587c01c645f28fc0e0b94eb3631a0170ebf5

No need 'Change-Id' here.

> Signed-off-by: KyongHo Cho<pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>   arch/arm/mach-exynos/Kconfig               |   5 -
>   arch/arm/mach-exynos/Makefile              |   1 -
>   arch/arm/mach-exynos/clock-exynos4.c       |  41 +++--
>   arch/arm/mach-exynos/clock-exynos4210.c    |   9 +-
>   arch/arm/mach-exynos/clock-exynos4212.c    |  23 ++-
>   arch/arm/mach-exynos/clock-exynos5.c       |  62 ++++---
>   arch/arm/mach-exynos/dev-sysmmu.c          | 274 -----------------------------
>   arch/arm/mach-exynos/include/mach/sysmmu.h |  66 -------
>   arch/arm/mach-exynos/mach-exynos4-dt.c     |  34 ++++
>   arch/arm/mach-exynos/mach-exynos5-dt.c     |  30 ++++
>   10 files changed, 137 insertions(+), 408 deletions(-)
>   delete mode 100644 arch/arm/mach-exynos/dev-sysmmu.c
>   delete mode 100644 arch/arm/mach-exynos/include/mach/sysmmu.h


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
