From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Fri, 05 Dec 2014 11:22:32 +0100
Message-ID: <54818768.3080303@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1417514366.21830.22.camel@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Inki Dae <inki.dae@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-12-02 10:59, Sjoerd Simons wrote:
> Hey Marek, Inki,
>
> On Wed, 2014-11-19 at 12:15 +0100, Marek Szyprowski wrote:
>> Hello Everyone,
>>
>> This is another attempt to finally make Exynos SYSMMU driver fully
>> integrated with DMA-mapping subsystem. The main change from previous
>> version is a rebase onto latest "automatic DMA configuration for IOMMU
>> masters" patches from Will Deacon.
> Do you happen to know if anyone is working on iommu/dma-mapping patches
> for Exynos 5 based on this patchset?

I hope to add Exynos5 SYSMMU patches to the next iteration of my patchset,
but I doubt it will get into v3.19-rc1.

> For some background to that question, We (re-)discovered yesterday that
> the out-of-tree exynos-reference kernel iommu patches are required to
> get HDMI out working on exynos 5 boards. The current situation in
> mainline is rather broken, HDMI output without CONFIG_DRM_EXYNOS_IOMMU
> results in just displaying stripes[0]. While turning on
> CONFIG_DRM_EXYNOS_IOMMU causes a kernel oops at boot....

We have observed similar issues with Exynos4 based boards, when LCD0 power
domain was turned off and only TV power domain has been powered on. Please
check the power domain configuration. Maybe in case of Exynos5 the same 
issue
is caused by the interaction between DISP1 and GSCL domains.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
