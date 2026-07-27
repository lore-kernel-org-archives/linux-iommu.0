Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2C31F9BC
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785129868; cv=none; b=LWm9wNsAdz/fr2avPUgpRS6VhbLQGOm8kDNv3Mo2wvzj+3m2AZsRxKzT7pB5OqL+5T1W3g3gPu2oAVZIlHmQHg93o/FsMug6+nqAQmfbMdeHS6zn3ZkMMXzSqr6MoTgDb/srxv6veUARgMLVvVJJy/K1vpBXzPSR4tQTyWAG7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785129868; c=relaxed/simple;
	bh=ZQvxZGp1h9Ulxkr1U7xbFjvu1Z3jvoqE26uf3FDecR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0lAjVqavgvhNWecC1U4ilN4zGzqjW5Ixy87R61fsDyysuZbeJbfhHqFbeGCz7H7qYo/i5bozHf7/kq0XzpMvu6qF8PLl2buO4JnCKEAg46K+C3N9ZzwX8BZvexT5ObhG1W7oMdQ/qt/sb4UrcH+/QOyXBTGxHGLfGo2m6zMUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TTJKlxoH; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TTJKlxoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785129786;
	bh=BAuW2MK6wM+qCED91Wqpl/CmYXEHnr0GEbI9EIdL8m8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TTJKlxoHfGePcrZI1ahw1zHDdhMh5v/cY9fYKkES7vr6g84NzN2w9OyPIJK8eikUv
	 OKiAsCCdnaPP0GnbvXzO6xkJBAOT6L5vntgg6zceS5NZ0tXBbhHyumrxzGOCV+BdfG
	 fyCxcltwNEgw2g5lhW+SOKONL0Covcpn6lYqEcto=
X-QQ-mid: zesmtpgz5t1785129780td75847cf
X-QQ-Originating-IP: xLEKETNoSQQ0KXfijPay7abwGUwlNQyeNjsySuE94Hw=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 13:22:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7335713737154730387
EX-QQ-RecipientCnt: 8
From: ZhaoJinming <zhaojinming@uniontech.com>
To: baolu.lu@linux.intel.com
Cc: dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH v2] iommu/vt-d: Fix copied_tables bitmap leak on error in copy_translation_tables
Date: Mon, 27 Jul 2026 13:22:40 +0800
Message-Id: <20260727052240.3483567-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <367f963a-d337-4d49-9d5b-a558fcba813a@linux.intel.com>
References: <367f963a-d337-4d49-9d5b-a558fcba813a@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N98Jd4LrBU+SHEzBemJOf3Ti0CRFQ6Y6eTKhqg7IkA/X3sCPJQBVG+bU
	bsN1f8w3sHc/XsWgsdxGOnrb+T9Tk1JzZoDsrIqHoh/1NOEVlm7lVEVvf+e4xwomFxYomGW
	KyjuViomLsUO0UpjUP0OXA8vqWjcvmYbBhRFFRCrArboF68GOAArXemzz/vJfygSYOO/dNy
	9vcyKpH2L63bUu+U6WT7734TAWQSWChAElBGuj7Vr1YZHR81fR/dI+6CM6uprEdKlq/1813
	N9sD3nAdgwT20lR6NWJvDltEEdDWJ/Djk3yam77igGUscGzXyRqzjVaOuHkYtIFcbP/e1cA
	XH0vrTuOzgzOdKzlOVGSDsDp6KvChra68WLFyeC/PqWHK9u03QL/8CdolMnXW8m7cy3Fg21
	F8AaKRk4cFjqaO/U9dMzfEfv6imK6BWoym9SivEsmd30o1TBqKRjEmqOf5tkMrzOe/bJR+E
	U/Ct7Vow0uko2DkgfncCmXqhjqM00l3FcZmVcXvK7+woXmLG2darF1yp87Ac/IhGRw5kzQ+
	M6fbnuisXCpfNmPsCe0jBaaVTa3QDtVeo7Q3VvVJ15QcSs1jNB5C1kBi5XZYueYM7fwsia7
	CO5b/am8VqxpuF3H1/nb2FDWO7nusD9e9BY5/5OalJbEnmJAF6SE5fUQU3lcdWg6wXwIVqW
	0otbozU0Ks8cmPMAbDzINjQRvf4H4SfmGi9WH4slCHYUcR+zfZIClNHOqv0d6A/S3HAo8Bk
	/Z6bYvfr4CzsTgt7JAmqYpmjSxcUts3NA2gVzz180ovvBEU9dVH5IzBhL+7OxFQNvvCw/Wc
	kS7o2gDpD5X3SbAf2nueW1a/yObrJxU3S27i6WnE3U08cYO54ksUEFX0qnyS+hDIc4ZFnji
	YAGQwxeS2gOUqi4Vpl0XAS1zut9Imz4DSM20OWTGYiIL4zdj1lNj9x0mDBp2A7Il2kP7qDi
	Lukj/68p4bpuCRv4OTXkUyM1QtPdtQg7nZsdYqjmlbpcU6U8k9lbz2LYSMzFSqwzaIv3p1Y
	7ggJ7iC9OP7RgR41TBEVK2oQSJHoSwsz9QpU703wH6lO5jcyhjSjoyzKbxxqurQtoaeZ6yb
	g==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
success path performs memunmap(old_rt) inline and returns 0
directly, since copied_tables must remain allocated for
subsequent use.
---

v2:
- On the success path, call memunmap(old_rt) before returning 0
  instead of returning directly, fixing a memunmap leak introduced
  in v1.  Suggested by Baolu Lu.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/iommu/intel/iommu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..05376a7231a0 100644
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
@@ -1603,11 +1607,14 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 	__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
 
-	ret = 0;
+	memunmap(old_rt);
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

