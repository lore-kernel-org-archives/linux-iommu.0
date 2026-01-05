Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D2227EA8
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640074; cv=none; b=SSxr2qA5KnLCmOjf3/IiRDMpSeRbaFlXFfn5XgdeAFoUqkQmhb+ey1WKNpYvXhTbpv30hjpP/hMGtR9uAmEfXyepucpIlbadRp5f4R9jp1hciHOx0f5j7cVJqCaqgr8EZO5QORQGUOHMz4aEFi54SE5X8uPwTJGSw4pRe+So4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640074; c=relaxed/simple;
	bh=UBwxbLdy23sDmct+07935iPu/FEqzhV/xHgYq/exls0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xp4xcZhma055YyiJLQ4SEOuPaY5NGAs7XQp7or3akO3w8ATpY04nQ2Bsp36oGGgqLe7htC48RU7YxbLxWLiD/uBl/JjOmq+sPKgaISh8jRHQZi+kpQPxDwRSd4gh7NpZoMLw315Mp4a9e8YHTzbTxvt5k/MEVC0rQrNqG9/LzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hcw70MAO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hcw70MAO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0a4b748a0so3859155ad.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767640072; x=1768244872; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HMUhWNvNwkRyVLnb3ImgC6yPPp9LfTSzDU0MStcOMWk=;
        b=Hcw70MAOu6xWEkQB/RZl+lIbFq3ezUr9se+2i5HHUwxpcECHnwQcfQjHblUHe36mK1
         zw3tVPt9Mm2f6GrttK9b+aIvLbSoh2plhdgqmGhio1vVOdKSaJp7KFYArFUOEV3MrmsN
         HcDCUfMwNY/2tNZVOUQ/RXd2pwRtBGcfdLIftLVsQkNkmD0nsxiVemBDRE7RUU4V//+0
         ZivQEhTyy5XecNNIJauyDU5AykxSG9t5f2H0725TJJA3MRlueSWwwtoKyBrtGRibD2Wz
         IqDBPtkRU84WRFE1AuuHmrv7tuUhRyrTZz/RvIbWoKsOJd9AB4a/sitBmuLZfGemKKRA
         fdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767640072; x=1768244872;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMUhWNvNwkRyVLnb3ImgC6yPPp9LfTSzDU0MStcOMWk=;
        b=pRse2WL4a6SKYEW6utWPSsrf+G5qVk4Qa0atnRI5DLG+dBtL5OcEC2Bl9vGvYFrSfW
         bl3TH2Z/eAyshpJkUMGG8dMwJv1Y+BCc9p+kufgFqDtHFzgX/K3FG8pcxMEce353BN/v
         fjhlv+8jpi4dTfSURPsbU2ae6lRDYutm/AwdYCorhUbx05eF/2y6nptfpruByDjZsMEU
         yDQS3uiFu9RN2HgKpgXabp9z5LIEzeiPF46wgmLHSc/jmVGgrMoY5XtLpvwPOWhh03jS
         D8oKwGAok+fH60qmDTdKobqGtK7/xPcC5knV5WrBNafa8yYz+E4p4ZeugX0gBbs2Jn5f
         rt6g==
X-Forwarded-Encrypted: i=1; AJvYcCXnepTZw5cnQKws7xLVT31xmNLyQzZqeu/lpcxn2zwpwgY+n1lS2XPjY4C8iPJ3VmmQW8sOIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCmJgIzcc88XWyDaQmwVNkbxNZgolIgelyUl1VCurKkQtNhV1L
	Q/6PVQixF4tjCB1uau7RzlxzwNiSYYrWNmfpt7/5E7LDXSDD600sFBzKqA1T+BYGge1A4zztCzh
	HirONOgEg4PADwQ==
X-Google-Smtp-Source: AGHT+IFXkKMfu90AhEtBHrwsjvhw5RMzSf8+LNAkWKP65vHzPOnSUIr1CKL+ik53m3qth7N8dqIaroK82/UHYw==
X-Received: from dlbrx15.prod.google.com ([2002:a05:7022:170f:b0:11d:cfa0:5ddf])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4197:b0:11b:78e6:8323 with SMTP id a92af1059eb24-121f18fabd3mr307956c88.37.1767640071903;
 Mon, 05 Jan 2026 11:07:51 -0800 (PST)
Date: Mon,  5 Jan 2026 19:07:46 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
Message-ID: <20260105190747.625082-1-cmllamas@google.com>
Subject: [PATCH] iommu/sva: include mmu_notifier.h header
From: Carlos Llamas <cmllamas@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

A call to mmu_notifier_arch_invalidate_secondary_tlbs() was introduced
in commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for
kernel address space") but without explicitly adding its corresponding
header file <linux/mmu_notifier.h>. This was evidenced while trying to
enable compile testing support for IOMMU_SVA:

   config IOMMU_SVA
          select IOMMU_MM_DATA
  -       bool
  +       bool "Shared Virtual Addressing" if COMPILE_TEST

The thing is for certain architectures this header file is indirectly
included via <asm/tlbflush.h>. However, for others such as 32-bit arm
the header is missing and it results in a build failure:

  $ make ARCH=arm allmodconfig
  [...]
  drivers/iommu/iommu-sva.c:340:3: error: call to undeclared function 'mmu_notifier_arch_invalidate_secondary_tlbs' [...]
    340 |  mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
        |  ^

Fix this by including the appropriate header file.

Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/iommu/iommu-sva.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index d236aef80a8d..e1e63c2be82b 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -3,6 +3,7 @@
  * Helpers for IOMMU drivers implementing SVA
  */
 #include <linux/mmu_context.h>
+#include <linux/mmu_notifier.h>
 #include <linux/mutex.h>
 #include <linux/sched/mm.h>
 #include <linux/iommu.h>
-- 
2.52.0.358.g0dd7633a29-goog

