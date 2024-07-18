Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BC12C7FB
	for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313512; cv=none; b=vDR0na4E9MehiDiusC45+ZuFXAuHRI4fR0qavFPOIgR8hLxdkO+JcoQgHwf7fMJH5YYkqKSJk3HxFk7B4YZkPBlA44go1AGBs4WcVyxQ48ndcJGkfqmTJFYZEoxQBgKqJ+ARU/XzFUEcnREM+cgdkS0aJ3mCSvdk3zEAA0y1jRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313512; c=relaxed/simple;
	bh=655M84QOxIyxhEgghQD1hLmEjBzleOVMlzXO+JBPNQk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JDGbR8X6LF1MHiEA7UlqpWTYUB6tI48EBpzTUg1GBshwuCJmG5iuGv7hlQASyYVDrcxtPKsySuut8pi6r+gRqQkG+vc3da1lZ4zw6NlGAZEZjRnSkYWzwjzDm4QO8vu10Kjep20dbVJp+tshv4i7B9Ek/2hUtT24uqP7axsZxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rlance.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGyGcXUU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rlance.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGyGcXUU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a694ba5aso2059224276.3
        for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721313510; x=1721918310; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=26w0UW+1YCoqkbV2Ly2uC/QIznS3C//f6tTnQb48MMs=;
        b=xGyGcXUUNlnRM6WDoD1py/2bvsuoOG1JEwzdl5qKvBi+/vqhEPHNkWRQpvN8BOd+ij
         G3KwLQs+wVnyl0PxX42yV51LA8ALgrBRJ0BxwJffHBwP09vsORMzIA7F1v/JtwXXviU7
         v/TGAenGRMhvv05Vk746kGylhdl9CHZmbyOO+ZROa0CzQByMWwXD0ol8S4QAO3zb6CdW
         opWPWAtvIdZFDoMvyd21c/vgMVXf/0Cy9Pu4xLxRoEZsMOwlGSvUym3klHpiEnmC49/7
         DSzbwds2aoO/2moT9qrvUmY3H5/6O66OEYiqPnux3DC34oq/WDZDyM7p96goLX0zeC3h
         dIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721313510; x=1721918310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26w0UW+1YCoqkbV2Ly2uC/QIznS3C//f6tTnQb48MMs=;
        b=m1C7j+hlysHJQ27IeqvaPmyhCrrZfADgL6XC3kPvpVoX9iTrAe53wStjb5TqUD1TLo
         UvOnHpIEDMy2WIZIp1IbxT5AVqANVP4B+L8FaxCAIOaZKnLB6jCZQL5IBVnmHKL0GZ7p
         kzhK7wUt0M1LS/lsAx+PkAlU/NAN1S9KpHqWhFTytkOEI1k99SSAdW71Ylsf/qZa3w+M
         /H2+UHHlwTlgHRoEuRLXutnHMwR+m4MRiLOKynh6laL9ump9yT6gT3C12HDVZpyxR+uD
         8Cu8o0e26zSa86xxOx3bRGD0894/mWAENkX1BrJ2qR/k0ICy04DnaolgKJBeVqQJcYJ0
         Y6kw==
X-Forwarded-Encrypted: i=1; AJvYcCVoQNrHOLHzWOKYryIFuXb9C5VretLq/VLtPEZ+T+oXfntZVI8zzMjkT+wsarG76mgaO1OtZ4CWIsLbeJnhd6A1xMp05dI=
X-Gm-Message-State: AOJu0YwO0T+0V+My3MxaHDIWo1429kJfA2jYM17zo+PqXmmI0kV2uJnM
	MqLyoo3r8c4wtp6xPNDYeEay5OAiOoqz1rnclxUROKtP4c5WcOLfGHwXmHyBUREMdFkAstqCR0b
	s
X-Google-Smtp-Source: AGHT+IFdATgTwlUIdzd8N4xyCNRjP+4RhDdjX1qf4WtX7NKzxrm/wADaSqRSdqoE4++w4IKKoPc0nUNNz8c=
X-Received: from rlance1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2694])
 (user=rlance job=sendgmr) by 2002:a05:6902:1107:b0:e03:a22c:df5 with SMTP id
 3f1490d57ef6-e05febf9266mr4705276.7.1721313510005; Thu, 18 Jul 2024 07:38:30
 -0700 (PDT)
Date: Thu, 18 Jul 2024 14:38:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240718143824.3729715-1-rlance@google.com>
Subject: [PATCH] dma: fix call order in dmam_free_coherent
From: Lance Richardson <rlance@google.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, iommu@lists.linux.dev, 
	David Rientjes <rientjes@google.com>, Lance Richardson <rlance@google.com>
Content-Type: text/plain; charset="UTF-8"

dmam_free_coherent() frees a DMA allocation, which makes the
freed vaddr available for reuse, then calls devres_destroy()
to remove and free the data structure used to track the DMA
allocation. Between the two calls, it is possible for a
concurrent task to make an allocation with the same vaddr
and add it to the devres list.

If this happens, there will be two entries in the devres list
with the same vaddr and devres_destroy() can free the wrong
entry, triggering the WARN_ON() in dmam_match.

Fix by destroying the devres entry before freeing the DMA
allocation.

Tested:
  kokonut //net/encryption
    http://sponge2/b9145fe6-0f72-4325-ac2f-a84d81075b03

Fixes: 9ac7849e35f7 ("devres: device resource management")
Signed-off-by: Lance Richardson <rlance@google.com>
---
 kernel/dma/mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 98e3d873792e..0492fb58be7b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -59,8 +59,8 @@ void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
 {
 	struct dma_devres match_data = { size, vaddr, dma_handle };
 
-	dma_free_coherent(dev, size, vaddr, dma_handle);
 	WARN_ON(devres_destroy(dev, dmam_release, dmam_match, &match_data));
+	dma_free_coherent(dev, size, vaddr, dma_handle);
 }
 EXPORT_SYMBOL(dmam_free_coherent);
 
-- 
2.45.2.993.g49e7a77208-goog

