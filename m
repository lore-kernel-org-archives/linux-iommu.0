Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7A407CF1
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240189; cv=none; b=ba8Bh7qATVBj2VQyCa5Jv4P6S6wG1BbQydgJY7iCMESP4j99z6HpYFyz35AWhBz6wZfoMY7vIsFHUEj8xPcVkg7aO6FXey5YX1HUwXx9nYzgcpM/Aatc7GuBBiOd1tqmA3NZTQtkBImpI+49x0bCccl69iyF+2L0ldN1R26OOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240189; c=relaxed/simple;
	bh=bxdeOguzyBUWg5FmS/ooCmP0SBlbym7Li6q+GIcu2c0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKRfwqtn4a62RCchW+iknC7uflj8rose997kNKEdqduDq4kHMj+D6SitREh6eFdmLXx2uCiwWquixoQ+is60qhA3r6Vjwb6/4TTvyGYy3OXJ4xbK5VEYTgpQ4rMDNufOFzp9iXo/3ZVXt+nVxdioWTarijTU3wxRaCdW/x79dy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCKnjxCv; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCKnjxCv"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4957287363bso11729535e9.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790240186; x=1790844986; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvYNwuZspYmqJYkW4Kvv5dJobx9eOS6NsDNgvr2VGvU=;
        b=KCKnjxCvZiesAr/NYLeVrjFRVQDXnEtFdHSVFhQI/2v72eaCfAS4+RHMSbagK9uhZ1
         cgHZbocFOyYAt/4BXQH9Dxj13q+zNR2YJK6obYOsTXQBTh6cWi0TJLHF8iqxkRun09+6
         rkYttWfyayLxXTrJZ3wvPNbm3Jct2FNCV6Uxc8+GTsuNVWJolSw8JELesP2Na7JeWx0B
         gamVr0KkKmEjSEUidLcJlRiHhG4K4l71JRMwVZ8JpBrW3TMoLNmyKV0hr4S353O7+Deq
         Jb4AnXBwbO8LH5dHv5sXvrRVcZ8QPZHQVsg6K8xv8dP86XmIRrxnIdMmtU/XtdMZ0EIC
         e7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240186; x=1790844986;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvYNwuZspYmqJYkW4Kvv5dJobx9eOS6NsDNgvr2VGvU=;
        b=ubaqTKPw6IdUWREjvJwLAeLsa0VbETq4HSKVjhnRhJPb+00qduW0vivR97wuV0AkDr
         XXglLm6P7GvIiyRDODurNoNm9hBZmpee0CO3yGdc8YNr/oLEDHGAfHOOJeB7pWSciofI
         g1DA2DOrO4ZV+Nmi+cuWWV41sP4pS967uONtn19S3SgEHx451T3DKiVOnsaXqCOdiwsl
         ecmm4SxxPUYXzbkQ8j4xS2TspDantE5l3tJi+ela0fK3yiErLN0kr6us3IWVB/0x+txz
         vZF14Ihsnz8DLa5YlezLyWR0+2y4VeTCwfJirzbcTJmPYJbtjrprA67EqRTgh3hadJSx
         inWA==
X-Forwarded-Encrypted: i=1; AKwUvByMZUUvSz+lyCLY/mc2+rOnYU1ONro9/YjmuNXE7bKpZLvL1fjT4jJYpe46LP5gKb1hrIgsng==@lists.linux.dev
X-Gm-Message-State: AFuF++mebaI8xaFsiWyqrEnn3tYxvAuSQVGvbbJcC4hz2a6KofCYZMKa
	DNONmR2rpIS0RolJ3T1V16jWJtE9z5mEmGzDwo0vT63zaNJMlSmSqg/U4Ebug6MwUaZsQupNyOj
	bQYeboyl66gLYkw==
X-Received: from wrbft16.prod.google.com ([2002:a05:6000:2b10:b0:47f:74c9:84ee])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:310a:b0:486:f980:2367 with SMTP id ffacd0b85a97d-488716aaa53mr3150067f8f.48.1790240185585;
 Thu, 24 Sep 2026 01:56:25 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:56:12 +0000
In-Reply-To: <20260924085616.300650-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260924085616.300650-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924085616.300650-2-smostafa@google.com>
Subject: [PATCH v2 1/5] iommu/arm-smmu-v3: Ensure L2 tables are visible before
 L1 ptrs
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Commit 6fabce53f6b9 ("iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update")
adds a dma_wmb() to arm_smmu_write_entry() to make sure stream tables
and context descriptors are observed first.

However, STE L1 table descriptors are configured directly
via WRITE_ONCE(), where before that they were zeroed with memset()
inside dma_direct_alloc() then written to abort in via memset() also
in arm_smmu_init_initial_stes() without a barrier in both cases which
means that the SMMUv3 can observe the allocated table before the
written descriptors causing it to fetch random data.

Similarly in arm_smmu_write_cd_l1_desc() where the L1 CD is written
after dma_alloc_coherent() with no barriers.

Add dma_wmb() in both cases.

Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")
Reported-by: Sashiko <>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..494bbfd2869f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1515,6 +1515,9 @@ static void arm_smmu_write_cd_l1_desc(struct arm_smmu_cdtab_l1 *dst,
 {
 	u64 val = (l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) | CTXDESC_L1_DESC_V;
 
+	/* Ensure the zero-cleared L2 table is fully visible. */
+	dma_wmb();
+
 	/* The HW has 64 bit atomicity with stores to the L2 CD table */
 	WRITE_ONCE(dst->l2ptr, cpu_to_le64(val));
 }
@@ -1804,6 +1807,9 @@ static void arm_smmu_write_strtab_l1_desc(struct arm_smmu_strtab_l1 *dst,
 	val |= FIELD_PREP(STRTAB_L1_DESC_SPAN, STRTAB_SPLIT + 1);
 	val |= l2ptr_dma & STRTAB_L1_DESC_L2PTR_MASK;
 
+	/* Ensure the new L2 table is fully visible. */
+	dma_wmb();
+
 	/* The HW has 64 bit atomicity with stores to the L2 STE table */
 	WRITE_ONCE(dst->l2ptr, cpu_to_le64(val));
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

