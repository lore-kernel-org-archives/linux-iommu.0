From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] iommu/exynos: Suppress unbinding to prevent system failure
Date: Fri, 20 May 2016 16:02:36 +0200
Message-ID: <573F18FC.9000506@samsung.com>
References: <1463752114-23653-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <1463752114-23653-1-git-send-email-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 05/20/2016 03:48 PM, Marek Szyprowski wrote:
> Removal of IOMMU driver cannot be done reliably, so Exynos IOMMU driver
> doesn't support this operation. It is essential for system operation, so
> it makes sense to prevent unbinding by disabling bind/unbind sysfs
> feature for SYSMMU controller driver to avoid kernel ops or trashing
> memory caused by such operation.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: stable@vger.kernel.org  # v4.2+
> ---
>  drivers/iommu/exynos-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
