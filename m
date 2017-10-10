From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 03/16] iommu: introduce iommu invalidate API function
Date: Tue, 10 Oct 2017 15:09:53 -0700
Message-ID: <20171010150953.4095a045@jacob-builder>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1507244624-39189-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20171010133542.juag7cwbivlb56sl@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010133542.juag7cwbivlb56sl@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, Liu@8bytes.org, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 10 Oct 2017 15:35:42 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Thu, Oct 05, 2017 at 04:03:31PM -0700, Jacob Pan wrote:
> > +int iommu_invalidate(struct iommu_domain *domain,
> > +		struct device *dev, struct tlb_invalidate_info
> > *inv_info)  
> 
> This name is way too generic, it should at least be called
> iommu_svm_invalidate() or something like that. With the name above it
> is easily confused with the other TLB invalidation functions of the
> IOMMU-API.
> 
Good point. I was calling it iommu_passdown_invalidate() originally.
The invalidation request comes from guest or user space instead of
in-kernel unmap kind of calls.
> > +enum iommu_inv_granularity {
> > +	IOMMU_INV_GRANU_GLOBAL,		/* all TLBs
> > invalidated */  
> 
> Is that needed? We certainly don't want to give userspace/guests that
> fine-grained control about IOMMU cache invalidations.
> 
> In the end a guest issues flush-global command does not translate to a
> flush-global on the host, but to separate flushes for the domains the
> guest uses.
> 
Right, guest should not go beyond its own domain.
> > +	IOMMU_INV_GRANU_DOMAIN,		/* all TLBs
> > associated with a domain */
> > +	IOMMU_INV_GRANU_DEVICE,		/* caching
> > structure associated with a
> > +					 * device ID  
> 
> What is the difference between a DOMAIN and a DEVICE flush?
> 
Those are based on vt-d context cache flush granularity, domain
selective flushes all context caches associated with a domain ID.
Device selective flush flushes context caches of a source ID.
But like you pointed out below, since context cache flush will come in
as unbind call, there is no need to do passdown invalidate. I can
remove that.

Here I am trying to use all generic definitions, which is a superset of
all vendor models. I am likely missing out some non-vt-d cases.

> > +	IOMMU_INV_GRANU_DOMAN_PAGE,	/* address range with a
> > domain */
> > +	IOMMU_INV_GRANU_ALL_PASID,	/* cache of a given
> > PASID */
> > +	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate
> > specified PASID */ +
> > +	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within
> > all PASIDs */
> > +	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a
> > PASIDs */
> > +	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective
> > within a PASID */
> > +	IOMMU_INV_NR_GRANU,
> > +};
> > +
> > +enum iommu_inv_type {
> > +	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
> > +	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure cache
> > */
> > +	IOMMU_INV_TYPE_PASID,	/* PASID cache */
> > +	IOMMU_INV_TYPE_CONTEXT,	/* device context entry
> > cache */  
> 
> Is that really needed? When the guest updates it context-entry
> equivalent it translates to bind_pasid_table/unbind_pasid_table calls,
> no?
> 
Right no need to passdown context cache invalidation for VT-d. I just
wasn't sure it is the same for all models. Again, trying to have a
superset of generic fields.

Thanks!

Jacob
