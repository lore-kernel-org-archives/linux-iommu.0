From: Roy Pledge <roy.pledge@nxp.com>
Subject: Re: dma-coherent: fix dma_declare_coherent_memory() logic error
Date: Thu, 14 Sep 2017 20:59:16 +0000
Message-ID: <DB6PR04MB2999F7968A4C1804E5C1EB80866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
References: <20170905081026.1198405-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Mark Craske <Mark_Craske@mentor.com>, "George G. Davis" <george_davis@mentor.com>, Bastian Hecht <bhecht@de.adit-jv.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 9/5/2017 4:10 AM, Arnd Bergmann wrote:=0A=
> A recent change interprets the return code of dma_init_coherent_memory=0A=
> as an error value, but it is instead a boolean, where 'true' indicates=0A=
> success. This leads causes the caller to always do the wrong thing,=0A=
> and also triggers a compile-time warning about it:=0A=
> =0A=
> drivers/base/dma-coherent.c: In function 'dma_declare_coherent_memory':=
=0A=
> drivers/base/dma-coherent.c:99:15: error: 'mem' may be used uninitialized=
 in this function [-Werror=3Dmaybe-uninitialized]=0A=
> =0A=
> I ended up changing the code a little more, to give use the usual=0A=
> error handling, as this seemed the best way to fix up the warning=0A=
> and make the code look reasonable at the same time.=0A=
> =0A=
> Fixes: 2436bdcda53f ("dma-coherent: remove the DMA_MEMORY_MAP and DMA_MEM=
ORY_IO flags")=0A=
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>=0A=
> ---=0A=
>   drivers/base/dma-coherent.c | 38 +++++++++++++++++++++++++-------------=
=0A=
>   1 file changed, 25 insertions(+), 13 deletions(-)=0A=
> =0A=
> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c=0A=
> index f82a504583d4..a39b2166b145 100644=0A=
> --- a/drivers/base/dma-coherent.c=0A=
> +++ b/drivers/base/dma-coherent.c=0A=
> @@ -37,7 +37,7 @@ static inline dma_addr_t dma_get_device_base(struct dev=
ice *dev,=0A=
>   		return mem->device_base;=0A=
>   }=0A=
>   =0A=
> -static bool dma_init_coherent_memory(=0A=
> +static int dma_init_coherent_memory(=0A=
>   	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,=
=0A=
>   	struct dma_coherent_mem **mem)=0A=
>   {=0A=
> @@ -45,20 +45,28 @@ static bool dma_init_coherent_memory(=0A=
>   	void __iomem *mem_base =3D NULL;=0A=
>   	int pages =3D size >> PAGE_SHIFT;=0A=
>   	int bitmap_size =3D BITS_TO_LONGS(pages) * sizeof(long);=0A=
> +	int ret;=0A=
>   =0A=
> -	if (!size)=0A=
> +	if (!size) {=0A=
> +		ret =3D -EINVAL;=0A=
>   		goto out;=0A=
> +	}=0A=
>   =0A=
>   	mem_base =3D memremap(phys_addr, size, MEMREMAP_WC);=0A=
> -	if (!mem_base)=0A=
> +	if (!mem_base) {=0A=
> +		ret =3D -EINVAL;=0A=
>   		goto out;=0A=
> -=0A=
> +	}=0A=
>   	dma_mem =3D kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);=0A=
> -	if (!dma_mem)=0A=
> +	if (!dma_mem) {=0A=
> +		ret =3D -ENOMEM;=0A=
>   		goto out;=0A=
> +	}=0A=
>   	dma_mem->bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);=0A=
> -	if (!dma_mem->bitmap)=0A=
> +	if (!dma_mem->bitmap) {=0A=
> +		ret =3D -ENOMEM;=0A=
>   		goto out;=0A=
> +	}=0A=
>   =0A=
>   	dma_mem->virt_base =3D mem_base;=0A=
>   	dma_mem->device_base =3D device_addr;=0A=
> @@ -68,13 +76,13 @@ static bool dma_init_coherent_memory(=0A=
>   	spin_lock_init(&dma_mem->spinlock);=0A=
>   =0A=
>   	*mem =3D dma_mem;=0A=
> -	return true;=0A=
> +	return 0;=0A=
>   =0A=
>   out:=0A=
>   	kfree(dma_mem);=0A=
>   	if (mem_base)=0A=
>   		memunmap(mem_base);=0A=
> -	return false;=0A=
> +	return ret;=0A=
>   }=0A=
>   =0A=
>   static void dma_release_coherent_memory(struct dma_coherent_mem *mem)=
=0A=
> @@ -338,14 +346,18 @@ static struct reserved_mem *dma_reserved_default_me=
mory __initdata;=0A=
>   static int rmem_dma_device_init(struct reserved_mem *rmem, struct devic=
e *dev)=0A=
>   {=0A=
>   	struct dma_coherent_mem *mem =3D rmem->priv;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (!mem)=0A=
> +		return -ENODEV;=0A=
=0A=
When I picked up this change my use of of_reserved_mem_device_init() =0A=
broke. The only place rmem->priv is set is in this function (bottom of =0A=
the patch) so the !mem check above will always fail. Am I missing =0A=
something? It seems to me the intent here was to only call =0A=
dma_init_coherent_memory() once and use rmem->priv as a cache for future =
=0A=
calls but I'm just looking at the implemation of this for the first time.=
=0A=
=0A=
>   =0A=
> -	if (!mem &&=0A=
> -	    !dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,=0A=
> -				      DMA_MEMORY_EXCLUSIVE,=0A=
> -				      &mem)) {=0A=
> +	ret =3D dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,=0A=
> +				       DMA_MEMORY_EXCLUSIVE, &mem);=0A=
> +=0A=
> +	if (ret) {=0A=
>   		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size =
%ld MiB\n",=0A=
>   			&rmem->base, (unsigned long)rmem->size / SZ_1M);=0A=
> -		return -ENODEV;=0A=
> +		return ret;=0A=
>   	}=0A=
>   	mem->use_dev_dma_pfn_offset =3D true;=0A=
>   	rmem->priv =3D mem;=0A=
> =0A=
=0A=
