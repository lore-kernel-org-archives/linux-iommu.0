Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1C3E5EEC
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652379; cv=none; b=Lo210D4fyZ855YgvAZiWiMCBNBSdTKi7SxMgvMPJQannUpB2zcpRPtjUmzaMSo03z1ADn7vqIRDke6QIXLo+V/NZwYQf4rF+WGXX0TX3ROZa85fAARrE1u8dgYojmq/vbI6g9haojdtt07SGjFKwegB07C4c0MiH3d2Vskop8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652379; c=relaxed/simple;
	bh=kC0aTN0K7u9RCDOE2X6e4KofmqQ39JXeOz9FhSIz23Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R35zLxY69CbkxdMwRHWQLpa8kumlwRBEglajKp29OFZ8WT3c50K750MJbBFLvFXTT3y1TwQidoWBX6CwoZD5m3NTiYpdNkviOAgdTme17UnDX6FA+DPVNC6acHFvOpyDoICWTnqlQ1dmtfHnMGg/lyscSsoe7KtvggVzl7x37Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECaStI30; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECaStI30"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4a45b3f0becso4166624b6e.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787652377; x=1788257177; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITNgIlTwsBrNBLrYNkaCeP0gJOrZpKRql3oj7U2AlDY=;
        b=ECaStI30AwVW9OM7EI4HihC1FaLfA9JkSKjCjzhARFCXyGoP4NKL1RFuB9Z2/3QE6y
         fgqKaSWbeU/X2PjQh0KHWphnQwUag84dFs2dj5X8wqhMwGzCKwUEV0vkRnoGK3EA1l8l
         DNdmUT7p51v0sXhnrDy3aQhHiip5IAd3A3eY9pqQPLbmDAaNXxtCDbR4kJ2cx6Gk+aUl
         3CSaPL8PhxDQgzJ0dxcC8dmpj5h6YKR6lUnuP0w/aeBSgZIigW7vbwYEiMHkvNZRxIzG
         SEr2etLue6RPigZpt1/Glx3xs5gLVfnN0I7V/edvmpheoICZqz/4ZLugv9wS+WOci5s1
         n+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652377; x=1788257177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITNgIlTwsBrNBLrYNkaCeP0gJOrZpKRql3oj7U2AlDY=;
        b=Ik498nYC+3AiU6HwL5T7eL4/ia1t6zR5YL1giqVoLUPXElqMR/hAB4s+1UCM0j6EVw
         4+Kig4UFYQYFX+qBDuWrtrCuY95bll9XBvHj69N87K/2QFkuW64x3UG/V/vlTWq8guUK
         7tyEOIZZQIczIWPJOK9LUC4hYUy/ZbwPLPjxnYMA2GHyIW12+5gzu/omryh9Yk+Vxbaw
         SIjy0roUoaelkIvKd/OcoswcZXMXIEajud7WWt5wxObFo67lEO5UWQpNxuD284LGIT2t
         WvYzgdpYXNJ9iuRGRsjOGlMwFrbbPErXiO/Y66GnivHpI13e8VwOoiPzKy4oufUeEGXX
         ALSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqE5ufiYJzA6E11hJWAx5PHAi1Cn96N9qlQQg3WIAoYu0AZtFbmz4qJ/JUyqQgGssg0zBihAA==@lists.linux.dev
X-Gm-Message-State: AFuF++kfCs30rpK6w67I8J1Cyrq/UhN5xQ5AJ3cAuS2qTDvT7t07G7UT
	FakBCj9qPKIG5whprVOMwJ/wYzVwWpEA21it8/rJKRkJBMdgihlp8uZM
X-Gm-Gg: AR+sD11JopXkjd9MtLNnUZInVgCCaq7ughakTukxEG59hQRu8cYWSm2+QPPLpPFh/dq
	iob57Ec91l6st9kKloBOwvTwoHg3j54VSezi9V6ZyXx/kPar/QWYwDxYsTzoWmoZry03kPq2mMb
	krxtGzJJTtmwM0B/TWsIp15c4Q7BXBhRWT0UIMDuMXvacIxWUC4Z3wEzD9o3RAaTCaHRBGD6YuR
	ZlZJ31UOFG6U83OKbtjOsgkogQ5Fb6Rk2IrbrqjPFNQsKp8Pr54IFTNFuaK/uaVoDt8uCefyVJA
	mjHyk1vHsqlY7z0Esb39JJH73Q/+CCHbVo6cEGMSnXwvsr3WEH9btIblA6cJdSWQNad5XCJFp1y
	/IOqJ5Tb6yzp9uzYbHQHQ8XFmLstJyV3dTm9++uX/CLKwlJF+9KMqmyufPgOyTE8ind179jAMyQ
	+9ETQ/wJX4/AK0cdQk5CkV33qhcrH6bfVXbcVqMO5HibPjpk62bKCAPFN3JpumOH/+Eqsns8PFI
	TJy0LKMW1c=
