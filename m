From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V2 5/8] iommu/amd: Make call-sites of get_device_id aware of
	its return value
Date: Tue, 26 Jan 2016 18:14:34 -0500
Message-ID: <1453850077-2539-6-git-send-email-vincent.wan@amd.com>
References: <1453850077-2539-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453850077-2539-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

This patch is to make the call-sites of get_device_id aware of its
return value.

Signed-off-by: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 51 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8063ab2..10d6623 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -278,9 +278,11 @@ static void init_unity_mappings_for_device(struct device *dev,
 					   struct dma_ops_domain *dma_dom)
 {
 	struct unity_map_entry *e;
-	u16 devid;
+	int devid;
 
 	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return;
 
 	list_for_each_entry(e, &amd_iommu_unity_map, list) {
 		if (!(devid >= e->devid_start && devid <= e->devid_end))
@@ -295,7 +297,7 @@ static void init_unity_mappings_for_device(struct device *dev,
  */
 static bool check_device(struct device *dev)
 {
-	u16 devid;
+	int devid;
 
 	if (!dev || !dev->dma_mask)
 		return false;
@@ -305,6 +307,8 @@ static bool check_device(struct device *dev)
 		return false;
 
 	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return false;
 
 	/* Out of our scope? */
 	if (devid > amd_iommu_last_bdf)
@@ -341,11 +345,16 @@ static int iommu_init_device(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct iommu_dev_data *dev_data;
+	int devid;
 
 	if (dev->archdata.iommu)
 		return 0;
 
-	dev_data = find_dev_data(get_device_id(dev));
+	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return devid;
+
+	dev_data = find_dev_data(devid);
 	if (!dev_data)
 		return -ENOMEM;
 
@@ -366,9 +375,13 @@ static int iommu_init_device(struct device *dev)
 
 static void iommu_ignore_device(struct device *dev)
 {
-	u16 devid, alias;
+	u16 alias;
+	int devid;
 
 	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return;
+
 	alias = amd_iommu_alias_table[devid];
 
 	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
@@ -380,8 +393,14 @@ static void iommu_ignore_device(struct device *dev)
 
 static void iommu_uninit_device(struct device *dev)
 {
-	struct iommu_dev_data *dev_data = search_dev_data(get_device_id(dev));
+	int devid;
+	struct iommu_dev_data *dev_data;
+
+	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return;
 
+	dev_data = search_dev_data(devid);
 	if (!dev_data)
 		return;
 
@@ -2310,13 +2329,15 @@ static int amd_iommu_add_device(struct device *dev)
 	struct iommu_dev_data *dev_data;
 	struct iommu_domain *domain;
 	struct amd_iommu *iommu;
-	u16 devid;
-	int ret;
+	int ret, devid;
 
 	if (!check_device(dev) || get_dev_data(dev))
 		return 0;
 
 	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return devid;
+
 	iommu = amd_iommu_rlookup_table[devid];
 
 	ret = iommu_init_device(dev);
@@ -2354,12 +2375,15 @@ out:
 static void amd_iommu_remove_device(struct device *dev)
 {
 	struct amd_iommu *iommu;
-	u16 devid;
+	int devid;
 
 	if (!check_device(dev))
 		return;
 
 	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return;
+
 	iommu = amd_iommu_rlookup_table[devid];
 
 	iommu_uninit_device(dev);
@@ -3031,12 +3055,14 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 {
 	struct iommu_dev_data *dev_data = dev->archdata.iommu;
 	struct amd_iommu *iommu;
-	u16 devid;
+	int devid;
 
 	if (!check_device(dev))
 		return;
 
 	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return;
 
 	if (dev_data->domain != NULL)
 		detach_device(dev);
@@ -3154,9 +3180,11 @@ static void amd_iommu_get_dm_regions(struct device *dev,
 				     struct list_head *head)
 {
 	struct unity_map_entry *entry;
-	u16 devid;
+	int devid;
 
 	devid = get_device_id(dev);
+	if (IS_ERR_VALUE(devid))
+		return;
 
 	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
 		struct iommu_dm_region *region;
@@ -3858,6 +3886,9 @@ static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
 	case X86_IRQ_ALLOC_TYPE_MSI:
 	case X86_IRQ_ALLOC_TYPE_MSIX:
 		devid = get_device_id(&info->msi_dev->dev);
+		if (IS_ERR_VALUE(devid))
+			return NULL;
+
 		iommu = amd_iommu_rlookup_table[devid];
 		if (iommu)
 			return iommu->msi_domain;
-- 
1.9.1
