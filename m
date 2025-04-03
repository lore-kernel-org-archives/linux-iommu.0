Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398761547C3
	for <iommu@lists.linux.dev>; Thu,  3 Apr 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699371; cv=none; b=tsHAqiYAW3AQ99uqL8FXgScQ8X9n4wkEIXpfz6Oe4rAG/IRpZSABg/G9K8i+9SUm37QoX2LCSzNssgp08DqH9SdkjjCNln2Y26Mx64fiwv7PCQrrTLivY/LUdvVJ5uWjIBPjj3yK76fzde4B3lANaiJ2ywmCwEyUTBEIV2lnCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699371; c=relaxed/simple;
	bh=fMPFmuCz+4umhrbdsLhmwvjvyCDs7GQHqN+lP7Mqa60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NC3YcT5oQa5BXOowyt4SGCO6eSlrp2U1etQreDFnJo3fSQlJgXmC8GgF2yj1DzVDEuv1f5B+4C3ZNBRMvu5j8C5cGXNP8hiXN2dL3jOsmN+nf1oa6z4jCVEXsBRo4PXdYRvdrHMt6KDZRDLo70JmypUlYiyEUfcDK4YlaT2SvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HYkjFZAP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HYkjFZAP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf7c2c351so535075e9.0
        for <iommu@lists.linux.dev>; Thu, 03 Apr 2025 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743699367; x=1744304167; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nws//u3rgDvjuf/6JSBp7e6LmW215pjitpAR2uf3QY4=;
        b=HYkjFZAP4sq74VPu2/SWGGUxGJancp65EQWGIKc8azfDcsrz4joQ9P/5Yigy4UVH53
         30vmcC704+EHkKiK2+D8oe7LK8NhfPWyds/++g7Y6UlpVncNzgbvCrXkiP0dVQVPGYi1
         1aoaQ2i7rkMWPggwnF9TP36PH9zjUM4xZLQtBlFxWXRdubhkEysk/cqzfr9aW4BViwBI
         ukKyemyIKR74PsKL8h47TEcd7URygIRUrjaxafoLvZE4EeBlsKQwTEOQw6Go4dsMasnV
         M5CYYdIHK34MN6+TdyhKqq1eavhmzRkBTNoyjNIuo1HAL3HFfPv/7ilHlYHvRrDXBB7K
         c8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699367; x=1744304167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nws//u3rgDvjuf/6JSBp7e6LmW215pjitpAR2uf3QY4=;
        b=wuj2iHxgw3iNXXVmZ+1LmHxyKsu5Z56vLMl6nQaCrAgxAXD7+oYu/GyYd6gnnPMS5t
         89SvTYxmCgh9vnYsMB02jdndKyBpB5vF+eJyFZH+045XLj2xkPG4xJ7YfMEe04Os0XZe
         ldck9H/mOKwC/JVFL1Yl1K2Fxdm6OyzNHCUYO69u1rLXLg0lCl5Ry8f61OafAiI6iTmL
         8JjvzoquBOvAmPMgmBnEYLPBEmi3TT/yQR3y1Wb82xkA/WBGHgNt9DlcbRq3SjytnHn6
         f5QSMhLka/24GPJeg8YpA1XJAPqRukewCMuylKFD+/5f2zIJ34+cNXrFoxI67z987bco
         SRzA==
X-Forwarded-Encrypted: i=1; AJvYcCU1p4sO8vvrv0UlnztppBl+bBy8tUs2xOo6R/9ul6l89kUZ16zv4IrYBjIT62OxoDjj80awsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhPlL4epTpoO146XlwKKoEAg8wmFNuuFCRoasVQ9hEwVZrqbOX
	j69/BwH+my1gCG2Ny+jHE0izHFGVk8t0eSe0uq9xM0sEA4gyeLz5LZUGoReb+f4=
X-Gm-Gg: ASbGncvjKfL/TQVV62t/HltBFVdm8dGU0PyExYKN1+hrAgO+of/Y4dzXevyo2g30b2J
	TyN9vcoEgmUUakdRaOwvCX/yDA+aFNTnOrbc57esIdAj8DVWZJ/CeYAJbdx3fumaKH8qCJ6S/+P
	XybSJtJdbeD70v1P11khVQ7phDSp3FPrPMLH9hlfHkTqwyNeP+mZXgRonA2xpndE4TXgHUg40La
	crbde3g4CzNqtIl41xyMaEHf7XFuvBF9G7XyIR2YunJCbqFGUBx8Ss34EBr3uboMSBJO7EORt/n
	AkOkV0YywwhQ922UgvLiif8UC1adCcji3F3N54gEGS/Mv8fMq3jwx/40iAXWlfKqMO+IHMfOws9
	hSmu2hPmHqw5Qu6wMD1/5KbIFCA0oe++Pwo4=
X-Google-Smtp-Source: AGHT+IFnHs2M9uTl/sVMr31Bcm8NftEhjmsWDRJgPxm3Q2k+jhRwztzbZUcO8weBM1x8XxOnlIgZfg==
X-Received: by 2002:a05:600c:4449:b0:43b:c0fa:f9bf with SMTP id 5b1f17b1804b1-43e94a41ae1mr64277355e9.3.1743699367345;
        Thu, 03 Apr 2025 09:56:07 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ec34be2e6sm23198265e9.18.2025.04.03.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:56:07 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Tom Murphy <murphyt7@tcd.ie>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] iommu/vt-d: Remove an unnecessary call set_dma_ops()
Date: Thu,  3 Apr 2025 18:56:05 +0200
Message-ID: <20250403165605.278541-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not touch per-device DMA ops when the driver has been converted to use
the dma-iommu API.

Fixes: c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 drivers/iommu/intel/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bf1f0c814348..b7e500451d4f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3789,7 +3789,6 @@ static void intel_iommu_release_device(struct device *dev)
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
 	kfree(info);
-	set_dma_ops(dev, NULL);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.48.1

