From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: Re: [PATCH v2 4/7] iommu: only unmap mapped entries
Date: Wed, 13 Apr 2016 13:37:08 -0700
Message-ID: <20160413203707.GA2034274@devbig084.prn1.facebook.com>
References: <cover.1460548546.git.mad@cs.technion.ac.il>
	<e07164c8d0aaff68cabd2cf8e3aee9ed20882ae4.1460548546.git.mad@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e07164c8d0aaff68cabd2cf8e3aee9ed20882ae4.1460548546.git.mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 13, 2016 at 09:52:00PM +0300, Adam Morrison wrote:
> @@ -3738,7 +3743,16 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
>  			   int nelems, enum dma_data_direction dir,
>  			   struct dma_attrs *attrs)
>  {
> -	intel_unmap(dev, sglist[0].dma_address);
> +	dma_addr_t startaddr = sglist[0].dma_address - sglist[0].offset;
> +	unsigned long nrpages = 0;
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sglist, sg, nelems, i) {
> +		nrpages += aligned_nrpages(sg->offset, sg->length);
> +	}
> +
> +	intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
>  }

I'm uncomfortmable with the .dma_address, .length. There are macros for
these, sg_dma_address/sg_dma_len. For .offset, are we sure it's always
valid in .unmap_sg? Better use sg_dma_address/sg_dma_len and align them
to get the pages.

Thanks,
Shaohua
