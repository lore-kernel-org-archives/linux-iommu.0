From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
Date: Thu, 23 Mar 2017 08:39:09 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439021F4D@shsmsx102.ccr.corp.intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-30-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C2574390206F0@shsmsx102.ccr.corp.intel.com>
 <d12a4a91-1fae-2fee-6109-3e9a1b7f5abe@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <d12a4a91-1fae-2fee-6109-3e9a1b7f5abe@arm.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Harv Abdulhamid <harba@qti.qualcomm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nate Watterson <nwatters@qti.qualcomm.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, Joerg Roedel <joro@8by>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

Thx for the excellent ideas. Pls refer to comments inline.

[...]

> > Hi Jean,
> >
> > I'm working on virtual SVM, and have some comments on the VFIO channel
> > definition.
>=20
> Thanks a lot for the comments, this is quite interesting to me. I just ha=
ve some
> concerns about portability so I'm proposing a way to be slightly more gen=
eric below.
>=20

yes, portability is what need to consider.

[...]

> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index
> >> 519eff362c1c..3fe4197a5ea0 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -198,6 +198,7 @@ struct vfio_device_info {
> >>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
> >>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device *=
/
> >>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
> >> +#define VFIO_DEVICE_FLAGS_SVM	(1 << 4)	/* Device supports bind/unbind=
 */
> >>  	__u32	num_regions;	/* Max region index + 1 */
> >>  	__u32	num_irqs;	/* Max IRQ index + 1 */
> >>  };
> >> @@ -409,6 +410,60 @@ struct vfio_irq_set {
> >>   */
> >>  #define VFIO_DEVICE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 11)
> >>
> >> +struct vfio_device_svm {
> >> +	__u32	argsz;
> >> +	__u32	flags;
> >> +#define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
> >> +#define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
> >> +	__u32	pasid;
> >> +};
> >
> > For virtual SVM work, the VFIO channel would be used to passdown guest
> > PASID tale PTR and invalidation information. And may have further
> > usage except the above.
> >
> > Here is the virtual SVM design doc which illustrates the VFIO usage.
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> >
> > For the guest PASID table ptr passdown, I've following message in pseud=
o code.
> > struct pasid_table_info {
> >         __u64 ptr;
> >         __u32 size;
> >  };
>=20
> There should probably be a way to specify the table format, so that the p=
IOMMU
> driver can check that it recognizes the format used by the vIOMMU before =
attaching
> it. This would allow to reuse the structure for other IOMMU architectures=
. If, for
> instance, the host has an intel IOMMU and someone decides to emulate an A=
RM
> SMMU with Qemu (their loss :), it can certainly use VFIO for passing-thro=
ugh devices
> with MAP/UNMAP. But if Qemu then attempts to passdown a PASID table in SM=
MU
> format, the Intel driver should have a way to reject it, as the SMMU form=
at isn't
> compatible.

Exactly, it would be grt if we can have the API defined as generic as MAP/U=
NMAP. The
case you mentioned to emulate an ARM SMMU on an Intel platform is represent=
ative.
For such cases, the problem is different vendors may have different PASID t=
able format
and also different page table format. In my understanding, these incompatib=
le things
may just result in failure if users try such emulation. What's your opinion=
 here?
Anyhow, better to listen to different voices.

>=20
> I'm tackling a similar problem at the moment, but for passing a single pa=
ge directory
> instead of full PASID table to the IOMMU.

For, Intel IOMMU, passing the whole guest PASID table is enough and it also=
 avoids=20
too much pgd passing. However, I'm open on this idea. You may just add a ne=
w flag
in "struct vfio_device_svm" and pass the single pgd down to host.

>=20
> So we need some kind of high-level classification that the vIOMMU must
> communicate to the physical one. Each IOMMU flavor would get a unique, gl=
obal
> identifier, simply to make sure that vIOMMU and pIOMMU speak the same lan=
guage.
> For example:
>=20
> 0x65776886 "AMDV" AMD IOMMU
> 0x73788476 "INTL" Intel IOMMU
> 0x83515748 "S390" s390 IOMMU
> 0x83777785 "SMMU" ARM SMMU
> etc.
>=20
> It needs to be a global magic number that everyone can recognize. Could b=
e as
> simple as 32-bit numbers allocated from 0. Once we have a global magic nu=
mber, we
> can use it to differentiate architecture-specific details.

I may need to think more on this part.
=20
> struct pasid_table_info {
> 	__u64 ptr;
> 	__u64 size;		/* Is it number of entry or size in
> 				   bytes? */

For Intel platform, it's encoded. But I can make it in bytes. Here, I'd lik=
e
to check with you if whole guest PASID info is also needed on ARM?

>=20
> 	__u32 model;		/* magic number */
> 	__u32 variant;		/* version of the IOMMU architecture,
> 				   maybe? IOMMU-specific. */
> 	__u8 opaque[];		/* IOMMU-specific details */
> };
>=20
> And then each IOMMU or page-table code can do low-level validation of the=
 format,
> by reading the details in 'opaque'. I assume that for Intel this would be=
 empty. But

yes, for Intel, if the PASID ptr is in the definition, opaque would be empt=
y.

> for instance on ARM SMMUv3, PASID table can have either one or two levels=
, and
> vIOMMU would specify which one of the three available formats it is using=
.

Yes it is. PASID table could also be multi-level. I agree to have it into c=
onsideration.


> struct pasid_table_info_smmu {
> 	/*
> 	 * In 'opaque', architecture details only the IOMMU driver should
> 	 * be caring about.
> 	 */
> 	__u8 s1fmt;
> 	__u8 s1dss;
> }
>=20
> If the physical SMMU doesn't implement the particular PASID table format,=
 it should
> reject the bind.

So far, I think reject may be the best policy. I can't assume that differen=
t have consistent
format for the PASID table and page table as previous comments.

>=20
> This would allow to keep architecture details outside of VFIO core (as we=
ll as virtio in
> my case), and only have vIOMMU and pIOMMU understand those details.
>=20
> >
> > For invalidation, I've following info in in pseudo code.
> > struct iommu_svm_tlb_invalidate_info
> > {
> >        __u32 inv_type;
> > #define IOTLB_INV			(1 << 0)
> > #define EXTENDED_IOTLB_INV		(1 << 1)
> > #define DEVICE_IOTLB_INV		(1 << 2)
> > #define EXTENDED_DEVICE_IOTLB_INV	(1 << 3)
> > #define PASID_CACHE_INV		(1 << 4)
> >        __u32 pasid;
> >        __u64 addr;
> >        __u64 size;
> >        __u8 granularity;
> > #define DEFAULT_INV_GRN        0
> > #define PAGE_SELECTIVE_INV     (1 << 0)
> > #define PASID_SELECVIVE_INV    (1 << 1)
> >        __u64 flags;
> > #define INVALIDATE_HINT_BIT    (1 << 0)
> > #define GLOBAL_HINT_BIT        (1 << 1)
> > #define DRAIN_READ_BIT         (1 << 2)
> > #define DRAIN_WRITE_BIT        (1 << 3)
> > #define DEVICE_TLB_GLOBAL_BIT  (1 << 4)
> >        __u8 mip;
> >        __u16 pfsid;
> > };
>=20
> This would also benefit from being split into generic and architectural p=
arts. Former
> would be defined in VFIO, latter would be in the IOMMU driver.

For invalidation part, I'm trying to have a generic definition by including=
 all possible information
for a TLB invalidation. Anyhow, I would  split the information when I send =
out my RFC patch
for virtual SVM.

>=20
> struct tlb_invalidate_info
> {
> 	__u8 granularity
> #define DEFAULT_INV_GRN		0	/* What is default? */

It's device selective. Since all invalidation from guest should be at least=
 device-selective, so I
name it as default. Would rename it to make it clear.

> #define PAGE_SELECTIVE_INV	(1 << 0)
> #define PASID_SELECTIVE_INV	(1 << 1)
> 	__u32 pasid;
> 	__u64 addr;
> 	__u64 size;
>=20
> 	/* Since IOMMU format has already been validated for this table,
> 	   the IOMMU driver knows that the following structure is in a
> 	   format it knows */
> 	__u8 opaque[];
> };
>=20
> struct tlb_invalidate_info_intel
> {
> 	__u32 inv_type;
> 	...
> 	__u64 flags;
> 	...
> 	__u8 mip;
> 	__u16 pfsid;
> };
>=20
> > Although your proposal is for userspace driver SVM usage while mine is
> > for  SVM usage in virtual machine, there should be a chance to make
> > the channel meet our request. And I think it would be more acceptable.
> > So I'd like to see your comments if we define the channel as following =
definition.
> > If any better solution, pls feel free let me know.
> >
> > struct vfio_device_svm {
> >        __u32   argsz;
> > #define VFIO_SVM_BIND_PASIDTP           (1 << 0)
>=20
> To check we're on the same page: the absence of BIND_PASIDTP flag would m=
ean
> "bind a single PASID" and in that case, data[] would be a "u32 pasid"?

Actually, I planned to use a single channel for both guest PASID table ptr =
passdown
and invalidation info passdown. So it is defined in this way.

VFIO_SVM_BIND_PASIDTP   -> data[] includes guest PASID table ptr and table =
size
VFIO_SVM_PASSDOWN_INVALIDATE    -> data[] includes infos for invalidataion

Now, we want to have it shared by different vendors. So I would remove inva=
lidate
definition from it. Regards to your example, yes it would be a "u32 pasid" =
if you are
passing a PASID value from guest. I think we are on the same page for the u=
sage?=20

>=20
> > #define VFIO_SVM_PASSDOWN_INVALIDATE    (1 << 1)
>=20
> Using the vfio_device_svm structure for invalidate operations is a bit od=
d, it might be
> nicer to add a new VFIO_SVM_INVALIDATE ioctl, that takes the above
> iommu_svm_tlb_invalidate_info as argument (with an added argsz.)

Agree, would add a separate IOCTL for invalidation.

>=20
> > #define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 2)
> > #define VFIO_SVM_PASID_RELEASE_CLEAN	  (1 << 3)
> >        __u32   flags;
> >        __u32   length;
>=20
> If length is the size of data[], I guess we can already deduce this info =
from argsz.

yes, it is size of data. Maybe remove argsz. How about your opinion?
=20
> >        __u8    data[];
> > };
>=20
> In general, I think that your proposal would work fine along mine. Note t=
hat for my
> next version of this patch, I would like to move the BIND/UNBIND SVM oper=
ations
> onto a VFIO container fd, instead of a VFIO device fd, if possible.

Attach the BIND/UNBIND operation onto VFIO container fd is practical.

BTW. Before you send out your next version, we'd better have a consensus on=
 the
vfio_device_svm definition. So that we can continue to drive our own work s=
eparately.

> ---
> As an aside, it also aligns with the one I'm working on at the moment, fo=
r virtual
> SVM at a finer granularity, where the BIND call is for a page table. I wo=
uld add this
> flag to vfio_device_svm:
>=20
> #define VFIO_SVM_BIND_PGTABLE		(1 << x)

Sure. I think it may also be a requirement from other vendors. I think you'=
ve mentioned
it in the above statements.

> Which would indicate the following data (just a draft, I'm oscillating be=
tween this
> and a generic PASID table solution, which would instead reuse your propos=
al):
>=20
> struct pgtable_info {
> 	__u32 pasid;
>=20
> 	__u64 pgd;
>=20
> 	__u32 model;
> 	__u32 variant;
>=20
> 	__u8 opaque[];
> };
>=20
> On ARM SMMU we would need to specify an io-pgtable variant and the opaque
> structure would be bits of io_pgtable_cfg (tcr, mair, etc.)
>=20
> The problem of portability is slightly different here, because while PASI=
D table
> format is specific to an IOMMU, page table format might be the same acros=
s
> multiple flavors of IOMMUs. For instance, the PASID table format I use in=
 this series
> can only be found in the ARM SMMUv3 architecture, but the page table form=
at is the
> same as ARM SMMUv2, and other MMUs. I'd like to implement an IOMMU
> independent of any page-table formats, that could use whatever the host o=
ffers (not
> necessarily MMU PT). The model numbers described above wouldn't be suitab=
le, so
> we'd need another set of magic numbers for page table formats.

Not sure if I totally got your points. We may assume PASID table format dif=
fers from
vendor to vendor. For the page table format, I assume you mean the page tab=
le of
process. Or in other words MMU page table.

I'm a little bit confused about the following statements. Could you speak a=
 little bit more?
Is it for virtual SVM or user-space driver SVM usage?
" I'd like to implement an IOMMU independent of any page-table formats, tha=
t could
use whatever the host offers (not necessarily MMU PT)."

I's nice to have such discussion. Let's co-work and have a well-defined API=
.

Thanks,
Yi L
