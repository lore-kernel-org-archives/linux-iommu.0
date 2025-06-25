Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FA18C008
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750834094; cv=none; b=DkN1lgZzrwZnSf6Br44U/Sx7A0mAXyGQiyLyleqDPd0fhcyHHjqaIhe9fmgiOINGxEllei/tvt9AImZaR9iciomLdOdbZrSXPfSgHCRoAuyBnGZXwq0s+7ajLdJVrAUBWsF3gBecYUrqMW0KEq5rVYKwaADUMK8YRsZd0roN2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750834094; c=relaxed/simple;
	bh=YRgTBG6ahEu12RrN56cHbtpyvTptKXyTAvXP+cLX6BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXGkz0ghmXGWgTkBLPjBAxUJhAgosmuTUFheB2BBGdLmlfb8HiONezzBdlSF2b/ISzu2CqFRqu9QmJI3fcsYLF4MsZGEiD8cwc+Qsu+egMKY5HI6GoV324dGlrEufHnNaNQ1I8e8AOfs6jNmhx1m+9gWWweB7jAYwfMRVrr+PLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1+/ex1G; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1+/ex1G"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33677183so14399435ad.2
        for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 23:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750834092; x=1751438892; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDntjPY9BcK8XP41EjKymaWC9cq9DzX53giAwjmriis=;
        b=Z1+/ex1G3tuBMmkNy7/eyvICg72YDoNjFzG8KCM4uqpKo2Lv6sQvFnnDUuY1K53Ef8
         x3aXtsnKRok4wUKj5Z6/MR+C1dc++mIptiydEOvWzaHI1+nSfdCYOnCsS4sewM5aqajD
         Pjhnmpk2e7QDjCPfDCDm79vxVe3NqBrJLDLhWm/4ER+gdvlMYWSa1YclUy6kj/4iDodw
         Hovuuj3JwVAXps8EleUk1t1q3KzWS2kpGk1hy4m1Zo95SMWELT3T2BtczlQIk/6YU892
         TkqrJDU537LddM7OFsS8eoKv1rG9cVfygaBcp2vNpVQyhjggvd72HDf1Ouf1uJ4kpwec
         MEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750834092; x=1751438892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDntjPY9BcK8XP41EjKymaWC9cq9DzX53giAwjmriis=;
        b=NQmhx3Z3wpTgSC+PYB47uO11PswMilrVle9hG5t+O47vZlxMH74E+V6v3nfFdkT0Y7
         dUI6EVL5WQrVPcBW7skafKgKKDZ6I3nrDw0JlmWLBvLzbCtrNSOvMb0PinayvSUgRs/d
         GM04Ft7XZ9OUoRL6b0iUy24UpubOGEuS55FMOKwJrdBHIDaFMUKStl6Y5zp02jmhrDon
         WP1xdKHGwFrIJqfq+xHJXTSq6elHyE39ShdW+PgXhf2rMDi2SByckNvo0SSoQmcNvV5H
         yM0ZuRZBid0aasJQWr73/xeYCg22xHf6in2Vl/RfWhJ2luPECH/EKtXpW1NJJ1ja5AVC
         mRQA==
X-Forwarded-Encrypted: i=1; AJvYcCWxtMR4dys8+8HS495fFw4QPYOtPTpTy3SRLGt5taZbmEWPU9QaiwObVxADc4LOGJAAE+idTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQIKCW5t28+CMxJhprIXSZmT3v3eQTsYt7t7JJWl64Rxgv+igK
	cX27O3m3ZAoHDMRkKCQo6Fz9yD8/FXdR5KLJkZZjWuIxl6NN3SkGDSDk
X-Gm-Gg: ASbGncsH5zWr+SgQKOOVktfgDsbGhTPs0LBbvJ0UxrTrfh9UjOA2dOHuOUVyDzecc3U
	NC/24/xnwOTqx2j28/qfkuGwViaCLvLShdogiVWL8FYA4H6oPWUco16XdKkz4CvIDLPZcM0zq4X
	A+VPz/pDkeczoEH2X1OEIJ/v6gWPy2qVuPkGUDHMP715NaDf4POMVD655BacNbR+GtVsQ8Jrsrc
	fcPtp7Z4DEQHLz+Ld0i/ncPGhTxcB0dn9vVa5XpBhE5yRUVbNl1zehSxyR6UG3YoutGRd1loTvL
	V7oDlOue027Q/DzfFq7G1TRQllzwG7cRSB9jTkRwvKiQesT1JvgrliABDlXGIZGebl2BWLUmpNH
	l
X-Google-Smtp-Source: AGHT+IHHpkRLh4Fi55uEQqLaLiIKZWApjITR844g5L0jj94q2zh5jkCtC479Nj3Tmpcpwwt3a8pnNA==
X-Received: by 2002:a17:902:d492:b0:234:8c64:7878 with SMTP id d9443c01a7336-2382409e007mr34322915ad.11.1750834092167;
        Tue, 24 Jun 2025 23:48:12 -0700 (PDT)
Received: from tiger.hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d866b659sm127470495ad.168.2025.06.24.23.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 23:48:11 -0700 (PDT)
From: YangWencheng <east.moutain.yang@gmail.com>
To: east.moutain.yang@gmail.com
Cc: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: clear SME flag for mmio pages
Date: Wed, 25 Jun 2025 14:48:02 +0800
Message-ID: <20250625064802.3640589-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If paddr is a mmio address, clear the SME flag. It makes no sense to
set SME bit on MMIO address.
---
 drivers/iommu/amd/io_pgtable.c    | 6 ++++--
 drivers/iommu/amd/io_pgtable_v2.c | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 4d308c071134..88b204449c2c 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -352,15 +352,17 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 			updated = true;
 
 		if (count > 1) {
-			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
+			__pte = PAGE_SIZE_PTE(paddr, pgsize);
 			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 		} else
-			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+			__pte = paddr | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 		if (prot & IOMMU_PROT_IR)
 			__pte |= IOMMU_PTE_IR;
 		if (prot & IOMMU_PROT_IW)
 			__pte |= IOMMU_PTE_IW;
+		if (pfn_valid(__phys_to_pfn(paddr)))
+			__pte = __sme_set(__pte);
 
 		for (i = 0; i < count; ++i)
 			pte[i] = __pte;
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index b47941353ccb..b301fb8e58fa 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -65,7 +65,11 @@ static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
 {
 	u64 pte;
 
-	pte = __sme_set(paddr & PM_ADDR_MASK);
+	if (pfn_valid(__phys_to_pfn(paddr)))
+		pte = __sme_set(paddr & PM_ADDR_MASK);
+	else
+		pte = paddr & PM_ADDR_MASK;
+
 	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
 	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
 
-- 
2.43.0

