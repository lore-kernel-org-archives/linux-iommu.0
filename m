Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4763BD
	for <iommu@lists.linux.dev>; Sat, 25 Nov 2023 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5JNoCG+"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a00cbb83c80so395520466b.0
        for <iommu@lists.linux.dev>; Sat, 25 Nov 2023 06:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921861; x=1701526661; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPB29h8XgdVf8/Mj7J0oGuHQzVyt4cdj+mVXkBfm3j0=;
        b=F5JNoCG+AbvrgQQgUSFaStYbBkJ6ZApzQbCCATTsgOrrel7X4oW2dX/8mfffifATps
         BZfV4EajkhFeQXCJQD2RKrUWeNh8TBOjU+tdEPzIG8+uaqHaoQTwGmmmiPJyTaBGIG0l
         OIaxQOI8TOuj+bP+J2buEJtqtko31TDZSkKwrEjXFouBCTtVqPfvt8sMEPOKNvAJkUkO
         755hpDi7c0xxVSzCKZidbc7P7ttjF6tXJTSvHc2pTlQhULzBZikKfGB0Y28al7Ty/D36
         uWgHq2FZr5YJ0lqscg5Ljza1m4FVF2y5eKlmbghfHFyY9YVDroWj6CsGVkmK4iKlVCUV
         S2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921861; x=1701526661;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPB29h8XgdVf8/Mj7J0oGuHQzVyt4cdj+mVXkBfm3j0=;
        b=w8/0fcbI3PF8M3AI0nZuL+TWJrAZD6f7rDNH4L4mgnlEdXV2QwHztV4xPi/CWOvYCR
         gCdhWzJnLr7OhpYbuzNakYjRJQQUMIkHaJUE+KCRsqBct3pA8qRS2dPsLO2WoWCuZwjp
         7ghmZZzuQUsKcgiHJZu+Gp+KYFNZbahoV+cXM2aq7YET82hhJsTWgmEzQujNU2QQu95i
         /s3cjbr/u11zDkNBfpjlkpE/XBJceH0GSGWiAPqnIq31j/qHXZ9OrCNe9CLfb7Xr4O0a
         z/sISBVauZ+fhTsoiEzyA+kpZLqqfqC/B17BMk7b7NDNAHhZMeZeoU4y4NW/CI2gXWib
         u0/w==
X-Gm-Message-State: AOJu0Ywz/QG71TAbP6IV5PkX24SA1D2fq9tOO69QD18XAam5cfzdzUbG
	Oy/UaRzkmwom30wTJyi1kEtDSQ==
X-Google-Smtp-Source: AGHT+IFshDaGZpoZ0UPNN73yo2NyaQpJ6p9P/hDNUi+51RGYJObtCtzb4JKAHb0PVhKI46jF5+kwvQ==
X-Received: by 2002:a17:907:2da9:b0:9fe:38b7:4278 with SMTP id gt41-20020a1709072da900b009fe38b74278mr5932250ejc.16.1700921861162;
        Sat, 25 Nov 2023 06:17:41 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:40 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/12] RB1/QCM2290 features
Date: Sat, 25 Nov 2023 15:17:28 +0100
Message-Id: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgBYmUC/x2NywqDQAwAf0VybsBEtof+SillH7EGZJWsLQXx3
 w0eZ2CYHZqYSoNHt4PJT5su1YFuHeQp1o+gFmfgngciDrgtq2a0RO9R4oalBOrDwHemBB6l2AS
 TxZonz+p3nl2uJqP+r8vzdRwnnFqtGnUAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=1962;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qqo1HkU087mhGcmOMVz6Ckg9V4Z4NTeii2LcjxJBNPM=;
 b=o1M6AdcRS2Gq88RD4ObPcOl1SXOsPSOZLeS6wO63F2KLCgkoaV13h/mDN9e0icg6ZaSnsLQtx
 31OcGhoRmcSBrN5eyR4Y9Mh5bTUkFIRHMYG7GFIXZPhZa5DwwDHyDfD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This series brings:
- interconnect plumbing
- display setup

for QCM2290/QRB2210 and

- CAN bus controller
- HDMI display
- wifi fw variant name

for QTI RB1

and the necessary bindings changes

Patch 1-4 is for Dmitry/freedreno
Patch 5 for Georgi/icc
Patch 7 for Will/iommu
the rest are for Bjorn/qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb2210-rb1: add wifi variant property

Konrad Dybcio (11):
      dt-bindings: display: msm: qcm2290-mdss: Use the non-deprecated DSI compat
      dt-bindings: display: msm: Add reg bus and rotator interconnects
      dt-bindings: display: msm: qcm2290-mdss: Allow 2 interconnects
      dt-bindings: display: msm: sm8450-mdss: Allow 3 interconnects
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add QCM2290 bwmon instance
      dt-bindings: firmware: qcom,scm: Allow interconnect for everyone
      iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
      arm64: dts: qcom: qcm2290: Add display nodes
      arm64: dts: qcom: qcm2290: Hook up interconnects
      arm64: dts: qcom: qrb2210-rb1: Set up HDMI
      arm64: dts: qcom: qrb2210-rb1: Enable CAN bus controller

 .../bindings/display/msm/mdss-common.yaml          |  18 +-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    |   8 +-
 .../bindings/display/msm/qcom,sm8450-mdss.yaml     |   4 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |  15 -
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   1 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 462 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           | 109 +++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
 8 files changed, 594 insertions(+), 24 deletions(-)
---
base-commit: 8c9660f6515396aba78d1168d2e17951d653ebf2
change-id: 20231125-topic-rb1_feat-dd510532621b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

