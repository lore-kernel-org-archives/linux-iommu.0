From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/20] iommu: Add apply_dm_region call-back to iommu-ops
Date: Fri,  8 Jul 2016 13:44:52 +0200
Message-ID: <1467978311-28322-2-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This new call-back will be used by the iommu driver to do
reserve the given dm_region in its iova space before the
mapping is created.

The call-back is temporary until the dma-ops implementation
is part of the common iommu code.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 3 +++
 include/linux/iommu.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3000051..e8d2fb0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -348,6 +348,9 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 	list_for_each_entry(entry, &mappings, list) {
 		dma_addr_t start, end, addr;
 
+		if (domain->ops->apply_dm_region)
+			domain->ops->apply_dm_region(dev, domain, entry);
+
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 664683a..a35fb8b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -152,6 +152,7 @@ struct iommu_dm_region {
  * @domain_set_attr: Change domain attributes
  * @get_dm_regions: Request list of direct mapping requirements for a device
  * @put_dm_regions: Free list of direct mapping requirements for a device
+ * @apply_dm_region: Temporary helper call-back for iova reserved ranges
  * @domain_window_enable: Configure and enable a particular window for a domain
  * @domain_window_disable: Disable a particular window for a domain
  * @domain_set_windows: Set the number of windows for a domain
@@ -186,6 +187,8 @@ struct iommu_ops {
 	/* Request/Free a list of direct mapping requirements for a device */
 	void (*get_dm_regions)(struct device *dev, struct list_head *list);
 	void (*put_dm_regions)(struct device *dev, struct list_head *list);
+	void (*apply_dm_region)(struct device *dev, struct iommu_domain *domain,
+				struct iommu_dm_region *region);
 
 	/* Window handling functions */
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
-- 
1.9.1
