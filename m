Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0640AC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 20:16:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1ED2078D
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 20:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="EJ5I7b0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1ED2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D62F8894D;
	Tue,  9 Jun 2020 20:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zJJJEJsg-69Q; Tue,  9 Jun 2020 20:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF61988907;
	Tue,  9 Jun 2020 20:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3F75C0894;
	Tue,  9 Jun 2020 20:16:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBB76C0863
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 20:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B3D6020503
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 20:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7t77IeFtu5ww for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 20:02:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 83CA3203E7
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 20:02:35 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id n141so22132316qke.2
 for <iommu@lists.linux-foundation.org>; Tue, 09 Jun 2020 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0BqclPegqJok0tr1lg07n1QfpjQ6ftwveg7CVu5MR2U=;
 b=EJ5I7b0p5sm6fG2LVDGmZFIoyUoEMOuv8dVuO+rWpAYZVg5NR9bq0wHB8aFLqtXbzX
 /kFMTgm/V/5WvrVz2M2EsfKNKxHNUIvuVjvZQQQDkpY/UQkKY/ra/6hAunI0v+uMZh6D
 0KyD/4Dhe9OBRkY/jQJgLgoVpLI87OZ0IGfTFEWHdL7PLOyC44ojCz/6e56gNWKMbygt
 P/VR1yGt2c8lH2OKGfLR+JiNAgrHj3fP6Ta+Nf74YWvAjaQr9cjHFme5RcIbHePSjo7u
 pR7FioGemlKZlrSNpD1MePBLmBhnAR+uUWkMJq5msxpz/0yE240PEL6jgGrlNq8pbix5
 eC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0BqclPegqJok0tr1lg07n1QfpjQ6ftwveg7CVu5MR2U=;
 b=NT+FdJKN57yup6OfY0z3vdSJB3K+IRDIfSuE5gCIN/w35VBv/VTSXYRZdIff4lK2SG
 ND8NKqZhVceU2YYTkm2BSOtCb0Ogfc621walRhAf1ZZyCAqE45uRa2IIuj48sLGBynBz
 PjlQC8qRQOqrwIF4pIqybyeUiHxHcxflj49+xcTttnaeb45PSxBNDM3G6hsmiJf9NCOj
 +4ILq+mdLmXEmlCMs1Hdvr6mHveOKAxCm88hzizMHt41IkWmwI9ID/5iLJVBM4tr4j1v
 fq0a3jVJPtBIj3N9tCk56FYzig2aWdih9N/J9drewEFZ+R9LQtfjq/dukQ06cnYqfn1+
 bKbQ==
X-Gm-Message-State: AOAM532uKf8LmCSVeX/oyIna6rUyaRiXREKzm+7erKQcz4oKaknf4iL7
 TnxJbc3+0cg3Em2+3Nr/oQxD1fL+Erlieg==
X-Google-Smtp-Source: ABdhPJyz/M9ZpkYSVQxPXiFgNuTI0QUGQCMuSuyLv9c8jT0hNZNxRz1VGjqEgkrwXdXTkx7A3ZM78w==
X-Received: by 2002:a37:6c2:: with SMTP id 185mr28950911qkg.95.1591731635916; 
 Tue, 09 Jun 2020 12:40:35 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
 by smtp.gmail.com with ESMTPSA id v8sm10513181qto.21.2020.06.09.12.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 12:40:35 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/8] iommu: arm-smmu-impl: Use qcom impl for sm8150 and
 sm8250 compatibles
Date: Tue,  9 Jun 2020 15:40:20 -0400
Message-Id: <20200609194030.17756-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200609194030.17756-1-jonathan@marek.ca>
References: <20200609194030.17756-1-jonathan@marek.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 09 Jun 2020 20:16:08 +0000
Cc: Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
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

Use the qcom implementation for IOMMU hardware on sm8150 and sm8250 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/iommu/arm-smmu-impl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index c75b9d957b70..f5f6cab626be 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -172,7 +172,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 		smmu->impl = &calxeda_impl;
 
 	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
-	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
+	    of_device_is_compatible(np, "qcom,sc7180-smmu-500") ||
+	    of_device_is_compatible(np, "qcom,sm8150-smmu-500") ||
+	    of_device_is_compatible(np, "qcom,sm8250-smmu-500"))
 		return qcom_smmu_impl_init(smmu);
 
 	return smmu;
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
