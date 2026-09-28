Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B638D40C
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573961; cv=none; b=gVZrYDnnVHNG72gkdT/h8EJqfoFWrEG0YDcpLT0Xk0B031FQXc3Vg9d/+lA+6QaK/EXyw+6DFx7Xj8iP3NODg+EWspiXJhFCuXM3SbuAd1SYbKD3DxFPTj76Tpuv3s7gB8SgOfLRIRBzY+r7n0t5lFXYYCpSSWkUx5+yQX6M4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573961; c=relaxed/simple;
	bh=qDHuxNQTwiK4vLrjxltnQ7pSPnmhxpgaO7APWc3qf9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uvbtbty5baKTL6Xwwc/a/EUjmYl+OwdN8gmChp7qJmtea0+zB0sIsrS5poFhDQDSGNUed8mdBotMlyy6KO7Ogo2YOMpMi+FQ4MAeOOsTcuiYmHeZ3zsgBcQA/eWHYLf/ib7i3hfqzy535w8uBYe9O/INd1IrpgT5FFS1tBSfj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8y2BuZ/; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8y2BuZ/"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-880a6cea1f7so73209b3a.0
        for <iommu@lists.linux.dev>; Sun, 27 Sep 2026 22:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790573954; x=1791178754; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oYoN39qS2O9tTjo4AMAAx7esJiOig4Qk9Kzt2+/v1lw=;
        b=q8y2BuZ/2/OL5TQpPAY8LxaEm/HuLkhCm9gKjrE+toqwqR4KCDNwZU9V1qZBFN3sMn
         0/msMeDmTBz2UxOPh12EE0vPtBCLEx0dN4ltnmWaiPhPT1SssqNNhDyKDFxKr8jDXkk2
         KJlUtaNIkbpFQXM3ju+or12WQGzIl53sJDOMjTlcOoaMEBUDSaCMVazuq/BBZQ8d+jOM
         x9ZgQ6QCY0gP/Ft/t7SNSKkt4nBdX62RQ2TtD+7S6fiO2bMwY65GUShDT2DW2Uw9OTjU
         xGk6JSqZf5OzMvuAIwab+FLxbhY9qqzSMAhSi2UerMJOX3JI7o4mxoOAP7ihBw3dfFYg
         MUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573954; x=1791178754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYoN39qS2O9tTjo4AMAAx7esJiOig4Qk9Kzt2+/v1lw=;
        b=A9wdS8bZzWjf+xi0nHBCFQLHwDxl1YmS/s7o7zW8WTSNoS0HWR89qyXRMwoQhjvDVr
         j/HbID+MR1bpcsHhgu9AbGYLCpL0bPRsUT8S8raU3y3yby6UbLRO748ImgT+qk2uHcKM
         1x+rzVNnunBb1cwkYlp+zpqEcI85YW/xhNyTbeFEk+mXSKvtLdATajPCw20UeZdZ1JyM
         nQnLlEpUH4ayFxKiZTxlbS65+iWCn3ElYFOP+AHgKdGs4FT7fA182Tv/Tro4k8GuoyOS
         kTjZvcODRwS0eXg+lDEQq75K6vgaWaXIEHoXaD5tySAXohCm4l9uiBY4hHH6TUtHIHv8
         5YOA==
X-Forwarded-Encrypted: i=1; AKwUvBzqiyDzee6arrkdMY5wtB5CvvuYaMnu6XKW4XlT0AHVRQSA8YPoECACPS9S0NsNbWOliyWIiQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ldHZV1eXM9Xw2cv+53HPI8ktHYqSgv0ksWT49kAmpXnh7X5EIx
	0asrs3QBmdcrxU1R8653RTq6Hj1Vect4Go/Nyd1+0sPwPZC9djvimZ8I
X-Gm-Gg: AYBFou3Ybb1RwSFRMLnMn1c/kY2VWvDoihP9cAuGg0zo8yTx+T3XcPXFPmoA7FYidr5
	DuWj1w4zuFRP5gIejx0WWcQu5uRzYj47DkD9SSxwXnUvvHcOEFxJoEmCmqy137CRmWaNG6PEgKe
	c8BnC3nya/osYGV8AiZ7TG8EcsXwpDSmldoIgcTMWghlV8UBR8XCvE9Up7rw8/DCnU5ezpuMjgP
	8eOu9qNJT+b8SDOhxo4HESdvRtzaGGiQTIvnc/+gcGRZFSB7XKTTMzWVrJLmTcWoMENmk2H7oMf
	/55hA6DVNyb6InNtvPQQpyhrxJ8qRq8DJupXY1SvojSzybauzCDDo09U+mnOXgGXx4SnUHWVdHW
	p0Jx9LIsjcfRq72SmpKLdSsAlEKKgGNmUyECzpISKHlkzcxzTxEpNztOnc/EvEbVAKvmPPxOHee
	eCorEcImMtAABLCPRzg/NEAn+9THApAmnnfdxb39FEp3kruLJo994Hq63Yh7/urQFwQzyhxzCmv
	MIvB4f3MtWpdA==
X-Received: by 2002:a05:6a21:1645:b0:3c3:2dc0:7cbd with SMTP id adf61e73a8af0-3de22b356bbmr12488753637.1.1790573954396;
        Sun, 27 Sep 2026 22:39:14 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87febb82357sm3591121b3a.61.2026.09.27.22.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:39:13 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
	freedreno@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Dmitry Baryshkov <lumag@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-media@vger.kernel.org,
	Bryan O'Donoghue <bod.linux@nxsw.ie>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v1 1/2] iommu: export iommu_get_dma_domain()
Date: Mon, 28 Sep 2026 13:38:50 +0800
Message-ID: <20260928053901.7270-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928053901.7270-1-liujianfeng1994@gmail.com>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm/msm needs to recover the physical address behind a DMA address of
imported dma-bufs: with CONFIG_DMABUF_DEBUG=y the attachment sg_table
it hands to importers carries no struct page, and msm has to translate
sg_dma_address() back to a physical address through the attaching
device's DMA-API domain to map such buffers into its own pagetables
(see the follow-up drm/msm patch).

Export the helper so modularized drivers can use it.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9af..330f9a79248bd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2327,6 +2327,7 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 {
 	return dev->iommu_group->default_domain;
 }
+EXPORT_SYMBOL_GPL(iommu_get_dma_domain);
 
 static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
 					  struct iommu_attach_handle *handle)
-- 
2.47.3

