From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 11/18] iommu: exynos: remove useless device_add/remove
 callbacks
Date: Mon, 26 Jan 2015 12:00:59 +0100
Message-ID: <20150126110059.GC30345@8bytes.org>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
 <1422028288-891-12-git-send-email-m.szyprowski@samsung.com>
 <2829552.kzfCU5HyxQ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2829552.kzfCU5HyxQ@avalon>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Sun, Jan 25, 2015 at 05:38:22PM +0200, Laurent Pinchart wrote:
> IOMMU groups still seem a bit unclear to me. Will Deacon has nicely explained 
> what they represent in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310816.html.
> The IOMMU core doesn't make groups 
> mandatory, but requires them in some code paths.
> 
> For example the coldplug device add function add_iommu_group() called for all 
> devices already registered when bus_set_iommu() is called will try to warn of 
> devices added multiple times with a WARN_ON(dev->iommu_group). Another example 
> is the iommu_bus_notifier() function which will call the remove_device() 
> operation only when dev->iommu_group isn't NULL.
> 
> I'm thus unsure whether groups should be made mandatory, or whether the IOMMU 
> core should be fixed to make them really optional (or, third option, whether 
> there's something I haven't understood properly).

My plan is to make IOMMU groups mandatory. I am currently preparing and
RFC patch-set to introduce default-domains (which will be per group). So
when all IOMMU drivers are converted to make use of default domains the
iommu groups will be mandatory.


	Joerg
