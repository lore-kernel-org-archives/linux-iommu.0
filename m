Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382A3AB5BB
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554540; cv=none; b=pjCOEDOTnhfJpotZrZSJZ/GjkTmLlwXHDuFNkADUFeVb7pbznSRuHgATyqFVratlcirKu/h+bgT4jd45L79tJETUby5yKcmSxsBArgpOD2/x4a218nX8qpG+v39xcXEBJczZqci/e/puBi5VkkvWo9LHxd6Xk+5Yw5/E5DoiPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554540; c=relaxed/simple;
	bh=8pgB2+m6zQDsdm8l3FJG7AwY8SkJeC+684RsRAZ8ZUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WoZKjhTp58+xm9KY0qIk70StMun0aaK8aR+C3aCMkOLEJvtPECO5z51vGI14MvCpuhDMbAdWrOvbB2Tue7FXT3wzDQXvVVHMFq5uPaMAwGuvGb7O7fVaCUBSPpqTk8sOQnVXpFD+oD74FofQvpToT33VqEH/I+Xftkncn3PMJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXGLuhaV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXGLuhaV"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848544a8496so490078b3a.0
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554538; x=1784159338; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZBzRoXH7VF0ByV3qQDpFWW6MWj2hI4S3QQKMPJnM4U=;
        b=sXGLuhaVU6fLTv45VPwNjG+ytZvAOnkzeg8GlRQHis6vyowzftFhmvhAQ3l/ytgP55
         qOv+Z/idmDLsR0qyEWjkYpgPZS/HyDkh753sLWeyZf4bPI3+C6OAlZDtJJg4XpqHwrue
         HoyVxgE2PrREGVtZbdwmz8HJ0vV4jJDU0kW6nSFCoKtrFuRpX4kjfHK8gA6WGqgS2Gjp
         iVhRfwZrivdcQwY/a1NfLBMUnLYHR6Y6kfuMf6aAt5inYtYWsgyrxhaYzn7ot+zr9qLX
         7tZKCZiMpga/M+NAfW1f6I/kIHfCvzrL4/SoX77abHUZg9HKTnovRXak283BbhE7akzn
         4xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554538; x=1784159338;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZBzRoXH7VF0ByV3qQDpFWW6MWj2hI4S3QQKMPJnM4U=;
        b=NM7gJEpBVa3DXE8TpmRNwQyKPqCphHRTWyBbb/otFVDtm0WJi4isV2jGd1vPwATuRV
         Iu/YDc45M4x2GDtOqYqQdkckHfAfOZHWKFMtEgCz1tCbBNRvwm7z+3GSW5uyCUcojRpa
         E3Dc35bR1AxqwJOYBqzUi+UFagdvucSCHUULr3UxB6FlmLuaSwLed/oeUGfCS/Sxn6+3
         0vs0sIt8yhGWUkUnuiqAugKkLr1TbN7vJAMu3jwWYejXLSxrhaaeUmFWtnv8ZDg18Uos
         BUm1N40ybfIQHpGQI6CUS8Cml3DvJAyw+WkdR67kPcRAQu3h4gPhCokSmEdx88CiV19r
         r1lA==
X-Forwarded-Encrypted: i=1; AHgh+Rogizdm85OvDtaxQrynGsNtTei8wvyWCRfcfNLSzW/R0O1g/Y7bzGw8b5AZgVo/I/F1wZgf2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY1v7AlSKu5jgZcVtkuycAOjfho739J6uGUk3u/9rGUshoY+Ur
	fbWqatJIDL1kObAdZdJt7E/jC1+8HaJ8qRzVRREJOxkCtXrLUmrNGzMrQ6cc+DamXrcrDuGhMfw
	8bLG05RikhrnRXw==
X-Received: from pfbhh2.prod.google.com ([2002:a05:6a00:8682:b0:845:4da8:56a5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:805:b0:848:3f83:de9b with SMTP id d2e1a72fcca58-84842fe47bcmr4585485b3a.9.1783554538155;
 Wed, 08 Jul 2026 16:48:58 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:48 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-5-skhawaja@google.com>
Subject: [RFC PATCH v2 04/10] dma-coherent: Allow checking if allocation is
 from dev coherent region
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an API that allows if a DMA allocation is from device coherent
region.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-map-ops.h |  3 +++
 kernel/dma/coherent.c       | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9b91c839ceb5..b13e5eebe6d3 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -162,6 +162,7 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, size_t size, int *ret);
+bool dma_is_from_dev_coherent(struct device *dev, void *vaddr);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
@@ -172,6 +173,8 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+#define dma_is_from_dev_coherent(dev, vaddr) (false)
+
 static inline void dma_release_coherent_memory(struct device *dev) { }
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index bcdc0f76d2e8..76cbe11e1f90 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -231,6 +231,17 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 	return __dma_release_from_coherent(mem, order, vaddr);
 }
 
+bool dma_is_from_dev_coherent(struct device *dev, void *vaddr)
+{
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (mem && vaddr >= mem->virt_base && vaddr <
+		   (mem->virt_base + ((dma_addr_t)mem->size << PAGE_SHIFT)))
+		return true;
+
+	return false;
+}
+
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 		struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
 {
-- 
2.55.0.795.g602f6c329a-goog

