From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 10/20] iommu/mediatek: Move reset_axi into plat_data
Date: Thu, 31 Jan 2019 11:22:26 +0800
Message-ID: <1548904946.19710.40.camel@mhfsdcap03>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
         <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2019-01-30 at 10:30 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while
> > it is extended to REG_MMU_CTRL which contains _STANDARD_AXI_MODE in
> > the other SoCs. I move this property to plat_data since both mt8173
> > and mt8183 use this property.
> >
> > It is a preparing patch for mt8183.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 4 ++--
> >  drivers/iommu/mtk_iommu.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 35a1263..8d8ab21 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -558,8 +558,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >         }
> >         writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> >
> > -       /* It's MISC control register whose default value is ok except mt8173.*/
> > -       if (data->plat_data->m4u_plat == M4U_MT8173)
> > +       if (data->plat_data->reset_axi)
> >                 writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
> 
> The commit description makes it sound like the overall format of the
> register is the same, but the "other SoCs" have some extra bits they'd
> like to leave alone. Would it be easier to do a read-modify-write to
> always clear some bits in the register, instead of doing something
> based on the SoC? Or do the bits mean completely different things in
> the different versions (in which case what you've got makes sense to
> me)?

The bits mean completely is different.(the axi bit position also is
different. I will add this in the comment of this patch.)

> -Evan
