From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V7 4/8] common: DMA-mapping: add DMA_ATTR_PRIVILEGED
 attribute
Date: Tue, 13 Dec 2016 13:55:46 +0000
Message-ID: <941457b5-9bfc-8df5-6f70-5f92e950cd89@arm.com>
References: <1481567927-14791-1-git-send-email-sricharan@codeaurora.org>
 <1481567927-14791-5-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481567927-14791-5-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>, jcrouse@codeaurora.org, pdaly@codeaurora.org, jgebben@codeaurora.org, joro@8bytes.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org, iommu@lists.linux-foundation.org, tzeng@codeaurora.org, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, mitchelh@codeaurora.org, vinod.koul@intel.com
Cc: dan.j.williams@intel.com
List-Id: iommu@lists.linux-foundation.org

On 12/12/16 18:38, Sricharan R wrote:
> From: Mitchel Humpherys <mitchelh@codeaurora.org>
> 
> This patch adds the DMA_ATTR_PRIVILEGED attribute to the DMA-mapping
> subsystem.
> 
> Some advanced peripherals such as remote processors and GPUs perform
> accesses to DMA buffers in both privileged "supervisor" and unprivileged
> "user" modes.  This attribute is used to indicate to the DMA-mapping
> subsystem that the buffer is fully accessible at the elevated privilege
> level (and ideally inaccessible or at least read-only at the
> lesser-privileged levels).
> 
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  Documentation/DMA-attributes.txt | 10 ++++++++++
>  include/linux/dma-mapping.h      |  7 +++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
> index 98bf7ac..44c6bc4 100644
> --- a/Documentation/DMA-attributes.txt
> +++ b/Documentation/DMA-attributes.txt
> @@ -143,3 +143,13 @@ So, this provides a way for drivers to avoid those error messages on calls
>  where allocation failures are not a problem, and shouldn't bother the logs.
>  
>  NOTE: At the moment DMA_ATTR_NO_WARN is only implemented on PowerPC.
> +
> +DMA_ATTR_PRIVILEGED
> +------------------------------
> +
> +Some advanced peripherals such as remote processors and GPUs perform
> +accesses to DMA buffers in both privileged "supervisor" and unprivileged
> +"user" modes.  This attribute is used to indicate to the DMA-mapping
> +subsystem that the buffer is fully accessible at the elevated privilege
> +level (and ideally inaccessible or at least read-only at the
> +lesser-privileged levels).
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 6f3e6ca..ee31ea1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -63,6 +63,13 @@
>  #define DMA_ATTR_NO_WARN	(1UL << 8)
>  
>  /*
> + * DMA_ATTR_PRIVILEGED: used to indicate that the buffer is fully
> + * accessible at an elevated privilege level (and ideally inaccessible or
> + * at least read-only at lesser-privileged levels).
> + */
> +#define DMA_ATTR_PRIVILEGED		(1UL << 8)

Oops, I spoke slightly too soon - there's a value conflict here which
has been missed in the rebase.

Robin

> +
> +/*
>   * A dma_addr_t can hold any valid DMA or bus address for the platform.
>   * It can be given to a device to use as a DMA source or target.  A CPU cannot
>   * reference a dma_addr_t directly because there may be translation between
> 
