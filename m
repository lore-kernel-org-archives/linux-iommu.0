From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
Date: Wed, 27 Feb 2019 22:34:43 +0800
Message-ID: <1551278083.17917.53.camel@mhfsdcap03>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
         <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
         <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft7R4tkR9hAif4izQi1J1QTcC0rUVyrLAnDdzu_RHV6yHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > MediaTek IOMMU don't have its power-domain. all the consumer connect
> > with smi-larb, then connect with smi-common.
> >
> >         M4U
> >          |
> >     smi-common
> >          |
> >   -------------
> >   |         |    ...
> >   |         |
> > larb1     larb2
> >   |         |
> > vdec       venc
> >
> > When the consumer works, it should enable the smi-larb's power which
> > also need enable the smi-common's power firstly.
> >
> > Thus, First of all, use the device link connect the consumer and the
> > smi-larbs. then add device link between the smi-larb and smi-common.
> >
> > This patch adds device_link between the consumer and the larbs.
> >
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
> >  drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
> >  2 files changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 202e41b..735ae8d 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >         struct mtk_smi_larb_iommu    *larb_mmu;
> >         unsigned int                 larbid, portid;
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       struct device_link *link;
> >         int i;
> >
> >         for (i = 0; i < fwspec->num_ids; ++i) {
> > @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >                 dev_dbg(dev, "%s iommu port: %d\n",
> >                         enable ? "enable" : "disable", portid);
> >
> > -               if (enable)
> > +               if (enable) {
> >                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> > -               else
> > +                       /* Link the consumer with the larb device(supplier) */
> > +                       link = device_link_add(dev, larb_mmu->dev,
> > +                                              DL_FLAG_PM_RUNTIME |
> > +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> > +                       if (!link) {
> > +                               dev_err(dev, "Unable to link %s\n",
> > +                                       dev_name(larb_mmu->dev));
> > +                               return;
> 
> The return is a little odd here, given that you don't return an error
> and this function doesn't do anything else. If it's non-fatal that
> this link didn't get set up, then remove the return. If it is fatal,
> then return an error code.

I will remove the "return". Thanks.

> 
> > +                       }
> > +               } else {
> >                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> > +               }
> >         }
> >  }
> >
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 9386aee..022bad9 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >         struct mtk_smi_larb_iommu    *larb_mmu;
> >         unsigned int                 larbid, portid;
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       struct device_link *link;
> >         int i;
> >
> >         for (i = 0; i < fwspec->num_ids; ++i) {
> > @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
> >                 dev_dbg(dev, "%s iommu port: %d\n",
> >                         enable ? "enable" : "disable", portid);
> >
> > -               if (enable)
> > +               if (enable) {
> >                         larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> > -               else
> > +                       link = device_link_add(dev, larb_mmu->dev,
> > +                                              DL_FLAG_PM_RUNTIME |
> > +                                              DL_FLAG_AUTOREMOVE_CONSUMER);
> > +                       if (!link) {
> > +                               dev_err(dev, "Unable to link %s\n",
> > +                                       dev_name(larb_mmu->dev));
> > +                               return;
> 
> Same for this one.
> 
> > +                       }
> > +               } else {
> >                         larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> > +               }
> >         }
> >  }
> >
> > --
> > 1.9.1
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
