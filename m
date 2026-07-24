Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50477424D73
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896804; cv=none; b=up+uzzU4036JuuYGtWRv64JOFik8LjPUiK0EdYHAF2i8/F6ApLLpjJg1/KN8OKwzrGV0uqr5HVqEOFlpNLBpNvRbAgbyBqn/QXdisD3mzVp60VjSQ89z9C6I2fOLLKfq1hoOQ77CmNy9ruelFNmWvu0KQ3VqGmZPc34GKUlYqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896804; c=relaxed/simple;
	bh=grNzaIZhTarizm1uEFeEaqFDbVnPHTcu7XioeAt/FBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1mjhva4je1L+xGVwOoegbNJNAokdRCJLqrKgRCzyRleCDOcXMF7S2hwKYzkI6hppqBi6mM1SsZDTiH4MLLNWHKzYPa8Wy1L8iLXjzf3xs1TpuKcKjSP71acn8G9CAsgc3q6+tfqFty+Ud0cHrTABMQVJuPfzRzFO6whhopAHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jobC8pqg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jobC8pqg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f703a9d05so297030f8f.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784896801; x=1785501601; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pb0xWtZMy3wb+Efco3IddiNHPbPPr5N2NAxGlPTtloA=;
        b=jobC8pqgqJBDzG6CY9TjB8L9jsi00a+MWcBtzTxhnmjo/H0BVxBsfuiwlO1UJzvvBx
         +8MRHWDOZXwJT7apwE9D1Bwhgj7Ep+kLGr+KU/XjaTI7HxzPrX1qisP4oLQkntGIc2yi
         5PTzq7N2u78m04x1dZXQgwh+QukVaTGRJpRfUQX0EColnfWjlkZM49QtU9b90935Xzot
         zSi8Y82npYY13ef8NeL5UuiratWFuFkCEPTtygX/LeOwZLTF1fu7dWd4CNKn/WtRubF8
         c3+iGRjvLa8cObchU8ZexrpTTdI7JrvCe0aHxI5/MjbypX1AMnjtE3PNtUmyXL9hqmR9
         F92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896801; x=1785501601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pb0xWtZMy3wb+Efco3IddiNHPbPPr5N2NAxGlPTtloA=;
        b=C/27czcqSPX4ZvQQpF1WKB2GT+FsKL+SUG0ZfAqfHR5Nc27DguAOWYCbmlDUOWIv/d
         pFD6h/xfeyok8ta0C4E8SxF83GBDz5fof5xpNeUmnWqYmUpglsLCn195aU6Pq3d+YeP+
         4wDNXy0AV8SDWPzYCR5JFZhOSUVHYtjcysNXwNPxIi7rb3TiG/GcwDIAepAuupXE1s2J
         kINq7c6aKHLaKJpgd2/EEJTHj42+V9cUCuzpAbjYEUBxF2qMUFC0mAZjLckIWb4Yc+Z8
         IATYTZ+yMdMNfKNAXulmeCMqLxhL4iYE/YK4p2n/lxNkyzMH0IZfCo0g5RTHa5iV5pMs
         6Lkg==
X-Forwarded-Encrypted: i=1; AHgh+Rqnrf5pLcEyjZb5Y5mMnlQ9EOth/j3fjmCembH2q0z3ND0lWcjEkhOuKCIjuTcZWtLlN3AR2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQZrh6UzSNUkrLrBz1AhHhireTzjtR33TsOLtmmsaxRiRVLlAu
	5IOSiN6Y9hEUgSx+BUL+L/70M+f48AouGyRW1Npzh1fIdYWsj0m18UgZQ6Ke1A/ULp4=
