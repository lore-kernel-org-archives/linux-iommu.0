Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7D19E7E
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:25:06 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f954d7309fso25373e87.1
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883105; x=1690475105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4mJfqzmvmApW4Rj1dXVWyxSwPO5WPkCbtZ4OGaD398=;
        b=SZy5l5RUOGcrmQW/jdYxGFBe0gnmhxq4QnEAq3v3QfdHzvrew39CDPEdKUkyJjDTre
         XvUlJVp8t0mEoqTyn9Pwf0qePjh+XLG0D8ZDl4ymxEss0hnXLzD8H132evKnb+dI7q6g
         iIwcvLwnGCQ8Pa+uDypTqnm1E9xIg+FOVFuJ1VvdcvaWH0SCIxkJuGInbDX+FjGxchDS
         UfcnzabUq5XzSz4XjJ46q802SSMdmCkrm4AGkTFX+xmI4E1Rzb9SltzEldkBp2H7Svua
         YA73OoB/WAuT3vc362D8wIQrf8gMgNrnI6bS0CHL03TeC95uPtBmLQ5M3j1TLoOzzIWn
         OFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883105; x=1690475105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4mJfqzmvmApW4Rj1dXVWyxSwPO5WPkCbtZ4OGaD398=;
        b=kn1S6rbj7tB2cTL2x60dNoITO8IxqPcpLdeRGt5PWtQGKRcDLKi340fLto669wjHtL
         terRvgB6IHCkKonNWq1vL72f9xwg/rdSJECzuVDmxKPsVSMapfPiNE3yPOKN820nOZ6I
         uWi4vfzzu5sbt2XthNNfTt+W/8QsPNgy8EYuZfGBBWFj/Drr30AiqowXRMqArUHMBJ79
         Cybekd21QHx3DiTn2MxrT1aDKbK49ZBtZ/0gEkjE6Oy1r4VMc+NQEDgzIk2bIwlLP/qA
         sdG7OnuK+GWshJR2DoQ1NMO/nF8e+oyTt3zJzNj4NWk9xuaUutskmVXbgR81oDaMfSIV
         YqGg==
X-Gm-Message-State: AC+VfDyC4FgR8JCOzlaZiXQ18ftbscmbid0tvUIVavlBTD6MmL/JtBJH
	rI4Gqx4Bs49fYwZvJty96KTa9g==
X-Google-Smtp-Source: ACHHUZ6BlsiDYElcMxfXy6yWsewsR0fKcoCpVeJD1LLcD2BVrW44G37On0y3gt5ZzXkA8F3J/hmvxA==
X-Received: by 2002:a19:5007:0:b0:4f8:52a8:d123 with SMTP id e7-20020a195007000000b004f852a8d123mr11226655lfb.12.1687883104785;
        Tue, 27 Jun 2023 09:25:04 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:25:04 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 27 Jun 2023 18:24:27 +0200
Subject: [PATCH 11/11] arm64: dts: qcom: msm8996: Add missing interrupt to
 the USB2 controller
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-11-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
To: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Benjamin Li <benl@squareup.com>, James Willcox <jwillcox@squareup.com>, 
 Joseph Gates <jgates@squareup.com>, Stephan Gerhold <stephan@gerhold.net>, 
 Zac Crosby <zac@squareup.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, Jun Nie <jun.nie@linaro.org>, 
 Max Chen <mchen@squareup.com>, Shawn Guo <shawn.guo@linaro.org>, 
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>, 
 Andy Gross <andy.gross@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=831;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Quz7pP0P5pjmtegvrsM8rd2Kfjx4W/mMKGAUDarFvWQ=;
 b=ZqlZW1EIjz9G94JII5XehUxnYwlV6O2ulqbfYf+vErKLQwa8/fgJxHsYBw7sTROnVJyMrEv0+
 bXnzqhh0QtJAbJKp7VUNhfrqDtonJ3y69Bbkmt1g/AhS2C/32mzlFdb
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The interrupt line was previously not described. Take care of that.

Fixes: 1e39255ed29d ("arm64: dts: msm8996: Add device node for qcom,dwc3")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 85d9d12f0c2c..7771d2909120 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3386,6 +3386,9 @@ usb2: usb@76f8800 {
 			#size-cells = <1>;
 			ranges;
 
+			interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq";
+
 			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
 				<&gcc GCC_USB20_MASTER_CLK>,
 				<&gcc GCC_USB20_MOCK_UTMI_CLK>,

-- 
2.41.0

