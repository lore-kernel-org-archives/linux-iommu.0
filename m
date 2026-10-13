Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB725218B0
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911562; cv=none; b=KhcQ0x1qvbRxRL2zNwzWTnXRsF8yXmiVPEwW/6/Vm8VsJ8Tj+IqPaRz6xVenyS940O5S5ptaQ/wt/XXstfVFNvFn4l2+g5sHepLr/mA+uMxEOIeyjZV7WzAip4tgpVj2mGfimfJh+9UjU553XX+PNRxTgtlEZGrj/RBnToOkEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911562; c=relaxed/simple;
	bh=vZ3XOjh7+MDb5NRUrgu7NjsmjoO7dxSF5Zx4rb2v0VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqmx8LoYls2/6DXdXLfy64+JyOdb15Y9C/UsG8kcmmpTBzmwarw67MeVG7TnWLzWrbKJSl68MWjv0049iYWHpuHI0P0YMFTjLeLcmuSPmMjd3sVjin1wUCmXoP6h9YXhZUGgX8eY5QVuX+d8vinvRoqWhLx/zqSLc/F0txGdqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4/yHGQj; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4/yHGQj"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33e6279a1d7so1361018eec.1
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791911559; x=1792516359; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZU7pSaZGKiPMSZYCfmxHQiJ5B/e9tRYMINwq527v7w=;
        b=C4/yHGQjcw7chFo7OmzSP0XnEVbteqWwPxf/ArKeipo8HvByvytzbtHF2C/Ln9BJ3k
         /Eohb6d31JuTrqHaYS+PCHN+ztpB8raRPbRjFWvR2Ze9BFNXLIPVmHZFHP0fGWRW9hGV
         Gr5O+8T+uJhhoA4qDS2Jq3x6FrWTwIoa6TIi9jYY3MyDcaxUHGYHytBBfBiO5Z7UsdRD
         r4SJNH+kaIu1COm1H5OYDiupSCyfFGiUN4cWE2K89A6oT96q4+KirDwZtR18zRBTa+gu
         wvLbVonwcuAaSWzYDjDbTNWc0Doq4ay21Dn0i8FpjCPVoO4e3RyXd7rduvnPCeIUmWz1
         nkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791911559; x=1792516359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZU7pSaZGKiPMSZYCfmxHQiJ5B/e9tRYMINwq527v7w=;
        b=X96rXfxPNA1TymjCxGXw4s5LiROrlnSjJsSz5MTnBarPf3OqxYIIhCWqtn1uOtV9Dr
         PnYLacbwS7VZ3eDKVRV3wa7jf/a8/1LyUOo6sWKeTvWZqQzO+EMqAcs5KkNdP7OZKtWQ
         rNy5JsG3RjvwpIj0DXa6Qi+XEybzO8Q/boF0Ze/aXmc3Ss+NUd3KLVIm1JTmVQeNjpZ0
         1qZ5T2JG3Z0osssz2uh08r3xeoOFKczIgzPfwY3+CEyMHhco6p4tm5NkjhDBV3Itx5n2
         1WQutooxUmmNNjXNEy8mNYmLtA74B4SM2bMLlqYV6RFm13zFlWhzSf6Z4utvPg3GNSZ4
         IPjw==
X-Forwarded-Encrypted: i=1; AKwUvBzU2GrkqfO10z7gDYx2uid5W+tCiRBQAFxI6x9wNpjuu48eisiMzc8Da01ogA5BfS+j0nh6wg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKa0HJ9v/w51IVFjqPCI980uz6QCksUF2RkgkuubfkFO4S/QLgw
	wDPld3NHttjAqNvOZv+fIJeI5sGlyd7OjD4U4H8zQXIP+U64IjUQp5KY
