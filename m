From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu: add api to get iommu_domain of a device
Date: Fri, 04 Oct 2013 11:12:52 -0600
Message-ID: <1380906772.25705.19.camel@ul30vt.home>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1379575763-2091-3-git-send-email-Bharat.Bhushan@freescale.com>
	<1380127533.3030.319.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0718FD1C@039-SN2MPN1-011.039d.mgd.msft.net>
	<1380901507.2673.204.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D07190F35@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07190F35-RL0Hj/+nBVCMXPU/2EZmt64g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2013-10-04 at 16:47 +0000, Bhushan Bharat-R65777 wrote:
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > Sent: Friday, October 04, 2013 9:15 PM
> > To: Bhushan Bharat-R65777
> > Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> > pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Wood Scott-B07421; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> > foundation.org
> > Subject: Re: [PATCH 2/7] iommu: add api to get iommu_domain of a device
> > 
> > On Fri, 2013-10-04 at 09:54 +0000, Bhushan Bharat-R65777 wrote:
> > >
> > > > -----Original Message-----
> > > > From: linux-pci-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > [mailto:linux-pci-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org]
> > > > On Behalf Of Alex Williamson
> > > > Sent: Wednesday, September 25, 2013 10:16 PM
> > > > To: Bhushan Bharat-R65777
> > > > Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org;
> > > > galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; linux- kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > > linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux- pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > > agraf-l3A5Bk7waGM@public.gmane.org; Wood Scott-B07421; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org foundation.org;
> > > > Bhushan Bharat-R65777
> > > > Subject: Re: [PATCH 2/7] iommu: add api to get iommu_domain of a
> > > > device
> > > >
> > > > On Thu, 2013-09-19 at 12:59 +0530, Bharat Bhushan wrote:
> > > > > This api return the iommu domain to which the device is attached.
> > > > > The iommu_domain is required for making API calls related to iommu.
> > > > > Follow up patches which use this API to know iommu maping.
> > > > >
> > > > > Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > > > ---
> > > > >  drivers/iommu/iommu.c |   10 ++++++++++
> > > > >  include/linux/iommu.h |    7 +++++++
> > > > >  2 files changed, 17 insertions(+), 0 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> > > > > fbe9ca7..6ac5f50 100644
> > > > > --- a/drivers/iommu/iommu.c
> > > > > +++ b/drivers/iommu/iommu.c
> > > > > @@ -696,6 +696,16 @@ void iommu_detach_device(struct iommu_domain
> > > > > *domain, struct device *dev)  }
> > > > > EXPORT_SYMBOL_GPL(iommu_detach_device);
> > > > >
> > > > > +struct iommu_domain *iommu_get_dev_domain(struct device *dev) {
> > > > > +	struct iommu_ops *ops = dev->bus->iommu_ops;
> > > > > +
> > > > > +	if (unlikely(ops == NULL || ops->get_dev_iommu_domain == NULL))
> > > > > +		return NULL;
> > > > > +
> > > > > +	return ops->get_dev_iommu_domain(dev); }
> > > > > +EXPORT_SYMBOL_GPL(iommu_get_dev_domain);
> > > >
> > > > What prevents this from racing iommu_domain_free()?  There's no
> > > > references acquired, so there's no reason for the caller to assume the
> > pointer is valid.
> > >
> > > Sorry for late query, somehow this email went into a folder and
> > > escaped;
> > >
> > > Just to be sure, there is not lock at generic "struct iommu_domain", but IP
> > specific structure (link FSL domain) linked in iommu_domain->priv have a lock,
> > so we need to ensure this race in FSL iommu code (say
> > drivers/iommu/fsl_pamu_domain.c), right?
> > 
> > No, it's not sufficient to make sure that your use of the interface is race
> > free.  The interface itself needs to be designed so that it's difficult to use
> > incorrectly.
> 
> So we can define iommu_get_dev_domain()/iommu_put_dev_domain();
> iommu_get_dev_domain() will return domain with the lock held, and
> iommu_put_dev_domain() will release the lock? And
> iommu_get_dev_domain() must always be followed by
> iommu_get_dev_domain().

