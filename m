From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [bug report] iommu/io-pgtable-arm: Fix pgtable allocation in
	selftest
Date: Wed, 10 Apr 2019 13:02:37 +0300
Message-ID: <20190410100237.GA31633@kadam>
References: <20190410093405.GA9889@kadam>
	<782a999e-ce70-bd8e-5a7b-cd320ce98144@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <782a999e-ce70-bd8e-5a7b-cd320ce98144-5wv7dgnIgG8@public.gmane.org>
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
Cc: jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 10, 2019 at 10:44:03AM +0100, Robin Murphy wrote:
> Hi Dan,
> 
> On 10/04/2019 10:34, Dan Carpenter wrote:
> > Hello Jean-Philippe Brucker,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch fac83d29d954: "iommu/io-pgtable-arm: Fix pgtable allocation
> > in selftest" from Jun 18, 2018, leads to the following Smatch
> > complaint:
> > 
> >      drivers/iommu/io-pgtable-arm.c:246 __arm_lpae_alloc_pages()
> >      error: we previously assumed 'dev' could be null (see line 239)
> > 
> > drivers/iommu/io-pgtable-arm.c
> >     238		VM_BUG_ON((gfp & __GFP_HIGHMEM));
> >     239		p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
> >                                       ^^^
> > We added a NULL check here
> > 
> >     240				     gfp | __GFP_ZERO, order);
> >     241		if (!p)
> >     242			return NULL;
> >     243	
> >     244		pages = page_address(p);
> >     245		if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
> 
> The selftests *should* always set this quirk such that they never get to the
> DMA mapping calls (that was one of the reasons for implementing things that
> way) - I guess that might be a bit too sneaky for Smatch, but I can take a
> look to double-check that the flow is working correctly such that this
> really is a false-positive.

Ah, thanks.

I have a plan for fixing these false positives caused by not tracking
bit masks.  It's not that complicated to fix, it just takes time to
write the code.

regards,
dan carpenter
