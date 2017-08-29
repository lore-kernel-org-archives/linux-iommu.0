From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Tue, 29 Aug 2017 14:12:13 +0200
Message-ID: <20170829121213.uj7p4ctgt74xzkae@suse.de>
References: <1503496204-2527-1-git-send-email-joro@8bytes.org>
	<1503496204-2527-3-git-send-email-joro@8bytes.org>
	<811dfba8-097c-0deb-c283-a7b1e0c6ee38@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <811dfba8-097c-0deb-c283-a7b1e0c6ee38-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 29, 2017 at 12:23:36PM +0100, Robin Murphy wrote:
> On 23/08/17 14:50, Joerg Roedel wrote:
> [...]
> > @@ -350,6 +379,20 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
> >  	return domain->ops->map_sg(domain, iova, sg, nents, prot);
> >  }
> >  
> > +static inline size_t iommu_map_sg_sync(struct iommu_domain *domain,
> > +				       unsigned long iova,
> > +				       struct scatterlist *sg,
> > +				       unsigned int nents, int prot)
> > +{
> > +	size_t size = domain->ops->map_sg(domain, iova, sg, nents, prot);
> > +	if (size > 0) {
> > +		iommu_tlb_range_add(domain, iova, size);
> > +		iommu_tlb_sync(domain);
> > +	}
> > +
> > +	return size;
> > +}
> 
> Do we still need this, or has it just slipped through from v1?

Ah, this slipped through, thanks for noticing. I will remove it.


Thanks,

	Joerg
