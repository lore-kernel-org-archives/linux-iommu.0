From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv2 4/6] Crashdump-Accepting-Active-IOMMU-Copy-Translations
Date: Fri, 20 Dec 2013 15:25:57 +0800
Message-ID: <20131220072557.GA4382@dhcp-16-105.nay.redhat.com>
References: <1387507787-14163-1-git-send-email-bill.sumner@hp.com>
	<1387507787-14163-5-git-send-email-bill.sumner@hp.com>
	<20131220060429.GB32194@dhcp-16-116.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131220060429.GB32194-je1gSBvt1Tcx0jIIkfS+Ph/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/20/13 at 02:04pm, Baoquan He wrote:
> On 12/19/13 at 07:49pm, Bill Sumner wrote:
> 
> > +static int copy_page_addr(u64 page_addr, u32 shift, u32 bus, u32 devfn,
> > +				u64 pte, struct dmar_domain *domain,
> > +				void *parms)
> > +{
> > +	struct copy_page_addr_parms *ppap = parms;
> > +
> > +	u64 page_size = ((u64)1 << shift);	/* page_size */
> > +	u64 pfn_lo;				/* For reserving IOVA range */
> > +	u64 pfn_hi;				/* For reserving IOVA range */
> > +	struct iova *iova_p;			/* For reserving IOVA range */
> > +
> > +	if (!ppap) {
> > +		pr_err("ERROR: ppap is NULL: 0x%3.3x(%3.3d) DevFn: 0x%3.3x(%3.3d) Page: 0x%16.16llx Size: 0x%16.16llx(%lld)\n",
> > +			bus, bus, devfn, devfn,  page_addr,
> > +			page_size, page_size);
> > +		return 0;
> > +	}
> > +
> 
> > +	/* Prepare for a new page */
> > +	ppap->first     = 0;		/* Not first-time anymore */
> > +	ppap->bus       = bus;
> > +	ppap->devfn     = devfn;
> > +	ppap->shift     = shift;
> > +	ppap->pte       = pte;
> > +	ppap->next_addr = page_addr + page_size; /* Next-expected page_addr */
> > +
> > +	ppap->page_addr = page_addr;	/* Addr(new page) */
> > +	ppap->page_size = page_size;	/* Size(new page) */
> > +
> > +	ppap->domain    = domain;	/* adr(domain for the new range) */
> 
> Here I am confused, ppap is used to collect the copied ranges and
> necessary information. To my understanding, this domain is the
> dmar_domain which the 1st device is on. When ppat->last is set to 1,
> among the whole collected range, there may be many domains. I just feel
> not good for this. Is it OK to define a specific lock for ppap
> structure, possibly? Please correct me if I am wrong.

Well, check it again. It's not about the lock. Just all address is
recorded in one dmar_domain.
