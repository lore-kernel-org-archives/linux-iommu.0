From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 5/6] iommu: Remove IOMMU_OF_DECLARE
Date: Mon,  9 Jul 2018 09:41:52 -0600
Message-ID: <20180709154153.15742-6-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180709154153.15742-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boot-architecture-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we use the driver core to stop deferred probe for missing
drivers, IOMMU_OF_DECLARE can be removed.

This is slightly less optimal than having a list of built-in drivers in
that we'll now defer probe twice before giving up. This shouldn't have a
significant impact on boot times as past discussions about deferred
probe have given no evidence of deferred probe having a substantial
impact.

Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c       |  2 --
 drivers/iommu/arm-smmu.c          |  7 -------
 drivers/iommu/exynos-iommu.c      |  2 --
 drivers/iommu/ipmmu-vmsa.c        |  3 ---
 drivers/iommu/msm_iommu.c         |  2 --
 drivers/iommu/of_iommu.c          | 19 +------------------
 drivers/iommu/qcom_iommu.c        |  2 --
 drivers/iommu/rockchip-iommu.c    |  2 --
 include/asm-generic/vmlinux.lds.h |  2 --
 include/linux/of_iommu.h          |  4 ----
 10 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d647104bccc..22bdabd3d8e0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2915,8 +2915,6 @@ static struct platform_driver arm_smmu_driver = {
 };
 module_platform_driver(arm_smmu_driver);
 
-IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3");
-
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7a96bcf94a6..c73cfce1ccc0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2211,13 +2211,6 @@ static struct platform_driver arm_smmu_driver = {
 };
 module_platform_driver(arm_smmu_driver);
 
-IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1");
-IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2");
-IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400");
-IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
-IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
-IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
-
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 85879cfec52f..b128cb4372d3 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1390,5 +1390,3 @@ static int __init exynos_iommu_init(void)
 	return ret;
 }
 core_initcall(exynos_iommu_init);
-
-IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu");
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 40ae6e87cb88..f026aa16d5f1 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1108,9 +1108,6 @@ static void __exit ipmmu_exit(void)
 subsys_initcall(ipmmu_init);
 module_exit(ipmmu_exit);
 
-IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa");
-IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795");
-
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0d3350463a3f..27377742600d 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -877,7 +877,5 @@ static void __exit msm_iommu_driver_exit(void)
 subsys_initcall(msm_iommu_driver_init);
 module_exit(msm_iommu_driver_exit);
 
-IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu");
-
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>");
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 78ddf47dd67a..f7787e757244 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -27,9 +27,6 @@
 
 #define NO_IOMMU	1
 
-static const struct of_device_id __iommu_of_table_sentinel
-	__used __section(__iommu_of_table_end);
-
 /**
  * of_get_dma_window - Parse *dma-window property and returns 0 if found.
  *
@@ -98,19 +95,6 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
 
-static bool of_iommu_driver_present(struct device_node *np)
-{
-	/*
-	 * If the IOMMU still isn't ready by the time we reach init, assume
-	 * it never will be. We don't want to defer indefinitely, nor attempt
-	 * to dereference __iommu_of_table after it's been freed.
-	 */
-	if (system_state >= SYSTEM_RUNNING)
-		return false;
-
-	return of_match_node(&__iommu_of_table, np);
-}
-
 static int of_iommu_xlate(struct device *dev,
 			  struct of_phandle_args *iommu_spec)
 {
@@ -120,8 +104,7 @@ static int of_iommu_xlate(struct device *dev,
 
 	ops = iommu_ops_from_fwnode(fwnode);
 	if ((ops && !ops->of_xlate) ||
-	    !of_device_is_available(iommu_spec->np) ||
-	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
+	    !of_device_is_available(iommu_spec->np))
 		return NO_IOMMU;
 
 	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index fe88a4880d3a..b48aee82d14b 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -945,7 +945,5 @@ static void __exit qcom_iommu_exit(void)
 module_init(qcom_iommu_init);
 module_exit(qcom_iommu_exit);
 
-IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1");
-
 MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 054cd2c8e9c8..de8d3bf91b23 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1284,8 +1284,6 @@ static int __init rk_iommu_init(void)
 }
 subsys_initcall(rk_iommu_init);
 
-IOMMU_OF_DECLARE(rk_iommu_of, "rockchip,iommu");
-
 MODULE_DESCRIPTION("IOMMU API for Rockchip");
 MODULE_AUTHOR("Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org> and Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>");
 MODULE_ALIAS("platform:rockchip-iommu");
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e373e2e10f6a..f173b5f30dbe 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -218,7 +218,6 @@
 #define TIMER_OF_TABLES()	OF_TABLE(CONFIG_TIMER_OF, timer)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
-#define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
@@ -601,7 +600,6 @@
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	TIMER_OF_TABLES()						\
-	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 4fa654e4b5a9..f3d40dd7bb66 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -32,8 +32,4 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 #endif	/* CONFIG_OF_IOMMU */
 
-extern struct of_device_id __iommu_of_table;
-
-#define IOMMU_OF_DECLARE(name, compat)	OF_DECLARE_1(iommu, name, compat, NULL)
-
 #endif /* __OF_IOMMU_H */
-- 
2.17.1
