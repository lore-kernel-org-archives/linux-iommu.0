Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F14C3F2D4
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 07:10:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E5B2073D
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 07:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i6eYExUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E5B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E960187E74;
	Fri,  6 Mar 2020 07:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id arbZ0J9G9wKI; Fri,  6 Mar 2020 07:10:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 197AA87E6E;
	Fri,  6 Mar 2020 07:10:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E72E0C18D3;
	Fri,  6 Mar 2020 07:10:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78447C013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 07:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4DE1A87E6E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 07:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id byNYux+EY5en for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 07:10:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id CA4EC87E74
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 07:10:07 +0000 (UTC)
X-UUID: 58704f9f07854fc3bbccf18a0d2e5295-20200306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=gkqDoOqHIrOTpmFheXHWiY15sLy0Mn7me1/+UDymw5E=; 
 b=i6eYExUFp8TbbpiIpervjhx/AOvdtjC8UwuF1nYDxYHjrF3KjEvZanoYuteF2lkPqc0MkCTTWrHL3DJ39AseRq5SyqC3yOXCkDVOqH85/NyiTO6y+dAry07pgQa7jmYSSlS4/tLuirgD2MfAnh4VarSiM4u4EE/8uGJiP861FnM=;
X-UUID: 58704f9f07854fc3bbccf18a0d2e5295-20200306
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1987127789; Fri, 06 Mar 2020 14:59:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 6 Mar 2020 14:58:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Mar 2020 14:58:41 +0800
Message-ID: <1583477982.4784.37.camel@mhfsdcap03>
Subject: Re: [PATCH v3 03/14] iommu/mediatek: Add device_link between the
 consumer and the larb devices
From: Yong Wu <yong.wu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Date: Fri, 6 Mar 2020 14:59:42 +0800
In-Reply-To: <CANMq1KAOHFF43708ktvhEU6EYZv_s7Wp+kUwFD7h0bwVrQpyqw@mail.gmail.com>
References: <1567503456-24725-1-git-send-email-yong.wu@mediatek.com>
 <1567503456-24725-4-git-send-email-yong.wu@mediatek.com>
 <CANMq1KAOHFF43708ktvhEU6EYZv_s7Wp+kUwFD7h0bwVrQpyqw@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B84E2E8EC000FE6B20341D7962063DB72347CFF9209A3FBB475D95CD84B3A5AB2000:8
X-MTK: N
Cc: maoguang.meng@mediatek.com, Will Deacon <will.deacon@arm.com>,
 youlin.pei@mediatek.com, Evan Green <evgreen@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>,
 Devicetree List <devicetree@vger.kernel.org>, cui.zhang@mediatek.com,
 houlong.wei@mediatek.com, Tomasz Figa <tfiga@google.com>,
 sj.huang@mediatek.com, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 anan.sun@mediatek.com, srv_heupstream <srv_heupstream@mediatek.com>,
 lkml <linux-kernel@vger.kernel.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2020-03-05 at 13:14 +0800, Nicolas Boichat wrote:
