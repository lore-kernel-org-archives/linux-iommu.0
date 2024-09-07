Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0216089A
	for <iommu@lists.linux.dev>; Sat,  7 Sep 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734904; cv=none; b=dYT0OQrhfTeP0pBMI4T98P8V7cDXj4cz4FF/1FPKjBXMMfhdMScZf6TdYZem89BDhmg+vriYwKqdvkj/GH34I0BIrycoQYY9Db9Y/I8vssHfeM/Q7aurmlfdthm+3tJbb5wZF2iY+hJcKQfcO5ugeMwaja/GXdKPFh43CyMhwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734904; c=relaxed/simple;
	bh=G8XjAsr7l2bULeKDkj37t5ZchnBw4CW6FlfjTvSZkX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0PzxBGkWGetDzTelrwB/Av7d/yO5YAMYWoBujKRrwsx9WnW9YzTPaiCWizuPVlkpvulEqngzKL13U/g1uIgb6T9ZE7nDnfHVl4t9CQEA+WF0xusQ6WC7E2RNLzKVq4YsIaOIZSOoaiIe8+0sT7qaxLhh/b7p3YwUT72Pbt32ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UPoY/dm+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPoY/dm+"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75c0b78fbso6944581fa.1
        for <iommu@lists.linux.dev>; Sat, 07 Sep 2024 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725734901; x=1726339701; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpkFdCDWxG+jHgwK52QzUzAkGgglAsm4AAFdePfcRFY=;
        b=UPoY/dm+WphYDlSNcYqXNQas2e6jMpk8suqZ4rphAn6kE3jo6R3/qAvpDDK42MAGyE
         6MsCjvcMdTiFjX1waZA+ZJ3CujOxdddNHMKS8GEBDICkQQoASiZ3b6YgnQC6JjRuwMsx
         BTnrByJX2hk1ZZUM8sbeIukp1BzrFda7aWuE6t9sZXvdn+/rwggzmp8CD/R2/uSYroQZ
         +OzcsKdWuz7Gl9wI07F0ozcQIQfmZMtfVTO98Se64OoU7/Reg469ZEOdI5loSNHI2YjO
         a/dyqXVKOoWdNO0hVFcpt7coaYJnCdyMLbL4Q7msCJ3x67ub30zwGTQQTRUThW8dWIRn
         kTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734901; x=1726339701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpkFdCDWxG+jHgwK52QzUzAkGgglAsm4AAFdePfcRFY=;
        b=aa9msXoTxjiYr9EERmqbikJjrGvyzmQKG7OH3nbnieiWPdlFxwQBhU5aVoJOw8VzZv
         ZlT9uyEV0NAN+1SKcmYiO9uywWSHS1TGhTuESzBqk3qAsn+5EqtfcYrAYxyn8qFg2J+g
         ySwyxdwARYmt+NDoIl9WNvTFcvVo44mffvlO+0kvQB06iEBjOlXURg8apCywwNlkM58z
         J6R1bhk6yJIZ4/u9sdqKcbOHJOZK6Ct4YpzKQjevgS4aFQy31E63mQFq1bG9wMzsKq/B
         yMQWL6P8Er6Gs5gVbS90mvWfGoECpTzwudW3uHT82nejNwYYA3bZa1TbZ5/GSnA20l5U
         mUQg==
X-Gm-Message-State: AOJu0Yw/7HQ8rHR1ZUdCS4U6IzXMqoln96A+5n61HqIPoRiUkSB/kn2G
	eXbLNthw6Sg9dE00wK6VEiC9zM3/c0fWbm2yeAKN+m9Q/U26L+x6FgoyKXJIAVs=
X-Google-Smtp-Source: AGHT+IEGc+rw8n897S3k/I+r66uqWMoCaEiaxiGscVL7WMTLCAC9tURU0h8WtjoSPAnSuDv8f4FDdg==
X-Received: by 2002:a2e:6111:0:b0:2f3:e2fd:7dcd with SMTP id 38308e7fff4ca-2f751ea7abdmr36668801fa.6.1725734900596;
        Sat, 07 Sep 2024 11:48:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c0b1af3sm2271861fa.129.2024.09.07.11.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:48:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 07 Sep 2024 21:48:13 +0300
Subject: [PATCH 2/7] arm64: dts: qcom: sdm630: enable GPU SMMU and GPUCC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-sdm660-wifi-v1-2-e316055142f8@linaro.org>
References: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
In-Reply-To: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=G8XjAsr7l2bULeKDkj37t5ZchnBw4CW6FlfjTvSZkX0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3J/xN40BsuEdXIGn7p9ScsoJtdiTQB8SViteB
 gBGFCIKcZuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtyf8QAKCRCLPIo+Aiko
 1ZcRB/9PjGkhtUodJVh3czV+ADqc3yYyhY69r+wl7qdHHU3JzuspOjFVoU7ZuoqO/THcsYrx6wh
 LmYqzCA+xmVgYwm4sp07bWG0O/4lMNAv/3BR6OdEHyfP82lLpx+ZRsb2ivv8ccP9rOMYaQWe1G3
 F7ay5oXlt3EUu5Nexny42eGZI8QY4Zq1ojF6hIcbwAZbrHXQcIwpkR9G78ACDBjodJIKCBrxWTR
 eDgg+hxpGLLGDqvotRO5ud5gXAlZiU0EstTkAygeVPGOOC2TqSTfXGMXNtcnVrSHx6ltk2oZmFq
 maTpaJaHMZmCeRXNHNAhZlTM9sgMK7AvwdhJx2gZlUV2akfY
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Now as the arm-smmu-qcom driver gained workarounds for the Adreno SMMU,
it becomes possible to safely enable GPU on the devices. Enable GPU SMMU
and GPU clock controller. GPU should be enabled for target devices that
have ZAP shader blob.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index c8da5cb8d04e..40ad99d75738 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1186,8 +1186,6 @@ kgsl_smmu: iommu@5040000 {
 				<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>;
-
-			status = "disabled";
 		};
 
 		gpucc: clock-controller@5065000 {
@@ -1203,7 +1201,6 @@ gpucc: clock-controller@5065000 {
 			clock-names = "xo",
 				      "gcc_gpu_gpll0_clk",
 				      "gcc_gpu_gpll0_div_clk";
-			status = "disabled";
 		};
 
 		lpass_smmu: iommu@5100000 {

-- 
2.39.2

