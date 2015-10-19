From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
Date: Mon, 19 Oct 2015 09:42:14 +0300
Message-ID: <1739171.POGWkgX12k@avalon>
References: <20151019030253.6274.46547.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20151019030253.6274.46547.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patch.

On Monday 19 October 2015 12:02:53 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Neither the ARM page table code enabled by IOMMU_IO_PGTABLE_LPAE
> nor the IPMMU_VMSA driver actually depends on ARM_LPAE, so get
> rid of the dependency.
>
> Tested with ipmmu-vmsa on r8a7794 ALT and a kernel config using:
>  # CONFIG_ARM_LPAE is not set

The driver only supports the 40-bits page table format for now, hence the 
dependency on LPAE, but it indeed seems that the dependency is bogus. As long 
as the 8 MSBs of the translated address are all 0 I assume the output 40-bit 
address is usable on a 32-bit physical address system.

How have you tested the patch ?

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/iommu/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- 0001/drivers/iommu/Kconfig
> +++ work/drivers/iommu/Kconfig	2015-10-18 14:58:09.080513000 +0900
> @@ -324,7 +324,6 @@ config SHMOBILE_IOMMU_L1SIZE
> 
>  config IPMMU_VMSA
>  	bool "Renesas VMSA-compatible IPMMU"
> -	depends on ARM_LPAE
>  	depends on ARCH_SHMOBILE || COMPILE_TEST
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE

-- 
Regards,

Laurent Pinchart

