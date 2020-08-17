Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96AAC433E4
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA73D2086A
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhMMGunm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA73D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 85A30857E2;
	Mon, 17 Aug 2020 07:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QpXOaGpOhnQp; Mon, 17 Aug 2020 07:50:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8B6685566;
	Mon, 17 Aug 2020 07:50:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1B20C07FF;
	Mon, 17 Aug 2020 07:50:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B84BC0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5A99D87CD4
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:50:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YWYs4DcHO6XW for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B3C2787E88
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de
 [95.90.213.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6C71A22CAD;
 Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597650620;
 bh=FiVFRusfj9DjxEECqrLRwnPwn3v/1jVkijJ8N2ump8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WhMMGunmpgK8vFWnOdTQ2I8t9MbghOejJRSb+BTP9jycrNykrJQP3kz4Br4sXCn0s
 4wwBV/Lx6SIIapFKypuni/Kbn41IlmBg7YFmeu7+n7UCekd4w/Oh6G6JMLRekvyPwg
 LRgUpuTisRQGkhsAJDrp8QBMM9mEU6AgEfstMrh4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1k7ZuM-00BfcU-FM; Mon, 17 Aug 2020 09:50:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 14/16] dt: add an spec for the Kirin36x0 SMMU
Date: Mon, 17 Aug 2020 09:50:13 +0200
Message-Id: <0fa3a11f63e68fdef3a8aa8d45f1df4d0832dcac.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 mauro.chehab@huawei.com
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

Describe the properties expected by the IOMMU driver used on
Hikey960 and Hikey970 boards.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../iommu/hisilicon,kirin36x0-smmu.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml b/Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml
new file mode 100644
index 000000000000..ec4c98faf3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/hisilicon,kirin36x0-smmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon support for HI3660/HI3670 SMMU
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+description: |+
+  Huawei's Hisilicon Kirin 3660/3670 contains a System MMU that enables
+  scattered physical memory chunks visible as a contiguous region to
+  DMA-capable peripheral devices like GPU and ISP.
+
+  The IOMMU domains are described via iommu_info settings.
+
+properties:
+  compatible:
+    const: hisilicon,hisi-smmu-lpae
+
+  iommu_info:
+    type: object
+
+    properties:
+      start-addr:
+        maxItems: 1
+        description: Memory start address (32 bits)
+
+      size:
+        maxItems: 1
+        description: size of the I/O MMU block (32 bits)
+
+      iova-align:
+        minItems: 2
+        maxItems: 2
+        description: DMA address alignment of the mapped memory (64 bits)
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    smmu_lpae {
+      compatible = "hisilicon,smmu-lpae";
+
+      iommu_info {
+        start-addr = <0x40000>;
+        size = <0xbffc0000>;
+        iova-align = <0x0 0x8000>;
+      };
+    };
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
