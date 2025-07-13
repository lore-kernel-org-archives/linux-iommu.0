Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07731F9406
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394056; cv=none; b=lKcBbDMpytiGkLsc/9VvT3YP3tX6JPRDAq6oR00Kshpie9SeQkHOptw7aRRfpVoNKn7CQEmMn9WfXHj/lODQ4+kXDmHpsdug8xAPETZfJN1KvkU+BDggvuNrj294qfg1mvJKm/xV7inGbcGSayQUuFVPI5YMVKkQYwzt+L5xIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394056; c=relaxed/simple;
	bh=aDMmuhwLGm8e9aVoqg3PeCCwJAaRLrTPedtNvgdSwWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTGw7YfCCzvc3zlkSPqSsyfusXLzJ6K4PCFRCpX53uJT7jlsuvp65bZ1d9KyrMZRzwz/VwVgyBcLbDQOcZB2Ir6gezmwyQizCI4+ug+5RAWB2yHkULFs0bAw5JoUZI1iECwGozn6LkZAFMfwTGdC7WMXpIaZfbWjDUymxRNZSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=og2bLk5+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="og2bLk5+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a5257748e1so2390874f8f.2
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394052; x=1752998852; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/c/J3A9ASq/x8Yj1Xu/txbcuuFB9UfWNR/sa9FS0As=;
        b=og2bLk5+9f603Thqaip9myjO+f2lt0VH+rivblNZYV9I0KEdPylRhQG2Dwja24O7lN
         5nljkmpY3u2jVrj/hx+/KZs3AL0o62DCU0Xe4g9FEixjEpLQI1Nya06PKxVjdS/Mr1TD
         /LXiBYUiGOmDNUUFYbCfowe/gL88q5QphhzsQDaTPfePyC2lNlaaMgl67wMNE3J7ea0W
         hrT//uaUWjwL/H3rYhTKaYH68vD5KBo+TaK7Gls5rqt7vhZbN1U9uTLsSJPXn0KXht1B
         xFiLJqQkMd5rqj3NA+mLgPbbOGEjaclp6ft8yil854Q5gPIuEY0Q4bprozt3ch1hjS5g
         n9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394052; x=1752998852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/c/J3A9ASq/x8Yj1Xu/txbcuuFB9UfWNR/sa9FS0As=;
        b=ltRgommp+X8qrerfCNPT737nLYEP6P/V4ZFxjTrL3CQ1FXBk5eUyDxX3V9LADlDzer
         pjO7qaZk7kzGr6GhK5qgt4Fxeu/DvsKyBE2qVGDCVekHXHFZzXKrluKL4zkkmkgqMp21
         Etvo8IU1pnkKPbLcZc1gNLThIvwV9hBHjs9wEjfzQYQbV2PoG5jAEuDwLKzY+fwdTfNU
         zxRN/r7FCtc2QF1h5jLbrX7mP8ayOtHbY1mtcl+F1h7J4vNWVngGWGqoeeNHfaw1hgUc
         0lRkwJN+90UWjjt+mw7AdL7nEMFuOfx6+n9TfipxXkvA/w6rMCFrN0BJjPQ/R5y00EO0
         GHBw==
X-Forwarded-Encrypted: i=1; AJvYcCX4pt6aYNK8OkVnOWqQ2EGsZJesemRwpx+chTEL0saAGm8JAka6pCNKrjceaVC9LnBKnvKLsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfQpGX+5QOzdsqac3gcAzxrDAZqop7qDj4uWYEZPJW6HR+/lfY
	T8z8ElSWO0KXwpab8aMTUWr+HFpqqh0j3nJYzA+bB/S/MeiEZbTjxwf1GIm14hSCj9g=
X-Gm-Gg: ASbGncsAL0tSmIm1QlSMywp809isaDR1iC8N/VIc76g90+IB8AQRaDSMFF09dZMqRx6
	MNqhT+5B8PqFGP55pao8ZCCfM5ht84pkR6vMvZlwoiqkRjw1B7MLXcTYI7rrh/UapQmqlJ9HAZf
	taiFG3FLxWB4TOu2xBfBXeRMwL7LA1jqKrKeWPf8wbD0b/C6Q3hf78PWkqmHIT8Vds+FiidQIEX
	wba0/ZiQHyE4ne185PHAdg9ZcwlgBqx5XcFeIYspMvA4mdsoDVPVYJabDPEKgKZLYWU5HGCK9Pz
	T6jwY6Qpwk3PKgazddIF8N9V0vY+0GTxUOMh8xEcN+zNJ26i3jaEB1rCWzCazFGMOjPTKi/wcr9
	ztvGwkDJ43zAQswcNg/JCRv+ZW2nn20Jwhk9A
X-Google-Smtp-Source: AGHT+IHfutuWB7rD4cm9MzDFG+4cnjfzK3xIdEUacutPo2JmbTjuiRMzIjn8M5NoivS2vTb1Jp+CSw==
X-Received: by 2002:a05:6000:470c:b0:3a4:d994:be7d with SMTP id ffacd0b85a97d-3b5f2dd470dmr6368310f8f.23.1752394052404;
        Sun, 13 Jul 2025 01:07:32 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:32 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:32 +0200
Subject: [PATCH v2 10/15] dt-bindings: mmc: sdhci-msm: document the Milos
 SDHCI Controller
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=846;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=aDMmuhwLGm8e9aVoqg3PeCCwJAaRLrTPedtNvgdSwWY=;
 b=QyvoywS+ViPILVHSWP4Oe4jmXijRzJRl4R/Cid8Kttmp8MEimcvZbZ2reSR7fMW32bxl68sjl
 rIaZtlOjefZAQM2+cVveN692VtVF73WT6QgLclxD9GL7msUjQM+72/5
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SDHCI Controller on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 2b2cbce2458b70b96b98c042109b10ead26e2291..6f3fee4929ea827fd75e59f31527f96b79b2cca8 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -42,6 +42,7 @@ properties:
               - qcom,ipq5424-sdhci
               - qcom,ipq6018-sdhci
               - qcom,ipq9574-sdhci
+              - qcom,milos-sdhci
               - qcom,qcm2290-sdhci
               - qcom,qcs404-sdhci
               - qcom,qcs615-sdhci

-- 
2.50.1

