Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23BC1F12E9
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458947; cv=none; b=kma7RMStpt9OyeYxBEPzCRlEx3+pXdOS6IRrlwuSyJMJ1k67iEOKmsZmL4mpiFXgpsAMt3tNIBLqGZpZYgP4tfiX9vbsyfxHDIOQZOoaGxvG+f1cZ8zC5FR4zcVJcPKKO7fXehoxRz70S7zeZY6+7E2SvlzApaPWDuGBsj7CZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458947; c=relaxed/simple;
	bh=DtILGrM3+rfRXWqQcTGk9nG1XMGIAOFuySX5/0Wg8L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM6C+bC+SgmZ6s/ST1T61HkWNWJfAvT4YlBm2H6kmkeI6EITep9pCxlkNdf8mniWCczkQRLHgxHywip8FSKmwdVAFY2mxQUlKAmTk7NwOa9+gwuMq927iE3xlY7F9rAP5ldPeb/YUvq50fosVu++6MgxcZ9zn8xPO6J0KR/49Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6PUhbPp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6PUhbPp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21636268e43so120660235ad.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 03:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737458945; x=1738063745; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXagEzywweo8G/6OstGzvbkfhs6k8bp2kHQoB/L2HB8=;
        b=e6PUhbPpLFTX3YsGthG76b2Sw3ypQcGJ3WIkQoW8od8cPeDvVaWVgLDsZNNRWTwY08
         ABt6o8/1yqXjvUpvB63SBVAMrW9KHIbqX5jqYHQCfCrgvq1OUmef4247ixNRydmdh9ep
         G6qitOB2U4SwvjPvjw5QTIbIx6HFE/my8T+XnCLH53Vk4vbKga9pJkEHUObVkwPToyCq
         xXIvSJLAqkBzYiqmhNHrUa2lt6DFB5hEA2k06XZJn9aIGV2TLaMxBI89lx575AoYe1BT
         l7cmtQUqkm27j8QDXH6gH16UuQanBf0seOLV6kURmDA2/93MXMCzmNVLJ/P8HNm+Jqpb
         vdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737458945; x=1738063745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXagEzywweo8G/6OstGzvbkfhs6k8bp2kHQoB/L2HB8=;
        b=B/p9LaLmtoM970y5zWp2TBXX/Tl5XmQ1qChN2agHKebO0VPZ4ok9O85veKJN8i6w3y
         o7ONarN1co2J3L7H0S+NHZ+ID14hhjgMvoyci2KbCaBpp2vcJj8F+AXdToLaKIlAO4fG
         pcl7miBAuCkRIce7uQobyaYBbw/zUo9oJ8wOgA97F3fxNByA0Hv4Pcz+DT9AiALIkA6K
         /dyUtk5cpv8HhjQgb0x2Iz/fzRo70NG6oOZxCIG2zJFcwoxLv8v061/VyFUd9FS5PN0E
         DOJd1GxPG+UbgzASaC2SFWOcuxr6zT6Y1ox4QhHl2LdaHgr+7yfLyUMFSd0JusShOGj7
         67SA==
X-Gm-Message-State: AOJu0YwlUr7dc923onv5K+SwpHpgeg82Vh91wgqR9+EWaBkatJbJliXZ
	AQH6O5XIEW1hZgQb9TJDKshOlpFgRUIesO1WeGk3JNbte1TXFHQd
X-Gm-Gg: ASbGncvEm+rHgfBjZMkjWCK+VwjE2zQNuqoIgTphEed7Cz7JU3a9n6tkzvDwfQAA/pe
	CbYH92uNzcqC2tZEBwiu6Q1/1um59TLnp+XuI8n18gQ8MjNugsZ+k1loV3rYk5cyv+jpkcxFBMg
	X5TzU5MrfdR8LVSoluX49acfAhkriqmF5uoqKPvluOrTjohU3hop9KQ2B6cpO0Xa4S2btW0gFRg
	rGPi6kzyeEh9eGfWyOOzH9tPHXBmPDMHICaRQDVCyrVImNOpcQ5YKRnZXi2tRkz6PH7smaf6dMS
	PGI2h3Aj
X-Google-Smtp-Source: AGHT+IH6fqnSkGAu0RzR1hL/8eMgnirYGIBDu4gvagajjQRKR4xYSTPHDLM/zXZ9hh02Fhhkq69ucQ==
X-Received: by 2002:a17:902:f7ce:b0:215:773a:c168 with SMTP id d9443c01a7336-21c352de425mr254278285ad.1.1737458945192;
        Tue, 21 Jan 2025 03:29:05 -0800 (PST)
Received: from tiger.hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea1fdesm75385965ad.26.2025.01.21.03.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:29:04 -0800 (PST)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: east.moutain.yang@gmail.com,
	alex.williamson@redhat.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	joro@8bytes.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org
Subject: [PATCH v3 2/3] vfio/vfio_iommu_type1:convert VFIO_DMA_MAP_FLAG_MMIO to IOMMU_MMIO flag
Date: Tue, 21 Jan 2025 19:28:35 +0800
Message-ID: <20250121112836.525046-2-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121112836.525046-1-east.moutain.yang@gmail.com>
References: <CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
 <20250121112836.525046-1-east.moutain.yang@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refer to commit: 31e6850e0fdb iommu: Add MMIO mapping type (Robin Murphy),
IOMMU needs to know the type of mapping to setup IOMMU page table,
if the mapping is for device MMIO region, on some platforms, IOMMU page
table entry attrs should be different versus regular memory.

Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 50ebc9593c9d..08be1ef8514b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1557,6 +1557,8 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 		prot |= IOMMU_WRITE;
 	if (map->flags & VFIO_DMA_MAP_FLAG_READ)
 		prot |= IOMMU_READ;
+    if (map->flags & VFIO_DMA_MAP_FLAG_MMIO)
+        prot |= IOMMU_MMIO;
 
 	if ((prot && set_vaddr) || (!prot && !set_vaddr))
 		return -EINVAL;
@@ -2801,7 +2803,7 @@ static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
 	struct vfio_iommu_type1_dma_map map;
 	unsigned long minsz;
 	uint32_t mask = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE |
-			VFIO_DMA_MAP_FLAG_VADDR;
+			VFIO_DMA_MAP_FLAG_VADDR | VFIO_DMA_MAP_FLAG_MMIO;
 
 	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
-- 
2.43.0

