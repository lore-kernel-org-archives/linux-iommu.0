Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B333F6
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117441; cv=none; b=tHeXuGhsAaOA0nrxbSb2zstte/PdrvVXfsg7jRxX3c4ryf3Igj/JaOPwR4nssaJrem/DtAqtShsB7Y61ZxXXZrdK1TgPnPf4opVneOYtnmPoktD0fKnY3crsXXqPT9sUbLCS2ZXvW2uOeL4HFqGFk7j1oss1JCPA3qC9lxUal0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117441; c=relaxed/simple;
	bh=5iZ+1LBZMer+pZpH3XZWHbsSvLh2Yz7gnxpvLUEV64s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1gHoVYBUYMcT5TXK9lYtwsDVWf2RjUO/K+ENK0sacT/u5bRKK8ajBuMRnBbH0VzvISlHTeTlcExNDql2YdR5HFG7vpQoUoq1AlxlC2LE9o3exgBXaW7BI99meAE2kkFzb9fPYdRlusLNLM9JGMP+M15McFNAlgt5x78i7oZZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WfKFAJWO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfKFAJWO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43e9ccaa1ebso1466665e9.1
        for <iommu@lists.linux.dev>; Thu, 01 May 2025 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746117438; x=1746722238; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8lqK6tfVd59vX3pywJVYOhORRQne8XIPVi9Jx6VDF0=;
        b=WfKFAJWOHy+6x3mncmfkKx3fcmCFuTi2QfFnxFRLEG53ktNlv4SKXWZVV838QhZn62
         gzkGAG3rnHFQlDVz/sDElLEb6jzO+gPPl91HUg5p/nd9dQ2XSzU+ZK8MOAH5gmxFf8xd
         eo44q2RWHcSSDK+cuZ3iJKV8Cfm8WGIqxL966FfPyn7v84cQ9CaXE5ghmOj64pBSaMaV
         7ImJbAsMQSZAtohZZLqtLY2gzd0+kN0EzWmsSykrl7/mh3hNZ2/gN0wl3sTHAMVx8l3Q
         PJf6Y+hgOEq0wZldrd8jihtH2GjOvye1oTVpLTG68d4PnWkd4+4J32VSFOuVfZBmNZzr
         lCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117438; x=1746722238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8lqK6tfVd59vX3pywJVYOhORRQne8XIPVi9Jx6VDF0=;
        b=o4GlBULZpBqtBI2OUKeu3WmacCSktha4zslsfC0YC09REgZ992C0tWAwoW0ovXDymH
         LvE7s9O2E5bLuR6yKAl18FF4rLyEUsvkraS1WQw0ZDJlFKtgTYqf+EBOL5Poux86EOAJ
         VSQldd87OsHoX6e2JTkYMOTk4VfO+sz9d40hhKvr4nox/8x6mQhJGDyVxcQ+f0EeLwJJ
         y3hBdmN+rZFepZ9iYTLeBTbCd50GjMIWMNTpkRXE98tVQE8COWqrRlCaHlFkARBQADH1
         MlsuH7gxLRvZfdq3vbDca9jZk3OGk7H4PeuaiLvXjJuSxu7Cq7nUh6gHr4snGqAcIZ64
         Xe3w==
X-Gm-Message-State: AOJu0YzReRt1UahMaihbpcPO5fyBYVUZVHwlJaeKPk5ul55DSbusTFjj
	+Mw2YvV0dD5kimh6LPcZeZX8CglIcKUtIigp7bjEWcAooeOrQSVnctZ9k2KKpRo=
X-Gm-Gg: ASbGncsD9biKH/HpP/MoEamYFRI0Gsg6ytp4jZauv1KxehK2UIEJoATmtg1VnnGBPGT
	qHcMHzsDbszHQTqGnsIfhDnnvvVtVrtO6pH06ep4GlBNbTTSt5ilx1lGhKx7AKVfYUZyFK+11O0
	8jR6bGVJpNHdVGOt+j2QPN7DesjXUfvP/Om3yc0f40Z5z2iSQUWgYGXQqRI9MvsX29LTWE55zMx
	GsHkzn280gdZo0slgfD5MeWf7KSWXIbapeXEm5p6BXCsUKjjlL16fv/LB3Rr+J4R1MumCZf5pqZ
	WEurbNQKA1qkDfsTtbbxJm4n7Jz1FYhssprkjh+q13AGa+Z1n4VHxc/w7ME=
