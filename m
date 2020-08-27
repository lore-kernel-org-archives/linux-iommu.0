Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7010C433E1
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 12:41:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801642177B
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 12:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ULbIy0qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801642177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 19252203CC;
	Thu, 27 Aug 2020 12:41:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lUOVtcv6aYf4; Thu, 27 Aug 2020 12:41:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A9A4C203BD;
	Thu, 27 Aug 2020 12:41:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB16C07FF;
	Thu, 27 Aug 2020 12:41:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 876E7C0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 12:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6D85C882A4
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 12:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id efsuQ3NlT2Fd for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 12:40:58 +0000 (UTC)
X-Greylist: delayed 00:06:29 by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D01CF87C17
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598532048;
 bh=92IISck0Hh+QcjDct9i6ju3E7DbMlpwjZF7zW6G46Sc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ULbIy0qVoT9J9+KyT4sfnqF3giUbqeCjn8XeElSEHd7eBeRw7x7zFBkS7G+zuIq87
 do0WPQ5HMGv2aWQdoWuL0hWIGOH70KW8cfLhlX0PPCYBMpFxJj5L7IT6sv5xx9ZkaC
 daznPerFRO4CmNBMs7yxWnhHheWj4Vt+1XdQtCfA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.146.7] ([217.61.146.7]) by web-mail.gmx.net
 (3c-app-gmx-bap26.server.lan [172.19.172.96]) (via HTTP); Thu, 27 Aug 2020
 14:31:59 +0200
MIME-Version: 1.0
Message-ID: <trinity-d6be65d8-9086-42bc-b993-238b731cdf60-1598531519064@3c-app-gmx-bap26>
From: Frank Wunderlich <frank-w@public-files.de>
To: Robin Murphy <robin.murphy@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>
Subject: Aw: [PATCH 00/18] Convert arch/arm to use iommu-dma
Date: Thu, 27 Aug 2020 14:31:59 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <cover.1597931875.git.robin.murphy@arm.com>
References: <cover.1597931875.git.robin.murphy@arm.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:s+a4a7dJl6sfE8qr3afXfh3rFMEB0yoGDcQKLuHS4QzYWvUvvC45GFgO8lF9qXw9R52Wk
 DtakmHS+HD6cGoa1Zil3uW/U+yFS9kxTAT+z6AMI2xcYorqC2HXtzYuOCqJCgtLpQ+XE0cJjSFZx
 jxGxAyxNxltq5fYSEegUZWLgP9jut/anC9MQ4QvGWdC7Fx2DqQGzPbELk6qKjHDVZ/m5suQOG5WX
 iSa5xQ1TVnlfnQDl3zDcjq+ZYocRCeCF/YEHBWcp/6xTs4r2KnkcTO/1Z2Mnufc+NBr+EgqeLN3I
 Vw=
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQElSUIlpfY=:vUij2jls5W1ysng1ZKcuYY
 pFA9/COE8C5IP5zXbsqR0tZEkf5JrhrlDbvI2BMEOJ6oxT9KgBx7IU5RIhi5RepN9KFHPvNhj
 IIfUa0pzA4K8Cqtyclfom5UzYIoZ6uspvq776cJ+Q9/zccw8+9sk/apjzvFyD6zeJZg3xbzHw
 aFTgUWHrFUJuKDGrpUkbYu13xZkIoNIEGFpWfg75gh8clONNYRzVMZwNjJmCgghie9wfvr1wH
 ckfAsgTHUQaeibtKn1wyZlqsS0TO+mnWvDMtCftrzES0zdT+qdWXwa3fnmGdrVzkO7E+ItaXA
 WzxUfguZg1bn3Rv1gj9yzdT3+TXacGV2fTba4NTMqgCF20TFfBBnU3gIpenTmsL3TG5pfKoV/
 Xx+8jxWvCK+QDzEQv93lcBSOi21n5dJq+dhSX013SNJ2lc/2komy1wn/JMGWFn2ZJmCdrASp7
 Lq3kRFZiTj7haQaGeH1eYLzZLS43QGcnlyxutuM3BGSA/ffVay8/xeY+NklA0Q0kOaJOOVwPy
 fy61U+hWj/AGMtuViBdu6pmBVj4Wlc6zRRcqqU4CvUYlFx4t/+/rR1tHPOMe55p0Araqd1bRy
 Z24ykS7pgx+vE5NVeoWGecY1mMNm5Jmq2daZh+i7Mvqg4U3obrH4hfogSKml1e6ThPpT/aFSX
 u/pLG4Cl6ByK1d5d9Ni5yrNteBc15qmD9URzq9CWrQFvCrDzjZWs7anZ+WH/8GcJ5Hek=
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 thierry.reding@gmail.com, laurent.pinchart@ideasonboard.com, digetx@gmail.com,
 will@kernel.org, hch@lst.de, linux-samsung-soc@vger.kernel.org,
 magnus.damm@gmail.com, linux@armlinux.org.uk, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, agross@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, sw0312.kim@samsung.com,
 linux-kernel@vger.kernel.org, t-kristo@ti.com, kyungmin.park@samsung.com
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

Tested full series on bananapi r2 (mt7623/mt2701, 5.9-rc1 + hdmi-patches), works so far fbcon+x without issues

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
