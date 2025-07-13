Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297731F09AD
	for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394074; cv=none; b=Khg1lAg5Jx3NxidZZVZ8ezoJd9V+aWMbvcRdvP0oTKcInJC7cdrBY+06/6tVV1Whx7wYx42PReqxyEoNyDnSMHbxbHnNEDnFWXSxqizZiLWa9gxWUoGVQjTr3UbPyF5qAAH9t3NptNKlPuZdR9gWSequvMsjSW40I9q8Se/rUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394074; c=relaxed/simple;
	bh=DMp52hjvQJeToXn5ideaGQ3795khbQZVtSdtbMOEerA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MT2p4Q/PB9x+JX6XVUzbGTdpg9cxZaRkCIzv8kYwPPRWnYmG3OqJNB9sVnZ0tx2DSjqIz5+w03Y9Ki84zye5+R8w83yhlktriCUbE8qK/Fga7jMihoMpWq9Er1mTSPgp0se1+esqEDH7M9iARazn1TzWpGDA2ohl+Mr7CTdjKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=debbePI0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="debbePI0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so1996264f8f.0
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394069; x=1752998869; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SQo06CwZZ+bZ2XWolSLrsJUXJrZwysl3KLdIVv7Q+Y=;
        b=debbePI0+EcOqz/DGxoQH+WB6k+Mm65ekrTkkx6SrzoTd2zZQG/U3NlxL2p/AFfWTl
         DGcB1ta8P29onHncBi0uNJ0UyAxQXGmB6Vh3+EKx2TtG2J4PMHFLRA/7EqV6xrQyVpVp
         JQ6NjcGRgEutbrbxuMmSCI2ODlptD4/8rNwrHf4xVkJSuAp2qtsMh7F2KA5en9phmHhQ
         +bNXOEg+4gRnaVIXNfT/rlhE0AHT0UIFHaxMhLBgTCxzaXgp7vMujE6xfvBAczvoP1dH
         398TcNljR1O1b3HKOYnCopvGVVEdhTXGyzzV/PSAyFQQxmOqTSEvVpTOnqQwj/nxjI7h
         tIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394069; x=1752998869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SQo06CwZZ+bZ2XWolSLrsJUXJrZwysl3KLdIVv7Q+Y=;
        b=eIXf5QRyjv7BXwWmYwTUEl8vYAyHAOF4XMUsQlFjn11TnPPT27Zx6oNEn3nR3lAdPT
         Qz6xqtBRVKxZQ3jemHcnhfH40gcatBtvckfJOliN32XdK8acCFQXb17DJXDuHp4u+CRJ
         QU2WxaFVmIu3PmVF4WSAonfkE82BpCUhCnKAX5FO0mYojr43OqGGYMjFdbxNAulhV3C7
         4sxRYo1rwiAVEPnVwczsmTX+lSoW2O6cmkvDXVWnuMUNatfBSCO9ivuVly25n83nbz3K
         Ymu7q2O6BBhqohQ1SRWW67EM6pU5hy5QG/MYL17M5Hclsf7cPFboyR0ahpfrCNLGyTyD
         zmVg==
X-Forwarded-Encrypted: i=1; AJvYcCWoY5o9UHMCyNMO2e0+GLF4h19myLlqoMkhw48CZ+QNyTKJFhZi9qIwlWz6KbwIG8u7zMn/Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA1C1ZyA9FjyrzBduvNA5zuou30psKFvXaVXBD41/V+95sPFpS
	WfHeRHTotlXexL3RuWkRlxUUeQyYiK1Etk65YvJuJ7ml7hItEe+OmjaPWDT2WpXbgek=
X-Gm-Gg: ASbGncsTdVxGgT6eKjYVOxWBVsAbb+NyUtlXNtE6F34xIZJrqH1ANzRmQZfR+h/JHgP
	Vb4MzP2gjXVg+ZGWU6lywnPmk21S7YM4imEWBxUJH+NPyzQKyxXxbo9QKdjxYbd2ndCfLeLaTQL
	kwBPwselYErKcCJffOTwEMqwkVgHhhn+A3dWiZtFnKym4y2CJVYiC5lphZjWwf6CclHXTjRSuF9
	QY0DL3mfngHmQ58T836p1s0a14epUGD+d6xAaZA3Wmc2kkKbhlPy17zjxmSB0O2zrGA60Oqfdlm
	ivIcEFavdQdqidIPOa14eqB2cAjyyPN369jMlQ5yCC9AihLcf5jiwVRp8vr6J22C+9pdM7Nw+4M
	heW65WRh1PNfZSfsTRY0thyu9dWXuwvgaWQ6K
X-Google-Smtp-Source: AGHT+IHS2sHqpL2/eZHUmAy8MZC5zOfAiyOO2INQCZr8EwbUKzOMR7kfyYk7nmZApin+IuOyVWkYMw==
X-Received: by 2002:a05:6000:40cf:b0:3a6:f2da:7fe5 with SMTP id ffacd0b85a97d-3b5f359996cmr6132510f8f.55.1752394069433;
        Sun, 13 Jul 2025 01:07:49 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:33 +0200
Subject: [PATCH v2 11/15] dt-bindings: soc: qcom: qcom,pmic-glink: document
 Milos compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-11-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=913;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=DMp52hjvQJeToXn5ideaGQ3795khbQZVtSdtbMOEerA=;
 b=2eut1D91kUWr+UGFcP8InACFwKyZfGSbIzuWVeP5xkcguaoH4DRmEvY3vHIxpLqdLQJKX+0r2
 KfHKbW+PBgpAlCoAY9hPuWiP349REQ62oa0RFzX6yRzG0QgrVbKKlFK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Milos compatible used to describe the pmic glink on this
SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4c9e78f29523e3d77aacb4299f64ab96f9b1a831..48114bb0c9276c9326db3256401a3ecaa8b3b9fe 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -37,6 +37,7 @@ properties:
           - const: qcom,pmic-glink
       - items:
           - enum:
+              - qcom,milos-pmic-glink
               - qcom,sm8650-pmic-glink
               - qcom,sm8750-pmic-glink
               - qcom,x1e80100-pmic-glink

-- 
2.50.1

