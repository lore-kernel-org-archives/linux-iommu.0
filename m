From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 11/13] iommu/mediatek: Use builtin_platform_driver
Date: Tue, 5 Mar 2019 11:03:40 -0800
Message-ID: <CAE=gft7ZQ36mKozYBmSJ9j9k4gcQyHMuEZsH0Kems2T6+=GtSg@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-12-git-send-email-yong.wu@mediatek.com> <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
 <1551278012.17917.51.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551278012.17917.51.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 27, 2019 at 6:33 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2019-02-25 at 15:56 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > MediaTek IOMMU should wait for smi larb which need wait for the
> > > power domain(mtk-scpsys.c) and the multimedia ccf who both are
> > > module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
> > > Switch to builtin_platform_driver.
> > >
> > > Meanwhile, the ".remove" can be removed. Move its content to
> > > ".shutdown".
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/mtk_iommu.c    | 23 ++---------------------
> > >  drivers/iommu/mtk_iommu_v1.c | 16 ++--------------
> > >  2 files changed, 4 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 735ae8d..2798b12 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -690,7 +690,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> > >         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> > >  }
> > >
> > > -static int mtk_iommu_remove(struct platform_device *pdev)
> > > +static void mtk_iommu_shutdown(struct platform_device *pdev)
> > >  {
> > >         struct mtk_iommu_data *data = platform_get_drvdata(pdev);
> > >
> > > @@ -703,12 +703,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
> > >         clk_disable_unprepare(data->bclk);
> > >         devm_free_irq(&pdev->dev, data->irq, data);
> > >         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> > > -       return 0;
> > > -}
> > > -
> > > -static void mtk_iommu_shutdown(struct platform_device *pdev)
> > > -{
> > > -       mtk_iommu_remove(pdev);
> >
> > Is there a reason all these things are happening in shutdown()? Don't
> > we normally just not clean things up and let the machine turn off?
> > Normally I'm a big advocate of proper symmetric teardown, so it hurts
> > a little to ask.
>
> In this patch I change the driver to builtin driver. I guess the
> "_remove" is not helpful now. thus I remove it.
>
> About the shutdown, I don't have a special reason for it. I only want to
> mute the m4u log when something go wrong in the shutdown flow.
>

Wouldn't you want to see the logs when something goes wrong in
shutdown? Or is there a lot of noise that gets generated if you don't
do this during a graceful shutdown? I guess if there's some real
reason you're doing all this stuff in shutdown then it's fine, but if
it was just a default shuttling of code from remove to shutdown
because remove was going away then it could be deleted.
-Evan
