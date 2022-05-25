Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29944C433FE
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 03:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2E7741A0E;
	Wed, 25 May 2022 03:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78xQaggzDcl2; Wed, 25 May 2022 03:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F578419B0;
	Wed, 25 May 2022 03:05:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50180C0086;
	Wed, 25 May 2022 03:05:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77859C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56C4A612AE
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:14:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fd-gRfFUR73 for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:14:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1115.securemx.jp
 [210.130.202.174])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 114ED612AA
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:14:00 +0000 (UTC)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 24P1WgCC012773;
 Wed, 25 May 2022 10:32:42 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 24P1W79U014816;
 Wed, 25 May 2022 10:32:07 +0900
X-Iguazu-Qid: 2wHHoRQqLZjpEs969Y
X-Iguazu-QSIG: v=2; s=0; t=1653442327; q=2wHHoRQqLZjpEs969Y;
 m=Xr7wfXU0P28tQrglBFUkXafUeWb8aRJHHN/nDBBqDyc=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
 by relay.securemx.jp (mx-mr1110) id 24P1W605016226
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 25 May 2022 10:32:06 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/3] iommu: bindings: Add binding documentation for Toshiba
 Visconti5 IOMMU device
Date: Wed, 25 May 2022 10:31:46 +0900
X-TSB-HOP2: ON
Message-Id: <20220525013147.2215355-3-nobuhiro1.iwamatsu@toshiba.co.jp>
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

Add documentation for the binding of Toshiba Visconti5 SoC's IOMMU.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../bindings/iommu/toshiba,visconti-atu.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml b/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
new file mode 100644
index 000000000000..af8d6688fa70
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/toshiba,visconti-atu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba ARM SoC Visconti5 IOMMU (ATU)
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description: |+
+  IOMMU (ATU) driver can bse used for Visconti5's multimedia IPs, such as
+  DCNN (Deep Convolutional Neural Network), VIIF(Video Input), VOIF(Video
+  output), and others.
+
+properties:
+  compatible:
+    const: toshiba,visconti-atu
+
+  reg:
+    maxItems: 1
+
+  "#iommu-cells":
+    const: 0
+
+  toshiba,max-entry:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The size of entry for address
+    enum:
+      - 16
+      - 32
+
+  toshiba,reserved-entry:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The reserve number of entry address.
+    default: 0
+    minimum: 0
+    maximum: 32
+
+required:
+  - compatible
+  - reg
+  - "#iommu-cells"
+  - toshiba,max-entry
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        atu_affine0: iommu@1400f000 {
+            compatible = "toshiba,visconti-atu";
+            reg = <0 0x1400F000 0 0x1000>;
+            toshiba,max-entry = <16>;
+            toshiba,reserved-entry = <1>;
+            #iommu-cells = <0>;
+        };
+    };
-- 
2.36.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
