Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ADD747B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 14:56:57 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id a13so2226284ljq.6
        for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 06:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKPZoARVL4pErww1wba0PhsjF+y4EURMfNEf5dTC1YQ=;
        b=odBtyRbdU9e/VNYr//7YW4Mc/4+x6j5dMtcALVOVFF9QTGuXaxlEGRgccSqD6wYwnx
         m/GFsZY0IZOlN5khck2Bi5GkcikpdtKamOW0AwagkHnDgiRqMdsQWIoBHFmDCAYFCwbw
         xT9PbU99YZh81KjBqwxtJrS4KZIZgT1kXaiB2oqWeLWSnQoWRTHO7VGJypgPVjscEQE9
         uSfqeGO3uaJ/49BnkjkQ0qSWw/JIag+uIdh2ceCPB7RDyi8HMOqtGoC5nLJjdBFREE2z
         dBOAtYykR8YyVsYClU5UlGN5uSxKekIQjZDGaYoUO3o3Flp52SFfGw5qINxXNQ+qKLGV
         onGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKPZoARVL4pErww1wba0PhsjF+y4EURMfNEf5dTC1YQ=;
        b=nGjw/2L2NAvBHDPpTvKwnBzkFyat+hB19KhYiPsvNGmQc+QIaSrPWIm9gsOzR2Te+X
         Hk04GYEnErVw2YOd1EyZVMw868K9KIUcIFBIkPYmcodA0pmAocRFRnn/erfb2Y0O4MI4
         ZnR2OgoIWQu5Bf/Adu8Jdhivh9pACOHuZcUGVmbpIhGFaW9tBHHVR5b72cesPjUPEdAu
         evSjJ2o2IYj0pq8g2nujZtHoH9nIYwf6Z1eaA30Fe64W7A+RwDJFzb3P2DdbEzFgz4EO
         ELXbCUv56lVBXFG5Uy3qdaxKxxiFC84vgZQi/fjsTDBxsLnjGBo8YbQIyF22wTk3mbvv
         gjVA==
X-Gm-Message-State: AO0yUKWRK8fnu4pSDc/QBSDtmnb+tMUeSZtDvfE2zWV3W2Qh6ir3COPS
	BKo4iu+KfJZwo4CPYwq5ZaeSAg==
X-Google-Smtp-Source: AK7set8FaLeTWAr/SL89TL2fRxvrlq8DSwMxLi2hP41yr3ZatnqIYGddBt7KxaV9SV/egp5Ryjb5uw==
X-Received: by 2002:a2e:550:0:b0:294:6d2d:c18c with SMTP id 77-20020a2e0550000000b002946d2dc18cmr331046ljf.36.1676559415327;
        Thu, 16 Feb 2023 06:56:55 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id f2-20020a2e1f02000000b00294619d902dsm230012ljf.112.2023.02.16.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:56:55 -0800 (PST)
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
Subject: [PATCH 4/5] arm64: dts: qcom: sm8250: Add qcom,smmu-500 to Adreno SMMU
Date: Thu, 16 Feb 2023 15:56:45 +0100
Message-Id: <20230216145646.4095336-4-konrad.dybcio@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 6a0100822d3d..13f5526d97b4 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2701,7 +2701,8 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sm8250-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
+			compatible = "qcom,sm8250-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.39.1

