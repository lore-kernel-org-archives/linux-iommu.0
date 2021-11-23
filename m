Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6739C433FE
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 11:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5710E4025E;
	Tue, 23 Nov 2021 11:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N2NcNVA8MSjV; Tue, 23 Nov 2021 11:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 021FB4025C;
	Tue, 23 Nov 2021 11:21:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAFA8C002E;
	Tue, 23 Nov 2021 11:21:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F05D7C0036
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC148606F1
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ol6-mnXcM34F for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:21:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A20D6065D
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:18 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 n15-20020a17090a160f00b001a75089daa3so1842606pja.1
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mq8nc34v9wy9BHUcdNCchv5TcJtzwaMW4yDN1UOKTXs=;
 b=JpDT/+FDBCbI5IBaWeaKfzyOwUUOyTt+Vw1ovqm0zuzKZZrjqWO3dJqGL1pzmsZRcz
 WEzphSwzny6i8imySPh8owk0bZ7mV09ROF7m2cIZELwxwLD3zWFbiIveEf0Sy/YacdFK
 n/sQubJ/NkmPIgp5pbeN1xtI08xQWQungcwqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mq8nc34v9wy9BHUcdNCchv5TcJtzwaMW4yDN1UOKTXs=;
 b=hoRk6Pf2EX0BllzVgZHLhZqAliROmXgas8NQA9xNw9xC4x5D6iNFn0KEi032CLdGZX
 IUmcGr5by5ST5Gb3POvnu7SraVo0g37X9s++hG1Pz/2+Tly6j3CbR1Cyez5Ob4tKn98i
 RkoPfLscGm/CathTBj64OWqbEjCCTeo5Gt3V4YhSqekqTSEVEHBB9UqVEIrEuvWGanGx
 EBaNvjmNhxGlkMb/IC34L7dnzK3Q6Ml990tTv3wpMvWWT6QvW2aSrx6eFbE4BIOSgPHO
 46jUD2MUmMqZTMcATAB4i/YjUkBAe/vXHXgVJLmJb9ZkxOk9k9oiPGRwtwqoI2PCx/3C
 XbGA==
X-Gm-Message-State: AOAM532Jg7YyB0a4c+7Pqfi3ZOFRu4Vn7U/niPpCGurZm9HSx+y6tnGr
 nxaq4DMuP37Sqgn0KXrBCO4kRw==
X-Google-Smtp-Source: ABdhPJxp5J8vQC13ZWDo2EQlaskUNOPku9PaqV5etdp5QIpELJ9fUxb88Pk4hXN6hRe8tLOckb6fGg==
X-Received: by 2002:a17:902:7d96:b0:142:87dc:7dd3 with SMTP id
 a22-20020a1709027d9600b0014287dc7dd3mr5260273plm.11.1637666477920; 
 Tue, 23 Nov 2021 03:21:17 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:d1ae:c331:ed2a:15e9])
 by smtp.gmail.com with ESMTPSA id 63sm11093914pfz.119.2021.11.23.03.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 03:21:17 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 3/3] arm64: dts: mt8183: use restricted swiotlb for scp mem
Date: Tue, 23 Nov 2021 19:21:04 +0800
Message-Id: <20211123112104.3530135-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211123112104.3530135-1-hsinyi@chromium.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org>
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

Use restricted-dma-pool for mtk_scp's reserved memory. And set the
io-tlb-segsize to 4096 since the driver needs at least 2560 slabs to
allocate memory.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 94c13c45919445..de94b2fd7f33e7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -109,9 +109,9 @@ reserved_memory: reserved-memory {
 		ranges;
 
 		scp_mem_reserved: scp_mem_region {
-			compatible = "shared-dma-pool";
+			compatible = "restricted-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
-			no-map;
+			io-tlb-segsize = <4096>;
 		};
 	};
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
