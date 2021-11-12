Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2F3C43217
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 13:12:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDEC6102A
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 13:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DDEC6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD19D6060D;
	Fri, 12 Nov 2021 13:12:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GqWn4Z4bfFki; Fri, 12 Nov 2021 13:12:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D02666063F;
	Fri, 12 Nov 2021 13:12:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7540DC0032;
	Fri, 12 Nov 2021 13:12:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 704D4C0012
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63F186060D
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a_Lfz6wzgk_j for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 13:12:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA2736063F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:41 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id d24so15520400wra.0
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 05:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=30OwVGxUy40t+1ZulyfICuuL3SNGXPyxdBoyAE95czg=;
 b=YSl3Vw5r2ILfv9Lot0EbCgdgIT+huk0RU+o8Oa9IK+u6PKR2Lyp73TbIR2pE6QJyDB
 hSKBfsO0nfDyMNwQZbl5AcI3qpJ6Jn086dxGqZL1ccKMXZUlI+hditFp11VfRq5Y/Cps
 mB7STmUiTskjXiCaMkvRZjQs5a9PzChrsK568cq/um+YEy1DAO4pb6iKajtxg1wMdzBn
 eaHHHPBPy4e3XncPYw8ivtkb5Xk+TcEkiGJ3hTq0dgoMmDtwhmRzgWT5OhJnqlbnGRaU
 ID/j3QjumPGu7YvlBq1geGcQ4WzVeqhZyCLMMW24lbhlDWhLNxuC9pPPAhsHizic6xI0
 04vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=30OwVGxUy40t+1ZulyfICuuL3SNGXPyxdBoyAE95czg=;
 b=lguELNro3vkPH/vptjJH2FpgcILyyaR0FnvTSL7fBl+HVtaxNrpKrKen6k77W/Vphn
 m2YVdI8doJK/QjtfbfqAFu67dFXDFUcu0/qHULn/dH8p3g8U77ZjkzXpvfBNhRsED4+r
 KUXi4h31kIrQB1RstIfjQ4L4sZILmjKwrk9IuWOrTyfXfROIx4q8Nv+JOHibhHJ/xKHk
 9r9Fo14dWyhwoFVfo+6LKjc93NOFaCTHsEIkrvb5Ks1antgoq+wZgSF4tx9LVQaIsn5H
 EVsm8hZvJxb/LTZP7YQD39CBiSWGFHYgcVeYB+QrsccOCs01zrbDyufTzX3XmijeOGrX
 Oehg==
X-Gm-Message-State: AOAM533qCj2wpRdnINCbAkRwicVGC59d+inOrnj1wmgdfxYjIN46adcA
 /BsQuhcxx3eQVdX9ezlwobc=
X-Google-Smtp-Source: ABdhPJywqmqY0nIe7O7aYkY30dDm1/rkkFXIkJBhzsUDjoLWFwd8Ga9BDfrqfLD2rCzfrK8nQkVVrw==
X-Received: by 2002:a5d:6d0b:: with SMTP id e11mr18874906wrq.16.1636722760058; 
 Fri, 12 Nov 2021 05:12:40 -0800 (PST)
Received: from localhost ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id o2sm5931682wrg.1.2021.11.12.05.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Nov 2021 05:12:39 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/4] dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
Date: Fri, 12 Nov 2021 14:12:29 +0100
Message-Id: <20211112131231.3683098-3-thierry.reding@gmail.com>
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

The NVIDIA Tegra234 SoC comes with one single-instance ARM SMMU used by
isochronous memory clients and two dual-instance ARM SMMUs used by non-
isochronous memory clients.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index cf32a7955475..21d293a2dadd 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -60,6 +60,7 @@ properties:
           for improved performance.
         items:
           - enum:
+              - nvidia,tegra234-smmu
               - nvidia,tegra194-smmu
               - nvidia,tegra186-smmu
           - const: nvidia,smmu-500
@@ -176,8 +177,9 @@ allOf:
         compatible:
           contains:
             enum:
-              - nvidia,tegra194-smmu
               - nvidia,tegra186-smmu
+              - nvidia,tegra194-smmu
+              - nvidia,tegra234-smmu
     then:
       properties:
         reg:
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
