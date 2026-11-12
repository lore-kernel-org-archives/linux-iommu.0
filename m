Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496259;
	b=XwxfhjgJwK0AWStARb25NTAT2fi0ql9FQquoY7cszHbhflP3lVe0l+SLTvBFDqFL1cyj
	 wHfjcmq/lG0gnMQ/BynPXwXlcPVQhkDWIigQ/hQmKk7zSSLmDoNxsIILChOMSRuG871Le
	 u6CRh/rwSm6HoGMlM5sx8zjaMZq01980eK+3AiedMR88CflA/zHztde/fmt3pcMKA5eKx
	 fhCYN+XSoQcAoeaLoJs8g6MP14rJumkeQcVsBtzdReRTzhiNG/7nWv5X/QNu24PyybLEV
	 3X/8J+NvpG+wGaKkISg4kI7FpB/8Eouim1UXz9WjJ0hdxI3LuK4CpmYS4CNngziqWGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6EicqY9ZopPI8vrn/BeUNEOWrezJd76xi93YUaHI18g=;
	b=c8Qhettn6vPyoNcq1MDXrq48OtUF/cvBVnQpcXBbuwzbX2f9CyA9oDWAqT13XaclATTq
	 GkjWr4OkNHcbZLIP7IBIotCRrrqTxzIA94XxGrPfkYJQREnZSYbk6jukMs4dYg5Rnbj0G
	 +68ccCtZTGbLcivpq2rSOsZRT93/Tt1iwcWbv4CWrm3Qdl6ZSipkrytYU2Hsod+HR/NOe
	 6ShHbD00UfiV8NOAD0KslzB5xz9pQUUH22S22QQD/RuSkqsIe6EUFoXtvworPwnRXqzBy
	 i2wgHCtSf81/RO2YrMK/i6u6m4opPDuW8oo2arDQtVKQJxqm0EvqpcK/WiFbDqKppkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--praan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CSBZA07C;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CADB606A321
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 15:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CADB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CSBZA07C
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b930598cf0so5493756b3a.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 07:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794496258; x=1795101058; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6EicqY9ZopPI8vrn/BeUNEOWrezJd76xi93YUaHI18g=;
        b=CSBZA07Cm6zWDLsblGDhndfJmEi5HhAkHbU3Of0U1cIiY4/T4aYFQR+dosAcJGHO2l
         Dj3NpfZuzMUeOI7SDc20Wv92uhehL9NyXQG5/O44q8cJVwWqu7Kvc2q7gEP4g5F7jKgc
         wTzaL9H02/V09BJYVjZtZzV7geU0dx4iMi8t0K1Jp/A/WZ+qipFX+n/6s0uemETr3zTy
         5/jJ8MLVbbeMr6Gq9Vze9wtKDvfgPJzfZgqW3sZl1WmnuLa5ip9y3zjP+bxarOcd2Arj
         MQy73TAIA7cQv3xqz35aote3WWWIh+aWGyMWQGW6bB1JNTUkfC8cfH/agarIbj8DU5Ku
         s3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496258; x=1795101058;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EicqY9ZopPI8vrn/BeUNEOWrezJd76xi93YUaHI18g=;
        b=flqMAe45mhTQJ+L76SMJ57r1+aIIOEEqVIRJ13jh198MEWrlKUvzFe4Q1mKumyK6Up
         ityj/Gk3Y74Z/sWHYd7Cx+9SHgZa2hRFoZ13Fjvm8YOuLimaIOQKT8AjTb6DLjfAfToo
         XuFEM0PHudhju5mTCHfFDYC/90CCJITOee8qMOaBteB2kHpnZbcrPxN3qZt0VabdJhXE
         lmRwZZh+uULQCE9DcX2RKaTQ3QIknzIT9+XhgfSi6kEmXdAb8UNjJKz2hUktmHFhl9nk
         2ajjgcoN0nFFAyxgx42I92Oa3g9OzlJPOvUogN+haZ1V5orzlQJQ+U+qx1Akl6tnzOSA
         40zQ==
X-Forwarded-Encrypted: i=1; AL+hErHaFNTKD1iK9guj0+QjWojaa4ZYLtUWImybKtliCwrhGqBT6xrLTI6wU+nbR6NWjt+n/BRA1w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9jOw8IfipW0OVOM2+CcJHnBrbo0oC2iIHaRWAVv0uSihOZhq2V
	QL7Asv7oFKlUwz9DVpAO/lqUJT7JIJJA8+hCOoJAYkCQRNupLTyRB33jpd05L544s86aHBNDG42
	YNw==
X-Received: from pfdj22.prod.google.com ([2002:a05:6a00:9516:b0:8b5:ec46:d313])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:388:b0:3c3:a3f4:5485
 with SMTP id adf61e73a8af0-3f2fa391439mr5495349637.6.1794496258237; Thu, 12
 Nov 2026 07:10:58 -0800 (PST)
Date: Thu, 12 Nov 2026 15:10:39 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112151039.2083705-1-praan@google.com>
Subject: [PATCH v2] iommu: Honor iommufd uapi for zero entry_num args
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>, 
	iommu@lists.linux.dev, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The IOMMU_HWPT_INVALIDATE ioctl uAPI explicitly allows an empty
invalidation request array by setting entry_num == 0. The uAPI
documentation in include/uapi/linux/iommufd.h mentions:

  " An empty invalidation request array by setting @entry_num==0
    is allowed, and @entry_len and @data_uptr would be ignored in
    this case."

While the core iommufd_hwpt_invalidate() handler honors this by
skipping its bounds checks, the generic array copy helper
iommu_copy_struct_from_full_user_array() still rejects it by
returning -EINVAL, forcing arm_vsmmu_cache_invalidate() to
special-case it.

Return 0 instead of -EINVAL when entry_num is 0 and drop the now
redundant checks in arm_vsmmu_cache_invalidate().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c   | 15 +++++----------
 include/linux/iommu.h                             |  5 +++--
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ab1078a97d80..74210867f204 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -491,15 +491,6 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 
 	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
 
-	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* A zero-length array only probes the type, validated above */
-	if (!array->entry_num)
-		return 0;
-
 	/*
 	 * The core re-invokes this op for the remaining requests, so copy one
 	 * cmdq batch worth of commands into a fixed on-stack buffer rather than
@@ -509,7 +500,11 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 	ret = iommu_copy_struct_from_full_user_array(
 		cmds, sizeof(*cmds), &batch,
 		IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3);
-	if (ret)
+	/*
+	 * A zero-length array only probes the data type, which the copy has
+	 * validated; skip issuing a bare CMD_SYNC for it.
+	 */
+	if (ret || !batch.entry_num)
 		goto out;
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 05f7cee1375e..5b5e82b21d0b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -556,7 +556,8 @@ static inline int __iommu_copy_struct_from_user_array(
  * @data_type: The data type of the @kdst. Must match with @user_array->type
  *
  * Copy the entire user array. kdst must have room for kdst_entry_size *
- * user_array->entry_num bytes. Return 0 for success, otherwise -error.
+ * user_array->entry_num bytes. An empty array copies nothing, though its
+ * @data_type is still validated. Return 0 for success, otherwise -error.
  */
 static inline int
 iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
@@ -569,7 +570,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
 	if (user_array->type != data_type)
 		return -EINVAL;
 	if (!user_array->entry_num)
-		return -EINVAL;
+		return 0;
 	if (likely(user_array->entry_len == kdst_entry_size)) {
 		if (copy_from_user(kdst, user_array->uptr,
 				   user_array->entry_num *
-- 
2.56.0.567.gdb80ae8cd5-goog

