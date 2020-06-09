Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BD4C433E1
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 20:16:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7DE2078D
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 20:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="R4aWwk4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7DE2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BDA678890B;
	Tue,  9 Jun 2020 20:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FOf9I0sFcVPJ; Tue,  9 Jun 2020 20:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 27D1788912;
	Tue,  9 Jun 2020 20:16:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07AA8C0893;
	Tue,  9 Jun 2020 20:16:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE8DEC016F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 20:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B96E220468
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 20:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mNjZWV7VGdyW for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 20:11:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 3039720460
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 20:11:47 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id n141so22162622qke.2
 for <iommu@lists.linux-foundation.org>; Tue, 09 Jun 2020 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sHWV6OU0cqgaqdPacomRMLT+w3Ah3p0WG4kNzV6/a0A=;
 b=R4aWwk4htZqHave/9h/EmzzlTvfpyow5xa1HrixdbeagLWiDVCahZX+fvgd72MMhKH
 mifgYvUj+jhWaMGg3Sy/QuCRU/M6RKcSTiv3XoeJ3SlLx/OpCDJihfdQDGtJHK6Ma2fv
 57K4OCfyNvmS7Mj4coeIZrZFaJpqmVEx2dQAQ48cfDir+BZHYiiGfFlO10AOnFVbaQ4l
 xacFlXm9XwJChbkrL3Ai0A69gf+8Aqb9dKIOsXRf2SdsS9hTKPcwi9G1oIrDRlCBi1AV
 k2QWPQR6Xa9viXBp+BOnMgIdZtNoxs4Gk5hOWjYWXe04l4pzi5HWgoRZ0X44+xTY6pZd
 w7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sHWV6OU0cqgaqdPacomRMLT+w3Ah3p0WG4kNzV6/a0A=;
 b=rxAAG+grwt+3zhOOD0fL6mlxvs4nNrN+9dWDEVLi7gcF5wGL4oyKng/gaIF1nZzafN
 VdyRIeax+vJ7FoY8UxBiEWNaK6yefwVNUKSE6k8vj+9H2dYPQ7DVX7sjiCrkLjNnDAw0
 eCzIXpPqNjHkpx4tzkM6IyQw1TdsJCdQwDOoOOxecqNLT/HVZkMDY/noT1yUtNf4Pltx
 jqW/Wmul4vK6llcJ+2dTvQDIRrctCXDB0rlWVTHo2QuM+K4N/BgAkz117mRPgtWUWNgq
 ZhUn8S0tlIcZVzOGd0Jf4KWfAqzOoleFMmgjBvjYFfNoxEewQUDVqv9WXj9OZUavwdxa
 GE4g==
X-Gm-Message-State: AOAM5330SR4FhedoyeOTk0pJZ8TUtvhhwgOnHlxsQoXmAHWXZp2iXX5Q
 w+CRKY6Dr0FXrB9VKS9vBOx2bfCO89LN5g==
X-Google-Smtp-Source: ABdhPJylYwtTWOmAgXhVLnUMhpb1BZNqKTLwO9QHJOFRb6EbibLEywFO6AcZedPsGIptantkT+8xEA==
X-Received: by 2002:a05:620a:49c:: with SMTP id
 28mr30284895qkr.168.1591731634848; 
 Tue, 09 Jun 2020 12:40:34 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
 by smtp.gmail.com with ESMTPSA id v8sm10513181qto.21.2020.06.09.12.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 12:40:34 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/8] dt-bindings: arm-smmu: Add sm8150 and sm8250
 compatible strings
Date: Tue,  9 Jun 2020 15:40:19 -0400
Message-Id: <20200609194030.17756-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200609194030.17756-1-jonathan@marek.ca>
References: <20200609194030.17756-1-jonathan@marek.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 09 Jun 2020 20:16:08 +0000
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

Add compatible strings for sm8150 and sm8250 iommus to documentation.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index d7ceb4c34423..3ac741236c8b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,8 @@ properties:
           - enum:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
+              - qcom,sm8150-smmu-500
+              - qcom,sm8250-smmu-500
           - const: arm,mmu-500
       - items:
           - const: arm,mmu-500
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
