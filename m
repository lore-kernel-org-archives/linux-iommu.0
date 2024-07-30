Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68FC2C8
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722303513; cv=none; b=jaz/vuyAySGrFQ1Z8Ocvnc2BpVAidVAp9JU57XmkILiv1LY38z9PBaF0VAhFdzm1Zc/o13yjArht6ksO/wwXv3MAFTWcKaU8WEfrJot4Ng8hHVFsl/CA8utj+7tDwbXlOqlsTRZSqtgo5y/56kHivONovRnoJ3IAOFVHiU/wCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722303513; c=relaxed/simple;
	bh=ax3TPARwN0WV0f1DYefYxiiOKQRlRBjw40MkPYhauHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqTP5VfkR9Wiek8s5l7pNrEN6x+nenNUXI1m80jKaRNaZOZfqtwghH1d9Wg3b2OEFHluRUC8duQuxvwQ1lRq7VxVTTOs/Bjl7NopU6jIv1maTGqG4HzQBaBuknHhcOVv1h7BV6WSvrFSgEmIGEQ7sWr2THysPvofXIEW77naQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEU5dCpu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEU5dCpu"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44feaa08040so23734611cf.2
        for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 18:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722303510; x=1722908310; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jadAqLKFE3q2pZsf/6bbztkcQnmkofhXBTNZedlCiwM=;
        b=dEU5dCpuRKk+8v+GbJVxh3DrwjEENpwu8HE4iQOccvOC4snosLm9j1FMgXzGjLK7lu
         3VTE7qMLmk/GwlnX6EdI1n3Vql06Z3HrXZDGPbWqARZ6pR+1wcCIDmXjlipGJPBj0g0P
         M9X+ZL21nnJpXKVQVszNHmi6POLZqCzinGRzSoqkyx4sQmTPiz1HLEOQL6O80lKzzxBn
         ZUf9YDUndNhwf4kPQrnqgSijYV7y20+zWRuzetEbAUQFU42BSUe3wQ+vIf1sOFB7f6fI
         Gy/iET8ZMEXGCeSg04J8/qIzmhBlzz0YllL70jrh7bKWpgtqCtxS0TOzorR/5Xw5+Bbr
         Su9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722303510; x=1722908310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jadAqLKFE3q2pZsf/6bbztkcQnmkofhXBTNZedlCiwM=;
        b=n5lidRo38IYZWAwh7pV6/2YFuFEWOcORrG8pDWFau05ZfjRQzXX+O7Becb6aI4zj6j
         2y1ZLEQe1y+gAzTuH0KYadSWflB9nCsEBnvTFdYVMrzD6ZXoJ+wVo6orGVkVcQa+qdo9
         CZUf3ZyohaMoxDTJkePym9VZx++mHXKjSeTkd6S/KXyLq5020g/Don2D9KMI1jgOVi8m
         w1xmrd0zF2DxIhvHKmMdfqwbyWYsDueDXizEHBwNSfnX1vSL/FkJRg1FtuEBVeaAqb11
         FHZY/NnY3n3b/zi72ue56bp6Nd2+4893k/MSk+KUCsx7z4ohYKOZ/5ZsitgTGRhooXGg
         y3hA==
X-Forwarded-Encrypted: i=1; AJvYcCUov92jaTFjxU7IPFRKhvg7y1Flvi36Yp9i/tnsqg+uoZi720s9O8TB7vQEh777eZaRnSIDmglurbol9546He4LLEQMIlg=
X-Gm-Message-State: AOJu0YyGLwQXHRR3YHYj+EO2yNsYjCZ4+KYKai/3LxN23hiNIocF1AY1
	e9FtVFMqv5aGy7f75VBCQh79K2qcMYWhZxQTdoB97a3j4jlD86Av
X-Google-Smtp-Source: AGHT+IGYK5Xjx0Vrl3G9T4RWpcjMNrPODmKbYEWMFZUZH5DSxk2I2TbWckPM+lm2RVZ3ltORXgQ/7Q==
X-Received: by 2002:a05:622a:1b9f:b0:44f:ec6b:9b01 with SMTP id d75a77b69052e-45004fb89acmr112733241cf.56.1722303509828;
        Mon, 29 Jul 2024 18:38:29 -0700 (PDT)
Received: from localhost ([2607:fea8:52a3:d200:324c:b818:b179:79b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe814741bsm46607701cf.29.2024.07.29.18.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 18:38:29 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: iommu: arm,smmu: add sdm670 adreno iommu compatible
Date: Mon, 29 Jul 2024 21:38:22 -0400
Message-ID: <20240730013820.41702-5-mailingradian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730013820.41702-4-mailingradian@gmail.com>
References: <20240730013820.41702-4-mailingradian@gmail.com>
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
index 280b4e49f219..c672f7b6a2ae 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -116,6 +116,7 @@ properties:
               - qcom,msm8996-smmu-v2
               - qcom,sc7180-smmu-v2
               - qcom,sdm630-smmu-v2
+              - qcom,sdm670-smmu-v2
               - qcom,sdm845-smmu-v2
               - qcom,sm6350-smmu-v2
               - qcom,sm7150-smmu-v2
-- 
2.45.2

