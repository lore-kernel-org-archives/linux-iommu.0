Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C521CA17
	for <iommu@lists.linux.dev>; Tue,  4 Feb 2025 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712219; cv=none; b=Y7kdl0sFlWsQZnW42+mANoR/l4guLXiNVrj+jsniOH9fBQ2jnkLBhgZakVsKcZNxvj0a2GZ6THX8xIOtO1m10dFAB/pCwI1WxnXjZmRdwQpvhX5FlM9UprSTKyRneilTBZCxLf7YsEAQqfGxlxHbf9uSLa5ZQiEo4JB5hnciS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712219; c=relaxed/simple;
	bh=R+Y6WZ2VttQSZ3o+eVRKRUcuHQ4tlXNm/aCDAigwpNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rBmyG3JjAycSW/KVHz01nUqpnw30XlueTwcIUM2V9+L63RLvP2EZD0BpmX2neDopWPnbaf5830c8puOlkhgraL9rvcb/6CTowMNuYK7LNJcbi3YqmIsdwLox1reF5wSf1qG5zQIhX8cVleU36xbEG6LEvVZ4QNYTct2tlIEuZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jxgao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUTd4Zqa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jxgao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUTd4Zqa"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f9e3a00fcdso15995a91.0
        for <iommu@lists.linux.dev>; Tue, 04 Feb 2025 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738712218; x=1739317018; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=re3PSxTV4DNU5pVphE4C5vvtq76V/ASBC4zGcW/yfQQ=;
        b=bUTd4Zqaf0bM5pdC9M2fOJ6Xlm74o7thqJpQojvOkKbzi8PpchJ12q1HlV/hxKyuyv
         QcF0YZaBGroech0J8i4A4vvoe+hBGtUp6IWLxDHh78fV1jcFg10LYBuXdBIIqAHlUM5Q
         WFtPbZENceRVN0HpWFmyk/Dw8HbS1SuoapsMVqfwAY4IL/8uLG/dVC8Yk1fP6YIy4XhR
         w6YsQlyddfMVdcfRbhhAcISQLW5DygIfnRflJXSjrxYJ245tnW/iJquP0M9JRPov6l1h
         7Xb0oncrFpRy7dWjbjt212QgJ+1+6NcVU4FEpdJi1t7kDUV0WkS/FJ0yLxWNe4j0ch8Y
         vtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738712218; x=1739317018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=re3PSxTV4DNU5pVphE4C5vvtq76V/ASBC4zGcW/yfQQ=;
        b=pokMa5i4OtJWTG7ByU6ELsIcxbR7d9/P9QvK/qCshnhS1lFleV+S4nUuhpFAs/TPui
         M3HTVM4Sh8vaFsjwKa6NG8DnXpLaQu3xFlU8q0KqNsdQhoYQDeQbXSPd6klU34RM3f3f
         yO6VlefShAO1WhgNoynDE5i7A1trjhqefWDkmD0tv9hOsh0yOLYMXAxBQ21baRPYif9r
         DuRUIYgOXzzz8o1eBFaJYmYL0C4hLmQQcGC8k+PPAPQnrxXNiGRj88FJkhXvn9hlRwMd
         83OpmRamWySb+QxEP7Lg52ViAjfMtWsjgGZCHqpG1SvJIAJ73mylaOa96TRoB+7IQutA
         MYTg==
X-Forwarded-Encrypted: i=1; AJvYcCUbbaWuRbtXlBKN0E8OlSLdUNpSH5F/FqfRtxnR/z5SMX0s3IFcqblx6QrBvoKHOG/FEnmtVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+Q/1rSoEApKkuZ9W27UfXE990PFGSxjaKEKPnUR9wBej6swbw
	HqVPPEPLodvh+uUl9f50eFp9Bgb6mPAZHqOyNX7HDOO0UMc2KQRj5GTiDjc0jnsEyMTxX5bzPg=
	=
X-Google-Smtp-Source: AGHT+IFjLwbq46SXedWka0QmmBPXIbrzOFu+JuTwezZ4xvg82r8SLnEq4/vkuBjZR0vrrtV6EJI24Y1VSg==
X-Received: from pjbcz6.prod.google.com ([2002:a17:90a:d446:b0:2ea:61ba:b8f7])
 (user=jxgao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f4b:b0:2ee:aed2:c15c
 with SMTP id 98e67ed59e1d1-2f9e083cc9cmr935737a91.28.1738712217752; Tue, 04
 Feb 2025 15:36:57 -0800 (PST)
Date: Tue,  4 Feb 2025 23:36:30 +0000
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250204233630.3407878-1-jxgao@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204233630.3407878-4-jxgao@google.com>
Subject: [RFC PATCH 3/3] set full_buffer_write for nvme devices.
From: Jianxiong Gao <jxgao@google.com>
To: Keith Busch <kbusch@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ryan Afranji <afranji@google.com>, 
	linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
	Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="UTF-8"

NVMe dma operations always overwrite the whole dma buffer passed to
the device. Making use the newly introduced full_buffer_write flag
so in cases swiotlb is used to bounce the buffer, we no longer need
to do the extra copy on preparing the buffer.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 278bed4e35bb..8fb6a0a87202 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3209,6 +3209,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 	else
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	dma_set_full_buffer_write(&pdev->dev, true);
 	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
-- 
2.48.1.362.g079036d154-goog

