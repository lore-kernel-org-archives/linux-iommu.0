Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6A182AB
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:24:44 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso3373992e87.0
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883082; x=1690475082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYGwW56BAscqG/0XM30LcNKT0W+nOLB99DFPYLoa8h4=;
        b=sibabZov11lA3Xz8hfW0CnXHL9Af+u9rZK5RCzkJFaCiw551/f9xZ8opO7gjVBdEuH
         4SIMesrNMaC72EWkZteivG5Mie8GpKa4ThW5V7hjw+/vbcF9jf3VlvaT+8jm5ehZHwMH
         jFEqhqLxglmtYkjRwWp0OxkupmtoUhVTMcGNMHbmDKaJ5WAQ5QC2SQuX4nowPy80xWS9
         8wRjmPXVOvdpRotfLb1w7oPL3+nDltxYij9cog3TMkkUlnFeOempPVVcUI4MxTNn3tLv
         OV3FN3H2RA/C8m4TNL1jQMauQWyhBuwzdh2hd+IV6khyZR4+hVIvIv8TC/K8oBljMk82
         f1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883082; x=1690475082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYGwW56BAscqG/0XM30LcNKT0W+nOLB99DFPYLoa8h4=;
        b=iCpqjAOTGQC0GZvTBApyGb2IMbOG1CZobN5amtrxTbs2JyFqH+nbXtK1EvcCjuO8Jf
         4NhyHyS1crTAQRry0256mErOJ2ZdaIaPp+bYhMoQCAml2n3xxNtORJQ3X0jVuayFMi7d
         7+fdDZajDpVo1/2tfdW9VEdW2u9xZLaspg37sT42Q+7SjLmHlB6DP0ZZUa8l39U0dvRS
         GvN3+syU/w7aay3DLSbckbor5fgIcQXJCME7r6yKm0KJSeu7iv5hbfDv6VCHlZCj/wYD
         AM+4CxZPjQ8c3vkr3qwDzNRuRIJkj741+O0GeIzT6+EdoeYJYLu38Jx/KnFcKed1E2Et
         Pq2A==
X-Gm-Message-State: AC+VfDwC1wqXkV7/VTSbWE38DqNmqKdH06Hg+mA47cyvod2HbIv2SvJN
	jpMXR5xHQlVfu48xSMfCix3IrA==
X-Google-Smtp-Source: ACHHUZ6lX9HpYxBjrECJJ0g2VIDJjeuZFhbfBiepWtS3n4v5ytBlMzMZaWyOH3hpcvldbLNDqBOUIw==
X-Received: by 2002:a19:4f46:0:b0:4f8:767d:9b98 with SMTP id a6-20020a194f46000000b004f8767d9b98mr13266735lfk.37.1687883082651;
        Tue, 27 Jun 2023 09:24:42 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:42 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 27 Jun 2023 18:24:18 +0200
Subject: [PATCH 02/11] arm64: dts: qcom: msm8939: Drop
 "qcom,idle-state-spc" compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=1417;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KPBhSzTOaGsAxteWT+99n4sapq26eBljMzOXJq+YN8U=;
 b=7EVfTk09owESIRFxaijnEfMskf7M1hyXNYPlsteOAdqP/jSMvA3awlLrUye0s9uVnU2WKwmNh
 nJELXr7ZA9QCRbfxrzR6dCs4sjLsMeuIeTO+P3N6fWRU3Zb/sUlBmU4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

As of today, the only cool and legal way to get ARM64 SMP going is
via PSCI (or spin tables). Sadly, not all chip and device vendors were
considerate of this in the early days of arm64. Qualcomm, for example
reused their tried-and-true spin-up method from MSM8974 and their Krait/
arm32 Cortex designs.

MSM8916 supports SMP with its arm32 dt overlay, as probably could 8939.
But the arm64 DT should not define non-PSCI SMP or CPUidle stuff.

Drop the qcom,idle-state-spc compatible (associated with Qualcomm-specific
CPUIdle) to make the dt checker happy:

apq8039-t2.dtb: idle-states: cpu-sleep-0:compatible:
['qcom,idle-state-spc', 'arm,idle-state'] is too long

Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 05d8abbbc840..38fc22e66bda 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -155,7 +155,7 @@ CPU7: cpu@3 {
 
 		idle-states {
 			CPU_SLEEP_0: cpu-sleep-0 {
-				compatible ="qcom,idle-state-spc", "arm,idle-state";
+				compatible = "arm,idle-state";
 				entry-latency-us = <130>;
 				exit-latency-us = <150>;
 				min-residency-us = <2000>;

-- 
2.41.0

