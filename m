Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF4C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 12:12:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB85560F0F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 12:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB85560F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B26C583B46;
	Fri, 30 Jul 2021 12:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rcb8ILBB0j-K; Fri, 30 Jul 2021 12:12:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B33E483AFE;
	Fri, 30 Jul 2021 12:12:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF34C0010;
	Fri, 30 Jul 2021 12:12:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FBD2C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83DBF40100
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gmx.net
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZpNTbS8gNUER for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 12:12:34 +0000 (UTC)
X-Greylist: delayed 00:05:21 by SQLgrey-1.8.0
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 293D3400E4
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1627647151;
 bh=FOQ3kf7nC91N2pAcyJy+ukr7C27FR3nQ3DekDqj8uEI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BwfBFduF6D0KhhlfgDaUp01g0HkjA5sJKqG9/o7UxxM1dHvkRQQ7ympZwrUenYWZF
 FqiwLQsdQqZ0kOCamLUpmSccbA/IB4imeXiULi3NNK4gwXoENWjH7S5gjiuPCAlf4y
 Ef/uijcUn45dUI1s1IW8AKT0/8tm91FPYZx/xL/E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.200] ([217.61.152.200]) by web-mail.gmx.net
 (3c-app-gmx-bs05.server.lan [172.19.170.54]) (via HTTP); Fri, 30 Jul 2021
 14:06:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-166e2707-ca11-4d84-803f-43732de72e2b-1627646799181@3c-app-gmx-bs05>
From: Frank Wunderlich <frank-w@public-files.de>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Aw: [PATCH v7 00/12] Clean up "mediatek,larb"
Date: Fri, 30 Jul 2021 14:06:39 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210730025238.22456-1-yong.wu@mediatek.com>
References: <20210730025238.22456-1-yong.wu@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Ju8UvQ9aQQ211RZizAddcu/LK0Fbm40eWbtOgPOujam+ZiApQCh89ygqJKUfghzFx3Em+
 2gYhue+9Tw2MD6gxpnG7k1n49GwJ96zbYr1t0dKh0XNlowbze19Bdjyh25AQrFqjwwEBD5zmvd83
 mhgHUGlB8Ek/ujixS17y/tmLUcS6lj6J3JAEdYwCmEJOBtpSoiNFM3NNFkq6C1Kia0XV7mTPl8vn
 vIhfuilUuastgrBdB7uKylodyw+GkvQKNLmACZ0chLIvF4sg96dcRXaudTEuldb+NRZCXQ2lp6Fe
 X4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:FocZdZ2/dxE=:qelBGfmw/AT6Do157g+7E5
 e/z4AVleOe+1IT5a6HSyaKye2dO0v8lEBosVB3uCQ+jdRkD32u68258ryt7HmGnqsLYBMSxkp
 Vg8AaJO2/NBus5X4vUc/qjHuYJ8LvhtvdLorUQ3UIOEJNLNiRmK9yDT+XRIMQzwWRv9yQnlYw
 Upz7w3Q5g3ho0GfQQFEmb68zjmxhbSguF0WSxl0lpAPHvFIwnsPkorozK/aVV/KX7BMDSD66b
 XuCnq7oD1Nubj43zbLsNZZCqv9QBtyTpLBbgRMqto0uIr2E/kl8CdTkb3aB2vxIn9EFa5Uicd
 SVKmnSxnqQx+da6ssc4CtCRrsolj2KPdYAOk8+bvGuEWCbr2q/6XyTfYcQXzUKVq9AgADeE4S
 V0aYfUXkaO1U476m6CGTGY8UgMpX8XiarQjrWXmrzHhp5zI/Zu6z/apbZJrYVmsVhgDazkmCY
 3KwRoxlYF9hIXV8UijNlPfxUXWJvViyq1of0Y8FfmnAUZq4/p1ncN82317RooXsGLa+J3dZ6N
 0SndvXxmeUy7iBco0YcKFzA4L3ETLAkl9AOFSIspJq6K2whO8vyd4I6ooGzQy8yD5cG2SVcj6
 RlyLjV66erHpMyF/v7hC0L/c5CdZuSS0NrsnLh73/XhFlcVdEqpKuUmiu/W0fxASQadwJc5tT
 QjBMrTXyHAvAPOAQLRkIAVptYQbOMAb+HTlX2AId/duxMX+TEPomHkWZKLrwja8dWKg1VKzN5
 Mp41TpSicnxIC4kFvPO10+Jk9dsn5b42A9cQhreUjA3jQvdgEVoaFxAH9lK5J+RJ6m60QAjjL
 h0bwUZBvhKHlfxZZJXSQQVFh40jESkMjtObYGrb5kwDzGYQgwU=
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

Full Series tested on BPI-R2/MT7623

Tested-By: Frank Wunderlich <frank-w@public-files.de>

regards Frank
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
