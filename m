From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] ARM: Exynos4: update SYSMMU setup code for gen_pd power
	domain driver
Date: Wed, 11 Apr 2012 16:34:31 +0200
Message-ID: <1334154871-4756-3-git-send-email-m.szyprowski@samsung.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1334154871-4756-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

SYSMMU platform devices must be registered before setting up power
domains to let power domain driver to correctly register also SYSMMU
controller devices. This patch also registers SYSMMU controller devices
to respective power domains.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-exynos/dev-sysmmu.c |    6 +++++-
 arch/arm/mach-exynos/pm_domains.c |   13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/dev-sysmmu.c b/arch/arm/mach-exynos/dev-sysmmu.c
index c5b1ea3..3544638 100644
--- a/arch/arm/mach-exynos/dev-sysmmu.c
+++ b/arch/arm/mach-exynos/dev-sysmmu.c
@@ -271,4 +271,8 @@ static int __init init_sysmmu_platform_device(void)
 
 	return 0;
 }
-arch_initcall(init_sysmmu_platform_device);
+/*
+ * SYSMMU platform devices must be registered before power domains
+ * see pm_domain.c, which use arch_initcall()
+ */
+core_initcall(init_sysmmu_platform_device);
diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 13b3068..51a028d 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 
 #include <mach/regs-pmu.h>
+#include <mach/sysmmu.h>
 #include <plat/devs.h>
 
 /*
@@ -155,6 +156,18 @@ static __init int exynos4_pm_init_power_domain(void)
 		pm_genpd_init(&exynos4_pm_domains[idx]->pd, NULL,
 				exynos4_pm_domains[idx]->is_off);
 
+#ifdef CONFIG_EXYNOS_DEV_SYSMMU
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(fimc0), &exynos4_pd_cam);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(fimc1), &exynos4_pd_cam);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(fimc2), &exynos4_pd_cam);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(fimc3), &exynos4_pd_cam);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(jpeg), &exynos4_pd_cam);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(mfc_l), &exynos4_pd_mfc);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(mfc_r), &exynos4_pd_mfc);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(fimd0), &exynos4_pd_lcd0);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(rot), &exynos4_pd_lcd0);
+	exynos_pm_add_dev_to_genpd(&SYSMMU_PLATDEV(tv), &exynos4_pd_tv);
+#endif
 #ifdef CONFIG_S5P_DEV_FIMD0
 	exynos_pm_add_dev_to_genpd(&s5p_device_fimd0, &exynos4_pd_lcd0);
 #endif
-- 
1.7.1.569.g6f426
