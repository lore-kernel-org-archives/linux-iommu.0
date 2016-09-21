From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 7/8] iommu/amd: Don't update domain info to dte entry
 at iommu init stage
Date: Wed, 21 Sep 2016 18:26:13 +0800
Message-ID: <20160921102613.GD13350@x1.redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
 <1473951806-25511-8-git-send-email-bhe@redhat.com>
 <20160920125004.GF3541@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160920125004.GF3541@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dyoung@redhat.com, xlpang@redhat.com, Vincent.Wan@amd.com
List-Id: iommu@lists.linux-foundation.org

On 09/20/16 at 02:50pm, Joerg Roedel wrote:
> On Thu, Sep 15, 2016 at 11:03:25PM +0800, Baoquan He wrote:
> > AMD iommu creates protection domain and assign each device to it during
> > iommu driver initialization stage. This happened just after system pci
> > bus scanning stage, and much earlier than device driver init stage. So
> > at this time if in kdump kernel the domain info, especially pte_root,
> > can't be updated to dte entry. We should wait until device driver init
> > stage.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  drivers/iommu/amd_iommu.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index fcb69ff..6c37300 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -137,6 +137,7 @@ struct iommu_dev_data {
> >  	bool pri_tlp;			  /* PASID TLB required for
> >  					     PPR completions */
> >  	u32 errata;			  /* Bitmap for errata to apply */
> > +	bool domain_updated;
> >  };
> >  
> >  /*
> > @@ -1708,6 +1709,15 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
> >  {
> >  	u64 pte_root = 0;
> >  	u64 flags = 0;
> > +	struct iommu_dev_data *dev_data;
> > +	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
> > +
> > +	dev_data = find_dev_data(devid);
> > +        if (!dev_data)
> > +                return;
> > +
> > +	if (translation_pre_enabled(iommu) && !dev_data->domain_updated)
> > +		return;
> >  
> >  	if (domain->mode != PAGE_MODE_NONE)
> >  		pte_root = virt_to_phys(domain->pt_root);
> > @@ -1756,6 +1766,14 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
> >  
> >  static void clear_dte_entry(u16 devid)
> >  {
> > +	struct iommu_dev_data *dev_data;
> > +	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
> > +
> > +	dev_data = find_dev_data(devid);
> > +        if (!dev_data)
> > +                return;
> > +	if (translation_pre_enabled(iommu) && !dev_data->domain_updated)
> > +		return;
> 
> This should be moved to do_attach/do_detach. There you also already have
> the dev_data you need here.

For amd-vi v1, checking in do_attach/do_detach is enough. But for v2
amd_iommu_domain_direct_map and amd_iommu_domain_enable_v2 also call it
to install pte_root into dev table. So finally, I move them into these
two lowest level functions to prevent any pte_root changing during iommu
init stage. It involves the least code change.

> 
> >  	/* remove entry from the device table seen by the hardware */
> >  	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
> >  	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
> > -- 
> > 2.5.5
> > 
