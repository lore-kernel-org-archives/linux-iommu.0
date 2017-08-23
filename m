From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/pamu: Add support for generic iommu-device
Date: Wed, 23 Aug 2017 16:21:34 +0200
Message-ID: <20170823142134.GD19533@8bytes.org>
References: <1502290014-2890-1-git-send-email-joro@8bytes.org>
	<1502290014-2890-5-git-send-email-joro@8bytes.org>
	<878tiaxyu4.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878tiaxyu4.fsf-W0DJWXSxmBNbyGPkN3NxC2scP1bn1w/D@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Cc: Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Michael,

On Wed, Aug 23, 2017 at 10:17:39PM +1000, Michael Ellerman wrote:

> [    0.358192] Call Trace:
> [    0.360624] [c0000000f7173680] [c0000000f7173710] 0xc0000000f7173710 (unreliable)
> [    0.368088] [c0000000f7173710] [c0000000002abf7c] .kernfs_find_and_get_ns+0x4c/0x7c
> [    0.375729] [c0000000f71737a0] [c0000000002b13c8] .sysfs_add_link_to_group+0x44/0x9c
> [    0.383456] [c0000000f7173840] [c000000000591660] .iommu_device_link+0x70/0x144
> [    0.390744] [c0000000f71738e0] [c0000000005942dc] .fsl_pamu_add_device+0x4c/0x80
> [    0.398121] [c0000000f7173960] [c00000000058ce8c] .add_iommu_group+0x5c/0x9c
> [    0.405153] [c0000000f71739e0] [c00000000059d6b8] .bus_for_each_dev+0x98/0xfc
> [    0.412269] [c0000000f7173a80] [c00000000058f1a0] .bus_set_iommu+0xd8/0x11c
> [    0.419218] [c0000000f7173b20] [c000000000d86998] .pamu_domain_init+0xb0/0xe0
> [    0.426331] [c0000000f7173ba0] [c000000000d86864] .fsl_pamu_init+0xec/0x170
> [    0.433276] [c0000000f7173c30] [c000000000001934] .do_one_initcall+0x68/0x1b8
> [    0.440395] [c0000000f7173d00] [c000000000d440e4] .kernel_init_freeable+0x24c/0x324
> [    0.448031] [c0000000f7173db0] [c000000000001b90] .kernel_init+0x20/0x140
> [    0.454801] [c0000000f7173e30] [c0000000000009bc] .ret_from_kernel_thread+0x58/0x9c
> [    0.462438] Instruction dump:
> [    0.465390] 7c0802a6 fb81ffe0 f8010010 fba1ffe8 fbc1fff0 fbe1fff8 f821ff71 7c7e1b78 
> [    0.473114] 7cbd2b78 7c9c2378 60000000 60000000 <a13e0068> 311dffff ebfe0048 552906b4 
> [    0.481017] ---[ end trace 5d11d3e6c29380bd ]---

Thanks for the report, this looks like an initialization ordering
problem. Can you please try the attached patch?

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 9238a85de53e..9ee8e9e161f5 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -44,8 +44,6 @@ static struct paace *spaact;
 
 static bool probed;			/* Has PAMU been probed? */
 
-struct iommu_device pamu_iommu;	/* IOMMU core code handle */
-
 /*
  * Table for matching compatible strings, for device tree
  * guts node, for QorIQ SOCs.
@@ -1156,18 +1154,6 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_genpool;
 
-	ret = iommu_device_sysfs_add(&pamu_iommu, dev, NULL, "iommu0");
-	if (ret)
-		goto error_genpool;
-
-	iommu_device_set_ops(&pamu_iommu, &fsl_pamu_ops);
-
-	ret = iommu_device_register(&pamu_iommu);
-	if (ret) {
-		dev_err(dev, "Can't register iommu device\n");
-		goto error_sysfs;
-	}
-
 	pamubypenr = in_be32(&guts_regs->pamubypenr);
 
 	for (pamu_reg_off = 0, pamu_counter = 0x80000000; pamu_reg_off < size;
@@ -1195,9 +1181,6 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 
 	return 0;
 
-error_sysfs:
-	iommu_device_sysfs_remove(&pamu_iommu);
-
 error_genpool:
 	gen_pool_destroy(spaace_pool);
 
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index fa48222f3421..c3434f29c967 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -391,9 +391,6 @@ struct ome {
 #define EOE_WWSAOL      0x1e    /* Write with stash allocate only and lock */
 #define EOE_VALID       0x80
 
-extern const struct iommu_ops fsl_pamu_ops;
-extern struct iommu_device pamu_iommu;	/* IOMMU core code handle */
-
 /* Function prototypes */
 int pamu_domain_init(void);
 int pamu_enable_liodn(int liodn);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 914953b87bf1..e0fcd079cca9 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -33,6 +33,8 @@ static struct kmem_cache *fsl_pamu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
 static DEFINE_SPINLOCK(device_domain_lock);
 
+struct iommu_device pamu_iommu;	/* IOMMU core code handle */
+
 static struct fsl_dma_domain *to_fsl_dma_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct fsl_dma_domain, iommu_domain);
@@ -1050,7 +1052,7 @@ static u32 fsl_pamu_get_windows(struct iommu_domain *domain)
 	return dma_domain->win_cnt;
 }
 
-const struct iommu_ops fsl_pamu_ops = {
+static const struct iommu_ops fsl_pamu_ops = {
 	.capable	= fsl_pamu_capable,
 	.domain_alloc	= fsl_pamu_domain_alloc,
 	.domain_free    = fsl_pamu_domain_free,
@@ -1076,6 +1078,19 @@ int __init pamu_domain_init(void)
 	if (ret)
 		return ret;
 
+	ret = iommu_device_sysfs_add(&pamu_iommu, NULL, NULL, "iommu0");
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&pamu_iommu, &fsl_pamu_ops);
+
+	ret = iommu_device_register(&pamu_iommu);
+	if (ret) {
+		iommu_device_sysfs_remove(&pamu_iommu);
+		pr_err("Can't register iommu device\n");
+		return ret;
+	}
+
 	bus_set_iommu(&platform_bus_type, &fsl_pamu_ops);
 	bus_set_iommu(&pci_bus_type, &fsl_pamu_ops);
 
diff --git a/drivers/iommu/fsl_pamu_domain.h b/drivers/iommu/fsl_pamu_domain.h
index 6d8661e488fb..f2b0f741d3de 100644
--- a/drivers/iommu/fsl_pamu_domain.h
+++ b/drivers/iommu/fsl_pamu_domain.h
@@ -21,8 +21,6 @@
 
 #include "fsl_pamu.h"
 
-const struct iommu_ops fsl_pamu_ops;
-
 struct dma_window {
 	phys_addr_t paddr;
 	u64 size;
