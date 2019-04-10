From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [bug report] iommu/io-pgtable-arm: Fix pgtable allocation in
	selftest
Date: Wed, 10 Apr 2019 10:44:03 +0100
Message-ID: <782a999e-ce70-bd8e-5a7b-cd320ce98144@arm.com>
References: <20190410093405.GA9889@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190410093405.GA9889@kadam>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Dan,

On 10/04/2019 10:34, Dan Carpenter wrote:
> Hello Jean-Philippe Brucker,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch fac83d29d954: "iommu/io-pgtable-arm: Fix pgtable allocation
> in selftest" from Jun 18, 2018, leads to the following Smatch
> complaint:
> 
>      drivers/iommu/io-pgtable-arm.c:246 __arm_lpae_alloc_pages()
>      error: we previously assumed 'dev' could be null (see line 239)
> 
> drivers/iommu/io-pgtable-arm.c
>     238		VM_BUG_ON((gfp & __GFP_HIGHMEM));
>     239		p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
>                                       ^^^
> We added a NULL check here
> 
>     240				     gfp | __GFP_ZERO, order);
>     241		if (!p)
>     242			return NULL;
>     243	
>     244		pages = page_address(p);
>     245		if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {

The selftests *should* always set this quirk such that they never get to 
the DMA mapping calls (that was one of the reasons for implementing 
things that way) - I guess that might be a bit too sneaky for Smatch, 
but I can take a look to double-check that the flow is working correctly 
such that this really is a false-positive.

Robin.

>     246			dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
>                                               ^^^
> But dma_map_single() can't take a NULL argument either.
> 
>     247			if (dma_mapping_error(dev, dma))
>     248				goto out_free;
> 
> I don't know why this warning is only showing up now, almost a year
> later.  Sorry about that.
> 
> regards,
> dan carpenter
> 
