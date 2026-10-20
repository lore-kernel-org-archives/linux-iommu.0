Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515813;
	b=F39gjPg81CVmyTKYpjwnr1PyXteLsnoFzXIiu3HZTO6lIiUYxKQnejX2qQA4eMrRlb3+
	 rBkfFry+pZVy1P/KWIlqF2+dl92jpsD41OB2YHHBuwPgjU0rzyYZHsO+PYsgDx4wCHWEX
	 EpVvVORckHnhqSLN7kY+0a7TFKGmPEOYsYM7s3TKhBtdb0ldwFuRcOwvK1DGs5Aiy5LIg
	 qTEEpYskz3VZ3LrU98IOnVocQRhIcmTG4rHy+smLLSCwz0pUhp0IJ0U0VQ7FMWHhwntIs
	 q4SCqJoeVVnAt98gVXWVfz3oiMcy8OCRIrO0bv1JQ38daqEO4of4orL9wdH5autiDsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PdL12cit1+z6d3jeLw0+naLR3nXNXmktozH9BnIvo4w=;
	b=c745mJH8MSCeK5OHi56xZNczVAAW+iEihPaV81aLKbMV8+UXDyrOwA5oPJ+RT7cVcDVJ
	 2mRbSyl5sONw4ReoR4GoZxaSd2+mfi31bW+t6f1rwtiW6H5/2yXo8GbHDrcUAadx4WP1b
	 nUJ95mxVp3VVR/SUvDFFtlJ/8RhLqG1wB1UwWLHzoV529YqZy1woLw14UhJYGIFqJ6D/0
	 ZcivA0f6xNrNJ69yPgbZpbVkrDAHScthOkQrdA67rML2CbE1qe667oHXPmI2i0a3UiJwe
	 C0Lrf1yK7FydZBR2iKGOjIDOAhNG3VQ5SZ4OuwdJEOB3n9bCN9v2iTwiH1igi7hCJuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qQms9V2g;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB760A2602
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 17:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04DB760A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qQms9V2g
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e635220b4so323144185a.1
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515812; x=1793120612; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdL12cit1+z6d3jeLw0+naLR3nXNXmktozH9BnIvo4w=;
        b=qQms9V2gAItqF1LE/2eya+jGx+tPvFIDpgZbKWMFpOpfAevgX0n6u3uIHMDTCX7hg0
         bcTZuMCH1MQ7l113kA+cmnqKyfNVrDkphZhp+3DKR82+4k6DFObLkhm0XJvIbbYhhAOd
         qUpkPV1FzriSTvaDsvbCWzBN5z9W3zR7Ip+vuAMZz6CIHISepZnbJ4ULY2CSuReyZq7M
         Lu4IckIQeqg0ZONSYJ4oUY+s5bikMgynl1WrDDaAyQQFVXNeLVqata5JpKUBc5Bl6IJb
         eLsLixajuwjLbCVp22VWiGY1ymfrMJK/HT1k1fYpV49qxx+gtnDHqkpmPVX9pup2yB9l
         5MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515812; x=1793120612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdL12cit1+z6d3jeLw0+naLR3nXNXmktozH9BnIvo4w=;
        b=xPDe3ooJQaeoz8wX5K7VoJ1nt6/UtzDGfNY2O5OxhYRvz9NEXuz+6orj/0CXbQSa9Z
         Mr1edV+4ix6K15qfBkvPKBUq/BQC3VKjg9WvT00WMaiRlwAk0xKOYsrTSxa6ijNJh4AY
         l8fcjh4f8jw2SijZfEhzsIqhrobxWDaGQBlzujsz9XK/AcLCd/qxGbg3ldJEGsK9mSC+
         b6AT8gYhODZocscAtcTzJ6y/OrE3GxicW5Ctjd9NyCtMN69UYLCTXG87BH1Kd/BUfvqf
         +kEfmoWyzsmmguuH7gFrrNSmQx7j6AdJqW+yFUZc/YsTER+taI1YLMljGSeX8iGqwZPP
         3bcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhMg033knSVsTQm5GDCLK7KvCdBAD1wnFypU02lQ95UDSOYiQDW/wKzR5Q3lcpKhmDtYpcIA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJajnkalYJUyEIW6u2IKIIejdHkCuCOE4LMBOH7mR/Xf/bi8B94
	n+8zeff9WwfCdM7VNaA+/B9Y2LhmVM8ufRXhiSEf8dUI6LGmUGWWx1Hp
X-Gm-Gg: AYBFou17m1n7Tu7q0bpX4W1J/dkIAXOaBpDXQ5j0PTx04CgwoGvG4j/ZFEuNZ8vocAf
	kWLrGmLop+OvOq7FEC7W5U02NtI1mRjUUdf8ltv6ipKnZBSI03dTkQOP8+Fy9mhP9BWlbP49uMt
	HvKz1VuxOooVnUmFWqV/2oMtoajEYXogEi9fygJAQpmXAi+cm5uevebDp7zsV3e7qx6GNcjuQdI
	wb1CKzM3y6H2ATODi70qihDZk7WOsUAE5UEbErZaJNiSDSjSGqEXloKPxmg+Hj1L7zqAXtMZSr0
	PfrOlgYGq+T0UKs6BtvatQii6DCrK6L0mITwB9vC1Dj1ieVpm1WggFIt+xRSAi9bAJCY5R9Pyca
	AWymEA2wyQMgf+kxaRpypDtryllFBkCA+zguTnkcgFeyAqRWcYX3PSJ3VVcWmsRpM/eePaw+6/I
	mOshry3icc0PJ5ZJ/0RvoQv1XQ984yQ4KP0GBxTWsdeGmKWk3e5nAS2yN7c2eKs4hoLBelxBj9A
	42WfcbVl8rps8DozJQUUA==
