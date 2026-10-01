Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6E3E5EFB
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895758; cv=none; b=VC5RssiEtnHjnj6a5sVd2j/q8PUi/jvLR3rl47/sQhJBvHE80A4Jqa4bgyquUGq0bftXuNcMpneIItWvAmIFTGt3VOIwQhAo/EcRI8FfpIMks4jECXK6cDLvCTzHv10fAvT7oAh/hbWLdeMoCkSGLLtmMkS/5RGewU7J2epYzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895758; c=relaxed/simple;
	bh=0jQt3q4Z0Q3P0sK3akDGkCdE9MUuzQyf/05QS2hrvfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIXX+DVMsBeEG0Ytl4n2QPzewvAgwzOyobVvWCRgjb2Qd54lHXLyKjEkENmFq7sQExf7jvNh1oZfgYPO8PfBTxfVH8knxGyDULhVoYvrhc0HNJlosV70qhnIYnNr+j4JSTzwUB4hDUIjhfQKbYsbW4YV+0frXgOY3aoQ1HD7Mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3gHX7g1; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3gHX7g1"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so11333176a91.0
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790895755; x=1791500555; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8Tzv848Pm5Gww4Q9gyMfGArUUtsY1KzJi65qPBcWZI=;
        b=P3gHX7g17iKpe7iYeW8nr8Oz6MMg+k2i4gj08r6ZsjhEs06Gmg1ie8yThvRvN7MprE
         QLgPot23ZogNAA7oVkz9sd5Y/J3bQ2wNNdnibdaN7IF3iyq+QCUlnkeM1wwW2XknJeZb
         7oN6V4MlvTkS5JyvwKhdRN2SgGFuwEyYTyQABAfNOt65YsYyvYC/8KPpG02+4dlegp/k
         MTqHBFLSppDj7T3bWaaUuxL8ddzX+lkPfuvgSszUWja/cUIUkOCTspn+2Q7/1b/v7KDw
         iTUDFkAuP9L2LkeyuWQkX8dVIpmVKYVtvjs903vRXVEDuRO6nFrXRAu43HZzFLDSNZQH
         kByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790895755; x=1791500555;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a8Tzv848Pm5Gww4Q9gyMfGArUUtsY1KzJi65qPBcWZI=;
        b=VucFAfoOVFR5D5OpGzFBz0jsv4UgWChBEfyF7O2j/bhipq42LMMIaiyKzmFrWtq364
         Lio0pZ6GklEEkTUJEXI7LV2G4JTgMpw+AKDArW18q3xUp081yudAF+bm+FVkpqtsUBKr
         ubnAxxfIv2CdRmS7f3CaGR2TsEDfQOL2uGcu5QH6mtW0d+zJHNq2nVrmVgylXyB32LpU
         OLQc5fbkvagTcSpTnhKt5Wx9BIuSPhS00tvaxLr4oHHco5aVDb6gcgtGea9m8mme2Eow
         v8LLKmzYkit2N0VYEfTe+Jp8TrGAD+M/xVoQFq1OFCFI7ZbU3OvWCanW2ChCPRgVwH6+
         sX5w==
X-Forwarded-Encrypted: i=1; AKwUvBzMPDDHw9gaUeV4wFzL8oBv7/MgD876LOTyZrZx87IPtKrZEIz2bbejmWZlZ5PqH+M2sw7RcQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ9bJio8CJwLg3SAdY1iBU11JIzR6W7hEkoTs/j+nu9UEkPklIk
	K+e5dhQ/uyzHadSLrZKx1K7KOqZlewpxg2cbuYSDr9ypUoWGkSMv6uP/NAOpGN98q8X0s/w+yQq
	2bw==
X-Received: from pgav22.prod.google.com ([2002:a05:6a02:2dd6:b0:cc9:f7f0:57ca])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33cc:b0:3a0:f2c8:9ad6
 with SMTP id 98e67ed59e1d1-3a6ce9a677fmr808338a91.64.1790895755297; Thu, 01
 Oct 2026 16:02:35 -0700 (PDT)
Date: Thu,  1 Oct 2026 23:02:19 +0000
In-Reply-To: <20261001230219.818128-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261001230219.818128-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001230219.818128-6-praan@google.com>
Subject: [RFC PATCH 5/5] iommupt: Return real page count to the shrinker core
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Logan Odell <loganodell@google.com>, iommu@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the count op to return real nr_pages that can be reclaimed.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 1 +
 drivers/iommu/generic_pt/shrinker.c | 9 ++++-----
 include/linux/generic_pt/iommu.h    | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index e5ee419f2f0b..4386caf3f713 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -1115,6 +1115,7 @@ static __maybe_unused int __unmap_range(struct pt_range *range, void *arg,
 
 				xa_store(&iommu->domain.reclaim_list, range->va,
 					 virt_to_ioptdesc(pts.table), GFP_ATOMIC);
+				atomic_long_inc(&iommu->nr_reclaimable);
 			}
 
 			gather_add_leaf(&unmap->pending, &pts);
diff --git a/drivers/iommu/generic_pt/shrinker.c b/drivers/iommu/generic_pt/shrinker.c
index 66169fb5db71..a27e171b5e80 100644
--- a/drivers/iommu/generic_pt/shrinker.c
+++ b/drivers/iommu/generic_pt/shrinker.c
@@ -43,11 +43,7 @@ static unsigned long generic_pt_shrinker_count(struct shrinker *shrink,
 
 	mutex_lock(&generic_pt_domains_list_lock);
 	list_for_each_entry(iommu, &generic_pt_domains_list, shrinker_list) {
-		struct iommu_domain *domain = &iommu->domain;
-
-		/* TODO: Return real nr_pages here! */
-		if (!xa_empty(&domain->reclaim_list))
-			count += 1;
+		count += atomic_long_read(&iommu->nr_reclaimable);
 	}
 	mutex_unlock(&generic_pt_domains_list_lock);
 
@@ -78,15 +74,18 @@ static unsigned long generic_pt_shrinker_scan(struct shrinker *shrink,
 				if (iommu->ops->sever_branch(iommu, iova, virt_to_phys(virt))) {
 					/* Successfully severed, queue for freeing */
 					xa_erase(&domain->reclaim_list, iova);
+					atomic_long_dec(&iommu->nr_reclaimable);
 					iommu_pages_list_add(&free_list, virt);
 					freed_count++;
 				} else {
 					/* We raced with map, abort pruning */
 					xa_erase(&domain->reclaim_list, iova);
+					atomic_long_dec(&iommu->nr_reclaimable);
 				}
 			} else {
 				/* Not empty anymore, remove from list */
 				xa_erase(&domain->reclaim_list, iova);
+				atomic_long_dec(&iommu->nr_reclaimable);
 			}
 		}
 
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 95bf9d4f0b6e..3c94745bded0 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -69,6 +69,11 @@ struct pt_iommu {
 	 * @shrinker_list: Node for the generic_pt global shrinker list
 	 */
 	struct list_head shrinker_list;
+
+	/**
+	 * @nr_reclaimable: Count of empty directories waiting in reclaim_list
+	 */
+	atomic_long_t nr_reclaimable;
 };
 
 extern struct srcu_struct generic_pt_srcu;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

