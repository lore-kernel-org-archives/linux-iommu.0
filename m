From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v5 17/20] memory: mtk-smi: Get rid of need_larbid
Date: Thu, 31 Jan 2019 09:45:48 -0800
Message-ID: <CAE=gft6do4Ku7ErqxY2tbPwqDN_3w6i_ygxvyUSyXLYzxvNwTg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-18-git-send-email-yong.wu@mediatek.com> <CAE=gft4vOxt7G0CqZxvNUxCmuGq_L4wc2Wv6LF4Y62BoJQEUXw@mail.gmail.com>
 <1548904937.19710.39.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548904937.19710.39.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 7:22 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2019-01-30 at 11:11 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> > > It's no need to parse it again in SMI driver. Only clean some codes.
> > > This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> > > and mt8183.
> > >
> > > After this patch, the "mediatek,larb-id" only be needed for mt2712
> > > which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> > > in which the larbs in the "mediatek,larbs" always are ordered.
> > >
> > > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/memory/mtk-smi.c | 26 ++------------------------
> > >  1 file changed, 2 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > index 08cf40d..10e6493 100644
> > > --- a/drivers/memory/mtk-smi.c
> > > +++ b/drivers/memory/mtk-smi.c
> > > @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
> > >  };
> > >
> > >  struct mtk_smi_larb_gen {
> > > -       bool need_larbid;
> > >         int port_in_larb[MTK_LARB_NR_MAX + 1];
> > >         void (*config_port)(struct device *);
> > >         unsigned int larb_direct_to_common_mask;
> > > @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
> > >         struct mtk_smi_iommu *smi_iommu = data;
> > >         unsigned int         i;
> > >
> > > -       if (larb->larb_gen->need_larbid) {
> > > -               larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> > > -               return 0;
> > > -       }
> > > -
> > > -       /*
> > > -        * If there is no larbid property, Loop to find the corresponding
> > > -        * iommu information.
> > > -        */
> > > -       for (i = 0; i < smi_iommu->larb_nr; i++) {
> > > +       for (i = 0; i < MTK_LARB_NR_MAX; i++) {
> >
> > Looks like this was the only use of mtk_smi_iommu.larb_nr. Should we
> > remove that now?
>
> This is necessary since the mt2712 which has two M4U HW.
>
> From its dtsi[1], take iommu1 as a example, its larb_nr only is 3, but
> we need scan all the larb.
>
> [1]
> http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016119.html

I'm not sure I follow. My point was that this structure member is only
ever set but never read:
$ git grep '[.>]larb_nr'
drivers/iommu/mtk_iommu.c:      data->smi_imu.larb_nr = larb_nr;
drivers/iommu/mtk_iommu_v1.c:   data->smi_imu.larb_nr = larb_nr;

Maybe I've applied the patches to the wrong tree, and there is a use
of this member I'm not seeing?
-Evan
