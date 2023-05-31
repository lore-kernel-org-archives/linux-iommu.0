Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE416425
	for <iommu@lists.linux.dev>; Wed, 31 May 2023 15:04:31 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f4f757d575so1409102e87.0
        for <iommu@lists.linux.dev>; Wed, 31 May 2023 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685545470; x=1688137470;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiTMvGB8HErpiqe2o3ZU7CnLtvKjGdeRLZBnEjNhU7o=;
        b=StJdu96j3/XNZxyg5eBVgEwqSXS3Wcz5Htr4jlMkhFev0kefaGT1sW9G/idRzUfXrl
         FfUyZmwXdhJ8cMFV51tw+1DLqVaTSsFCOVcFeaawAnqnj1Z4x0N6rkFwkzXk7Iz5Ik2c
         fmt3ZtbHA4AjUKJnTYHZAPT17ZgWSvur3RvKwMtnAcgRC1LLKpyk04Bi61PxFf9RtJYN
         BryPn6eU3JJqegSD3UwtJnuVGL6T4BavSY9SwThYZ5ZRplaWSn2FiI4/vr3QD3McL8me
         De+gLF8EgZdrxzFNxCvdjQqBT3CXkp12YV+OPwmqTzy0odkBO87ysld+h9ycF3UtqEB7
         ZsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545470; x=1688137470;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiTMvGB8HErpiqe2o3ZU7CnLtvKjGdeRLZBnEjNhU7o=;
        b=RjBV2yP8qyI1c2YiTeATEqqtCjreiKTHWvQbjSmJ+K9iYHmRWf2c2upXzzsO4X/66O
         aPQrqAKYOD4vpfbVo42BQx8n5aLEBuwAZkq0ifn3RcEicyZM+rivvs19PFupWa6zC9pX
         7Uq9Wln0RansA1ARrqx4fiXrTJSeUV7N4SmuT5EBt6ZWMq62kL6G78IBEuiOPZi1yG3N
         cNTJe7F7vAv66m7U1jU36E1II/hA3xEBI9+3uldLJFrJvbNQ1253uauCHwzQcUEFmEOG
         8XbF5ctVAIusN5N+nr36TPaxXMlz/o9h3+8e7d3IJyCHdwQlA5dC0Nv2ATUX/TfD8JDM
         z17A==
X-Gm-Message-State: AC+VfDx7H7nH5kiK+pXe3/K6iTmN+XZZO/li8HgxhFtS+htj/DUNR8hD
	ohED6TaQ6jOYJwXd7gGU60KONQ==
X-Google-Smtp-Source: ACHHUZ6B0Iz7krBLd1B0iaQcomiMQZShU8ZA7yaAYGwJq+fvY+WGLaS3B9f+Lo8eqHcE3APS+kiy8A==
X-Received: by 2002:a05:6512:10cc:b0:4f2:47ea:2f32 with SMTP id k12-20020a05651210cc00b004f247ea2f32mr4506235lfg.23.1685545469755;
        Wed, 31 May 2023 08:04:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004f019d3eab4sm756325lfe.23.2023.05.31.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:04:29 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] SM6375 GPU SMMU
Date: Wed, 31 May 2023 17:04:22 +0200
Message-Id: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPZhd2QC/x2NWwrCMBAAr1L220AeVNGriEg2ru1Ck4ZsI0Lp3
 V38nIFhdhBqTAK3YYdGHxZei4I7DZDmWCYy/FIGb32wY3BmWysnI/kcLuNzql1y7gavMaH1Hp1
 PoClGIYMtljRrXPqyqKyN3vz9v+6P4/gBEI3PzXsAAAA=
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685545468; l=857;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ihuIa5z+sCVM/dPT9nv97DWtZT8WnTtyU4Ykbs/OYTw=;
 b=PR8mQCQ3IisTHZqcXsO0nduFHV4WKooTGDBvnygFx/9tqu4rsSueE4EnwfTMbC8lDonGIaWYx
 26Ppu7f4ytKDLRNQok9991Qykuu3/yy2VstUym3W1z5MzPVCGX6MEBj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This series hooks up the GPU SMMU, as well as GPUCC as its direct
dependency.

The thing sadly can't seem to be able to do PPPT, not even on downstream..

Depends on (bindings and functionality-wise):
https://lore.kernel.org/linux-arm-msm/20230529-topic-sm6375gpuccpd-v1-0-8d57c41a6066@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add SM6375 GPU SMMU
      arm64: dts: qcom: sm6375: Add GPUCC and Adreno SMMU

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  2 ++
 arch/arm64/boot/dts/qcom/sm6375.dtsi               | 37 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)
---
base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
change-id: 20230531-topic-sm6375_gpusmmu-b9acb022b12c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

