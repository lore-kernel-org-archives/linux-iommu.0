From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/exynos: Remove custom platform device registration
 code
Date: Fri, 4 Aug 2017 13:02:00 +0200
Message-ID: <20170804110200.GD17443@8bytes.org>
References: <CGME20170804102843eucas1p1fb17da4f86044a8ad78cc1684aa6e321@eucas1p1.samsung.com>
 <1501842513-23180-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501842513-23180-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 04, 2017 at 12:28:33PM +0200, Marek Szyprowski wrote:
> Commit 09515ef5ddad ("of/acpi: Configure dma operations at probe time for
> platform/amba/pci bus devices") postponed the moment of attaching IOMMU
> controller to its device, so there is no need to register IOMMU controllers
> very early, before all other devices in the system. This change gives us an
> opportunity to use standard platform device registration method also for
> Exynos SYSMMU controllers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 36 +++++++++---------------------------
>  1 file changed, 9 insertions(+), 27 deletions(-)

Applied, thanks.
