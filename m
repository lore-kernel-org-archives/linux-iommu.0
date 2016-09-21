From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 8/8] iommu/amd: Update domain into to dte entry during
	device driver init
Date: Wed, 21 Sep 2016 18:31:15 +0800
Message-ID: <20160921103115.GE13350@x1.redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
	<1473951806-25511-9-git-send-email-bhe@redhat.com>
	<20160920125330.GG3541@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160920125330.GG3541-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/20/16 at 02:53pm, Joerg Roedel wrote:
> On Thu, Sep 15, 2016 at 11:03:26PM +0800, Baoquan He wrote:
> > All devices are supposed to reset themselves at device driver initialization
> > stage. At this time if in kdump kernel those on-flight DMA will be stopped
> > because of device reset. It's best time to update the protection domain info,
> > especially pte_root, to dte entry which the device relates to.
> > 
> > Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/amd_iommu.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index 6c37300..00b64ee 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -2310,6 +2310,10 @@ static dma_addr_t __map_single(struct device *dev,
> >  	unsigned int pages;
> >  	int prot = 0;
> >  	int i;
> > +	struct iommu_dev_data *dev_data = get_dev_data(dev);
> > +	struct protection_domain *domain = get_domain(dev);
> > +	u16 alias = amd_iommu_alias_table[dev_data->devid];
> > +	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
> >  
> >  	pages = iommu_num_pages(paddr, size, PAGE_SIZE);
> >  	paddr &= PAGE_MASK;
> > @@ -2319,6 +2323,13 @@ static dma_addr_t __map_single(struct device *dev,
> >  		goto out;
> >  
> >  	prot = dir2prot(direction);
> > +	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
> > +               dev_data->domain_updated = true;
> > +               set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
> > +               if (alias != dev_data->devid)
> > +                       set_dte_entry(alias, domain, dev_data->ats.enabled);
> > +               device_flush_dte(dev_data);
> > +       }
> 
> Hmm, have you tried hooking this into the set_dma_mask call-back? Every
> driver should call it for its device, so that should be a better
> indicator to now map a new domain.

Very earlier you mentioned this, and I tried, but failed. I guess that
is because of the bnx2 NIC resetting problem. Let me try it again. In
theory it should be better. Just sometime people probably don't call
set_dma_mask explicitly, then default dma mask is used. This could be
seen in those simple device. For those complicated device like sata disk
and ethernet NIC, set_dma_mask should be called. So I would like to try
and use set_dma_mask. Thanks for your great suggestion.

Thanks
Baoquan
