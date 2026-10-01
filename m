Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B22FFF8D
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838024; cv=none; b=CwseqXbOjbBNkp7F0ZnzdHqibFH5pzkWuord7La95GzahAzX02l8pN1hNLHg2s6a+cqrjJmUW2qSd6qkQMnutPJ+Fl/+w/MbWV1OEYQcxq/zpnoq725wPu1+nSzP+ZKwWgGogVj0OR//9hsQaXa/zt8j5q5ooxiUEQc85ucKltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838024; c=relaxed/simple;
	bh=CJLBeRK+I5A1iOpSL7oJuq5eozHbtafRxFhgIb8iIGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVFMg0LAami4vcTUA1+xApqoLP3GHV6tZFOWmSAvyvH0q1DCKCHbkFgQQ9briMXldr7JP2h/YUxcdzlloxtI8OUKLeewPucLJo9Pxuz63L+dQmntQFHVz6j452kow1WfViOI7TE5MHzCpM/YTtyO5u4LTkmQFhcEzFaxpxf0Kt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwoRx6/v; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwoRx6/v"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ac4967f1c9so15591637b3.2
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790838014; x=1791442814; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PY5L4rsgn2xeSzbqzp3GfiDBmX9wGoutuZbjOU3l+N8=;
        b=rwoRx6/vVB4JEOBEE6nlIfTaEiCXc3QpBwCkKqQSWW7Hr/JY6F/u/rI3Ds6GpPf1NO
         NP4U9gRBIeWIaD9U0fY0COKgObVPmuhQuUaLfLzF2KaUysxRp4WYi1uz/T/uZZcQXZSH
         YnSNUGQJijPFVvVeYBofVlyb/1hNPIITGcwkgbaIYRTZqwM+Dy4a/JB/pyU0hSukMokR
         92w0g3ZozqexGvFS3/VbdhsmEMR34nVgxjUTT6ZhP4Os8NEzaDbhR+2iiEtI9/rQzXqe
         occ9xCnTQBnM/Uo1Frgvmlo7pCETMEkgTb+yo3NJhDsHGxUqVvo5ZJbrylhNWh55bDu8
         Pn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790838014; x=1791442814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PY5L4rsgn2xeSzbqzp3GfiDBmX9wGoutuZbjOU3l+N8=;
        b=aKsYYqGGxHCf6ls9QO9FlHIwjd5qk9o62i8rTZo79x7Hcc8M/xhu7Qp+i7wTraizfM
         JqWWaLA4MvyUI51NNN1OOMWx5Qpn2pbTRM6OyzytL9hJL9l7GpKrlYKVHfkl3BLg+CgD
         gFQzzauGGmJXi99rn6w7KSD2x7yepP8egRLN9hRNAPZM58A8AVumGxsNNJks2j722y4e
         s36PdS+983PGtQoCMaUJOIZ9vRXhvKE8qf/fsjHk/t39kGD4Y4nvuVK132PfxQu+dTO3
         npSi9jEn36O03e5oN0k6RJCD3ouiyMVZJBm9CTsj/nsFym1fe3So+dRdpb6bXHMOwe4h
         hz0Q==
X-Gm-Message-State: AFq9FYLfMrA8gm2psrvkv6kwWhD1nA3pEO14cs+ziwO1hgItRdr44cQn
	gk0PRSTiuvaT8tEHvwa5UVUTnPUddiZH/AR/uFH3AKLN5lc3itPlf0Gu
X-Gm-Gg: AYBFou1TL7/8FXBt4R9stRa1j2esJjUcvDExDFYlV81MppUId7CTDC2Bm6sudxa1LO/
	Ag1pwLVrLs9erGU3eQHgNM3mk8tE6PB6t3r44yjeRYXPVVod6HH/B5Amt4bOgTD2Mt8suTe6xi2
	7zIAnHDhiRnkGsuPQpiWLd9tKSSj3+72MRhC6ZcFX4XJbQ4K1yWO9G5DbBiA//tDv+TFEfu3okh
	eSsNsGkB6x4NKieZfoQ579sK6ufQjjKrKCnSv4Ot45l2USo6iFKsYzbtbfLDsWcipSpkurHpkA0
	vw9sf5FUa2b9vz5YXgmaZWNZt+JDtM61D7LsviufLEcHpnrDn9UJTplWymREuvpmtnVDFC8dm+U
	v7+yvZHn/Z6BQWgD+hRWwoux/LNZztXhEktpZ5SyQiIZ1E4/BaHCfzrxoVh3GCy9TPAJ2B9TrND
	f4OdoE3unOlym7OjI4mvSgVTtt4i8AzNRU3+IVBq6KXfkRcQKngEmzd+WT+5MoRQ==
X-Received: by 2002:a05:690c:d89:b0:882:31:3b08 with SMTP id 00721157ae682-8ac909cacd4mr14554387b3.15.1790838014308;
        Thu, 01 Oct 2026 00:00:14 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdac9d2e8sm7283687b3.12.2026.10.01.00.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:00:12 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH] iommu/dma: Don't free under/oversized IOVA ranges
Date: Thu,  1 Oct 2026 02:59:53 -0400
Message-ID: <20261001065953.2717823-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unmapping DMA from a translating IOMMU, the range unmapped by the
IOMMU page table may not match the size specified in the request. An
unmapped length of 0 suggests that either the request was rejected by
the IOMMU or the IOVA did not exist in the page table. A size mismatch
suggests that either the unmap was partially successful or the request
was made with an incorrect IOVA and/or size.

Because the return value of iommu_unmap_fast() is already in hand in
__iommu_dma_unmap(), hardening is cheap.

In the case of an unmapped length of 0, skip the IOTLB sync (because
there is nothing to sync) and skip freeing of the unmapped IOVA which
would corrupt the IOVA allocator state.

In the case of size mismatch, flush the IOTLB synchronously and
intentionally leak the IOVA allocation if it existed. A potential leak
of a valid IOVA is more predictable than potentially corrupting the
IOVA allocator state. The existing WARN_ON() is preserved.

The intention is to prevent failure cascades from intermittent driver
bugs. If one bad unmap causes a future mapping error (because the
allocator cache believed that an IOVA was free), then we are at the
mercy of the driver's map error handling.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
This was tested with QEMU 8.2 against virtio-iommu and emulation of:
* VT-d
* AMD-Vi
* SMMUv3
* s390 zPCI
---
 drivers/iommu/dma-iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..029ccc3b55cf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -836,7 +836,22 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
 
 	unmapped = iommu_unmap_fast(domain, dma_addr, size, &iotlb_gather);
-	WARN_ON(unmapped != size);
+	if (WARN_ON(unmapped != size)) {
+		if (unmapped) {
+			/*
+			 * If we changed the page table, we must sync IOTLB.
+			 * Freeing the IOVA could corrupt the allocator,
+			 *   so leak it instead.
+			 */
+			if (iotlb_gather.queued) {
+				iommu_flush_iotlb_all(domain);
+				iommu_put_pages_list(&iotlb_gather.freelist);
+			} else {
+				iommu_iotlb_sync(domain, &iotlb_gather);
+			}
+		}
+		return;
+	}
 
 	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);

base-commit: cec2dc7663e7182c311162163d71b1bbdfdbf09b
-- 
2.43.0

