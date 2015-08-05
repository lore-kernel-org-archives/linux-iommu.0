From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 15/26] iommu/vt-d: Rename dmar_insert_dev_info()
Date: Wed,  5 Aug 2015 17:18:46 +0200
Message-ID: <1438787937-7340-16-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Rename this function to dmar_insert_one_dev_info() to match
the name better with its counter part function
domain_remove_one_dev_info().

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0d4b700..8e87208 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2284,10 +2284,10 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 	return NULL;
 }
 
-static struct dmar_domain *dmar_insert_dev_info(struct intel_iommu *iommu,
-						int bus, int devfn,
-						struct device *dev,
-						struct dmar_domain *domain)
+static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
+						    int bus, int devfn,
+						    struct device *dev,
+						    struct dmar_domain *domain)
 {
 	struct dmar_domain *found = NULL;
 	struct device_domain_info *info;
@@ -2394,8 +2394,8 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 
 	/* register PCI DMA alias device */
 	if (dev_is_pci(dev)) {
-		tmp = dmar_insert_dev_info(iommu, PCI_BUS_NUM(dma_alias),
-					   dma_alias & 0xff, NULL, domain);
+		tmp = dmar_insert_one_dev_info(iommu, PCI_BUS_NUM(dma_alias),
+					       dma_alias & 0xff, NULL, domain);
 
 		if (!tmp || tmp != domain) {
 			domain_exit(domain);
@@ -2407,7 +2407,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	}
 
 found_domain:
-	tmp = dmar_insert_dev_info(iommu, bus, devfn, dev, domain);
+	tmp = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
 
 	if (!tmp || tmp != domain) {
 		domain_exit(domain);
@@ -2596,7 +2596,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	ndomain = dmar_insert_dev_info(iommu, bus, devfn, dev, domain);
+	ndomain = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
 	if (ndomain != domain)
 		return -EBUSY;
 
-- 
1.9.1
