Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484C3C38
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 11:16:28 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id k13so939868ljn.11
        for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 03:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmoMqnRP5kZAiXq2v7CNcctUC+zodegcmF76bZvlIAw=;
        b=c9ZZv4rfZBZFzWEA/W4nxzpP5BhRgY9jBI02O6onfHggcezzcuWXJYJqtcWCHbm0mT
         8znT6eB/RftHt6F5swPqmxl/ow+oPAX+ATKuAIWxQ+dbIZ8/154bCTfi8ccf7yFAVEfk
         89qRZKPexUTswZ3Uc/WpUy0jPV8Gvf6/YcG5UV7yMPgBlsj/tKja6DNIwal3/nkLZD8W
         pHqLuWe3ctTNUHjyBby4nO5DRH3/I75JCS1yL1I4Rbzhhhz0bGIedRXkHlkVGoKQKiAs
         7f6itx6ijSPdMoMVVMavTvdjc3s5LMwGyeSfYJqAyCOg3/LUBokSI+AHWypbR+kjS7ls
         KF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmoMqnRP5kZAiXq2v7CNcctUC+zodegcmF76bZvlIAw=;
        b=rdLUnxSAiXQCHxbu5YGNPidyW/7ZqDOX6R7RdIrNdaj9FXi6u3Tfrio2zOvDGgwecA
         6JYjKqOd9EA+U4Vp9diWOTfMGP4CHYqe+4USFByHOyuqTHOnBolk/YFLQpmW8kF6RwSO
         oH001QUgvCDyekvWF8mfDsDzYagCL7YgOh3uQp/54XNiy6U1DTXv6lorDug58LiQ7heB
         9eieB2rIY3XXsgFT8FuarR7UDSOm3574jUD0YA8do/AX1Hbx0Ok3oXjd5RA2ynlnvjee
         tv43VsenHj4hX9r7ckQQwZV4dxklEL3G8Frb72s9lS71b68YmfIwCdwrESh5vKI9wwrI
         NQsQ==
X-Gm-Message-State: AO0yUKV04ZAFVK4tw4WFtzccEl2vSM/yaegl2ITsxLDZukk/z9JZYASH
	prcH0K2+pN9xp+Dhe9h4gOPQLQ==
X-Google-Smtp-Source: AK7set95lmN1eG8L+WqSsDgz3Maqx82n55DwsLlhEGEwttIK1QfQtsLZabqbklItAavuPKe3Mak4tQ==
X-Received: by 2002:a05:651c:1a06:b0:293:4e4b:bf5a with SMTP id by6-20020a05651c1a0600b002934e4bbf5amr1795039ljb.1.1676632586440;
        Fri, 17 Feb 2023 03:16:26 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e9b15000000b002935899fe3fsm554818lji.116.2023.02.17.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:16:26 -0800 (PST)
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
Subject: [PATCH v2 5/6] arm64: dts: qcom: sm8250: Add qcom,smmu-500 to Adreno SMMU
Date: Fri, 17 Feb 2023 12:16:12 +0100
Message-Id: <20230217111613.306978-5-konrad.dybcio@linaro.org>
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

