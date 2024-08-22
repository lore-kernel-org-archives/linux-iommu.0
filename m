Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27D1D04A1;
	Thu, 22 Aug 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351870; cv=none; b=pAED6lIz9O5lk/8r8IwteD8sawPU7OmYkWcz9FxY+GZJdOSajsbWe9INwK0FzP2OhD0AMbYO64K+E3EBtWBC2z1Nngfrju6JyCugDgm4hMH2A8nAYkEwhYl7aR7FbZ2nwqVw8xoiFcejWxePovoBEQ0OrXKB1poRSsHaH6y528k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351870; c=relaxed/simple;
	bh=t7o/ANRPJFs0l8TeamTdj8dI882TkX1rTKCkymHtYNQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNwVVueQlv0VfXkpeXfO69G4Vwyj2HFtHfkAR7Acq+K56/hUH8Ecgxq2s/kihbcI2TZvd7808riO5yIx3SiGUD2V8TPpd8HLcl6W3ZqbNm7h5Wk8ok59u97R3sZ8ZoZnDVzakFdRm3nQGGag4Zv8ZdcbORoqP9p4MqqzQOERoP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhOIl1mg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhOIl1mg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20208830de8so9578605ad.1;
        Thu, 22 Aug 2024 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351868; x=1724956668; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/ThqndoEMvfHog7jEmoHMSz79N0bCj0y64RGbOiEjY=;
        b=ZhOIl1mgNKrYWb/ybAvK1im9G1wtFFPXpI+G30lWrGPizWH4HAtLdhuUbOOW30lK38
         8pCBSnzlUQ3M+vogMxVewjb0S1vCnrWXs8O0DVhaMpYEFub37su0Co5p73lza8LgJBYh
         47HQaYBVFmbkL+5wFZhNPXUAdybGVeZAAMKMu7Eu8bMu/n2CdIC6uYJC2kDPbSwVl03o
         ydkMBr42nmZkAtWvJQNz9OVecsarDFl5lQwWvMzgJmzLHYFFkOoproZeyy3I1a8cLLEe
         PdAbBDckCnxs3lvYhSMWL/1mrtmjfY5OHwayqqE951AGzZLM2pWUsjbepO0XnmROmjuE
         SJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351868; x=1724956668;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/ThqndoEMvfHog7jEmoHMSz79N0bCj0y64RGbOiEjY=;
        b=n1RkwaZGw/aXZe8I6wDJU+t7FiI4EgYfDjvZfJEFmUUwMhZA0nL01+DQNxWZwU30zY
         caCoShO5l+V8BW5KcljcY7ZlBJXgX6f5Lx9vA19orJsY1SLYV2DgNL6yQOlY29P/QAXt
         YLRGFoIM2KIc3wBuqGzv08zrIITdSCoS0870sP1RLpTYtMqjA0MvFiGKZHx5u59odPHV
         uWFqfMA8qiz1sdxbzMpr65NWg3/AsBPyvuDyJf+WLbDsjVRtld+8ExF80Gsq3bkm7aV6
         gmmjYmbusd2ln6eJ1LK/7EbxJV5Bdddez97BreP1Wq5m7XHY2J+EykhT29kfow2C/Wo0
         iKeA==
X-Forwarded-Encrypted: i=1; AJvYcCU9uZGNM/u0PeG318p+xrhOWzjI6elByvWgeZzJAReYhgCokoOOIlWoGSu0qcn8Yzel4Xva8A==@lists.linux.dev, AJvYcCWx8i+jnBqO8NA4Bz8JK8Qln5fskZaA86KTWU2zd31J/fPpYuhSI8iDWeqQBtqBiqWXACslhvYhrSccwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr2tpDgIUQYk3XeBzyW3A7RbilxDQCWlycfOodQesHQzpi/i2R
	MFJmhgUsQk3y+Qh9pewkhmKANHVPPxcg9W3AUtQoT3wIWdVM33Fb
X-Google-Smtp-Source: AGHT+IE5HU0h4JUoQwfjPC2hkmon5bCJZ8hz8HnwTaO4uEWN3UXUQmXUdXTWmLmVascnml4B3X8Sbw==
X-Received: by 2002:a17:902:d4ca:b0:202:162c:1f36 with SMTP id d9443c01a7336-20367d3b815mr78784005ad.36.1724351868111;
        Thu, 22 Aug 2024 11:37:48 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:47 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 2/7] dma: Handle swiotlb throttling for SGLs
Date: Thu, 22 Aug 2024 11:37:13 -0700
Message-Id: <20240822183718.1234-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

When a DMA map request is for a SGL, each SGL entry results in an
independent mapping operation. If the mapping requires a bounce buffer
due to running in a CoCo VM or due to swiotlb=force on the boot line,
swiotlb is invoked. If swiotlb throttling is enabled for the request,
each SGL entry results in a separate throttling operation. This is
problematic because a thread may be holding swiotlb memory while waiting
for memory to become free.

Resolve this problem by only allowing throttling on the 0th SGL
entry. When unmapping the SGL, unmap entries 1 thru N-1 first, then
unmap entry 0 so that the throttle isn't released until all swiotlb
memory has been freed.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This approach to SGLs muddies the line between DMA direct and swiotlb
throttling functionality. To keep the MAY_BLOCK attr fully generic, it
should propagate to the mapping of all SGL entries.

An alternate approach is to define an additional DMA attribute that
is internal to the DMA layer. Instead of clearing MAX_BLOCK, this
attr is added by dma_direct_map_sg() when mapping SGL entries other
than the 0th entry. swiotlb would do throttling only when MAY_BLOCK
is set and this new attr is not set.

This approach has a modest amount of additional complexity. Given
that we currently have no other users of the MAY_BLOCK attr, the
conceptual cleanliness may not be warranted until we do.

Thoughts?

 kernel/dma/direct.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4480a3cd92e0..80e03c0838d4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -438,6 +438,18 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 }
 
+static void dma_direct_unmap_sgl_entry(struct device *dev,
+		struct scatterlist *sgl, enum dma_data_direction dir,
+		unsigned long attrs)
+
+{
+	if (sg_dma_is_bus_address(sgl))
+		sg_dma_unmark_bus_address(sgl);
+	else
+		dma_direct_unmap_page(dev, sgl->dma_address,
+				      sg_dma_len(sgl), dir, attrs);
+}
+
 /*
  * Unmaps segments, except for ones marked as pci_p2pdma which do not
  * require any further action as they contain a bus address.
@@ -449,12 +461,20 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl,  sg, nents, i) {
-		if (sg_dma_is_bus_address(sg))
-			sg_dma_unmark_bus_address(sg);
-		else
-			dma_direct_unmap_page(dev, sg->dma_address,
-					      sg_dma_len(sg), dir, attrs);
+		/*
+		 * Skip the 0th SGL entry in case this SGL consists of
+		 * throttled swiotlb mappings. In such a case, any other
+		 * entries should be unmapped first since unmapping the
+		 * 0th entry will release the throttle semaphore.
+		 */
+		if (!i)
+			continue;
+		dma_direct_unmap_sgl_entry(dev, sg, dir, attrs);
 	}
+
+	/* Now do the 0th SGL entry */
+	if (nents)
+		dma_direct_unmap_sgl_entry(dev, sgl, dir, attrs);
 }
 #endif
 
@@ -492,6 +512,11 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			ret = -EIO;
 			goto out_unmap;
 		}
+
+		/* Allow only the 0th SGL entry to block */
+		if (!i)
+			attrs &= ~DMA_ATTR_MAY_BLOCK;
+
 		sg_dma_len(sg) = sg->length;
 	}
 
-- 
2.25.1

