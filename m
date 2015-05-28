From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/22] iommu: Create direct mappings in default domains
Date: Thu, 28 May 2015 18:41:34 +0200
Message-ID: <1432831305-11126-12-git-send-email-joro@8bytes.org>
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

Use the information exported by the IOMMU drivers to create
direct mapped regions in the default domains.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6b8d6e7..ffad1ea 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -325,6 +325,52 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
 }
 EXPORT_SYMBOL_GPL(iommu_group_set_name);
 
+static int iommu_group_create_direct_mappings(struct iommu_group *group,
+					      struct device *dev)
+{
+	struct iommu_domain *domain = group->default_domain;
+	struct iommu_dm_region *entry;
+	struct list_head mappings;
+	unsigned long pg_size;
+	int ret = 0;
+
+	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
+		return 0;
+
+	BUG_ON(!domain->ops->pgsize_bitmap);
+
+	pg_size = 1UL << __ffs(domain->ops->pgsize_bitmap);
+	INIT_LIST_HEAD(&mappings);
+
+	iommu_get_dm_regions(dev, &mappings);
+
+	/* We need to consider overlapping regions for different devices */
+	list_for_each_entry(entry, &mappings, list) {
+		dma_addr_t start, end, addr;
+
+		start = ALIGN(entry->start, pg_size);
+		end   = ALIGN(entry->start + entry->length, pg_size);
+
+		for (addr = start; addr < end; addr += pg_size) {
+			phys_addr_t phys_addr;
+
+			phys_addr = iommu_iova_to_phys(domain, addr);
+			if (phys_addr)
+				continue;
+
+			ret = iommu_map(domain, addr, addr, pg_size, entry->prot);
+			if (ret)
+				goto out;
+		}
+
+	}
+
+out:
+	iommu_put_dm_regions(dev, &mappings);
+
+	return ret;
+}
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -381,6 +427,8 @@ rename:
 
 	dev->iommu_group = group;
 
+	iommu_group_create_direct_mappings(group, dev);
+
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
-- 
1.9.1
