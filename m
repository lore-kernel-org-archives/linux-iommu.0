Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF25C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 16:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEC73856BA;
	Thu,  9 Dec 2021 16:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UjbLfhaOZMcb; Thu,  9 Dec 2021 16:36:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3330856BE;
	Thu,  9 Dec 2021 16:36:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE6AFC002F;
	Thu,  9 Dec 2021 16:36:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F026BC006E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D057F61AE0
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2vjKqb1frLtV for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 16:36:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D2CC61ADD
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:36:10 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id q3so10693721wru.5
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=86gCcT11WeDFdl1AL6yEl0ohyQgOtx0+QoNrmaw2baI=;
 b=Ga+bX+MxQ2LlUWtzQpm7YKN+3EoZkJIPF4urBsxybQ3zUoQRKwiYd3HPGW2qx8L49P
 q/wwMfLlhTN/bDG/qODlTV3TjkwsPu9qZDLFv4Ov1BwPD/+eND9vumYd0P4o+EfPii6t
 EP1P2UFvGfJVvqTbDl125jewEungHH4bTxUx7ZmGM0/Huct4rHA/auNHvDJWz9hkbLQy
 arWvahGAMpWjEQ4GrSrtaitit0FgX2rsXuFEF7A6GxDXyy+MUCI17Q3HrPRIGthnWHdA
 7OK3WKyYh1tDp+1bTWv9YFPZf8gDgsZOJ6eJVxcDKNo0pQ9pCrso9BoCKbJGm5aFchh0
 RBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=86gCcT11WeDFdl1AL6yEl0ohyQgOtx0+QoNrmaw2baI=;
 b=RboopweeA1rwid8QYb2ouO4668BbBfR4wBv0W3yst28OS0/BmboItHG6sW7McriPwO
 IVKpotqbAEIO62GPgRMGjpk2nQMVKnLrZ0qgurspQ0kVwKWUu3G43FFe+pfJkJ/KiSx8
 oDrcuRi/OIlgsNW+tljKFwbY7BorsidAk1As1kw0QXdaMDDANwrt1RxJbLhCSOkIRUbV
 qJMqjwg3ekj8BHCUASk7wKNErMrWAp7bU7NoEM0kYvoSVBXknzO1o/b6Wo4O+l6Y4TkP
 2oDAPcKeTsjRIDQwSrCUMvU81Ob2gnk+vENbx6NIV0aIq6QOBZvtGo/89Ux1mlPgT4ij
 343A==
X-Gm-Message-State: AOAM531Z+iaVHKRnpDA9KTSOhBXe2mAkLy+1FMaJCGdeOqw3l1wVobFV
 nGqLrAsOLCEDw3zLvCDE9XE=
X-Google-Smtp-Source: ABdhPJzu/LQIurnEEcsBXxaEe6K46RBSx74oQ7BLemLuFcbFy7zSJ66BBZRQOEPAj2P6+XWrrayDTQ==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr7663352wrt.321.1639067769151; 
 Thu, 09 Dec 2021 08:36:09 -0800 (PST)
Received: from localhost ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id r15sm8899810wmh.13.2021.12.09.08.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Dec 2021 08:36:08 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
Date: Thu,  9 Dec 2021 17:35:58 +0100
Message-Id: <20211209163600.609613-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209163600.609613-1-thierry.reding@gmail.com>
References: <20211209163600.609613-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index e239157eb30c..7fd0522bcd84 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -60,8 +60,9 @@ properties:
           for improved performance.
         items:
           - enum:
-              - nvidia,tegra194-smmu
               - nvidia,tegra186-smmu
+              - nvidia,tegra194-smmu
+              - nvidia,tegra234-smmu
           - const: nvidia,smmu-500
       - items:
           - const: arm,mmu-500
@@ -181,8 +182,9 @@ allOf:
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
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
