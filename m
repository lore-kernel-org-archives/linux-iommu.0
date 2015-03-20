From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH 00/15] iommu: Move domain allocation into drivers
Date: Fri, 20 Mar 2015 17:24:18 +0800
Message-ID: <1426843458.23931.17.camel@mtksdaap41>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422316305-19216-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Alexandre Courbot <gnurou@gmail.com>, linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Alex Williamson <alex.williamson@redhat.com>, Kukjin Kim <kgene@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, jroedel@suse.de, linux-tegra@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Hiroshi Doyu <hdoyu@nvidia.com>, Tomasz Figa <tfiga@chromium.org>, Yong Wu =?UTF-8?Q?=28=E5=90=B4=E5=8B=87=29?= <yong.wu@mediatek.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-01-27 at 00:51 +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Hi,
> 
> here is patch-set to replace the existing domain_init and
> domain_destroy iommu-ops with the new domain_alloc and
> domain_free callbacks
> 
> The new callbacks move the allocation of iommu domains into
> the iommu driver, allowing them to put a generic
> iommu_domain struct into their own domain struct. This makes
> domain handling in the drivers more cache efficient and
> prepares the introduction of default domains in another
> patch-set.

Hi Joerg,

What's the status of this patchset?
While porting MTK IOMMU driver[1], we need to use a global variable
because we need to do dma_alloc_coherent in our domain_init. I think we
can remove that global variable if we base on this series.

Joe.C

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328461.html
