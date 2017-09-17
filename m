From: Roy Pledge <roy.pledge-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH] dma-coherent: fix rmem_dma_device_init regression
Date: Sun, 17 Sep 2017 12:35:00 +0000
Message-ID: <DB6PR04MB2999521F03C88E4A5A1682A386620@DB6PR04MB2999.eurprd04.prod.outlook.com>
References: <20170915150824.3805217-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek
	Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Craske <Mark_Craske-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Bastian Hecht <bhecht-Tbglbhd2jqSoSS7kgVBzIA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "George G. Davis" <george_davis-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 9/15/2017 11:08 AM, Arnd Bergmann wrote:
> My recent bug fix introduced another bug, which caused rmem_dma_device_init
> to always fail, as rmem->priv is never set to anything.
> 
> This restores the previous behavior, calling dma_init_coherent_memory()
> whenever ->priv is NULL.
> 
> Fixes: d35b0996fef3 ("dma-coherent: fix dma_declare_coherent_memory() logic error")
> Reported-by: Roy Pledge <roy.pledge-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> ---
> Roy, can you test this new fix?
> ---
>   drivers/base/dma-coherent.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
> index a39b2166b145..744f64f43454 100644
> --- a/drivers/base/dma-coherent.c
> +++ b/drivers/base/dma-coherent.c
> @@ -348,16 +348,15 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
>   	struct dma_coherent_mem *mem = rmem->priv;
>   	int ret;
>   
> -	if (!mem)
> -		return -ENODEV;
> -
> -	ret = dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
> -				       DMA_MEMORY_EXCLUSIVE, &mem);
> -
> -	if (ret) {
> -		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
> -			&rmem->base, (unsigned long)rmem->size / SZ_1M);
> -		return ret;
> +	if (!mem) {
> +		ret = dma_init_coherent_memory(rmem->base, rmem->base,
> +					       rmem->size,
> +					       DMA_MEMORY_EXCLUSIVE, &mem);
> +		if (ret) {
> +			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
> +				&rmem->base, (unsigned long)rmem->size / SZ_1M);
> +			return ret;
> +		}
>   	}
>   	mem->use_dev_dma_pfn_offset = true;
>   	rmem->priv = mem;
> 
I tried this and it solves the issue I was seeing. Thanks for the quick fix.

Tested-by:  Roy Pledge <roy.pledge-3arQi8VN3Tc@public.gmane.org>