X-Gm-Gg: AYBFou1opKLVfzmr/aVwtHtCU/C63+nM7nRPA5vu+lqS4ZJbyu97n45ydIkTW8KBLw3
	a39iapCDJzVF1Sj+FEWSwn37T9FXA7EwZt86sv4eNBcYnFP1mhDk5reheezzhVND2bi/O8+vtAg
	WvCtSMSc2KbJqs/uyt9oKhBZAYSHY5f6q8/2aIA3RuTex2X+zRPq2Z/4cg62Jd0Be2ZxcOnF+57
	V21fFzeWsFmr2b/dZHKyopaNFnO25JsHWjbl6r+XuWg2SLb9Dg+TWi6lXJUIdSM4iUKkEAdS4wG
	QqZmkROtTjEtMF/4gH85aUEWafPCZYzWmPKv3IT6yN9/Cu5XSyX2iRktcAiTwzzDQNUS8cWOWIe
	PwipwixiWYTKCbuZnkRwUQgz6xsU2XG1lL1OeTcfbtPAgHq0xTCFpL23tuZbRcdJ93qqdxXCYaN
	p3bBlZlk0ZBZ/rOox4H1o8yHsjteFH+ZCGu7Y/iBZbj5SI3RP72g78vtg6N4pi9rdjpnx0VoEgj
	mWo86s2yoNJKVfuCO9V3pWRHGR5NWY1ElX2yoe9+OteBeN1nf931MMr
X-Received: by 2002:a05:693c:4159:20b0:34c:8c69:529d with SMTP id 5a478bee46e88-3537e0a9695mr19809272eec.26.1791911558689;
        Tue, 13 Oct 2026 10:12:38 -0700 (PDT)
Received: from 1u1g-b650-0212.nvidia.com ([72.25.70.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35a352d4b05sm25620546eec.19.2026.10.13.10.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:12:37 -0700 (PDT)
From: samarth.colleges@gmail.com
To: Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [PATCH] iommufd/iova_bitmap: fail GET_DIRTY_BITMAP when a bitmap page cannot be pinned
Date: Tue, 13 Oct 2026 10:10:45 -0700
Message-ID: <20261013171045.3104619-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samarth Narang <samarth.colleges@gmail.com>

The iova_bitmap_set() function reports dirty IOVAs into a user-provided bitmap, it does so by
pinning the bitmap pages lazily one chunk at a time as the reported IOVA advances.
When advancing to the next chunk fails, the function simply returns without recording the dirty bits.

	if (iova_bitmap_advance_to(bitmap, iova))
		return;

So on an IOMMU_HWPT_GET_DIRTY_BITMAP ioctl, if any bitmap chunk past the
first cannot be pinned, the dirty pages in that chunk are cleared in the page table,
not set in the bitmap, and the ioctl will still return success.
This means that the destination VM will observe stale memory.

This patch records the first such error in the iova_bitmap and propagates it so the
ioctl fails instead of silently succeeding.

Fixes: 4a00f9434891 ("iommupt: Add read_and_clear_dirty op")
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4e447ce74..e6540b0a2 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -589,7 +589,7 @@ iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	arg.iopt = iopt;
 	arg.domain = domain;
 	arg.dirty = &dirty;
-	iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
+	ret = iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
 
 	if (!(flags & IOMMU_DIRTY_NO_CLEAR))
 		iommu_iotlb_sync(domain, &gather);
diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index dac3e657d..483f0cc84 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -116,6 +116,9 @@ struct iova_bitmap {
 
 	/* length of the IOVA range for the whole bitmap */
 	size_t length;
+
+	/* first error from pinning a bitmap chunk; -EFAULT etc. */
+	int err;
 };
 
 /*
@@ -384,7 +387,9 @@ static int iova_bitmap_advance_to(struct iova_bitmap *bitmap,
 int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 			 iova_bitmap_fn_t fn)
 {
-	return fn(bitmap, bitmap->iova, bitmap->length, opaque);
+	int ret = fn(bitmap, bitmap->iova, bitmap->length, opaque);
+
+	return ret ? ret : bitmap->err;
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_for_each, "IOMMUFD");
 
@@ -411,8 +416,13 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 		 * may fail if it's out of bounds, or pinning the pages
 		 * returns an error.
 		 */
-		if (iova_bitmap_advance_to(bitmap, iova))
+		int ret = iova_bitmap_advance_to(bitmap, iova);
+
+		if (ret) {
+			if (!bitmap->err)
+				bitmap->err = ret;
 			return;
+		}
 	}
 
 	last_page_idx = mapped->npages - 1;
