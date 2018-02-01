From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
Date: Wed, 31 Jan 2018 17:46:15 -0800
Message-ID: <1517449575.3715.113.camel@gmail.com>
References: <1517438756.3715.108.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517438756.3715.108.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Serebrin <serebrin@google.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2018-01-31 at 14:45 -0800, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Some devices (like mlx4) try hard to allocate memory on selected
> NUMA node, but it turns out intel_alloc_coherent() is not NUMA
> aware yet.
> 
> Note that dma_generic_alloc_coherent() in arch/x86/kernel/pci-dma.c
> gets this right.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Benjamin Serebrin <serebrin@google.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/intel-iommu.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a1373cf343269455808f66ad18dc0a2fb7aa73f2..0efef077abc099eb29ebc5cefdd1b996f025dffd 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3734,8 +3734,11 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
>  		}
>  	}
>  
> -	if (!page)
> -		page = alloc_pages(flags, order);
> +	if (!page) {
> +		page = alloc_pages_node(dev_to_node(dev), flags, order);
> +		if (!page)
> +			page = alloc_pages(flags, order);

I'll send a V2 without the fallback to alloc_pages()

This seems not necessary at all.


> +	}
>  	if (!page)
>  		return NULL;
>  	memset(page_address(page), 0, size);
