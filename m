Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1E1B85E4
	for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622013; cv=none; b=QlWqoApA2no5lQ4JocPZnc+DQUmwCAhxi1WiyXOpHH+LtDNPS3099xdnqQwoLk7rbCBj/dJjBHCIvUH6P9gAIzIDKLB7tZpI6pq6yLS6+P+Brw3bHkSqsu7QJSmAYuRx78lERxwqKlL/AGxzwXVPtrPrKZ2w3lQTqDi8dZqKgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622013; c=relaxed/simple;
	bh=JU0TwdMjeSFQ90hC61OukfyZcV4B06qD4tAIkB9vGZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBoLXXtHJgsnOsQzFY8ld3yliC2Ifr0gQF1LFd2vM2AuZXkMhhjcJEtq+MgvY3ZsRwE2L6Jffm/sD938aCL9RjNksXsbx2YY58bdALuaAuQut1Wv4pdKorBSuWj8V0msNkqK/UcRdNXCtuCHBuZbg5C2xsufw0kilv4KVTx2LvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEimbzLl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEimbzLl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38625aa01b3so324115f8f.3
        for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 11:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736622010; x=1737226810; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PW/3EHqkTVSUDSi98uyP6NlZnYHXc/ieQQmNS4dMCM=;
        b=sEimbzLld7cXAa/fXgn+L5rnGBoQDGNor4mfftP2aEuoXRhHMI6t92FxLwP66AYgko
         XQaMmRDQEfK7qXx08XG9ggvdyeeAo34JtNgDD4xnoIrJZ5I0GWN/eoBzC824DTDkYvj8
         2ZdP/zjH4FQzZRfStKWDcRdlTVYoJwSQP6Qmfz/VSeyw6pFGVoaxHHBCmTbKfKrSd8mO
         +S+ouGkNDeMKYF9vLMQczqzh7YW4mIzE2B1Fz5P0z8fM1s3WLsHHEaF/nOTLKOmrB4id
         QLtP/mf80zt21sOSoRN4fQ5ofJsYHliqhg0fL2dXOH+PjefT9yPv6tAbNYNrrMZHt/F/
         kRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736622010; x=1737226810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PW/3EHqkTVSUDSi98uyP6NlZnYHXc/ieQQmNS4dMCM=;
        b=WhiT+rlH4bzEi0uo18FznqQT/o6xit8cTmXkL4x9qpHxa5GoSm9R39Gxw8xgqhf4qo
         N6/sbqJoMYMGqWV9NeZdp4H/kmuS024+T4EElr3CqFHSEP8FtR5dQsaaliKEq6wRMpcW
         FaEwQ5FaV6uLIO9ESf14uPmaEzWg7ImzzCyUxeL5Zfks/AQ2sMDEl15cVBw1JOJbmuIY
         n8jJ1hafr7oGjCM3J26i5g+IZ4cOzXtDtoc54NrVuR8rIVgaooDE7niIaa+ri+lQaWbv
         7AZCa8DfMlY/O3vzcsbRjEJdcERSCkAblIPqcqULTgt0odT4R29F8VKuz3bRrAMmVgbR
         JgvA==
X-Gm-Message-State: AOJu0YxSfyBw+aWk0xsjlmNUYumcXzC8Qd9QPCJfhpFTc8IXEJyUjw2y
	O/GZ9WM/rx50crl60gdYHJLynLV58G9aT4NLKEM9I8XRlyXEt48ukR8JP0r71Qw=
X-Gm-Gg: ASbGncsZd/pj9wynYpv0w7qfeNljTKCZILlEwtr7arwtoBxkO4RuAOmAChxmO9+8660
	M1t4IkzYZejkWHIpH88MAM9vJwMNJFlwQ+SXTnP7E1ktJaeaiTJu2xwOpb6FCot3RWI3CjKxXRk
	qYUBf8cFpu+EQGvvK8PggG1jL0f+PakfrMDgV/uzIPWEopcdLA/ETq/afZ2xfOuRByOWFC9LN9Y
	9hKR2OyJawEEbJnqdUSBaSY2m5/vUBTgG3m7OJ6fAoGhSYGvY8f2dX+hRBddPwg0RrnMnh1
X-Google-Smtp-Source: AGHT+IHq0hIg7Nw5hzAVMFQ6qFqPN2h5LoXzXQjltVNuXkaUvtWrPCaTeD1jJRqtPCNIDucQyDlj3w==
X-Received: by 2002:a05:600c:3c97:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-436e2713e51mr60366275e9.6.1736622009942;
        Sat, 11 Jan 2025 11:00:09 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc81sm91309075e9.5.2025.01.11.11.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 11:00:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 11 Jan 2025 20:00:01 +0100
Subject: [PATCH 1/3] iommu: omap: Drop redundant check if
 ti,syscon-mmuconfig exists
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-syscon-phandle-args-iommu-v1-1-3767dee585a6@linaro.org>
References: <20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org>
In-Reply-To: <20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JU0TwdMjeSFQ90hC61OukfyZcV4B06qD4tAIkB9vGZk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBngr+z59T0wdz6nZaOzPJVmnu6RWUBcwaYTVzxd
 NcqQDtiqf6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4K/swAKCRDBN2bmhouD
 10xWD/wKpBcaRhMOt/aF5rrhNyKSQjCZPDlENPZNEBsLmPqFIcefYlzlWHrHtr/7QWp7Gi/DGey
 1mShcGuGWmAIUyed7PwVjKOuUsgVj9SCmB60jbl56FHtZn2fYvgLlj5wwm1mGbE7DPnqsFI8/ud
 qzBNPKxWvWt8rxw7jEzS8Z7uN8kbfrUc25t0Y71SgggKRwqIzrthA0kvnEhBtaiPW8QyZIqM2OC
 jR531qGCrRdzqm7rTK4l9j1DL0CyTJM6HndALKaeEwXy+QsVe+yI+NS+ABOVHtyIUd3GaEZucEz
 D/K/dpzPCbUL9ObvfABlEd/9AMIJteCOcuFOfTQVxhUf8dapHSVoDGGnEcauFUSfHq4tGL9rxR3
 XrcMSgbLa6Kq4HMT0Kr9tbiuha1yrz45kc47dxQMtVfZnTaX8LAVhwEzoGlLDX7c+h3XCD5LTHA
 A4ZC79voez84ZURupI+6jvD34gJIPOWIPg6MKanJDlrktDMbrHTuoa5y5QvSLRPvRHzqBSrNOtH
 5zTGxKSiEgHQVFjaCdRfxQ6zWmCl9FBtHIaNBiSIi7LKSjrfMrEZbjvdi+OCvFzjkf1edNuCei/
 8FDrwPqtChINgtcFPtPBOxTfWBs3oa7Ita5FiQWWMjAzTZV5GNIqERBC8ayXI78f9N98pOGkg8z
 QM11Xn8Y801aKpg==
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

