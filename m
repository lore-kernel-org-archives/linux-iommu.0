Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AC2144A8
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117444; cv=none; b=UzCJtIgSOWdRmC+xlk/WONwCC2bL7wDzkkWiP/a11JssH13fCvgR3xPqVgDLLjzOc9M4otUsTINX2mv//2QsmBFpdwpIJPshdooZAdNr5UuMEDi6CxElNxl15tDBa5vSBvpvzV4c19DyU6jf3VHfqBJE1J06NX7V/VQcwdYBd98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117444; c=relaxed/simple;
	bh=br7GZJo/Y+jEEdWoRzjynfLSYE2qWMF71yGrpCFWlfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKG0A6xZeQvDKQp0Lb7GU9CHxOadCNwvcuZpTiRamNngMBZ26CI2dQbPGc+7lB85/tNJtSNS0Wa9cwB6jdVXSbHzOXiyExi03c8fEdviYUP5jptnfZR7Ss7HALBOPwz/qoXKqe3faKQw2f5Td9Xcp1j3uQh7o/EFdlfER2qgEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQ73wkU/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQ73wkU/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ce4e47a85so1641475e9.0
        for <iommu@lists.linux.dev>; Thu, 01 May 2025 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746117441; x=1746722241; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+72BTk3p7hLtQaCti3cuxoq+C9cJepOLj5FSJpxepws=;
        b=yQ73wkU/7ChikUv8O4kdWPW6IEGPdaBj5dRXV6elPL33LrTEYqyb/41o6WJcdIhwjs
         LWO3WFb02gWqGDI1+Ip/adps4QZ5a+PBdulXE0tgbfdC6GAuwSn+qDc1X37CKOeavJkt
         3D2OOwXmge4x9zfKjmHU78R33ZPXJQr6jYkmefrEDMlvcmNZstxSNrMlrub+BVf6FtpX
         X4NqrOmuVEluHVfkM2leg97PGVGaTuGg9SEGFDVPvHw4n/7i6NspCl3sXdCe65W3oqDL
         jnq4MnCwiN7NLlp2zlECNHWjzR4rp4YWE5ZM6/8eycazx3zEfDj6h0ztTBUOr3BnjLq/
         ll4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117441; x=1746722241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+72BTk3p7hLtQaCti3cuxoq+C9cJepOLj5FSJpxepws=;
        b=unfwsxmxP/AluC2k5a3vbeTiXP+X+x7utLgrDRVMnHI8HrbQSpioI6IrThOozcR/Qk
         QT01z8zHneaVB09kgV9f4otfRx9PljTGz/+DmsN5Kdpbuu5n/CeR9oob5Ne+EDHfYK7J
         39SixY/BBmguPYnv7dd4Z/b3wU180MgCmQqSwr5ZaI1x9uRMA/9dwIZzgbdNVWBfxUit
         hK25S92D3oN7huVbL2P6Pzj420J8gEIY0iHJJE1cvZKmitaGiPYHx36KrY35XtEya+Be
         qlAzNhzHZkbLrxSKutEj7pU2jq/8mJtNAFKrnMuzuKkIETwdGoxBUlcjSzKFC5Rf7pgu
         9wrw==
X-Gm-Message-State: AOJu0Yx90m8gh9zd8xTAX4KZ68HNXKWEqWfXHs2GP2tPhWY0fG4sMXL1
	Ri5dmu4ODGcK8h3KnrYCWZnPAvtzkgh5vgMUnXxc2dvZjtFrmZIa0OZ+/mIzjjM=
X-Gm-Gg: ASbGncuh+7Inpro9XjmG1E6WnlgG+bTOXpYemXBwuqSyE63keDfLUzMt6B0TkI7Jn+o
	99RLi4MJFga7Y9Okvy9UBjI1h3oGqLcwMXl5Qx+39VyD3yQ7NS5wIY6PcH1Fa+XFlVdR9sAhmIa
	V4+4FBea+Wqk///0r2wEwmhas2UEI+TneqUgLlmKboMHCswC/1CvkljU+e1iZsGBzUEN0sHxW03
	1mJqFgxoGOJMJ8eEGhKaub4dtcrnsp/NUhcxIZupkWEj5klMKELQjFwiyq4ncvIiumxukhGdOAg
	cxIdQS/JbTrvomZr4qXrisqfSvkaplBKebg3aBwrv8K/zGTqPlmsxL/e4eb5Vx4ZrICaSQ==
