From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V4 13/21] iommu/vt-d: Fix issue in computing domain's
	iommu_snooping flag
Date: Fri, 11 Jul 2014 14:19:37 +0800
Message-ID: <1405059585-10620-14-git-send-email-jiang.liu@linux.intel.com>
References: <1405059585-10620-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1405059585-10620-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

IOMMU units may dynamically attached to/detached from domains,
so we should scan all active IOMMU units when computing iommu_snooping
flag for a domain instead of only scanning IOMMU units associated
with the domain.

Also check snooping and superpage capabilities when hot-adding DMAR units.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index cd1ba24c766a..58cc2b75d7ae 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -633,50 +633,56 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 	rcu_read_unlock();
 }
 
-static void domain_update_iommu_snooping(struct dmar_domain *domain)
+static int domain_update_iommu_snooping(struct intel_iommu *skip)
 {
-	int i;
-
-	domain->iommu_snooping = 1;
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	int ret = 1;
 
-	for_each_set_bit(i, domain->iommu_bmp, g_num_of_iommus) {
-		if (!ecap_sc_support(g_iommus[i]->ecap)) {
-			domain->iommu_snooping = 0;
-			break;
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (iommu != skip) {
+			if (!ecap_sc_support(iommu->ecap)) {
+				ret = 0;
+				break;
+			}
 		}
 	}
+	rcu_read_unlock();
+
+	return ret;
 }
 
-static void domain_update_iommu_superpage(struct dmar_domain *domain)
+static int domain_update_iommu_superpage(struct intel_iommu *skip)
 {
 	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu = NULL;
+	struct intel_iommu *iommu;
 	int mask = 0xf;
 
 	if (!intel_iommu_superpage) {
-		domain->iommu_superpage = 0;
-		return;
+		return 0;
 	}
 
 	/* set iommu_superpage to the smallest common denominator */
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
-		mask &= cap_super_page_val(iommu->cap);
-		if (!mask) {
-			break;
+		if (iommu != skip) {
+			mask &= cap_super_page_val(iommu->cap);
+			if (!mask)
+				break;
 		}
 	}
 	rcu_read_unlock();
 
-	domain->iommu_superpage = fls(mask);
+	return fls(mask);
 }
 
 /* Some capabilities may be different across iommus */
 static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
 	domain_update_iommu_coherency(domain);
-	domain_update_iommu_snooping(domain);
-	domain_update_iommu_superpage(domain);
+	domain->iommu_snooping = domain_update_iommu_snooping(NULL);
+	domain->iommu_superpage = domain_update_iommu_superpage(NULL);
 }
 
 static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
-- 
1.7.10.4
