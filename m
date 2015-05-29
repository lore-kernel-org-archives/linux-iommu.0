From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v7 03/25] iommu: Init iommu-groups support earlier, in
 core_initcall
Date: Fri, 29 May 2015 10:33:24 +0200
Message-ID: <20150529083323.GD13130@8bytes.org>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1432041645-11172-4-git-send-email-m.szyprowski@samsung.com>
 <2209337.hhg3lyvUbi@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2209337.hhg3lyvUbi@avalon>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Sat, May 23, 2015 at 07:23:34PM +0300, Laurent Pinchart wrote:
> On Tuesday 19 May 2015 15:20:23 Marek Szyprowski wrote:
> > -arch_initcall(iommu_init);
> > +core_initcall(iommu_init);
> 
> I'll let Joerg comment on this, but this initcall ordering dance always makes 
> me feel that something isn't quite right. Have you had a chance to look at the 
> patch series I posted about a week ago to implement IOMMU probe deferral 
> support ?

Yeah, this is hacky, but I can live with it until your probe deferal
patch-set is merged.


	Joerg
