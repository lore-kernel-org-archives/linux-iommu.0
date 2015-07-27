From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Mon, 27 Jul 2015 16:31:48 +0100
Message-ID: <20150727153148.GJ7557@n2100.arm.linux.org.uk>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
 <55B630CE.4050803@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B630CE.4050803@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <Mark.Rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>, "arnd@arndb.de" <arnd@arndb.de>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Rob Herring <robh+dt@kernel.org>, Daniel Kurtz <djkurtz@google.com>, Sasha Hauer <kernel@pengutronix.de>, "cloud.chou@mediatek.com" <cloud.chou@mediatek.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, frederic.chen@mediat
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 27, 2015 at 02:23:26PM +0100, Robin Murphy wrote:
> On 16/07/15 10:04, Yong Wu wrote:
> >This patch adds support for mediatek m4u (MultiMedia Memory Management
> >Unit).
> >
> >Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> [...]
> >+static void mtk_iommu_flush_pgtable(void *ptr, size_t size, void *cookie)
> >+{
> >+       struct mtk_iommu_domain *domain = cookie;
> >+       unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
> >+
> >+       dma_map_page(domain->data->dev, virt_to_page(ptr), offset,
> >+                    size, DMA_TO_DEVICE);
> 
> Nit: this looks like it may as well be dma_map_single.
> 
> It would probably be worth following it with a matching unmap too, just to
> avoid any possible leakage bugs (especially if this M4U ever appears in a
> SoC supporting RAM above the 32-bit boundary).

Why not do the job properly?  Take a look at how I implemented the
streaming DMA API on Tegra SMMU (patch set recently sent out earlier
today).

There's no need for hacks like dma_map_page() (and discarding it's
return value) or dma_map_page() followed by dma_unmap_page().

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
