Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A977C07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:24:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9830613B2
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9830613B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AB9482AF8;
	Wed, 14 Jul 2021 11:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P7Ka2BOW2FTf; Wed, 14 Jul 2021 11:24:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9AEF982C91;
	Wed, 14 Jul 2021 11:24:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53CC1C0010;
	Wed, 14 Jul 2021 11:24:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C822C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2964C6074B
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gmx.net
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWD9Xhb6eDyv for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:24:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1539606BE
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1626261811;
 bh=bRr42QOU3WxiGukaiKaQo9qQhX/uefmYG0L+VFBR0cY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MH7MDNZQYjkv/8bbwBkSy/dTHjnZEPLNjx58GhW9NiKHHaEhkZIBMgl+1jheOfYNx
 sjSLqyorceUCLaV+PPaVTyVLnTnuLOwvgbv9UIdtSSouT/ugGyPoD0cnAxEyO/tBby
 KIzRPQDofNHx0bvw8YjucC6+kgI+v0FtYHZpN/kY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.136] ([217.61.152.136]) by web-mail.gmx.net
 (3c-app-gmx-bs01.server.lan [172.19.170.50]) (via HTTP); Wed, 14 Jul 2021
 13:23:31 +0200
MIME-Version: 1.0
Message-ID: <trinity-345a7606-49c0-417a-b40a-5ff156332354-1626261811356@3c-app-gmx-bs01>
From: Frank Wunderlich <frank-w@public-files.de>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Aw: Re:  [PATCH v6 00/11] Clean up "mediatek,larb"
Date: Wed, 14 Jul 2021 13:23:31 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <1626261496.14352.16.camel@mhfsdcap03>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
 <trinity-7d9ebdc9-4849-4d93-bfb5-429dcb4ee449-1626253158870@3c-app-gmx-bs01>
 <1626261496.14352.16.camel@mhfsdcap03>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:C0a90b1taoG2cfcfP1pde1q2MNu5r1lIgwNvN5NXJS81Z6XyWAFZhMImid05bZKAZUc1Z
 fSbF+ihXoQ925TRhUh/2PryeQrkBTUM6JIUaLAvZhNfmBG35Ckp7hDn2PsC6SOkInfw03TSGwAnq
 QVkUFPFGffmEj3883aNhVDGijVAV0Dj7a1YKE2SJcV1ysSSD1b5nQ6xxg4LGX+ho7QSyvTaUSA5/
 VeO3HfkSU+3+B2YcXrhadx1ynHb86Y/11K6GLOIm5WEjhoUM5E0xij5biHeSELX8yOKYJratdjjD
 DA=
X-UI-Out-Filterresults: notjunk:1;V03:K0:DZIjrERjTx0=:zO1GGiDuxmWNpY4kEGNX+H
 Qsmf9C4I97mAD+wP1pU8z1eVgOesso/R5WsIidAM5D5eoNM9Jq9vra+7B0hV+BiXqHlm/N2U8
 AU3rTTheff7I21iXOz3ILBB3bGN35C3B0KptIb4TN1MAOKfCNobq+RN/zUswYDl0kZ4eUR9c0
 tQGm/bjLfNmBpNJHquyGdQvZYZNq2DH8QApwTchWdAEnpNcF+KOpKXpYjySgkTnaBYwVj27pW
 nDbtsU5XednjYl88TCAk3MdLCU/njHPVEi8eLjrm12TvLdsgmyoYJgQ3BqBfit76+TcdTzEaj
 8oSosUKEC17F7PKZVCu360ZGcAfd7x+mFySyONxorqV3I0Ge29/VKMmQCUx6U4tGyE/tedka0
 RX/CBC10tyIElacx5U7+9OoA+hRzKwTS9LRYmixBzk4cXG/5G4+j5ljnyn57NrDQp9fuMGkwH
 vk4taR0w6XvN8s45fZ+qBA/Vzfq/o2D5Jnk1CrTsYwZRGO7EH3DubSJEKxu8Q/SfXw+yPfXD2
 QcYHX3vFQ95LjF+yBhj7MDkk83UPCbZujqhgGuzFULXV9/KpR40RKpwh37QTl0x+I283hMmgo
 yZjPMs8hjkNCjgYaF3X/Y6tG+n2TFGBWh36cu9O5iTbFSEXYKv0BUaEKLtwxiEUfLEYqFZeP1
 RGJafeHCi3VQkh24Z0kvP/wCasLOFs3jsuq2je+vhXaEdZJ9NeCB9D3wVis0CVRxceZ/6F0z+
 aWWCGUHZw8ekZPLQRrauLJKsPcMo3Awj4mlBI3ggYs1VbVrpwEBT98jdeIMoiUs72pausS9ap
 BJ1DOYDL0HTAvkX8qv8ayhDVShLTwcji0NvCJczKYjZbdxnY7c=
Cc: Xia Jiang <xia.jiang@mediatek.com>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, David Airlie <airlied@linux.ie>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Tiffany Lin <tiffany.lin@mediatek.com>, yi.kuo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 acourbot@chromium.org, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

> Gesendet: Mittwoch, 14. Juli 2021 um 13:18 Uhr
> Von: "Yong Wu" <yong.wu@mediatek.com>
> Hi Frank,
>
> Thanks for your report. mt7623 use mtk_iommu_v1.c.
>
> I will try to reproduce this locally.

Hi,

as far as i have debugged it dev->iommu_group is NULL, so it crashes on first access (dev_info)

drivers/iommu/iommu.c:

 923 void iommu_group_remove_device(struct device *dev)
 924 {
 925 printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
 926     struct iommu_group *group = dev->iommu_group;
 927     struct group_device *tmp_device, *device = NULL;
 928
 929 printk(KERN_ALERT "DEBUG: Passed %s %d 0x%08x\n",__FUNCTION__,__LINE__,(unsigned int)group);
 930     dev_info(dev, "Removing from iommu group %d\n", group->id);


regards Frank
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
