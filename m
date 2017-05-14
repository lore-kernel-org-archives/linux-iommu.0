From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 1/8] iommu: Introduce bind_pasid_table API function
Date: Sun, 14 May 2017 18:56:51 +0800
Message-ID: <20170514105651.GC22110@gmail.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-2-git-send-email-yi.l.liu@intel.com>
	<20170512155914.73bad777@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170512155914.73bad777-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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

On Fri, May 12, 2017 at 03:59:14PM -0600, Alex Williamson wrote:
> On Wed, 26 Apr 2017 18:11:58 +0800
> "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > Virtual IOMMU was proposed to support Shared Virtual Memory (SVM) use
> > case in the guest:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> > 
> > As part of the proposed architecture, when a SVM capable PCI
> > device is assigned to a guest, nested mode is turned on. Guest owns the
> > first level page tables (request with PASID) and performs GVA->GPA
> > translation. Second level page tables are owned by the host for GPA->HPA
> > translation for both request with and without PASID.
> > 
> > A new IOMMU driver interface is therefore needed to perform tasks as
> > follows:
> > * Enable nested translation and appropriate translation type
> > * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> > 
> > This patch introduces new functions called iommu_(un)bind_pasid_table()
> > to IOMMU APIs. Architecture specific IOMMU function can be added later
> > to perform the specific steps for binding pasid table of assigned devices.
> > 
> > This patch also adds model definition in iommu.h. It would be used to
> > check if the bind request is from a compatible entity. e.g. a bind
> > request from an intel_iommu emulator may not be supported by an ARM SMMU
> > driver.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/iommu/iommu.c | 19 +++++++++++++++++++
> >  include/linux/iommu.h | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index dbe7f65..f2da636 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1134,6 +1134,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> > +			struct pasid_table_info *pasidt_binfo)
> > +{
> > +	if (unlikely(!domain->ops->bind_pasid_table))
> > +		return -EINVAL;
> > +
> > +	return domain->ops->bind_pasid_table(domain, dev, pasidt_binfo);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_bind_pasid_table);
> > +
> > +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> > +{
> > +	if (unlikely(!domain->ops->unbind_pasid_table))
> > +		return -EINVAL;
> > +
> > +	return domain->ops->unbind_pasid_table(domain, dev);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 0ff5111..491a011 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -131,6 +131,15 @@ struct iommu_dm_region {
> >  	int			prot;
> >  };
> >  
> > +struct pasid_table_info {
> > +	__u64	ptr;	/* PASID table ptr */
> > +	__u64	size;	/* PASID table size*/
> > +	__u32	model;	/* magic number */
> > +#define INTEL_IOMMU	(1 << 0)
> > +#define ARM_SMMU	(1 << 1)
> > +	__u8	opaque[];/* IOMMU-specific details */
> > +};
> 
> This needs to be in uapi since you're expecting a user to pass it 

yes, it is. Thx for the correction.

Thanks,
Yi L
> > +
> >  #ifdef CONFIG_IOMMU_API
> >  
> >  /**
> > @@ -159,6 +168,8 @@ struct iommu_dm_region {
> >   * @domain_get_windows: Return the number of windows for a domain
> >   * @of_xlate: add OF master IDs to iommu grouping
> >   * @pgsize_bitmap: bitmap of all possible supported page sizes
> > + * @bind_pasid_table: bind pasid table pointer for guest SVM
> > + * @unbind_pasid_table: unbind pasid table pointer and restore defaults
> >   */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -200,6 +211,10 @@ struct iommu_ops {
> >  	u32 (*domain_get_windows)(struct iommu_domain *domain);
> >  
> >  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> > +	int (*bind_pasid_table)(struct iommu_domain *domain, struct device *dev,
> > +				struct pasid_table_info *pasidt_binfo);
> > +	int (*unbind_pasid_table)(struct iommu_domain *domain,
> > +				struct device *dev);
> >  
> >  	unsigned long pgsize_bitmap;
> >  };
> > @@ -221,6 +236,10 @@ extern int iommu_attach_device(struct iommu_domain *domain,
> >  			       struct device *dev);
> >  extern void iommu_detach_device(struct iommu_domain *domain,
> >  				struct device *dev);
> > +extern int iommu_bind_pasid_table(struct iommu_domain *domain,
> > +		struct device *dev, struct pasid_table_info *pasidt_binfo);
> > +extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
> > +				struct device *dev);
> >  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> >  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> >  		     phys_addr_t paddr, size_t size, int prot);
> > @@ -595,6 +614,18 @@ const struct iommu_ops *iommu_get_instance(struct fwnode_handle *fwnode)
> >  	return NULL;
> >  }
> >  
> > +static inline
> > +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> > +			struct pasid_table_info *pasidt_binfo)
> > +{
> > +	return -EINVAL;
> > +}
> > +static inline
> > +int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> >  #endif /* CONFIG_IOMMU_API */
> >  
> >  #endif /* __LINUX_IOMMU_H */
> 
