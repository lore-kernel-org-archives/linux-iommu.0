Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A18492
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 09:44:57 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe10f0f4d1so8993933e87.0
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691487895; x=1692092695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAg8mzz6tXJyaH1tEofpHQ5TEsFiQj+ho2hy+w4Tmaw=;
        b=ca5JW3Xvljn6DS1Xd30alZ4zxwYWFfovT2/rBr10h3IRpLg6vWyhTXUfMMgEyXqjTf
         fVDwI1brYe5iB+WTXfMIV1RDdxF7O5GvXM0qXs0nH55nSS+hJ4An72Q1UINLCpwN0qUz
         2fFCXnGgDe0vK3E9HfN29br11SFPCQH//SDWZqJ69g/t1hS0kzIZj2X4vIBtwGdACO05
         MQaXEif+bHQApWXNcjRX9OE2oHPylbrNc+zQwy8c69Ex5aUrRsemjdGkXgncPXU0gdNS
         /dbIXvpSj07PckDr1QK7ijnoXXkwb77lJnIgx0p7wwKkH8dBqwCJQHZllcz0ypf1OX9H
         vW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691487895; x=1692092695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAg8mzz6tXJyaH1tEofpHQ5TEsFiQj+ho2hy+w4Tmaw=;
        b=JL77Iz1RgV8LtaBFva6U1Cwhk7jxXTkf3DBJZgHej7+WHIzBMVHpwoKHkT7QcaDLT8
         cCt5x+t9KmFVWOJkLXVQIeRePMVPRuQ57SHphbvdANe+/enSeHfRVBOTfRyw91I+144N
         5tCrDxIIoUEnMRGc9ub1qYwmR3foHmQcOPtQrfh7y2i2beJCocjOwiUWh9olgSMvDxRe
         tfsbZIJsujpdHaPMW29t+VXcq1L2G2q/ZbKx2BmyKxgqxlslgeJmg6OQ/xVqmL+48kLx
         yU0PPqtdE6tE+FCnbZmKGaHE50dqo8rMcDYNwxucP1avzi8fbJrS3niIXWxAVm2jiozo
         EQRw==
X-Gm-Message-State: AOJu0Yz2HbnIJAqH+v3tC+OILt4NYDb6Jy2T7v2iEZHcDY1GS0IYWi73
	BI7IVkyAl+2jWBPCvAtXGIAA6Q==
X-Google-Smtp-Source: AGHT+IHZdXCtug2ljX6dDSj6oQkG8V1UJLNKTYOKnSjmV42sR9+Wv2CCmrrKVl5VAmfJlHe6DhBOLg==
X-Received: by 2002:a05:6512:2018:b0:4fd:c771:ed86 with SMTP id a24-20020a056512201800b004fdc771ed86mr6615303lfb.67.1691487895251;
        Tue, 08 Aug 2023 02:44:55 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:54 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 08 Aug 2023 11:44:44 +0200
Subject: [PATCH v2 4/6] clk: qcom: mmcc-msm8998: Don't check halt bit on
 some branch clks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-4-34273e275c51@linaro.org>
References: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, 
 Imran Khan <kimran@codeaurora.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Joonwoo Park <joonwoop@codeaurora.org>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=1407;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=haDOFYx+cWB8WYF0AFsxGiNUFhwDHpLSQyDe+vgkap0=;
 b=ZrMZ0b0kru/BioU+kcPyTGDosiv5UYR3dvjZ97R7NYb1CKIWbtfb6OQL9uoCg1eDGTN2RtwgC
 KnIylLEWD68BzoXZqSp7GXw9MgJJMQxVOqARg8YLk04oG4zFHl8Kfq8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some branch clocks are governed externally and we're only supposed to
send a request concerning their shutdown, not actually ensure it happens.

Use the BRANCH_HALT_SKIP define to skip checking the halt bit.

Fixes: d14b15b5931c ("clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver")
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index c62aa270af1c..d0a5440e2291 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2452,6 +2452,7 @@ static struct clk_branch fd_ahb_clk = {
 
 static struct clk_branch mnoc_ahb_clk = {
 	.halt_reg = 0x5024,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x5024,
 		.enable_mask = BIT(0),
@@ -2467,6 +2468,7 @@ static struct clk_branch mnoc_ahb_clk = {
 
 static struct clk_branch bimc_smmu_ahb_clk = {
 	.halt_reg = 0xe004,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe004,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -2484,6 +2486,7 @@ static struct clk_branch bimc_smmu_ahb_clk = {
 
 static struct clk_branch bimc_smmu_axi_clk = {
 	.halt_reg = 0xe008,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe008,
 	.hwcg_bit = 1,
 	.clkr = {

-- 
2.41.0

