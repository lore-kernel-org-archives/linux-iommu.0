Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173424216
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iy2fFfAz"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c9f4bb2e5eso22135951fa.1
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694549; x=1702299349; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNQ9eoIjbihkMBids/A7yvSvLEz/1dSNBCDwED7GiWA=;
        b=iy2fFfAzKjOle/8cSq3G/HjfePQGPWM4tbcVLgLKq+nXpBAdGPLlq+pdydeQ3b3lD6
         04sPFe12+cJDxFNKerzc7aTIBbKgYihqOZiU9QxNHFFn6MP/PqMxJxEewS2Qq3MCI0RC
         RopCW5m66NoSVY4o5usxB7bRbubsJ4KgYJ+6N1gmVVPUxyquzNNyCAo8sO3uAnW1UNyR
         KFMS9tg49wb7QGaRYyKTy4MlB/oOmyOI9eWOoaw4/8sXNUHXoPZnMku3JniU+fBGdVTs
         BHHN6DnIanHTn/nsd7spt0VDN/p/0RexIB0ZUazSEH01/ttEsdfmMrrOfNsIV2gp5Gfk
         sVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694549; x=1702299349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNQ9eoIjbihkMBids/A7yvSvLEz/1dSNBCDwED7GiWA=;
        b=WSquai8dvfHxsNpCUs5z5PCnpZV0eiDKVTFuTw0jbZ2pWZEOMhvylP+Bm5tAz9ADr/
         PfFBUz4TRld71Zl/gpXZX9WphaDWtY3p15zQ7pv1stc3mOY3BWxIzFOZz4IX+hxkORQ/
         vX8iftNDOfwsM69xtNEJCXQFQS6MKK1Rkt/u5LHbv5Muj2EckjxM+vlY+ARm3ADx/qmV
         7iaqR1KE1WiDk/HXScQz0jsurplfB3LS9Kmo2ZsQP63Yd9bC9e+Y6y71IIeSgDcuQfxo
         +dOuK3oh2bn4zSmkIUOmOew056Du+bUQeuG3+anuJGDYjkPohhBVJLV7DEfKYxiZEo8b
         d8MQ==
X-Gm-Message-State: AOJu0YzkHM68AtUpSf4GIZJ+t3VvM3dGhaelbpRWltBN+RGKeLqvntHQ
	Q1POTTEudYh1VjHKzVptwUMEYA==
X-Google-Smtp-Source: AGHT+IH4SmbQ/yfFGY+S1fotYDWx2YJj9ibDEy0bCNmkp78l1pCEiMegKfwF5e3/7oHwxwx2RHkA5Q==
X-Received: by 2002:a2e:9455:0:b0:2c9:b8b4:849a with SMTP id o21-20020a2e9455000000b002c9b8b4849amr2402449ljh.13.1701694548843;
        Mon, 04 Dec 2023 04:55:48 -0800 (PST)
Received: from [10.167.154.1] (178235179097.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.97])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm5241373ejb.150.2023.12.04.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:48 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 04 Dec 2023 13:55:25 +0100
Subject: [PATCH v2 6/6] arm64: dts: qcom: sm8450-hdk: Enable the A730 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v2-6-2a437588e563@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701694533; l=742;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5wrD+vCj1p2Cee2rl5pPwaxhLb9h2pOZBD/QHizMBSw=;
 b=vmX8yPPaJKbK1Wbx4M2B51h7DEAnbLVxVGAYZqmt+w2sqzK4Pygh9iEsbPCNUPEZQU3p6/yte
 scSp8FFO7+mD1svtKUGpstIdPzgaFqF0OjkIucB79ENPXei3wQ73c6O
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the GPU and provide a path for the ZAP blob.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 20153d08edde..a20d5d76af35 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -580,6 +580,14 @@ &dispcc {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8450/a730_zap.mbn";
+	};
+};
+
 &i2c9 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.43.0

