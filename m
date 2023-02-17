Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453293C38
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 11:16:25 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id y14so699077ljq.10
        for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 03:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wJq/iqxZ5CY0MZ8/qvZLLKvRq4WEHI7wVVOEpRQbpw=;
        b=MC0poj+iXKkHo+R2YU6rbuzxgf0jQAaVXqzsfYcg40ZF3p+sobPJSFb784cEKAph2V
         omQrmbXAmq+e1xvIDhXtXGahku8AXRkp8Hz9BUHYS5N2NI75Ie5HsrrrN1BrptallZmn
         2TwPVpLlWyflzhC3CIJhIZ1SaXKypl1Zl0Cp2u4JDIn8IGlNRUVSobKIjOAUsFJgLCn8
         HhnKdH+BWhPGRNFicVt4LPpwUvJgaFW9pffXdR9uy10rZ3UDaL1Nto35bJYb/NaH5hcx
         +KiYim1dXAd7QtUADL/nmLwNcpU2tZuRtQJm4+FhOK/8RdcUA45ToDW7owata6sb3Ddb
         /jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wJq/iqxZ5CY0MZ8/qvZLLKvRq4WEHI7wVVOEpRQbpw=;
        b=oeLwPX1dqvV8YlsgE/bM9M23C8O0Iw5ECfAui3u1oSvKAhfiYteGSr4JbaV4Bl8R96
         mMqfCHjP1uln/EKkoPdK5SQLUv6XoW7a2/SqvI39aPE9gLcljpB1SYG+JnYbczOP6dmJ
         sf4kfrpWNlE5+rwkVwtEiIzPMUw2WqTJEeWH0bzh2HxPiYvSSoTikdsoB4jV4FezZxo1
         y5vGNVnmHDqVmZoMP+ccQ34hlFjYHV46uM9ep6yoKlyqcC/a8uazj7KQHRWGaKXeCy1E
         jIoj/DEiWePXN/sRpYtddjEqYoghV03o7Pi0XmQVP0f32p9wuKkskKyiLsy6wYDGwOv/
         KZFg==
X-Gm-Message-State: AO0yUKUzXGF4ekKnoKKiU1Wuu88NnLATi/yNDxkcZq7luY/7wg6ENyTt
	vCmdofo0Yqv4wfeXEc6ufY69qA==
X-Google-Smtp-Source: AK7set+MHcEoedvXSDYloedEh6Y9Sy1Tzo13ZFKtLdr645Gc9MRYQ7gRjlpO3L0eUgXSthIRnqVygQ==
X-Received: by 2002:a05:651c:1031:b0:293:4b8d:daeb with SMTP id w17-20020a05651c103100b002934b8ddaebmr66584ljm.34.1676632583401;
        Fri, 17 Feb 2023 03:16:23 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e9b15000000b002935899fe3fsm554818lji.116.2023.02.17.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:16:23 -0800 (PST)
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
Subject: [PATCH v2 3/6] arm64: dts: qcom: sc7280: Add qcom,smmu-500 to Adreno SMMU
Date: Fri, 17 Feb 2023 12:16:10 +0100
Message-Id: <20230217111613.306978-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
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
v1 -> v2:
No changes

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

