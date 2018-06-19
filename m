From: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
Subject: Re: [PATCH 18/25] MIPS: loongson64: use generic dma noncoherent ops
Date: Tue, 19 Jun 2018 16:19:25 -0700
Message-ID: <20180619231925.mgbgc7lfvjqumr7a@pburton-laptop>
References: <20180615110854.19253-1-hch@lst.de>
	<20180615110854.19253-19-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180615110854.19253-19-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Fri, Jun 15, 2018 at 01:08:47PM +0200, Christoph Hellwig wrote:
> -static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
> -	dma_addr_t dma_addr)
> -{
> -#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> -	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
> -#else
> -	return dma_addr & 0x7fffffff;
> -#endif
> -}

...

> +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
> +{
> +#if defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
> +	if (dma_addr > 0x8fffffff)
> +		return dma_addr;
> +#endif
> +	return dma_addr & 0x0fffffff;
> +}

Thanks for putting in the work here - I've applied patches 1-17 to
mips-next so far, but I'm struggling to convince myself that the above
is correct.

In the original code we have 3 distinct cases:

  64b Loongson2F, dma_addr > 0x8fffffff  -> dma_addr
  64b Loongson2F, dma_addr <= 0x8fffffff -> dma_addr & 0x0fffffff
  Everything else                        -> dma_addr & 0x7fffffff

In the new __dma_to_phys() though only the first case remains the same.

Is this intentional or a mixup?

Thanks,
    Paul
