From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/6] iommu: add IOMMU_PRIV attribute
Date: Mon, 11 Jul 2016 15:08:06 +0100
Message-ID: <5783A846.1050601@arm.com>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
 <20160709020919.6760-2-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160709020919.6760-2-mitchelh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mitchel Humpherys <mitchelh@codeaurora.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jordan Crouse <jcrouse@codeaurora.org>, Jeremy Gebben <jgebben@codeaurora.org>, Patrick Daly <pdaly@codeaurora.org>, Pratik Patel <pratikp@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On 09/07/16 03:09, Mitchel Humpherys wrote:
> Add the IOMMU_PRIV attribute, which is used to indicate privileged
> mappings.
> 
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  include/linux/iommu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 664683aedcce..01c9f2667f2b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -31,6 +31,7 @@
>  #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
>  #define IOMMU_NOEXEC	(1 << 3)
>  #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
> +#define IOMMU_PRIV	(1 << 5)

I agree on the IOMMU_PRIV name, but can't help thinking it might be
worth a brief comment to make it abundantly clear at a glance that it
isn't "private" or "priority 5" or whatever ;)

Robin.

>  struct iommu_ops;
>  struct iommu_group;
> 
