Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC4249EF
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pG6m5JhQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a0029289b1bso572564766b.1
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 04:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694544; x=1702299344; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QF1YIXWEgPxBBuUeInrydPVHlwVtxwvmFaOgA3MM5Cg=;
        b=pG6m5JhQRbCKkuB1NA/sWzeziMXaoZLefr+X3CziSvGsihZP+kOgW3hHpubNT0fmKp
         X7sISXbV9ds51A3nACI6Kmq9w31P8dRKSMjF+bvMmCx7wLr97Y7HrJ4gIrarHZNelciV
         mVFW0SJN9qJqHDKSfTOjParqsQKAR1CrDVNVHBsyhW+tQAXV+Vq5JXcmc6x/zCbj5tff
         Yix+maAoj+BewfF6/y9J1spqULQaBWEB9JPeYnKkpvivA7iqqpGs9a+9rJ/t6+aIPGvb
         4ZPqFl0GNGxTJUM+KQzJdYx1WfOWRkh1DGwHWHCyyAyG4S6oaHix4sJnzalLl6iKGWb4
         M3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694544; x=1702299344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF1YIXWEgPxBBuUeInrydPVHlwVtxwvmFaOgA3MM5Cg=;
        b=PGYo3WbiVApaHhsiFJ4I/rZIsVU6OY5j2417lbaIIA1JRk6lw46/1DwdvBC4cCAoJM
         SccsE0C1opUjetpD4MOylWpKmXigU6LaF6AiAOYqNik1JZmy6sip9C/eiN1FncBA3AJm
         ML20YYItDy7Fhr7hMSS/89w6KTM00avNAu/y4uzLzajlyyiV8HMTlXM9mziY4dfA+AJK
         IxGVBteivC8d/RXoKAZVn53g0AXA88fYgmr4Ra0TbK+5gaRY9I/aM9YWiRuRYQkg/MMR
         hlQzzkgEM2JqGvIfGEXU8Vk1QHPkIoFYsdF3cwSlvdBbDYjKPCyYifmYgP/MnnP9mjHW
         VsYg==
X-Gm-Message-State: AOJu0YyDMnpm7blz8nMjNJ2XCNFc7UKf7kHjA69ZgU4lZbZU5BsfxkGE
	o4tRleZE+IFtNrvHoeHogttsgg==
X-Google-Smtp-Source: AGHT+IFeIYz1iO3KsYQ3qcBtBpS+Vd4YXm0h7XwncIOh9jeVwFbwFlOur3jXmcXfiTKrzIuS0d+soA==
X-Received: by 2002:a17:906:748c:b0:a1a:4813:e833 with SMTP id e12-20020a170906748c00b00a1a4813e833mr3118246ejl.67.1701694544222;
        Mon, 04 Dec 2023 04:55:44 -0800 (PST)
Received: from [10.167.154.1] (178235179097.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.97])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm5241373ejb.150.2023.12.04.04.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:43 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 04 Dec 2023 13:55:23 +0100
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v2-4-2a437588e563@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701694533; l=794;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ijt3beGGSYLGoF3RtudvbmIRYSlskid0fUlPyla+S1o=;
 b=P8Y1u7ibWzTnMEQ9WLFkXk3Kn7plZq3rCoAPCAWZDO5x0/PeBqpACFWtPPlp84QwwtRGPBU0A
 7DzHQ4qB8fDA9YJfk7dZm7zWziRoe9UMMtcZqfPkUhEnKIhNS8b4onq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the GPU and provide a path for the ZAP blob.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index eef811def39b..9fe51d308675 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -596,6 +596,14 @@ &gcc {
 		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8550/a740_zap.mbn";
+	};
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio17";

-- 
2.43.0

