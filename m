Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17D23817E
	for <iommu@lists.linux.dev>; Sun, 15 Mar 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563326; cv=none; b=uY8X1N3dnnJ0WAez42StTP3J5sUL6YAS85Ajh0McvWLBbqBQ/bHagbq0yBCPOLH59/hz7UNs5kXhMFM8zAffZsTPKUAIP0OuD/UlPKTAL5FX6rYv06W1bNk0MEtDZlAEjdxxxq8nFwSamFrD1Pqp00HIIEtE+IsBVtYOflcJRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563326; c=relaxed/simple;
	bh=HFCmm9+lNAJNhfV7fOVO/gE32UV6UExhiS6HRHN+uo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=PGxbKKKSPEluB+42Lsb7C+SjQXx95d7qHroHkojkodjQAjKzZicUuXxtHkMz//xLaI9z1bn5QL1WLP6Xe0QcG4JtOEWQd58Zz5dwMxkvHOYp8L9zHOabeAGs5KW5AfWAzyla/IEq57H/2/3oHzL8uFiX4P6zOhY/rRT4KSpLsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6+QwT1I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6+QwT1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773563323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sT1fz+nZNL5Xr4YwRtI6wr1LjR6m/sM+MT7k5Awq2j8=;
	b=L6+QwT1IOvzkJrgj3gsopm3W42lhtFtC9vlv5cd/hOEYm/+wVGbrCSODq6rIYYA2pDLPQN
	3RL5nM7TjG2hAdi3u5oeojXf4w3tBX2owDuN1lYmyQaw6b3TZJh4pOB7sguhxbp+4VimSb
	o+pQeLRnQjDuezu9X6WIMOLb49M1aiQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-kpJ8T2JBNBOkldirolFx4A-1; Sun, 15 Mar 2026 04:28:42 -0400
X-MC-Unique: kpJ8T2JBNBOkldirolFx4A-1
X-Mimecast-MFC-AGG-ID: kpJ8T2JBNBOkldirolFx4A_1773563321
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3595485abbbso3904352a91.2
        for <iommu@lists.linux.dev>; Sun, 15 Mar 2026 01:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773563321; x=1774168121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT1fz+nZNL5Xr4YwRtI6wr1LjR6m/sM+MT7k5Awq2j8=;
        b=jIrBg0SaqWaEb7j59x2f4DsWFkxiIjg+I5Y3g4eF08o1vX/H5GXBWE6qKR0lHpppCb
         yPgnS17blcE2E0vJ5v6pwbDSblCvotQSvSO9QorJx2qscixmyiKXEicX6+BZF4Rbt5/Y
         rZ1B4arGxmiLEJpZerk7w6L5n8LsbEmCzWfeg+RJ+2rROq7FI7zB2lWwyBqk+aQU/rR5
         b++AW1kSD2EF3D3QGUMg/w4Btm4h5uXSPRAgliYx8XtdeN6tvaCaTcZ91Wo9iHEchiD7
         m1ZFN/+z3sxyT/9UUN9OJnA9uifHiXVZip3RYiAsvhRZlNBDW0Rm0Q9OibFNy9mTqbNR
         P08g==
X-Forwarded-Encrypted: i=1; AJvYcCVFXbatzIV743jOcRtBqaLh90OG+RGGteSgR4nu6yYZj6Ngcid+bPDC+mmwBQ5st3husQN6Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuUE940s7TF6SSuITrV8Uxzyp7smSXeQHOnR/fjG7uBpZRnXRt
	joernpVI3yYDv/x92RK4OFYkNGncoWeqZ/43PfQz2vZz7jiQ/JDavqYf7ni644treikyLDWesu6
	kaf9+gHaBSoaSRasUDDMc4jsp/sKbSkWvT78nnAsrOz24CDqdE3+JWOoF