> On Tue, Sep 3, 2019 at 5:38 PM Yong Wu <yong.wu@mediatek.com> wrote:
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
> > When device_link_add, I add the flag DL_FLAG_STATELESS to avoid calling
> > pm_runtime_xx to keep the original status of clocks. It can avoid two
> > issues:
> > 1) Display HW show fastlogo abnormally reported in [1]. At the beggining,
> > all the clocks are enabled before entering kernel, but the clocks for
> > display HW(always in larb0) will be gated after clk_enable and clk_disable
> > called from device_link_add(->pm_runtime_resume) and rpm_idle. The clock
> > operation happened before display driver probe. At that time, the display
> > HW will be abnormal.
> >
> > 2) A deadlock issue reported in [2]. Use DL_FLAG_STATELESS to skip
> > pm_runtime_xx to avoid the deadlock.
> >
> > Corresponding, DL_FLAG_AUTOREMOVE_CONSUMER can't be added, then
> > device_link_removed should be added explicitly.
> >
> > [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-July/
> > 021500.html
> > [2] https://lore.kernel.org/patchwork/patch/1086569/
> >
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c    | 17 +++++++++++++++++
> >  drivers/iommu/mtk_iommu_v1.c | 18 +++++++++++++++++-
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index b138b94..2511b3c 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -450,6 +450,9 @@ static int mtk_iommu_add_device(struct device *dev)
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >         struct mtk_iommu_data *data;
> >         struct iommu_group *group;
> > +       struct device_link *link;
> > +       struct device *larbdev;
> > +       unsigned int larbid;
> >
> >         if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> >                 return -ENODEV; /* Not a iommu client device */
> > @@ -461,6 +464,14 @@ static int mtk_iommu_add_device(struct device *dev)
> >         if (IS_ERR(group))
> >                 return PTR_ERR(group);
> >
> > +       /* Link the consumer device with the smi-larb device(supplier) */
> > +       larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
> 
> I'll mirror the comment I made on gerrit
> (https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1361013):
> Maybe I'm missing something here, but for example, on MT8173,
> vcodec_enc: vcodec@18002000 needs to use both larb3 and larb5, isn't
> the code below just adding a link for larb3?

Yes. It only add larb3 here.

> 
> Do we need to iterate over all fwspecs->ids to figure out which larbs
> we need to add links to each of them?

We have checked this venc issue. Currently I have requested our venc guy
to seperate larb3-venc and larb5-venc in the driver[1] since they are
independent HW actually. I will put it into this series when I send next
version.

If there is some reasonable driver which have two larbs in it, then the
iterating is really necessary, But I don't see it right now. Only using
fwspec->ids[0] is enough for now.

[1]
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1958322

> 
> > +       larbdev = data->larb_imu[larbid].dev;
> > +       link = device_link_add(dev, larbdev,
> > +                              DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> > +       if (!link)
> > +               dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> > +
> >         iommu_group_put(group);
> >         return 0;
> >  }
> > @@ -469,6 +480,8 @@ static void mtk_iommu_remove_device(struct device *dev)
> >  {
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >         struct mtk_iommu_data *data;
> > +       struct device *larbdev;
> > +       unsigned int larbid;
> >
> >         if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> >                 return;
> > @@ -476,6 +489,10 @@ static void mtk_iommu_remove_device(struct device *dev)
> >         data = fwspec->iommu_priv;
> >         iommu_device_unlink(&data->iommu, dev);
> >
> > +       larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
> > +       larbdev = data->larb_imu[larbid].dev;
> > +       device_link_remove(dev, larbdev);
> > +
> >         iommu_group_remove_device(dev);
> >         iommu_fwspec_free(dev);
> >  }
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 2034d72..a7f22a2 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -423,7 +423,9 @@ static int mtk_iommu_add_device(struct device *dev)
> >         struct of_phandle_iterator it;
> >         struct mtk_iommu_data *data;
> >         struct iommu_group *group;
> > -       int err;
> > +       struct device_link *link;
> > +       struct device *larbdev;
> > +       int err, larbid;
> >
> >         of_for_each_phandle(&it, err, dev->of_node, "iommus",
> >                         "#iommu-cells", 0) {
> > @@ -466,6 +468,14 @@ static int mtk_iommu_add_device(struct device *dev)
> >                 return err;
> >         }
> >
> > +       /* Link the consumer device with the smi-larb device(supplier) */
> > +       larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
> > +       larbdev = data->larb_imu[larbid].dev;
> > +       link = device_link_add(dev, larbdev,
> > +                              DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> > +       if (!link)
> > +               dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> > +
> >         return iommu_device_link(&data->iommu, dev);
> >  }
> >
> > @@ -473,6 +483,8 @@ static void mtk_iommu_remove_device(struct device *dev)
> >  {
> >         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >         struct mtk_iommu_data *data;
> > +       struct device *larbdev;
> > +       unsigned int larbid;
> >
> >         if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> >                 return;
> > @@ -480,6 +492,10 @@ static void mtk_iommu_remove_device(struct device *dev)
> >         data = fwspec->iommu_priv;
> >         iommu_device_unlink(&data->iommu, dev);
> >
> > +       larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
> > +       larbdev = data->larb_imu[larbid].dev;
> > +       device_link_remove(dev, larbdev);
> > +
> >         iommu_group_remove_device(dev);
> >         iommu_fwspec_free(dev);
> >  }
> > --
> > 1.9.1
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
