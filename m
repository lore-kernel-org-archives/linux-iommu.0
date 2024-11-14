Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD4DF5C
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545257; cv=none; b=DPlzATBsQH2JZtFTSjKYlkb57G4MpQneOYEgVQbdJnLhGN2J9eJk0a1XMkNj5wYoVxpNnRyox5A7EdAg/YsEv4YIcr8E3Esr8QNJ3U8tAsIKHBZTB4ngVAVVVFiUZ+1W+nGPOt89aKJ0KC6I9IqzF+jRhw9UWyl2w2R0WqEPS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545257; c=relaxed/simple;
	bh=IdsOiPVpkymG/J7+hE0qmbsOoZxpB+jRc3dtEEvfF0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Le/bUNplGZXOuXaEFTPtZVfzAdiI0yxrmip+a1/PRykvyyQAyc2Tp/afFlvQMWxC9Gp6mWS7cVHoDNto5Pafr1fyyscCcfjtBf48Xlfjc2fYxL1oQdeUMlql0vHPhO5i6MtjO/Adu0f5tNVp87rd1UiS48nW3LQhtmXsXWb3gEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCgTE50l; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCgTE50l"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4c303206eso173205ab.3
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 16:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731545255; x=1732150055; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfeWIa2nRRaLMa7E3TxB2pqTwWPv20hKS0WKJTtnevs=;
        b=ZCgTE50lqzJxRNmiJtRh/Pq/wtwrsGB9w+mqRTm4u/Xzd0wD3WrCt8K4MyELs0Aa0g
         vqrBlm0F3+U69hBmal+VsHpXCIV3/WgskTcAG6XeXayhdUNCIUabPbPyDbw10dSe19Qj
         ed60vU5+END/KC821LBcf/5SsTgwIye0FJ8R78jF9hC4OAQGUGOZAHvidKVLiLtY0TDD
         BnJv+b3PPPJwTbcGGoF4mu01+kKt/JZ4P58aj2syBZ1wISbukTyP+x9gMKiZ1Qbm3p8P
         J7M32MvR1aGhLdQ34hcCqoDSkoK6dfjTOVn9XIvLHtmHG+ONH5thd2AfQqErQPrqriCa
         bFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731545255; x=1732150055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfeWIa2nRRaLMa7E3TxB2pqTwWPv20hKS0WKJTtnevs=;
        b=NNscJMO714O1VtU/gNNIeRjKOJlNNrn0tNaIcjzB0JdnmvfFiu2YZR1W+6f5+VKGRw
         p6An0Zz+sspU75XLQqxm2A7rQwRCLNzd0Zn+Zd9ez99TVHK8eAARfwOpBRAVAXnlWokR
         zzk9QX/Ev+rogxg6HGV25NPGUlOcCHmp44P8OIhhSGC46k5wfBIxSBQGLWRzkGdLHmJn
         W6R4JExQpua45ggWLo3KHtb4jkqgpZfv+2s4G4o4OU3cuh6oeOuyMledfx1hfyVuiklF
         EaP40RleUnF/owOPzNLJ+LVvvsN11d9H8xV6wG9q1BqC+ZiTL5ZhN0bBU3ubZPf3FLhf
         v5ew==
X-Forwarded-Encrypted: i=1; AJvYcCUajwvg6zicNbE2EqHu2cmSrujUrv1lOeJBr+OagXH5Njf3/C67DZbojjpYPjWYeXLy/ICjMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+8eW2ceMZxSAA2lK+fZc1XCO+rjFbl8A4OjWQq8Ha/4YU3WRG
	E/tr5Rj05RwbhAMQg6h1Z8miLZOpVMjVQutgoxkPs112Ao0/VodW
X-Google-Smtp-Source: AGHT+IE/YfqP7Sjx0YczZnwTlxJkpO38uTXKwcD4NS9fALu47F5QGMi2FVOxn8z8wQMbRGQuOsqucQ==
X-Received: by 2002:a05:6e02:749:b0:3a4:ecdb:d61d with SMTP id e9e14a558f8ab-3a71fe3b539mr4886115ab.8.1731545254783;
        Wed, 13 Nov 2024 16:47:34 -0800 (PST)
Received: from localhost ([2607:fea8:52a3:d200::8f60])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e02fc619bfsm5011173.42.2024.11.13.16.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 16:47:34 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 2/2] iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible
Date: Wed, 13 Nov 2024 19:47:16 -0500
Message-ID: <20241114004713.42404-6-mailingradian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114004713.42404-4-mailingradian@gmail.com>
References: <20241114004713.42404-4-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the separate IOMMU on SDM670 for the Adreno GPU.

This IOMMU has the compatible strings:

	"qcom,sdm670-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2"

While the SMMU 500 doesn't need an entry for this specific SoC, the
SMMU v2 compatible should have its own entry, as the fallback entry in
arm-smmu.c handles "qcom,smmu-v2" without per-process page table support
unless there is an entry here. This entry can't be the
"qcom,adreno-smmu" compatible because dedicated GPU IOMMUs can also be
SMMU 500 with different handling.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 6372f3e25c4b..601fb878d0ef 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -567,6 +567,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
+	{ .compatible = "qcom,sdm670-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
-- 
2.47.0