X-Gm-Gg: ATEYQzyJjFGWMvXm0weReqvKupt74U8kyYmu4U7ZD599nwd877YygEGRTp3/GsCZhGS
	D28PBpAXc/budhIO5h1ES8ZXfViuXHahBAj25Buufk1aggenw4kZ15Igr01Kcb9P6WHq05hDR7Z
	PhvFo5W/l5x9LYboHCgT0IN03uzOpN5EQ5qqfibScFG08R3VMq7YFY20RWPry+rS6z6rMaSiskw
	A8hz5M+LgFwRjOK927ODi6qHJTZ5Bu1uAIoX+nuKezoXIUmxtFkbd1zcdYPlezwCbOnrM5wXK/m
	irC+Abamaoi/vqDtfKGzf5FDBGc7Zn9qgmgnA6uX308pb8N8zmg6JeOcGJle2y88W3chWJUCemP
	1vCEErD/+2eHQirwv8qbbGQcIWZg2CXNCq7mM3xwIUFe2+g==
X-Received: by 2002:a17:90b:1f8c:b0:359:8d70:c4e6 with SMTP id 98e67ed59e1d1-35a21e485e2mr8227102a91.1.1773563321208;
        Sun, 15 Mar 2026 01:28:41 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8c:b0:359:8d70:c4e6 with SMTP id 98e67ed59e1d1-35a21e485e2mr8227093a91.1.1773563320779;
        Sun, 15 Mar 2026 01:28:40 -0700 (PDT)
Received: from kernel-devel.tail62cea.ts.net ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b95822ca2sm579919a91.4.2026.03.15.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:28:40 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma: swiotlb: add KMSAN annotations to swiotlb_bounce()
Date: Sun, 15 Mar 2026 17:27:49 +0900
Message-ID: <20260315082750.2375581-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jZwSdcdFRB4BPLyV1zWUUi9X1EXyoYngx0rUiH_fpRY_1773563321
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When a device performs DMA to a bounce buffer, KMSAN is unaware of
the write and does not mark the data as initialized.  When
swiotlb_bounce() later copies the bounce buffer back to the original
buffer, memcpy propagates the uninitialized shadow to the original
buffer, causing false positive uninit-value reports.

Fix this by calling kmsan_unpoison_memory() on the bounce buffer
before copying it back in the DMA_FROM_DEVICE path, so that memcpy
naturally propagates initialized shadow to the destination.

Suggested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/CAG_fn=WUGta-paG1BgsGRoAR+fmuCgh3xo=R3XdzOt_-DqSdHw@mail.gmail.com/
Fixes: 7ade4f10779c ("dma: kmsan: unpoison DMA mappings")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 kernel/dma/swiotlb.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d8e6f1d889d5..9fd73700ddcf 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -30,6 +30,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 #include <linux/iommu-helper.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
@@ -901,10 +902,19 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 
 			local_irq_save(flags);
 			page = pfn_to_page(pfn);
-			if (dir == DMA_TO_DEVICE)
+			if (dir == DMA_TO_DEVICE) {
+				/*
+				 * Ideally, kmsan_check_highmem_page()
+				 * could be used here to detect infoleaks,
+				 * but callers may map uninitialized buffers
+				 * that will be written by the device,
+				 * causing false positives.
+				 */
 				memcpy_from_page(vaddr, page, offset, sz);
-			else
+			} else {
+				kmsan_unpoison_memory(vaddr, sz);
 				memcpy_to_page(page, offset, vaddr, sz);
+			}
 			local_irq_restore(flags);
 
 			size -= sz;
@@ -913,8 +923,15 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 			offset = 0;
 		}
 	} else if (dir == DMA_TO_DEVICE) {
+		/*
+		 * Ideally, kmsan_check_memory() could be used here to detect
+		 * infoleaks (uninitialized data being sent to device), but
+		 * callers may map uninitialized buffers that will be written
+		 * by the device, causing false positives.
+		 */
 		memcpy(vaddr, phys_to_virt(orig_addr), size);
 	} else {
+		kmsan_unpoison_memory(vaddr, size);
 		memcpy(phys_to_virt(orig_addr), vaddr, size);
 	}
 }
-- 
2.52.0

