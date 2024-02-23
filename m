Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F6149382
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723309; cv=none; b=lhK3TfxBoKjZsPAFJckVCA7dPMsBmcCNzJB78qPu+hsBXfiP2JGbEA8TKO5tyz8ofOUf43anU5G0b5WwEtJbLhzWW4lBIVlTQPracw43/Q3bv5+8Sunn8HTguLxYLr9r/C8kT/bLifL29VtoAme8IaDRm1fyjGwRALRRottWws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723309; c=relaxed/simple;
	bh=7tHpBwYBjs0QIZxWGt5a/fib2c1/MZ4A6oZE+Z30PYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YdcjsFyDUEl3C0IRzT0qvr11BpT5rbuHZNcKtV8yn+dL3JO84m8+X+f0YcsbcQI/XZsdPes87bGUEq0c62jIMGfsTTIPHvWRSLXC8hPjcGqmTZIEiBj8crv/utQT3i34WFTvDHJSdWYlQSul642S8pbCchZxbgzSCyuSIb1nwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jaEhprcu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaEhprcu"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso158911766b.1
        for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 13:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723306; x=1709328106; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3qOtgMPjyNgM5pphCQWRy5M3sSPymURGErwjzDyDOL0=;
        b=jaEhprcubximTS3tY1hgFTGNPAgxyOB2MxXhf5NJa1sfxMbKkrY7TJL80I9nn4ArcQ
         pD+ZBBkgOEG5xkE+iT8BmyUR09okKjiS3G09uxMJ3RgUcpGnp+997SQ4xqSBa6KtXccx
         peVYh25vf/EVJlowP8fA/xn1S1Un7Q5RblTIbdrXm1PdyDjoH3poCvK/mnmrULIXzx1/
         x9mJxwhPIirw5X7+p14WVNNh/Dsrez89w6ZzQycJxb/lqM5VGxI4bjt/WGfQvM98Xprn
         OfBTAVRoD+QtY5kWU8Qizh5yWK6y4v46nNrrhNKror5jobPO9TxMaJPrfmaMuRlQZ4d6
         QsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723306; x=1709328106;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qOtgMPjyNgM5pphCQWRy5M3sSPymURGErwjzDyDOL0=;
        b=GNQyLKNJ25fDx3c2WyTVyP5mk4R8kfliofWJzy4kXTA9wZwVZWX/N0+3SJ3qMteybz
         mAa4Yk4VGjG4jKj4sLSiqXQSRR91hPqqC+XZy1jMHhJEThBAPpouxfD1EXpf41edgWQK
         JUHqAZywH8rJhWROSnPPycfQR2GT9JqVSISMc/nDGdmekTyN0msGnd853Eg8fCs4TsL3
         FESF42aWEw4EgN01uUOk57Kg7dMCqLMT6qq9uLw6r/of/qaIRznhY+jnf6EoLtq3CS5p
         bPCSipnKWXrqm/9/q28o9Iuy5pdS3R3A/L41MDXbzj3wdgzJNGX1R55fPY6+4uyC729i
         WLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2fRPOoum/lmGoRv9TznATvECsCPBe2l9+nkS092kkRevcYQG94MslVvmiC4tZtCjc2ivEFxE64V/f5aSzCeocYo8qk90=
X-Gm-Message-State: AOJu0YxNK4lq/8Ld9vz/a1iN3bdUFdRNwrv7UGen3AXEuaVFOBTF5ryf
	UZYzh76SQzOa0HojWLHOuPkKK2yvG6Kprj8hQqWAmo4PqK6cfLNI+0hj0VlQPdU=
X-Google-Smtp-Source: AGHT+IHNsRoCGn0GHTzTMfxgVcZdziz1Uz8p/0O7ANbTl1s5RH6d++8nVtFJ+a8mGI1yevbhqwpi0w==
X-Received: by 2002:a17:906:fb06:b0:a3e:8bd8:b711 with SMTP id lz6-20020a170906fb0600b00a3e8bd8b711mr685947ejb.37.1708723306292;
        Fri, 23 Feb 2024 13:21:46 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id mj8-20020a170906af8800b00a3ee9305b02sm4091226ejb.20.2024.02.23.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:21:45 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/7] A702 support
Date: Fri, 23 Feb 2024 22:21:36 +0100
Message-Id: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGAM2WUC/3WNQQqDMBBFryKzbkoSraaueo8iJcZRBySRiUqLe
 Pem7rt8D/5/O0Rkwgh1tgPjRpGCT6AvGbjR+gEFdYlBS11Ire5iCTM5wa16DfMqcnTGlSaXuSk
 gbVobUbRsvRvTyq/TlOTM2NP7jDybxCPFJfDnbG7qZ//db0pI0elS9tbcikpWj4m85XANPEBzH
 McX0NVltcAAAAA=
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708723303; l=2367;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7tHpBwYBjs0QIZxWGt5a/fib2c1/MZ4A6oZE+Z30PYs=;
 b=epuG5oAKrr533fJKmkaFnj1FjTAPxNoYkEMcHz+KHP4gzlrOn5lsXpP9f1YjnwX0/IsJ6cXt4
 ZTN2yx5xm87CgDWY+vMjlaY6zIT3LRax1dgd2sxLnp0EOV4B4xdjC4F
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Bit of a megaseries, bunched together for your testing convenience..
Needs mesa!27665 [1] on the userland part, kmscube happily spins.

I'm feeling quite lukewarm about the memory barriers in patch 3..

Patch 1 for Will/smmu, 5-6 for drm/msm, rest for qcom

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27665

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Drop applied smmu-bindings patch
- Fix the gpucc bindings patch to be even better
- Reorder HUAYRA_2290 definitions near HUAYRA (..Add HUAYRA_2290
  support..)
- Replace weird memory barriers copypasted from msm-5.4 with readback to
  ensure timely write completion (..Add HUAYRA_2290 support..)
- Keep my super amazing commit message referencing the 3D accelerator
  official naming (dts)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org

---
Konrad Dybcio (7):
      dt-bindings: clock: Add Qcom QCM2290 GPUCC
      clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
      clk: qcom: Add QCM2290 GPU clock controller driver
      drm/msm/adreno: Add missing defines for A702
      drm/msm/adreno: Add A702 support
      arm64: dts: qcom: qcm2290: Add GPU nodes
      arm64: dts: qcom: qrb2210-rb1: Enable the GPU

 .../bindings/clock/qcom,qcm2290-gpucc.yaml         |  77 ++++
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 154 ++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |   8 +
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  47 +++
 drivers/clk/qcom/clk-alpha-pll.h                   |   3 +
 drivers/clk/qcom/gpucc-qcm2290.c                   | 423 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx.xml.h              |  18 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  92 ++++-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  18 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  16 +-
 include/dt-bindings/clock/qcom,qcm2290-gpucc.h     |  32 ++
 13 files changed, 889 insertions(+), 9 deletions(-)
---
base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
change-id: 20240219-topic-rb1_gpu-3ec8c6830384

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

