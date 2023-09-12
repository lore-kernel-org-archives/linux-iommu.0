Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC7377
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 13:32:02 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-52e828ad46bso7339514a12.1
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525521; x=1695130321; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y15C8Fv8QHJExv9aOHGDEKpdbaBfEIqNr0Cf6pow0Ag=;
        b=n2zTFNn3ODbQREfTiQMNcabc5mDlY+8lF+C4VzizYU1kH4E3CtxbOL0+jjdxXX2t5P
         /hNdzy94qT7NFM2996si95HMrO/UPndLSfSHSfy2l0WIbSTQeL09gEQdsIpu8ChJkK8u
         KYImcY1L1sapIyLZ+VpwDW5uKi+asvq/TxIxFbt5U82wzRJg6jkN+jS49m1T+HhbF1XT
         IsSTVSLsR4kAw70TRsrRhObpy+pnvm4MRdOrtRwgItj92tHJi0SdgDLjPmEQzQ4XgheB
         nLV5YT1gMfQjAZAlbUfTiKJcVzUejRES+UTgMFuG8XhfGtPQZ7dgOrXkEFFTmr+gm9+a
         Y3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525521; x=1695130321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y15C8Fv8QHJExv9aOHGDEKpdbaBfEIqNr0Cf6pow0Ag=;
        b=cxEnBdDlOW9d5a3RyM6WD8JZMGREn4aCrl4FxiJiRig8J0XL4duA2rUdvbrC0n4DLn
         AOLFe6rcGVnEuPA8wVuv9f7aBrweg3LKSVfHmOqo+3ifZsmz5M6zTl+qPT3mzkR6haQr
         ZZOPqqQNEEZSSdA/SDwaC2SA6sJcH74UhfaigUBlHdU4ZkM+9sFMMkUaEQV3zgo1vF1S
         Yedu7wfjZRUBIImD/kBUrSt/4YsOLnFzLAx1JDUbKGkMEr+XWHKmpqieA0YK0xq7Z2su
         RkvqIsuIX6O61c7JWZnkHZkhZgnQsliPteT+iLlOE4C3uO4l/+QTugX8kLIsdTiHwPPv
         QlfQ==
X-Gm-Message-State: AOJu0YwL+ewwuous25+HlMVeU/FdxejOw10q8diIp624syjD0A+5v7Vc
	BnYsGk+zafHlMHkQAlYSTQoJQA==
X-Google-Smtp-Source: AGHT+IE3doayARluv4buJCGo1gFXhllVuL8rkaKATeR59HGZ3l/xPGTkeTXBDZpVZHKXxV2qHfkVYw==
X-Received: by 2002:a05:6402:7c7:b0:523:3f45:5678 with SMTP id u7-20020a05640207c700b005233f455678mr10703279edy.31.1694525521218;
        Tue, 12 Sep 2023 06:32:01 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:00 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 12 Sep 2023 15:31:45 +0200
Subject: [PATCH v2 07/14] arm64: dts: qcom: msm8939: Drop RPM bus clocks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-7-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1626;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hTGKHTrH0J17CafSs4xXiO5hAXDwGff4qsoi0JWwbnA=;
 b=l+QgN/I9sJ1LySbRwaJMmRSPxHrlPgUlyioN0ie8QDsjFp8u6rYg+lKqT3jjZ7Apm7mhB2dgS
 PSf1efuodKDA5yu/qkP/pv2fKUCJuDLwADDK3n+SXTx671DVTtqp0Da
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 6e24f0f2374f..e3d1eb7dd289 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -581,9 +581,6 @@ rpm_msg_ram: sram@60000 {
 		bimc: interconnect@400000 {
 			compatible = "qcom,msm8939-bimc";
 			reg = <0x00400000 0x62000>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 			#interconnect-cells = <1>;
 		};
 
@@ -627,25 +624,16 @@ restart@4ab000 {
 		pcnoc: interconnect@500000 {
 			compatible = "qcom,msm8939-pcnoc";
 			reg = <0x00500000 0x11000>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
-				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
 			#interconnect-cells = <1>;
 		};
 
 		snoc: interconnect@580000 {
 			compatible = "qcom,msm8939-snoc";
 			reg = <0x00580000 0x14080>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 			#interconnect-cells = <1>;
 
 			snoc_mm: interconnect-snoc {
 				compatible = "qcom,msm8939-snoc-mm";
-				clock-names = "bus", "bus_a";
-				clocks = <&rpmcc RPM_SMD_SYSMMNOC_CLK>,
-					 <&rpmcc RPM_SMD_SYSMMNOC_A_CLK>;
 				#interconnect-cells = <1>;
 			};
 		};

-- 
2.42.0

