Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7228EA
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 10:52:14 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id y15so14217295lfa.7
        for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678877532;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2g86OmueSpPiYj+shGHhHR7giTUqsasgfj/yahZtOr8=;
        b=LpNLrZoDbTto+6U/vEjefyfVJDrLezxlhdDslutIZZYDD5wn2aH7hMx6oMmOEzQxJ2
         RtbCY0mW6RCmX+7UTV0OO9KTlfcOeCRm02ShXo38JsbFSQVlx2detrF3O42n5TMXj0mi
         R43r6tSPPCccEnzksA0VmykkLWMiEO4T8ERoK2bHMFy8up6iWbAbWpGto4wBPzLgelCz
         Kg7rjk++bh26pGIy7286hVCDjt61YS8+aRLwaZV9MOZ6BEczSxa8MdC2rVZ0JChsKFGu
         2GuHiUM2uTfJ4vLJRsK82kNZjk/NIKucrvntcn+u1JmD1XSTcCFndoYcd2DZpklvx255
         odfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678877532;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g86OmueSpPiYj+shGHhHR7giTUqsasgfj/yahZtOr8=;
        b=prF+9srDGNFJgfjHvBVgK79UexRsUuJlKuQUPunLboS1ZFk2KfFDhx0ATOYkjzVZxm
         DD7xigW+EkwZsjcMEysfBwrKQ8CJ7m14XMARPv91nT/AeC3lz029tvW24NqbiTkmNsmD
         UuI6atuIRU9xKAnUV8AmZlELEYWgys2lg/MbsOngGtUmTGoKoK9yWjWvshmx2Oj08yOB
         5t6+zXkzJGsI94uwY9GKkzIVYiAqn83x0f/qBcOP8+eRxlDHl+EF7BIuTiDn8qqE0ety
         3zZIlXwFX7LVAXGkKGwS3o55JPQrzDdkkppQFxpSeRmtyQAsslwNYoMqrXvx39kGDnA/
         YPDg==
X-Gm-Message-State: AO0yUKUzcN5LdjdO3gSthWQvrthWg2URpG/xOe5vaybzSjhF/uQAVh3t
	FhwI+CkWqpkqNnXosJT1vKE73g==
X-Google-Smtp-Source: AK7set/XwbRqxTTviAOLApW5FgOcPev++YfSKQbWF9oqE6kAdQbI9w5GcEpOOWN6v8k4GUcwdyKxHA==
X-Received: by 2002:a05:6512:388e:b0:4e0:ee54:fa23 with SMTP id n14-20020a056512388e00b004e0ee54fa23mr1753368lft.8.1678877532439;
        Wed, 15 Mar 2023 03:52:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q3-20020ac25fc3000000b004d856fe5121sm767791lfg.194.2023.03.15.03.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 03:52:11 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] SM6115 GPU SMMU
Date: Wed, 15 Mar 2023 11:52:07 +0100
Message-Id: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFejEWQC/x2N0QqDMAwAf0XyvEKr82H7lTFGbOMMs60kKgPx3
 xf2eAfHHaAkTAr35gChnZVrMQiXBuKE5U2OkzG0vu18F3q31oWj+2CusuILk2jOm6Mr+Rv5QD4
 hWDugkhsES5ysLts8m1yERv7+Z4/nef4A8ZJQjHwAAAA=
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678877530; l=943;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Khf6zPVTrTyEaJNF46TyYR3lhq+2h+i61osVaLQEqp8=;
 b=3B8qHhID5uvoyUTuuJwV97GTunWJ2e4I/sLaGNpj67bHnsGyTzfyKPohYceTAmrxqe1xj+wLGFji
 WLkpmZ1TDAfUgcDzs5vYQNqUdpFZU1pP4VI6ius2OHki56xxtjCb
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Bring in bindings and the dt part for SM6115 GPU SMMU

Depends on:
https://lore.kernel.org/linux-arm-msm/20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org/

[2/2] only addresses 6115, 6125 will be sent separately after some dt cleanups there

WARNING:

[1/2] WILL apply without the dependency, HOWEVER it will not make much sense

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU
      arm64: dts: qcom: sm6115: Add GPUCC and Adreno SMMU

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 28 ++++++++++++++--
 arch/arm64/boot/dts/qcom/sm6115.dtsi               | 38 ++++++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)
---
base-commit: 062337f0f153c686835cefdb4f937b63fa03edb6
change-id: 20230315-topic-kamorta_adrsmmu-e4e09e01e0da

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

