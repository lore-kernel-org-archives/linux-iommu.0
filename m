From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Intel-IOMMU: Delete an error message for a failed
	memory allocation in init_dmars()
Date: Sun, 21 Jan 2018 11:37:23 -0800
Message-ID: <1516563443.24895.16.camel@perches.com>
References: <def26d40-37d3-d594-e17c-53e40a3034b7@users.sourceforge.net>
	<20180120133452.GB28161@8bytes.org>
	<6b452dfb-b2fc-2417-26b3-bbcdf11ed06f@users.sourceforge.net>
	<20180120194004.GC28161@8bytes.org>
	<1516498672.24895.2.camel@perches.com>
	<20180121071903.GD28161@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180121071903.GD28161-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 2018-01-21 at 08:19 +0100, J=F6rg R=F6del wrote:
> On Sat, Jan 20, 2018 at 05:37:52PM -0800, Joe Perches wrote:
> > While Markus' commit messages are nearly universally terrible,
> > is there really any signficant value in knowing when any
> > particular OOM condition occurs other than the subsystem that
> > became OOM?
> > =

> > You're going to be hosed in any case.
> > =

> > Why isn't the generic OOM stack dump good enough?
> =

> Because if we know the exact allocation attempt that failed right away,
> we can more easily check if we can rewrite it so that it is more likely
> to succeed, e.g. rewriting one higher-order allocation to multiple
> order-0 allocations.

Up to you but I think that's pretty dubious
as this is an init function and if it fails
the system really is stuffed.

Unrelated, there are some unnecessary casts
of pointers to void * that could be removed
to help make the code a bit more regular as
some callers use the cast and some do not.

---
 drivers/iommu/intel-iommu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4a2de34895ec..8d7ea76345ae 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -845,8 +845,8 @@ static inline struct context_entry *iommu_context_addr(=
struct intel_iommu *iommu
 		if (!context)
 			return NULL;
 =

-		__iommu_flush_cache(iommu, (void *)context, CONTEXT_SIZE);
-		phy_addr =3D virt_to_phys((void *)context);
+		__iommu_flush_cache(iommu, context, CONTEXT_SIZE);
+		phy_addr =3D virt_to_phys(context);
 		*entry =3D phy_addr | 1;
 		__iommu_flush_cache(iommu, entry, sizeof(*entry));
 	}
@@ -1298,7 +1298,7 @@ static int iommu_alloc_root_entry(struct intel_iommu =
*iommu)
 	struct root_entry *root;
 	unsigned long flags;
 =

-	root =3D (struct root_entry *)alloc_pgtable_page(iommu->node);
+	root =3D alloc_pgtable_page(iommu->node);
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
 			iommu->name);
@@ -1978,7 +1978,7 @@ static int domain_init(struct dmar_domain *domain, st=
ruct intel_iommu *iommu,
 	domain->nid =3D iommu->node;
 =

 	/* always allocate the top pgd */
-	domain->pgd =3D (struct dma_pte *)alloc_pgtable_page(domain->nid);
+	domain->pgd =3D alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
 	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
@@ -4168,7 +4168,7 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_heade=
r *header, void *arg)
 	if (!rmrru->resv)
 		goto free_rmrru;
 =

-	rmrru->devices =3D dmar_alloc_dev_scope((void *)(rmrr + 1),
+	rmrru->devices =3D dmar_alloc_dev_scope(rmrr + 1,
 				((void *)rmrr) + rmrr->header.length,
 				&rmrru->devices_cnt);
 	if (rmrru->devices_cnt && rmrru->devices =3D=3D NULL)
@@ -4229,7 +4229,7 @@ int dmar_parse_one_atsr(struct acpi_dmar_header *hdr,=
 void *arg)
 	memcpy(atsru->hdr, hdr, hdr->length);
 	atsru->include_all =3D atsr->flags & 0x1;
 	if (!atsru->include_all) {
-		atsru->devices =3D dmar_alloc_dev_scope((void *)(atsr + 1),
+		atsru->devices =3D dmar_alloc_dev_scope(atsr + 1,
 				(void *)atsr + atsr->header.length,
 				&atsru->devices_cnt);
 		if (atsru->devices_cnt && atsru->devices =3D=3D NULL) {
@@ -4465,7 +4465,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notif=
y_info *info)
 		rmrr =3D container_of(rmrru->hdr,
 				    struct acpi_dmar_reserved_memory, header);
 		if (info->event =3D=3D BUS_NOTIFY_ADD_DEVICE) {
-			ret =3D dmar_insert_dev_scope(info, (void *)(rmrr + 1),
+			ret =3D dmar_insert_dev_scope(info, rmrr + 1,
 				((void *)rmrr) + rmrr->header.length,
 				rmrr->segment, rmrru->devices,
 				rmrru->devices_cnt);
@@ -4483,7 +4483,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notif=
y_info *info)
 =

 		atsr =3D container_of(atsru->hdr, struct acpi_dmar_atsr, header);
 		if (info->event =3D=3D BUS_NOTIFY_ADD_DEVICE) {
-			ret =3D dmar_insert_dev_scope(info, (void *)(atsr + 1),
+			ret =3D dmar_insert_dev_scope(info, atsr + 1,
 					(void *)atsr + atsr->header.length,
 					atsr->segment, atsru->devices,
 					atsru->devices_cnt);
@@ -4920,7 +4920,7 @@ static int md_domain_init(struct dmar_domain *domain,=
 int guest_width)
 	domain->max_addr =3D 0;
 =

 	/* always allocate the top pgd */
-	domain->pgd =3D (struct dma_pte *)alloc_pgtable_page(domain->nid);
+	domain->pgd =3D alloc_pgtable_page(domain->nid);
 	if (!domain->pgd)
 		return -ENOMEM;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
