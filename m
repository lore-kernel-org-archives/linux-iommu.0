Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998A0C433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 12:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E43A41519;
	Tue, 25 Jan 2022 12:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8139FeF1ajw; Tue, 25 Jan 2022 12:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2517D4148B;
	Tue, 25 Jan 2022 12:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2D9EC0031;
	Tue, 25 Jan 2022 12:56:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D74CFC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5BAA83F0F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 33OkTanKX7l4 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 12:56:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7862827C9
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:56:13 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; d="scan'208";a="108236321"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 25 Jan 2022 21:56:12 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id E935C4002631;
 Tue, 25 Jan 2022 21:56:11 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	will@kernel.org,
	robh+dt@kernel.org
Subject: [PATCH 1/2] dt-bindings: iommu: renesas,
 ipmmu-vmsa: add r8a779f0 support
Date: Tue, 25 Jan 2022 21:56:01 +0900
Message-Id: <20220125125602.4144793-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

Document the compatible values for the IPMMU-VMSA blocks in
the Renesas R-Car S4-8 (R8A779F0) SoC and R-Car Gen4.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index ce0c715205c6..5159a87f3fa7 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -44,6 +44,10 @@ properties:
               - renesas,ipmmu-r8a77990 # R-Car E3
               - renesas,ipmmu-r8a77995 # R-Car D3
               - renesas,ipmmu-r8a779a0 # R-Car V3U
+      - items:
+          - enum:
+              - renesas,ipmmu-r8a779f0 # R-Car S4-8
+          - const: renesas,rcar-gen4-ipmmu-vmsa  # R-Car Gen4
 
   reg:
     maxItems: 1
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