X-Gm-Gg: AR+sD13fk1Z7G5jdxIOJnPfSKYz6ML8DvuKH6nKHaIzYwlE2kh8/Vt9sRzk7pyECtyL
	zJ/b/4ZnqhKTcIJPIlak9Dh0hi4bvpXDjwEKhDfjbAbrQXf1wu8rvngl78ktnD/wai0ddBgJxFz
	+++sBwnY/4c2OWxyBVXAOWIZKP32THOy23VqnyLUx4shxoqkPI2tA8eMJ1XKQSSzWSE1I7Nloe6
	ErgJHIw3iGXIpz79o8hyrlkZSxa5aKpc3TmRS5w1dJ3NolVonT51oqyREpJfemy32g0euul4UH3
	WVwD//an7k5mLBCsG6Gt+kuPyJbp2Ul/YcnzEa3PlXJXqalIJWGscs2TiikRVolKmyJ6OGp0w8l
	4mP4lh1zYL+w1Jdmgx7gApzn7Bk6pEGceVHoRlleP3/iETd/rRbeOrPmBMYCTTEZ2a66uGis5s0
	uZg/NMTgZ2r7KiV+ogjDn1lRfXdFXKHK9DwmM=
X-Received: by 2002:a05:600c:c059:20b0:495:63e6:5fb8 with SMTP id 5b1f17b1804b1-49573c9bbdcmr62628475e9.12.1784896801561;
        Fri, 24 Jul 2026 05:40:01 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([2a00:23c7:314c:4601:a07c:a901:acc1:9287])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af6b10esm71556795e9.5.2026.07.24.05.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 05:40:01 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 24 Jul 2026 13:39:42 +0100
Subject: [PATCH 1/2] dt-bindings: iommu: add arm,instdata-override property
 documentation
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-arm-smmu-v3-instcfg-override-v1-1-e7acf4a8a525@linaro.org>
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
In-Reply-To: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
 Daniel Mentz <danielmentz@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
 willmcvicker@google.com, jyescas@google.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=grNzaIZhTarizm1uEFeEaqFDbVnPHTcu7XioeAt/FBg=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqY10eAg0RYUiLSa+cCoQ/bi2kFDEdZd0AvKhcp
 BNevQec4jCJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCamNdHgAKCRDO6LjWAjRy
 ujuwD/4vdtU14qtM7zY1gR4pBiw1bskRRH+U/hdF6Efn1OO0Dw9syoJjGIukFMdeUZ7ZazcigE0
 Ehf2cje464+yA/9S/eHT+2+6J992g8bI3b8A7sFNJE4nSStrgA154nK+Ns8okuYn0Uykyllx8sT
 oFOyohXlpjSkV0YXzwZIoBpXULUeiSXNdPJCb+NvM6dE0VfqD+6LCu6+qjz5q9pLnN9PFPYL+qa
 ml7zGOyKfLE/Vbw/HrWZ9n2p333/reyCw/zvIce1ZPKjqCaN8udMSLBqBRYr1GIZ2GkI2XRoDCN
 4IXAwaoUcXTqyV08728bh9c9G/kkTs56cNRWIRwaYWxFGPAxqZruRFs7GD6HnjpXr0WYGeb71lA
 u9DMtcE3AF3K3wWQ7TlymI2zAZCtwna7WdqbvGnUvgfuOt+R3Q10rZ+kcHqE0KLKL/egHYO+Ymw
 pZiQrylLK51/pxVqZK1fc5DL2LGs1XLkp1rOIYak/c7Hs/oiRgmvRXDsGjhN1y0AHmuQZKpoiXZ
 DEZmtJa00EsMsFit8+YC9WQ9JxtTj3dCY+c1t8dGdkDzc8hTymLXl2avvWuEf92eMr/Qenub7K7
 vYypUP1/G5BP2nku6FoVTv7lOz3Vu1lOZK4PNEkZi5BBbmTULXr+HLWFZ6QpFFdoYmTwn5WwR3C
 voMklnr0DyOl/Ug==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Add a new arm,instdata-override DT property used to enable the incoming
attributes override feature to Data.

This is used, when the smmu can't guarantee that these attributes are
provided correctly from the client device. One such example is Google
Laguna SoC due to silicon errata on some IP instances.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 82957334bea2..23ea5e8880d4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -83,6 +83,15 @@ properties:
       register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
       doesn't support SMMU page1 register space.
 
+  arm,instdata-override:
+    type: boolean
+    description:
+      Override the instruction/data attribute of incoming traffic to Data
+      by setting the INSTCFG override in all Stream Table Entries. Used
+      when the smmu can't guarantee that these attributes are provided
+      correctly from the client device. Google Laguna SoC is one such
+      example for some smmu instances.
+
 allOf:
   - if:
       not:

-- 
2.55.0.229.g6434b31f56-goog

