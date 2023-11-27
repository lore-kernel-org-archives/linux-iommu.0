Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF732C6C
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhqZvcEC"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso6641469e87.1
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098951; x=1701703751; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WME6ubitd3vxaAOMdHVezdwhed8qbighnDEBO169Ec=;
        b=FhqZvcECAfbFqZviX9QViqEfzFZcLoYoJTmgozxEDv7HKnGh5v7RvZ8m+afGadNbPs
         MSiU1MIRyVhRrBYEc7aJibaMCosWtoQT42wJY+l6CTGBqpUOwrZpaHYdDE8+ulAanNNG
         5CIQ7KKyR0kQXsR+/Q6Blg2wSdAtmcE8fTWNsHwZ23rX+fSdnqbdaMVsQk2awW+TCUUd
         eBUzl3hggLQEnUxOJ7Tk1TyQJxiyEIOhjvJa9gCAPl8AHzfr7wy5HkEiGJbcVvUuFOd4
         NSxDuL1kbFhF0Lfjsi/QdB2IxjAGHOpiJR3ZCQDCAFkyQWv6789R/3A4podJB5TAqeww
         oZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098951; x=1701703751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WME6ubitd3vxaAOMdHVezdwhed8qbighnDEBO169Ec=;
        b=DWAU3Y5DJcBPdE4HNQyLFrfa6ubxPL5mE7q2Rdf8reIlKhPtVLWEw8to7Xrpf2Bsty
         0Rxf0t5uuWC3Fzlb8S0fRs+dxGHOCoDblxGh6KJgOhjnhYl704ttGlfGkfSX0AYsAyXT
         VJ3V37Lpu2w2WOPPMH5e/top+QW4hFVXUkIhuFJ1BTOq3V3Ln8jbpwX2NnhLlOaMu7KB
         r5+ZYqjjF6Pk2mAiQEuXImfTgthKt040McZ9E3H5WYMQjCEIgSNBRXm/wh0SNa4AJ7mQ
         Ro9Sg4s1LWLpPAQeu2uaexN8qR2huwqvCPjP5TuHIm7JtlJSVvtyg9NaI9dHjZYs9sru
         LVQw==
X-Gm-Message-State: AOJu0YxyqWx33AUM36D2ucytxJVypAMnAwv7nGGB4EwwXlR9S7HwE6aX
	+OQLKVgsesjyi4IZWGe+Jbj8Zw==
X-Google-Smtp-Source: AGHT+IH9PASqf8+9MS/t3uEvXsv+5J3bCkLHJgeNIv00zKAMBrW7rkqqrSRlRaaexUly2vTsBuJ+TA==
X-Received: by 2002:a19:ac48:0:b0:50a:6fc5:e95c with SMTP id r8-20020a19ac48000000b0050a6fc5e95cmr7956561lfc.60.1701098951013;
        Mon, 27 Nov 2023 07:29:11 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:10 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:46 +0100
Subject: [PATCH v2 06/12] arm64: dts: qcom: sc7180: Add the missing MDSS
 icc path
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-6-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=1145;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QxbVxThi6gj4JqQP8V9LpJsjR/myuVOnIJbwHX7amYU=;
 b=fS2uPRd3j9acJg11U61tq9XVN8ayomlEw9d5ATm43L3nTtaAyensMfnnnvE/jpMI6SBpUTurk
 TEzmocPClnSCqU9FEoaODlLAlpLeRUPaiJm5qFPFJKjE9fYnQKYi6tN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

MDSS, aside from the MDP-MEM path, also requires the CPU-DISP_CFG one.
Failing to provide it may result in register accesses failing and that's
never good.

Add the missing path.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 11f353d416b4..9664e42faeb1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3100,8 +3100,12 @@ mdss: display-subsystem@ae00000 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
-			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>;
-			interconnect-names = "mdp0-mem";
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
 
 			iommus = <&apps_smmu 0x800 0x2>;
 

-- 
2.43.0

