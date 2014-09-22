From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 04/18] clk: exynos: add missing smmu_g2d clock and
 update comments
Date: Mon, 22 Sep 2014 14:09:34 +0200
Message-ID: <5420117E.9030108@gmail.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com> <1410868485-4143-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1410868485-4143-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 16.09.2014 13:54, Marek Szyprowski wrote:
> This patch adds missing smmu_g2d clock implementation and updates
> comment about Exynos4 clocks from 278-282 range. Those clocks are
> available on all Exynos4 SoC series, so the misleading comment has been
> removed.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c   |  1 +
>  include/dt-bindings/clock/exynos4.h | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 

Applied for next.

Best regards,
Tomasz
