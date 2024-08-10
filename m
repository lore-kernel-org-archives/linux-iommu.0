Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF049620
	for <iommu@lists.linux.dev>; Sat, 10 Aug 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251556; cv=none; b=HzYqLnWiDv2ysJqNELLpeYC6TKzZ/uENXxqwVJuslrQVYo6xV8MiZRFk6WDJYLpdrzZHjriU1RNFqD9VXhKCc46jkmh6cdhK3CPtKwdwRD6XlMh6aM0yRHMBzrc/bCIbS+wZB4Fx6ctiWsbanM1HPZwSD2xNdikuzuJLugpSB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251556; c=relaxed/simple;
	bh=Qd7PQGlgqKWRuWWjokUhPdESXuWBLnqq7/eOi/nr0rQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m1cRdANXjWY3Nwk/KtAMVUYmCNXjz4irpEUbrsz6yoR0QvwZEuId9QRLvXQlPNUXhofA4bcH5ijonIBstNVmNR5KU8kpvAlh39dhPwDc2m0QDFpuimNxX2Iq+H08hkogsJMLSSL0I241KWvOxdQZYfCbcJRKEGSpiXsUlrctwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qX90QdoW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qX90QdoW"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0be2c7c34dso4070458276.2
        for <iommu@lists.linux.dev>; Fri, 09 Aug 2024 17:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723251554; x=1723856354; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hzRe7SJD/obU3/qfFI0GbsgavYc/p8tTU00CB2noSOQ=;
        b=qX90QdoWQJUxr3sdN//OMgw8UuAfxIVSGicTp+cS23jH3yk8JUIjdi9Shqo7pl2jCl
         kvooN/v8F5lKpyRnRtYX04cDMAj/CD58B5ybTl3FfXEqf+QSx+qNgQC2t9WLAskXb3qs
         wH0BKTvAX68Jro1o70QCiH5/FcFRIiN5nU2BNODYjatBA1updvPJN4oiyfB7n3gpVNyV
         BlYz1gElx7BRLan+XsTyR9RqHwFyLEb9rGjwzblGWRrzhYoHAhldz0fGakjTiRlRzX9w
         W+5KCU+axVxsZxD0qVcedsncQNVFKU52Yc+vRGtWYkc84J64ryWNGEjHEAdigXJIBAlu
         LlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723251554; x=1723856354;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzRe7SJD/obU3/qfFI0GbsgavYc/p8tTU00CB2noSOQ=;
        b=wvSo6ILCQqEfnn16FsWkf0KJR6GYKqVRjLL4HrtfJZIzFz8hTKIfusppPe0hRXV1oF
         23vUeyWmpj4FfXC7VnGwSCPEHxWoi+YmHcVerhI97rDPPLiIKrWToB0SMbWP1ADm/9EV
         WDHVDFax5ysffb3yJhUgAuZZi2ftMHOEVwlFCPbgDqGsUQ9IcFyUDKmnOM9YIErqorke
         m2elKUV6WRQPC+iWhJ2KBumLkqTtIrZDu5E2EiDcCFRHnBdGUMipjLZaWEkDFdTeE1Fg
         ig3aUw059y+M4yFsVg6iSJXc8FeQYaQDDDGz1LGWMVorErEASiX0kf6rKonG7lPcyk2u
         kvuQ==
X-Gm-Message-State: AOJu0Yxba+b6zWcsmXQnYph/dsSFZ4kSkLPiS7VXM6z/0x1bOOx9Mxh7
	53g/FREs185u01GrtZpV8FRENTrjOjBdK4tyrArPuawgnpj+p8JEdfp80NzlfpNFpgknAwH8nLK
	fpl7wzbBg8zwJRT4eNQ==
X-Google-Smtp-Source: AGHT+IHD0Iz9jlKUFUJREyIgq4IGjnZvc8Lz0nEksZRzwjg7ycn2KRHYS2pQ8au66FNFZ3hf1c2NXmzyd8oafA1x
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a5b:c4b:0:b0:e0b:f684:e972 with SMTP id
 3f1490d57ef6-e0eb9a32f37mr29248276.12.1723251553634; Fri, 09 Aug 2024
 17:59:13 -0700 (PDT)
Date: Sat, 10 Aug 2024 00:59:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240810005911.684644-1-yosryahmed@google.com>
Subject: [PATCH] dma-mapping: use bit masking to check VM_DMA_COHERENT
From: Yosry Ahmed <yosryahmed@google.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Reiji Watanabe <reijiw@google.com>, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In dma_common_find_pages(), area->flags are compared directly with
VM_DMA_COHERENT. This works because VM_DMA_COHERENT is the only set
flag.

During development of a new feature (ASI [1]), a new VM flag is
introduced, and that flag can be injected into VM_DMA_COHERENT mappings
(among others).  The presence of that flag caused
dma_common_find_pages() to return NULL for VM_DMA_COHERENT addresses,
leading to a lot of problems ending in crashing during boot. It took a
bit of time to figure this problem out.

It was a mistake to inject a VM flag to begin with, but it took a
significant amount of debugging to figure out the problem. Most users of
area->flags use bitmasking rather than equivalency to check for flags.
Update dma_common_find_pages() and dma_common_free_remap() to do the
same, which would have avoided the boot crashing. Instead, add a warning
in dma_common_find_pages() if any extra VM flags are set to catch such
problems more easily during development.

No functional change intended.

[1]https://lore.kernel.org/lkml/20240712-asi-rfc-24-v1-0-144b319a40d8@google.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/dma/remap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 27596f3b4aef3..9e2afad1c6152 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -10,8 +10,10 @@ struct page **dma_common_find_pages(void *cpu_addr)
 {
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
-	if (!area || area->flags != VM_DMA_COHERENT)
+	if (!area || !(area->flags & VM_DMA_COHERENT))
 		return NULL;
+	WARN(area->flags != VM_DMA_COHERENT,
+	     "unexpected flags in area: %p\n", cpu_addr);
 	return area->pages;
 }
 
@@ -61,7 +63,7 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
 {
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
-	if (!area || area->flags != VM_DMA_COHERENT) {
+	if (!area || !(area->flags & VM_DMA_COHERENT)) {
 		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
 		return;
 	}
-- 
2.46.0.76.ge559c4bf1a-goog

