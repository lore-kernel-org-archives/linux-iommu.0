From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v8 01/10] iommu/vt-d: Update iommu_attach_domain() and its
	callers
Date: Mon, 12 Jan 2015 15:06:19 +0800
Message-ID: <1421046388-27925-2-git-send-email-zhen-hual@hp.com>
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1421046388-27925-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Allow specification of the domain-id for the new domain.
This patch only adds the 'did' parameter to iommu_attach_domain()
and modifies all of its callers to specify the default value of -1
which says "no did specified, allocate a new one".

This is no functional change from current behaviour -- just enables
a functional change to be made in a later patch.

Bill Sumner:
    Original version.

Li, Zhenhua:
    Minor change, add change to function __iommu_attach_domain.

Signed-off-by: Bill Sumner <billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 40dfbc0..8d5c400 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1534,31 +1534,36 @@ static struct dmar_domain *alloc_domain(int flags)
 }
 
 static int __iommu_attach_domain(struct dmar_domain *domain,
-				 struct intel_iommu *iommu)
+				 struct intel_iommu *iommu,
+				 int domain_number)
 {
 	int num;
 	unsigned long ndomains;
 
 	ndomains = cap_ndoms(iommu->cap);
-	num = find_first_zero_bit(iommu->domain_ids, ndomains);
-	if (num < ndomains) {
-		set_bit(num, iommu->domain_ids);
-		iommu->domains[num] = domain;
-	} else {
-		num = -ENOSPC;
-	}
+	if (domain_number < 0) {
+		num = find_first_zero_bit(iommu->domain_ids, ndomains);
+		if (num < ndomains) {
+			set_bit(num, iommu->domain_ids);
+			iommu->domains[num] = domain;
+		} else {
+			num = -ENOSPC;
+		}
+	} else
+		num = domain_number;
 
 	return num;
 }
 
 static int iommu_attach_domain(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+			       struct intel_iommu *iommu,
+			       int domain_number)
 {
 	int num;
 	unsigned long flags;
 
 	spin_lock_irqsave(&iommu->lock, flags);
-	num = __iommu_attach_domain(domain, iommu);
+	num = __iommu_attach_domain(domain, iommu, domain_number);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 	if (num < 0)
 		pr_err("IOMMU: no free domain ids\n");
@@ -1577,7 +1582,7 @@ static int iommu_attach_vm_domain(struct dmar_domain *domain,
 		if (iommu->domains[num] == domain)
 			return num;
 
-	return __iommu_attach_domain(domain, iommu);
+	return __iommu_attach_domain(domain, iommu, -1);
 }
 
 static void iommu_detach_domain(struct dmar_domain *domain,
@@ -2231,6 +2236,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	u16 dma_alias;
 	unsigned long flags;
 	u8 bus, devfn;
+	int did = -1;   /* Default to "no domain_id supplied" */
 
 	domain = find_domain(dev);
 	if (domain)
@@ -2264,7 +2270,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
-	domain->id = iommu_attach_domain(domain, iommu);
+	domain->id = iommu_attach_domain(domain, iommu, did);
 	if (domain->id < 0) {
 		free_domain_mem(domain);
 		return NULL;
@@ -2442,7 +2448,7 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 
 	for_each_active_iommu(iommu, drhd) {
-		ret = iommu_attach_domain(si_domain, iommu);
+		ret = iommu_attach_domain(si_domain, iommu, -1);
 		if (ret < 0) {
 			domain_exit(si_domain);
 			return -EFAULT;
@@ -3866,7 +3872,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu_enable_translation(iommu);
 
 	if (si_domain) {
-		ret = iommu_attach_domain(si_domain, iommu);
+		ret = iommu_attach_domain(si_domain, iommu, -1);
 		if (ret < 0 || si_domain->id != ret)
 			goto disable_iommu;
 		domain_attach_iommu(si_domain, iommu);
-- 
2.0.0-rc0
