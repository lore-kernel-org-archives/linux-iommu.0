From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 10/25] iommu: exynos: remove useless device_add/remove
 callbacks
Date: Mon, 18 May 2015 19:04:30 +0200
Message-ID: <20150518170430.GK20611@8bytes.org>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-11-git-send-email-m.szyprowski@samsung.com>
 <20150505145538.GL15736@8bytes.org>
 <5559D66A.5070406@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5559D66A.5070406@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On Mon, May 18, 2015 at 02:09:14PM +0200, Marek Szyprowski wrote:
> >Hmm, will this remove support for iommu-groups in the exynos driver? I
> >am still working on the default-domain patch-set which makes iommu-group
> >support mandatory for iommu-drivers.
> 
> I you wish, I can leave this code. iommu-groups were not used at all
> on Exynos,
> so I thought that there is no point keeping useless code.

Yes, please keep the iommu-goups support, it will be required at some
point.


	Joerg
