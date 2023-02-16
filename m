Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33333747A
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 14:56:54 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id x29so2277072ljq.0
        for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA8Nok9QB06dAiggpOCi9jTMtWNwPI/BkB7gt9UlA4Q=;
        b=ud3t/DRE6nToVd1mFfxMCc6ZnBTJhm+5E49w3+Wd6fAP1x3kIW/YoRm6IBQP3sj8M0
         rFkdEVsROi9pudYxdoIMTqL5Shncf57fkILgjqbKY+LFttQJFNT4ghldjCVIYA6vCvMC
         23LI5vUzCoFB6Hxq0EeMx7ANobgZ+4oYaB7uafYr5edOgUAWNM9ZjChwWq2pvsfquWDO
         RnzlLylNeFXvOZ7HisHJJzsmJpgdwCs+GzLBG+sOaIX1nwsi909aMXSOlwyYiIoiPWNS
         QvMMsIB1n226cXbdH7MtKUKkbFEO4hGsXXRlRLh9nOyl1e9x355WiI+qRUhHp+bUPfRI
         wVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA8Nok9QB06dAiggpOCi9jTMtWNwPI/BkB7gt9UlA4Q=;
        b=DuhNw8cVP+u/izpeagH6MjggmMz2Dxxt64Ni+Thw2S6Ey4rfyFtE9DxcPM7yolTuwM
         OCZ1wcQLzaeo8/75i0gsze/azd2aDWLbuNdTkOrktoAONJuQKVcty9sLcBDSIrGSwEnh
         D3lmwewLsMD8+P18Zg4eA+1llZMCXenjG0GiX6SQA4zf+i6FZms/wQ1jq7tQmqVmv+a7
         40MwbwaAXpDoMdTkDYU0L52Y1unpNG2VZtcm3XMr8lrQjT7d8hhizhmYrH4BG9RXeIIO
         48iFt5o9jp9pxHz9f7Mf95+P/i0cVP7gL+E2AJgtEEnjNtOsthxjpWjMDV1qRtTqSPQN
         NSWA==
X-Gm-Message-State: AO0yUKXZnELs0sE4tgvN3bhQkrDpnBqWzwuKzPrXIBtav2t7XJ1ZVrFm
	sRMoTnZSLMeVmHUxVaVaEZ+CyQ==
X-Google-Smtp-Source: AK7set/Fipmuu7N68aDIu5iNxlr0lOhtbQnXNgbheUnyJukms92JZ5kKwONFGBqzp7T7B/gzoigPvQ==
X-Received: by 2002:a2e:2a43:0:b0:293:4b6b:914e with SMTP id q64-20020a2e2a43000000b002934b6b914emr1835066ljq.26.1676559412360;
        Thu, 16 Feb 2023 06:56:52 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id f2-20020a2e1f02000000b00294619d902dsm230012ljf.112.2023.02.16.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:56:51 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	andersson@kernel.org,
	agross@kernel.org
Cc: marijn.suijten@somainline.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: qcom: sc7280: Add qcom,smmu-500 to Adreno SMMU
Date: Thu, 16 Feb 2023 15:56:43 +0100
Message-Id: <20230216145646.4095336-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
References: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the fallback Qualcomm SMMU500 compatible to the Adreno SMMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index bdcb74925313..a8227bb6b336 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2677,7 +2677,8 @@ dma@117f000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sc7280-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sc7280-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x20000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.39.1

