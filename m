From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
Date: Tue, 21 Mar 2017 07:04:09 +0000
Message-ID: <A2975661238FB949B60364EF0F2C2574390206F0@shsmsx102.ccr.corp.intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-30-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170227195441.5170-30-jean-philippe.brucker@arm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Harv Abdulhamid <harba@qti.qualcomm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nate Watterson <nwatters@qti.qualcomm.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

I'm working on virtual SVM, and have some comments on the VFIO channel
definition.

> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Jean-Philippe Brucker
> Sent: Tuesday, February 28, 2017 3:55 AM
> Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>; kvm@vger.kernel.org;
> Catalin Marinas <catalin.marinas@arm.com>; Sinan Kaya
> <okaya@qti.qualcomm.com>; Will Deacon <will.deacon@arm.com>;
> iommu@lists.linux-foundation.org; Harv Abdulhamid <harba@qti.qualcomm.com=
>;
> linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; David
> Woodhouse <dwmw2@infradead.org>; linux-arm-kernel@lists.infradead.org; Na=
te
> Watterson <nwatters@qti.qualcomm.com>
> Subject: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
>=20
> Add two new ioctl for VFIO devices. VFIO_DEVICE_BIND_TASK creates a bond
> between a device and a process address space, identified by a device-spec=
ific ID
> named PASID. This allows the device to target DMA transactions at the pro=
cess
> virtual addresses without a need for mapping and unmapping buffers explic=
itly in the
> IOMMU. The process page tables are shared with the IOMMU, and mechanisms =
such
> as PCI ATS/PRI may be used to handle faults. VFIO_DEVICE_UNBIND_TASK remo=
ved
> a bond identified by a PASID.
>=20
> Also add a capability flag in device info to detect whether the system an=
d the device
> support SVM.
>=20
> Users need to specify the state of a PASID when unbinding, with flags
> VFIO_PASID_RELEASE_FLUSHED and VFIO_PASID_RELEASE_CLEAN. Even for PCI,
> PASID invalidation is specific to each device and only partially covered =
by the
> specification:
>=20
> * Device must have an implementation-defined mechanism for stopping the
>   use of a PASID. When this mechanism finishes, the device has stopped
>   issuing transactions for this PASID and all transactions for this PASID
>   have been flushed to the IOMMU.
>=20
> * Device may either wait for all outstanding PRI requests for this PASID
>   to finish, or issue a Stop Marker message, a barrier that separates PRI
>   requests affecting this instance of the PASID from PRI requests
>   affecting the next instance. In the first case, we say that the PASID i=
s
>   "clean", in the second case it is "flushed" (and the IOMMU has to wait
>   for the Stop Marker before reassigning the PASID.)
>=20
> We expect similar distinctions for platform devices. Ideally there should=
 be a callback
> for each PCI device, allowing the IOMMU to ask the device to stop using a=
 PASID.
> When the callback returns, the PASID is either flushed or clean and the r=
eturn value
> tells which.
>=20
> For the moment I don't know how to implement this callback for PCI, so if=
 the user
> forgets to call unbind with either "clean" or "flushed", the PASID is nev=
er reused. For
> platform devices, it might be simpler to implement since we could associa=
te an
> invalidate_pasid callback to a DT compatible string, as is currently done=
 for reset.
>=20
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[...]

