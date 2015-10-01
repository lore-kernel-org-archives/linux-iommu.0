From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/vt-d: Split iommu_prepare_identity_map
Date: Thu,  1 Oct 2015 16:34:33 +0200
Message-ID: <1443710074-29701-2-git-send-email-joro@8bytes.org>
References: <1443710074-29701-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443710074-29701-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Split the part of the function that fetches the domain out
and put the rest into into a domain_prepare_identity_map, so
that the code can also be used with when the domain is
already known.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2d7349a..e182d81 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2429,17 +2429,13 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 				  DMA_PTE_READ|DMA_PTE_WRITE);
 }
 
-static int iommu_prepare_identity_map(struct device *dev,
-				      unsigned long long start,
-				      unsigned long long end)
+static int domain_prepare_identity_map(struct device *dev,
+				       struct dmar_domain *domain,
+				       unsigned long long start,
+				       unsigned long long end)
 {
-	struct dmar_domain *domain;
 	int ret;
 
-	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		return -ENOMEM;
-
 	/* For _hardware_ passthrough, don't bother. But for software
 	   passthrough, we do it anyway -- it may indicate a memory
 	   range which is reserved in E820, so which didn't get set
@@ -2459,8 +2455,7 @@ static int iommu_prepare_identity_map(struct device *dev,
 			dmi_get_system_info(DMI_BIOS_VENDOR),
 			dmi_get_system_info(DMI_BIOS_VERSION),
 		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		ret = -EIO;
-		goto error;
+		return -EIO;
 	}
 
 	if (end >> agaw_to_width(domain->agaw)) {
@@ -2470,18 +2465,27 @@ static int iommu_prepare_identity_map(struct device *dev,
 		     dmi_get_system_info(DMI_BIOS_VENDOR),
 		     dmi_get_system_info(DMI_BIOS_VERSION),
 		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		ret = -EIO;
-		goto error;
+		return -EIO;
 	}
 
-	ret = iommu_domain_identity_map(domain, start, end);
-	if (ret)
-		goto error;
+	return iommu_domain_identity_map(domain, start, end);
+}
 
-	return 0;
+static int iommu_prepare_identity_map(struct device *dev,
+				      unsigned long long start,
+				      unsigned long long end)
+{
+	struct dmar_domain *domain;
+	int ret;
+
+	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	if (!domain)
+		return -ENOMEM;
+
+	ret = domain_prepare_identity_map(dev, domain, start, end);
+	if (ret)
+		domain_exit(domain);
 
- error:
-	domain_exit(domain);
 	return ret;
 }
 
-- 
1.9.1
