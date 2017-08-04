From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/exynos: prevent building on big-endian kernels
Date: Fri, 4 Aug 2017 11:56:03 +0200
Message-ID: <20170804095603.GA17443@8bytes.org>
References: <20170728131954.213595-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728131954.213595-1-arnd@arndb.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
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

Applied, thanks.
