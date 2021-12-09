Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED5AC433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 16:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02EB8856C0;
	Thu,  9 Dec 2021 16:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4dVPiLQDB5sA; Thu,  9 Dec 2021 16:36:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D7C3E856B5;
	Thu,  9 Dec 2021 16:36:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0A6DC002F;
	Thu,  9 Dec 2021 16:36:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A067C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05FFB61ADE
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0rQRd0AMyBgH for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 16:36:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E10BF61AE5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:08 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 o19-20020a1c7513000000b0033a93202467so4548715wmc.2
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iI3azBWTRCFEeeRKyJXboLUDLxUqU0ShZoPCiSe0QHI=;
 b=IvslFsKP2cSAAyw81pK4hpkGOzTdSo/ctRvboBfXswKfysT5fU5LhL/9bRxSPuRWgL
 iBZHmyOuf9rQ3ILzAxwW6IBHw5NxZDxhUcTtbubGfDs+NS9kEWGeBug16SAcrC+ihzbP
 Y3NV2KEG6CbS3lZBJtG6eSob23mqkyF0FaClUFW8/vr9tbAJgmVFGqD9wjFdu9Wl+yIA
 3hDivw4Ft7xhzx9V2B2OYa9GYDE6KxbUjOC4Y6qvBD6wE6wigFf+MoZHwU0x06SElhur
 aGAHOZGlfXkirYozfV96mJpJ8ROZP5bUeGazugVqBgrCOBWWtYSbV9Q8+3+bnxK/uSY0
 mVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iI3azBWTRCFEeeRKyJXboLUDLxUqU0ShZoPCiSe0QHI=;
 b=2U4wFZVtmWuoNywAtUDM7eHztvl++IFGkVKOAnKhLWrPiRHTFfS7jjZttTTA9tr8tX
 BfwlvrKjjZexPXMDHv593TvjiSJajdIaMOjPTxuuGhYTVTOHnxOB5Fj+OuW8ERzZlBzM
 FEvhN670qqX2RJIbHMzFL4XGGLXxdHdESzJTUisXSpPSJPRoFhJmgVYKfkWRqsXCbUnh
 slSgbnKakt7vvdmNOD00JBrFutpkY77Je1dy78/ozswSL6MaQa8y4hV8IPRoANwyxSEO
 9g4jTkf9yzgwUwVQv+5KATc/FbMFi882+mXz/McQzn6/ByD2Vszdt5meMth9b8sxtCPc
 WZXQ==
X-Gm-Message-State: AOAM532fhyBSxpGHtZbnsMDAO6q1HrT+vZO1zXXxs67V7IR80uvY2nI5
 Sdk1LUhA5hYRysDEbDLw21w=
X-Google-Smtp-Source: ABdhPJy/sovjJ1DaI6y5oVUNi8kEueGlCXRc+ly7iHh3Okas8Ii3nmU4WWUlC+CLCxJuYru8/SPnpw==
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr8636459wmb.1.1639067766782;
 Thu, 09 Dec 2021 08:36:06 -0800 (PST)
Received: from localhost ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id r62sm284530wmr.35.2021.12.09.08.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Dec 2021 08:36:06 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: arm-smmu: Document nvidia,
 memory-controller property
Date: Thu,  9 Dec 2021 17:35:57 +0100
Message-Id: <20211209163600.609613-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

On NVIDIA SoC's the ARM SMMU needs to interact with the memory
controller in order to map memory clients to the corresponding stream
IDs. Document how the nvidia,memory-controller property can be used to
achieve this.

Note that this is a backwards-incompatible change that is, however,
necessary to ensure correctness. Without the new property, most of the
devices would still work but it is not guaranteed that all will.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- clarify why the new nvidia,memory-controller property is required

 .../devicetree/bindings/iommu/arm,smmu.yaml     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index f66a3effba73..e239157eb30c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -155,6 +155,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  nvidia,memory-controller:
+    description: |
+      A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
+      The memory controller needs to be programmed with a mapping of memory
+      client IDs to ARM SMMU stream IDs.
+
+      If this property is absent, the mapping programmed by early firmware
+      will be used and it is not guaranteed that IOMMU translations will be
+      enabled for any given device.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg
@@ -177,6 +188,12 @@ allOf:
         reg:
           minItems: 1
           maxItems: 2
+
+      # The reference to the memory controller is required to ensure that the
+      # memory client to stream ID mapping can be done synchronously with the
+      # IOMMU attachment.
+      required:
+        - nvidia,memory-controller
     else:
       properties:
         reg:
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
