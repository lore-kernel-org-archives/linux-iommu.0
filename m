Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B72D2FB
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 09:44:51 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so84681881fa.1
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691487889; x=1692092689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KW5W/BsMVq6+QNzWH4B7mMdqsIsqWz/fCs4TWl8ltY=;
        b=KSWYTc5D3BN3gp99SUg3MEoihR8mRf2Yxe9UrxtqsBYgJndJ3OWTn8CLZgter4FoFR
         i5Tzu4DyXPsf4zIMKSQESEwGQLbJ/ymAwxxeVMR4sW0nOBf2eGBPMzv2y6GxV5pmO7vb
         9XrWFnxyh8ZsVQ5m/Ab5WeaedRbR/JYvzh/rsx45p++ZVPL1E+IgDsIFY95fjnjctCcx
         6XyHZaJFyGHKbQF1qLh5YapRKJW/8DeVmz0vKghkGat/CQru9ozaXX+5tv1qdzUc55y/
         IcmHcfu0R7HXOhrdUJtz7R0gFomC+MRrHPqH+TKk7NtAHasEA0HTGSHco95G+ORirVfv
         ScrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691487889; x=1692092689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KW5W/BsMVq6+QNzWH4B7mMdqsIsqWz/fCs4TWl8ltY=;
        b=lWLnMaifbFrhxq/C2SnYPvINZEC1Chzt/RTHNgkSLAAYCVUUqlp92UCNx/GA45UuRT
         bwSPdewYSKsEykz2XJTErFdB/TwpY6tlC8z6AthWZvxA4gqBA2nicCt52eeQzWgdbQ92
         2eAbcXgOl45Df2sDkRdVceKa2z8QDBM/4wo0Q6xjWvJFL7TEcDCH5wvlAQA3tzdO+Gxn
         idRFHRvpXrXY16uBlv1J3ke/LEDOdtwiyOaU34BAoFd0NX2pMi+9U2QTYxKu2ARpHpYb
         nDlCVPUhmcwBAs61syDKprzToSp/WY7RMQJmmhN7kZeL5rTGM/nDzxgXcKJWtGZ2mCTG
         rOvA==
X-Gm-Message-State: AOJu0YzHGo8YespDC53SKDGalpw6qidYMIX0l2U/xJaSFPvGptb6Nf9E
	lN9jEsfJEvOC7jIWHEBQAU7QwA==
X-Google-Smtp-Source: AGHT+IG1IYYssFkGiczWRJXJ2hNd7aUPVrG4bPRpm+cL/fBJQfj5HgLT+UBhH2Xhh05RcC4OK+d9Kw==
X-Received: by 2002:a19:6518:0:b0:4fd:d18e:be33 with SMTP id z24-20020a196518000000b004fdd18ebe33mr7634340lfb.26.1691487889572;
        Tue, 08 Aug 2023 02:44:49 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:49 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 08 Aug 2023 11:44:41 +0200
Subject: [PATCH v2 1/6] arm64: dts: qcom: msm8998: Drop bus clock reference
 from MMSS SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-8998_mmssclk-v2-1-34273e275c51@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=994;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3dPVka+1yoTBWJAX5iuBqo/JljLJGzd9OEipOW26gpY=;
 b=P/xfTwdFTTKmfRH1cHDGu0mhCVETc7DhmfzfJHr6hh8cV9OWxxp8ilKs4ThwIArS2RVFHOVnf
 uG9mGb1qwVACAbr6fd75bvJra8iZTVEziz1Kd1WLVE66/LQYZdFZUkQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The MMSS SMMU has been abusingly consuming the exposed RPM interconnect
clock. Drop it.

Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia subsystem iommu")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index a41a34dbcc3c..e40f6461f4fd 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2743,10 +2743,10 @@ mmss_smmu: iommu@cd00000 {
 
 			clocks = <&mmcc MNOC_AHB_CLK>,
 				 <&mmcc BIMC_SMMU_AHB_CLK>,
-				 <&rpmcc RPM_SMD_MMAXI_CLK>,
 				 <&mmcc BIMC_SMMU_AXI_CLK>;
-			clock-names = "iface-mm", "iface-smmu",
-				      "bus-mm", "bus-smmu";
+			clock-names = "iface-mm",
+				      "iface-smmu",
+				      "bus-smmu";
 
 			#global-interrupts = <0>;
 			interrupts =

-- 
2.41.0

