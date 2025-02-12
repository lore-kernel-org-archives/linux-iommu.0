Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABB200B99
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391589; cv=none; b=GY8JewkVHrBX6NMK9VhOZtXKm5T0nxD9ZJUwxeOafl9z0byGEl44pY9qtB6qppSJpXn4BwFw49HVEnJQaRq/JSjsDBOwWoqyzUISeXvzDHQjCFx+sih0gAk/L/LVUQe/2TMkmauqhW50rxt72jrfhrBquY3CDbcCO3pZoYPz9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391589; c=relaxed/simple;
	bh=JU0TwdMjeSFQ90hC61OukfyZcV4B06qD4tAIkB9vGZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCJ6lKN1OJrUgOa0U77YiYgO5CRli1JGFgVTtgqElGcoaMvO1bGMlKZnYpLAZScZcx28SfKiVpzYAhQWD5iCG99gb1g9L+4OZFeJja93LEcSqtLGc9k6DplgxjKd1ftrXMu6flt2D0DXnb4xV55owP8Ymvpi6EgE5XGd1kqMAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbCADfSq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbCADfSq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dbf7d45853so10800a12.1
        for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 12:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391585; x=1739996385; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PW/3EHqkTVSUDSi98uyP6NlZnYHXc/ieQQmNS4dMCM=;
        b=pbCADfSqjHLBCZsY0J9hcQhc2m/pwdQ8lArVpXurFuQwmPTNa4TI3Vbyc49luJTsj9
         1bcr9hMVzLR1xBE0zl6MrydZKc9elSwB16V7TvYBgp0R/rDMMMGgkB3qSky1Kre0uAbF
         DNjw23dICkSYlddi/JxAgoAtb+H6NPKd1pQLPp85fB8oWNLRxepDeJ82HCnfhJn5aMbQ
         EiUJTDQWvSp6czjkQDzOctqGCQwjLa8iD1SwULHfvd9POsau+cMVykOZG0UsLBIET3Qo
         auk4GGILVLjuDulXAOcqsc1T6bNqRfyGTl9QrxUOLyk9/NVOqvL8qxf+98AzsscCxZBX
         hWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391585; x=1739996385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PW/3EHqkTVSUDSi98uyP6NlZnYHXc/ieQQmNS4dMCM=;
        b=lQgjrLxCpLda8497cL/kjBO5jZzQPcq5OP4hgOd/YsFzWtdafTk9qHbK78jUio9Zy6
         xTBIjuDb64ios9UW0ozAyqJbStiWUJ6CwpGS8s+2vA63OLjwRYl0MaQRxDjazM5zYuQb
         jn8yeuu3x+duoQeptseHaoe3WWll4B3qgXQTcR+RdIiLAvqwn8Mk1Sw/pIjfFvD0t2kr
         Taaz7vf5WWC6WRHqoopGa6L/fUfMQwicRHM+CvBb6jjEqTZjlUTPoVmnPQXfI4M4VfnZ
         zqTF7rpfiq3vZZOPHNxoZ/jtle5lC/fb9sHlShBw5CF6kkp16thNLasHGeLApqjvnQn2
         vYfA==
X-Gm-Message-State: AOJu0YxEMDe9KzQVWM6qzILFxsO0Ot5VAGs5ZruU1Z7ZE5z3nzkISFSd
	HOeUUnDkX0X61OCpkaWVr1jDLnsHW+Hyfu7SAFj7O4HKdIj5zF8ooRjy8lbwVjgAg2V8Z8vTKth
	w
X-Gm-Gg: ASbGncuJr1X6bipLkOMa1yEPgLPe2XHk4VyMYkBWHqzN36ceFOlsVUIT0EHCOL/S4jX
	CyHNBYc++5yD3YnrRMeA42KEuhwnCjNeEmOHr5rlJ21b0qRBrfZ25hSHld2n6vgmrD2uPRQ6sF2
	K2cgpFK0HUnGf83wrsj6zOH8YVMdfWlBZ118rpHiEUVJ+sJvs+SBt6PBlfToYTPJAVqwb4TZMYX
	doHyfAKvVG4USHM5EL3SlRWHLByjsdGFCmQlm33rC1/+5C4RXI4AihsV+MYebWUlyaUgsXA91ys
	RGZZGTr5kmkbgUdWYtcVZQG++vM4r2g=
X-Google-Smtp-Source: AGHT+IG927cWF3dO5cKv23Ry21as4RwotNysUlOS2yNn+N8Iz4LmKa1CWaZoNBvqmkEZIQ4eSYBhDw==
X-Received: by 2002:a05:6402:40c4:b0:5dc:c277:f787 with SMTP id 4fb4d7f45d1cf-5deadda8af9mr1394914a12.4.1739391585552;
        Wed, 12 Feb 2025 12:19:45 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9436732a12.45.2025.02.12.12.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:19:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:19:33 +0100
Subject: [PATCH RESEND 1/3] iommu: omap: Drop redundant check if
 ti,syscon-mmuconfig exists
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-iommu-v1-1-c3fab486b426@linaro.org>
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JU0TwdMjeSFQ90hC61OukfyZcV4B06qD4tAIkB9vGZk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQJa5ulXnSjG/p4Urz2phkzFIaaIncKVbofVZ
 2XB3AU9FVGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60CWgAKCRDBN2bmhouD
 187YD/0dYgxFiXk76wBs6vQXu/bOtKtDtMMzI6WlFLh5EGoLkfxVZ+eueTfdJK99vK29yR58p1f
 v7gdgQHFxDUOvdfmp2uu5N/i6b0dAGTKdgpzursxjzvjR9GryeaUnV9Zeujp+FUtMwe+4QfebsT
 aiHMW1/HNJhPFIEccaDgf1UD9hf80cdc43EnajVXGilyQuLkLqBFJon1D0BbycYjha1p359QjDm
 EJDb0+XQrY1P8I+W0eshmNgjUYY/05Uk/lNNcCB2zX0gH3PoTto755PEklkMQ9rtNp4aL2ygTM+
 B8xPkOYSseAYiCcSlMCBDOtceEDVHsKGDx1XTpRK4TTtCCU4yYiSVNn8uaC9ClEem+nQ7bYrAJR
 2efiu1Fk4bZFEORRd30TrUgZHYOERgT4xlYM3Rx0DvP//EMe+Moi6vxxgblhNB5r7f5T7meUQlA
 LBO/sJblGOGkGXsByFzK2MI88MjP7fBswS/vC6gJc7ndUMRbXln8qwcKQCrYFZrR2/j8iDNAl2+
 eu53OjfsXrx1oexE4/p5psrJ+R6ydTEfhd4kMTAQx/1o9SSrSVrrOKv9/3Ykf7H5+wpvPM2Qr+z
 sIm1hhw/1StnZxXSqdaT22e/oopb71QJ1J9D/rqzkUA2Q25DXxaQ8928PB8gznnZ9txHnj1787o
 kPkLIEskBRo5s9A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The syscon_regmap_lookup_by_phandle() will fail if property does not
exist, so doing of_property_read_bool() earlier is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3c62337f43c67720a15b67e8b610da7886f6f39c..04a7deaaba25cb270eb6eeaf6a21030440f78a5e 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1128,11 +1128,6 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
 
-	if (!of_property_read_bool(np, "ti,syscon-mmuconfig")) {
-		dev_err(&pdev->dev, "ti,syscon-mmuconfig property is missing\n");
-		return -EINVAL;
-	}
-
 	obj->syscfg =
 		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
 	if (IS_ERR(obj->syscfg)) {

-- 
2.43.0