X-Received: by 2002:a05:6808:1201:b0:4a3:3108:866a with SMTP id 5614622812f47-4b2ef480315mr28341239b6e.17.1787652376848;
        Tue, 25 Aug 2026 03:06:16 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183f31sm29502922c88.13.2026.08.25.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:06:16 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@nvidia.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix ineffective error check in nested domain allocation
Date: Tue, 25 Aug 2026 15:35:54 +0530
Message-ID: <20260825100554.2787577-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_iommu_pdom_id_alloc() returns an int: a domain ID on success, or the
negative errno from ida_alloc_range() when the ID space is exhausted or
memory is short.  amd_iommu_alloc_domain_nested() stores that return value
in gdom_info->hdom_id, which is a u32, and only then tests it:

	gdom_info->hdom_id = amd_iommu_pdom_id_alloc();
	if (gdom_info->hdom_id <= 0) {

The assignment discards the sign, so -ENOSPC becomes 0xffffffe4 and the
test never fires.  The nested domain is then set up with a host domain ID
that was never allocated, instead of the allocation failing with -ENOSPC.

Keep the value in an int, test it there, and store it only once it is
known to be valid, which is what the other amd_iommu_pdom_id_alloc()
callers already do.

Fixes: 757d2b1fdf5b ("iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation")
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
Verified by driving amd_iommu_alloc_domain_nested() directly from a debugfs
hook, since the normal entry point needs iommufd to request a nested HWPT on
real hardware.  No error injection was used: the harness allocates domain IDs
until ida_alloc_range() genuinely runs out, then calls the function with a
zeroed guest DTE, which is what validate_gdte_nested() accepts.

Without this patch:

  NESTEDTEST: first alloc, IDs available        -> success, hdom_id=1 (0x00000001)
  NESTEDTEST: second alloc, same gDomID (reuse) -> success, hdom_id=1 (0x00000001)
  NESTEDTEST: exhausted the ID space after 65534 IDs, allocator returns -28
  NESTEDTEST: third alloc, IDs exhausted        -> success, hdom_id=4294967268 (0xffffffe4)

With this patch:

  NESTEDTEST: first alloc, IDs available        -> success, hdom_id=1 (0x00000001)
  NESTEDTEST: second alloc, same gDomID (reuse) -> success, hdom_id=1 (0x00000001)
  NESTEDTEST: exhausted the ID space after 65534 IDs, allocator returns -28
  NESTEDTEST: third alloc, IDs exhausted        -> error -28

The successful and the reuse paths are unchanged; only the exhausted case
differs, and the result was the same in three runs of each kernel.  Built with
CONFIG_AMD_IOMMU_IOMMUFD=y; sparse and checkpatch are clean.

 drivers/iommu/amd/nested.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 63b53b29e029..f1c7987fc585 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -96,7 +96,7 @@ struct iommu_domain *
 amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
-	int ret;
+	int ret, hdom_id;
 	unsigned long irqflags;
 	struct nested_domain *ndom;
 	struct guest_domain_mapping_info *gdom_info;
@@ -161,8 +161,8 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	}
 
 	/* The gDomID does not exist. We allocate new hdom_id */
-	gdom_info->hdom_id = amd_iommu_pdom_id_alloc();
-	if (gdom_info->hdom_id <= 0) {
+	hdom_id = amd_iommu_pdom_id_alloc();
+	if (hdom_id <= 0) {
 		__xa_cmpxchg(&aviommu->gdomid_array,
 			     ndom->gdom_id, gdom_info, NULL, GFP_ATOMIC);
 		xa_unlock_irqrestore(&aviommu->gdomid_array, irqflags);
@@ -170,6 +170,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 		goto out_err_gdom_info;
 	}
 
+	gdom_info->hdom_id = hdom_id;
 	ndom->gdom_info = gdom_info;
 	refcount_set(&gdom_info->users, 1);
 
-- 
2.43.7

