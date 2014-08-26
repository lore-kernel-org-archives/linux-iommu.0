From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] iommu/amd: Keep a list of devices in an alias group
Date: Tue, 26 Aug 2014 11:36:12 +0200
Message-ID: <1409045774-32000-3-git-send-email-joro@8bytes.org>
References: <1409045774-32000-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409045774-32000-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Some broken devices might use any request-id from the alias
group, so we need to set a DTE entry for every device in
there. This patch adds creation of those lists.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fe6d7cc..8a15256 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -93,6 +93,7 @@ static struct dma_map_ops amd_iommu_dma_ops;
 struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct list_head dev_data_list;	  /* For global dev_data_list */
+	struct list_head alias_list;      /* Link alias-groups together */
 	struct iommu_dev_data *alias_data;/* The alias dev_data */
 	struct protection_domain *domain; /* Domain the device is bound to */
 	atomic_t bind;			  /* Domain attach reference count */
@@ -135,6 +136,8 @@ static struct iommu_dev_data *alloc_dev_data(u16 devid)
 	if (!dev_data)
 		return NULL;
 
+	INIT_LIST_HEAD(&dev_data->alias_list);
+
 	dev_data->devid = devid;
 	atomic_set(&dev_data->bind, 0);
 
@@ -383,6 +386,9 @@ static int iommu_init_device(struct device *dev)
 			return -ENOTSUPP;
 		}
 		dev_data->alias_data = alias_data;
+
+		/* Add device to the alias_list */
+		list_add(&dev_data->alias_list, &alias_data->alias_list);
 	}
 
 	ret = init_iommu_group(dev);
-- 
1.9.1
