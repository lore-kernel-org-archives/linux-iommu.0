Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB03BBFD
	for <iommu@lists.linux.dev>; Sat,  9 Mar 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991104; cv=none; b=Stt9m0CFLPAndoxMTRqPF4k9tktZL86EbMp3+o3+QJOfjm+Z8i6V6hCjj68okp6asG/vzyLOUh+QdWPUvwJ0ZSKSllmHYOMOvJF+sp0VClvpwIdrG1o/bGAcA3OjXFvevw8Y25hVoHEV6++nCMMTaSs9ywRGfkK4dfCnd/oz7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991104; c=relaxed/simple;
	bh=dzIRNamppTDwRXph5j+j6sHF8ZDQWmVY7VVa9HIkrhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHFyAK1axivbtFhpWaV823l67cGV1OAduKZCujqEiXZfYnkoc0mTaDQTeJ/j8RaEeKLbGXDFuTpuAEVF2TciFOG5xu8zWDojdWhVsV8i0GEaTOfO1ykFri/uYcoIMvF3+Nx+tIi83iMRnG7ZYne8o9plsqSjLNg3HKzkLdDOxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f1eXaRC8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1eXaRC8"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d422b6253cso15006281fa.2
        for <iommu@lists.linux.dev>; Sat, 09 Mar 2024 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709991101; x=1710595901; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S9sVMkbewmcU+sMnLiPTREy1pYzZjdKzAeaIhzyiFg=;
        b=f1eXaRC8YUIgwzpocMhyTrNTBcwBsvlTPzeGDtVRLr73JBvj88Em+SlbnQ0igDIdtQ
         gQixMk9DHsWKqllKEcnOBerBaf+Jr6sweXp48NdW+XH/4H4XKTelqVwitT/gg2Kubjyx
         Cf52TWid33fSj8sqJgynStNe0m1BK7zktkJfA0c/ygyIg6tI0M8eeZQa90MbjSbQfbDr
         f1TjVU5JrmVwdhsaITBpJAzIawTWvGx/NWcO2lWlrbwPTKNRQ+MuS3vM98WS7wY9GpYm
         tIToIyVWpEyODDdAZOm42XPkKZwPIcEWG4PWLW7Yo2hsrguCaFWLObdOR6i2IL5/Zc9j
         u41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709991101; x=1710595901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S9sVMkbewmcU+sMnLiPTREy1pYzZjdKzAeaIhzyiFg=;
        b=l85VeeW6lQSv4iuY4KDwj80AQIXtnoIXgG5U6NPUC0Z0UUMjtiGjERB1pCCRxdheg7
         QpKBRVeSGTEhIsZ85Q5Ix0DghMYObPXh4/rk/Vav3Zeb7uKotZTWWvPAOHJPG7r6SAcp
         wSKhgZLGBVFqNWehLw1bhJkak4MbXRV20m0G6fLQlmhnByPYC3m+spht0IZPBjwWSqA2
         /kjtFJnMczZIbX5ldB0cY7DZahp1Vv4lspU4XepHTzbM/6WrHJYPoLUwmyA33sNq0E0t
         gzZl8S1i8Ea0fs6GtrTR7nMmkzbONM9A+ntl73V/bPFKPvRGeXkOAFYO4syJCG9l5cAc
         oB2g==
X-Forwarded-Encrypted: i=1; AJvYcCXortZ4vym+PE+HsRDtPcmzSOYu4HTif2e9SHMDWdJkQPGA/XFikjGZo+ayiDKC7lD0OoD3iPwTNqRVZDcnPalx9OaaoYI=
X-Gm-Message-State: AOJu0YwSGPVL3bN6VqlCRYIeDoWSDBqPRD2TT3hXrQvZ8/Wrh34BklLG
	H8aOmuZG9FZABGYfttXVunr0pPp43tApmG+5E8PCNQ+3B6mSK6wHrJAz0jy9v5I=
X-Google-Smtp-Source: AGHT+IEpSZeJhL5yoIiRWaKJ5Og/+Gu8F/5CU1zIV9HwGS9ow5HVn0ZE4zYgJJ2lmTzhhyHOkgWHzw==
X-Received: by 2002:a2e:9c49:0:b0:2d4:d88:50e1 with SMTP id t9-20020a2e9c49000000b002d40d8850e1mr1200361ljj.42.1709991100722;
        Sat, 09 Mar 2024 05:31:40 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b002d08f3640b5sm298524ljk.11.2024.03.09.05.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 05:31:40 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 09 Mar 2024 14:31:09 +0100
Subject: [PATCH v2 1/2] dt-bindings: iommu: arm,smmu-v3: Add SC8280XP
 compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-topic-8280_smmuv3-v2-1-c67bd3226687@linaro.org>
References: <20231219-topic-8280_smmuv3-v2-0-c67bd3226687@linaro.org>
In-Reply-To: <20231219-topic-8280_smmuv3-v2-0-c67bd3226687@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709991097; l=1021;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dzIRNamppTDwRXph5j+j6sHF8ZDQWmVY7VVa9HIkrhM=;
 b=IARinJntgA9j3ldAG+sggUdQewMX0B8FKYRMYSHMxceXbAzKPita/P7clAon14ZE33XE2qsPW
 Svh21LycFfKCvFkZ3auFTkXQ2YwF/lhzL4YUB6vxLQIMsF3Jfuwiy3x
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The smmu-v3 binding currently doesn't differentiate the SoCs it's
implemented on. This is a poor design choice that may bite in the future,
should any quirks surface.

Add a compatible for the instance found on Qualcomm SC8280XP.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9..f284f7b0c1d8 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -20,7 +20,11 @@ properties:
   $nodename:
     pattern: "^iommu@[0-9a-f]*"
   compatible:
-    const: arm,smmu-v3
+    oneOf:
+      - items:
+          - const: qcom,sc8280xp-smmu-v3
+          - const: arm,smmu-v3
+      - const: arm,smmu-v3
 
   reg:
     maxItems: 1

-- 
2.44.0

