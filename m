Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A99C4167E
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 06:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3D3C408CD;
	Tue,  3 May 2022 06:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p7t82zn9uCYc; Tue,  3 May 2022 06:30:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 73097410DB;
	Tue,  3 May 2022 06:30:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7D7CC007F;
	Tue,  3 May 2022 06:30:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAFC2C0032
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0C8A410DB
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfLabPzf5n89 for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 06:30:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0135408CD
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:35 +0000 (UTC)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de
 [87.154.217.136])
 by soltyk.jannau.net (Postfix) with ESMTPSA id 74B0B26E9B3;
 Tue,  3 May 2022 08:23:02 +0200 (CEST)
From: Janne Grunau <j@jannau.net>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/4] dt-bindings: iommu: dart: add t6000 compatible
Date: Tue,  3 May 2022 08:22:58 +0200
Message-Id: <20220503062301.20872-2-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503062301.20872-1-j@jannau.net>
References: <20220503062301.20872-1-j@jannau.net>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

From: Sven Peter <sven@svenpeter.dev>

The M1 Max/Pro SoCs come with a new DART variant that is incompatible with
the previous one. Add a new compatible for those.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Acked-by: Rob Herring <robh@kernel.org>

---
v2 changes:
 - added Rob's Acked-by:
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 82ad669feef7..06af2bacbe97 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -22,7 +22,9 @@ description: |+
 
 properties:
   compatible:
-    const: apple,t8103-dart
+    enum:
+      - apple,t8103-dart
+      - apple,t6000-dart
 
   reg:
     maxItems: 1
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
