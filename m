From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: [PATCH 1/1] iommu/vt-d: Convert non-returned local variable to
 boolean when relevant
Date: Fri, 6 Feb 2015 10:59:53 +0100
Message-ID: <20150206095953.GA5780@sloth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This patch was produced using Coccinelle. A simplified version of the
semantic patch is:

@r exists@
identifier f;
local idexpression u8 x;
identifier xname;
@@

f(...) {
...when any
(
  x@xname = 1;
|
  x@xname = 0;
)
...when any
}

@bad exists@
identifier r.f;
local idexpression u8 r.x
expression e1 != {0, 1}, e2;
@@

f(...) {
...when any
(
  x = e1;
|
  x + e2
)
...when any
}

@depends on !bad@
identifier r.f;
local idexpression u8 r.x;
identifier r.xname;
@@

f(...) {
...
++ bool xname;
- int xname;
<...
(
  x =
- 1
+ true
|
  x =
- -1
+ false
)
...>

}

Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
---
 drivers/iommu/intel-iommu.c         | 13 +++++++------
 drivers/iommu/intel_irq_remapping.c | 12 ++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ae4c1a8..d25cc62 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -595,12 +595,13 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	int i, found = 0;
+	bool found = false;
+	int i;
 
 	domain->iommu_coherency = 1;
 
 	for_each_set_bit(i, domain->iommu_bmp, g_num_of_iommus) {
-		found = 1;
+		found = true;
 		if (!ecap_coherent(g_iommus[i]->ecap)) {
 			domain->iommu_coherency = 0;
 			break;
@@ -1267,7 +1268,7 @@ static struct device_domain_info *
 iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 			 u8 bus, u8 devfn)
 {
-	int found = 0;
+	bool found = false;
 	unsigned long flags;
 	struct device_domain_info *info;
 	struct pci_dev *pdev;
@@ -1282,7 +1283,7 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 	list_for_each_entry(info, &domain->devices, link)
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
-			found = 1;
+			found = true;
 			break;
 		}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -4270,7 +4271,7 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 	struct device_domain_info *info, *tmp;
 	struct intel_iommu *iommu;
 	unsigned long flags;
-	int found = 0;
+	bool found = false;
 	u8 bus, devfn;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
@@ -4302,7 +4303,7 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 		 * update iommu count and coherency
 		 */
 		if (info->iommu == iommu)
-			found = 1;
+			found = true;
 	}
 
 	spin_unlock_irqrestore(&device_domain_lock, flags);
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 14de1ab..6c25b3c 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -631,7 +631,7 @@ static int __init intel_enable_irq_remapping(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	int setup = 0;
+	bool setup = false;
 	int eim = 0;
 
 	if (x2apic_supported()) {
@@ -697,7 +697,7 @@ static int __init intel_enable_irq_remapping(void)
 	 */
 	for_each_iommu(iommu, drhd) {
 		iommu_set_irq_remapping(iommu, eim);
-		setup = 1;
+		setup = true;
 	}
 
 	if (!setup)
@@ -856,7 +856,7 @@ static int __init parse_ioapics_under_ir(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	int ir_supported = 0;
+	bool ir_supported = false;
 	int ioapic_idx;
 
 	for_each_iommu(iommu, drhd)
@@ -864,7 +864,7 @@ static int __init parse_ioapics_under_ir(void)
 			if (ir_parse_ioapic_hpet_scope(drhd->hdr, iommu))
 				return -1;
 
-			ir_supported = 1;
+			ir_supported = true;
 		}
 
 	if (!ir_supported)
@@ -917,7 +917,7 @@ static void disable_irq_remapping(void)
 static int reenable_irq_remapping(int eim)
 {
 	struct dmar_drhd_unit *drhd;
-	int setup = 0;
+	bool setup = false;
 	struct intel_iommu *iommu = NULL;
 
 	for_each_iommu(iommu, drhd)
@@ -933,7 +933,7 @@ static int reenable_irq_remapping(int eim)
 
 		/* Set up interrupt remapping for iommu.*/
 		iommu_set_irq_remapping(iommu, eim);
-		setup = 1;
+		setup = true;
 	}
 
 	if (!setup)
-- 
1.9.1
