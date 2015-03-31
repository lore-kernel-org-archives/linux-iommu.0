From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 00/16 v2] iommu: Move domain allocation into drivers
Date: Tue, 31 Mar 2015 15:18:34 +0200
Message-ID: <20150331131834.GE4441@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
 <20150330174315.GD15655@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150330174315.GD15655@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>, Hiroshi Doyu <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "jroedel@suse.de" <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Mon, Mar 30, 2015 at 06:43:15PM +0100, Will Deacon wrote:
> Whilst I'm still a bit worried about the ability of the IOMMU driver to do
> very much in the ->domain_alloc callback (since we don't know which IOMMU
> instance the domain is for), it doesn't leave us any worse off than we
> currently are.

The IOMMU driver should just allocate the data-structures for a domain
in the domain_alloc call-back. It should not be necessary to care about
any relations of the domain with specific iommu instances.
 
> So, for the arm-smmu patch and the core IOMMU changes:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

Thanks a lot!


	Joerg
