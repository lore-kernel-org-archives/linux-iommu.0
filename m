Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675812F36
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 18:44:24 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id x21so24818409ljg.10
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgMhdFkKLkhPhfVCNQ6+pSsp5VjoW+jEZtcFsBXxEx4=;
        b=FksAD5v1C/TpK1XjS0IBQ4/8HsPn7ot3DprBWYnIB9syyukB4rLZPBb6tA0YZm2tdv
         mnMaDUlUVzzxEOuHjhj0E0xDth/1mrNzQZySXRXjYKDLaqJdoW4gPEJutPuOOw0mBRhu
         QBnxD5QgfCDrbOm43ALL0L3iFoGFeMmdijmI4pGEMGLC2PgBo/rLjrpnc3g8009OSv3c
         JqiPmvd04K1mi86IKSyGp524T3D0UQn/ssEOWsDEIqHJeX14TNdIeWk8096C7KRdK7Es
         OPwK7kUcb3JKonk2wxDfSNMC9vltEt78EzvAYfbF3yi4VJ1BzX+t5KNwx232jXnz+9mJ
         7+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgMhdFkKLkhPhfVCNQ6+pSsp5VjoW+jEZtcFsBXxEx4=;
        b=1X5wv1URAN/AdEGb0LvM4Zc5n1Zwfv02RUxVp6gs6LZZjT4Y5WzuWaTKQrK+V1gd97
         A9bTbiuP+2o2pVO/u4+KRUKSXRuPpCj87EWOr0SVPQ+1TR3Hd5jZN/PzPiPH2WTJQD9G
         93CSAkzaTNj/MCmE27EAJIe8hdRnqe2/+Ie7JC9QV/gaNOQAoqzn3X0D0sPmG4aWwP27
         2iZQQbba9Nv4H8c8RumKsNAEuomanS57mwY0EcVlJYq/txgVCPs8A/dI4PV68ZyaG0U4
         2+pJn+JznbQZWqCb82ZO2WpvFVM5GsNDqVRuWkLmIi8Skr/OFDtJef2/a2N4NmPCeOgm
         VfUA==
X-Gm-Message-State: ACrzQf1bmmCAqcGEnQDzi3UIQ05xzXzKExFNRnnBUUdv1lKedw5SqV+Q
	PtwdUunlFyQZHPCifXo1qapkJA==
X-Google-Smtp-Source: AMsMyM4QRl5werbPkUscSIzc2q729LvDrgthZOrKbD+rv3ezGvOX+tkpxYFYAI/j+MoIwm7qkGu0zg==
X-Received: by 2002:a2e:834c:0:b0:277:24e1:7b80 with SMTP id l12-20020a2e834c000000b0027724e17b80mr9314376ljh.302.1667414662496;
        Wed, 02 Nov 2022 11:44:22 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b00277092c03e7sm2277540ljo.33.2022.11.02.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:44:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [RFC PATCH v2 01/11] arm64: dts: qcom: msm8996: change order of SMMU clocks on this platform
Date: Wed,  2 Nov 2022 21:44:10 +0300
Message-Id: <20221102184420.534094-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change order of SMMU clocks to match the schema.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 31 +++++++++++++--------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c0a2baffa49d..9331327678d8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2205,9 +2205,9 @@ adreno_smmu: iommu@b40000 {
 				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
 			#iommu-cells = <1>;
 
-			clocks = <&mmcc GPU_AHB_CLK>,
-				 <&gcc GCC_MMSS_BIMC_GFX_CLK>;
-			clock-names = "iface", "bus";
+			clocks = <&gcc GCC_MMSS_BIMC_GFX_CLK>,
+				 <&mmcc GPU_AHB_CLK>;
+			clock-names = "bus", "iface";
 
 			power-domains = <&mmcc GPU_GDSC>;
 		};
@@ -2272,9 +2272,9 @@ mdp_smmu: iommu@d00000 {
 				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
 			#iommu-cells = <1>;
-			clocks = <&mmcc SMMU_MDP_AHB_CLK>,
-				 <&mmcc SMMU_MDP_AXI_CLK>;
-			clock-names = "iface", "bus";
+			clocks = <&mmcc SMMU_MDP_AXI_CLK>,
+				 <&mmcc SMMU_MDP_AHB_CLK>;
+			clock-names = "bus", "iface";
 
 			power-domains = <&mmcc MDSS_GDSC>;
 		};
@@ -2292,9 +2292,9 @@ venus_smmu: iommu@d40000 {
 				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&mmcc MMAGIC_VIDEO_GDSC>;
-			clocks = <&mmcc SMMU_VIDEO_AHB_CLK>,
-				 <&mmcc SMMU_VIDEO_AXI_CLK>;
-			clock-names = "iface", "bus";
+			clocks = <&mmcc SMMU_VIDEO_AXI_CLK>,
+				 <&mmcc SMMU_VIDEO_AHB_CLK>;
+			clock-names = "bus", "iface";
 			#iommu-cells = <1>;
 			status = "okay";
 		};
@@ -2308,10 +2308,9 @@ vfe_smmu: iommu@da0000 {
 				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&mmcc MMAGIC_CAMSS_GDSC>;
-			clocks = <&mmcc SMMU_VFE_AHB_CLK>,
-				 <&mmcc SMMU_VFE_AXI_CLK>;
-			clock-names = "iface",
-				      "bus";
+			clocks = <&mmcc SMMU_VFE_AXI_CLK>,
+				 <&mmcc SMMU_VFE_AHB_CLK>;
+			clock-names = "bus", "iface";
 			#iommu-cells = <1>;
 		};
 
@@ -2336,9 +2335,9 @@ lpass_q6_smmu: iommu@1600000 {
 		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
 		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
 
-			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
-				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
-			clock-names = "iface", "bus";
+			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>,
+				 <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>;
+			clock-names = "bus", "iface";
 		};
 
 		slpi_pil: remoteproc@1c00000 {
-- 
2.35.1

