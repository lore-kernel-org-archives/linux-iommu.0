From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: dma_ops_domain_alloc causes kernel 4.1.0-next-20150626+ panic
Date: Mon, 29 Jun 2015 21:34:02 +0200
Message-ID: <20150629193402.GM18569@8bytes.org>
References: <CAPBX1x+zagVVYebbXU0M7VkEaDkzvqBGnkt6PW_N42fRQRQ9Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPBX1x+zagVVYebbXU0M7VkEaDkzvqBGnkt6PW_N42fRQRQ9Gg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: George Wang <xuw2015-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 30, 2015 at 01:44:34AM +0800, George Wang wrote:
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index d3e5e9a..4f6da17 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1882,6 +1882,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
>                 return NULL;
> 
>         spin_lock_init(&dma_dom->domain.lock);
> +       mutex_init(&dma_dom->domain.api_lock);
> 
> When I initialize the api_lock, then I can go forward with another problem.

How do you trigger this? The DMA-API domains are not used via the
IOMMU-API yet, so the initializing the api-lock for it shouldn't matter.


	Joerg
