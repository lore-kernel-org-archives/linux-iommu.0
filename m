Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D882C433EF
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 11:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85B8780D37;
	Tue, 23 Nov 2021 11:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aiaUptxdQEcH; Tue, 23 Nov 2021 11:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DB6E80D06;
	Tue, 23 Nov 2021 11:21:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54C20C002E;
	Tue, 23 Nov 2021 11:21:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42BC3C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EAD880D14
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2gzZ8Y2Z8AC for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:21:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E266980D06
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:10 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id m24so16774420pls.10
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 03:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5/NUU473gHgJJWAHyz9icycAmdo+qfzcO9MMsTUYLCA=;
 b=Ka+/WtPAVKmsC47ebx/EttMPimSyaFaQsXvSwohDRgg53jo8emMNbvUMSjBffFZJiF
 6mmEV31XO/9nn98pDJV/kWkNmFi5luffIqiHkegaqh/MUKTubaMVlPLwa07SSu/o/XsD
 8ngdYw/RZqDR/Hmx12cSy0gEWVZ3Gd2d3Mktk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5/NUU473gHgJJWAHyz9icycAmdo+qfzcO9MMsTUYLCA=;
 b=st1sU/s6d/Zug8/gAnI0iRsRwt8ho4WL8mgSswsHDR1qvt3+gRe2KxiuwQz2ykbS5M
 m9qxtpgNsGk7fxxr5zctoD03ZiqSa2qwU5LdrSRb8kQu0z4HSigRoClG5Okoe2YuUeBd
 WgX1BQfBJjsHHB/mzpGG1V5xP5HN/GW6iKvUgitW+hYtocLGXKAcDNYOc+lGcRRLmTbq
 wGF+TiAPRkqXkkyLiXMQenBCWmI4iyx7ZMoMYXnwlwSv3ksL4jD6TR32kZjgMgSap/c8
 1bzfzuhmOnU/sbzVnwohiMw5PfAunFoEB6pJb/+vhTjL5Znc+mvcCahLW0c8QAEC8LkV
 XYXQ==
X-Gm-Message-State: AOAM532eaGzvYFDRKsLKsr16baCLWy06k+/G5licVyQ5KLlzEalgaLmd
 UNGk62cmgL1IUDJq7c7b0/dD8A==
X-Google-Smtp-Source: ABdhPJzZX7TeNDOF6tm1dgQN6UgDtm8Er0h77Xe7AqW6C2wdt/CMcVsKuhDG9eZ4EtpKo4xugVw3nw==
X-Received: by 2002:a17:902:e5ce:b0:142:780:78db with SMTP id
 u14-20020a170902e5ce00b00142078078dbmr5853227plf.12.1637666470227; 
 Tue, 23 Nov 2021 03:21:10 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:d1ae:c331:ed2a:15e9])
 by smtp.gmail.com with ESMTPSA id 63sm11093914pfz.119.2021.11.23.03.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 03:21:09 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
Date: Tue, 23 Nov 2021 19:21:01 +0800
Message-Id: <20211123112104.3530135-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
 linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Maxime Ripard <maxime@cerno.tech>,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Default IO_TLB_SEGSIZE (128) slabs may be not enough for some use cases.
This series adds support to customize io_tlb_segsize for each
restricted-dma-pool.

Example use case:

mtk-isp drivers[1] are controlled by mtk-scp[2] and allocate memory through
mtk-scp. In order to use the noncontiguous DMA API[3], we need to use
the swiotlb pool. mtk-scp needs to allocate memory with 2560 slabs.
mtk-isp drivers also needs to allocate memory with 200+ slabs. Both are
larger than the default IO_TLB_SEGSIZE (128) slabs.

[1] (not in upstream) https://patchwork.kernel.org/project/linux-media/cover/20190611035344.29814-1-jungo.lin@mediatek.com/
[2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/mtk_scp.c
[3] https://patchwork.kernel.org/project/linux-media/cover/20210909112430.61243-1-senozhatsky@chromium.org/

Hsin-Yi Wang (3):
  dma: swiotlb: Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
  dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
  arm64: dts: mt8183: use restricted swiotlb for scp mem

 .../reserved-memory/shared-dma-pool.yaml      |  8 +++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +--
 include/linux/swiotlb.h                       |  1 +
 kernel/dma/swiotlb.c                          | 34 ++++++++++++++-----
 4 files changed, 37 insertions(+), 10 deletions(-)

-- 
2.34.0.rc2.393.gf8c9666880-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
