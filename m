Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39405166F10
	for <iommu@lists.linux.dev>; Sat,  7 Sep 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734907; cv=none; b=FhJcIqWkvRKIT2mY/MDTEL+opGejJMXC+e1fdPeoQfAYxe3kU+g445xuughYilE6iDCSluqkT7oPDGf9BDWX0+v2gjRhCbv3jJ4tiwtQknQWMl1N+tfuVDlwJSzxWCz6Gilvkfb84oy2fFQ26v5yTFLdtTWbueTc7N+dNDej+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734907; c=relaxed/simple;
	bh=gth7VehLLAYczDDqOTK1mioSLmcntX+IjHSeS1+PsRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gv0ppzwc3b9WvcuJwfRfO3FcoTwEUtaHNrcY8cSkbw7zZyJmEklAVAF8F9yapvWJUyR0rodxHU/+mVQTOmowiVMpzSStN3NoTD2WrAcSokosKdVUZUfhhEF0azwcxhUcnDoTWKvCcTHEWSjpkfgNRuPFdwCRIGCc/+EP6rfBmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCHHREXg; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCHHREXg"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f762de00e5so243411fa.3
        for <iommu@lists.linux.dev>; Sat, 07 Sep 2024 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725734903; x=1726339703; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7LsuAqj5Yv+PzKysRic0Rp3tIs0Hiyq7Bki4F0WIhU=;
        b=FCHHREXgbPNq7P77YkRmY/hcRmj7uAVXvp7opixENmUmK9N3+E/zGoKb2hhdvzpkoR
         ZzQC12rjq2bZawqJLL7rTDFlTaQO/h2xZd7gGIGG+aQfRCKbuEPR9CEn8GMw5k4Aai2V
         rD70dM+QC1PqOOMLBB8+unYrLa7MwU2/SLKLXMrQc5j2yxG6rewOB4d1huUGQGsp3wJu
         hdM5XiCswbyVvrFYqxIA7lRaOIbdF0WKXVQoYj9QA9UFYJsmQKzv2S0d86RSCTP5x7AO
         3Tbotx2PtlqiyQmzjk+o+ovUUO0bxxojgcERpwjpWGA269tMp6id2y36mVLn6ckhZv7m
         4Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734903; x=1726339703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7LsuAqj5Yv+PzKysRic0Rp3tIs0Hiyq7Bki4F0WIhU=;
        b=QEsok5o9IayTcEmetdsySfbj9yq0AGYhek+K9/6SaCZ02UGNPZLUji/bFNkUnD59zz
         ZHFX1sXJDkZ7LwWdG5fVJ4D1k6g5h1+Y+hxa4VPloHvlG9vDc+1oIU/YfurvF9wGsvJv
         xenYuv803wqyWEDo9tLJ3Tyb3c5uHzjTa1npaB3RbfR6qvAaJ93kaXvM3Z/3IhBUf+tF
         0CxMZoTGAmgBQlQvfi7h5vuO0V360KPAKfJYP+nMugVEIZCoGKZru4K8G9fZvPq/6Swg
         Bktlo8zOhBk+27ROvk4VtjwSE+A/kza+Dab8GuQzZoD073GspbIs3SChy47hvBumR1Bl
         ohbQ==
X-Gm-Message-State: AOJu0YwdtJaplM48EPczTdyXDdIl/BX0DsBsSBkfpvpK/IjyCOu2uzuI
	9E1E1lKjXyGvoU0tCbnsqb9u69rTs3n8d2LzMTwwJDcE0tlzJ6ivm2N11hBK0uc=
X-Google-Smtp-Source: AGHT+IG6Er2WTTB9ykLtsnwLJMIhAvVqgLPtZjGk+LCEAz8mWM1M2LvXxH2Ll6NQE9F97hNSetaCCQ==
X-Received: by 2002:a2e:be83:0:b0:2ee:8453:5164 with SMTP id 38308e7fff4ca-2f751db7570mr44719081fa.0.1725734903101;
        Sat, 07 Sep 2024 11:48:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c0b1af3sm2271861fa.129.2024.09.07.11.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:48:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 07 Sep 2024 21:48:16 +0300
Subject: [PATCH 5/7] arm64: dts: qcom: sdm630: enable A2NOC and LPASS SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-sdm660-wifi-v1-5-e316055142f8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=980;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gth7VehLLAYczDDqOTK1mioSLmcntX+IjHSeS1+PsRg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3J/yK0Kr6gfauwYtKBj2YifOOoYasEb2/KJQy
 oQEzjAtvuWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtyf8gAKCRCLPIo+Aiko
 1eXDB/9YMK3v0BNnzKGqm5xYDSjWyN0LHPfuoGLoxqF11BB6jzZ6HjSdbB6BPi6n8/uMcF2CYCU
 pUhc1bXjxfVuHGaf6cHWqtrnm7QnBYbY9S7oexm20BZreHSMx1mnvyugF1faew9zNq1i2P1VmaW
 tewDNsm9c7RZhrMo8cO/oHOa9PCy0u9yKVQlnBYbWFEdjODYF+LEK4HQTo3Nz/eca3UAyniGYYK
 NoyD5wvdIVIhaTLstIx19dmx4DHhmbkyOR5XRyfpvPD6mMbJJQd3pK9+vtPWua3amdHbpfVaJaS
 UyTHeyQAsEcjpl2psOw4Yjpzg+Yj+fS2DFCA/EGPiMz/yeke
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Now as the arm-smmu-qcom driver gained workarounds for the A2NOC and
LPASS SMMU devices, enable those two devices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 92695375a63b..dc8bc63bdc70 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -665,8 +665,6 @@ anoc2_smmu: iommu@16c0000 {
 				<GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
-
-			status = "disabled";
 		};
 
 		a2noc: interconnect@1704000 {
@@ -1234,8 +1232,6 @@ lpass_smmu: iommu@5100000 {
 				<GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
-
-			status = "disabled";
 		};
 
 		sram@290000 {

-- 
2.39.2

