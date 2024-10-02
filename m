Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFBC13C90F
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857914; cv=none; b=NgBc+nRYHjivhwpna4t38gHatmIB0PQAe9Cle2G/TFPrqmGAVNNMAxL5XMLymMKXMxvZkhfvHH5vOVmdHinnREL8y1bPcrC1sHc/RBjayqR9AuzW5GC8yuSlSAShb5ViRCC1632YmsdaqZx2jdEznDKqr6XNbHhxZ7xz160CwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857914; c=relaxed/simple;
	bh=dz3TnnmaHxX4rTHrBk2jsLW01eIFWKsYTonE725bpLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8DI1b/rODOldKS6R6e+ctCPHKMHpxpbgu8f/KP+opshMd4daatUHjr2+aBj6WOhnY7eT8UvjeEcgMNef4m/2ZJr+v8BHAPPxY7Ov1lQsPQbRl8yjLgE+pKlCB4fIHbFYmL4jiqgPWFkfwLb2DRyQhQ3LCarPf1JiuHr4L2C9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icY5j/Qj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icY5j/Qj"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53995380bb3so3585057e87.1
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727857911; x=1728462711; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3i6810UFJIFlcsBbgqFL1M8gMfdIH9tr27N9SErNn3U=;
        b=icY5j/Qj4H0rLyo/BG6c2F6oTCFSXRDCtHf3XKD0sRzCagsGU+BFyTMy5SYhErEuF/
         OJoA40pV9fq77q+ACtQJeOBwcdm9JFrAPjf/oTeqPOSiTa3DGMKJGp44TFRSg45VS6ah
         QH4pfVl13wP/+g6dAvAhWuIgTm08CS8b1tUf1y1bHkMGEU3/iQCJEf6pO8f+go+yr/Jd
         faM/g83F712tnIPzzxJ6+YCHWgzxsTs32/t6p6SsRW38cKYjkH10+X9uxyP06FMe8JQN
         V2e+NPLJ+5I8v/haKwUok9rdhDsMYpsd7zwYt79fdlY4pTgBWpIRp2SzuRKWsiA5y5Xg
         8GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727857911; x=1728462711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3i6810UFJIFlcsBbgqFL1M8gMfdIH9tr27N9SErNn3U=;
        b=Va4lXYYuVONgwwVaRz5I2uxiOd9QSEMCeA/cOh6lIXsWPbVl8+xansh5TZNvi1vAmP
         W8hKNL5f5XV8He8jWK/vOPwlY7xiT/aACUrjeH46YSaJTz2m5wu6suugwR06DuBBWmsU
         20OH+sN85Xk9FZOhgmlYxADl38fXlB3sUmKC8k6Bjeqq1g8+aH10PlRhj5Bu4mR8rO3T
         09d830efprGS2lsXtMCCeTXrcCwFskzS4kv+k2oxnPQlW9jDIokVoQy6P40GIjsg6Are
         4CNtX9VU4ZZlpRt1pOrXU/wdl7oaXtqlp4ahjAjqUBzq4K7tsx0WEP06LTuZXMF8rt9o
         F7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPgfaw7CnectVd4kXQY/y9f1RvqJbrEpBqiFySQGU1IVATk6LFfduU4NtJ4SUun9Q3592fDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZWsW2wG8EEQrzHM1iU8CtlbFzg2GaFBw76RG14+LGKwLmvbUa
	GgO14+IPRT0i+EC2YAJWjZtQijyo7XB5ucHknKDRa4HUcwuuVd29
X-Google-Smtp-Source: AGHT+IGo1JGO44BEKQ2Q+d1hBGSQ3FoIslb7AYw7iBhDsII9i7GgOdct7cze006dHJSfBSyzDTRPpw==
X-Received: by 2002:a05:6512:31ce:b0:539:8f3c:457c with SMTP id 2adb3069b0e04-539a07a9ed3mr1280515e87.53.1727857910987;
        Wed, 02 Oct 2024 01:31:50 -0700 (PDT)
Received: from localhost.localdomain ([37.161.243.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245ea1dsm7257716a12.53.2024.10.02.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:31:50 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] iommu/dma: Potential uninitialized variable in iommu_dma_unmap_sg
Date: Wed,  2 Oct 2024 10:31:28 +0200
Message-ID: <20241002083131.18135-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fix the possibility to have the variable 'start'
not initialized.

Smatch tool raises the error:
drivers/iommu/dma-iommu.c:1510
iommu_dma_unmap_sg() error: uninitialized symbol 'start'.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..5b2596f4b24f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1496,7 +1496,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t end = 0, start;
+	dma_addr_t end = 0, start = 0;
 	struct scatterlist *tmp;
 	int i;
 
-- 
2.43.0

