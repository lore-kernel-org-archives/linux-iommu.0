Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD81C43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 12:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9261983E32;
	Wed, 15 Jun 2022 12:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SJGt93hqQpPk; Wed, 15 Jun 2022 12:16:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6717182E19;
	Wed, 15 Jun 2022 12:16:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B4B4C0032;
	Wed, 15 Jun 2022 12:16:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C3D3C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B99F82EBA
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dh_DiN6tACRt for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 12:16:22 +0000 (UTC)
X-Greylist: delayed 00:05:09 by SQLgrey-1.8.0
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 29DF982E19
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1655295380;
 bh=ezOnlosGKAAydv3zO7jEy12Plio79ZRPNcLr5oCfANk=;
 h=X-UI-Sender-Class:From:To:Subject:Date;
 b=Ys3c+7GHto2Ru2oL3QlQnA3wjf5gNh4Qe4p4VLMRtmrxXtGcmUlePwyUajokUI1le
 rEO6jpEwXWL1JYG53rQeXRO2vP48qG1YtooUXG0f5pv2WOxmIl8YH3voosJECZHxDP
 A3UO01jNpvV44Gl0UiL9c9ktEvveVh81e/m00s5A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.5] ([217.61.154.5]) by web-mail.gmx.net
 (3c-app-gmx-bap28.server.lan [172.19.172.98]) (via HTTP); Wed, 15 Jun 2022
 14:11:01 +0200
MIME-Version: 1.0
Message-ID: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28>
From: Frank Wunderlich <frank-w@public-files.de>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Robin
 Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Subject: helping with remapping vmem for dma
Date: Wed, 15 Jun 2022 14:11:01 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:prJPJkK3LsA2dyv/B4CgBXInvxwhazHL2+i4NT5HILEb0X3vFX2cw2FHYhNF3WSJuZ6Dh
 jhmKjare/8EgAott0Sca5YAcM35WB3vvDVwE2cfCmpzzTqusTiZ8Zq6eDILWAG17d/5G/fsnZ586
 I8jgOiDFMu6lr/hfrSGxg4/f5ZKAMzmBzODiFRIN5igr7MtzHmHpB68fiJL+gz+YfHZ6guHCqJCt
 DeIXT4zSWnkGfa+akDLPrXRo96raafEoUrhBhKIqJQctZiu4ENZZ0BNQLtNjc8xroQHqEW+1ONgF
 tg=
X-UI-Out-Filterresults: notjunk:1;V03:K0:AyD6qfhZxuE=:zh1nGAcajto/CrYXacCFMq
 0FAUrxsD2lJWLbYjvK/h54D/d8S+EViePAC7PjPnj8kWFQ2favOknz2dAW+IdO4affPKtSwny
 DriQqEHtdC7/bBgFvMav3yYYHOIYyvSHrT3o/XTMJfFK38duYR14mHRmVdjoANKm5nTzSs9Oj
 T2c6vsuJ/1zmXgt25njbIHs1rlvqqMwO9044+Ae8UAl543EcK8JOC5oiGakhz6fxYF53z29GM
 INCElMZxRVQsDxGMLMcy7OGaNI7k3H9iFUHEAMNd+uuVddBaDfvipINEfQks8vHDiWHctn/cY
 0Nti7qXy2K8/m0Fgob6YOGAPtiNUfWpcy8Ul4CMuWJeK+I1jOCXAcNyqU4EZ+2wqq+iYKEos+
 oJqPZepfVHQWdMd3aBt/bJwYwA5xkBOSV8Vy7U2Za1OXrihDnOb5MFIY4eIPNqRK2NTbds1kM
 UpngSLU3Kf9eu0ISyJYTO+QtDn+xi7EX5CpH+7e/mUbFDYMTpkWDi2yv3A0uM61BHGSsW7o5L
 0+W0kM72xmu6Gybx9LAlCA9PUXk7lwJqtRJZqVQn+38MNFaWqSqXqqCbhYp8GdizkPGP7pe3s
 dDTknUZ61f2JVa8Xx8StyDf9SGIDo8RdQ6Ad7JBS4VVSY6NJhlJ2QeGx1OuclEyua/cxia2sT
 Hz7azzv/JoVstEZ0OlH/MSR3XNUuJcWtcKqLpFvziYOWEBuB09YHxotvhaox32VduT2caJ/t7
 PpNaFfpbsQ6tzHoxDnYHg5vQJsLlx8WeO5fMDKAxLNWTL6WM1NJN62FIpn8CVM60Yf3ifhOLz
 Dp2zr2l
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

Hi,

i have upported a wifi-driver (mt6625l for armhf) for some time and fall now (at least 5.18) in the
"rejecting DMA map of vmalloc memory" error [1].

maybe anybody here can guide me on how to nail it down and maybe fix it.

as far as i have debugged it, it uses dma_map_single [2] to get dma memory from a previous
allocated memory region.

this function "kalDevPortRead" in [2] is used via macro HAL_PORT_RD [3] (used in HAL_READ_RX_PORT
and HAL_READ_INTR_STATUS in same hal.h file)

HAL_READ_INTR_STATUS is always called with an empty int array as buf which i guess is not the problem.
I think the issue is using the use with an preallocated prSDIOCtrl struct (have not completely traced
it back where it is allocated).

calls of HAL_PORT_RD/HAL_READ_RX_PORT are in nic{,_rx}.c (with sdio-struct) ([4] as example)

maybe there is a simple way to get an address in preallocated memory as replacement for the dma_map_simple call (and the unmap of course).

regards Frank

[1] https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L327
[2] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/os/linux/hif/ahb/ahb.c#L940
[3] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/include/nic/hal.h#L176
[4] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/nic/nic_rx.c#L3604
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
