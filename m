Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5FEC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 09:05:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A25611AC
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 09:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A25611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F40A83BE0;
	Wed, 14 Jul 2021 09:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wSlbqIHHXgG0; Wed, 14 Jul 2021 09:05:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3BC5A83B80;
	Wed, 14 Jul 2021 09:05:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 187FCC0010;
	Wed, 14 Jul 2021 09:05:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B7E6C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 09:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69F1A4054A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 09:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gmx.net
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o384xt0VYdvw for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 09:05:09 +0000 (UTC)
X-Greylist: delayed 00:05:20 by SQLgrey-1.8.0
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FBB240585
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1626253504;
 bh=2PfUJGsN5axf79lyK53KIfWRTeJoSiAoNWHeXAJAm5k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hFlZ9zXRKnNbdJOq8h/n/gLd2cdrhQ2L2Pwy31esU4kquqJ7yEslTvg4VwZsGuURu
 nOKmyeLVBszXEbM+wL6yDlq2NDGDJLi9i1pdqZ6TXnjhu/JY9cC/l4pirc1trxEhWN
 I2DfqKP8yo67Vx2rAm3pPZwt7+JIZtr6GMdJnKJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.136] ([217.61.152.136]) by web-mail.gmx.net
 (3c-app-gmx-bs01.server.lan [172.19.170.50]) (via HTTP); Wed, 14 Jul 2021
 10:59:18 +0200
MIME-Version: 1.0
Message-ID: <trinity-7d9ebdc9-4849-4d93-bfb5-429dcb4ee449-1626253158870@3c-app-gmx-bs01>
From: Frank Wunderlich <frank-w@public-files.de>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Aw: [PATCH v6 00/11] Clean up "mediatek,larb"
Date: Wed, 14 Jul 2021 10:59:18 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210714025626.5528-1-yong.wu@mediatek.com>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:41hJo/XYrZUHIeMDY07beGhJR05vkLxAQITh9O1JknXiCDIPb9AnREzqsqzHICRgoA4aX
 +VAlF3wwHQHbYa/GGCgJhTDtD0i0iZcray5tchmyODDSQBszTPJ8Cg9gg9LgxbFhLS4m04MCLN53
 ePdYFNXzAkr1Xvyf64zJFgpHrtCx3fhmT3LqyYxoT0nRDwTxV6UVaYlwijr3k0aNzY44Q9GNsnWw
 Rl3go4EBz7ULxN81eHdqgXx4wZX5M3IQyIamHA+xF+0G23a388+8tJIl3y+MV5whXMki3Iq+biLW
 UE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:q4SdFS9ZooI=:EASULLPsuk0ST92h5Xtvfk
 Jhco9PstXzKg11oRy4uTdr2xx83dTHAxk5Omr7i4+ZY6mOOD7tcjBWXmQaCSEgtK6fquM9IT3
 hXv4XotYxOcQexd6lUClbQux8vW4D1digaMT/BbScWQqCcoXHKkzlsV1lDSDDRR78wD1AcNdH
 XrgKtNwn9w0gQz4dSYuwgT5u4O67rnJbVIEZfMwVI2FBMnVyzG0EM7wNnJwmwZsvskRHsj4VS
 W++DUs+maUXMYjwDEHLDgvsm0LkulGr8bGvoTByeHxVYAG1zFAz3GYxxQhNMs06975P5+znYo
 0lNckpjd/3n8KBX7Ag4Mbpv/d0YxcW1fqPIbSgmuEVXsCMRKZaF5OwjrS4rEDAw95/cUPokzd
 rWsMktPFMSwHfzYrU/ekghZUZaUxKp2/z/bkDS1xIbrj/F+xKhU8otH6dmCQTDguxBAEz1vi9
 +Lt1saJjh2wWo0pUNdbA9wOdalG1UGrA74CQ5GR/VNWTxtGfIEtbySBLtcE+GyCfWm8D4hf93
 awxkLE5nMV9rsAdxaEQaHIlJkOAPlxqNGsoPbCqepF1Kt5vkVG0hc5fdpCPbv6x6wKKniaqsl
 bk2wxy/3o3A89mEF22jc/KcrWSMuKXRqgMtucvwzGASjqu89V/nO70SJauPemdNBeSKqw0B9Q
 fn/Lowm9cIhmuRzlAcBY9wNdZrsXOUTT6ZosXfCu6lkrnqii+QKYLIzLjDKgTtSPScKodjNTA
 bEaeK48TV3vDvOUefpb+aMqcNSUYAD7pKdg77jmFkOtNoRb0lOwE19OHhxhQzq9LhQCgGvawU
 Go5mGxmercOneoqsxAElwMmd+APSD2eFKkndx1s77M8no3uigg=
