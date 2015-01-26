From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 11/18] iommu: exynos: remove useless device_add/remove
 callbacks
Date: Mon, 26 Jan 2015 14:47:01 +0100
Message-ID: <20150126134701.GH30345@8bytes.org>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
 <2829552.kzfCU5HyxQ@avalon>
 <20150126110059.GC30345@8bytes.org>
 <1589480.9kxdoXKkuz@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1589480.9kxdoXKkuz@avalon>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Mon, Jan 26, 2015 at 03:03:57PM +0200, Laurent Pinchart wrote:
> On Monday 26 January 2015 12:00:59 Joerg Roedel wrote:
> > My plan is to make IOMMU groups mandatory. I am currently preparing and
> > RFC patch-set to introduce default-domains (which will be per group). So
> > when all IOMMU drivers are converted to make use of default domains the
> > iommu groups will be mandatory.
> 
> Could the default domain policy be configured by the IOMMU driver ? The ipmmu-
> vmsa driver supports four domains only, and serves up to 32 masters, with one 
> group per master. A default of one domain per group wouldn't be usable.

I guess this limitation is a property of the iommu hardware. I currently
have no support for this in the patch-set, but I think it is easy (and
the best way) to support a model where we have only one default domain
for all groups. This is not in the patch set right now, but will be
added at some point.


	Joerg
