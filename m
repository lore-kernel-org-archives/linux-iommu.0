Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE94766A9
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523860; cv=none; b=ZOrqDoYXTUjqERPzuVPoH7x1J9DMnlHV8ozwF7Lw60bv3xQas/hNnL8Co6xwmC+LrVmi6Pfc6Hrnfchex01c8qYgHFF4VB6otoT01Z/927mhM5eNey6adT45fidwnDNp4WkjDHCxHZDsNc8RqXMPBg1KoryZh58sw6pTD9VuZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523860; c=relaxed/simple;
	bh=SytTqBZRVnhvi6OcGzBLq+bOOo2twon79DQt7+lrUQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btMXO9M51szxqJHMLSWlyeeLDj4VkIYCNKfgS+6+5L6WaSuZOR2zUOcIIcuOxwIgqZq0OtohZHS8TKkrxiTKY0YGGh+yaajwpDNYp/iaS3VK1w2Fg85f1cbLtpBKy2wPc2jCxHnOtMS+lxJpBARXVxmM1kkNCgvcYibkf4pDGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AScWCyKZ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AScWCyKZ"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b128dd0cb1so575255eaf.3
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523857; x=1789128657; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LM/ZtSLU/J3nueXy+XgpL+eelg2/bX7Qhca0kqwRafM=;
        b=AScWCyKZKr7IIArO1zOXrvMDpg6biyWI6gED5hrkfH6y2Xvn5/NeDTvqbg871M5nWr
         kQfjkZw6Sgit3x4euQo+8s/KQO3rWCP7AZrjCb5C/VSEtHjPssOAJ/R8E3y1W/Z25j2K
         ZRGtJf5vxy6BmECxY6oqPiFmr9jgD39hYf30g2ZF9NjKp81SM/F9RdiMgaKMqfQQD1he
         MyzWLJrM7q2F245xYa+YFv/qZU5588Qw59R0tBJB555hfalSPYpR7CW/7PiDcc8dMUj/
         LogC/Y264E0jvBkm8OL9qM28+V5CW4Zfzq542eAkcZbrBCasF9cUAvrw6QLqbjDSmI35
         MrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523857; x=1789128657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LM/ZtSLU/J3nueXy+XgpL+eelg2/bX7Qhca0kqwRafM=;
        b=r7zlF3S8WiCnxD5xgQejUeKIldE6ZBpO0dm9bx9ov9GJQpHc8bp0l2kkRUoyLsEQuz
         XGojfmsvXJ+Pf0iIZqSAxdSfRmaVhaQvwqo7sSz10XQCvYXecnyZv5DXm4pd8VUeQCKc
         Zz5+MOiO0nv9GK9Bclr35Ud9zLBcCuchEVhH7+Q05jZenClkTRsf3mp9CEiJtfa7cbrg
         dEypaUILwyprzn0YFY13HVksRGrn3q9O4fWi1gde6RexdsMNa81FBvjxCqLRceBwx7n4
         dcVL5X1F65vHgC5a6TPuPEfLC5Ceo8+jgjJPQ9Ut2aDDgB8PA/mh+ec/jPTpVPBg6E/v
         Zdsw==
X-Forwarded-Encrypted: i=1; AKwUvByMAt83NAA087WVslfBPvVA7UlCD7V/hMFDHc7rr5xHze4DuKZke2hw8f7vVmPhl/9Cv76Dtw==@lists.linux.dev
X-Gm-Message-State: AFuF++mX/AmM4UaaUlqT9fBO0NegGEz0puqZom4sRLGFXtt45kwEwLh3
	E5Cb9M1LeYx4TsvxcDnG0LaWi2rrqHF8fqQAbGJjG/4aXOG+ogPldNB4
X-Gm-Gg: AYBFou2hukZouLC0u0D3YzmLH6bPccofcgso076I6bHUlumdb7arMBm72YVoVgppyHo
	wVj4EGvoWv3iZsMZcj5a1zxTDgmQWaYRHwejy5KG15HZrc7r3w0Y0dgbR8OTuGMmbifzBwqGvpp
	xJYtfd9jNGnBCKbj5+zN1eLdmSdxmDcJ9A1X2cMYVEXxQVivajkvKOjhnccVE5CXpqV7BMpwFv+
	X5QYNkcfZFv06ZFJz2jtXGcXpC8caQv46Ted+HFtAj+eCEehYsk4+iroNUc6539KwQ2A+Naid1a
	2czgP79r43bQvdvXbJZrl/svkKDONwEqQ0ycKqmA3ImCv7blOP8JXh1V6zQ+ZJrHT4jwbRJBgzh
	caY1PyOwvvdSU21+jhHeeF/dXrqutAef+6l0J4x3Svw8Orku63t/kM+t8GdoRUMjpdj9Mn3EaRS
	alZktSF5DcZDTDm3KCUOdKTwqdEFxFgfD+dLVRft3qESJmpi5Hl+nbJI3HsVNoQzlFMayhERQs1
	f7gnO5OJicmv98=
X-Received: by 2002:a05:6820:188a:b0:6b7:83d6:292d with SMTP id 006d021491bc7-6b783d62eb3mr1446014eaf.48.1788523857014;
        Fri, 04 Sep 2026 05:10:57 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm6461237eec.13.2026.09.04.05.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:10:56 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 1/2] iommu: fix typos in comments
Date: Fri,  4 Sep 2026 17:40:43 +0530
Message-ID: <20260904121047.21701-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904121047.21701-1-hemanth.selam@gmail.com>
References: <20260904121047.21701-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 4 ++--
 drivers/iommu/intel/dmar.c          | 2 +-
 drivers/iommu/omap-iommu.c          | 2 +-
 drivers/iommu/sun50i-iommu.c        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3dbe20023456..a1cd29f0d03f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -121,8 +121,8 @@
 
 /* Note:
  * The current driver only support 16-bit PASID.
- * Currently, hardware only implement upto 16-bit PASID
- * even though the spec says it could have upto 20 bits.
+ * Currently, hardware only implement up to 16-bit PASID
+ * even though the spec says it could have up to 20 bits.
  */
 #define PASID_MASK		0x0000ffff
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08cd20..e80a2eb3e64e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1034,7 +1034,7 @@ static void unmap_iommu(struct intel_iommu *iommu)
  * @drhd: DMA remapping hardware definition structure
  *
  * Memory map the iommu's registers.  Start w/ a single page, and
- * possibly expand if that turns out to be insufficent.
+ * possibly expand if that turns out to be insufficient.
  */
 static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 {
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8231d7d6bb6a..7e43c6d64434 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1732,7 +1732,7 @@ static int __init omap_iommu_init(void)
 {
 	struct kmem_cache *p;
 	const slab_flags_t flags = SLAB_HWCACHE_ALIGN;
-	size_t align = 1 << 10; /* L2 pagetable alignement */
+	size_t align = 1 << 10; /* L2 pagetable alignment */
 	struct device_node *np;
 	int ret;
 
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index be3f1ce696ba..8c9ed9e5f1cb 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -152,7 +152,7 @@ static void iommu_write(struct sun50i_iommu *iommu, u32 offset, u32 value)
  * 4096 4-bytes Directory Table Entries (DTE), each pointing to a Page
  * Table (PT).
  *
- * Each PT consits of 256 4-bytes Page Table Entries (PTE), each
+ * Each PT consists of 256 4-bytes Page Table Entries (PTE), each
  * pointing to a 4kB page of physical memory.
  *
  * The IOMMU supports a single DT, pointed by the IOMMU_TTB_REG
-- 
2.48.1

