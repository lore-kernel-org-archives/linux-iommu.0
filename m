From: James Sewart <jamessewart@arista.com>
Subject: [RFC v2] iommu/vt-d: Allow iommu_domain_alloc to allocate
 IOMMU_DOMAIN_DMA
Date: Wed, 5 Dec 2018 17:19:35 +0000
Message-ID: <E1FC52F0-B31C-4FB5-9C57-C72E5F4BCBCE@arista.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Dmitry Safonov <dima@arista.com>
List-Id: iommu@lists.linux-foundation.org

Hey,

There exists an issue in the logic used to determine domain association=20=

with devices. Currently the driver uses find_or_alloc_domain to either=20=

reuse an existing domain or allocate a new one if one isn=E2=80=99t =
found. Domains=20
should be shared between all members of an IOMMU group as this is the=20
minimum granularity that we can guarantee address space isolation.

The intel IOMMU driver exposes pci_device_group in intel_iommu_ops as =
the=20
function to call to determine the group of a device, this is implemented=20=

in the generic IOMMU code and checks: dma aliases, upstream pcie switch=20=

ACS, pci aliases, and pci function aliases. The find_or_alloc_domain =
code=20
currently only uses dma aliases to determine if a domain is shared. This=20=

causes a disconnect between IOMMU groups and domains. We have observed=20=

devices under a pcie switch each having their own domain but assigned =
the=20
same group.

One solution would be to fix the logic in find_or_alloc_domain to add=20
checks for the other conditions that a device may share a domain. =
However,=20
this duplicates code which the generic IOMMU code implements. Instead =
this=20
issue can be fixed by allowing the allocation of default_domain on the=20=

IOMMU group. This is not currently supported as the intel driver does =
not=20
allow allocation of domain type IOMMU_DOMAIN_DMA.

Allowing allocation of DMA domains has the effect that the =
default_domain=20
is non NULL and is attached to a device when initialising. This =
delegates=20
the handling of domains to the generic IOMMU code. Once this is=20
implemented it is possible to remove the lazy allocation of domains=20
entirely.

This patch implements DMA and identity domains to be allocated for=20
external management. As it isn=E2=80=99t known which device will be =
attached to a=20
domain, the dma domain is not initialised at alloc time. Instead it is=20=

allocated when attached. As we may lose RMRR mappings when attaching a=20=

device to a new domain, we also ensure these are mapped at attach time.

This will likely conflict with the work done for auxiliary domains by=20
Baolu but the code to accommodate won=E2=80=99t change much.

I had also started on a patch to remove find_or_alloc_domain and various=20=

functions that call it but had issues with edge cases such as=20
iommu_prepare_isa that is doing domain operations at IOMMU init time.

Cheers,
James.


---
 drivers/iommu/intel-iommu.c | 159 +++++++++++++++++++++++++-----------
 1 file changed, 110 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 41a4b8808802..6437cb2e9b22 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -351,6 +351,14 @@ static int hw_pass_through =3D 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
=20
+/* Domain managed externally, don't cleanup if it isn't attached
+ * to any devices. */
+#define DOMAIN_FLAG_NO_CLEANUP	(1 << 2)
+
+/* Set after domain initialisation. Used when allocating dma domains to
+ * defer domain initialisation until it is attached to a device */
+#define DOMAIN_FLAG_INITIALISED	(1 << 4)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx =3D 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -624,6 +632,16 @@ static inline int domain_type_is_vm_or_si(struct =
dmar_domain *domain)
 				DOMAIN_FLAG_STATIC_IDENTITY);
 }
=20
+static inline int domain_managed_externally(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_NO_CLEANUP;
+}
+
+static inline int domain_is_initialised(struct dmar_domain *domain)
+{
+	return domain->flags & DOMAIN_FLAG_INITIALISED;
+}
+
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -1717,7 +1735,7 @@ static void disable_dmar_iommu(struct intel_iommu =
*iommu)
=20
 		__dmar_remove_one_dev_info(info);
