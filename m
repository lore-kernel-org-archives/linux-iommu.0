Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012D202F64
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391594; cv=none; b=kQF+IragSI5GIPkW5JNE+eiBpIjiQlDDQ9q8/SZMYA22loCCk+U1vThaH+0Y/HrUKvRXLL3YPcg+3ZuqfF2kqY6dwcNAHsufhpcgpjXd+s0jPBnHIRxNGp1DRS4mLGL+5vv7VZTTyIGwR2s2NVWmX7MdTH8FJwdMRzULWAzYnQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391594; c=relaxed/simple;
	bh=J9wumi7qlxcc6299rTzUmyAx5YxElF0K+3qqjT1gkcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkHne/OnxfjWihpnTL4Tq4SUtArSGMu+0WEZjEVd8yS/nLyxCQL1IbDfJa1RHCt2Nbrk2h6JGurmMhu0fIpldaDj1aPIX3TYtk69I+w79ksMUJ/+eknmfbRdny+uSwbLX43tEAWlqwooLMY0xn3QUej0Cs8hJmImBwcbVBb41XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zV4ZYh+5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zV4ZYh+5"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de3723cb76so7785a12.3
        for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391591; x=1739996391; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6+F/nzJic4e58KU64FVAzTlIBmwAdN4ZEHOdFxRX/U=;
        b=zV4ZYh+5EEBeb3PC8tUGmCo3GXUYqNFjx3Hl7T6KJdQJ2LTxOubgD2GMs+anL9ED2i
         Ly+NwZ48s/W6A0q4sqEH9ujgwSoZZLicDjhIp6xEgVLFAm6kYy2u0wQfoucRcaM4+T2e
         5ga0/x5jcSiU00HKSUlIDU95PpnbHVOO7O4nD5X0ZmKNilP0j/1iAIVpCESW1oo43ORI
         YNrhmT+ph5wxDDRQ0DJZIi3pUImZkihL/Tmt3IxFv1Q+wwLqIZwU09HxrWZbA29D0DR5
         K9kxqgkwugCsS9CZkbSRlUxB4uAUDyQq7TWxjNj/YHSbeby3qsHbfpagp/f2IowrBGCr
         huHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391591; x=1739996391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6+F/nzJic4e58KU64FVAzTlIBmwAdN4ZEHOdFxRX/U=;
        b=cR164C/Dhx5LqcNUljghGRqi5gyAKTv6uXzJO6zHLymKSInhKjEaFlcAlNcZN1gPIu
         LWR4TuC29yD2aUeF+3LXafIPwZKn0jWz3bk7xo6as2tc98jFGSn6Jfx7h2vAox7s3jj5
         XLz4/JPVeWAqsmhyeTO3j5KId+klWxRb07xFNgpR+9PWhgp+eTwDx+HuwD3O20eJk4jc
         zSViwT+49Vw9451T5dgTJCfpbC5UdZRMiNQiGHDlDum37mCvJCGlNbPH5xCKdSsCytdW
         VwqZ5EmOfwxaxyT1CMplICfaQYvu2sS/GeURDWmuyQTMSSL4TeTogf/PbO/EtHzZl/TF
         ph7w==
X-Gm-Message-State: AOJu0YwCwyrxWfrT3lV9FNhvdEoefaBautuyxYkixN2VOCIoVtB/bT1f
	EzI5LOlMfK5gDad66W1+RBHLfTNncVt+u5ph2sfAFrkyc9fFCeuXf/WsURAR8fM=
X-Gm-Gg: ASbGncsGYk3+mx+XaVmey+u/J6kpqNU981lEev1f9uPldeHEC9J2d7MMlnAvhMSC9hn
	OGuO0EqmGgWXkNqq6MQzbW28Z1n0RFQJmzRplWQAJJUymguL5gHv+yVY8dehuDPoTIXvKntrboA
	X0g8vG5REOBBsze5olKZVQ1kgBVCbWNXgVcNc3IHV9d/Z19IQ8Y6NAvNsuF6jWCDe1HJXOcxMtT
	EDEYZklmWK29W4xwgBxGvA3g0Qkvs+i36lii7GJCTmAjowIIr9f8kqnFXf4y93Tq/z91qBHgSfW
	Id/M9j2uxV1OP+jxesLeBMUSDGXRa54=
