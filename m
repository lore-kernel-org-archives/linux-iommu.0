From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V4 05/21] iommu/vt-d: Allocate dynamic domain id for
	virtual domains only
Date: Fri, 11 Jul 2014 14:19:29 +0800
Message-ID: <1405059585-10620-6-git-send-email-jiang.liu@linux.intel.com>
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

Check the same domain id is allocated for si_domain on each IOMMU,
otherwise the IOTLB flush for si_domain will fail.

Now the rules to allocate and manage domain id are:
1) For normal and static identity domains, domain id is allocated
   when creating domain structure. And this id will be written into
   context entry.
2) For virtual machine domain, a virtual id is allocated when creating
   domain. And when binding virtual machine domain to an iommu, a real
   domain id is allocated on demand and this domain id will be written
   into context entry. So domain->id for virtual machine domain may be
   different from the domain id written into context entry(used by
   hardware).

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index eae9b0d8bc60..968e3d32e305 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1549,15 +1549,27 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	num = __iommu_attach_domain(domain, iommu);
+	spin_unlock_irqrestore(&iommu->lock, flags);
 	if (num < 0)
 		pr_err("IOMMU: no free domain ids\n");
-	else
-		domain->id = num;
-	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return num;
 }
 
+static int iommu_attach_vm_domain(struct dmar_domain *domain,
+				  struct intel_iommu *iommu)
+{
+	int num;
+	unsigned long ndomains;
+
+	ndomains = cap_ndoms(iommu->cap);
+	for_each_set_bit(num, iommu->domain_ids, ndomains)
+		if (iommu->domains[num] == domain)
+			return num;
+
+	return __iommu_attach_domain(domain, iommu);
+}
+
 static void iommu_detach_domain(struct dmar_domain *domain,
 				struct intel_iommu *iommu)
 {
@@ -1764,8 +1776,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	unsigned long flags;
 	struct dma_pte *pgd;
-	unsigned long num;
-	unsigned long ndomains;
 	int id;
 	int agaw;
 	struct device_domain_info *info = NULL;
@@ -1790,20 +1800,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	pgd = domain->pgd;
 
 	if (domain_type_is_vm_or_si(domain)) {
-		int found = 0;
-
-		/* find an available domain id for this device in iommu */
-		ndomains = cap_ndoms(iommu->cap);
-		for_each_set_bit(num, iommu->domain_ids, ndomains) {
-			if (iommu->domains[num] == domain) {
-				id = num;
-				found = 1;
-				break;
-			}
-		}
-
-		if (found == 0) {
-			id = __iommu_attach_domain(domain, iommu);
+		if (domain_type_is_vm(domain)) {
+			id = iommu_attach_vm_domain(domain, iommu);
 			if (id < 0) {
 				spin_unlock_irqrestore(&iommu->lock, flags);
 				pr_err("IOMMU: no free domain ids\n");
@@ -2257,8 +2255,8 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
-
-	if (iommu_attach_domain(domain, iommu) < 0) {
+	domain->id = iommu_attach_domain(domain, iommu);
+	if (domain->id < 0) {
 		free_domain_mem(domain);
 		return NULL;
 	}
@@ -2428,6 +2426,7 @@ static int __init si_domain_init(int hw)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int nid, ret = 0;
+	bool first = true;
 
 	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
 	if (!si_domain)
@@ -2438,6 +2437,12 @@ static int __init si_domain_init(int hw)
 		if (ret < 0) {
 			domain_exit(si_domain);
 			return -EFAULT;
+		} else if (first) {
+			si_domain->id = ret;
+			first = false;
+		} else if (si_domain->id != ret) {
+			domain_exit(si_domain);
+			return -EFAULT;
 		}
 		domain_attach_iommu(si_domain, iommu);
 	}
-- 
1.7.10.4
