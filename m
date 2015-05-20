From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 18/25] ARM: Exynos: pm_domains: register power domain
 driver from core_initcall
Date: Wed, 20 May 2015 09:51:23 +0900
Message-ID: <555BDA8B.30402@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1432041645-11172-19-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-19-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: iommu@lists.linux-foundation.org

On 19.05.2015 22:20, Marek Szyprowski wrote:
> SYSMMU devices are registered very early in arch_initcall, so ensure
> that they can get access to power domains by registering power domain
> driver from earlier initcall. This change requires dropping usage of the
> platform device associated with each power domain and replacing clock
> calls with respective of_clk_* equivalents.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mach-exynos/pm_domains.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
