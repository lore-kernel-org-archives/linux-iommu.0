Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDCAC433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 15:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CD01418AF;
	Fri, 13 May 2022 15:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OcoC8H4xlHZU; Fri, 13 May 2022 15:14:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F40794186F;
	Fri, 13 May 2022 15:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CADB1C0032;
	Fri, 13 May 2022 15:14:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF1AFC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 15:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD0BE418A9
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 15:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z9cBjamHn6Gb for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 15:14:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C23A04186F
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 15:14:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 2336E1F461FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652454857;
 bh=eNQrmpvsqIQtwYolKiTtDiOp4ht3MwzuuikVm7BUBRA=;
 h=From:To:Cc:Subject:Date:From;
 b=ifTxDALRDsOUg2NBN8H0yqa1BCJr6hM2JSyW9QsFSEqpoBmIkPhzspDTJU52fDmwR
 aI0mPk84dcw4QaxXrYH5comEdHVP+s88W1MXFxjXAUwyb1SP/4OgAfXokT3MGNQJ30
 tin8aNAxuh8Bpi3SGqgNiRoFw0Ys1PYZzxVP6hABWEdFXypIAQYxBdaEoQ6d/1vWsW
 klt7wOLZb8KxcPhBdER+a7IJsYbPOdiyEzE7PysS4HvhFaeyKuUS/nrOAen1GlNzcf
 Jtcc5h+6oFeYhINPkhZyIdOvtGDqbjHHFHAW9vLH7mCeZuXWGKmeK4Q+2k0OG2CBj1
 NM6/52G3zNsGQ==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - M4U/IOMMU Support
Date: Fri, 13 May 2022 17:14:09 +0200
Message-Id: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, martin.botka@somainline.org,
 paul.bouchara@somainline.org, konrad.dybcio@somainline.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, marijn.suijten@somainline.org,
 phone-devel@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces support for the IOMMUs found on this SoC.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

AngeloGioacchino Del Regno (2):
  dt-bindings: mediatek: Add bindings for MT6795 M4U
  iommu: mtk_iommu: Add support for MT6795 Helio X10 M4Us

 .../bindings/iommu/mediatek,iommu.yaml        |  3 +
 drivers/iommu/mtk_iommu.c                     | 20 +++-
 include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
