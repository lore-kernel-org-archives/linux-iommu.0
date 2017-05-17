From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 3/8] iommu: Introduce iommu do invalidate API function
Date: Wed, 17 May 2017 18:23:07 +0800
Message-ID: <20170517102307.GD22110@gmail.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-4-git-send-email-yi.l.liu@intel.com>
	<20170512155924.755ee17f@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170512155924.755ee17f-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 12, 2017 at 03:59:24PM -0600, Alex Williamson wrote:
> On Wed, 26 Apr 2017 18:12:00 +0800
> "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 

Hi Alex,

Pls refer to the open I mentioned in this email, I need your comments
on it to prepare the formal patchset for SVM virtualization. Thx.

> > From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > When a SVM capable device is assigned to a guest, the first level page
> > tables are owned by the guest and the guest PASID table pointer is
> > linked to the device context entry of the physical IOMMU.
> > 
> > Host IOMMU driver has no knowledge of caching structure updates unless
> > the guest invalidation activities are passed down to the host. The
> > primary usage is derived from emulated IOMMU in the guest, where QEMU
> > can trap invalidation activities before pass them down the
> > host/physical IOMMU. There are IOMMU architectural specific actions
> > need to be taken which requires the generic APIs introduced in this
> > patch to have opaque data in the tlb_invalidate_info argument.
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/iommu/iommu.c | 13 +++++++++++++
> >  include/linux/iommu.h | 16 ++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index f2da636..ca7cff2 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1153,6 +1153,19 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
> >  
> > +int iommu_do_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info *inv_info)
> > +{
> > +	int ret = 0;
> > +
> > +	if (unlikely(domain->ops->do_invalidate == NULL))
> > +		return -ENODEV;
> > +
> > +	ret = domain->ops->do_invalidate(domain, dev, inv_info);
> > +	return ret;
> 
> nit, ret is unnecessary.

yes, would modify it. Thx.
 
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_do_invalidate);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 491a011..a48e3b75 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -140,6 +140,11 @@ struct pasid_table_info {
> >  	__u8	opaque[];/* IOMMU-specific details */
> >  };
> >  
> > +struct tlb_invalidate_info {
> > +	__u32	model;
> > +	__u8	opaque[];
> > +};
> 
> I'm wondering if 'model' is really necessary here, shouldn't this
> function only be called if a bind_pasid_table() succeeded, and then the
> model would be set at that time?

For this model, I'm thinking about another potential usage which
is from Tianyu's idea to use tlb_invalidate_info to pass invalidations
for iova related mappings. In such case, there would be no bind_pasid_table()
before it, so a model check would be needed. But I may remove it since this
patchset is focusing on SVM.

Here, I have an open to check with you. I defined the tlb_invalidate_info
with full opaque data. The opaque would include the invalidate info for
different vendors. But we have two choices for the tlb_invalidate_info
definition.

a) as proposed in this patchset, passing raw data to host. Host pIOMMU
   driver submits invalidation request after replacing specific fields.
   Reject if the IOMMU model is not correct.
   * Pros: no need to do parse and re-assembling, better performance
   * Cons: unable to support the scenarios which emulates an Intel IOMMU
           on an ARM platform.
b) parse the invalidation info into specific data, e.g. gran, addr,
   size, invalidation type etc. then fill the data in a generic
   structure. In host, pIOMMU driver re-assemble the invalidation
   request and submit to pIOMMU.
   * Pros: may be able to support the scenario above. But it is still in
           question since different vendor may have vendor specific
           invalidation info. This would make it difficult to have vendor
           agnostic invalidation propagation API.

   * Cons: needs additional complexity to do parse and re-assembling.
           The generic structure would be a hyper-set of all possible
           invalidate info, this may be hard to maintain in future.

As the pros/cons show, I proposed a) as an initial version. But it is an
open. Jean from ARM has gave some comments on it and inclined to the opaque
way with generic part defined explicitly. Jean's reply is in the link below.

http://www.spinics.net/lists/kvm/msg149884.html

I'd like to see your comments on it before moving forward. I'm fine with
Jean's idea. For VT-d, I may define it as "generic part" + "raw data".

Thanks,
Yi L

> This also needs to be uapi since you're expecting a user to provide it
> to vfio.  The opaque data needs to be fully specified (relative to
> uapi) per model.
> 

would do it as you pointed.
 
> > +
> >  #ifdef CONFIG_IOMMU_API
> >  
> >  /**
> > @@ -215,6 +220,8 @@ struct iommu_ops {
> >  				struct pasid_table_info *pasidt_binfo);
> >  	int (*unbind_pasid_table)(struct iommu_domain *domain,
> >  				struct device *dev);
> > +	int (*do_invalidate)(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info *inv_info);
> >  
> >  	unsigned long pgsize_bitmap;
> >  };
> > @@ -240,6 +247,9 @@ extern int iommu_bind_pasid_table(struct iommu_domain *domain,
> >  		struct device *dev, struct pasid_table_info *pasidt_binfo);
> >  extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
> >  				struct device *dev);
> > +extern int iommu_do_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info *inv_info);
> > +
> >  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> >  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> >  		     phys_addr_t paddr, size_t size, int prot);
> > @@ -626,6 +636,12 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> >  	return -EINVAL;
> >  }
> >  
> > +static inline int iommu_do_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info *inv_info)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> >  #endif /* CONFIG_IOMMU_API */
> >  
> >  #endif /* __LINUX_IOMMU_H */
> 