X-Received: by 2002:a05:620a:294c:b0:93f:26f6:6bab with SMTP id af79cd13be357-93f29ccce99mr1849718785a.18.1792515811784;
        Tue, 20 Oct 2026 10:03:31 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c6e030sm31479985a.1.2026.10.20.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:03:30 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] iommu/sun50i: Report TLB invalidation timeouts from iotlb_sync_map
Date: Tue, 20 Oct 2026 13:03:11 -0400
Message-ID: <20261020170324.1223144-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun50i_iommu_iotlb_sync_map() invalidates the TLB and PTW cache entries
around a newly mapped range, as the IOMMU can otherwise keep using stale
entries for it (see commit e563cc0c787c ("iommu/sun50i: Implement
.iotlb_sync_map")). When an invalidation times out, it only prints a
warning and the callback still returns 0, so iommu_map() reports success
for a mapping that the IOMMU may not be using yet.

Since commit fa4c4507099f ("iommu: Allow .iotlb_sync_map to fail and
handle s390's -ENOMEM return"), iommu_map() unmaps the range and fails
when .iotlb_sync_map() returns an error. Return the result of the
invalidations, after still issuing all of them and restoring auto
gating. The page fault handler keeps ignoring it. The unmap path is not
changed, as .iotlb_sync() and .flush_iotlb_all() cannot report a
failure.

Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. It has not been
reproduced on hardware; a timeout is not expected on working hardware.
Compile-tested only (ARCH=arm64 defconfig with SUN50I_IOMMU=y, W=1).

 drivers/iommu/sun50i-iommu.c | 42 ++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index be3f1ce696ba2..74ca3625ae25c 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -298,8 +298,8 @@ static void sun50i_table_flush(struct sun50i_iommu_domain *sun50i_domain,
 	dma_sync_single_for_device(iommu->dev, dma, size, DMA_TO_DEVICE);
 }
 
-static void sun50i_iommu_zap_iova(struct sun50i_iommu *iommu,
-				  unsigned long iova)
+static int sun50i_iommu_zap_iova(struct sun50i_iommu *iommu,
+				 unsigned long iova)
 {
 	u32 reg;
 	int ret;
@@ -313,10 +313,12 @@ static void sun50i_iommu_zap_iova(struct sun50i_iommu *iommu,
 					reg, !reg, 1, 2000);
 	if (ret)
 		dev_warn(iommu->dev, "TLB invalidation timed out!\n");
+
+	return ret;
 }
 
-static void sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu,
-				       unsigned long iova)
+static int sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu,
+				      unsigned long iova)
 {
 	u32 reg;
 	int ret;
@@ -329,29 +331,36 @@ static void sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu,
 					reg, !reg, 1, 2000);
 	if (ret)
 		dev_warn(iommu->dev, "PTW cache invalidation timed out!\n");
+
+	return ret;
 }
 
-static void sun50i_iommu_zap_range(struct sun50i_iommu *iommu,
-				   unsigned long iova, size_t size)
+static int sun50i_iommu_zap_range(struct sun50i_iommu *iommu,
+				  unsigned long iova, size_t size)
 {
+	int ret;
+
 	assert_spin_locked(&iommu->iommu_lock);
 
 	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
 
-	sun50i_iommu_zap_iova(iommu, iova);
-	sun50i_iommu_zap_iova(iommu, iova + SPAGE_SIZE);
+	/* Issue all invalidations even if one of them times out. */
+	ret = sun50i_iommu_zap_iova(iommu, iova);
+	ret = sun50i_iommu_zap_iova(iommu, iova + SPAGE_SIZE) ?: ret;
 	if (size > SPAGE_SIZE) {
-		sun50i_iommu_zap_iova(iommu, iova + size);
-		sun50i_iommu_zap_iova(iommu, iova + size + SPAGE_SIZE);
+		ret = sun50i_iommu_zap_iova(iommu, iova + size) ?: ret;
+		ret = sun50i_iommu_zap_iova(iommu, iova + size + SPAGE_SIZE) ?: ret;
 	}
-	sun50i_iommu_zap_ptw_cache(iommu, iova);
-	sun50i_iommu_zap_ptw_cache(iommu, iova + SZ_1M);
+	ret = sun50i_iommu_zap_ptw_cache(iommu, iova) ?: ret;
+	ret = sun50i_iommu_zap_ptw_cache(iommu, iova + SZ_1M) ?: ret;
 	if (size > SZ_1M) {
-		sun50i_iommu_zap_ptw_cache(iommu, iova + size);
-		sun50i_iommu_zap_ptw_cache(iommu, iova + size + SZ_1M);
+		ret = sun50i_iommu_zap_ptw_cache(iommu, iova + size) ?: ret;
+		ret = sun50i_iommu_zap_ptw_cache(iommu, iova + size + SZ_1M) ?: ret;
 	}
 
 	iommu_write(iommu, IOMMU_AUTO_GATING_REG, IOMMU_AUTO_GATING_ENABLE);
+
+	return ret;
 }
 
 static int sun50i_iommu_flush_all_tlb(struct sun50i_iommu *iommu)
@@ -409,12 +418,13 @@ static int sun50i_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu = sun50i_domain->iommu;
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&iommu->iommu_lock, flags);
-	sun50i_iommu_zap_range(iommu, iova, size);
+	ret = sun50i_iommu_zap_range(iommu, iova, size);
 	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static void sun50i_iommu_iotlb_sync(struct iommu_domain *domain,

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

