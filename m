Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2C28CF6F
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640486; cv=none; b=U5ToFOZAIRzfV2+YNrfCY0kYk7c9ZQbxAv5FhufbtpAF4wACwhTe1flEvRlxu3lIUsm7BoTjlwwgo3w4Wk/1QWve1hN/R8tgFsddZpgXMjFl93XDH0ytF+QILQwf8BgrQqWb3ncywpu8r6N7vLI2+6r4sAXE210w7yMg7QyVsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640486; c=relaxed/simple;
	bh=SpUfzCT8IHU0ORW01ds8PUqbr6hOM18pR7FF3FM5GCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQFb3A+gnubV6O0vOKMI6T6pcoR/5K40Rr7hFT6yJwC5mYgWhEfn1FOjEwm2zjeyZQIpWb2bYaBR6G8wGXdHD/kWjOzdi9/PsK6woGGFd9YvAkuRAF5T6uLb0HmV7BrR/ipPPGl6lt8Nyn/sDm2iGRuQmi8oT9ICDoaGXGdDVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SpixbH7w; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SpixbH7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784640412;
	bh=KodHXqjpVuyorgaMmQXmLbe3T5ozuFODqoXZASKFWx8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SpixbH7w5aK/qxSUaC1mlCGTNQWYO9dqpQEKFLghtvX8mzsg+gBAMaLjtbkSt7HYy
	 e9EiwwHSm6HKCofrl+e+CjY1NJ3t7oXHHpcc6K+X+sgadkqyrkQTy4vrjiokuo5pUl
	 pOw9ngMVZGTqSLF1L/CkPugFRY769RzKxtZWwMmA=
X-QQ-mid: esmtpsz20t1784640407t6f132b36
X-QQ-Originating-IP: h1ZF1hBo7fXTfp3PVA13rc36qG/AOnJjubrXktmXkqM=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 21:26:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 890172722082696734
EX-QQ-RecipientCnt: 8
From: ZhaoJinming <zhaojinming@uniontech.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] iommu/vt-d: Fix copied_tables bitmap leak on error in copy_translation_tables
Date: Tue, 21 Jul 2026 21:26:35 +0800
Message-Id: <20260721132635.1436908-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MBKLumFSBSSxrmbUv5mTrF6ixXvpzclheShePDmCViPccuswnv6tselk
	G6A1VhKVAX9Xd4a3YDG15jaUEWq3cGLrH9pzoZkeBrCYLpC/EBKnHGTv+5maekT9vy6nbTN
	rcphQJFPlDP9w51wmpS/+rmF/W0Dn/v9wxVpCHFP+NK1xrl1KcDmiHBIP27QX7/bjGXmPjg
	EVcEocHv7KNjBE6RUrJaVOcKP3gWN6wOcENG6FCinxrWTFdcncDswD/rDCItiwBZ25fh0pD
	RJSi1lFA1kUjP1jioVoWyGslaj6ki9Nr8vIaFMQ7cJ1Wj2CxG9LClBvW1AzQB86uty91716
	eq7vJP4i5uLMGHT6tPD5Ms61VPA7G1Dj0/VgiTnGXzggBA/0UpqIyJPlJicyoifOw9OZ/rr
	tKy3IC+RLu9Ao36KNpJoI3GU9bx7wAAMvYAWxRAEtryIjsbimBx2zkFuSmQiwtj1Ku9oPC9
	x1qDbaj8obaSz3GbP8/1MTjnb79eBiP1J1IZN6RcqgJaP15EiClVowMO6FHrYZ4hiLuiimZ
	x4sjyc7Zx05s3qXZ0wyla8OxIxZKmpU4SYJMBea17+faCtFgl3oQTiC9zRAzSGNACwo3IFv
	BCRFZSW2sVrJa1o+cua7/AcRa872TrWo4cYSKIwHy6q1BQkrPM+IzQB/k9UfYT671bI8fF9
	IWfYiR2fZWCHe4t59UZZVVhkN7YDGFvkaOYbAblNImH9Th7D6acTZ3m+S7NhKpj3ktyna8W
	mC5JXEclTiClPpJWWhb3xOsksCucfn9b2SuyE7cQQSlq0TPJoVOg3/8gP9h0YTZweSbedvf
	G9WogRuSFTZdstL1HngizkPS7JM8BunQ9xWKxTazzFIAq3pcgy5t4ki5uibTk657DV+8vhS
	EdqymSjGSHbMH178rhdFKJLJz3orZ0gpqijk+mtZEsxeyVPovLK0IpsWOeD2FMacY2I5+q9
	GujQvCFNurhwA1KCWHewlTuk92dH0rKAFechuMQUj/nX4kyGx53M+TUQqC8cG/df1cQETb1
	BPRktK3BUeTw4DcFn2iH2CXQDQ3zhWwfYmRqzz0iVr7jabc1B/
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

The iommu->copied_tables bitmap was introduced by the IOMMU live
update series to track which context entries have been copied from
the previous kernel.  The allocation via bitmap_zalloc() was added
inside copy_translation_tables(), but the error paths were not
updated to free it:

  1. When old_rt_phys is 0 (invalid root table address)
  2. When memremap(old_rt_phys) fails
  3. When kcalloc for ctxt_tbls fails (goto out_unmap, which only
     unmaps old_rt without releasing the bitmap)

The bitmap is only cleaned up by free_dmar_iommu(), which is
called from the free_iommu error label in init_dmars().  However,
when copy_translation_tables() fails, init_dmars() does not jump
to free_iommu -- it logs the error, falls through, and continues
with the next IOMMU.  As a result, copied_tables is leaked.

Fix this by converting the two early returns to goto a new
err_free_bitmap label, and by making out_unmap fall through to
it so that the bitmap is always freed on any error path.  The
success path is changed to return 0 directly instead of falling
through to out_unmap, since copied_tables must remain allocated
for subsequent use.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/iommu/intel/iommu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..25f49d29da8a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1554,12 +1554,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		return -ENOMEM;
 
 	old_rt_phys = rtaddr_reg & VTD_PAGE_MASK;
-	if (!old_rt_phys)
-		return -EINVAL;
+	if (!old_rt_phys) {
+		ret = -EINVAL;
+		goto err_free_bitmap;
+	}
 
 	old_rt = memremap(old_rt_phys, PAGE_SIZE, MEMREMAP_WB);
-	if (!old_rt)
-		return -ENOMEM;
+	if (!old_rt) {
+		ret = -ENOMEM;
+		goto err_free_bitmap;
+	}
 
 	/* This is too big for the stack - allocate it from slab */
 	ctxt_table_entries = ext ? 512 : 256;
@@ -1603,11 +1607,13 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
 
-	ret = 0;
+	return 0;
 
 out_unmap:
 	memunmap(old_rt);
-
+err_free_bitmap:
+	bitmap_free(iommu->copied_tables);
+	iommu->copied_tables = NULL;
 	return ret;
 }
 
-- 
2.20.1

