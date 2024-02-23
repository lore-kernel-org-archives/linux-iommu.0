Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6D14EFDE
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723326; cv=none; b=uS1XQyhKjZOKyhldUL+lcnaTzSYS8BgCndYHFkmA9mwRVVfDaCm1fUf54RIFiUo2KqL/zcKDEM5T3FYWnSFvWBAlVhCTVGhQp8o312RPvknm5UZb4wG4I6hkDUep1TwHg8ogF6YQSnD8p2ZHXbaI5ItZAfl7/FevzkEtxgxMaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723326; c=relaxed/simple;
	bh=/vlAxfs5pRi3jedgeW7eSy/wWzvCwowVIaHNbXcWUPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mkw6qf2mmk0DFzoRJA3BXgH+KbDhtwE6609qx4wtfsCfFs+hX2lRiuLIPxjNulSPbvEqQ3/QUF+z5qvX19+CboluQKy3us+YNQubzyH4YlQcZT6HFeu2bUxsZcNY6OMmGTXia/t7U+LkLpF7E7Cbc596UGUIw7/4+yKzMMfM7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A1JCcVas; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1JCcVas"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so123484466b.1
        for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 13:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723323; x=1709328123; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1FkVd0ZOd4HuLhR6rsPDjyD4D3QNLPmtuC+OU6cTVA=;
        b=A1JCcVasx2Pwb2Gdr+xCqjZN0lpxartVM6nHnh+fV+ChnenTz84hHWXu6J6MbpaG+a
         hrbzLLxxNfG57qGMGDeZLuzBUoQEe7zV/G+hZWI4M1j9hhOl2H0dWgi09doAdJ735wbO
         +I/qIFFT2UMm9Ud2nSfXFCtMqlx5gnTGTJur5WmL/Q498FJRepReWRtS66L8XZlw93GB
         +UvCZlrAogj53rZvv1NYDorM//fNAHIn43snpTq2My6Giqd1a6VMOMsqcu3HnoQxyBys
         G74JFCm9hyuRnl8Gjql4FXz03q1Cjgapa3xwkt1FqUOJwc1jti2UkL9a1hCD8Z4ncez7
         UzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723323; x=1709328123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1FkVd0ZOd4HuLhR6rsPDjyD4D3QNLPmtuC+OU6cTVA=;
        b=JazDIKyMot1bkiHbSNlvTTyzNeTx7Alpxf1lwEo4Rpwl/PN7WvryW59iCXO+6ZpRqr
         8/frjizHjG/1V+rTAaIUXDcc+0PM2+UbuebEjp/A0sdi9McphrQ7yIzD13HpwvrPmxBA
         Fj0lgTNfaxcB1fFGYoBgHmDIWr0v7D3uPkfej1l4pAB2ToVqwwwlvdlx4lDmkh/vrR/b
         DuQIT9knzYCo0LuGE0LnGj8wdqGiZjuo/OKhG4+Z7PfBY6yUoA02zLcAAZM2tsq2bKMv
         v+Vk3pjCtqYKKF5urpSDr/mg5xv3RZl+nJk39hHINOYn9/EkbhOqSIzPg3rZYepJDUei
         JVGA==
X-Forwarded-Encrypted: i=1; AJvYcCVOmMAt5nudTN86tih7hFd4ORFb2lzPe2qlmXRNQW964aB2/Nta8nwi9Sk9ACAKcy4QIPwZkkLicEYWiul4BkCqro5B8ho=
X-Gm-Message-State: AOJu0Yyo3IMy7ZZDOc7FI3o67fAkYYW2rw0WbDql3v3AOE5bA7sr6rsl
	pMn+Mv/09bEOI4uK97OvYFDa25Iy66mbq11k+ei931R6O+AFaMk9dfVQhry2tWg=
X-Google-Smtp-Source: AGHT+IGOTeJ72nc86iYe9aCP0RR8+Z6aDoD/m/NIKZ620up7wC2li1nmXfS7jDE9C25SuU9Ep338Kg==
X-Received: by 2002:a17:906:f215:b0:a36:5079:d6cb with SMTP id gt21-20020a170906f21500b00a365079d6cbmr656216ejb.56.1708723322827;
        Fri, 23 Feb 2024 13:22:02 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id mj8-20020a170906af8800b00a3ee9305b02sm4091226ejb.20.2024.02.23.13.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:22:02 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 23 Feb 2024 22:21:43 +0100
Subject: [PATCH v2 7/7] arm64: dts: qcom: qrb2210-rb1: Enable the GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v2-7-2d3d6a0db040@linaro.org>
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708723303; l=915;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/vlAxfs5pRi3jedgeW7eSy/wWzvCwowVIaHNbXcWUPw=;
 b=4NlbjUV1GBwZhD/RgzQVAtB0KvTlyLizT1CamJiEGMHqdxMJ9uLicJBWYxiAk+HFlJirPhazp
 Vg14+VV3wZTAdFOGnvbdNKKrCCVqvlFJbUo88fKB1HZyJF7PN0UX4Z8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the A702 GPU (also marketed as "3D accelerator by qcom [1], lol).

[1] https://docs.qualcomm.com/bundle/publicresource/87-61720-1_REV_A_QUALCOMM_ROBOTICS_RB1_PLATFORM__QUALCOMM_QRB2210__PRODUCT_BRIEF.pdf

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 6e9dd0312adc..c9abca5a7e39 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -199,6 +199,14 @@ &gpi_dma0 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/qcm2290/a702_zap.mbn";
+	};
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.43.2

