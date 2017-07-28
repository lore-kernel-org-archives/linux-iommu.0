From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] iommu/exynos: prevent building on big-endian kernels
Date: Fri, 28 Jul 2017 21:17:26 +0200
Message-ID: <20170728191726.rjx5pczkfwe6q2eo@kozik-lap>
References: <20170728131954.213595-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728131954.213595-1-arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Joerg Roedel <joro@8bytes.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 28, 2017 at 03:19:19PM +0200, Arnd Bergmann wrote:
> Since we print the correct warning, an allmodconfig build is no longer
> clean but always prints it, which defeats compile-testing:
> 
> drivers/iommu/exynos-iommu.c:58:2: error: #warning "revisit driver if we can enable big-endian ptes" [-Werror=cpp]
> 
> This replaces the #warning with a dependency, moving warning text into
> a comment.
> 
> Fixes: 1f59adb1766d ("iommu/exynos: Replace non-existing big-endian Kconfig option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/Kconfig        | 1 +
>  drivers/iommu/exynos-iommu.c | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)
>

Makes sense, although there is no error to fix (for fixes tag). If there
was an error, then probably the one bringing warning and wrong kconfig
option (6ae5343c26f9cba5e9ef8 "iommu/exynos: update to use iommu
big-endian")?

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
