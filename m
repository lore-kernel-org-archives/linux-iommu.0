Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E378492
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 09:44:59 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so8999195e87.0
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691487897; x=1692092697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlY5pXEYcBgHeb5qjzLwZeG+1V5JyWmwzq+8kailYB8=;
        b=v+PRDMZxsoLGpseVtkDvUJn58AZ1YAzEUzT4w0Zjtj4lt3VSh7JoXsim8kFKzP7l0d
         8lNcQdku11MFWwF4cUUHmQf1XfwsRgVb654spJLXNc6tWBMWvQSuz/B3eN7WzKk2O+Ia
         cU1l8PDw2X1xUBrFVT6WkBNRgyDvHShiCf1aLPR28RSF/Rsa0xf3LZtp5J2BlxwzYkfs
         qKelIW9m/mx05lZFUMBILBhEuPUBUNcGdkiiapP0l05E+J8ol3s4I4YXgHttqbEBwl0M
         kbRPuTrMg1oFN3i6Fq4ckhhZHu/fVE76242lTBcE5rrXYsRo37EkzRy8COpvrvUX02k/
         r5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691487897; x=1692092697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlY5pXEYcBgHeb5qjzLwZeG+1V5JyWmwzq+8kailYB8=;
        b=QFChYfaFtNfJ6JOyp/hn4xMEVrguuiM57+KcL/K16VbGKR6XfEJ9Gm/7BCmUe9Kh6n
         rArsSYYNogmt9Gjkb9OWhZXUrPolUh/TvBacK5ukAovbBfukWXu8Mop98R+W4poFZ45M
         gppINYg9p+nAAqWDR7s/8SX3iZ8+OjHYFW5xJJben29768PsZ0CjFMqyDbXUzHVk1lG8
         47/cfOzY2Qw8We4oOubr7DoiwcMV3diLCLVglGJnb0EOW1uSqfCbJNMlZhBIuS3seaTG
         e+D0jXFb4KCY76ZxHn8ks8dZ81fRkJ7rUBL34NERtNtCSjalFYnnvTrtEvxSahldBJFP
         jk4g==
X-Gm-Message-State: AOJu0YyEK3plHNSIirtQQBS+pKpDT4sdzd+e2aTtPudk1wtk/OY9921E
	Twlx7n4Wae5+1RncbGwBjs31SQ==
X-Google-Smtp-Source: AGHT+IHh37iYuUiKI2GbU0AYhtJBCPFDqyHRg6hHZo0rvcAp0zMmu3aywLaX3w+vkrjWoKcJi+lCTw==
X-Received: by 2002:a05:6512:20c1:b0:4f8:58af:ebd7 with SMTP id u1-20020a05651220c100b004f858afebd7mr6593359lfr.39.1691487897383;
        Tue, 08 Aug 2023 02:44:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:56 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 08 Aug 2023 11:44:45 +0200
Subject: [PATCH v2 5/6] clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-5-34273e275c51@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=1105;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=87zmBNCrKExC5fA2pDw1hJreUEORhjqL4+NYXqa3bgY=;
 b=VT9trWuRQROU5ByyIvzOsud1+jUCahMFSSwl7lXsHgNEroaV6TNcWL2Qi+2HDnBgH+uqXNQKx
 XLni2Mv9lxlCRZ/eHiiHKdcIHZUZoGsQGa7E5QjDCIxTVH8MTuWmOw8
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

