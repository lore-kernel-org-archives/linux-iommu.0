Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8ACA95C
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545253; cv=none; b=VqvirxzQAJV3zDXPmpYCziLQa8E5OP4KyQuyHiqrFL9rmZBLG4NisITk/x3YXlG4YC0Z7K/Vjukk4jb5HguzQNkLIL5GnObEKu5qv0GzthyMcGV4ZLMbD01VnI9vQaJf7Ft+0mYn1gTlbayxbxAL6clDDQ1etg6o35rghVN+e20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545253; c=relaxed/simple;
	bh=ENClf2k/0srqZ1Tno5IWk8kqgefUXkcVt7om+HGziMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AI+xhuJqIrlWq+jybGhAjBOhh+O632JBHlDI/lOM12GG/qykmj4xjuBjvTVgukLtpjuZcXcK69SFOz9Elq6mBtKkBgaXwcxCfsM/7BF1zWkU8fhF1dnjnsgz2mi7aj8/3ozZl6PkjEL0r4wKGZA4RkYZUj9jJ2LY1LxPp4/By/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqAB+azo; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqAB+azo"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a4e5e574b6so115185ab.0
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 16:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731545251; x=1732150051; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLKPb6tUtWuvaIwy1RvtfFfoipFQqhXlm0WTPWG9stQ=;
        b=XqAB+azoOkcOrz18U31DUcP9czM0+98rdMe0NDgm8IUQ4F9SCYJmsjwNH6MZ95lD29
         +14iCBx4qtVYnk5kPzpDDDU+h/WRfq8do8BV5Bqs/ApkbD3gF/dVAyw3RAHyIylk2PCU
         DJ2KXMH5twGlAO5Pm/fjAqWae5Ch22ggZA1qIAyOOY+4qL/ehdGf8esAI7Nd7r3hksYi
         2lTiVQnWYk/O/cXA8tL1VeHQtjLhuI5RaCfWEGXvdisozhAP0T7CNiya9ObAHeJFmVKi
         VSmhkmAEAyYsDBaBCVQUi30wGWvd7QXu+6imx4pUUM2CAYdVGh2+5N+Xts+1IaV/21bG
         HCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731545251; x=1732150051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLKPb6tUtWuvaIwy1RvtfFfoipFQqhXlm0WTPWG9stQ=;
        b=r3FBuwyRpVFr3MzDbRyO0qRfhkXokwlXliloisYT21nejODRG70jjGITEBML6HRSJR
         Xf8OIOXOCWQuy88+6gCn3HnPn2sXiXeitDVDwWloUQBcvGmx/3CUYLKTq9IB+VnyzTKg
         Vje2CEIjXKC0gBlewxmnlsF7+A+EDJ7VI2DPyW+p5Vzn5VAlftyXiEfDZ3g3MWA3PFC2
         nlidSgVseX2/Hzuc6UIaxe/cIwh/r7PtzXXcNF1gAx5ok/SJDXF+DaHTZpit6v0ggtCv
         JuiAv7zNA8bm8Zqv9jVFmXlwVU1pgUHuKYbccJGsPSqy6UxPHkHU4VYHq3ljh2slBMKT
         N+cw==
X-Forwarded-Encrypted: i=1; AJvYcCVBotyU/S5EnHijwF20kBA6AsxrgRLl8gQCsi/0W+lI707FWRYvFoIsxYGLNOyY2aWuTBplNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYWd6u7IoQu4DtBMuIYleN+/cfJ91Ytx5HKu0oouTE9smapZ3k
	8rUebtcAO39Pt02e+nVCmD81JwubUVtBxIz6BNdGlJvdLanK4c6e6qpUBL3I
X-Google-Smtp-Source: AGHT+IEQPohY/RxprSo/ZE/amxJXjaPA/03CfPwtD8Zlbhh428jqAhrJ8y9EcENEoACl7aqbla2/TQ==
X-Received: by 2002:a05:6e02:1709:b0:3a6:c4da:6031 with SMTP id e9e14a558f8ab-3a71de54216mr21112185ab.2.1731545251314;
        Wed, 13 Nov 2024 16:47:31 -0800 (PST)
Received: from localhost ([2607:fea8:52a3:d200::8f60])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f988fc9csm32277105ab.65.2024.11.13.16.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 16:47:30 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: iommu: arm,smmu: add sdm670 adreno iommu compatible
Date: Wed, 13 Nov 2024 19:47:15 -0500
Message-ID: <20241114004713.42404-5-mailingradian@gmail.com>
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

SDM670 has a separate IOMMU for the GPU, like SDM845. Add the compatible
for it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 92d350b8e01a..6d1b92a57dc4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -119,6 +119,7 @@ properties:
               - qcom,msm8996-smmu-v2
               - qcom,sc7180-smmu-v2
               - qcom,sdm630-smmu-v2
+              - qcom,sdm670-smmu-v2
               - qcom,sdm845-smmu-v2
               - qcom,sm6350-smmu-v2
               - qcom,sm7150-smmu-v2
-- 
2.47.0

