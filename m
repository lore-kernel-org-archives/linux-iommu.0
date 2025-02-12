Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FE202C24
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391591; cv=none; b=Eo1NwxUumFj1Gdvam22VZpxA5Z/FnUSz9Zie8CaNFqZQyY+zdFbmq32JRz6Ru8/naw/KyXCoUI4FXqLGVHNtkzXrPA/Pt1FHSIDELi8OXlBF25YSVp1jy9YOyOVh4KqH4gJygktmOzEV1+mnbp8lbYtvxlOjQYa1GauUza9sET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391591; c=relaxed/simple;
	bh=Wjm+/RrFtOEa7BfBgV+P437/knLXydDC/LcDaBSqdzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lH8sNyOtP+Ug9Fn+slCpdFPfhY6UFpM2XeAhTDcrAQ+Q8S3VfvnjbIcaWVFoS/iX/b0QIoE4XewzQY3q+59sAIQsZgPCw5LUqIaBzagEbiiZCc04sLQ/MM03ggTa9S4Y0BGeVzGdiFYDUdjpAs7x/ae57WMwIViZapnnKdD6T8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nZiaaCPu; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZiaaCPu"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de481310f0so12146a12.0
        for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 12:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391588; x=1739996388; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/qw8YuMgYbNsFsx9INqoN5rDRO1U0upg/GNac9bIpg=;
        b=nZiaaCPui0To7JLbLlrLAs28qYa9g3fGwpOE36PPjijogxefPzSGOlVajlwSnBabQ5
         YnDDypgC+o7xY8kDKnGtkThiUfpOo3fk2FeScnH9l1HvNSNPuhgIFhVgOI+jFw2UzbeZ
         881QYQT85ldKyYP3f6IYxQD0/9z7/GlaavLumwsKTILP1rUW5TSFLrEmz10K0Xesb5zx
         O6fWEg8qtV9ZOlwyV9Kr36YJdDYeQUiABmSPhDe6SD3e6zDr6Dtl37doe7luiSDx90nJ
         q3wqE2UdFcOAXbjOJ8RlhpvvI97vwAJBdXP0F5x+8EZEb06mZlcllHKpyzIWmwZiASKZ
         eXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391588; x=1739996388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/qw8YuMgYbNsFsx9INqoN5rDRO1U0upg/GNac9bIpg=;
        b=qJcWxpyo5gHrAB5FfDtZOqSWABPAVrHdKFJCGbvnC4qVrpk2gSkxtf6NQEkxbDRgXD
         Uj7GsQ/Me/N4NJfLLR7Y/S0geGblCYhDc4cJ6UQnyoRHBuQEpiB26JMONyKw225MRh7R
         VdClWVzjWvzT2WoUjedhYV6R7cAsPT+EzVyJVilHh4BLj+8/X64PoQbT6pQtFE0WyIFK
         p6wdn1FK9ex5ocUlV0mGp+LqW6QWqZbL1g3032kfO15jPTlmqqNQ/vurh8WwXKJtgPYW
         ou6uZH53PCdjlxis+njpZyKsFVeoonLMnOPPFC954PiK4q4IfX7o3GMl9ccYCSXAW8bP
         M3Lw==
X-Gm-Message-State: AOJu0YxKjAnpZljgcl//jkozavwZqoD3rNQj0fjskretCtmdXQhjHU1s
	uSZLr5nmj9mXDWr47dV+HNUj2vTz7o5T7d2TGvAhX3ZdcjJ6yXfr6E3QHw8vhM8=
X-Gm-Gg: ASbGncu1z5tCaSrhfizyCS8f/VQdIPkeXVcGXRsXWH863o9UIBpfWsm1JDNEQjF8gBS
	PZth5DptqYDnvSSOQFgDI/o2pdTHvR9hpmsQ+5yETSMMBydz0FxdvUIOeWbIHdBuafKzajqoUXe
	VHbFz5v3ccQsyHZUU1SDDfAlKM+8MYpyiwHQbAgI4XTYQF1eeP/90ouTpNpft17Po8IsF8RYqSR
	H2RoKUxKo2ewkijE2w1gS4eZogjUy6Tah0jTgcMLjssEaDtqKuBmzqnljT4TchaI4shohsd1UAg
	hgN85KrcfywDuGujv7GqMoihcf/8U+U=
X-Google-Smtp-Source: AGHT+IGF8pu12XjdIIkO0K7CQJD4mhN8hPLT9Ezts/KvaBalNSFXhsxk2rjSGiqkZ9maq3+XJbTA3Q==
X-Received: by 2002:a05:6402:26d6:b0:5de:a8bd:a231 with SMTP id 4fb4d7f45d1cf-5deadf7f96fmr1405147a12.1.1739391587918;
        Wed, 12 Feb 2025 12:19:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9436732a12.45.2025.02.12.12.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:19:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:19:34 +0100
Subject: [PATCH RESEND 2/3] iommu: omap: Simplify returning syscon PTR_ERR
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-iommu-v1-2-c3fab486b426@linaro.org>
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Wjm+/RrFtOEa7BfBgV+P437/knLXydDC/LcDaBSqdzc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQJbpiYmbeOW7tNs95AFVsSVJIEUHNSEy5Wby
 IbCqkEgsPiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60CWwAKCRDBN2bmhouD
 19pMEACAx4yY1a/yBpXb0g/DvzLC8SYJdzpX2M20o3LO/8RjeqBGdZMUvt2uYkioed9EHRumxjd
 w/v8U1pJ/RUP499WTjw6wzk2icyXn4u3NRSKHyfWHDtYggW2tuHuYP6NXpQUOhrB62HYgsaTX9I
 0PvVfyc7aSiyPVPLjepPQNV0k3zZErixrWg03iYS5UJF+rlRsXIgHsd0fR+bt9xcC9ZKqfTNhSF
 9a7+cuyKylmVGw6Ra/QH3nP22F2O1LxyOkkiqrFmelou2qdA/Biiibf5BSO1ZHMWw+wVAZttHUb
 jO0G8+0cct9vUwzyx0ql041C2OnDVypmXrbBpOfaReOiLWiMD1g/VtEWnYsA5ERIelxkjmTjRFL
 VqPBf1N59kK8lPE8yVM7uhZNh+69X7fxCrUkk2ir/0VR6/BciVl+lmVqHgh8XrQA9cwoQMkiQHN
 AXQ5izBHWaAA8z2tmMuaM5MeCdLvB4oqbP2YqT0dABsqh017fRZbT7u1mhCPsSEokVYb66eRmcK
 fFOCj5UtumQITt+abb5fNhf5h+uvqOOLz6xLcCQ49puaJYF6EymOWRLylHBWpuE5xFRGw+uZE0n
 piguclf4TmtfRdCIEP03l3xoyFDPCbVGYtMO3ZPSFYf+HhNmrB+KnrYkiwCvrzHQxa3DuHI9Cec
 aPjC84+nQHP+m/w==
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