>  drivers/vfio/pci/vfio_pci.c |  24 ++++++++++
>  drivers/vfio/vfio.c         | 104 ++++++++++++++++++++++++++++++++++++++=
++++++
>  include/uapi/linux/vfio.h   |  55 +++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
>=20
...
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h index
> 519eff362c1c..3fe4197a5ea0 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -198,6 +198,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
> +#define VFIO_DEVICE_FLAGS_SVM	(1 << 4)	/* Device supports bind/unbind */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
> @@ -409,6 +410,60 @@ struct vfio_irq_set {
>   */
>  #define VFIO_DEVICE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 11)
>=20
> +struct vfio_device_svm {
> +	__u32	argsz;
> +	__u32	flags;
> +#define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
> +#define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
> +	__u32	pasid;
> +};

For virtual SVM work, the VFIO channel would be used to passdown guest
PASID tale PTR and invalidation information. And may have further usage
except the above.

Here is the virtual SVM design doc which illustrates the VFIO usage.
https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html

For the guest PASID table ptr passdown, I've following message in pseudo co=
de.
struct pasid_table_info {
        __u64 ptr;
        __u32 size;
 };

For invalidation, I've following info in in pseudo code.
struct iommu_svm_tlb_invalidate_info
{
       __u32 inv_type;
#define IOTLB_INV			(1 << 0)
#define EXTENDED_IOTLB_INV		(1 << 1)
#define DEVICE_IOTLB_INV		(1 << 2)
#define EXTENDED_DEVICE_IOTLB_INV	(1 << 3)
#define PASID_CACHE_INV		(1 << 4)
       __u32 pasid;
       __u64 addr;
       __u64 size;
       __u8 granularity;
#define DEFAULT_INV_GRN        0
#define PAGE_SELECTIVE_INV     (1 << 0)
#define PASID_SELECVIVE_INV    (1 << 1)
       __u64 flags;
#define INVALIDATE_HINT_BIT    (1 << 0)
#define GLOBAL_HINT_BIT        (1 << 1)
#define DRAIN_READ_BIT         (1 << 2)
#define DRAIN_WRITE_BIT        (1 << 3)
#define DEVICE_TLB_GLOBAL_BIT  (1 << 4)
       __u8 mip;
       __u16 pfsid;
};

Although your proposal is for userspace driver SVM usage while mine is
for  SVM usage in virtual machine, there should be a chance to make the
channel meet our request. And I think it would be more acceptable. So I'd
like to see your comments if we define the channel as following definition.
If any better solution, pls feel free let me know.

struct vfio_device_svm {
       __u32   argsz;
#define VFIO_SVM_BIND_PASIDTP           (1 << 0)
#define VFIO_SVM_PASSDOWN_INVALIDATE    (1 << 1)
#define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 2)
#define VFIO_SVM_PASID_RELEASE_CLEAN	  (1 << 3)
       __u32   flags;
       __u32   length;
       __u8    data[];
};

Thanks,
Yi L

> + * VFIO_DEVICE_BIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> + *                               struct vfio_device_svm)
> + *
> + * Share a process' virtual address space with the device.
> + *
> + * This feature creates a new address space for the device, which is
> +not
> + * affected by VFIO_IOMMU_MAP/UNMAP_DMA. Instead, the device can tag
> +its DMA
> + * traffic with the given @pasid to perform transactions on the
> +associated
> + * virtual address space. Mapping and unmapping of buffers is performed
> +by
> + * standard functions such as mmap and malloc.
> + *
> + * On success, VFIO writes a Process Address Space ID (PASID) into
> +@pasid. This
> + * ID is unique to a device.
> + *
> + * The bond between device and process must be removed with
> + * VFIO_DEVICE_UNBIND_TASK before exiting.
> + *
> + * On fork, the child inherits the device fd and can use the bonds
> +setup by its
> + * parent. Consequently, the child has R/W access on the address spaces
> +bound by
> + * its parent. After an execv, the device fd is closed and the child
> +doesn't
> + * have access to the address space anymore.
> + *
> + * Availability of this feature depends on the device, its bus, the
> +underlying
> + * IOMMU and the CPU architecture. All of these are guaranteed when the
> +device
> + * has VFIO_DEVICE_FLAGS_SVM flag set.
> + *
> + * returns: 0 on success, -errno on failure.
> + */
> +#define VFIO_DEVICE_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
> +/*
> + * VFIO_DEVICE_UNBIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 23,
> + *                                 struct vfio_device_svm)
> + *
> + * Unbind address space identified by @pasid from device. Device must
> +have
> + * stopped issuing any DMA transaction for the PASID and flushed any
> +reference
> + * to this PASID upstream. Some IOMMUs need to know when a PASID is
> +safe to
> + * reuse, in which case one of the following must be present in @flags
> + *
> + * VFIO_PASID_RELEASE_FLUSHED: the PASID is safe to reassign after the I=
OMMU
> + *       receives an invalidation message from the device.
> + *
> + * VFIO_PASID_RELEASE_CLEAN: the PASID is safe to reassign immediately.
> + */
> +#define VFIO_DEVICE_UNBIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 23)
> +
>  /*
>   * The VFIO-PCI bus driver makes use of the following fixed region and
>   * IRQ index mapping.  Unimplemented regions return a size of zero.
> --
> 2.11.0
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
