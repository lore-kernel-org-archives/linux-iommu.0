From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V3 03/21] iommu/vt-d: introduce helper functions to
	improve code readability
Date: Wed, 25 Jun 2014 17:02:29 +0800
Message-ID: <1403686967-10887-4-git-send-email-jiang.liu@linux.intel.com>
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

Introduce domain_type_is_vm() and domain_type_is_vm_or_si() to improve
code readability.

Also kill useless macro DOMAIN_FLAG_P2P_MULTIPLE_DEVICES.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   59 +++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 64a3c37d5cfa..3bac9785b054 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -321,16 +321,13 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 static struct dmar_domain *si_domain;
 static int hw_pass_through = 1;
 
-/* devices under the same p2p bridge are owned in one domain */
-#define DOMAIN_FLAG_P2P_MULTIPLE_DEVICES (1 << 0)
-
 /* domain represents a virtual machine, more than one devices
  * across iommus may be owned in one domain, e.g. kvm guest.
  */
-#define DOMAIN_FLAG_VIRTUAL_MACHINE	(1 << 1)
+#define DOMAIN_FLAG_VIRTUAL_MACHINE	(1 << 0)
 
 /* si_domain contains mulitple devices */
-#define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 2)
+#define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
 
 /* define the limit of IOMMUs supported in each domain */
 #ifdef	CONFIG_X86
@@ -540,6 +537,16 @@ void free_iova_mem(struct iova *iova)
 	kmem_cache_free(iommu_iova_cache, iova);
 }
 
+static inline int domain_type_is_vm(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE;
+}
+
+static inline int domain_type_is_vm_or_si(struct dmar_domain *domain)
+{
+	return domain->flags & (DOMAIN_FLAG_VIRTUAL_MACHINE |
+				DOMAIN_FLAG_STATIC_IDENTITY);
+}
 
 static int __iommu_calculate_agaw(struct intel_iommu *iommu, int max_gaw)
 {
@@ -580,9 +587,7 @@ static struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 	int iommu_id;
 
 	/* si_domain and vm domain should not get here. */
-	BUG_ON(domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE);
-	BUG_ON(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY);
-
+	BUG_ON(domain_type_is_vm_or_si(domain));
 	iommu_id = find_first_bit(domain->iommu_bmp, g_num_of_iommus);
 	if (iommu_id < 0 || iommu_id >= g_num_of_iommus)
 		return NULL;
@@ -1500,7 +1505,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	free_context_table(iommu);
 }
 
-static struct dmar_domain *alloc_domain(bool vm)
+static struct dmar_domain *alloc_domain(int flags)
 {
 	/* domain id for virtual machine, it won't be set in context */
 	static atomic_t vm_domid = ATOMIC_INIT(0);
@@ -1510,16 +1515,13 @@ static struct dmar_domain *alloc_domain(bool vm)
 	if (!domain)
 		return NULL;
 
+	memset(domain, 0, sizeof(*domain));
 	domain->nid = -1;
-	domain->iommu_count = 0;
-	memset(domain->iommu_bmp, 0, sizeof(domain->iommu_bmp));
-	domain->flags = 0;
+	domain->flags = flags;
 	spin_lock_init(&domain->iommu_lock);
 	INIT_LIST_HEAD(&domain->devices);
-	if (vm) {
+	if (flags & DOMAIN_FLAG_VIRTUAL_MACHINE)
 		domain->id = atomic_inc_return(&vm_domid);
-		domain->flags = DOMAIN_FLAG_VIRTUAL_MACHINE;
-	}
 
 	return domain;
 }
@@ -1707,7 +1709,7 @@ static void domain_exit(struct dmar_domain *domain)
 	/* clear attached or cached domains */
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd)
-		if (domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE ||
+		if (domain_type_is_vm(domain) ||
 		    test_bit(iommu->seq_id, domain->iommu_bmp))
 			iommu_detach_domain(domain, iommu);
 	rcu_read_unlock();
@@ -1749,8 +1751,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	id = domain->id;
 	pgd = domain->pgd;
 
-	if (domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE ||
-	    domain->flags & DOMAIN_FLAG_STATIC_IDENTITY) {
+	if (domain_type_is_vm_or_si(domain)) {
 		int found = 0;
 
 		/* find an available domain id for this device in iommu */
@@ -2116,7 +2117,7 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 		iommu_disable_dev_iotlb(info);
 		iommu_detach_dev(info->iommu, info->bus, info->devfn);
 
-		if (domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE) {
+		if (domain_type_is_vm(domain)) {
 			iommu_detach_dependent_devices(info->iommu, info->dev);
 			/* clear this iommu in iommu_bmp, update iommu count
 			 * and capabilities
@@ -2182,8 +2183,6 @@ static struct dmar_domain *dmar_insert_dev_info(struct intel_iommu *iommu,
 	info->dev = dev;
 	info->domain = domain;
 	info->iommu = iommu;
-	if (!dev)
-		domain->flags |= DOMAIN_FLAG_P2P_MULTIPLE_DEVICES;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	if (dev)
@@ -2258,7 +2257,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 		goto error;
 
 	/* Allocate and initialize new domain for the device */
-	domain = alloc_domain(false);
+	domain = alloc_domain(0);
 	if (!domain)
 		goto error;
 	if (iommu_attach_domain(domain, iommu)) {
@@ -2422,12 +2421,10 @@ static int __init si_domain_init(int hw)
 	struct intel_iommu *iommu;
 	int nid, ret = 0;
 
-	si_domain = alloc_domain(false);
+	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
 	if (!si_domain)
 		return -EFAULT;
 
-	si_domain->flags = DOMAIN_FLAG_STATIC_IDENTITY;
-
 	for_each_active_iommu(iommu, drhd) {
 		ret = iommu_attach_domain(si_domain, iommu);
 		if (ret) {
@@ -3874,9 +3871,7 @@ static int device_notifier(struct notifier_block *nb,
 
 	down_read(&dmar_global_lock);
 	domain_remove_one_dev_info(domain, dev);
-	if (!(domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE) &&
-	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY) &&
-	    list_empty(&domain->devices))
+	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
 		domain_exit(domain);
 	up_read(&dmar_global_lock);
 
@@ -4125,8 +4120,7 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		spin_unlock_irqrestore(&domain->iommu_lock, tmp_flags);
 
-		if (!(domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE) &&
-		    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY)) {
+		if (!domain_type_is_vm_or_si(domain)) {
 			spin_lock_irqsave(&iommu->lock, tmp_flags);
 			clear_bit(domain->id, iommu->domain_ids);
 			iommu->domains[domain->id] = NULL;
@@ -4165,7 +4159,7 @@ static int intel_iommu_domain_init(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain;
 
-	dmar_domain = alloc_domain(true);
+	dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
 	if (!dmar_domain) {
 		printk(KERN_ERR
 			"intel_iommu_domain_init: dmar_domain == NULL\n");
@@ -4209,8 +4203,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 
 		old_domain = find_domain(dev);
 		if (old_domain) {
-			if (dmar_domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE ||
-			    dmar_domain->flags & DOMAIN_FLAG_STATIC_IDENTITY)
+			if (domain_type_is_vm_or_si(dmar_domain))
 				domain_remove_one_dev_info(old_domain, dev);
 			else
 				domain_remove_dev_info(old_domain);
-- 
1.7.10.4
