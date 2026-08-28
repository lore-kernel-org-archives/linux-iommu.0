Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B9221FB4
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921659; cv=none; b=SmH7sz83x30b1IIsicIfMYaiUgNVD43LnPQIrWwEUDasTrYtbU6E3bDkhX/UG3V4Mh0oZwPD7zmn0iqzTBKk7oVqbMD49nX++GmUjjMXCJ8C4wefxH0pmU7392fOTqwIKLYRm43By2UZ2KHIYZ35WLlLVVtmcnFBuGTmbyZQ4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921659; c=relaxed/simple;
	bh=upXdKvag3PQjFo+u20Yny7ckLbyRjOxAi0c3fKM7W+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HyQFgVAIMQrQBh5J8EfWt+eIGr5wzgFJwbloG8tI2+/Ctmt8JzI0aldpBfvhBUuqfX8793zt1WcWRy9k0OyjqpDHpqRrEupoTOETWjWDezTnZj7FXWK8reBotUbbShB9P+Ltqi3xb4aDRpHfz2K8cvLAzUxyyN/iBIF4qMi2ZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChAwpsD/; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChAwpsD/"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cc954a3edso836085e9.2
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787921656; x=1788526456; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIbaVf3ZrMQ638kyQmo2xKF0JXdpiB0/s407XZc/gcU=;
        b=ChAwpsD/5th3s+TzoJvKMaQT1plVsNlBZEKC3+/kqEaKrYOWuoTuh/vyDndXA2eKVz
         D2Xu2tIczpYAuAADIXCxChTbBKxNsAOtT6RFQYY5g5UQTGEX9WZtPM1CKTLUq9PShR+5
         ScfHEHHRqjxhTsdnN8dbNp2ShFKamIaxBWeo6/S5XetWKMMKnltazrIM/J/jkdRQuqe7
         IBbcvrgI7pYA5Y/AVnADQMqek4dH34GtNfWzMJaezUi9m0tXYhFt6nhssoJjh/qip+Lh
         TbeTgl+57eTwTAdvproihIZTGK2knu8VaRRMlWv6f0zhvfY2FVe7ee/Y8q7nKBkhDERQ
         sM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921656; x=1788526456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIbaVf3ZrMQ638kyQmo2xKF0JXdpiB0/s407XZc/gcU=;
        b=UKa6+R57sHTSGM24p8380UIhhX9/xumttxk4DYEr3Ewg85BrMaCtZg32RjscJr2pq6
         XS5BIJ/4ALHyCSSFMWoNxtDpOEwoh9SlSCiCGY2a4XGwwLWVlQs7fnBXcLvjNVKndHRq
         C09sBrYfFHhpCYmtnXBDrk690aj81yCBaHn8HkzTxGqPzoDgIIYOk29uWhwu4jfWPLvq
         NKu2CjHVNyGYz4lW77XTXqGUjSgXw105Vo12x9qvhka1rc4+9LMJAIEULVJU+o6bOEeI
         4oG9+ZgB41NBtfxTkRd9lzYM9qUO8GW48NpcaVYXz3dMwNX8moTz3pfjkAUEn2nwWCR/
         2eXw==
X-Forwarded-Encrypted: i=1; AHgh+RqME90H22tLL8G9B7IGYOsq+u+hq/x2S85sXM+AvDbwFyCYIiurcMMLfeHejaZl5gWeXM7P1g==@lists.linux.dev
X-Gm-Message-State: AFuF++ml6xznAJ1veAtIcPKmxt6bJfp7JbAwx3ZO7D61v0a5m7DIeIwX
	kLtmXAwHwAS4jhUH2t6hHaSd7S+MuPFK9S7EXCrGzY3FApHsbh+y2uUWO2H272Axm0iUgrXFRGS
	HE1inVYT//Bw0VA==
X-Received: from wmof19.prod.google.com ([2002:a05:600c:44d3:b0:493:beda:c864])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4453:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-49b91c486abmr88157945e9.12.1787921655833;
 Fri, 28 Aug 2026 05:54:15 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:53:36 +0000
In-Reply-To: <20260828125409.1921538-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260828125409.1921538-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828125409.1921538-2-smostafa@google.com>
Subject: [PATCH 1/7] iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
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
2.55.0.897.gb25b4bd76c-goog

