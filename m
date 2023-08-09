Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147024503
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 19:20:47 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso2397151fa.3
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691608845; x=1692213645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlY5pXEYcBgHeb5qjzLwZeG+1V5JyWmwzq+8kailYB8=;
        b=TfhFmGA2dH+TveOOjTBM+LXhYCAopnWok1rpSmme2kr7oBvmt6nTk4Lk3foM868G5b
         aE9Wmuy0c+DlCtfHBPYmxCwgVWB5e+v7Y0TU+N/+l+Gh7Kst7o4vWvI2m7BGaORPIiTS
         0HDzZt+v6tbH0IzQWlaIeCuUzRK/dwMB0izv2EmHKw2eKdleSP97NFbbZX7vBUMJ/bGb
         1PZ+GFC1voBzNGut5ABKsRcBAvdj+jJTZqGwUT6+khj8FECcLIeqS61IVGXUPNkz2p2L
         5m+Rw4b24Bv1lc/C9wGVDXEOS2G6Jh5EKBw4EAmwAJAaGh7ydl2yhF3IQc45UUkimxm/
         rIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608845; x=1692213645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlY5pXEYcBgHeb5qjzLwZeG+1V5JyWmwzq+8kailYB8=;
        b=JAe+eqvuodna+yOUIWvjYQ9FOK3Txv/BfW2jUeN8viXfXMiEzV8w6C8knWnvDiCtnZ
         jLa34PlcSM/WaYQ8nJDHOGhwLFTOmiS1pa4Ezw8wX7sLaDK2MiGnfXg4SDmKoWhueFiI
         Lu27ahaCEuvNynLbyrZiFFdxtYU6w2IIqyJKbb0MUq/bukWSyy+G0fb27IroTBLbBL3N
         Pl7yinFdFmLF2aN/GLYCLwJ1usO/NfVoyc3D2Dzz3AOSQ/342EBF7tmCs1D+8OL73lZr
         jj4GwtLdYQHCKaR4cb7mQ3sv1zmUBSdrElOXWrBeCjgYvNg2eAucRjh0nZ1UUFZ57Pl/
         yEQw==
X-Gm-Message-State: AOJu0YweyXaqb21iGGS7XnXNf5YUEvMTwRSyL8bAeqbFMuFmGjMH57ym
	yoKGEfAvUniMEBQbnqTnsfx9Nw==
X-Google-Smtp-Source: AGHT+IGSCNjiKUVekSkXLXbvmSbUjKSDMw5H3M68C5MVVfFAHx8T9iPqUvbhGGWowQfwkt411qIkMA==
X-Received: by 2002:a2e:730f:0:b0:2b5:1b80:264b with SMTP id o15-20020a2e730f000000b002b51b80264bmr105482ljc.12.1691608845471;
        Wed, 09 Aug 2023 12:20:45 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b002b9ed203af1sm2863218ljj.132.2023.08.09.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:20:45 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 09 Aug 2023 21:20:28 +0200
Subject: [PATCH v3 5/6] clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v3-5-ba1b1fd9ee75@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691608824; l=1105;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=87zmBNCrKExC5fA2pDw1hJreUEORhjqL4+NYXqa3bgY=;
 b=CtWmrvSHsvlErbsQsxLrU3ODuhQtNsTsNtB19xrNUGWfiV2aSZHRHHqxrLMUFEu1uiAStAAWj
 RMlV9Kb8TVNBKbiitjQkSgCh91rmQV5dVmkhomop/HO4nk1+OC6BFNa
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The SMMU GDSC doesn't have to be ALWAYS-ON and shouldn't feature the
HW_CTRL flag (it's separate from hw_ctrl_addr).  In addition to that,
it should feature a cxc entry for bimc_smmu_axi_clk and be marked as
votable.

Fix all of these issues.

Fixes: d14b15b5931c ("clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index d0a5440e2291..4fdc41e7d2a8 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2627,11 +2627,13 @@ static struct gdsc camss_cpp_gdsc = {
 static struct gdsc bimc_smmu_gdsc = {
 	.gdscr = 0xe020,
 	.gds_hw_ctrl = 0xe024,
+	.cxcs = (unsigned int []){ 0xe008 },
+	.cxc_count = 1,
 	.pd = {
 		.name = "bimc_smmu",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | ALWAYS_ON,
+	.flags = VOTABLE,
 };
 
 static struct clk_regmap *mmcc_msm8998_clocks[] = {

-- 
2.41.0

