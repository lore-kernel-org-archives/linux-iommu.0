From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 14/22] iommu/amd: Implement dm_region call-backs
Date: Thu, 28 May 2015 18:41:37 +0200
Message-ID: <1432831305-11126-15-git-send-email-joro@8bytes.org>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Add the get_dm_regions and put_dm_regions callbacks to the
iommu_ops of the AMD IOMMU driver.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e43d489..9da3f0e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3412,6 +3412,41 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 	return false;
 }
 
+static void amd_iommu_get_dm_regions(struct device *dev,
+				     struct list_head *head)
+{
+	struct unity_map_entry *entry;
+	u16 devid;
+
+	devid = get_device_id(dev);
+
+	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
+		struct iommu_dm_region *region;
+
+		if (devid < entry->devid_start || devid > entry->devid_end)
+			continue;
+
+		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		region->start = entry->address_start;
+		region->length = entry->address_end - entry->address_start;
+		if (entry->prot & IOMMU_PROT_IR)
+			region->prot |= IOMMU_READ;
+		if (entry->prot & IOMMU_PROT_IW)
+			region->prot |= IOMMU_WRITE;
+
+		list_add_tail(&region->list, head);
+	}
+}
+
+static void amd_iommu_put_dm_regions(struct device *dev,
+				     struct list_head *head)
+{
+	struct iommu_dm_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, head, list)
+		kfree(entry);
+}
+
 static const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3422,6 +3457,8 @@ static const struct iommu_ops amd_iommu_ops = {
 	.unmap = amd_iommu_unmap,
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = amd_iommu_iova_to_phys,
+	.get_dm_regions = amd_iommu_get_dm_regions,
+	.put_dm_regions = amd_iommu_put_dm_regions,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 };
 
-- 
1.9.1
