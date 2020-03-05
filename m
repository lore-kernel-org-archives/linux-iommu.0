Return-Path: <SRS0=kRV3=4W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F3C3F2CD
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 05:21:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A452072D
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 05:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NrFhDK9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A452072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 98BBF86566;
	Thu,  5 Mar 2020 05:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DSPqrnKNe0jk; Thu,  5 Mar 2020 05:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 269B5814E2;
	Thu,  5 Mar 2020 05:21:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07D90C1AE2;
	Thu,  5 Mar 2020 05:21:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8748CC013E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 05:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7DBBA84B2D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 05:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rrCG4fwDCit2 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Mar 2020 05:21:47 +0000 (UTC)
X-Greylist: delayed 00:07:19 by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C8EFC848A3
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 05:21:46 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id u25so4155477qkk.3
 for <iommu@lists.linux-foundation.org>; Wed, 04 Mar 2020 21:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rTn3aZiOBdvpLaF9in60GflGuo7nuzt/CIGjImwtiUM=;
 b=NrFhDK9B12p+3RdamIUYum/ORdm0XLJgoFeESAo99664Tf9pb1E6TcqGodgrLcM5BU
 6YUyipKpSxuCMqCS5XxgM87hpGBtG6kcUPm3Zq2El6LJ+BtsgCxRXTFOKSp/G+nfZOOI
 T1OpoH0qKLaMjQXRWCU3Yc3tRnguEKVaKs5oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rTn3aZiOBdvpLaF9in60GflGuo7nuzt/CIGjImwtiUM=;
 b=nvwJok7g709mca4AROKy2sOK/vILtcvzY4rKaLA9OUK5RrhIYEQQTZVwSYylTJ1w6v
 2ctX94cJbjc1UB3HbFHut4M02O6tjNmWPDOiexrRb78PX4fFVGB4XLgYSLfSI8C2iNg4
 HSP2bf3YkeKh2et0r8CixIOUkIQB//AQMhVqlCsjsWfluedATvFGLLKzeNXqM02z653O
 FeDUsNDNxgsdIWmaFhXmSNTf1HUs5mKtSQJ8T+ahe/bbGAZU4K0586fa74P/pKj8Iwfb
 2vagWEuBunTx18MoLsdG5Tbk40DD0H/OLrbuHVyghnMjAy2eLjMfqLNhTohRlHhDNvEi
 NPNQ==
X-Gm-Message-State: ANhLgQ3Xmp2waYcqBT0XxdslabV+67yz1mM0IB1Cu75RAPRJPOagD5F7
 bFsjjsleHNi9LzZsBKLjGaMT+W3BTFb6wQglsjBrrrwYYQY=
X-Google-Smtp-Source: ADFU+vsjlqRt25RAnjpqBwwBqr94htBKQelMZzFwJ5kzWW9Pubmn0eresOonSxZoZDexvuo0WFSMiY0iBLfQk0M8fiw=
X-Received: by 2002:a37:c47:: with SMTP id 68mr996909qkm.144.1583385266606;
 Wed, 04 Mar 2020 21:14:26 -0800 (PST)
MIME-Version: 1.0
References: <1567503456-24725-1-git-send-email-yong.wu@mediatek.com>
 <1567503456-24725-4-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1567503456-24725-4-git-send-email-yong.wu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 5 Mar 2020 13:14:14 +0800
Message-ID: <CANMq1KAOHFF43708ktvhEU6EYZv_s7Wp+kUwFD7h0bwVrQpyqw@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] iommu/mediatek: Add device_link between the
 consumer and the larb devices
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, Devicetree List <devicetree@vger.kernel.org>,
 cui.zhang@mediatek.com, srv_heupstream <srv_heupstream@mediatek.com>,
 chao.hao@mediatek.com, Will Deacon <will.deacon@arm.com>,
 lkml <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
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

