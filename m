Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E61B5ED1
	for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622015; cv=none; b=kwzRc/T/F6wQhVUnltu2igtKECkQSOqug8wa6IRCNi6FpsJSIP1Z+OERmbJPdd/FlJiVW6nffz9GLdMutbVOwRLP9lJ/QXhqOzgGZo0cVn032NHaKz8McgL3nBQ2SirjL7RJRf9CQBOamR1Pb+1V1wJQIAiQosnA41yk2J9MGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622015; c=relaxed/simple;
	bh=Wjm+/RrFtOEa7BfBgV+P437/knLXydDC/LcDaBSqdzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZuLbUg4cAicMKEr/r/RPiJ9hSXtIUWjkbxWucwMAu65bX+g3KyaYN46oduCFvB9lQAZk7y22p40aRux97B1yT0DqT5etzslDJgxzwJi1eygNRJeCUNLSJByH8oPt0AKHL0GMLzJ1AQW0v9IOl9HIEkVb1BnHw3s0gaC7xu7b52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcVxqZYf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcVxqZYf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436381876e2so2703755e9.1
        for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736622011; x=1737226811; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/qw8YuMgYbNsFsx9INqoN5rDRO1U0upg/GNac9bIpg=;
        b=YcVxqZYfppRzFGbvMdPLd68KYDq+qG2ncEuXL6NFg680IakLQT30kMSVrGXDJ6mk7V
         SAEnO+EY0ktZU70A5VEsUTXysEyq/E84TIOOzbQ2ozSo6y4GsXxSzHDIdfT4zxeIDGlQ
         DW87ieFLZxQGcWpPAUD9jWk8MDxj8mrOOwd1tyr23Kn5IaFXodk94yxejyuzUFtIrT+g
         Mm2aZ4fVOlX9WwfIwh2Jx0KlQSnbilI9915sqSnrNSAum/PQQBxKiJatekmh4t7zzWYM
         b4q0zoCaw4AUv2hF3GQj1m6v4pdc7vSg5/wE1oBPG+5RuydgoyzKVeyI2zWSCQe9SlrB
         ULmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622011; x=1737226811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/qw8YuMgYbNsFsx9INqoN5rDRO1U0upg/GNac9bIpg=;
        b=u3VXwpdHpdwAbKGF9n8xoVXf9yxGLRTZfl//79rzRDxZzG25zH9GrlZ2TzmJtaGUcJ
         riTj9yGp/rvDvVOfaL19QUP+LOVipLu2+AC43mJ9RQZs4LLXb5KEpZxiOEte7LOvua5v
         rJHT2FW9UA3a8mdzceVIebGbuui0nE5yvEhg1RAmc9RdvJDLkpHnMre21WJFRvEkUki2
         /H2TtPOBQW0MSXTRvYNZSXle1+GAeYJu9nZIEjvOQaZXmu2qTFtRkTMshUx0NribVMC0
         BqnFVNB71ki26c9nARxOBk9PKmtLkHJmr2zphy4pY1UXDaLpzBGGvIMvgSI2RwMvI8qG
         tOSg==
X-Gm-Message-State: AOJu0Yz8NI1HpZkfbazxR9mTTGNc+boyI/j0madipQSi8HlTPpAB1XgL
	Ll1EEX9Qae5wiPkoUqp8zGvY8aFMbk7V+eDINkK7d/DbtAg8dfpG+MLdv/EvarI=
X-Gm-Gg: ASbGncuC26JLV1hIGYsQd7H6dWa/G9HJIZUP3K6XeNngVtIW3uPzMZph4O2bP07JzJQ
	nVPHxwZWdRnNSc/Z++HeXSYoKfv+Vb2PMNUnzg5Anyd09khXp6KfNx/bG9jZk9tOA80p0mad5zN
	SU5ZFQYzBxI+nOpkA0y6fRKlbABA8wBqZVH57RIzJTRCeDupeMxg0AfCmls4EO+k/GeUOoSBSBz
	YqfupRZ1wGBeWR3l+FwzewFZmnj9a1pCtNXgzQZOVT5b5/hmsD5Wx/PhvuXIIUVg2h9yu0Q
X-Google-Smtp-Source: AGHT+IEa/FqvCoM6bG/HCK5AVPbj3yLeKzY4X1P3xKRQLs7OL2Q8sGJMkfd8OYGtKR8DgmYIry1K6Q==
X-Received: by 2002:a05:600c:3c97:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-436e2713e51mr60366545e9.6.1736622011221;
        Sat, 11 Jan 2025 11:00:11 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc81sm91309075e9.5.2025.01.11.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 11:00:10 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 11 Jan 2025 20:00:02 +0100
Subject: [PATCH 2/3] iommu: omap: Simplify returning syscon PTR_ERR
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-syscon-phandle-args-iommu-v1-2-3767dee585a6@linaro.org>
References: <20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org>
In-Reply-To: <20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Wjm+/RrFtOEa7BfBgV+P437/knLXydDC/LcDaBSqdzc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBngr+0YaQ3ImDqRhIbmWqwPoUUUn0NLpRvTFdF/
 QTYMCqbOxyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4K/tAAKCRDBN2bmhouD
 14WkD/9gwvd+7w7WaOdBA6GjHaXFAx6TkIqfYRFXyzsnoHCUCrgCO/LUuBBjnXki4F8j9mnjLNT
 vzjEKKy7Jj4im/qS45M0SUBW1PtYVhtLAU2hOlQFAYB8NuPwNvh5MCCCHQX1vdqJ9beDxytTCIm
 3BUKm6EAZeFtMPIkFgrSuMUecLz/7xvLuCpQbHgSKtgrNXrzJFScDVVc+7vE+VqVdNNJDzsB+/Z
 VpozubWl+GNS0/9yfpPDkPNtR9BkyR/rf1u2uLHVeLqJplCHkiv0eVo9l4hH09JnIYfb+c2DGmm
 j9GqkCoGtFote+TdrTPX/rRE3fX38C5SDe1nfWbtB7L6H9JYxNZi0wBatB9ei9NirAiCfPHfmQh
 +hB8oJdUTorwVi1U9UCABrIpIzpNv76oiq6bEwCkKTXdC8zUhFGKgNoSWLwcSptWSmGcknOqYFm
 +IIA7XSODt/tORIAmgEj2WoZF/qzvB8mK1OYVZdzM0karZJdRHvCWZ3Nv1s1NOkMGz5HR/V39oi
 cr77Vi/SvnXPx3XsPbOGpCuczDGOS/JQfLswAYvDurOuERV3YAKtTdHzAsVB2KFioOozyqobqZ5
 PZBiQlJ8J/V49CGmACtiXz8czJU/3zpQYl+cVUyppYiVi6EguqBhpQF2M8MA0nqmn556cQsrI1I
 jjXsOI8qDMCtsGw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

No need to store PTR_ERR into temporary, local 'ret' variable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 04a7deaaba25cb270eb6eeaf6a21030440f78a5e..bce27805805010ae473aa8dbd9e0cb903dd79bba 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1123,7 +1123,6 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 					      struct omap_iommu *obj)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int ret;
 
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
@@ -1132,8 +1131,7 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
 	if (IS_ERR(obj->syscfg)) {
 		/* can fail with -EPROBE_DEFER */
-		ret = PTR_ERR(obj->syscfg);
-		return ret;
+		return PTR_ERR(obj->syscfg);
 	}
 
 	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,

-- 
2.43.0

