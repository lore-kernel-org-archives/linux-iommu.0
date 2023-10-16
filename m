Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E722F1A
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00DD21FB;
	Mon, 16 Oct 2023 04:18:54 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 772803F5A1;
	Mon, 16 Oct 2023 04:18:11 -0700 (PDT)
Message-ID: <6808cecc-41c2-4e6e-9886-5ad633d8ba8f@arm.com>
Date: Mon, 16 Oct 2023 12:18:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] riscv: only select DMA_DIRECT_REMAP from
 RISCV_ISA_ZICBOM
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
 iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
References: <20231016054755.915155-1-hch@lst.de>
 <20231016054755.915155-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231016054755.915155-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2023 6:47 am, Christoph Hellwig wrote:
> RISCV_DMA_NONCOHERENT is also used for whacky non-standard
> non-coherent ops that use different hooks in dma-direct.

FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/riscv/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0ac0b538379718..9c48fecc671918 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -273,7 +273,6 @@ config RISCV_DMA_NONCOHERENT
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select DMA_BOUNCE_UNALIGNED_KMALLOC if SWIOTLB
> -	select DMA_DIRECT_REMAP if MMU
>   
>   config RISCV_NONSTANDARD_CACHE_OPS
>   	bool
> @@ -549,6 +548,7 @@ config RISCV_ISA_ZICBOM
>   	depends on RISCV_ALTERNATIVE
>   	default y
>   	select RISCV_DMA_NONCOHERENT
> +	select DMA_DIRECT_REMAP
>   	help
>   	   Adds support to dynamically detect the presence of the ZICBOM
>   	   extension (Cache Block Management Operations) and enable its