What lock?  get/put are generally used for reference counting, not
locking in the kernel.

> > That's not the case here.  This is a backdoor to get the iommu
> > domain from the iommu driver regardless of who is using it or how.  The iommu
> > domain is created and managed by vfio, so shouldn't we be looking at how to do
> > this through vfio?
> 
> Let me first describe what we are doing here:
> During initialization:-
>  - vfio talks to MSI system to know the MSI-page and size
>  - vfio then interacts with iommu to map the MSI-page in iommu (IOVA is decided by userspace and physical address is the MSI-page)
>  - So the IOVA subwindow mapping is created in iommu and yes VFIO know about this mapping.
> 
> Now do SET_IRQ(MSI/MSIX) ioctl:
>  - calls pci_enable_msix()/pci_enable_msi_block(): which is supposed to set MSI address/data in device.
>  - So in current implementation (this patchset) msi-subsystem gets the IOVA from iommu via this defined interface.
>  - Are you saying that rather than getting this from iommu, we should get this from vfio? What difference does this make?

Yes, you just said above that vfio knows the msi to iova mapping, so why
go outside of vfio to find it later?  The difference is one case you can
have a proper reference to data structures to make sure the pointer you
get back actually has meaning at the time you're using it vs the code
here where you're defining an API that returns a meaningless value
because you can't check or enforce that an arbitrary caller is using it
correctly.  It's not maintainable.  Thanks,

Alex

> > It seems like you'd want to use your device to get a vfio
> > group reference, from which you could do something with the vfio external user
> > interface and get the iommu domain reference.  Thanks,
> > 
> > Alex
> > 
> > > > >  /*
> > > > >   * IOMMU groups are really the natrual working unit of the IOMMU, but
> > > > >   * the IOMMU API works on domains and devices.  Bridge that gap
> > > > > by diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > > > index 7ea319e..fa046bd 100644
> > > > > --- a/include/linux/iommu.h
> > > > > +++ b/include/linux/iommu.h
> > > > > @@ -127,6 +127,7 @@ struct iommu_ops {
> > > > >  	int (*domain_set_windows)(struct iommu_domain *domain, u32
> > w_count);
> > > > >  	/* Get the numer of window per domain */
> > > > >  	u32 (*domain_get_windows)(struct iommu_domain *domain);
> > > > > +	struct iommu_domain *(*get_dev_iommu_domain)(struct device
> > > > > +*dev);
> > > > >
> > > > >  	unsigned long pgsize_bitmap;
> > > > >  };
> > > > > @@ -190,6 +191,7 @@ extern int iommu_domain_window_enable(struct
> > > > > iommu_domain
> > > > *domain, u32 wnd_nr,
> > > > >  				      phys_addr_t offset, u64 size,
> > > > >  				      int prot);
> > > > >  extern void iommu_domain_window_disable(struct iommu_domain
> > > > > *domain,
> > > > > u32 wnd_nr);
> > > > > +extern struct iommu_domain *iommu_get_dev_domain(struct device
> > > > > +*dev);
> > > > >  /**
> > > > >   * report_iommu_fault() - report about an IOMMU fault to the IOMMU
> > framework
> > > > >   * @domain: the iommu domain where the fault has happened @@
> > > > > -284,6
> > > > > +286,11 @@ static inline void iommu_domain_window_disable(struct
> > > > > iommu_domain *domain,  {  }
> > > > >
> > > > > +static inline struct iommu_domain *iommu_get_dev_domain(struct
> > > > > +device
> > > > > +*dev) {
> > > > > +	return NULL;
> > > > > +}
> > > > > +
> > > > >  static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain
> > > > > *domain, dma_addr_t iova)  {
> > > > >  	return 0;
> > > >
> > > >
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > > > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
> > > > info at http://vger.kernel.org/majordomo-info.html
> > >
> > 
> > 
> > 
> 