X-Google-Smtp-Source: AGHT+IFVsggGxzqlN/vZf4SFgQQpoTSQaeE0j9ooOvf/iQpaNXtig8fCxgL3//Gs75L6jr0AEe4gNw==
X-Received: by 2002:a05:6402:40cd:b0:5de:a752:3c7d with SMTP id 4fb4d7f45d1cf-5deade02885mr1522371a12.6.1739391591011;
        Wed, 12 Feb 2025 12:19:51 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9436732a12.45.2025.02.12.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:19:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:19:35 +0100
Subject: [PATCH RESEND 3/3] iommu: omap: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-iommu-v1-3-c3fab486b426@linaro.org>
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=J9wumi7qlxcc6299rTzUmyAx5YxElF0K+3qqjT1gkcw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQJccqLErD/jL7OyJNpS7lTBh7SFfQbhopUl3
 i1FCXVvl7mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60CXAAKCRDBN2bmhouD
 1z9SD/0V45R0Dr0Gsk6W+9AJn0o53W0eP5qesp0hzSdhUFvKk1/Nyz0472zLdSR2L38oywV9SbE
 ySEkrA2bKRxcLYKV4kRFeTDxln6ARH0N9GPBNynnsCAz1aUihKYNRY4GyrzMNRyudxEpIarweV1
 XuvYlnx+13q6HL8VkUuA6/s1pBaMOEmHZ0AOVNyxCvbSinQwekU4WmL0BsfmjekqREs1SvLetfj
 Tv75bftsQwlU9LcNXaGXhcpjyfNzFu527W+8OHTGOx/1uIq7Tl2gn4SKfWSCZlC+zrCiHpegy7X
 6SO4akowKQYWh+B+DrmgUQSjP2fbgqrBU4clUhmVTSLxgPhmMghaMk79nnohljMiDNUSS61y07x
 1eYcbSiLpPpwwH+kQ8Y8wmQ+eo8enpx9Za4YAbMu+YbrTqzB1PFkH9ZG4Hsp96U/t1uhPLWYQz3
 iQD9JAmXnEhIh7NxRQP9r/TmFNLbvFiQRvNksJJT5Vezm5Y/mS8wAjOeotMe0bOvhzFFnTH/YP3
 HCp2zNeEaRsuiFF44N50CSPP5kPwWK4IlkWZ2yVkiqneiqeLeMllNVwHnZD9Uoi82wvLDnciGT3
 5WSdFMeQY9iX5Qb/64GcSBuaCpzdZ7AnM5qVy371ckQt8WBoyvxsYkHsXT+YUgG+oVflmnt8ayN
 c/bwFyGivjIl6aA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bce27805805010ae473aa8dbd9e0cb903dd79bba..f12812d3f828ad382c7a84f6ecd604c8f35a6d10 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1127,19 +1127,13 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
 
-	obj->syscfg =
-		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
+	obj->syscfg = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-mmuconfig",
+							   1, &obj->id);
 	if (IS_ERR(obj->syscfg)) {
 		/* can fail with -EPROBE_DEFER */
 		return PTR_ERR(obj->syscfg);
 	}
 
-	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,
-				       &obj->id)) {
-		dev_err(&pdev->dev, "couldn't get the IOMMU instance id within subsystem\n");
-		return -EINVAL;
-	}
-
 	if (obj->id != 0 && obj->id != 1) {
 		dev_err(&pdev->dev, "invalid IOMMU instance id\n");
 		return -EINVAL;

-- 
2.43.0

