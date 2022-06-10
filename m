Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D5EC433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 10:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A29FA419C2;
	Fri, 10 Jun 2022 10:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3w-DQ4mn6rr3; Fri, 10 Jun 2022 10:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2DD9B41A5A;
	Fri, 10 Jun 2022 10:15:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0B54C0032;
	Fri, 10 Jun 2022 10:15:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C2F5C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 10:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C54041A5A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 10:15:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5GmUt47DhqUm for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 10:15:12 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE58D419C2
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 10:15:11 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:6907:80d7:a5b:48f8])
 by xavier.telenet-ops.be with bizsmtp
 id hNA52700Z35NJNs01NA5zX; Fri, 10 Jun 2022 12:10:08 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1nzbaf-003RO3-4G; Fri, 10 Jun 2022 12:10:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1nzbae-00BJvU-J6; Fri, 10 Jun 2022 12:10:04 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2] dt-bindings: iommu: renesas,
 ipmmu-vmsa: R-Car V3U is R-Car Gen4
Date: Fri, 10 Jun 2022 12:10:03 +0200
Message-Id: <36400fe2cc6b6dcc0d6984fb77338d4d163e84dc.1654855711.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
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

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family.  Hence move its compatible value to the R-Car Gen4 section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2:
  - Add Acked-by, Reviewed-by,
  - Add blank lines to improve readability.
---
 .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml       | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index 8854569ca3a6c949..26d0a5121f02a153 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -29,6 +29,7 @@ properties:
               - renesas,ipmmu-r8a7793  # R-Car M2-N
               - renesas,ipmmu-r8a7794  # R-Car E2
           - const: renesas,ipmmu-vmsa  # R-Mobile APE6 or R-Car Gen2 or RZ/G1
+
       - items:
           - enum:
               - renesas,ipmmu-r8a774a1 # RZ/G2M
@@ -43,10 +44,11 @@ properties:
               - renesas,ipmmu-r8a77980 # R-Car V3H
               - renesas,ipmmu-r8a77990 # R-Car E3
               - renesas,ipmmu-r8a77995 # R-Car D3
-              - renesas,ipmmu-r8a779a0 # R-Car V3U
+
       - items:
           - enum:
-              - renesas,ipmmu-r8a779f0 # R-Car S4-8
+              - renesas,ipmmu-r8a779a0           # R-Car V3U
+              - renesas,ipmmu-r8a779f0           # R-Car S4-8
           - const: renesas,rcar-gen4-ipmmu-vmsa  # R-Car Gen4
 
   reg:
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
