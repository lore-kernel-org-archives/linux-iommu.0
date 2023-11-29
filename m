Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC932185
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaVapGUH"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54af2498e85so7554807a12.0
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 06:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269072; x=1701873872; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K/KL6rUHA7mDcBMrrqIFDkXaVSeDD2iYf5D2W8YBIg=;
        b=DaVapGUHRTgRi6IafavQ1MYt8ftfHvONqRFuX85n2GvxBC5xtSJWqN8aLb/RllyrzF
         gfVpzFP6C1W2Yg/XUzNzMCQ49CI6V7UFg4r2SI5Qo5R+/oLiEIVgnZyD+pHU+Hzv70Cf
         wuqsVCn5PydZteKoB65pk8msQgZrz63YxL/gD7ET5NGS6BzwuNs5UPA20Rha/ZN0m1j7
         2S1Pq65LrjpJNnU1kPtZHxrIbY+uHqd9o8iBh1TX9ezj2qMnwtbighn2prtB+DNbi4xc
         GuctQLPHivJAIaPKohLE597LvX0yng+tR6VZWM0ZUq5zf4syLy3rs+KHsiXOpkiddg52
         d2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269072; x=1701873872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K/KL6rUHA7mDcBMrrqIFDkXaVSeDD2iYf5D2W8YBIg=;
        b=tzWRFr7TIU6MZfihAe0p0hdNXGRlFtakf9nXiMX2fEhPvzvl1a+vRkMabIkpJfE1fJ
         R0R2FWG5r9UlUupbW4bYI/gi+1jOv/J/ihUHKkhONwYpw8HeKd+0aRODIbDeqpeZUivI
         mAKq0vasfuQU2cQsbOkl0nqsOVCr5jEYItssKC4KyKCfNwapA4+KMRQn2iYg2DDw/jbH
         oibV4qMg5XlaWup+Eyz0uHdewz/iyqzKWjaOeo2Y5TPV3y6jYi6VTuS4BNiLdT5u256j
         fmNTgy+/+kBmQmrryuVJS8uSASATL5+1EmfAYBj4gw2imsW6Dk6u2IgnVe1nd/JdBlm5
         qnQg==
X-Gm-Message-State: AOJu0Yx+yaM8Tn/qg7DKUrDVqHNh7B6ySDiyMvz041WmBOBURNHHd3NS
	dBAjrQlrt5W5tLCjZxdvpwgndA==
X-Google-Smtp-Source: AGHT+IGjVdN7cz5padHg+T+KRoFbmsMzhIWory1lFuWkxTuEmzq2syYeBQUInK/9FTSsztA+J2jYow==
X-Received: by 2002:a17:906:2219:b0:a16:8d1b:5b13 with SMTP id s25-20020a170906221900b00a168d1b5b13mr3159519ejs.73.1701269071739;
        Wed, 29 Nov 2023 06:44:31 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:31 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:44:04 +0100
Subject: [PATCH v3 07/12] arm64: dts: qcom: sc7280: Add the missing MDSS
 icc path
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-7-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=1493;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RpzLMWuMbYjvqQjs1yjMVMPj1VmkWicMXA9dO0pSXPQ=;
 b=idb266kdiffZu3Aqa8UlqEsL6fRd558KK+7szhEZHwR5Nruiw3g141r8j8bfrnqsrqdUyCE8W
 EO6Zzca5zhMB+0xwj+IunhA6686/xhyDdRSJIxzzge1Fic1shg6vvOS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

MDSS, aside from the MDP-MEM path, also requires the CPU-DISP_CFG one.
Failing to provide it may result in register accesses failing and that's
never good.

Add the missing path.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 04bf85b0399a..41d327b1f1b6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -3958,8 +3959,12 @@ mdss: display-subsystem@ae00000 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
-			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>;
-			interconnect-names = "mdp0-mem";
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &cnoc2 SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
 
 			iommus = <&apps_smmu 0x900 0x402>;
 

-- 
2.43.0

