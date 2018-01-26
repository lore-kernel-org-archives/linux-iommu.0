From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4] iommu/mediatek: Move attach_device after iommu-group is
	ready for M4Uv1
Date: Fri, 26 Jan 2018 15:11:28 +0800
Message-ID: <1516950688-28405-1-git-send-email-yong.wu@mediatek.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bibby Hsieh <bibby.hsieh-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In the commit 05f80300dc8b ("iommu: Finish making iommu_group support
mandatory"), the iommu framework has supposed all the iommu drivers have
their owner iommu-group, it get rid of the FIXME workarounds while the
group is NULL. But the flow of Mediatek M4U gen1 looks a bit trick that
it will hang at this case:

==========================================
Unable to handle kernel NULL pointer dereference at virtual address 00000030
pgd = c0004000
[00000030] *pgd=00000000
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

The root cause is that the device's iommu-group is NULL while
arm_iommu_attach_device is called. This patch prepare a new iommu-group
for the iommu consumer devices to fix this issue.

CC: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
CC: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Fixes: 05f80300dc8b ("iommu: Finish making iommu_group support mandatory")
Reported-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
Change notes:

v4: Get rid of device_group callback.

v3: https://lists.linuxfoundation.org/pipermail/iommu/2018-January/025872.html
    don't use the global variable and allocate a new iommu group before
    arm_iommu_attach_device following Robin's suggestion.

v2: http://lists.infradead.org/pipermail/linux-mediatek/2018-January/011810.html
   Add mtk_domain_v1=NULL in domain_free for symmetry.

v1: https://patchwork.kernel.org/patch/10176255/
---
 drivers/iommu/mtk_iommu_v1.c | 54 +++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 542930c..1b1b7759 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -418,20 +418,12 @@ static int mtk_iommu_create_mapping(struct device *dev,
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
@@ -452,15 +444,30 @@ static int mtk_iommu_add_device(struct device *dev)
 	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
 		return -ENODEV; /* Not a iommu client device */
 
-	data = dev->iommu_fwspec->iommu_priv;
-	iommu_device_link(&data->iommu, dev);
-
-	group = iommu_group_get_for_dev(dev);
+	/*
+	 * This is a short-term bodge because the ARM DMA code doesn't
+	 * understand multi-device groups, but we have to call into it
+	 * successfully (and not just rely on a normal IOMMU API attach
+	 * here) in order to set the correct DMA API ops on @dev.
+	 */
+	group = iommu_group_alloc();
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	err = iommu_group_add_device(group, dev);
 	iommu_group_put(group);
-	return 0;
+	if (err)
+		return err;
+
+	data = dev->iommu_fwspec->iommu_priv;
+	mtk_mapping = data->dev->archdata.iommu;
+	err = arm_iommu_attach_device(dev, mtk_mapping);
+	if (err) {
+		iommu_group_remove_device(dev);
+		return err;
+	}
+
+	return iommu_device_link(&data->iommu, dev);;
 }
 
 static void mtk_iommu_remove_device(struct device *dev)
@@ -477,24 +484,6 @@ static void mtk_iommu_remove_device(struct device *dev)
 	iommu_fwspec_free(dev);
 }
 
-static struct iommu_group *mtk_iommu_device_group(struct device *dev)
-{
-	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
-
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
-}
-
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 {
 	u32 regval;
@@ -547,7 +536,6 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	.iova_to_phys	= mtk_iommu_iova_to_phys,
 	.add_device	= mtk_iommu_add_device,
 	.remove_device	= mtk_iommu_remove_device,
-	.device_group	= mtk_iommu_device_group,
 	.pgsize_bitmap	= ~0UL << MT2701_IOMMU_PAGE_SHIFT,
 };
 
-- 
1.8.1.1.dirty
