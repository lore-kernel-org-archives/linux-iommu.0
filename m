Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11378F4B
	for <iommu@lists.linux.dev>; Sun, 26 Jan 2025 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737882564; cv=none; b=KeiWH/hwuhDq4QRuw9eV+sFyGLLTrqL1cnuFguFXi8GbzpechEHPMmXZzzC5egUdD3HVrIUJx2iYkcKRq3NsnvvqQDEhlIu1aQ9cb6u7BqnP/57GD3crk/Bso94za/Mc31n1h/K39FO+3ilyEWeWZC2sL8wJznYMWYXLWKzg1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737882564; c=relaxed/simple;
	bh=YaGoWGpsklGIQt67nkm2fqrq/O3GNFyu96dmoP7FMbA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kJQrBP9xzUwrz7Xq1MNkIk6NdNVNF8jtSIX5cQysRpqwWBKn3h5RELfb3WZCyJFXoL4utUCJS1cz7Xt3u0Pgq9/Sa8By0cR1jZOxMPdckysNomRWblpQK1CBkgwJDhN46MHlUV6XJarJZ7r7srSPFIxNldDjzw4Y45sp1M2Qco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+0OiaH0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+0OiaH0"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso829102a91.3
        for <iommu@lists.linux.dev>; Sun, 26 Jan 2025 01:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737882562; x=1738487362; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+cfvIoxVPtQPbBiDtAArxp4pruZxdup7yQD95mYg5w=;
        b=R+0OiaH0+bB4OgXt9Z5mTZjLsPyzwv+FOOMcD2CX9/Uph+3CEXHo7R3NdWtW+uqMl0
         xcLdbMTOOKko42ktv0Tn79DUg9fUVk768fgyfusUtlUy1h6+xhOW1K+mmV/AjgaufWoz
         EnaDv63Yt3+3GdU6tJtykgHndbS2j6LG3u2fQV2ryRWY3gW+HcDlT8KzEJisrvzimB8u
         mqqhXbIzBpNF4n6kWYB7fUZQX9jcxYIDeKH2WfABuOnodksjg1WF4t2BEKiqv0CLYee6
         uXaLI1Uf0YlQnm5BN+6PltGfBg7RA6EmZXa4r2mgCku7TgdP8KSJypk7fX1zvsRT+FSz
         OJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737882562; x=1738487362;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+cfvIoxVPtQPbBiDtAArxp4pruZxdup7yQD95mYg5w=;
        b=RxxDAFikiw1H3fD1pL3FAE8HhdjOW1rl3J7aMqMUIKPesuK6M9bL/rAzHmEvYIi9dk
         uF/xLIYwZ/sJmMRcM/nXqnGm8GFTfmheBpZ6foQsW2Cew/cMlhUpA2qQZQ5uElEwhSfd
         qvCCilgQ8G0PtfS2bu4bq9wIMiKMruJmucrtHczfys5pE5QWEtBHDATmMMJl4mRogUVA
         r/Tey3Edi+569HQ63q0G9q751JYo4SP96XYp3aRUaVyEpkfk2HxIMRDmQH/wI3KTyUr1
         e4jiuincktqsvBStJ68d5eRz3NO0pwm9ZnzHJNkICIBzlS5+vKovkdfrPhLZltCIlYIP
         jW+w==
X-Forwarded-Encrypted: i=1; AJvYcCW/5Zl7hSKOjpLhxzau/wB0GHCX3IwrBWq8nA8FpSFafucHNGwhwuyzjo3p/bVv9E0t948U8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSevF5Qev84S/tbBARlP28aQF2aeJUAoiWDCCQ31SKa5ApibMm
	kbu+3H8ZtxNksq5oGI8pfR1oAY+R0gPeESoKDboKdI//mZAwo7APKQUtB+yo/qqZJkCtHdYdfV/
	dzp94/fGyeP8SaDY6isbpoBIKUbo=
X-Gm-Gg: ASbGncu8lnjQ/692nvqB2nXigbca3ttmZz65xz5q8korOW9uEwKStMwbpvkMvDzJs7F
	jUYUkP3HPnr90azBtjNnGMV0IO2HQ8ZOuNY21gbOuCTRg/R9lDBaye+wvNV4mrr827NDrdyGauD
	ydQctmL2ACw2LObimEVbo=
X-Google-Smtp-Source: AGHT+IGyFrPT4kR55B4ZMMZHTE8tGSsiEWF19KzvgoA/wX6bcBPgwPkzKXnYGeJ3GAz1YYzHx47vq+dmkRrs5wTKm9A=
X-Received: by 2002:a17:90b:6c3:b0:2f2:a9bd:afe9 with SMTP id
 98e67ed59e1d1-2f782c562e7mr19339344a91.2.1737882562298; Sun, 26 Jan 2025
 01:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Dima Stepanov <dstepanov.src@gmail.com>
Date: Sun, 26 Jan 2025 10:09:10 +0100
X-Gm-Features: AWEUYZm5hLwacDRU2jedBsltQ2YaAUYDFf65Lzvj2nTxQ-1bOx2-UciHK0b6pYs
Message-ID: <CAEHp+Gasm2ZuYPusn1ZsMuePpjV0atutVGTr9n3-DT=tQODYkQ@mail.gmail.com>
Subject: [PATCH] kernel/dma: dma_common_find_pages returns pages for requested address
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Dima Stepanov <dstepanov.src@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Recently hit an issue on an attempt to mmap allocated DMA memory to the
user space. It isn't the case for any device, but only if dma_mmap_attrs
call will use the iommu_dma_mmap() function as a backend.
If the kernel address (cpu_addr) passed to the iommu_dma_mmap function
is the same as returned by allocator (dma_alloc_coherent) then memory
will be mapped correctly. But if the address passed is inside the
allocated region, then the mapping in the user space will still refer
to the start of the region and not to the middle of it.

The reason for it is the dma_common_find_pages() call, which returns the
very first page of the vm structure regardless of the cpu_addr passed.

The idea for the fix is to return not the first page in the vm
structure, but the page related to the requested cpu_addr.

Signed-off-by: Dima Stepanov <dstepanov.src@gmail.com>
---
 kernel/dma/remap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 9e2afad1c615..238fbf2821a6 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -9,12 +9,15 @@
 struct page **dma_common_find_pages(void *cpu_addr)
 {
     struct vm_struct *area = find_vm_area(cpu_addr);
+    int i;

     if (!area || !(area->flags & VM_DMA_COHERENT))
         return NULL;
     WARN(area->flags != VM_DMA_COHERENT,
          "unexpected flags in area: %p\n", cpu_addr);
-    return area->pages;
+    i = (PAGE_ALIGN((uintptr_t)cpu_addr) - (uintptr_t)area->addr) >>
PAGE_SHIFT;
+
+    return &area->pages[i];
 }

 /*
-- 
2.43.0
