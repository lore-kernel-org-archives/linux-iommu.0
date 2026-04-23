Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079137B028
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939257; cv=none; b=Z0xSh6SEpMwAOsxL78VnmFncbunWcgkjts3cbA6+PQPyMJrhzfcX8Nc4jmkT3fblI/3BeWYrmyZR24+iufl+5AoYuiMxm0ea+zajLjFqrdvMZompQoqQe0lmyESvdj1wKOaRVkJvpa5BfB2DCaRJCJbwXdHizSdfoCGnSYwlJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939257; c=relaxed/simple;
	bh=bfflzEHdpLESHwzPVr7kcu++Rfuj6zUYLaa4J7zWLPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D69paYYnUd7iQ5oI7mALuzrgtJK91VvekQ+1cW9rRT6JaQdQCNoXHIR1GErkZEVigYsJB8x3A48RnIc/5nGTy9dHmGkPSh4428qPR5WpjWyT5jWn0lj72derrDSGzgDmBNWMOkY4XgUVqwApnKl+LCblJY1VXaclJnNjjIYIT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXqHUEu1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXqHUEu1"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso3837011a91.0
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776939254; x=1777544054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D105fItJZxsqyXtCtVn6aQ3UIkkHqVrtT7Vq4lq6K4g=;
        b=mXqHUEu1CRcwaOJiw5dIWgTYXdBLigBxBhnYyoHBfeqywkR1UVpB98741IKY4O4vui
         T0aqzAibwD/Z0Xu0CbgxIhiwXUXnAheNCvEswzjkm9IAtTA8DEL+o3H8GAT5JGIJrLe2
         LMehc0eu3B7jmQyZunO+ORModEuo1DwV3/UU0iHCv1lo6iKVCIGQkGiszBGleY+Ft3J2
         e8gdCAI9Obpa4ZkUQ5rh4QRGqg9P2ky2V2Wx94y/CxZNHvLjnGNmFNpRC7wWLIy3mgSV
         5Z9GKhIRm3tsK7T6mYMBfDZhBFArghQcsZUywJDEaREnwqBzgZFdcYsGjq366fgPZfRs
         6Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939254; x=1777544054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D105fItJZxsqyXtCtVn6aQ3UIkkHqVrtT7Vq4lq6K4g=;
        b=XsDFZosKHyJH5QHV0/g/byn39kypZ7rwTBykRfNHG3z+4jZ+SupkGw6U/+hdrjNLvq
         kiSU9a9mObsjvP17f/t8hs8+TIOBr927qTjfqPqX5vaO+BOWICng+/Ln7NLbdm+UHaYq
         TRxp9uwHUNdcxs8zRnz77R/PFkFz9RR9qlNPdxEqdjP2ApKRERhQoqvf772PW7Q2+7AA
         Oqghrh9FYHlScm/9pibB9i+dPAO+gYYVxV58S9G7vy1iBIzDB8opwpSVve0PJ3KPMjiY
         +2dZqXdkfjI885M8m5pSR2vtO+q4LyfGJYg8Yaj1PRDCtX0p1wZCw64sDYWHH5X5IXWd
         DP2A==
X-Forwarded-Encrypted: i=1; AFNElJ/sNCaCGD/XYlfmbwY4l2tVw3DfRERHE89Lf7r7A0jLyXXnhvW9NOrerrBTVSXdO+wCMG/65w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx64oTVfpTrUS1w5cYLc/Zo8IGXZZxotomHhufI/gqTszlqIqxV
	jYDPyckExUoC8qEOrg0XvKo3b8rV+SKczPvjJiAqsdER5O1fl1Ag9rkwzDEkuGTo