X-Google-Smtp-Source: AGHT+IFZwlTD+VXEFQskm5Opg4QT08E4V4yhKr2btjZ2ach7B7s8+ZAR92EKMwCOCBvn4Zdc7T2oaA==
X-Received: by 2002:a05:600c:c0e:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-441b76b815amr9384095e9.5.1746117438399;
        Thu, 01 May 2025 09:37:18 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a288f0sm17166175e9.27.2025.05.01.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:37:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 01 May 2025 18:36:55 +0200
Subject: [PATCH RESEND v2 1/3] iommu: omap: Drop redundant check if
 ti,syscon-mmuconfig exists
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-syscon-phandle-args-iommu-v2-1-5a3cab296972@linaro.org>
References: <20250501-syscon-phandle-args-iommu-v2-0-5a3cab296972@linaro.org>
In-Reply-To: <20250501-syscon-phandle-args-iommu-v2-0-5a3cab296972@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5iZ+1LBZMer+pZpH3XZWHbsSvLh2Yz7gnxpvLUEV64s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE6M2ILY0VIn3BIClSvY2jKPuO2ZgMzm5a6pN9
 Hx8f2cAHZCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOjNgAKCRDBN2bmhouD
 15TnD/wKU43Zt+z6TRR7birMMQYuwrxVFM6QbcBghyAdrUuYvBvaFWylo3sxGwRXrxQEi7aVy8b
 Y2uBscPzKtNC+oIxA7zRvI3ttqWtsBwY/iJrd1LgPB69tBvCvkPE3x6liwxclqrWv83JRpxOfh8
 wTbtqA0N+N+H7tH58L7E40i7OkW5ek13kb8TCqSZhe+GC17WYbQreJZ+f28Wg5VBLT6y15iF9wo
 e413uncYze7Q9LGmPeAmWW6+3AhghiKuqg/kAsQ/mkqSuDzLPKkphG0CFxImCKH7Ktniy44KJ2f
 FaJ/px0bcruKsShHrH81Q6auY/JSWbGP7krcrhljbSqsEJ5JpuGkt3MfkGQjTzJtZovjC2SwbuC
 WDAoJpWsXwq9v6WXMxdML9yg4et6s5Q5sWJpTHbjjiScPfg+if13v3IxFCKyRnZt08iZdsqqEYf
 ss0OkD15qM7P+PnYccuMIcbVGQdrX3qQT7Y5Vcmtl1WHAbePL3Xj45nbYke67iyk5urV4j8Xgxs
 Ckr5V+w2cZUPlReNlqD/oshdO5Ln6i3PQrSsHIUTBndConaw4BZ1J6x2fmyHjvSSXn9tovdtXFX
 KjPcSg8HMs9XewBrAes4OT41kJMBesAI5ABhORTNE6g0s/mmqZDyqfiQ24RreU0sFZh+COAPGcy
 eubtyBdyW4diOqA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The syscon_regmap_lookup_by_phandle() will fail if property does not
exist, so doing of_property_read_bool() earlier is redundant.  Drop that
check and move error message to syscon_regmap_lookup_by_phandle() error
case while converting it to dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3c62337f43c67720a15b67e8b610da7886f6f39c..4448c0a512137c79195112eea25d762266c77bc3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1123,23 +1123,15 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 					      struct omap_iommu *obj)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int ret;
 
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
 
-	if (!of_property_read_bool(np, "ti,syscon-mmuconfig")) {
-		dev_err(&pdev->dev, "ti,syscon-mmuconfig property is missing\n");
-		return -EINVAL;
-	}
-
 	obj->syscfg =
 		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
-	if (IS_ERR(obj->syscfg)) {
-		/* can fail with -EPROBE_DEFER */
-		ret = PTR_ERR(obj->syscfg);
-		return ret;
-	}
+	if (IS_ERR(obj->syscfg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(obj->syscfg),
+				     "ti,syscon-mmuconfig property is missing\n");
 
 	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,
 				       &obj->id)) {

-- 
2.45.2

