Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842626FA5A
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820913; cv=none; b=H8s7xywfIsn9aSABmmYcCBVFcFnD7VlQMMqacFsTJ8UF1Bx+0KGQbOrfCeFQLmcjpq6e+BLe/uZiBNWpLOB/Xn23kr/a9Q4MLdjmNKu3OoCnrUp/+bXFENZc1ymXsorFHPhmFkvehvB8BN6HFw5WWTqUp4JRk8Ibhw/i4MBgHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820913; c=relaxed/simple;
	bh=5s1rWQJ+Z2lDryIw+56RWZIO1a5iRfqeMXiOHFNPVzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0lKWV+MBPXwvt9VQo+C7Ul3Dgua7OM8wqboCR8Y5BUuWdg8QuFjEQnllVduT3mq2+ASezpn9qy5GvpOKPvgob7Isyu+FZJTFZOkdHJkNN37zfynSBH2oOi8qWfx3N/DkwhGBJnCxqJrhKc0l4PN/byf2VEz1bC7hWUo+ljr00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lt9c6xH8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lt9c6xH8"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b9974ac31so128482f8f.1
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775820910; x=1776425710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+enkRwOXc8U3SwUhbI4xZhsqayARL5qS8xyrN2qP60=;
        b=Lt9c6xH8Pn0XGLBYRRp9v2OzvA3G5QsfbJlOOXdM67HuLbA3wNk/r7aGRyjCM0CuQ0
         mcogTRNHPI/9hFIngJuN1EWLdRmBWE+kDXNDELgPfzC22wKlfJ2bwRHQr+5WPsrBYjiw
         BedWSp4vZd3zuulhHVOZYJv36NY4Ac3+gDRYWYyWrzdR12Wh6G8ouD/IMoYYRdHtg+ev
         KqPai51ySo9RS85lC5OMaacJHD9wok0hYAZYw97kd6qzNZXvUxIo9olGRQZSeQZFJm9n
         ZIqpvRSlWu50xfM9TklSc9qe6mXECaGnejGM9QaqyPihAxnK2tH87QMKsUHuxkvQ1DZM
         +Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775820910; x=1776425710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+enkRwOXc8U3SwUhbI4xZhsqayARL5qS8xyrN2qP60=;
        b=NokCK00v2AbxoI2MSuuoejNdSM1/NxagzPpl6jUZFDAP9cus8D3qkaOu4ZAEy6D8W8
         +3afAMEOFWGbk78/YxU0YvqOBvcDJ4Z8Vj2ZonPddqnIfDIccilrVlsokyPstDfuPN/D
         a9szZrDHfCsYewW2wOSigNVngApFqXJKhpBk3wsGGcK8S64V30yzqw8acYfcxOalPq8V
         qdfrLtI/J7Ciu9h8GudObmM6lxhkd/IHIHalyzoQETIDLKKC6TlWPlBZDetddpwIAhxZ
         6HN4gkVA3mo6UvH47W9TDHmpFbuLUOfOxnbFdtwXI5l+n8UqT9ahq08s4CA/kN9OpqAR
         lh2w==
X-Gm-Message-State: AOJu0YwFUrUP3coWe78PP3j1Fj5glrywOEjB6IU4mrW3YCADGQn2T674
	xTU4NJeM1usN/b74oLf3tPM2UNbBbMFZxeHQRxJ32apyo5xgiICDyOgTOevJAIk1uIw=
X-Gm-Gg: AeBDietRGxwnWQg9TiaI8tpyn0q7kch+tygt1tIZUSg2MJ6WjDpYFtduUwOv2tgw/wx
	jkbMCTQ+PMdB+owOdTss+fAKYbBwrizxZ/L0gMBRuy8YhHI3/NugMTN0BAt4fnu4zGmBe93OyGC
	qkbTa5M54hk9yMj4xbbDTY1TC4ayQvBZ+tjFXtUoDnxyUXA35lcvBtdKccK4cXOKMGngmX+0wF/
	I4oY012o/cB+P+xHOZF87EWGCAChLAfsPaF5IsG5FKn/x59PN4/E/BA//VHFCyE+bvG1UF/bD3S
	GcGMXVeLTv/89TOhkwU1vsDbKTW1cWERoLinpqKwLTQbcuF7h4lO2AoVD2+kVmz67oy+TrebApY
	ic1g+zuxIRfLr7oJ/BARLC5pYHQ94yPpaH6c6hekEgwkgHc0vTVPijDaEu6EdEWLBoISgmPjJ+I
	1kCeK9DaTUBQ8AoP9JdH9zDBlGCgXrQhl5H5woOO0cr15MUvBzVzKbzzqT6tKXmiax4DVI6aI9R
	oJWL7wRh0jXegAVvLBZs7w9q3o5
X-Received: by 2002:a05:600c:1c06:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-488d7e21466mr17700085e9.0.1775820910015;
        Fri, 10 Apr 2026 04:35:10 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3c597sm62850165e9.12.2026.04.10.04.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 04:35:09 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 1/1] dma-direct: fix use of max_pfn
Date: Fri, 10 Apr 2026 13:35:06 +0200
Message-ID: <20260410113506.262579-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calculate the correct physical address of the last byte of memory. Since
max_pfn is in fact "the PFN of the first page after the highest system RAM
in physical address space", the highest address that might be used for a
DMA buffer is one byte below max_pfn << PAGE_SHIFT.

This fix is unlikely to make any difference in practice. It's just that the
current formula is slightly confusing.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kernel/dma/direct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8f43a930716d4..fefa6c4ac467f 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -39,7 +39,7 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
+	phys_addr_t phys = ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
 	u64 max_dma = phys_to_dma_direct(dev, phys);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
@@ -540,7 +540,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
+	u64 min_mask = ((u64)max_pfn << PAGE_SHIFT) - 1;
 
 	/*
 	 * Because 32-bit DMA masks are so common we expect every architecture
-- 
2.53.0

