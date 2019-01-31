From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 13/20] iommu/mediatek: Add mt8183 IOMMU support
Date: Thu, 31 Jan 2019 11:19:51 +0800
Message-ID: <1548904791.19710.34.camel@mhfsdcap03>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-14-git-send-email-yong.wu@mediatek.com>
         <CAE=gft6nQ4uv5kqYO876sQaKo71F0RkMj4d-dKDvxi8pEy-WgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft6nQ4uv5kqYO876sQaKo71F0RkMj4d-dKDvxi8pEy-WgQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2019-01-30 at 10:31 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> > the ARM Short-descriptor like mt8173, and most of the HW registers
> > are the same.
> >
> > Here list main differences between mt8183 and mt8173/mt2712:
> > 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> > 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> > 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> > mode".
> > 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> > the bit[33:32] in the physical address of the pgtable base, But the
> > standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> > we add a mask.
> > 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> > 6) mt8183 need reset_axi like mt8173.
> > 7) the larb-id in smi-common is remapped. M4U should add its larbid_remap.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 15 ++++++++++++---
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  drivers/memory/mtk-smi.c  | 20 ++++++++++++++++++++
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 2913ddb..66e3615 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -36,6 +36,7 @@
> >  #include "mtk_iommu.h"
> >
> >  #define REG_MMU_PT_BASE_ADDR                   0x000
> > +#define MMU_PT_ADDR_MASK                       GENMASK(31, 7)
> >
> >  #define REG_MMU_INVALIDATE                     0x020
> >  #define F_ALL_INVLD                            0x2
> > @@ -342,7 +343,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
> >         /* Update the pgtable base address register of the M4U HW */
> >         if (!data->m4u_dom) {
> >                 data->m4u_dom = dom;
> > -               writel(dom->cfg.arm_v7s_cfg.ttbr[0],
> > +               writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
> 
> So there aren't any other bits down below 7 that you need, like the
> shareable bits?

Yes. We don't need all the bits down below 7. As the comment 4) above,
we mask it just because the S bit.
