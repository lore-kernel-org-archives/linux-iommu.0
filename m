Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB63B217F27
	for <iommu@lists.linux.dev>; Sat, 14 Feb 2026 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771056595; cv=none; b=bQaA1zBzQFUcBGBX2evkNaOCAakwrEY439ofOA7rlM5dCfUtvLln3B/dIze1rvG//Bt8uzcYIy2ZjwExCu+706ZT3ZW6KS2OuMiofZ+zzfsJLbO8zeLZmKKGTMaGp3kAp6iDeHyBT/FMxZHMuQPsOuOBCJ2TQnzDeyN+l7RA8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771056595; c=relaxed/simple;
	bh=yZJwP+nsAfnT8DMGk/jL6ONa/8beKhsUbC/4OfiH+UI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fWE5EZ9ppx/DgF26Ddw9PPMK0hBleqGpWX+QooR75RDL+10pUOVg94knRIIU2UpjYHLi5M+Mmk8nxjwGiptJhpMDCep+ISUjGXSzyyBgzFVroBHnstB7NCnnRaW8DUO7Lx9WgsN4P/gZ9gZCRBrIZlFBrrfFA+41SNNdorL8j7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liulynn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RAowLXZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liulynn.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RAowLXZ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6e1e748213so1086029a12.2
        for <iommu@lists.linux.dev>; Sat, 14 Feb 2026 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771056594; x=1771661394; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JJxsPsPKNTjfv6PsB/f5RXxGICW3iUFDwWM6i7w1qdo=;
        b=0RAowLXZCNHuDV5YLv0rwe7PTTwcOD9Hey3nsZvYMNiABIGpjD350Q7vb+z2U/Vyya
         5Lf2FzXZpNyv1n87RP7CQjoN5yE1PQXnobqMQJejTT5cR27t/C6wp60ahHsxf+9AE6tt
         kQwNOcQIr8PryohzRcMUNFyIAPnVxSkXy++K8XKTGQHtbmE/kHsgiZqUpuABXyyN2Igw
         41HL+okzBmyK2AwwwPrA+ucCcjPlPUwKg9U0hNpxZnd+rE/pLhQkWdjHqXvTAW/awwlA
         hJLBzqEb7PGDS0E+aokNJJRLeVz7UQOX065Elur2zhlMfmq3hgq5GxrAzaH+M2peC/CO
         rGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771056594; x=1771661394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJxsPsPKNTjfv6PsB/f5RXxGICW3iUFDwWM6i7w1qdo=;
        b=rlK8xv21JuxAKvLbi+GkXtkwd+aFC7QK/FXz2Rze4XDk2kG6E7wXuzW0h3/ZCZBXQI
         9/9KIks0QoEgU441i27uymX5oi1Gahd0lEmoMcLkzw69fmD6/06Wu+qy2bkoRA10sBhN
         +ZmNQxsVZb1R3bpiI8KSoWaX/pyaa0Fn+Jsud/qZ9CIdOsjVu0d2i58l1n01C5BOHAul
         j8uAGN0lejZ8gMgGhmiJ7KcpquHEZ1HAyQQX9c0JXArBAYuoCR5JwCtZXzuSj7yLHC3W
         mOnMg/Wk4xEazBEWdHBAgoLmrIJYLBzs/47n+m6vRwj3hzPayBUKmYIKAYhnmt1G8hsw
         yYXQ==
X-Gm-Message-State: AOJu0YxN+Da7mXF2qZmnkVLsnP3kqTCYq561pZUjOHSqA8qocn3mMLj4
	PwXohbl/UCS9jfyAJx+cY8PcRvDaoswemXn/gCTxn4Et9wo00uBWSQyvB6rRAUhaofam4Xu+uz6
	TXoFZJ3GM6A==
X-Received: from pgcv9.prod.google.com ([2002:a05:6a02:5309:b0:bd9:a349:94a3])
 (user=liulynn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9148:b0:37e:4319:d7c9
 with SMTP id adf61e73a8af0-3946c911088mr4095339637.77.1771056593999; Sat, 14
 Feb 2026 00:09:53 -0800 (PST)
Date: Sat, 14 Feb 2026 08:09:19 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260214080919.390846-1-liulynn@google.com>
Subject: [PATCH] iommu/iova: Add NULL check in iova_magazine_free()
From: Lynn Liu <liulynn@google.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lynn <liulynn@google.com>
Content-Type: text/plain; charset="UTF-8"

From: lynn <liulynn@google.com>

When iova_domain_init_rcaches() fails to allocate an iova_magazine
during the initialization of per-cpu rcaches, it jumps to out_err and
calls free_iova_rcaches() for cleanup.

In free_iova_rcaches(), the code iterates through all possible CPUs to
free both cpu_rcache->loaded and cpu_rcache->prev. However, if the
original allocation failed mid-way through the CPU loop, the pointers
for the remaining CPUs remain NULL.

Since kmem_cache_free() does not explicitly handle NULL pointers like
kfree() does, passing these NULL pointers leads to a kernel paging
request fault.

Add a NULL check in iova_magazine_free() to safely handle partially
initialized rcaches in error paths.

Signed-off-by: lynn <liulynn@google.com>
---
 drivers/iommu/iova.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 18f839721813..e026be5e068b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -611,7 +611,8 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 
 static void iova_magazine_free(struct iova_magazine *mag)
 {
-	kmem_cache_free(iova_magazine_cache, mag);
+	if (mag)
+		kmem_cache_free(iova_magazine_cache, mag);
 }
 
 static void
-- 
2.53.0.273.g2a3d683680-goog

