Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012F328AC
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmBM0a0N"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so57887461fa.3
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098968; x=1701703768; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YptWvF1sLLHvvXfICRwlDYacILHWf1Qs1ovKRND9MmY=;
        b=YmBM0a0NKByYCKxezsK8M826cn4u9ORoHQYFYohyHz0ONFFo6ALnrQN2TCoihmTPc3
         AscpP6F4j+xEx0kwrmI8YFpKG+Kloh6mTy2RAxSc/LX4K12ULmTLnzDJ8z1x1fGD2ujS
         DbGoiT4pSP+7PTCKrZ4f1dcNcgIUrpdD0Sw5qboxTnS9ywCjnnFCjUGfl8wOaooIuhtQ
         Ca67yGMxdI6ylDg/THlO/rdCOeEIfxNV6AxZHkTAaxO67GT5e0l4ctLjfJ2BG8AVlgIo
         yJqcYqfAH/tV8kNUh3dmOmEjNq0rLbmKATIMgBcTQw+g0fY2BokGh3dAHVF2iDNTBxMa
         1MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098968; x=1701703768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YptWvF1sLLHvvXfICRwlDYacILHWf1Qs1ovKRND9MmY=;
        b=Pmo6RkhzpOYEr4k4Olca8uvW+PoNH8IZnubYTn3fiNQGizWhp7CotUyioc46gENAU9
         WH2j62Qt/z7Y07pnVRDzNcZE7zwV/9VBVKOTR84Q7X0xjzBDMBLElAm5K1DASN/hyJRj
         SQB4t6fgQefNUwODkkwjFeyBmDpkUpnRs+Cofnotj14+xH2R3ZlpTU/e0BCEyzr0HX9X
         WDk4+yx3gNCmie1yoJVbh3gGR/cU17qFMhZMKmyeaq4qjE1/7ktwfihrmE/TwRVOEueh
         90ATRHNXQDMaSCA5TS2+DCP5u9g4QacC4S9LVXog51GYWM+Yl+0ciuEu1Qvl7VpvH0DK
         7HHw==
X-Gm-Message-State: AOJu0YyWdvaX3C0XIrMwAzRCRHH71q2Cic/D/g4N4OqQoo256TEZ3eUO
	aESM7nAIdHys6Mo7u7PtwT1idg==
X-Google-Smtp-Source: AGHT+IF14HxXk/i8Hx/kT2HfsjYY7qz3ym0fgTWTtVIAQtcCIYmbezJEbnfTOuTnFP9xEd3AVxPqKw==
X-Received: by 2002:ac2:428a:0:b0:50b:aa88:c54e with SMTP id m10-20020ac2428a000000b0050baa88c54emr4234752lfh.16.1701098967944;
        Mon, 27 Nov 2023 07:29:27 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:27 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:51 +0100
Subject: [PATCH v2 11/12] arm64: dts: qcom: qrb2210-rb1: Enable CAN bus
 controller
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-11-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=1186;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JMbrDi2bxn7DXN0vpomcpuwaGp6goPBlt7d60Jxny0w=;
 b=0VzzU3nfCmJFD+gJXkaGnr4+zZVv+j1inpmS8tB7INAL8zVPNzqIYZ7zmhyZrAJlH4oEekE9Q
 +wduaJ8UzpkDuxe2KKgwcAvZ4AcAIKJVm/tTKiG1TisQfEGVZrHXPTQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Enable the Microchip mcp2518fd hosted on the SPI5 bus.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index ac6584164058..ac597eb3fe9d 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -23,6 +23,14 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		clk40M: can-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <40000000>;
+			#clock-cells = <0>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -449,6 +457,20 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&spi5 {
+	status = "okay";
+
+	can@0 {
+		compatible = "microchip,mcp2518fd";
+		reg = <0>;
+		interrupts-extended = <&tlmm 39 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clk40M>;
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&vdc_5v>;
+		xceiver-supply = <&vdc_5v>;
+	};
+};
+
 &tlmm {
 	lt9611_rst_pin: lt9611-rst-state {
 		pins = "gpio41";

-- 
2.43.0

