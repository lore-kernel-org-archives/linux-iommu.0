Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27BCC433FE
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 13:12:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FF060EFE
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 13:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57FF060EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31B3981B98;
	Fri, 12 Nov 2021 13:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ittVc-wo5aMb; Fri, 12 Nov 2021 13:12:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 28A3280ECF;
	Fri, 12 Nov 2021 13:12:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB92C001E;
	Fri, 12 Nov 2021 13:12:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0D82C0012
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83F2D81BF5
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aQklaRR1pv2s for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 13:12:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 012AE81765
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:38 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id u18so15441208wrg.5
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 05:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5BQCyeoftBnqluexlQFqNbj0sfJJp2rC7QMu3C6I4Zg=;
 b=O1/AgrCk+PAkiYDIhOZArF//i2H+vPoki07JngSt9fvDUEs8ThN9b9qg/7Tn9d21dp
 9T7CTcxvuVB8YVg9P7bQa1/+jHwvPVcOyYEL4KXMtDgc98P+ZAlfQRJAwI/kvPOumtvs
 OBRRHT1MO3elSIcyIsr+iW7Ze44hLyWydY1Z6lyshshP7yqm3GI1qUMMvNkzNDbFUP31
 cWTjO83fzF/AG82eUIVVziB/FF/cQQCjTHn2mcm8WspkPZV0agOM8E6UlP9x4WqqXygA
 QnE+6aMrDASh2FMthqYYZ1tbJu0nXW+OObKhqqvUQMpI99+W7DlKZ23EwIpmV4+WOeCZ
 8Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5BQCyeoftBnqluexlQFqNbj0sfJJp2rC7QMu3C6I4Zg=;
 b=lVL38rF/VKmYzWF+/y/5xI3Zhg4A5mA3SIAvAgdbOidKf/pgFHWKu6DMAajIIdyKyt
 tzHKFrLhF7ZcqNVgZ6Mefev0FOmPQE6rpOOBiCLy3EXXQgtePo7jBY1KoHDJHIzQDFW8
 IWdJi0bHksbLRZhurg22zYU+UD0zcp7E0yhbwmtyTyG+Mf3I02uQMUUGIilthER0YFaF
 nNHA0VW89xuMvkm0dnw3IIGmsFzi+D4PkAH2KAKOTlMr91MMzpK1M6coewkTAgjSn5ra
 n5P52Ct2oqen7SMpEVDYQi5Newb2XJOJmQl0XWZK+UaEPTym9CnHRHQWg4GMnrJmsjxI
 cLgA==
X-Gm-Message-State: AOAM530WoFbwpzz93oTcHfGOlL0StRZXBIc0BoouvXWUroIe1WzFesfy
 mZhXpbPLGH+JgnfyIPJa/LY=
X-Google-Smtp-Source: ABdhPJzXGvINEjdyWWMM4YRPaSpE8bNuSD+Uq5vsHP8/CjX9uKFv1EsCovA9Wf4X2IHkhGEaYgKzeg==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr17906538wrs.437.1636722757281; 
 Fri, 12 Nov 2021 05:12:37 -0800 (PST)
Received: from localhost ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id h18sm6276740wre.46.2021.11.12.05.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Nov 2021 05:12:36 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/4] dt-bindings: arm-smmu: Document nvidia,
 memory-controller property
Date: Fri, 12 Nov 2021 14:12:28 +0100
Message-Id: <20211112131231.3683098-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112131231.3683098-1-thierry.reding@gmail.com>
References: <20211112131231.3683098-1-thierry.reding@gmail.com>
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

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index f66a3effba73..cf32a7955475 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -155,6 +155,12 @@ properties:
   power-domains:
     maxItems: 1
 
+  nvidia,memory-controller:
+    description: A phandle to the memory controller on NVIDIA Tegra186
+      and later SoCs. The memory controller needs to be programmed with
+      a mapping of memory client IDs to ARM SMMU stream IDs.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg
@@ -177,6 +183,9 @@ allOf:
         reg:
           minItems: 1
           maxItems: 2
+
+      required:
+        - nvidia,memory-controller
     else:
       properties:
         reg:
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
