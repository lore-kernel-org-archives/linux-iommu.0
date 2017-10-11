From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 10/16] iommu: introduce device fault report API
Date: Wed, 11 Oct 2017 10:21:22 -0700
Message-ID: <20171011102122.773a6c8c@jacob-builder>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1507244624-39189-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <20171010134054.5gjzvznhzddc2cn7@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010134054.5gjzvznhzddc2cn7@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 10 Oct 2017 15:40:54 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Thu, Oct 05, 2017 at 04:03:38PM -0700, Jacob Pan wrote:
> > Traditionally, device specific faults are detected and handled
> > within their own device drivers. When IOMMU is enabled, faults such
> > as DMA related transactions are detected by IOMMU. There is no
> > generic reporting mechanism to report faults back to the in-kernel
> > device driver or the guest OS in case of assigned devices.
> > 
> > Faults detected by IOMMU is based on the transaction's source ID
> > which can be reported at per device basis, regardless of the device
> > type is a PCI device or not.
> > 
> > The fault types include recoverable (e.g. page request) and
> > unrecoverable faults(e.g. access error). In most cases, faults can
> > be handled by IOMMU drivers internally. The primary use cases are as
> > follows:
> > 1. page request fault originated from an SVM capable device that is
> > assigned to guest via vIOMMU. In this case, the first level page
> > tables are owned by the guest. Page request must be propagated to
> > the guest to let guest OS fault in the pages then send page
> > response. In this mechanism, the direct receiver of IOMMU fault
> > notification is VFIO, which can relay notification events to QEMU
> > or other user space software.
> > 
> > 2. faults need more subtle handling by device drivers. Other than
> > simply invoke reset function, there are needs to let device driver
> > handle the fault with a smaller impact.
> > 
> > This patchset is intended to create a generic fault report API such
> > that it can scale as follows:
> > - all IOMMU types
> > - PCI and non-PCI devices
> > - recoverable and unrecoverable faults
> > - VFIO and other other in kernel users
> > - DMA & IRQ remapping (TBD)
> > The original idea was brought up by David Woodhouse and discussions
> > summarized at https://lwn.net/Articles/608914/.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > ---
> >  drivers/iommu/iommu.c | 56
> > ++++++++++++++++++++++++++++++++++++++++++++++++++-
> > include/linux/iommu.h | 23 +++++++++++++++++++++ 2 files changed,
> > 78 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 5a14154..0b058e2 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -554,9 +554,15 @@ int iommu_group_add_device(struct iommu_group
> > *group, struct device *dev) 
> >  	device->dev = dev;
> >  
> > +	dev->iommu_fault_param = kzalloc(sizeof(struct
> > iommu_fault_param), GFP_KERNEL);
> > +	if (!dev->iommu_fault_param) {
> > +		ret = -ENOMEM;
> > +		goto err_free_device;
> > +	}
> > +  
> 
> This looks like some left-over from a previous version, because
> allocation of that structure is done in
> iommu_register_device_fault_handler()
> 
you are right! I later changed it to do allocation at the
handler registration time.
