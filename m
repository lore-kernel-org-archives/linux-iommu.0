Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8846C433E3
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995E72074D
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDZcQosI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995E72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6D6528804A;
	Mon, 24 Aug 2020 18:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qaijna0j0I6Y; Mon, 24 Aug 2020 18:42:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0121D87CB2;
	Mon, 24 Aug 2020 18:42:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E25CFC016F;
	Mon, 24 Aug 2020 18:42:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 156CCC0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0E4BD2156B
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sNa0TLw1ZB7F for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 18:42:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 0B4F82155B
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:32 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id d22so5317368pfn.5
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8jrJbdIXQQAFjo/ry7i+txJOnZIwex0ahQyZ/9frdio=;
 b=vDZcQosIOwttT+7YVD0YcJH63i/4ANBtWVWvB3iylHAaQulSk6Zt7LO0aYaQGeR8La
 Nf8A20AmUnyBL5dyL5YvhbxVitCshAaCyxzgTjfew1FhVN8rwvRSHF+nw1IRTCT+HJEy
 LgfiPuvEKOs/thV8w202+qBEZDCU+r1Zl8SLot+h3dwwLhotl/DUgl81PJRW1yM79dcZ
 9QGffNgb65T+Rovp82CSbUGQINp+vpJ8/XXTWUFo6wLY6s7ajEGZZXyDUVmzzrVB1BeB
 DA6m6erABwDeEATCGThEYV5o1xN7WllNV2le6drxEfsYY72ehk5qdU1vkRSxeuJJeZFW
 XY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8jrJbdIXQQAFjo/ry7i+txJOnZIwex0ahQyZ/9frdio=;
 b=Pp48F5nCSGZKTQEqquCUxxG8ysIB7dy4FzKZzHqzrpNvcqfeg4SeeJRKa1xu1jBRJj
 L3+DrJPsIRB3GJDv9bTshnQAwhRmiODUN0fk47sSAZu4CSt2G/mssWPMhFBianvyFjjn
 8JCxEE1GHwo+g6TOMeS+xWqkgITZ/Ee89XD4CWunaWp4WWtlqR3l/z40Y4YnwYiHrgl1
 As8KcDrVmD0V3NSTTQG/FlNy3ckfzO7NjQ7dfiE6nSZePdn+uqWINMlTsfPQlumPcMQH
 cj0ricg7QD7DUqZXZfbNannZTE3Rgi9VuKY3TaX1gBufkDyigZ08nfasrAw2tK28y9/r
 tZEw==
X-Gm-Message-State: AOAM5313/FNNax4jFSAhkJBTe/ifV3BdJiHoOh7aKKJeEX4YVN2nnCiR
 LLHXebdX+rr/PuA2VORfLM4=
X-Google-Smtp-Source: ABdhPJz3GfCDsrY2e8D8NgnMkrpU5oev72R67ENvd+ltLeKwaHWMDwrcr34kf5ZWRUkLqlnrTXmo9w==
X-Received: by 2002:a63:ca4e:: with SMTP id o14mr4352543pgi.213.1598294551624; 
 Mon, 24 Aug 2020 11:42:31 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id il13sm251907pjb.0.2020.08.24.11.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 11:42:30 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 10/20] dt-bindings: arm-smmu: Add compatible string for Adreno
 GPU SMMU
Date: Mon, 24 Aug 2020 11:37:44 -0700
Message-Id: <20200824183825.1778810-11-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Akhil P Oommen <akhilpo@codeaurora.org>, Eric Anholt <eric@anholt.net>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Rob Herring <robh@kernel.org>,
 Jonathan Marek <jonathan@marek.ca>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Sibi Sankar <sibis@codeaurora.org>, Brian Masney <masneyb@onstation.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 freedreno@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Jordan Crouse <jcrouse@codeaurora.org>

Every Qcom Adreno GPU has an embedded SMMU for its own use. These
devices depend on unique features such as split pagetables,
different stall/halt requirements and other settings. Identify them
with a compatible string so that they can be identified in the
arm-smmu implementation specific code.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 503160a7b9a0..3b63f2ae24db 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -28,8 +28,6 @@ properties:
           - enum:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
-              - qcom,sc7180-smmu-v2
-              - qcom,sdm845-smmu-v2
           - const: qcom,smmu-v2
 
       - description: Qcom SoCs implementing "arm,mmu-500"
@@ -40,6 +38,13 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: arm,mmu-500
+      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
+        items:
+          - enum:
+              - qcom,sc7180-smmu-v2
+              - qcom,sdm845-smmu-v2
+          - const: qcom,adreno-smmu
+          - const: qcom,smmu-v2
       - description: Marvell SoCs implementing "arm,mmu-500"
         items:
           - const: marvell,ap806-smmu-500
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
