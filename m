From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V3 06/21] iommu/vt-d: fix possible invalid memory access
	caused by free_dmar_iommu()
Date: Wed, 25 Jun 2014 17:02:32 +0800
Message-ID: <1403686967-10887-7-git-send-email-jiang.liu@linux.intel.com>
References: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403686967-10887-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Static identity and virtual machine domains may be cached in
iommu->domain_ids array after corresponding IOMMUs have been removed
from domain->iommu_bmp. So we should check domain->iommu_bmp before
decreasing domain->iommu_count in function free_dmar_iommu(), otherwise
it may cause free of inuse domain data structure.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c9d7279f8f8a..b1ac737b3196 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -426,6 +426,8 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 				       struct device *dev);
 static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 					   struct device *dev);
+static int domain_detach_iommu(struct dmar_domain *domain,
+			       struct intel_iommu *iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
 int dmar_disabled = 0;
@@ -1468,8 +1470,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 static void free_dmar_iommu(struct intel_iommu *iommu)
 {
 	struct dmar_domain *domain;
-	int i, count;
-	unsigned long flags;
+	int i;
 
 	if ((iommu->domains) && (iommu->domain_ids)) {
 		for_each_set_bit(i, iommu->domain_ids, cap_ndoms(iommu->cap)) {
@@ -1482,11 +1483,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 
 			domain = iommu->domains[i];
 			clear_bit(i, iommu->domain_ids);
-
-			spin_lock_irqsave(&domain->iommu_lock, flags);
-			count = --domain->iommu_count;
-			spin_unlock_irqrestore(&domain->iommu_lock, flags);
-			if (count == 0)
+			if (domain_detach_iommu(domain, iommu) == 0)
 				domain_exit(domain);
 		}
 	}
-- 
1.7.10.4
