Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D6364D7
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSrNyraE"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a04196fc957so645796266b.2
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102022; x=1701706822; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gQ6YImSRCbx+1xRUL4mfy0bfTlxIzI8pSH1DPk4t6M=;
        b=TSrNyraEvh/ShSxWb5ov3iEqU4L15/FU3xg6cO4T7ckSop87y4J+f+rr4SA8azktpp
         s9s2zjFg53a87BqfTT4ROKP3tGSovq5UngfflCDBskDe/SuFYB2KlxQ2YKVRjal4Y17u
         ZzBUMoPNuWOrn6rA9+35n6jvJGee+O1TKsKPDOfMlGOayYHmH2HFPVqEVleZOlGkAfRF
         djtrptdgTvTTXkFl6lBGlBQt208d2R/mSpfZjqa8tgRbEtKl4Q2oBO6dk+aJeBqqq5oA
         9BeYJMV/3jQ0YUuw3TgMI8lH9KE5BC4HixsWssMiEtOb2XZk11rb3q0XEdVEuVNV7+Zb
         aUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102022; x=1701706822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gQ6YImSRCbx+1xRUL4mfy0bfTlxIzI8pSH1DPk4t6M=;
        b=b1VQo1c2RcY9G1aVGsfGvQZp1ktCOtoURR/ILXXiGMQ0cGTLFIjxX3ucnAmgUSbKvJ
         fNymPCACLKWr188xx6zR5AdB8v8kV0fkV4+YMXUlnFidcAqSQPSjgO83N6jHawRqwPqB
         enJJDbRRhCPUuoXRqmFUX6DEy6MqidMUnlLJP/S+9p/EZEGvNBs8OIYLqLFBTvHlGkrm
         3Oq6AkwtDRIcxd5WlIcRQpoqe+XDELzq3WvhtP4paIP1DenqDiBIxAP19fMn9ojuI2PG
         r2HGeuRwSu0i+DfWY9DIXe4sDD2Qqagr4gWc//FeM58LGyQYJW7ng0efyQwk3pPHiQyV
         ZYYw==
X-Gm-Message-State: AOJu0Yzm/ZI8wc36kZgzio1gQyDBwI88m7oAOqY3rnR2sTY4zrObupJ3
	7emvUAHwhR42WOvxD5svIYk97g==
X-Google-Smtp-Source: AGHT+IFPmWmSTHMcfL1yecPUgSq8wRk41FMgkXe1PITU3Isy6yZrSpKslVtSqdOYlcbiQ944Gj61HQ==
X-Received: by 2002:a17:906:3e0e:b0:9c1:edd8:43c2 with SMTP id k14-20020a1709063e0e00b009c1edd843c2mr8518492eji.42.1701102022689;
        Mon, 27 Nov 2023 08:20:22 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:22 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 17:20:08 +0100
Subject: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: Enable the A730 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v1-6-a228b8122ebf@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=685;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZUlIcXR6hgLx+DM+J1BHsWNt1eWJies/ihFtsM1lhWs=;
 b=Cedfa+rVMp6sij89sdZZMlPzRmUJXcuOfEsRWBEN2D21fqvMOO59apxBjB3KBAs4/TDPO0Kqr
 SYlvJAJGZQ/CbFapt8rBADbCSma58YbPuNklA1x7+9wefmw9suo3yzI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the GPU and provide a path for the ZAP blob.

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