On Tue, Sep 3, 2019 at 5:38 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU don't have its power-domain. all the consumer connect
> with smi-larb, then connect with smi-common.
>
>         M4U
>          |
>     smi-common
>          |
>   -------------
>   |         |    ...
>   |         |
> larb1     larb2
>   |         |
> vdec       venc
>
> When the consumer works, it should enable the smi-larb's power which
> also need enable the smi-common's power firstly.
>
> Thus, First of all, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
>
> This patch adds device_link between the consumer and the larbs.
>
> When device_link_add, I add the flag DL_FLAG_STATELESS to avoid calling
> pm_runtime_xx to keep the original status of clocks. It can avoid two
> issues:
> 1) Display HW show fastlogo abnormally reported in [1]. At the beggining,
> all the clocks are enabled before entering kernel, but the clocks for
> display HW(always in larb0) will be gated after clk_enable and clk_disable
> called from device_link_add(->pm_runtime_resume) and rpm_idle. The clock
> operation happened before display driver probe. At that time, the display
> HW will be abnormal.
>
> 2) A deadlock issue reported in [2]. Use DL_FLAG_STATELESS to skip
> pm_runtime_xx to avoid the deadlock.
>
> Corresponding, DL_FLAG_AUTOREMOVE_CONSUMER can't be added, then
> device_link_removed should be added explicitly.
>
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-July/
> 021500.html
> [2] https://lore.kernel.org/patchwork/patch/1086569/
>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 17 +++++++++++++++++
>  drivers/iommu/mtk_iommu_v1.c | 18 +++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index b138b94..2511b3c 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -450,6 +450,9 @@ static int mtk_iommu_add_device(struct device *dev)
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>         struct mtk_iommu_data *data;
>         struct iommu_group *group;
> +       struct device_link *link;
> +       struct device *larbdev;
> +       unsigned int larbid;
>
>         if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>                 return -ENODEV; /* Not a iommu client device */
> @@ -461,6 +464,14 @@ static int mtk_iommu_add_device(struct device *dev)
>         if (IS_ERR(group))
>                 return PTR_ERR(group);
>
> +       /* Link the consumer device with the smi-larb device(supplier) */
> +       larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);

I'll mirror the comment I made on gerrit
(https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1361013):
Maybe I'm missing something here, but for example, on MT8173,
vcodec_enc: vcodec@18002000 needs to use both larb3 and larb5, isn't
the code below just adding a link for larb3?

Do we need to iterate over all fwspecs->ids to figure out which larbs
we need to add links to each of them?

> +       larbdev = data->larb_imu[larbid].dev;
> +       link = device_link_add(dev, larbdev,
> +                              DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +       if (!link)
> +               dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> +
>         iommu_group_put(group);
>         return 0;
>  }
> @@ -469,6 +480,8 @@ static void mtk_iommu_remove_device(struct device *dev)
>  {
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>         struct mtk_iommu_data *data;
> +       struct device *larbdev;
> +       unsigned int larbid;
>
>         if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>                 return;
> @@ -476,6 +489,10 @@ static void mtk_iommu_remove_device(struct device *dev)
>         data = fwspec->iommu_priv;
>         iommu_device_unlink(&data->iommu, dev);
>
> +       larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
> +       larbdev = data->larb_imu[larbid].dev;
> +       device_link_remove(dev, larbdev);
> +
>         iommu_group_remove_device(dev);
>         iommu_fwspec_free(dev);
>  }
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 2034d72..a7f22a2 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -423,7 +423,9 @@ static int mtk_iommu_add_device(struct device *dev)
>         struct of_phandle_iterator it;
>         struct mtk_iommu_data *data;
>         struct iommu_group *group;
> -       int err;
> +       struct device_link *link;
> +       struct device *larbdev;
> +       int err, larbid;
>
>         of_for_each_phandle(&it, err, dev->of_node, "iommus",
>                         "#iommu-cells", 0) {
> @@ -466,6 +468,14 @@ static int mtk_iommu_add_device(struct device *dev)
>                 return err;
>         }
>
> +       /* Link the consumer device with the smi-larb device(supplier) */
> +       larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
> +       larbdev = data->larb_imu[larbid].dev;
> +       link = device_link_add(dev, larbdev,
> +                              DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +       if (!link)
> +               dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> +
>         return iommu_device_link(&data->iommu, dev);
>  }
>
> @@ -473,6 +483,8 @@ static void mtk_iommu_remove_device(struct device *dev)
>  {
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>         struct mtk_iommu_data *data;
> +       struct device *larbdev;
> +       unsigned int larbid;
>
>         if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>                 return;
> @@ -480,6 +492,10 @@ static void mtk_iommu_remove_device(struct device *dev)
>         data = fwspec->iommu_priv;
>         iommu_device_unlink(&data->iommu, dev);
>
> +       larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
> +       larbdev = data->larb_imu[larbid].dev;
> +       device_link_remove(dev, larbdev);
> +
>         iommu_group_remove_device(dev);
>         iommu_fwspec_free(dev);
>  }
> --
> 1.9.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
