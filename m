From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 30/30] vfio: Allow to bind foreign task
Date: Tue, 28 Feb 2017 06:43:31 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C4CB9C@SHSMSX101.ccr.corp.intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
	<20170227195441.5170-31-jean-philippe.brucker@arm.com>
	<20170227205411.1abca59a@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227205411.1abca59a-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Alex Williamson
> Sent: Tuesday, February 28, 2017 11:54 AM
> 
> On Mon, 27 Feb 2017 19:54:41 +0000
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
[...]
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 3fe4197a5ea0..41ae8a231d42 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -415,7 +415,9 @@ struct vfio_device_svm {
> >  	__u32	flags;
> >  #define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
> >  #define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
> > +#define VFIO_SVM_PID			(1 << 2)
> >  	__u32	pasid;
> > +	__u32	pid;
> >  };
> >  /*
> >   * VFIO_DEVICE_BIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> > @@ -432,6 +434,19 @@ struct vfio_device_svm {
> >   * On success, VFIO writes a Process Address Space ID (PASID) into @pasid. This
> >   * ID is unique to a device.
> >   *
> > + * VFIO_SVM_PID: bind task @pid instead of current task. The shared address
> > + *        space identified by @pasid is that of task identified by @pid.
> > + *
> > + *        Given that the caller owns the device, setting this flag grants the
> > + *        caller read and write permissions on the entire address space of
> > + *        foreign task described by @pid. Therefore, permission to perform the
> > + *        bind operation on a foreign process is governed by the ptrace access
> > + *        mode PTRACE_MODE_ATTACH_REALCREDS check. See man ptrace(2) for
> more
> > + *        information.
> > + *
> > + *        If the VFIO_SVM_PID flag is not set, @pid is unused and it is the
> > + *        current task that is bound to the device.
> > + *
> >   * The bond between device and process must be removed with
> >   * VFIO_DEVICE_UNBIND_TASK before exiting.
> >   *
> 
> BTW, nice commit logs throughout this series, I probably need to read
> through them a few more times to really digest it all.  AIUI, the VFIO
> support here is really only useful for basic userspace drivers, I don't
> see how we could take advantage of it for a VM use case where the guest
> manages the PASID space for a domain.  Perhaps it hasn't spent enough
> cycles bouncing around in my head yet.  Thanks,
> 

Current definition doesn't work with virtualization usage, at least on Intel
VT-d. To enable virtualized SVM within a VM, architecturally VT-d needs
be in a nested mode - go through guest PASID table to find guest CR3, 
use guest CR3 as 1st level translation for GVA->GPA and then use 2nd 
level translation for GPA->HPA. PASID table is fully allocated/managed
by VM. Within the translation process each guest pointer (PASID or 1st 
level paging structures) is treated as GPA which also goes through 2nd 
level translation. I didn't read ARM SMMU spec yet, but hope the basic 
mechanism stays similar.

Here we need an API which allows Qemu vIOMMU to bind guest PASID
table pointer and enable nested mode for target device in underlying 
IOMMU hardware, while proposed API is only for user space driver 
regarding to binding a specific host address space.

Based on above requirement difference, Alex, do you prefer to 
introducing one API covering both usages or separate APIs for their
own purposes?

btw Yi is working on a SVM virtualization prototype based on Intel 
VT-d. I hope soon he will send out a RFC so we can align the high
level API requirement better. :-)

Thanks
Kevin
