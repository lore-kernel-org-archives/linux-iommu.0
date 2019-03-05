From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 05/13] memory: mtk-smi: Add device-link between smi-larb
 and smi-common
Date: Tue, 5 Mar 2019 11:02:58 -0800
Message-ID: <CAE=gft4=VjbQut0vGVJ=ViqBCva00tdq1K-QnyJKSkzA4f0rUw@mail.gmail.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-6-git-send-email-yong.wu@mediatek.com> <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
 <1551277985.17917.48.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551277985.17917.48.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 27, 2019 at 6:33 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > Normally, If the smi-larb HW need work, we should enable the smi-common
> > > HW power and clock firstly.
> > > This patch adds device-link between the smi-larb dev and the smi-common
> > > dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
> > > (smi-common-dev) will be called automatically.
> > >
> > > Since smi is built-in driver like IOMMU and never unbound,
> > > DL_FLAG_AUTOREMOVE_* is not needed.
> > >
> > > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/memory/mtk-smi.c | 16 +++++++---------
> > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > index 9688341..30930e4 100644
> > > --- a/drivers/memory/mtk-smi.c
> > > +++ b/drivers/memory/mtk-smi.c
> > > @@ -271,6 +271,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> > >         struct device *dev = &pdev->dev;
> > >         struct device_node *smi_node;
> > >         struct platform_device *smi_pdev;
> > > +       struct device_link *link;
> > >
> > >         larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
> > >         if (!larb)
> > > @@ -310,6 +311,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> > >                 if (!platform_get_drvdata(smi_pdev))
> > >                         return -EPROBE_DEFER;
> > >                 larb->smi_common_dev = &smi_pdev->dev;
> > > +               link = device_link_add(dev, larb->smi_common_dev,
> > > +                                      DL_FLAG_PM_RUNTIME);
> >
> > Doesn't this need to be torn down in remove()? You mention that it's
> > built-in and never removed, but it does seem to have a remove()
>
> The MTK IOMMU driver need depend on this SMI driver. the IOMMU is a
> builtin driver, thus the SMI also should be a builtin driver.
>
> Technically, If the driver is builtin, then the "remove" function can be
> removed? If yes, I could use a new patch do it.

Yeah, I guess so. It's always sad to see cleanup code getting removed,
but it makes sense to me.


>
> It looks the MACRO(builtin_platform_driver) only support one driver, but
> we have two driver(smi-common and smi-larb) here.
>
> > function that tears down everything else, so it seemed a shame to
> > start leaking now. Maybe the AUTOREMOVE flag would do it.
>
>
