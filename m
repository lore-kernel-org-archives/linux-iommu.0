From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 16/20] memory: mtk-smi: Add bus_sel for mt8183
Date: Thu, 31 Jan 2019 11:20:08 +0800
Message-ID: <1548904808.19710.35.camel@mhfsdcap03>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
         <1546314952-15990-17-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4q3oj+oQ=Vo-kGD7OYTO0_WMf8t4SLa_H7SCH8G2VFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4q3oj+oQ=Vo-kGD7OYTO0_WMf8t4SLa_H7SCH8G2VFOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2019-01-30 at 11:07 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> > mmu0 or mmu1 to balance the bandwidth via the smi-common register
> > SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
> >
> > In mt8183, For better performance, we switch larb1/2/5/7 to enter
> > mmu1 while the others still keep enter mmu0.
> >
> > In mt8173 and mt2712, we don't get the performance issue,
> > Keep its default value(0x0), that means all the larbs enter mmu0.
> >
> > Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
> >
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 9790801..08cf40d 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -49,6 +49,12 @@
> >  #define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
> >  #define F_MMU_EN               BIT(0)
> >
> > +/* SMI COMMON */
> > +#define SMI_BUS_SEL                    0x220
> > +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> > +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> > +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> > +
> >  enum mtk_smi_gen {
> >         MTK_SMI_GEN1,
> >         MTK_SMI_GEN2
> > @@ -57,6 +63,7 @@ enum mtk_smi_gen {
> >  struct mtk_smi_common_plat {
> >         enum mtk_smi_gen gen;
> >         bool             has_gals;
> > +       u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
> >  };
> >
> >  struct mtk_smi_larb_gen {
> > @@ -72,8 +79,8 @@ struct mtk_smi {
> >         struct clk                      *clk_apb, *clk_smi;
> >         struct clk                      *clk_gals0, *clk_gals1;
> >         struct clk                      *clk_async; /*only needed by mt2701*/
> > -       void __iomem                    *smi_ao_base;
> > -
> > +       void __iomem                    *smi_ao_base; /* only for gen1 */
> > +       void __iomem                    *base;        /* only for gen2 */
> >         const struct mtk_smi_common_plat *plat;
> >  };
> >
> > @@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> >  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> >         .gen      = MTK_SMI_GEN2,
> >         .has_gals = true,
> > +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> > +                   F_MMU1_LARB(7),
> >  };
> >
> >  static const struct of_device_id mtk_smi_common_of_ids[] = {
> > @@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
> >                 ret = clk_prepare_enable(common->clk_async);
> >                 if (ret)
> >                         return ret;
> > +       } else {
> > +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +               common->base = devm_ioremap_resource(dev, res);
> > +               if (IS_ERR(common->base))
> > +                       return PTR_ERR(common->base);
> 
> So you split base and smi_ao_base because they're completely different
> register regions, or because ->base is no longer "always on"? It's
> tempting to recombine them because they appear to be mutually
> exclusive, but if they're truly different register regions then I
> understand.

They are completely different. the common->base is the smi-common normal
base while the common->smi_ao_base only exist in smi-gen1.
