Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF85C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 03:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37871831F1;
	Wed, 25 May 2022 03:05:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pg82vCYBF-sE; Wed, 25 May 2022 03:05:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 17A3682CCB;
	Wed, 25 May 2022 03:05:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFE11C0039;
	Wed, 25 May 2022 03:05:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF59C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B17F41A2C
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o8Ms8Z7f-ywk for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:06:56 +0000 (UTC)
X-Greylist: delayed 00:34:22 by SQLgrey-1.8.0
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1516.securemx.jp
 [210.130.202.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6398A41825
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:06:56 +0000 (UTC)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 24P1Wdmb008710;
 Wed, 25 May 2022 10:32:39 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 24P1W7TH006843;
 Wed, 25 May 2022 10:32:07 +0900
X-Iguazu-Qid: 34trSfAbwEbMEl4JJC
X-Iguazu-QSIG: v=2; s=0; t=1653442327; q=34trSfAbwEbMEl4JJC;
 m=Qsis1jZV/htQxCw0i55V7ARuLBOxVBW6EAOFcn4Oy/w=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
 by relay.securemx.jp (mx-mr1511) id 24P1W6AE039192
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 May 2022 10:32:06 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/3] MAINTAINERS: Add entries for Toshiba Visconti5 IOMMU
Date: Wed, 25 May 2022 10:31:47 +0900
X-TSB-HOP2: ON
Message-Id: <20220525013147.2215355-4-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 May 2022 03:05:51 +0000
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org
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

Add entries for Toshiba Visconti5 IOMMU (ATU) binding and driver.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f4f4ba84c2e..a43023844c87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2897,6 +2897,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
 F:	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
+F:	Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
@@ -2904,6 +2905,7 @@ F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/clk/visconti/
+F:	drivers/iommu/visconti-atu.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
 F:	drivers/gpio/gpio-visconti.c
 F:	drivers/pci/controller/dwc/pcie-visconti.c
-- 
2.36.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
