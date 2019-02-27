From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 03/13] iommu/mediatek: Add probe_defer for smi-larb
Date: Wed, 27 Feb 2019 22:33:54 +0800
Message-ID: <1551278034.17917.52.camel@mhfsdcap03>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
         <1546318276-18993-4-git-send-email-yong.wu@mediatek.com>
         <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: youlin.pei@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > The iommu consumer should use device_link to connect with the
> > smi-larb(supplier). then the smi-larb should run before the iommu
> > consumer. Here we delay the iommu driver until the smi driver is
> > ready, then all the iommu consumer always is after the smi driver.
> >
> > When there is no this patch, if some consumer drivers run before
> > smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> > device_link_add, then device_links_driver_bound will use WARN_ON
> > to complain that the link_status of supplier is not right.
> >
> 
> I don't quite have enough knowledge of device links to figure out if
> this is a) the right fix, b) a deficiency in the device_links code, or
> c) neither.

I can not say more about the device link, But from the MTK iommu point
of view, it looks a right fix. As the comment above, we should make sure
the probe sequence, SMI-larb should be before MTK IOMMU which need be
before iommu-consumer. this patch help SMI-larb always is before
MTK_IOMMU.

Then if there is no this patchset, what the MTK_IOMMU will happen?.

The MTK_IOMMU is subsys_initcall, all the consume only need after the
MTK_IOMMU and don't need wait for SMI-larb driver. If some consume run
before SMI-larb driver, It also is OK while it don't call
mtk_smi_larb_get in this probe.(Of course it will abort if it call this
while smi-driver don't probe at that time). the consumer and smi-larb
normally are module_init, we can not guarantee the the sequence. it is a
potential issue.

Some consume know it should wait for SMI-larb like [1], but It don't
work.

[1]
https://elixir.bootlin.com/linux/v5.0-rc1/source/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c#L145

> 
> Perhaps someone else could chime in on this one.
> -Evan
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