X-Gm-Gg: AeBDievLWJNZ4fkLSwjZpemiKqOyjnSiS8BgjL7AHAVS6Jm7inLS/1+wOuL9/rMcnXF
	y/knMC3VasYCssW9TU47wKv9z/ilI7PIHOzhacYijZLhepU3E4UDz24hljojoOppSAye8697CVt
	AA4Li/UDfy2uVpMWD6yqNHlQZ2aWcF2gl3GyMlGf4c6YmJoSf6hkvr1Nj759Wh3eYSZ65lf5eTN
	wsJLpG+GyfDBuV3LrVTiflJRQJ4jKTte4JPjLdVALA3zaSvAsXXW9AWhJBQMkgH0rs+GCgGS2+/
	LR0n1WLEKnUgNpz7M+SNxxp9B/sEaEfg2KBls6URwBgBgR6wwdqK0hssRnPVNj072AbrBX7jtRD
	IPdHdT9rbeuLZtcLBksqGu8PMKcqshRqE4OxG87p7Qbm1VcgvpVOO2MOnvKKYjpPQGMWWKLAFx/
	VqnC0kE+nTvhM6Z2T22NBG0QOEVmLAS6v3uQ==
X-Received: by 2002:a17:90b:4b49:b0:35d:9560:3f09 with SMTP id 98e67ed59e1d1-361404b8efbmr26679621a91.24.1776939254431;
        Thu, 23 Apr 2026 03:14:14 -0700 (PDT)
Received: from fedora ([2401:4900:1cbc:314:9667:4972:a94c:125a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc5d94sm25275714a91.2.2026.04.23.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:14:14 -0700 (PDT)
From: avinash pal <avinashpal441@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	avinash pal <avinashpal441@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Giovanni Pancotti <giovanni.pancotti@example.com>
Subject: [PATCH stable 6.12 2/2] iommu/dma: sync IOTLB before releasing IOVA on sg unmap
Date: Thu, 23 Apr 2026 15:39:04 +0530
Message-ID: <20260423100904.5966-3-avinashpal441@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100904.5966-1-avinashpal441@gmail.com>
References: <20260423100904.5966-1-avinashpal441@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On the lazy-flush path, __iommu_dma_unmap_sg() calls free_iova_fast()
before iommu_iotlb_sync() has drained the old mapping from hardware.
A concurrent dma_map_sg() can then allocate the same IOVA and hit the
stale-PTE WARN_ON in __domain_mapping() / intel_iommu_map_pages():

    CPU 0 (unmap, lazy)              CPU 1 (map)
    ───────────────────              ─────────────────────────────
    iommu_unmap(iova)
    free_iova_fast(iova)  ← live!
                                     alloc_iova_fast() → same iova
                                     __domain_mapping()
                                       dma_pte_present() == true ← WARN

Fix: insert iommu_iotlb_sync() immediately before free_iova_fast() on
the lazy path so the IOTLB is fully drained before IOVA reuse.

The strict-mode path already serialises here; this closes the same gap
for lazy/deferred flushing (regression introduced between v6.12.74 and
v6.12.76 — confirmed by reporter).

Reported-by: Giovanni Pancotti <giovanni.pancotti@example.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221389
Fixes: <run: git log v6.12.74..v6.12.76 -- drivers/iommu/dma-iommu.c>
Cc: stable@vger.kernel.org
Signed-off-by: avinash pal <avinashpal441@gmail.com>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0f0caf590..90071cf4a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -159,6 +159,15 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
 			break;
 
 		iommu_put_pages_list(&fq->entries[idx].freelist);
+/*
+ * Bug fix (Bugzilla #221389, regression v6.12.75/v6.12.76):
+ * Drain the IOTLB before handing the IOVA back to the allocator.
+ * On the lazy-flush path, free_iova_fast() makes the IOVA
+ * immediately reusable.  A concurrent map() call can then receive
+ * the same IOVA while the old PTE is still live in hardware,
+ * triggering a stale-PTE WARN in __domain_mapping().
+ */
+iommu_iotlb_sync(domain, &iotlb_gather);
 		free_iova_fast(&cookie->iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
-- 
2.53.0

