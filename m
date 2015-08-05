From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 14/26] iommu/vt-d: Move context-mapping into
	dmar_insert_dev_info
Date: Wed,  5 Aug 2015 17:18:45 +0200
Message-ID: <1438787937-7340-15-git-send-email-joro@8bytes.org>
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

Do the context-mapping of devices from a single place in the
call-path and clean up the other call-sites.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 265b02e..0d4b700 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2325,6 +2325,12 @@ static struct dmar_domain *dmar_insert_dev_info(struct intel_iommu *iommu,
 		dev->archdata.iommu = info;
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
+	if (dev && domain_context_mapping(domain, dev)) {
+		pr_err("Domain context map for %s failed\n", dev_name(dev));
+		domain_remove_one_dev_info(domain, dev);
+		return NULL;
+	}
+
 	return domain;
 }
 
@@ -2337,11 +2343,11 @@ static int get_last_alias(struct pci_dev *pdev, u16 alias, void *opaque)
 /* domain is initialized */
 static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 {
+	struct device_domain_info *info = NULL;
 	struct dmar_domain *domain, *tmp;
 	struct intel_iommu *iommu;
-	struct device_domain_info *info;
-	u16 dma_alias;
 	unsigned long flags;
+	u16 dma_alias;
 	u8 bus, devfn;
 
 	domain = find_domain(dev);
@@ -2490,11 +2496,6 @@ static int iommu_prepare_identity_map(struct device *dev,
 	if (ret)
 		goto error;
 
-	/* context entry init */
-	ret = domain_context_mapping(domain, dev);
-	if (ret)
-		goto error;
-
 	return 0;
 
  error:
@@ -2590,7 +2591,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
-	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -2600,12 +2600,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (ndomain != domain)
 		return -EBUSY;
 
-	ret = domain_context_mapping(domain, dev);
-	if (ret) {
-		domain_remove_one_dev_info(domain, dev);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -3261,7 +3255,6 @@ static struct iova *intel_alloc_iova(struct device *dev,
 static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 {
 	struct dmar_domain *domain;
-	int ret;
 
 	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 	if (!domain) {
@@ -3270,16 +3263,6 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 		return NULL;
 	}
 
-	/* make sure context mapping is ok */
-	if (unlikely(!domain_context_mapped(dev))) {
-		ret = domain_context_mapping(domain, dev);
-		if (ret) {
-			pr_err("Domain context map for %s failed\n",
-			       dev_name(dev));
-			return NULL;
-		}
-	}
-
 	return domain;
 }
 
-- 
1.9.1
