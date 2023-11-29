Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA532C81
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3XD7E1W"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a04196fc957so977724166b.2
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269081; x=1701873881; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uv9zfaf6z99knWy+mQD+FqbIWFj2XAGtTYBT+VcDlo=;
        b=L3XD7E1WqxEuy3AKIpalepJ7Bh0Z9FUNQD7Tgt1lSxQW+gQlus0TZhMhCQLeaGUJTA
         lVlH/PgMBgsYJUAXm/E3aQGTUC6vkrdcL05ZXvA5xzy6imSoIyUV9Tb8Gt8orC9zaRzX
         pNmtiPaw5sxQ/yK2tZVGN+HQeKniekwqAQoI8LEPrhPyvlsCRHDumgGM2FJeSktxvhhl
         PxN90PP76A3ingWhSMPl0CCEYrJM7WNj86ABfZjHL1jl7OU0ZIUOHsgTG1Cy/NjqW9Vt
         3HJRMyjLwPRZkePpJS90F64TCtkoOi0ws4oaG87bKAdYvAjqxfJ8F0Y1M9ncMw5vEJDS
         FUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269081; x=1701873881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uv9zfaf6z99knWy+mQD+FqbIWFj2XAGtTYBT+VcDlo=;
        b=wG0Sf7t4mmACWbsJh/TWUIf3kfezn6XMd05lzkFVU/NQLpernohYmDJm8I1vQZ2VET
         vEevzdv6dzPJVInMZkVoKqpz6e3AjPrKVqQSRblfikX3CxBCkpfoskfRy6mSzR89FdBK
         Vrp1USDpF2UE6dnBkVErvfnOziG8ZqSu3eTVh7QdKzLLZYDFcCOZ+t/9meo/nk2HI3Ld
         duNrd1m8M0tBFgiR+seLzSing6hnbD/OBGu73GuPWYw9eW5gzyvN14lQQjxsCC813X/+
         tx66bMnQdTltqHLpr25Xxn2V/X25X7eVm8S9L9puj3PWiDxL+kKE56ojZZJOftl1rL7K
         u7wA==
X-Gm-Message-State: AOJu0YxiIVQ2cOao07dibmPKKX67KiKpXMMffpKQl+84sX577hOlsULt
	uX9A/4ERoYsgLFqWgfTTv38+vw==
X-Google-Smtp-Source: AGHT+IH/vXkw0enMe7jjwoBb+lnZfRyS5aO1O8s2vfXdceOl8FZPhdJNVVAhGjenI+fDmgsaO/vHsQ==
X-Received: by 2002:a17:907:6b88:b0:a11:adc9:d14e with SMTP id rg8-20020a1709076b8800b00a11adc9d14emr6306159ejc.71.1701269081664;
        Wed, 29 Nov 2023 06:44:41 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:41 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:44:07 +0100
Subject: [PATCH v3 10/12] arm64: dts: qcom: qrb2210-rb1: Set up HDMI
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-10-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
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
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=2405;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7zIWcZYNiLUFpSiqbz9ETzUeMoZvPDpFqV4bp5urq7I=;
 b=sB+64YQKn6yoWshqZCZ+xVNWQ5kgrtmy29piu0Wsi8nXSWUNAn07BSj+gyt4rmqgsQtWaApR8
 nJYCsn5ZpY+DuB9A7y6p+2C11Z7QRG94ErbCwzs8mK+tTXJMUpbWuVV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the required nodes to support display output via the HDMI port.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 94885b9c21c8..ac6584164058 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -40,6 +40,17 @@ key-volume-up {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -158,6 +169,68 @@ vph_pwr: regulator-vph-pwr {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+		interrupts-extended = <&tlmm 46 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&vreg_hdmi_out_1p2>;
+		vcc-supply = <&lt9611_3v3>;
+
+		pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
+		pinctrl-names = "default";
+		#sound-dai-cells = <1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&pm2250_l5>;
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &pm2250_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
@@ -377,6 +450,19 @@ &sdhc_2 {
 };
 
 &tlmm {
+	lt9611_rst_pin: lt9611-rst-state {
+		pins = "gpio41";
+		function = "gpio";
+		input-disable;
+		output-high;
+	};
+
+	lt9611_irq_pin: lt9611-irq-state {
+		pins = "gpio46";
+		function = "gpio";
+		bias-disable;
+	};
+
 	sd_det_in_on: sd-det-in-on-state {
 		pins = "gpio88";
 		function = "gpio";

-- 
2.43.0

