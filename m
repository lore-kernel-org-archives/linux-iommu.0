From: Joe Jin <joe.jin@oracle.com>
Subject: Re: [PATCH RFC 1/1] swiotlb: add debugfs to track swiotlb buffer
 usage
Date: Thu, 6 Dec 2018 08:12:02 -0800
Message-ID: <da16ecce-4e25-d246-3e0d-389e8e9e413e@oracle.com>
References: <1544068785-20399-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544068785-20399-1-git-send-email-dongli.zhang@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dongli Zhang <dongli.zhang@oracle.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

Hi Dongli,

Maybe move d_swiotlb_usage declare into swiotlb_create_debugfs():

void swiotlb_create_debugfs(void)
{
#ifdef CONFIG_DEBUG_FS
	static struct dentry *d_swiotlb_usage = NULL;

	if (d_swiotlb_usage)
		return;

	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);

	if (!d_swiotlb_usage)
		return;

	debugfs_create_file("usage", 0600, d_swiotlb_usage,
			    NULL, &swiotlb_usage_fops);
#endif
}

And for io_tlb_used, possible add a check at the begin of swiotlb_tbl_map_single(),
if there were not any free slots or not enough slots, return fail directly?

Thanks,
Joe
On 12/5/18 7:59 PM, Dongli Zhang wrote:
> The device driver will not be able to do dma operations once swiotlb buffer
> is full, either because the driver is using so many IO TLB blocks inflight,
> or because there is memory leak issue in device driver. To export the
> swiotlb buffer usage via debugfs would help the user estimate the size of
> swiotlb buffer to pre-allocate or analyze device driver memory leak issue.
> 
> As the swiotlb can be initialized at very early stage when debugfs cannot
> register successfully, this patch creates the debugfs entry on demand.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 045930e..d3c8aa4 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -35,6 +35,9 @@
>  #include <linux/scatterlist.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/set_memory.h>
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +#endif
>  
>  #include <asm/io.h>
>  #include <asm/dma.h>
> @@ -73,6 +76,13 @@ static phys_addr_t io_tlb_start, io_tlb_end;
>   */
>  static unsigned long io_tlb_nslabs;
>  
> +#ifdef CONFIG_DEBUG_FS
> +/*
> + * The number of used IO TLB block
> + */
> +static unsigned long io_tlb_used;
> +#endif
> +
>  /*
>   * This is a free list describing the number of free entries available from
>   * each index
> @@ -100,6 +110,41 @@ static DEFINE_SPINLOCK(io_tlb_lock);
>  
>  static int late_alloc;
>  
> +#ifdef CONFIG_DEBUG_FS
> +
> +static struct dentry *d_swiotlb_usage;
> +
> +static int swiotlb_usage_show(struct seq_file *m, void *v)
> +{
> +	seq_printf(m, "%lu\n%lu\n", io_tlb_used, io_tlb_nslabs);
> +	return 0;
> +}
> +
> +static int swiotlb_usage_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, swiotlb_usage_show, NULL);
> +}
> +
> +static const struct file_operations swiotlb_usage_fops = {
> +	.open           = swiotlb_usage_open,
> +	.read           = seq_read,
> +	.llseek         = seq_lseek,
> +	.release        = single_release,
> +};
> +
> +void swiotlb_create_debugfs(void)
> +{
> +	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
> +
> +	if (!d_swiotlb_usage)
> +		return;
> +
> +	debugfs_create_file("usage", 0600, d_swiotlb_usage,
> +			    NULL, &swiotlb_usage_fops);
> +}
> +
> +#endif
> +
>  static int __init
>  setup_io_tlb_npages(char *str)
>  {
> @@ -449,6 +494,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
>  			     sme_active() ? "SME" : "SEV");
>  
> +#ifdef CONFIG_DEBUG_FS
> +	if (unlikely(!d_swiotlb_usage))
> +		swiotlb_create_debugfs();
> +#endif
> +
>  	mask = dma_get_seg_boundary(hwdev);
>  
>  	tbl_dma_addr &= mask;
> @@ -528,6 +578,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>  	return SWIOTLB_MAP_ERROR;
>  found:
> +#ifdef CONFIG_DEBUG_FS
> +	io_tlb_used += nslots;
> +#endif
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  
>  	/*
> @@ -588,6 +641,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  		 */
>  		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
>  			io_tlb_list[i] = ++count;
> +
> +#ifdef CONFIG_DEBUG_FS
> +		io_tlb_used -= nslots;
> +#endif
>  	}
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  }
> 
