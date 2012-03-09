From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 07/23] pci, dmar: Update dmar units devices list during hotplug
Date: Thu, 8 Mar 2012 18:06:07 -0700
Message-ID: <CAErSpo6jqr44JS4Cyfc0cR_TNbo_ETjPJUO=x2gj-Q_x4TckVA@mail.gmail.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org> <1331018040-30725-8-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1331018040-30725-8-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 6, 2012 at 12:13 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> When do pci remove/rescan on system that have more iommus, got
>
> [ =A0894.089745] Set context mapping for c4:00.0
> [ =A0894.110890] mpt2sas3: Allocated physical memory: size(4293 kB)
> [ =A0894.112556] mpt2sas3: Current Controller Queue Depth(1883), Max =
Controller Queue Depth(2144)
> [ =A0894.127278] mpt2sas3: Scatter Gather Elements per IO(128)
> [ =A0894.361295] DRHD: handling fault status reg 2
> [ =A0894.364053] DMAR:[DMA Read] Request device [c4:00.0] fault addr =
fffbe000
> [ =A0894.364056] DMAR:[fault reason 02] Present bit in context entry =
is cl
>
> it turns out when remove/rescan, pci dev will be freed and will get a=
nother new dev.
> but drhd units still keep old one... so dmar_find_matched_drhd_unit w=
ill
> return wrong drhd and iommu for the device that is not on first iommu=
=2E
>
> So need to update devices in drhd_units during pci remove/rescan.
>
> Could save domain/bus/device/function aside in the list and according=
 that info
> restore new dev to drhd_units later.
> Then dmar_find_matched_drdh_unit and device_to_iommu could return rig=
ht drhd and iommu.
>
> Add remove_dev_from_drhd/restore_dev_to_drhd functions to do the real=
 work.
> call them in device ADD_DEVICE and UNBOUND_DRIVER
>
> Need to do the samething to atsr. =A0(expose dmar_atsr_units and add =
atsru->segment)
>
> After patch, will right iommu for the new dev and will not get DMAR e=
rror any more.
>
> -v2: add pci_dev_put/pci_dev_get to make refcount consistent.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: iommu@lists.linux-foundation.org
> ---
> =A0drivers/iommu/intel-iommu.c | =A0187 +++++++++++++++++++++++++++++=
+++++++++++---
> =A0include/linux/dmar.h =A0 =A0 =A0 =A0| =A0 =A04 +
> =A02 files changed, 181 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.=
c
> index c9c6053..39ef2ce 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -665,6 +665,159 @@ static struct intel_iommu *device_to_iommu(int =
segment, u8 bus, u8 devfn)
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +#ifdef CONFIG_HOTPLUG
> +struct dev_dmaru {
> + =A0 =A0 =A0 struct list_head list;
> + =A0 =A0 =A0 void *dmaru;
> + =A0 =A0 =A0 int index;
> + =A0 =A0 =A0 int segment;
> + =A0 =A0 =A0 unsigned char bus;
> + =A0 =A0 =A0 unsigned int devfn;
> +};
> +
> +static int
> +save_dev_dmaru(int segment, unsigned char bus, unsigned int devfn,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *dmaru, int index, struct list_=
head *lh)

=46ollow the indentation style used elsewhere in the file: as much of
the declaration on one line as will fit (here and below).

I think the callers would read more naturally if you passed in the
struct pci_dev * to save_dev_dmaru() and extracted the
segment/bus/devfn here rather than in the callers.