X-Google-Smtp-Source: AGHT+IFZ4wq/YC5Z8Q1DORspcfBal0TXZZSb4qQ5i2LX5qoWo7ODXYSBY0H6naDeevzu7XX1zCwGJA==
X-Received: by 2002:a05:600c:8712:b0:43b:c962:ad29 with SMTP id 5b1f17b1804b1-441b2c6fe2cmr22011025e9.1.1746117441032;
        Thu, 01 May 2025 09:37:21 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a288f0sm17166175e9.27.2025.05.01.09.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:37:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 01 May 2025 18:36:57 +0200
Subject: [PATCH RESEND v2 3/3] iommu: mtk_iommu_v1: Simplify by dropping
 local 'mtk_mapping' variable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-syscon-phandle-args-iommu-v2-3-5a3cab296972@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=br7GZJo/Y+jEEdWoRzjynfLSYE2qWMF71yGrpCFWlfM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE6M4CJameWdIEbaKrhQD0ut81+1BXWRWUnwFO
 97Wgb7lxumJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOjOAAKCRDBN2bmhouD
 14SOD/45uy0MY8VGk4ZvKE/H0R7CNE2ft3oLP9XOQRzm6XJHx2Z9QXmTT/RSuKn7rZ+bMTOw+Ir
 GPQ0iGcxYbbvzawOd5YGQVIPk0Zb1+shoVoyBFJqmuoRll36W3jRmfIN3GL0YaUjZhpnA1jcZAy
 TTuqnfYHXInALgDOecbSNWc79Uy8+ClQ3E4L+KOy4pdGjft7nSX7JXTtTXy37QxGkhpekH0JM5e
 Ny0iwkeJTtgXi7Exa1K2spOHRlROyoBC4SbhIwSnR1ht7QkzuV/dDELMLU+rjhbANXDRvhLD3Vu
 jzqfOzDuiChfqmVO8WAS80b7a7MORPmXVhl/foe3JeyXchF2/AdA0IG31LiCwkryPkD2k75l3rn
 CEazjbiTy4jsN8ZLcGWs8/1s6FpePznAdTmg4Xwg85K+Un2AibmOI8+XJXVQYQflmXwe2cvAcxq
 dYBhTZwXoJ+HdUEjmJpq+DC1veARGn0blUPddRTXMqveUNQP6ieZY53tCYDKJH3dsXH3cU+rmSn
 2touTUB0YumibIzZdFmfF4BKTwSMHWDE0A4ZrLuaeQ2PdEdjI39x0BCE2NLbYI+Ra1JtWEZ7mgq
 vVTfWQER71C4Hc8d4JZLENH1I4xL8uQFlnxuZ0maHo0+4z4H03ObcnJNhOE7y1NWCKkOEVpBT7F
 DmneETwpwZMjFiw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Storing 'data->mapping' in local variable in
mtk_iommu_v1_probe_finalize() does not make the code easier to read.
Use the 'data->mapping' directly.

ARM64 W=1 builds also complain with:

  mtk_iommu_v1.c:512:28: error: variable 'mtk_mapping' set but not used [-Werror,-Wunused-but-set-variable]

but this is not being fixed here and 'data' still won't be used in such
compile test.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Old warning is change now to:

  error: variable 'data' set but not used [-Werror,-Wunused-but-set-variable]
---
 drivers/iommu/mtk_iommu_v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 66824982e05fbfdda224276ad41b90f9d5f9ca4e..bbe3e9d901c69ac6405d9549a4481fc80f1adb80 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -509,14 +509,12 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
 
 static void mtk_iommu_v1_probe_finalize(struct device *dev)
 {
-	struct dma_iommu_mapping *mtk_mapping;
 	struct mtk_iommu_v1_data *data;
 	int err;
 
 	data        = dev_iommu_priv_get(dev);
-	mtk_mapping = data->mapping;
 
-	err = arm_iommu_attach_device(dev, mtk_mapping);
+	err = arm_iommu_attach_device(dev, data->mapping);
 	if (err)
 		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
 }

-- 
2.45.2

