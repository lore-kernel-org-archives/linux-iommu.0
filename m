Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30524503
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 19:20:43 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so2825501fa.1
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691608841; x=1692213641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAg8mzz6tXJyaH1tEofpHQ5TEsFiQj+ho2hy+w4Tmaw=;
        b=VzyIj7kpmL0GI4+H4dQgi+UkUqLL/c7AY4Rxja5tdpF915CELH4iPRezqR4JDiLnJh
         hYWiJDYoMzzJV5MOSC8CjjSlzrYOHQ10ohlzh1bPxmj1pr+/0siODEQNxkxj8Yh9A15S
         zI/qS1L0OWycrmB7G1C/yp5U3na9yIXRmmtuRliwEkSdu6YiQewsJJXy6uF7YPyjbuSp
         yBKQ+5U3WetAiIi2o4FlPGztZERZdbxrFevAtYlQ7nZclkZyC3NgxUPVi2x2kQyOfnnJ
         /9NEypY0RwWjU0nhuHENuUW3M2BNeFJ+Ce+M5dutJ5CYEMVFUVzkHqcp1d3icMk49mwb
         AQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608841; x=1692213641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAg8mzz6tXJyaH1tEofpHQ5TEsFiQj+ho2hy+w4Tmaw=;
        b=Lhm3v7QqTHax2jQlVawg3f0ygDTtdV/6/D1A4d4p9s2uDTXzbeCWahELpqZOyChwNQ
         RrNvJ1nxxCZYCIqHiWLVCzW1Xz7HRJl9AVenPROicfuyPioUxRYk0XateNoyZ2PKpVCo
         yVXTJ7DyzGbD84VnOe1a20wU2blpoe5cQc7QYU0ILz93yKdpw59dVvM9hS3o/p7+kPtr
         UqN6UBYfmx87RwBvxYhcBeDyXJ2HFRSHJHNaJvQ7WDkjxBVUKFqF+PUv9X1KeDGAFKp0
         O9cYC/hN64IK9JwTkfjOWdlfJ2S4h/kHlPeaPZaiVFM5EhrUd58hNmSKVU2x3L4HMnF5
         PqIQ==
X-Gm-Message-State: AOJu0Yz1poEQ1M4+3ggLg505KGOxbysUKoex8E8fwQE+Q76R8fI4bekP
	/yz5IoCQVvBJ8c4Z8dZVjzOZMQ==
X-Google-Smtp-Source: AGHT+IHkKP1lMchPzHbm+j7W1NCjA5ROEnb+i2koQY3n9dklYzTIduqy4k3ASK3zu6ne7YURGmApPg==
X-Received: by 2002:a2e:9c50:0:b0:2b9:5695:d10d with SMTP id t16-20020a2e9c50000000b002b95695d10dmr82394ljj.36.1691608841249;
        Wed, 09 Aug 2023 12:20:41 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b002b9ed203af1sm2863218ljj.132.2023.08.09.12.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:20:40 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 09 Aug 2023 21:20:27 +0200
Subject: [PATCH v3 4/6] clk: qcom: mmcc-msm8998: Don't check halt bit on
 some branch clks
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v3-4-ba1b1fd9ee75@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691608824; l=1407;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=haDOFYx+cWB8WYF0AFsxGiNUFhwDHpLSQyDe+vgkap0=;
 b=ivHa7Psm9IKmZjT3K/fiYAso4o3IjbutXh3aiP/PX5cuAobhTzT3jwBqR6ntC92H28DCKPHah
 56lr1ds08k8Cbcneb+IbXt/B0FrSWryIzQYDSVIg30b+uHh5Nmoezjz
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

