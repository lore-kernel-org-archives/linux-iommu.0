Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8F364D9
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBc9jZmo"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a02cc476581so594841666b.2
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102020; x=1701706820; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+c7o+g11wQaVIfs6Upk57wmZsR4iWH52vbiNHzvWM8=;
        b=WBc9jZmowKp5OWYGMJXiMQUPVZDChXR8unSzjYhwKWBCeqikAcnNLSmquh8EBBzAhF
         78Yna2V+niFtPLnleib2Zt15+K36ZRRYlFTkziyYLW5PpuImH3+yctthd653275wBl+b
         IFdSaN4lSMfOXTs3mRMVJh80PdvSJ9qgtQT2Co54Aatq/recX1fQgZreszrb8ySB14Zx
         iCzqOWFLFe7ZjKz5zlZeQaHtRn/p7chFuKZiQUQUbPrpiUMk4ao8UetiQaxYeE93BHS7
         MOCzt/JYUXKiYwj4QGhcdyz7qsYdDflGLSEb8g556VzqkdC4CVwL4lWSH/rJGKAZ/1Px
         Xk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102020; x=1701706820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+c7o+g11wQaVIfs6Upk57wmZsR4iWH52vbiNHzvWM8=;
        b=EN7tWN7bUylXH7xtD/Mxeg2G0061y2rTrzh5u52b1770k/EJPxC4BXeJ1DTVVtNNFV
         PgcVac5uvbKKMezTrsOlziLyuABueRVCBQ4R+pk3fZ3oammYDZhJRNukrEcDCeEGjtD3
         H4+RzSSG8aeyp8ItpMTJDznUB/EqwhANIOcbdhVshgcG2Q+Ss1GFTvzWpi5sCV/UNw2W
         zxCSO9ixLjA4DHGHeozNhMmxs4/8JRnPARQ+nEUsRNiT54zQeF49LvYvmrGHOav8iimL
         saN/3ycOuS9873PeqROFvXJ9r8D8i1tMTLKs81dKLHKLYFWKxPsxT3HkAMjDrU5udvo+
         6hiQ==
X-Gm-Message-State: AOJu0Yxy06PlzmRTuucfSN5yKe3qe9GaNjtVr04Ykm+eyfZ0EZVVcQQ/
	eoE5kBR878KZw2ApfN6V+ybh8Q==
X-Google-Smtp-Source: AGHT+IEqwnM1Zk0NU5iClHhAf8DuvbmDFdZ/y49v5SALbxoGoB9jxKWr8LOq25RqeNMDSYJdvz5jQg==
X-Received: by 2002:a17:906:1dd0:b0:9fe:4d14:800e with SMTP id v16-20020a1709061dd000b009fe4d14800emr9032787ejh.39.1701102020723;
        Mon, 27 Nov 2023 08:20:20 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:20 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 17:20:07 +0100
Subject: [PATCH 5/6] arm64: dts: qcom: sm8550-mtp: Enable the A740 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v1-5-a228b8122ebf@linaro.org>
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=668;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kZlLueRiP9pbt+9Wm47psoQj32zcJNffjpfPIXiL3Bo=;
 b=WRE83MLWSmpWessB7dY2coUQjzm2iYdVGzHYcmSdqDG6gP7YK80Ny1kvOBPNCJW7eUVt17kWT
 iGpNakUX2RMDVvsD7DpAWz4E9Kr/O4fKm9GopVgSiee5bK+ao4OTcRl
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the GPU and provide a path for the ZAP blob.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 9a70875028b7..52244e9bfdee 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -512,6 +512,14 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8550/a740_zap.mbn";
+	};
+};
+
 &i2c_master_hub_0 {
 	status = "okay";
 };

-- 
2.43.0