Cc: Xia Jiang <xia.jiang@mediatek.com>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, David Airlie <airlied@linux.ie>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Tiffany Lin <tiffany.lin@mediatek.com>,
 yi.kuo@mediatek.com, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 Mauro Carvalho Chehab <mchehab@kernel.org>, anan.sun@mediatek.com,
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

Hi,

sorry this (or the 2 depency-series) cause a NULL Pointer deref in iommu_group_remove_device on mt7623/bpi-r2

i wonder why on bootup a cleanup is run, but have no hint about this.

since "dts: mtk-mdp: remove mediatek, vpu property from primary MDP device" all is good, i guess problem comes up while removing larb with DT

this is backtrace

[    6.274465] PC is at iommu_group_remove_device+0x28/0x148
[    6.279877] LR is at iommu_release_device+0x4c/0x70

[    6.674347] Backtrace:
[    6.676797] [<c0c9c37c>] (iommu_group_remove_device) from [<c06bf028>] (iomm)
[    6.686221]  r7:00000000 r6:c06bf04c r5:c0d7a1ac r4:c21fc010
[    6.691883] [<c06befdc>] (iommu_release_device) from [<c06bf064>] (remove_io)
[    6.700689]  r5:00000000 r4:00000000
[    6.704265] [<c06bf04c>] (remove_iommu_group) from [<c0733434>] (bus_for_eac)
[    6.712725] [<c07333ac>] (bus_for_each_dev) from [<c06bf658>] (bus_set_iommu)
[    6.720753]  r6:c331f440 r5:c1406f58 r4:ffffffea
[    6.725370] [<c06bf5a0>] (bus_set_iommu) from [<c06c1e88>] (mtk_iommu_probe+)
[    6.733484]  r7:c32db0b8 r6:c21f9c00 r5:c331f1c0 r4:00000000
[    6.739145] [<c06c1bfc>] (mtk_iommu_probe) from [<c0738c14>] (platform_probe)
[    6.747176]  r10:c21f9c10 r9:c2496f54 r8:c14623b8 r7:c14623b8 r6:c1405b90 r50
[    6.755012]  r4:00000000
[    6.757544] [<c0738ba8>] (platform_probe) from [<c0735968>] (really_probe.pa)
[    6.766006]  r7:c14623b8 r6:c1405b90 r5:00000000 r4:c21f9c10
[    6.771667] [<c07358a0>] (really_probe.part.0) from [<c0735cec>] (really_pro)
[    6.779866]  r7:c21f9c10 r6:c2549e74 r5:c1405b90 r4:c21f9c10
[    6.785527] [<c0735ca4>] (really_probe) from [<c0735de0>] (__driver_probe_de)
[    6.793984]  r5:c1405b90 r4:c21f9c10
[    6.797560] [<c0735d30>] (__driver_probe_device) from [<c0735fa0>] (driver_p)
[    6.806543]  r9:c2496f54 r8:00000008 r7:c21f9c10 r6:c2549e74 r5:c14c6ec8 r4:4
[    6.814291] [<c0735f5c>] (driver_probe_device) from [<c0736410>] (__device_a)
[    6.823448]  r9:c2496f54 r8:00000000 r7:c21f9c10 r6:c2549e74 r5:c1405b90 r4:1
[    6.831196] [<c073635c>] (__device_attach_driver) from [<c0733540>] (bus_for)
[    6.840007]  r7:c14623b8 r6:c073635c r5:c2549e74 r4:00000000
[    6.845669] [<c07334ac>] (bus_for_each_drv) from [<c07357e8>] (__device_atta)
[    6.854044]  r6:00000001 r5:c21f9c54 r4:c21f9c10
[    6.858662] [<c07356e4>] (__device_attach) from [<c073662c>] (device_initial)
[    6.867207]  r6:c21f9c10 r5:c1406f58 r4:c1406ca0
[    6.871825] [<c0736610>] (device_initial_probe) from [<c07346dc>] (bus_probe)
[    6.880454] [<c0734648>] (bus_probe_device) from [<c0734cc8>] (deferred_prob)


bisect shows this commit as breaking:

Author: Yong Wu <yong.wu@mediatek.com>
Date:   Wed Jul 14 10:56:17 2021 +0800

    iommu/mediatek: Add probe_defer for smi-larb

    Prepare for adding device_link.

regards Frank
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
