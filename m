Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD564204F
	for <iommu@lists.linux.dev>; Sun, 14 Apr 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713111909; cv=none; b=rxGdJkT3dH1OPFv4rQQ5/VsdLFqE1s9/bEfpF5anXj1WcHGqtOkovhcUz9jChI0JJS9loCy4TmZPb34QscnfbHt/+BPvh7hhcZT4CX/0yLrLssvoCBFLHNyu6VswE5m7ac4DWXO9Gdf8ieJKLks2kPEvujFRuNmf/in8YdC6RiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713111909; c=relaxed/simple;
	bh=x9zY+X01BxCJYs60384+4AxqPsLSpqAW3M0zfApyxdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T11rTHhVNAbzXPbQWm7u34iSTE7mFx93uXqaEAQiVquWFUR6uY0Its671BmGiQEWe08kwdR7AURYtIACCceZOuKQZ2CVWzP4S7H0cc4EyK9UEfFFgpm3zgrOtPcL6ClO3AJONXvWzFWVTk7At91H+rKdpvEHjSMI5E6Jrsxm8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7/JtsVu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7/JtsVu"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44ad785a44so278278166b.3
        for <iommu@lists.linux.dev>; Sun, 14 Apr 2024 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713111906; x=1713716706; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVsG3JCtQo4tlTQt5Af4gG7a1SS2UAv4W4YMU6rXC8Y=;
        b=m7/JtsVuP6aFYhO5G5uCAB0TgLsn5kFNmh3D35+Lzbw4Lfd3L8cN9ss5EM5yQ5Dp71
         gIwyuW3QmENijNiMVs07/QCU2pqGqJhD1lRrsTLZGRJVIyLTE5zY6NmIbkRpCXNnLt0Y
         226LVvU+atM+CctL7punxDAugZHLJjlNm+f3j18qZ+78dtD67T4gw5JCAc0tu4z5WX1M
         RCnMJJfdle6NGWCfa1QkJXgFZ90N0HRhiSxuG0TnnqSj+Uwr3fm8iLoBacwGHsmDGGlJ
         LTRQ7q58c2M3ZTG/WG50lHxlzD3nK8zN41UfyyMuVyTfaavUgOQ3YmwxlYkFUJu2STuy
         aLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713111906; x=1713716706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVsG3JCtQo4tlTQt5Af4gG7a1SS2UAv4W4YMU6rXC8Y=;
        b=m8IHb1gYUAbRQAR9gJ8zUWQC4pOD56tBqjZw4IAOdSMNoucesekeEp3nXBwtuEGsej
         hTWDFq8cMzWCXY2toSbX1rxfRSx6R2nPNUiMFcv2RKAE/nq7TROf9Q7MT/g8PHZcKag9
         3/R7m8G7rQHXDjfEbjwQgZkS4SiKIMLYIUDvjtJTt/ic7Yv+bvzZuLxFoodzUNb4TAyv
         dowtf7MjipaYpDNMSdlVJBLjuIYvyBXq8ZkPE4PBmEIbav0MrIscG6nk0F/dU8L8XGBh
         niaaXfrwM1gTpb18GMuNgiLD+sLi00efNoD+FagOl1/j2xjYpyfVyZHmtuXKR0A8YDh8
         /vzA==
X-Gm-Message-State: AOJu0Yz9xK0MogZxrrkMKVpt7T+7mk9f4CivYhT2BVoUcBx/Uwn/U7zC
	dh5DWpnvecBWboIGx1Ptypuxo8IXLodVEGtKywe7qoNpmMSfXEp9Hq82mQ==
X-Google-Smtp-Source: AGHT+IH9g+mcCrogr0CIRidhtrDFP5KjqkCIgE/JGUqj2zc3wRYfBX9PYIONiFkO0uvOTfch9T1big==
X-Received: by 2002:a17:906:2932:b0:a51:969e:ba0 with SMTP id v18-20020a170906293200b00a51969e0ba0mr4631415ejd.44.1713111905479;
        Sun, 14 Apr 2024 09:25:05 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063f9200b00a523cf3293fsm2920181ejj.59.2024.04.14.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 09:25:04 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/intel: Use try_cmpxchg64{,_local}() in iommu.c
Date: Sun, 14 Apr 2024 18:23:11 +0200
Message-ID: <20240414162454.49584-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace this pattern in iommu.c:

    cmpxchg64{,_local}(*ptr, 0, new) != 0

... with the simpler and faster:

    !try_cmpxchg64{,_local}(*ptr, &tmp, new)

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after the CMPXCHG.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc..311073494f50 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -865,7 +865,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			break;
 
 		if (!dma_pte_present(pte)) {
-			uint64_t pteval;
+			uint64_t pteval, tmp;
 
 			tmp_page = alloc_pgtable_page(domain->nid, gfp);
 
@@ -877,7 +877,8 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			if (domain->use_first_level)
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
-			if (cmpxchg64(&pte->val, 0ULL, pteval))
+			tmp = 0ULL;
+			if (!try_cmpxchg64(&pte->val, &tmp, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
 			else
@@ -2128,8 +2129,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		/* We don't need lock here, nobody else
 		 * touches the iova range
 		 */
-		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
-		if (tmp) {
+		tmp = 0ULL;
+		if (!try_cmpxchg64_local(&pte->val, &tmp, pteval)) {
 			static int dumps = 5;
 			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
 				iov_pfn, tmp, (unsigned long long)pteval);
-- 
2.42.0

