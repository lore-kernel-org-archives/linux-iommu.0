Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA829825B
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767769; cv=none; b=f75K/ShoDA9Gnxf4Ap5U+khcCV8vQTRjDEm+LxtC99SiiMeet7bCRX5KfgQj6DTI0XY6FzDv/f9cNi6E4+9SxIRDR76J7OMDW2Vdipq/h1Yql4qsdt0c7HvMioP3RzZq0euHj+OwjVSDvpQS+YDpCUnxGOpK4TmFR/loEFCJBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767769; c=relaxed/simple;
	bh=ueipJTTN4GIT99VDYZR+nAvHf+JWom0KrWneDnWo3sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bcv/yyl8wVB+8DPgulVsltjw+tH+2YoCxCxaZglRWKUF+jfBaTTyb7yVCQY288DndlmhniSISJxq78vOzDfiTBhIp3AeW83my5vcgNqQ0xsexfW+46pFWwD9CZQDm69daXpvREmHB5lxeTTNn49nhkkkqq/y2YCKAJ6KYNqqhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GUM580xP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUM580xP"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad89dc2d8b4so77701866b.3
        for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750767765; x=1751372565; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYR0mvGjbB1t9PwMrSYQystitWjrVQqAGcccPxG+GgU=;
        b=GUM580xPTILHhHA8f+SReSzGu1tDKZXDmotRV87f0dPnwGhBhMELG4MshksxX9qnwa
         1d086/zl/QRHZC1QJ/yzJ4KBBb3AK8aFybvrmZNeGFQ7tbUudnsIykSi+KB/gzF7cWVm
         usdzSUvy8gCT2tp5CmpV9gt00S8BUyFWKJP3/0m/gOn8+XA2rkKxUppkdpSU9AMnqdRo
         Lr9ES8LMCtKnA+fTXT/FFVJmmdj4Pq/KI1vqAzFcjEbnH0l8KgK9TSMY2qGFbdJWaOBb
         mDuYs5drqs41XXgcCodlLVoyDcVYF4Iu8YPH3m6lgMMK3X+zvkDTNKOlgSFwSfWvNGP5
         BLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750767765; x=1751372565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYR0mvGjbB1t9PwMrSYQystitWjrVQqAGcccPxG+GgU=;
        b=xL4OVFVnPmTu+obxDoqAJOmv9zkqxf0TaYz/uK8A7JeOAZ3Yck0CrsAfVCXJ0rpJMg
         Wunn7Ak/llb79KbH9YllgxjvvXSJgd4AvLfAUlHqdwgiXzz1y/m4XJEB4WzgzGjcukEG
         T49DOQJoGKePo9j5kVSHnWuY1RC/C7oVILu0BpZwfmo2ZpX96Jdd4jvDv2aO0nn3zAJN
         HJBIdgBEi6D0r6IIkmKL4IA8cXY6JOlNTS9hdN1nHs1Qv7Bq08Epm1EB6RYdlLzORaiU
         tqf2x1GYabYUVmW0hw/it7gI2tZDZjlbZy/tKHtkVyWHGIekQpzauzlCu6lqedtwDYqa
         Z6hw==
X-Gm-Message-State: AOJu0YyN+bSYaT91UQposKrpQ/02gbA6bMrR4lHutsvOl/kGOUTPP6kX
	3c3i6XcUyIHdfLQk3PpbEt2866NdypszomjRFObbytDos82dpHqBdeRKGoCDvm3crWw=
X-Gm-Gg: ASbGncufkaOmRw4qhO+uerDT5cBjsN2Q1DC5VOK/twHPE96xZJ7h4aGwNM6+V9WMjuH
	ktOFG4AQlpb85XjKWDKCeZ8jHJfxFIs+IWx84GidcQsXPjq66i8k8bQeGp3Ve0LH4wpCb5pJ2F1
	v8TZKtgTSgL6WhiJqFufiizQfg91AlgQg+YRfVlV0xx3kiPOpNlPPSuRuJSC3O6wxyAMb9q2bwy
	5lpvMESqr4mc3Sdz/lr+9912xTrn1769A8y+mqBf2J+dLBuU3vEx0dzoXFw5gAjNqOh6ic4RtnO
	etbOtsvlkt14NyUjJBi11jXJSHZtArvOj2mInK4RGslNQuHhXHUB+uV5aCfufDmWX2oVQQ8yfC4
	UWCtyiQ==
X-Google-Smtp-Source: AGHT+IEsZ//+E0/Q5JRbtMOjfmMwrd6ZqBEhvEMcASAfMvO4Z78K40GvJpneVMJGYeJGXSRojLvxIw==
X-Received: by 2002:a17:906:9fc8:b0:ad8:8200:ecfc with SMTP id a640c23a62f3a-ae0578e005amr526516566b.5.1750767765372;
        Tue, 24 Jun 2025 05:22:45 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b3448efbsm56794966b.177.2025.06.24.05.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 05:22:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 24 Jun 2025 14:22:32 +0200
Subject: [PATCH v3 3/3] iommu: mtk_iommu_v1: Simplify by dropping local
 'mtk_mapping' variable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-syscon-phandle-args-iommu-v3-3-1a36487d69b8@linaro.org>
References: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>
In-Reply-To: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ueipJTTN4GIT99VDYZR+nAvHf+JWom0KrWneDnWo3sI=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGhamI7Iw+ClTaksgGzVRNZBqEwhCMHErWdDPgl3KBLt2cw5H
 IkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJoWpiOAAoJEME3ZuaGi4PXrSMQAJis
 3J5R/L2EfwRPOX20YInJ3r9Rj4cm59Hk4gwBb6sJBPC42WJRFUfriJKoBwOrXG4/wGCneYOvHGn
 F5h1zJLrIknW/Rr3eQU2JmiXfvfG05b4wEn2q59T4z98TmmqESvXISsSy8InCeK/ui4qCEormFm
 WCluiPBO7+kmKT471cc0V8LUPwBidaXYQy0bvjwLALYhsZSyss5hTi0lqvTpmEOIPjJQPZ8S44U
 y8hpaLmPwJZaSNbSxVJ7jgDmEG0OCU2Lp5Hfk8m76ijVsRAjp7vbifVJJcmzAwVnLwz/Mhp9zqR
 701ZiWueSdJOpFBr9dnum4uzJtbfmdAOcAaZrtr9fZ6/8ODcEjp7a1R4JPWaqzdwTcMrjXDcDSp
 5ucG899MrwqT2WEahy5IreqJFG9SGntaDTDewpOcO1+l+iqe/4TFw1rrvC+vK9qOdHK9DnBc3T2
 6cDBQMuhRGre8ruUf6h1li4CfqdYwi1szocZJHVAsr2PQZvMjWtWLBToNtCdJbPXEhD5loEEwpO
 Fck8zxNaq4AlXafOpg2uWSWvYs13l4VTCztSq9QCYclHzDZhCXukRHSJtPuCdNnQjAO4JtF4LQP
 BdA7mfHdmewfVjvi6I+fwWRhECj2Z5cyuRBK9DFSYqceUX0/iMGPS6nRoDGeG9QYu1NFWb5FYv+
 /WU5W
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

Old warning is changed now to:

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
2.48.1