=20
-		if (!domain_type_is_vm_or_si(domain)) {
+		if (!domain_managed_externally(domain)) {
 			/*
 			 * The domain_exit() function  can't be called =
under
 			 * device_domain_lock, as it takes this lock =
itself.
@@ -1951,6 +1969,7 @@ static int domain_init(struct dmar_domain *domain, =
struct intel_iommu *iommu,
 	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
 	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -3234,11 +3253,9 @@ static int copy_translation_tables(struct =
intel_iommu *iommu)
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
-	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables =3D false;
-	struct device *dev;
 	struct intel_iommu *iommu;
-	int i, ret;
+	int ret;
=20
 	/*
 	 * for each drhd
@@ -4529,7 +4522,7 @@ static int device_notifier(struct notifier_block =
*nb,
 		return 0;
=20
 	dmar_remove_one_dev_info(domain, dev);
-	if (!domain_type_is_vm_or_si(domain) && =
list_empty(&domain->devices))
+	if (!domain_managed_externally(domain) && =
list_empty(&domain->devices))
 		domain_exit(domain);
=20
 	return 0;
@@ -4930,6 +4923,7 @@ static int md_domain_init(struct dmar_domain =
*domain, int guest_width)
 	domain->pgd =3D (struct dma_pte =
*)alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
+	domain->flags |=3D DOMAIN_FLAG_INITIALISED;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -4938,28 +4932,65 @@ static struct iommu_domain =
*intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	int flags =3D DOMAIN_FLAG_NO_CLEANUP;
+	int nid;
=20
-	if (type !=3D IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-
-	dmar_domain =3D alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
-	if (!dmar_domain) {
-		pr_err("Can't allocate dmar_domain\n");
-		return NULL;
-	}
-	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		pr_err("Domain initialization failed\n");
-		domain_exit(dmar_domain);
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		flags |=3D DOMAIN_FLAG_VIRTUAL_MACHINE | =
DOMAIN_FLAG_INITIALISED;
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		if (md_domain_init(dmar_domain, =
DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		domain_update_iommu_cap(dmar_domain);
+		domain->geometry.aperture_start =3D 0;
+		domain->geometry.aperture_end   =3D =
__DOMAIN_MAX_ADDR(dmar_domain->gaw);
+		domain->geometry.force_aperture =3D true;
+		break;
+	case IOMMU_DOMAIN_DMA:
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		/* init domain in device attach when we know IOMMU =
capabilities */
+		break;
+	case IOMMU_DOMAIN_IDENTITY:
+		flags |=3D DOMAIN_FLAG_STATIC_IDENTITY | =
DOMAIN_FLAG_INITIALISED;
+		dmar_domain =3D alloc_domain(flags);
+		if (!dmar_domain) {
+			pr_err("Can't allocate dmar_domain\n");
+			return NULL;
+		}
+		if (md_domain_init(dmar_domain, =
DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
+			pr_err("Domain initialization failed\n");
+			domain_exit(dmar_domain);
+			return NULL;
+		}
+		domain_update_iommu_cap(dmar_domain);
+		for_each_online_node(nid) {
+			unsigned long start_pfn, end_pfn;
+			int i, ret;
+
+			for_each_mem_pfn_range(i, nid, &start_pfn, =
&end_pfn, NULL) {
+				ret =3D =
iommu_domain_identity_map(dmar_domain,
+						PFN_PHYS(start_pfn), =
PFN_PHYS(end_pfn));
+				if (ret)
+					return NULL;
+			}
+		}
+		break;
+	default:
 		return NULL;
 	}
-	domain_update_iommu_cap(dmar_domain);
-
-	domain =3D &dmar_domain->domain;
-	domain->geometry.aperture_start =3D 0;
-	domain->geometry.aperture_end   =3D =
__DOMAIN_MAX_ADDR(dmar_domain->gaw);
-	domain->geometry.force_aperture =3D true;
=20
-	return domain;
+	return &dmar_domain->domain;
 }
=20
 static void intel_iommu_domain_free(struct iommu_domain *domain)
@@ -4974,6 +5005,9 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 	struct intel_iommu *iommu;
 	int addr_width;
 	u8 bus, devfn;
+	struct dmar_rmrr_unit *rmrr;
+	struct device *i_dev;
+	int i, ret;
=20
 	if (device_is_rmrr_locked(dev)) {
 		dev_warn(dev, "Device is ineligible for IOMMU domain =
attach due to platform RMRR requirement.  Contact your platform =
vendor.\n");
@@ -4990,8 +5024,8 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 			dmar_remove_one_dev_info(old_domain, dev);
 			rcu_read_unlock();
=20
-			if (!domain_type_is_vm_or_si(old_domain) &&
-			     list_empty(&old_domain->devices))
+			if (list_empty(&old_domain->devices) &&
+			     !domain_managed_externally(old_domain))
 				domain_exit(old_domain);
 		}
 	}
@@ -5000,6 +5034,12 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
=20
+	/* Initialise domain with IOMMU capabilities if it isn't already =
initialised */
+	if (!domain_is_initialised(dmar_domain)) {
+		if (domain_init(dmar_domain, iommu, =
DEFAULT_DOMAIN_ADDRESS_WIDTH))
+			return -ENOMEM;
+	}
+
 	/* check if this iommu agaw is sufficient for max mapped address =
*/
 	addr_width =3D agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5028,6 +5068,27 @@ static int intel_iommu_attach_device(struct =
iommu_domain *domain,
 		dmar_domain->agaw--;
 	}
=20
+	if (domain_type_is_vm_or_si(dmar_domain))
+		goto out;
+
+	/* Ensure DMA domain has devices RMRR */
+	rcu_read_lock();
+	for_each_rmrr_units(rmrr) {
+		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
+					  i, i_dev) {
+			if (i_dev !=3D dev)
+				continue;
+
+			ret =3D domain_prepare_identity_map(dev, =
dmar_domain,
+							  =
rmrr->base_address,
+							  =
rmrr->end_address);
+			if (ret)
+				dev_err(dev, "Mapping reserved region =
failed\n");
+		}
+	}
+	rcu_read_unlock();
+
+out:
 	return domain_add_dev_info(dmar_domain, dev);
 }
=20
--=20
2.17.1
