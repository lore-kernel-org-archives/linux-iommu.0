From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2] iommu/mediatek: Move attach_device after iommu-group is
	ready for M4Uv1
Date: Tue, 23 Jan 2018 16:39:48 +0800
Message-ID: <1516696788-8668-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bibby Hsieh <bibby.hsieh-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In the commit 05f80300dc8b ("iommu: Finish making iommu_group support
mandatory"), the iommu framework has supposed all the iommu drivers have
their owner iommu-group, it get rid of the FIXME workarounds while the
group is NULL. But the flow of Mediatek M4U gen1 looks a bit trick that
it will hang at this case:

==========================================
Unable to handle kernel NULL pointer dereference at virtual address 00000030
PC is at mutex_lock+0x28/0x54
LR is at iommu_attach_device+0xa4/0xd4
pc : [<c07632e8>]    lr : [<c04736fc>]    psr: 60000013
sp : df0edbb8  ip : df0edbc8  fp : df0edbc4
r10: c114da14  r9 : df2a3e40  r8 : 00000003
r7 : df27a210  r6 : df2a90c4  r5 : 00000030  r4 : 00000000
r3 : df0f8000  r2 : fffff000  r1 : df29c610  r0 : 00000030
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
xxx
(mutex_lock) from [<c04736fc>] (iommu_attach_device+0xa4/0xd4)
(iommu_attach_device) from [<c011b9dc>] (__arm_iommu_attach_device+0x28/0x90)
(__arm_iommu_attach_device) from [<c011ba60>] (arm_iommu_attach_device+0x1c/0x30)
(arm_iommu_attach_device) from [<c04759ac>] (mtk_iommu_add_device+0xfc/0x214)
(mtk_iommu_add_device) from [<c0472aa4>] (add_iommu_group+0x3c/0x68)
(add_iommu_group) from [<c047d044>] (bus_for_each_dev+0x78/0xac)
(bus_for_each_dev) from [<c04734a4>] (bus_set_iommu+0xb0/0xec)
(bus_set_iommu) from [<c0476310>] (mtk_iommu_probe+0x328/0x368)
(mtk_iommu_probe) from [<c048189c>] (platform_drv_probe+0x5c/0xc0)
(platform_drv_probe) from [<c047f510>] (driver_probe_device+0x2f4/0x4d8)
(driver_probe_device) from [<c047f800>] (__driver_attach+0x10c/0x128)
(__driver_attach) from [<c047d044>] (bus_for_each_dev+0x78/0xac)
(bus_for_each_dev) from [<c047ec78>] (driver_attach+0x2c/0x30)
(driver_attach) from [<c047e640>] (bus_add_driver+0x1e0/0x278)
(bus_add_driver) from [<c048052c>] (driver_register+0x88/0x108)
(driver_register) from [<c04817ec>] (__platform_driver_register+0x50/0x58)
(__platform_driver_register) from [<c0b31380>] (m4u_init+0x24/0x28)
(m4u_init) from [<c0101c38>] (do_one_initcall+0xf0/0x17c)
=========================

The root cause is that "arm_iommu_attach_device" is called before
"iommu_group_get_for_dev" in the interface "mtk_iommu_add_device". Thus,
We adjust the sequence of this two functions.

Unfortunately, there is another issue after the solution above, From the
function "iommu_attach_device", Only one device in each a iommu group is
allowed. In Mediatek case, there is only one m4u group, all the devices
are in one group. thus it get fail at this step.

In order to satisfy this requirement, a new iommu group is allocated for
each a iommu consumer device. But meanwhile, we still have to use the
same domain for all the iommu group. Use a global variable "mtk_domain_v1"
to save the global domain.

CC: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
CC: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Fixes: 05f80300dc8b ("iommu: Finish making iommu_group support mandatory")
Reported-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Tested-by: Bibby Hsieh <bibby.hsieh-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
changes since v1:
   Add mtk_domain_v1=NULL in domain_free for symmetry.

v1: https://patchwork.kernel.org/patch/10176255/
---
 drivers/iommu/mtk_iommu_v1.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 542930c..86106bf 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -103,6 +103,9 @@ struct mtk_iommu_domain {
 	struct mtk_iommu_data		*data;
 };
 
+/* There is only a iommu domain in M4U gen1. */
+static struct mtk_iommu_domain *mtk_domain_v1;
+
 static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct mtk_iommu_domain, domain);
@@ -251,10 +254,15 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
+	/* Always return the same domain. */
+	if (mtk_domain_v1)
+		return &mtk_domain_v1->domain;
+
 	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
 	if (!dom)
 		return NULL;
 
+	mtk_domain_v1 = dom;
 	return &dom->domain;
 }
 
@@ -263,6 +271,7 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct mtk_iommu_data *data = dom->data;
 
+	mtk_domain_v1 = NULL;
 	dma_free_coherent(data->dev, M2701_IOMMU_PGT_SIZE,
 			dom->pgt_va, dom->pgt_pa);
 	kfree(to_mtk_domain(domain));
@@ -418,20 +427,12 @@ static int mtk_iommu_create_mapping(struct device *dev,
 		m4udev->archdata.iommu = mtk_mapping;
 	}
 
-	ret = arm_iommu_attach_device(dev, mtk_mapping);
-	if (ret)
-		goto err_release_mapping;
-
 	return 0;
-
-err_release_mapping:
-	arm_iommu_release_mapping(mtk_mapping);
-	m4udev->archdata.iommu = NULL;
-	return ret;
 }
 
 static int mtk_iommu_add_device(struct device *dev)
 {
+	struct dma_iommu_mapping *mtk_mapping;
 	struct of_phandle_args iommu_spec;
 	struct of_phandle_iterator it;
 	struct mtk_iommu_data *data;
@@ -460,7 +461,9 @@ static int mtk_iommu_add_device(struct device *dev)
 		return PTR_ERR(group);
 
 	iommu_group_put(group);
-	return 0;
+
+	mtk_mapping = data->dev->archdata.iommu;
+	return arm_iommu_attach_device(dev, mtk_mapping);
 }
 
 static void mtk_iommu_remove_device(struct device *dev)
@@ -479,20 +482,13 @@ static void mtk_iommu_remove_device(struct device *dev)
 
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
-	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct iommu_group *group;
 
-	if (!data)
-		return ERR_PTR(-ENODEV);
-
-	/* All the client devices are in the same m4u iommu-group */
-	if (!data->m4u_group) {
-		data->m4u_group = iommu_group_alloc();
-		if (IS_ERR(data->m4u_group))
-			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
-	} else {
-		iommu_group_ref_get(data->m4u_group);
-	}
-	return data->m4u_group;
+	group = iommu_group_get(dev);
+	if (!group)
+		group = generic_device_group(dev);
+
+	return group;
 }
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
-- 
1.8.1.1.dirty
