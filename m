Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03CAFC6
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 20:07:56 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id r11so40639796wrr.12
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680811676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/qILjo31dKZRnx2BX/LkX4PumS7avDA/rk4boexQqw=;
        b=mWXFvaBTMes2+5FGcHrA86JEiUqUUTA8C1NMuHGOQ/4j5VwacWsbgogLhiFPWMNS1U
         qZHmMk6g1RmkM1MUB073AuluNGMHZSoA9v+FLJ2ZIIU100uQ8XWCHn6quje58KDTIvjk
         EDfkqbwnZ634sNQEunfyQNJUNH8otZS1hJEgdjQlxlAZv6f5Q9qdk9cZv1yLhjWoTj5C
         BxzHiqa6Wc1eOb11bJUqHP1HkZ0/7fIFWvhdjILp5xuZ0M5ihwPWcdcQ96+NSx4nU+MH
         oPZ0W/VhZJSPkp/0L/H36Acg3v2JNzMCFyXbjeLvDjooL3LUZ7lvmfX4g7/3diXHxv+x
         3Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/qILjo31dKZRnx2BX/LkX4PumS7avDA/rk4boexQqw=;
        b=oBXF98bY+3p/EyuYxoZoQIi8tA3OvO5zh8n+5QKecsV2zX1GK+6qyR7D6YhWEd3JZY
         /objRHQH2MQMtFvdwGNxs1MdgZrgdcVcpenYj4N4XOubqrbw4l+AQR9zq0Lh8mMhANL5
         iRxgbnPIZq8GElXVIxM1HT6SirFrFGZ73Bx/DhxyuoM3FP0GkuoMgvQrvDRQPM6GBbut
         qHOQs0ZswZdpwMtup0BCzoOjRKdzDi27txFPhmpacgb2G7HABt2V50EKK/pBYUgJ7qL9
         M5VIBqmucZaGGmTy52NR+TYrLgj/wGz4ZlDT9RSBG5oVE3P3tT9PF+hM+80WtdUuqPoW
         MRjg==
X-Gm-Message-State: AAQBX9dVPn43oxcLGb+rGiv0/5BGYb8jfb6d/y+2Nu23t0+LX5G7nzoQ
	WNPVOLI6bkRmCiNe5hFo20wQdg==
X-Google-Smtp-Source: AKy350beFouznKsGY5cO6VPMl+btQGI5bQmEMBut1bMbkKXE41VbY78i9lJQNg9ULlpIJIn036ehbw==
X-Received: by 2002:adf:e74d:0:b0:2ce:a85d:5319 with SMTP id c13-20020adfe74d000000b002cea85d5319mr7927093wrn.39.1680811676506;
        Thu, 06 Apr 2023 13:07:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2560506wrn.52.2023.04.06.13.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:07:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 7/7] arm64: dts: qcom: sa8775p: add the GPU IOMMU node
Date: Thu,  6 Apr 2023 22:07:23 +0200
Message-Id: <20230406200723.552644-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230406200723.552644-1-brgl@bgdev.pl>
References: <20230406200723.552644-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the GPU IOMMU for sa8775p-based platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index f799cb5abb87..f46c1a73abdb 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+#include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
 #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -605,6 +606,41 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		kgsl_smmu: iommu@3da0000 {
+			compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x20000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <2>;
+			dma-coherent;
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_HUB_AON_CLK>;
+			clock-names = "gcc_gpu_memnoc_gfx_clk",
+				      "gcc_gpu_snoc_dvm_gfx_clk",
+				      "gpu_cc_ahb_clk",
+				      "gpu_cc_hlos1_vote_gpu_smmu_clk",
+				      "gpu_cc_cx_gmu_clk",
+				      "gpu_cc_hub_cx_int_clk",
+				      "gpu_cc_hub_aon_clk";
+			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,
-- 
2.37.2

