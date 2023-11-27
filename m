Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DCD34CE0
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvPe4mt2"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so6263874e87.3
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102010; x=1701706810; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7VqPtYpwoj+TW7Y8BWDK43UozTyH/qVC7KhQCmuFRM=;
        b=ZvPe4mt2AxGRQIGFamvrOBy6rUn6vk10ndNcAgar/XbQdwNv7uPttE4bEEmkYob4zK
         Mo1fBlblS9x4gR0SkAyMgjWOpqQBuOL5jfccdQV8E7dlEKVR0gbAkg+q2oBmszOUPb65
         ZNGlREGSSQa2gt9TcmEACPXnW7zqgDi660Xk4jZON6/8z+DCU2YND+dxnnNlU5q891md
         EXP3lUwdUUY6gCCZF8o6hj7XXHvXrI/Eo1XFGrirjy3sL30uZW5BdHI948ZSjvfVfWd/
         nWctCbPZQvdbGZgsO7pYCdN7mJbt8jTFoH2wyguYHNgePExS1hGxQfTvYnHs7ZOTgErt
         L+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102010; x=1701706810;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7VqPtYpwoj+TW7Y8BWDK43UozTyH/qVC7KhQCmuFRM=;
        b=qb+1O6eWIJIklgL/YCQ2ett9/P0Wlu2j6sPtQEF9pbYHq/c97ngG/+SCFMRm1RKDsq
         NsAbJRNiIyGmR/LnJ8Cjf5QiydtwpGjjJCqBHwJODfjvmkON8Cbk1nh/AhcoGAUEDZd1
         Z66RG9gtj7BJLknyzIgIbZY0tSM8eRgH4U1VnEIcuCw4OEPmEdNAgim8F1jy8LvAMb96
         wwPgWmhgyq5i7BGW7BHvfl94xBeIrv/89fp5M9HuIVaSvVKLnot+piIIfM/kMpJQVDQH
         3+MZZHNXO5j3O9BwNmO90oEgq/F4+YJ3ZlyXioE2ddrf9s3MzDJq1iaS7j5AgpJRjq+P
         i4aA==
X-Gm-Message-State: AOJu0Yzrn5yViQdW7zOCCaqsRztWw0nYrVWgx86bZAeMmFrMBqwej3yh
	NE0riHUQ9C7tetqITQB8wVKbiA==
X-Google-Smtp-Source: AGHT+IHmgRxGBQwnhbTyFCMdrlJjPEqWPP9SdrVlRVuS7yeIr7kA+AYZlSRHNy1rJX25Nv8IL8B7dg==
X-Received: by 2002:a05:6512:3196:b0:50b:aa13:a761 with SMTP id i22-20020a056512319600b0050baa13a761mr5779827lfe.46.1701102010662;
        Mon, 27 Nov 2023 08:20:10 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:10 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/6] SM8450 / SM8550 Adreno
Date: Mon, 27 Nov 2023 17:20:02 +0100
Message-Id: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLBZGUC/x2NUQqDMBAFryL77UKTCoJXKaWsyVMXJEqiJSDev
 Us/Z2CYiwqyotDQXJTx1aJbMnBtQ2GRNIM1GpN/+Kdzvudj2zWw9LV+4sETgM51HjEKWTNKAY9
 ZUlisSue6mtwzJq3/yet93z/OMxPedAAAAA==
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=1189;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/aCt/tpWduoy987CggdzKos+vz6oIxXcKvTXjXKLxJ8=;
 b=/fFdW2I4PegFvbTzHnoeeKoejhyDoNRfMyRHqa4iYNbe/GxP/qCjLCCo4xiLaXyEVTacKmf9c
 nJik6l90SFTAynj16yrttBu/TokmhuJ4L2xau17nJBJgUOOGLFeHYzE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Following the merging of related bindings, driver and mesa changes, enable
the GPU on both of these platforms.

P1 for Will/iommu, rest for qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
      arm64: dts: qcom: sm8450: Add GPU nodes
      arm64: dts: qcom: sm8550: Add GPU nodes
      arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
      arm64: dts: qcom: sm8550-mtp: Enable the A740 GPU
      arm64: dts: qcom: sm8450-hdk: Enable the A730 GPU

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  48 ++++-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |   8 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 202 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   8 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   8 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 166 +++++++++++++++++
 6 files changed, 438 insertions(+), 2 deletions(-)
---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231127-topic-a7xx_dt-feee4142edda

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

