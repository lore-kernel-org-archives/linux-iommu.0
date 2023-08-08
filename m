Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936438492
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 09:44:55 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so9011216e87.1
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691487893; x=1692092693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJRcX7l83GzG4nljjiXsSgTVORkCZorOu6CVVdtQF3E=;
        b=FwiZRivLw+b6j30Dqlfa0OdR8cWxJe7FJS3Eu98iehs4rEHG8XlD4DuQthJ9CgHo40
         la1bXGL1RFgr5GLcaUqBBdxTxz+1kpZ7MjHphaTd03aCEMc2gEeWfUoWzgF182uzpscs
         SUZjI1uHCC7TX63M85GU8m5AB+wP7ti3nZd1N32a5FrobBDqEGAfmj/ok1wSnrpvAYo1
         M8ReC5IkwmhBw0hwjsnlPwpnS4TzShlBCSNGz3MzgJ/ispJj2MSOYCHmeJRCj5MwCkQn
         5IfDBUUzF700hih29k9XgIzd9MMTos9wgbWx0Kp6GyQF4KWi2AJtWvxTYx4mcIrRWRAJ
         ILMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691487893; x=1692092693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJRcX7l83GzG4nljjiXsSgTVORkCZorOu6CVVdtQF3E=;
        b=kD3tx0qNtvZORRbm0DI8RgeVSZrTygTZiSNnYqQdYQP/CZAd9XCl20zCNQ6gF+Sk1E
         Hu1KAbhbOBeZVoWXRTobVGo/WJE/tZTOCW7U2bq50BqYXfb2q9YV9eC9sZTmlimrlKur
         wpKbWombHmd8d4qCsazBjDcJzgRc47/UcgfEivhO8LReX4AeUKhOyr2oqhSffg6gKjde
         CtK6Mt6/V+dFBQB9rECC17xPwfwU7XJ3ZWRIUymU9S02y80D6WY+pwLplHW31KrumTEj
         zWQgZz8nwtIgIgfP08oHCqsvHFfJnyoPnfCEEKiNs9iEckNAbo9m76db+4YXNszJbU/q
         c2zA==
X-Gm-Message-State: AOJu0YwA7iMUTv08piBNnxUI+JWhPhysLbM5OfamWjdzV06n7j8L9WJK
	JW/cMag/ppUVIkUU3vXdS7+EBg==
X-Google-Smtp-Source: AGHT+IGHUT7VSfmI8VQtBPNaetpOWrfLKOPZbXgUnGq/oqs5MCTMjFVV+jNZ7mtrZHhq6p1BDeKZtQ==
X-Received: by 2002:a05:6512:39c3:b0:4fb:89e3:5ac6 with SMTP id k3-20020a05651239c300b004fb89e35ac6mr9893926lfu.62.1691487893637;
        Tue, 08 Aug 2023 02:44:53 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:53 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 08 Aug 2023 11:44:43 +0200
Subject: [PATCH v2 3/6] clk: qcom: gcc-msm8998: Don't check halt bit on
 some branch clks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-3-34273e275c51@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=1627;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4vcJD39xmmwGxR16do/vEynX3nfOkYLGbzSw65dGFMA=;
 b=t/2b5DxWk6eOZxBSMoG1WvSgfjtXnl9wcFAwd+sra0DiGErD9S3YZpkCbKjr1qwJdtT7FY3gv
 IJZo/StB+T4CsgBs40j0+BPJSYBAKHNwSKgL7MrSPgapI+FCbOr3UJU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some branch clocks are governed externally and we're only supposed to
send a request concerning their shutdown, not actually ensure it happens.

Use the BRANCH_HALT_SKIP define to skip checking the halt bit.

Fixes: db2c7c0a04b1 ("clk: qcom: Add missing msm8998 gcc_bimc_gfx_clk")
Fixes: b5f5f525c547 ("clk: qcom: Add MSM8998 Global Clock Control (GCC) driver")
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-msm8998.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index 1ba516a0c0f3..257b27d8eeb6 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -2060,7 +2060,7 @@ static struct clk_branch gcc_gp3_clk = {
 
 static struct clk_branch gcc_bimc_gfx_clk = {
 	.halt_reg = 0x46040,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x46040,
 		.enable_mask = BIT(0),
@@ -2073,7 +2073,7 @@ static struct clk_branch gcc_bimc_gfx_clk = {
 
 static struct clk_branch gcc_gpu_bimc_gfx_clk = {
 	.halt_reg = 0x71010,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x71010,
 		.enable_mask = BIT(0),
@@ -2099,7 +2099,7 @@ static struct clk_branch gcc_gpu_bimc_gfx_src_clk = {
 
 static struct clk_branch gcc_gpu_cfg_ahb_clk = {
 	.halt_reg = 0x71004,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x71004,
 		.enable_mask = BIT(0),

-- 
2.41.0

