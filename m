Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4F27CCE0
	for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766789663; cv=none; b=BSOqxU9M+koXuGzhRFn+6CC6kWVf9jGiKMAMezkU/8tkEvHPJQRoJwc48NfxpgCEdsmA3tP1Oeg2uUKuFfxaKEVH/E90CwqdcOLKMLC781eUP9IfU5pGumJBhaZft9Av5L24KadjEhK8OCVxiktVvj8YvSHr7n2fTD2Gt9CWpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766789663; c=relaxed/simple;
	bh=ShBsoH34IqplDCbKkd/jSxuIHIIWI8ySxMBj3nK3wpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axpfZdyzzPhu/IRfmiKL96wBFLW7dL2uj7oc9qV8ZIHAYvwm5f94OLWRPdjhRSy7Q+wjMkp7F8eS3sz68fC20lRdLIMN7KpXzBj1DQLnrQWi1ta1NAGW3WhILIAswqVFvH51YOweMRj92kV9IT7tQNkKh1b85ueakS16CEVl4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3iuASPn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3iuASPn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso4971685a91.3
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 14:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766789659; x=1767394459; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beONI3EcXYpecg+Q1bsEm+B77vz1JdIzHQgAsq5N5yU=;
        b=R3iuASPnDp1Be3QoA7M8seo3rpxvB7nqoNAE4ElcL4e4hQSiCYUfmsxpga8/IQadm/
         +8QLpKwL5PSv3z/6QO8U0hsdxJtDeM1DdNvIyyqiLIIu570rR0vgRyM0higCMZu/pnCg
         CpRp4j1gYFwaPMvjV69WXyd5L+unHf9cCyeAmqNBtqL3FTFi1WFs5RR8Zy6MV411ek35
         rjmzj0Mf7uyVgQCWo50VTkWDqslbmEpBzVoqZ8AlBZjPGlXKXuk2pCHOdaV0RLVWZTa+
         wxK3Ka8pZh8Pr/3vY/fSUN3hlHziDt+CcD+2O37lKi2IH9Vvqw2Yp70dQxmFew4yStyl
         yGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766789659; x=1767394459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beONI3EcXYpecg+Q1bsEm+B77vz1JdIzHQgAsq5N5yU=;
        b=qFuzomXOLGR3oTMXoGLhOfAyZJ16YssirHQlwVeEos9vzc7lEWsSuSTbtUls9mCOq+
         RIuRxQ5FVTNGnCYai6sXVYAWlH3ZuAp3eWkG3aXwhuglTkyWkAe/VJ9YqPRQwFdYiByz
         +JzqMFDMR4lga16EH7yklGf2GnCWoY5y4sH1Rc1KNI+aq58icYEV7Ex6LvtX6Bqzf2S4
         UNrW/Pz/f7dd61EqEWqGDowG5vzaFvlMllljPzUr8iU3gVaZ1IAfOiHFOPimfwjkxXfe
         MSfaW2g1EzIOqxu5VLix1nDLwtXd8zL8AVFlmQXB8baqEsbBoYNG5loT7gHU4VEDmsuV
         F0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeSsLOFoWco+madWJkXQ7ccgdtCsXv7Pqq14fxavN8/CHeYjevc4c97VWJkyYmXbYHX7HdzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5GWhnPhtkrelIRrbF+Nsb3ZR75YpPpfNpf3GMPrLt3j9CuAN8
	t/Ov5tB5oCg6ov+mdSQgy3SFzJo6nSmjuYMJhWVzBKHm+z+QBFiRWrlC
X-Gm-Gg: AY/fxX65N8JI8XSqETqyGQuwiiorueonkceE8P0Ms2UIjC7poz14/2sJUu6/Uxu0f6C
	YTQ1sRToDDC/VlHb1ggLSPSED2FPQ0MrZbeYX1Jg9p3h+uIrDmBnLxRXZi9E8vsRwsOtKTrka6V
	S97zhcP7V0C2Sd2L8RkZ9B6EXQcOGVL2/mhCkUPZC1TELEzu5xYaFfvfky6OwBmOr1V8kbswdSD
	0lvLiADtY7TJ1kE/917DQ9m9bIPmw+4xkVlKZGVo689zQKbutp8ZAxlwGy08gyTxRB2DO9eW3FB
	Cj7ZLROak5mK4Kf6lHuw2HWC9ygevXE91N5mnQZEgOEJ0NnfYtnpes4UmaJfHwwVVbU5FIeDjVP
	oJ/DggbJa/wVxberj1l/LvER2tOjjHGzYT89srEziwWW5/ttRzHefqM3ZQPqJHZ1meVdHMp3CCI
	eKJnQj0ueaWNYD
X-Google-Smtp-Source: AGHT+IF3FBOgnhAE+C4yK80l6tVlXmB4Rfi7fJf1frV3RXQh1+Ry7oysljXY9g9IJMnKqHJpP4IhrA==
X-Received: by 2002:a17:90b:2787:b0:33b:cbb2:31ed with SMTP id 98e67ed59e1d1-34e91f6398cmr20025228a91.0.1766789659345;
        Fri, 26 Dec 2025 14:54:19 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:54:18 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: [PATCH RFC v2 8/8] dma-iommu: Support DMA sync batch mode for iommu_dma_sync_sg_for_{cpu, device}
Date: Sat, 27 Dec 2025 11:52:48 +1300
Message-ID: <20251226225254.46197-9-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251226225254.46197-1-21cnbao@gmail.com>
References: <20251226225254.46197-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

Apply batched DMA synchronization to iommu_dma_sync_sg_for_cpu() and
iommu_dma_sync_sg_for_device(). For all buffers in an SG list, only
a single flush operation is needed.

I do not have the hardware to test this, so the patch is marked as
RFC. I would greatly appreciate any testing feedback.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Signed-off-by: Barry Song <baohua@kernel.org>
---
 drivers/iommu/dma-iommu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ffa940bdbbaf..b68dbfcb7846 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1131,10 +1131,9 @@ void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
 	} else if (!dev_is_dma_coherent(dev)) {
-		for_each_sg(sgl, sg, nelems, i) {
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
-			arch_sync_dma_flush();
-		}
+		arch_sync_dma_flush();
 	}
 }
 
@@ -1144,16 +1143,16 @@ void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	if (sg_dma_is_swiotlb(sgl))
+	if (sg_dma_is_swiotlb(sgl)) {
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
 							 sg->length, dir);
-	else if (!dev_is_dma_coherent(dev))
-		for_each_sg(sgl, sg, nelems, i) {
+	} else if (!dev_is_dma_coherent(dev)) {
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
-			arch_sync_dma_flush();
-		}
+		arch_sync_dma_flush();
+	}
 }
 
 static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
-- 
2.43.0

