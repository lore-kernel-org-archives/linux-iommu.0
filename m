From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v2 17/25] KVM: kvm-vfio: User API for VT-d Posted-Interrupts
Date: Mon, 8 Dec 2014 04:58:43 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0022E2DD7@SHSMSX104.ccr.corp.intel.com>
References: <1417592394-24343-1-git-send-email-feng.wu@intel.com>
	<1417592394-24343-18-git-send-email-feng.wu@intel.com>
	<548069F6.7020308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <548069F6.7020308-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: kvm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:kvm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On
> Behalf Of Eric Auger
> Sent: Thursday, December 04, 2014 10:05 PM
> To: Wu, Feng; tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org;
> x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v2 17/25] KVM: kvm-vfio: User API for VT-d Posted-Interrupts
> 
> Hi Feng,
> On 12/03/2014 08:39 AM, Feng Wu wrote:
> > This patch adds and documents a new attribute
> > KVM_DEV_VFIO_DEVICE_POSTING_IRQ in KVM_DEV_VFIO_DEVICE group.
> > This new attribute is used for VT-d Posted-Interrupts.
> >
> > When guest OS changes the interrupt configuration for an
> > assigned device, such as, MSI/MSIx data/address fields,
> > QEMU will use this IRQ attribute to tell KVM to update the
> > related IRTE according the VT-d Posted-Interrrupts Specification,
> > such as, the guest vector should be updated in the related IRTE.
> >
> > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  Documentation/virtual/kvm/devices/vfio.txt |    9 +++++++++
> >  include/uapi/linux/kvm.h                   |   10 ++++++++++
> >  2 files changed, 19 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/virtual/kvm/devices/vfio.txt
> b/Documentation/virtual/kvm/devices/vfio.txt
> > index f7aff29..41e12b7 100644
> > --- a/Documentation/virtual/kvm/devices/vfio.txt
> > +++ b/Documentation/virtual/kvm/devices/vfio.txt
> > @@ -42,3 +42,12 @@ activated before VFIO_DEVICE_SET_IRQS has been
> called to trigger the IRQ
> >  or associate an eventfd to it. Unforwarding can only be called while the
> >  signaling has been disabled with VFIO_DEVICE_SET_IRQS. If this condition
> is
> >  not satisfied, the command returns an -EBUSY.
> > +
> > +  KVM_DEV_VFIO_DEVICE_POSTING_IRQ: Use posted interrtups
> mechanism to post
> typo
> > +                                   the IRQ to guests.
> > +For this attribute, kvm_device_attr.addr points to a kvm_vfio_dev_irq
> struct.
> > +
> > +When guest OS changes the interrupt configuration for an assigned device,
> > +such as, MSI/MSIx data/address fields, QEMU will use this IRQ attribute
> > +to tell KVM to update the related IRTE according the VT-d
> Posted-Interrrupts
> > +Specification, such as, the guest vector should be updated in the related
> IRTE.
> For my curiosity are there any restrictions about the instant at which
> the change can be done?
> I do not get here how you deactivate the posting?

The current method is if the hardware supports interrupts posting, we will
use it instead of interrupts remapping, since it has good performance. Why
do I need deactivate interrupts posting?

Here is the reply to Alex for the same question:
"In fact, I don't think we need to stop the posted-interrupts. For setting
posted interrupts, we update the related IRTE according to the new
format. If the guest reboots, or unload the drivers, or some other
operations, the msi/msix will be disabled first, in this path, the irq
will be disabled the related IRTE is not used anymore."

> 
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index a269a42..7d98650 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -949,6 +949,7 @@ struct kvm_device_attr {
> >  #define  KVM_DEV_VFIO_DEVICE			2
> >  #define   KVM_DEV_VFIO_DEVICE_FORWARD_IRQ			1
> >  #define   KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ			2
> > +#define   KVM_DEV_VFIO_DEVICE_POSTING_IRQ			3
> Maybe we should align our naming verb vs verbing here?
> Best Regards
> Eric

No problem, I will align my patch in the next version. Thanks!

Thanks,
Feng

> >
> >  enum kvm_device_type {
> >  	KVM_DEV_TYPE_FSL_MPIC_20	= 1,
> > @@ -973,6 +974,15 @@ struct kvm_arch_forwarded_irq {
> >  	__u32 gsi; /* gsi, ie. virtual IRQ number */
> >  };
> >
> > +struct kvm_vfio_dev_irq {
> > +	__u32	argsz;
> > +	__u32	fd;		/* file descriptor of the VFIO device */
> > +	__u32	index;		/* VFIO device IRQ index */
> > +	__u32	start;
> > +	__u32	count;
> > +	__u32	gsi[];		/* gsi, ie. virtual IRQ number */
> > +};
> > +
> >  /*
> >   * ioctls for VM fds
> >   */
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
