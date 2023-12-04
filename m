Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275F249FD
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLQekZjN"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54c671acd2eso3466616a12.1
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694546; x=1702299346; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYBJZvf16al31yAEkvLrTZBLEk08fvZeDLHzDDQHdx0=;
        b=JLQekZjN0Zo3/mSUFqQnaLsPUhJAS66qOgm5Uv2gxshhfhFDlhYPcTqCs4MfLsVE+N
         ZhC8aSo60D80EOGqIkekpGAWlHXSWllr/Ffh7mijmfLZ04/6viBw/Il4PMDvbqk/qR+f
         HHYNKjoe9RDWgdLhJlD6nmUmh1DLvaWOsSIXTpbJQ4I9sKc5Rt0htGyBboZeBo8l4EsS
         iJsFnvuueSiHxHL40jziVnYrIW4yNrhsYCtDUbt81Sz1RtxGMnzA7U577RqcIjB6FXYW
         5CB4spkrXjUkaECuQGtRRE26hN2W3gNfpVkEwz8moYi3PN+CoZEWzknlI8HQM3jj5hYe
         I5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694546; x=1702299346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYBJZvf16al31yAEkvLrTZBLEk08fvZeDLHzDDQHdx0=;
        b=OKw/6/iGRBh5FNzdIwuisOq4lE2iaA7TjcLjpkmHEA78ZQpfbDAI2rH2PxPdar0hjL
         JPIV4+y8PB3edagJscW4Q5tbZxUssdG0WwhwG7A8wpKLtrnZmKaiX3qkvyERY5le0o5B
         bCLNILVUvAzekkbC/Awo3pfO77AEqwXpQ9biVpXy0udfOU19jkFwT5q9DoEta828vszx
         Gl2I3ChYEt58xgSXX/QCXsk/BjWZhRrQbz3dXw6beHmjPR4FKFx3r15IZCtr0sYyCvfq
         /6OK0w92n+SuJhk3DxAjY5m27Jd0JGcv/UVdkQQ1GB7DROCFZeGhej8KST/Jvn3+P8GB
         j7tA==
X-Gm-Message-State: AOJu0YwMlEZdEmnYekmaAnK7Jd+EmVuIidZwqyI37Oz2YMHEEdKqaEKU
	54G5ZXLvE3h/Mn4VXHGKSgWRiQ==
X-Google-Smtp-Source: AGHT+IHoHO9TKConiwiagXCkku3lVT4S1J8QynxoRRmySDKBpuPSv9oHBFS3wp7AR1UsVLO+J4Qu9w==
X-Received: by 2002:a17:906:da04:b0:a19:a19b:c72f with SMTP id fi4-20020a170906da0400b00a19a19bc72fmr2953051ejb.127.1701694546652;
        Mon, 04 Dec 2023 04:55:46 -0800 (PST)
Received: from [10.167.154.1] (178235179097.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.97])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm5241373ejb.150.2023.12.04.04.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:46 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 04 Dec 2023 13:55:24 +0100
Subject: [PATCH v2 5/6] arm64: dts: qcom: sm8550-mtp: Enable the A740 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v2-5-2a437588e563@linaro.org>
References: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701694533; l=725;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9FJMq5XZXBPBjP7KOy0b1q2lfGMXMmYwfkQChVXyG58=;
 b=dZQFJAa43yRKRFVuhYC59lVTywRwiU+Z0ruBiOuzMDG984BZCFwibm30OYopXSQz1iEUiR2Kv
 fnvSNpONBQeAECiGUNL/pvHsWJ8Izr1Y1LW3p+shWU/3y27ivta91tX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the GPU and provide a path for the ZAP blob.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