> +{
> + =A0 =A0 =A0 struct dev_dmaru *m;
> +
> + =A0 =A0 =A0 m =3D kzalloc(sizeof(*m), GFP_KERNEL);
> + =A0 =A0 =A0 if (!m)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 m->segment =3D segment;
> + =A0 =A0 =A0 m->bus =A0 =A0 =3D bus;
> + =A0 =A0 =A0 m->devfn =A0 =3D devfn;
> + =A0 =A0 =A0 m->dmaru =A0 =3D dmaru;
> + =A0 =A0 =A0 m->index =A0 =3D index;
> +
> + =A0 =A0 =A0 list_add(&m->list, lh);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void
> +*get_dev_dmaru(int segment, unsigned char bus, unsigned int devfn,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *index, struct list_head *lh)
> +{
> + =A0 =A0 =A0 struct dev_dmaru *m;
> + =A0 =A0 =A0 void *dmaru =3D NULL;
> +
> + =A0 =A0 =A0 list_for_each_entry(m, lh, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (m->segment =3D=3D segment &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->bus =3D=3D bus && m->devfn =3D=
=3D devfn) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *index =3D m->index;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmaru =A0=3D m->dmaru;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&m->list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(m);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return dmaru;
> +}
> +
> +static LIST_HEAD(saved_dev_drhd_list);
> +
> +static void remove_dev_from_drhd(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 struct dmar_drhd_unit *drhd =3D NULL;
> + =A0 =A0 =A0 int segment =3D pci_domain_nr(dev->bus);
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for_each_drhd_unit(drhd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drhd->ignored)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (segment !=3D drhd->segment)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < drhd->devices_cnt; i+=
+) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drhd->devices[i] =3D=
=3D dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* save=
 it at first if it is in drhd */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_de=
v_dmaru(segment, dev->bus->number,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 dev->devfn, drhd, i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &saved_dev_drhd_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* alwa=
ys remove it */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_dev=
_put(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drhd->d=
evices[i] =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +static void restore_dev_to_drhd(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 struct dmar_drhd_unit *drhd =3D NULL;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 /* find the stored drhd */
> + =A0 =A0 =A0 drhd =3D get_dev_dmaru(pci_domain_nr(dev->bus), dev->bu=
s->number,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev-=
>devfn, &i, &saved_dev_drhd_list);
> + =A0 =A0 =A0 /* restore that into drhd */
> + =A0 =A0 =A0 if (drhd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drhd->devices[i] =3D pci_dev_get(dev);
> +}
> +#else
> +static void remove_dev_from_drhd(struct pci_dev *dev)
> +{
> +}
> +
> +static void restore_dev_to_drhd(struct pci_dev *dev)
> +{
> +}
> +#endif
> +
> +#if defined(CONFIG_DMAR) && defined(CONFIG_HOTPLUG)
> +static LIST_HEAD(saved_dev_atsr_list);
> +
> +static void remove_dev_from_atsr(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 struct dmar_atsr_unit *atsr =3D NULL;
> + =A0 =A0 =A0 int segment =3D pci_domain_nr(dev->bus);
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for_each_atsr_unit(atsr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (segment !=3D atsr->segment)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < atsr->devices_cnt; i+=
+) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (atsr->devices[i] =3D=
=3D dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* save=
 it at first if it is in drhd */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_de=
v_dmaru(segment, dev->bus->number,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 dev->devfn, atsr, i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &saved_dev_atsr_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* alwa=
ys remove it */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_dev=
_put(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atsr->d=
evices[i] =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +static void restore_dev_to_atsr(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 struct dmar_atsr_unit *atsr =3D NULL;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 /* find the stored atsr */
> + =A0 =A0 =A0 atsr =3D get_dev_dmaru(pci_domain_nr(dev->bus), dev->bu=
s->number,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev-=
>devfn, &i, &saved_dev_atsr_list);
> + =A0 =A0 =A0 /* restore that into atsr */
> + =A0 =A0 =A0 if (atsr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atsr->devices[i] =3D pci_dev_get(dev);
> +}
> +#else
> +static void remove_dev_from_atsr(struct pci_dev *dev)
> +{
> +}
> +
> +static void restore_dev_to_atsr(struct pci_dev *dev)
> +{
> +}
> +#endif
> +
> =A0static void domain_flush_cache(struct dmar_domain *domain,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *add=
r, int size)
> =A0{
> @@ -3474,6 +3627,7 @@ int __init dmar_parse_one_atsr(struct acpi_dmar=
_header *hdr)
>
> =A0 =A0 =A0 =A0atsru->hdr =3D hdr;
> =A0 =A0 =A0 =A0atsru->include_all =3D atsr->flags & 0x1;
> + =A0 =A0 =A0 atsru->segment =3D atsr->segment;
>
> =A0 =A0 =A0 =A0list_add(&atsru->list, &dmar_atsr_units);
>
> @@ -3505,16 +3659,13 @@ int dmar_find_matched_atsr_unit(struct pci_de=
v *dev)
> =A0{
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> - =A0 =A0 =A0 struct acpi_dmar_atsr *atsr;
> =A0 =A0 =A0 =A0struct dmar_atsr_unit *atsru;
>
> =A0 =A0 =A0 =A0dev =3D pci_physfn(dev);
>
> - =A0 =A0 =A0 list_for_each_entry(atsru, &dmar_atsr_units, list) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 atsr =3D container_of(atsru->hdr, struc=
t acpi_dmar_atsr, header);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (atsr->segment =3D=3D pci_domain_nr(=
dev->bus))
> + =A0 =A0 =A0 list_for_each_entry(atsru, &dmar_atsr_units, list)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (atsru->segment =3D=3D pci_domain_nr=
(dev->bus))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto found;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return 0;
>
> @@ -3574,20 +3725,36 @@ static int device_notifier(struct notifier_bl=
ock *nb,
> =A0 =A0 =A0 =A0struct pci_dev *pdev =3D to_pci_dev(dev);
> =A0 =A0 =A0 =A0struct dmar_domain *domain;
>
> - =A0 =A0 =A0 if (iommu_no_mapping(dev))
> + =A0 =A0 =A0 if (unlikely(dev->bus !=3D &pci_bus_type))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> - =A0 =A0 =A0 domain =3D find_domain(pdev);
> - =A0 =A0 =A0 if (!domain)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 switch (action) {
> + =A0 =A0 =A0 case BUS_NOTIFY_UNBOUND_DRIVER:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iommu_no_mapping(dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iommu_pass_through)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 domain =3D find_domain(pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!domain)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> - =A0 =A0 =A0 if (action =3D=3D BUS_NOTIFY_UNBOUND_DRIVER && !iommu_p=
ass_through) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0domain_remove_one_dev_info(domain, pde=
v);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(domain->flags & DOMAIN_FLAG_VIRT=
UAL_MACHINE) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!(domain->flags & DOMAIN_FLAG_=
STATIC_IDENTITY) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_empty(&domain->devices))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0domain_exit(domain);
> +out:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_dev_from_drhd(pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_dev_from_atsr(pdev);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case BUS_NOTIFY_ADD_DEVICE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 restore_dev_to_drhd(pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 restore_dev_to_atsr(pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 731a609..57e1375 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -236,9 +236,13 @@ struct dmar_atsr_unit {
> =A0 =A0 =A0 =A0struct acpi_dmar_header *hdr; =A0 /* ACPI header */
> =A0 =A0 =A0 =A0struct pci_dev **devices; =A0 =A0 =A0 /* target device=
s */
> =A0 =A0 =A0 =A0int devices_cnt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* tar=
get device count */
> + =A0 =A0 =A0 u16 segment; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
PCI domain */
> =A0 =A0 =A0 =A0u8 include_all:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* inclu=
de all ports */
> =A0};
>
> +#define for_each_atsr_unit(atsr) \
> + =A0 =A0 =A0 list_for_each_entry(atsr, &dmar_atsr_units, list)
> +
> =A0int dmar_parse_rmrr_atsr_dev(void);
> =A0extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header);
> =A0extern int dmar_parse_one_atsr(struct acpi_dmar_header *header);
> --
> 1.7.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
