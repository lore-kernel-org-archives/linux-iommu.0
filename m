From: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 4/8] iommu/vt-d: Update iommu_attach_domain() and its callers
Date: Thu, 24 Apr 2014 18:36:34 -0600
Message-ID: <1398386198-19304-5-git-send-email-bill.sumner@hp.com>
References: <1398386198-19304-1-git-send-email-bill.sumner@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398386198-19304-1-git-send-email-bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhenhua-VXdhtT5mjnY@public.gmane.org, bill.sumner-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Allow specification of the domain-id for the new domain.
This patch only adds the 'did' parameter to iommu_attach_domain()
and modifies all of its callers to specify the default value of -1
which says "no did specified, allocate a new one".

This is no functional change from current behaviour -- just enables
a functional change to be made in a later patch.

Signed-off-by: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4116377..226c1d0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1181,7 +1181,8 @@ static struct dmar_domain *alloc_domain(bool vm)
 }
 
 static int iommu_attach_domain(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
+			       struct intel_iommu *iommu,
+			       int domain_number)
 {
 	int num;
 	unsigned long ndomains;
@@ -1191,12 +1192,15 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	num = find_first_zero_bit(iommu->domain_ids, ndomains);
-	if (num >= ndomains) {
-		spin_unlock_irqrestore(&iommu->lock, flags);
-		printk(KERN_ERR "IOMMU: no free domain ids\n");
-		return -ENOMEM;
-	}
+	if (domain_number < 0) {
+		num = find_first_zero_bit(iommu->domain_ids, ndomains);
+		if (num >= ndomains) {
+			spin_unlock_irqrestore(&iommu->lock, flags);
+			pr_err("IOMMU: no free domain ids\n");
+			return -ENOMEM;
+		}
+	} else
+		num = domain_number;
 
 	domain->id = num;
 	domain->iommu_count++;
@@ -1875,6 +1879,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	struct pci_dev *dev_tmp = NULL;
 	unsigned long flags;
 	u8 bus, devfn, bridge_bus, bridge_devfn;
+	int did = -1;   /* Default to "no domain_id supplied" */
 
 	domain = find_domain(dev);
 	if (domain)
@@ -1915,7 +1920,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(false);
 	if (!domain)
 		goto error;
-	if (iommu_attach_domain(domain, iommu)) {
+	if (iommu_attach_domain(domain, iommu, did)) {
 		free_domain_mem(domain);
 		domain = NULL;
 		goto error;
@@ -2083,7 +2088,7 @@ static int __init si_domain_init(int hw)
 	si_domain->flags = DOMAIN_FLAG_STATIC_IDENTITY;
 
 	for_each_active_iommu(iommu, drhd) {
-		ret = iommu_attach_domain(si_domain, iommu);
+		ret = iommu_attach_domain(si_domain, iommu, (int) -1);
 		if (ret) {
 			domain_exit(si_domain);
 			return -EFAULT;
-- 
Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
