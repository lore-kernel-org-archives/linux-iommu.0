Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3B24503
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 19:20:39 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9a828c920so2621081fa.1
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691608837; x=1692213637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJRcX7l83GzG4nljjiXsSgTVORkCZorOu6CVVdtQF3E=;
        b=J67BqW4PzqZ3LQWy0xRUu2fPeiS0tkYFmGkV8qggyN4tk0Dk0oUfVjDADdP0QFanwR
         olOGQjV3qFvbRfIGzyqylFnevJTih4Dpjdu8EtcMJ74XvJl8YZfUoLa90KrTAMGprVLI
         bS6OLJehb/0Hh/fLPS85pVJuLlki/+tZ/9KG7PxDHOipRiNsBCUka2PHikg1QDidIXQl
         B+Hkg8Z3Opm1oBnCxg+ky7ePEN23reVd9SCgVz6w8aqbIrWezCMq5BwPT0FaUpyV4uhz
         wDjt/ZV0LlftrlbmAyB0UyLRPI5n/JPFDhmaY6FOQhEHx1MTU25pjWb2MIrSHWvkQ00Q
         fNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608837; x=1692213637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJRcX7l83GzG4nljjiXsSgTVORkCZorOu6CVVdtQF3E=;
        b=jgc3/6BkyOmJETkco3c3MWvVhAmliQ1HLwK85ZiolBUhPPSuCtst5DBRdBjLY+B4fZ
         NFBoavfLT2KkQgiOXZehgb+JIgY/jDzymkyMG/PBuqYVDCeAh06xodOBuddfXqC9G710
         Hu8ZSCWS0A4lbCV1jdeOH3n4p+lEBAHCmWRRsuJR3V1OhAYDPmTjySLYHj32tYKX+qLa
         Aow3pU/1NU0fTV6Z4kVcxx9xS1KPD5xYxr5RReyGLWt35gXkaCtg1saaQOq6K1ZCbLRk
         Mb6CnrHMOQ888S9HJvKY2FUOnbvln8P/I4bV2oT6yRiKuHWZ6Dr0tuw9lO7rRmT4B19P
         vKng==
X-Gm-Message-State: AOJu0YxYLGldEueqpcS2BnGeqvzQyGiHkjjRxqm3B9oeoOetUlnn4U9H
	Bm9wYXD2ATkqQuR6klaX5dnBEQ==
X-Google-Smtp-Source: AGHT+IH2946wTqoiD++C2k5Ij5yIMLr7yXfpYxAYOyBlkrJ8arEJR+lmMs4NyQvImUkP6zbq99geZQ==
X-Received: by 2002:a2e:730f:0:b0:2b9:e7d7:64bd with SMTP id o15-20020a2e730f000000b002b9e7d764bdmr92624ljc.47.1691608837194;
        Wed, 09 Aug 2023 12:20:37 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b002b9ed203af1sm2863218ljj.132.2023.08.09.12.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:20:36 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 09 Aug 2023 21:20:26 +0200
Subject: [PATCH v3 3/6] clk: qcom: gcc-msm8998: Don't check halt bit on
 some branch clks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v3-3-ba1b1fd9ee75@linaro.org>
References: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691608824; l=1627;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4vcJD39xmmwGxR16do/vEynX3nfOkYLGbzSw65dGFMA=;
 b=V6n6R9yvH/Elr5qcWR9xj0kZ2oYv/FkZVkxEuDifmy96KAhGojMvRCcOz1x/M+gxV1oaooOtj
 YvOhwXH9HlDBckManxwXKBZRQC8h4oe4BVD+Miqo6zg7UuiZETyqzCN
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

