Return-Path: <SRS0=Olas=7M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F32C433DF
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:20:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F612070E
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EQ/AeGy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F612070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3667220764;
	Sat, 30 May 2020 08:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6nL8OSQvOvz1; Sat, 30 May 2020 08:19:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9827A22179;
	Sat, 30 May 2020 08:19:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB8FC0863;
	Sat, 30 May 2020 08:19:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00FAFC016F
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EC0A787EA7
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dcPgfsJ4vt6F for <iommu@lists.linux-foundation.org>;
 Sat, 30 May 2020 08:19:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1304587E1F
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:19:55 +0000 (UTC)
X-UUID: de14d8edaccb421d9e132428fae02f70-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=UzfE6L+Q+N5T60qWBYKFvl/nWB8dnMHgO4HFEf6j0Lk=; 
 b=EQ/AeGy179Ew+/hKZOBs/oIb1tNjzQNd1dAKioPKcPdTY4A6ZhTV5Qftx+4OUTssOYtDOwju6HaYVANLy2vex0E16BVgTaQ4H5ppayeFIPbOKeVb/HGzv/fQfCP+hbFyjaGQ1KeMGT0YOTRbgeR9w2LT2hL/wa7nKlXWrJHZ7Nk=;
X-UUID: de14d8edaccb421d9e132428fae02f70-20200530
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 169133581; Sat, 30 May 2020 16:14:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:14:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:14:50 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 16/17] arm64: dts: mt8173: Separate mtk-vcodec-enc node
Date: Sat, 30 May 2020 16:10:17 +0800
Message-ID: <1590826218-23653-17-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
 Irui Wang <irui.wang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Evan Green <evgreen@chromium.org>, eizan@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, cui.zhang@mediatek.com,
 Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, chao.hao@mediatek.com,
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

From: Irui Wang <irui.wang@mediatek.com>

There are two separate hardware encoder blocks inside MT8173. Split
the current mtk-vcodec-enc node to match the hardware architecture.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 60 +++++++++++++++++---------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index fb21a6b..9fccbec 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1364,13 +1364,10 @@
 		};
 
 		vcodec_enc: vcodec@18002000 {
-			compatible = "mediatek,mt8173-vcodec-enc";
-			reg = <0 0x18002000 0 0x1000>,	/* VENC_SYS */
-			      <0 0x19002000 0 0x1000>;	/* VENC_LT_SYS */
-			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
-				     <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larb = <&larb3>,
-					<&larb5>;
+			compatible = "mediatek,mt8173-vcodec-avc-enc";
+			reg = <0 0x18002000 0 0x1000>;	/* VENC_SYS */
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larb = <&larb3>;
 			iommus = <&iommu M4U_PORT_VENC_RCPU>,
 				 <&iommu M4U_PORT_VENC_REC>,
 				 <&iommu M4U_PORT_VENC_BSDMA>,
@@ -1381,29 +1378,12 @@
 				 <&iommu M4U_PORT_VENC_REF_LUMA>,
 				 <&iommu M4U_PORT_VENC_REF_CHROMA>,
 				 <&iommu M4U_PORT_VENC_NBM_RDMA>,
-				 <&iommu M4U_PORT_VENC_NBM_WDMA>,
-				 <&iommu M4U_PORT_VENC_RCPU_SET2>,
-				 <&iommu M4U_PORT_VENC_REC_FRM_SET2>,
-				 <&iommu M4U_PORT_VENC_BSDMA_SET2>,
-				 <&iommu M4U_PORT_VENC_SV_COMA_SET2>,
-				 <&iommu M4U_PORT_VENC_RD_COMA_SET2>,
-				 <&iommu M4U_PORT_VENC_CUR_LUMA_SET2>,
-				 <&iommu M4U_PORT_VENC_CUR_CHROMA_SET2>,
-				 <&iommu M4U_PORT_VENC_REF_LUMA_SET2>,
-				 <&iommu M4U_PORT_VENC_REC_CHROMA_SET2>;
+				 <&iommu M4U_PORT_VENC_NBM_WDMA>;
 			mediatek,vpu = <&vpu>;
-			clocks = <&topckgen CLK_TOP_VENCPLL_D2>,
-				 <&topckgen CLK_TOP_VENC_SEL>,
-				 <&topckgen CLK_TOP_UNIVPLL1_D2>,
-				 <&topckgen CLK_TOP_VENC_LT_SEL>;
-			clock-names = "venc_sel_src",
-				      "venc_sel",
-				      "venc_lt_sel_src",
-				      "venc_lt_sel";
-			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
-					  <&topckgen CLK_TOP_VENC_LT_SEL>;
-			assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
-						 <&topckgen CLK_TOP_UNIVPLL1_D2>;
+			clocks = <&topckgen CLK_TOP_VENC_SEL>;
+			clock-names = "venc_sel";
+			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
 		};
 
 		jpegdec: jpegdec@18004000 {
@@ -1435,6 +1415,28 @@
 				 <&vencltsys CLK_VENCLT_CKE0>;
 			clock-names = "apb", "smi";
 		};
+
+		vcodec_enc_lt: vcodec@19002000 {
+			compatible = "mediatek,mt8173-vcodec-vp8-enc";
+			reg =  <0 0x19002000 0 0x1000>;	/* VENC_LT_SYS */
+			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_VENC_RCPU_SET2>,
+				 <&iommu M4U_PORT_VENC_REC_FRM_SET2>,
+				 <&iommu M4U_PORT_VENC_BSDMA_SET2>,
+				 <&iommu M4U_PORT_VENC_SV_COMA_SET2>,
+				 <&iommu M4U_PORT_VENC_RD_COMA_SET2>,
+				 <&iommu M4U_PORT_VENC_CUR_LUMA_SET2>,
+				 <&iommu M4U_PORT_VENC_CUR_CHROMA_SET2>,
+				 <&iommu M4U_PORT_VENC_REF_LUMA_SET2>,
+				 <&iommu M4U_PORT_VENC_REC_CHROMA_SET2>;
+			mediatek,larb = <&larb5>;
+			mediatek,vpu = <&vpu>;
+			clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
+			clock-names = "venc_lt_sel";
+			assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
+			assigned-clock-parents = <&topckgen
+						  CLK_TOP_VCODECPLL_370P5>;
+		};
 	};
 };
 
-- 
1.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
