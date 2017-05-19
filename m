From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 09/20] Memory: introduce
 iommu_ops->record_device
Date: Fri, 19 May 2017 13:23:38 +0800
Message-ID: <20170519052338.GA10952@sky-dev>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
 <1493201210-14357-10-git-send-email-yi.l.liu@linux.intel.com>
 <5c64416d-7d8a-f1a6-64f9-cb0bf1d95a4a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c64416d-7d8a-f1a6-64f9-cb0bf1d95a4a@intel.com>
Sender: kvm-owner@vger.kernel.org
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org, jean-philippe.brucker@arm.com, jasowang@redhat.com, iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com, tianyu.lan@intel.com
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

What's your opinion with Tianyu's question? Is it accepatable
to use VFIO API in intel_iommu emulator?

Thanks,
Yi L
On Fri, Apr 28, 2017 at 02:46:16PM +0800, Lan Tianyu wrote:
> On 2017年04月26日 18:06, Liu, Yi L wrote:
> > With vIOMMU exposed to guest, vIOMMU emulator needs to do translation
> > between host and guest. e.g. a device-selective TLB flush, vIOMMU
> > emulator needs to replace guest SID with host SID so that to limit
> > the invalidation. This patch introduces a new callback
> > iommu_ops->record_device() to notify vIOMMU emulator to record necessary
> > information about the assigned device.
> 
> This patch is to prepare to translate guest sbdf to host sbdf.
> 
> Alex:
> 	Could we add a new vfio API to do such translation? This will be more
> straight forward than storing host sbdf in the vIOMMU device model.
> 
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  include/exec/memory.h | 11 +++++++++++
> >  memory.c              | 12 ++++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 7bd13ab..49087ef 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -203,6 +203,8 @@ struct MemoryRegionIOMMUOps {
> >                                  IOMMUNotifierFlag new_flags);
> >      /* Set this up to provide customized IOMMU replay function */
> >      void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
> > +    void (*record_device)(MemoryRegion *iommu,
> > +                          void *device_info);
> >  };
> >  
> >  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> > @@ -708,6 +710,15 @@ void memory_region_notify_iommu(MemoryRegion *mr,
> >  void memory_region_notify_one(IOMMUNotifier *notifier,
> >                                IOMMUTLBEntry *entry);
> >  
> > +/*
> > + * memory_region_notify_device_record: notify IOMMU to record assign
> > + * device.
> > + * @mr: the memory region to notify
> > + * @ device_info: device information
> > + */
> > +void memory_region_notify_device_record(MemoryRegion *mr,
> > +                                        void *info);
> > +
> >  /**
> >   * memory_region_register_iommu_notifier: register a notifier for changes to
> >   * IOMMU translation entries.
> > diff --git a/memory.c b/memory.c
> > index 0728e62..45ef069 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1600,6 +1600,18 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
> >      mr->iommu_notify_flags = flags;
> >  }
> >  
> > +void memory_region_notify_device_record(MemoryRegion *mr,
> > +                                        void *info)
> > +{
> > +    assert(memory_region_is_iommu(mr));
> > +
> > +    if (mr->iommu_ops->record_device) {
> > +        mr->iommu_ops->record_device(mr, info);
> > +    }
> > +
> > +    return;
> > +}
> > +
> >  void memory_region_register_iommu_notifier(MemoryRegion *mr,
> >                                             IOMMUNotifier *n)
> >  {
> > 
> 
> 
