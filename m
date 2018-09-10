From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Date: Mon, 10 Sep 2018 18:13:50 +0200
Message-ID: <20180910161350.GA10380@kroah.com>
References: <20180910060533.27172-1-hch@lst.de>
 <20180910060533.27172-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910060533.27172-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 10, 2018 at 08:05:30AM +0200, Christoph Hellwig wrote:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 8f882549edee..983506789402 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -927,6 +927,8 @@ struct dev_links_info {
>   * @offline:	Set after successful invocation of bus type's .offline().
>   * @of_node_reused: Set if the device-tree node is shared with an ancestor
>   *              device.
> + * @dma_coherent: this particular device is dma coherent, even if the
> + *		architecture supports non-coherent devices.
>   *
>   * At the lowest level, every device in a Linux system is represented by an
>   * instance of struct device. The device structure contains the information
> @@ -1016,6 +1018,11 @@ struct device {
>  	bool			offline_disabled:1;
>  	bool			offline:1;
>  	bool			of_node_reused:1;
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> +	bool			dma_coherent:1;
> +#endif

It's just one bit, why not always have it enabled here?  If the arch
uses it or doesn't, no big deal.

Or are you using this to "catch" arches that mess something up?

thanks,

greg k-h
