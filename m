Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116239;
	b=FiHKAAwpzs3YztpI4gn0UsRUAErnnTh/dDIjzyKHKjOrUfEI+SNIEJAlUHxf8n2KGfUw
	 zindEXcWC6SBMP1yO4mhhpxujUq4fXJydW7kZc3IrXerJUBLQtybj9xWh8JVt1yvm8M8G
	 IAgbelYX6PNXHYFWovK9BbWGON42j93w0lCKhfYeNTgas46w/IWlux7RytPMPAsxQSHLD
	 tohmRrLblqKBH4vv8A7oFY3pyKMk6gUAXfts/ZnwZJ3OOklewsPFQYVUc6iN7ALycCX+B
	 IUoCO1+NRf83bV41q/nRssA1zX1bNdBgc7lYM+8mthQAhci9Hf0+bB76Lqd7SdeeW0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=CrF3nFAcJDY76kOF2hHER5D9X1eXwFds2Fdu+YPAT14=;
	b=vLDu4FRDEruySTILMXEv3QZPGtlGC4gcWfguKsHq+vQXCknzR1D9UAE2dm79ZCtUIFBt
	 qXRscmi/TS8sqJ/L9XuDN7z9oNZxJvaZacsp/aqf17rg6X4XuDao3+uAhbMCv9QbZkS4a
	 SiZ8DHLkBfuDZFPaM1g9oyiuOv3I5JWd3UL4CgZUow2xJLX3l39q76YVmjuCjjFcBoR+Y
	 PN144h0iUIoZ0mxuPCVbJgKXwOCYraB6QXhltk6ADi/+5Gt2i4B2G6YKK2WO5U5SSn3Gv
	 yq3q4XEqV3i6UAU/Z37hAA5wXKpgaJzjwlUlvkBCg6D+b65h9CUihkwAcZ+Iw976geQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--praan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Au/iMimr";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9722606A326
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 19:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9722606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Au/iMimr
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b3a73a82a1so182789a91.2
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116238; x=1795721038; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CrF3nFAcJDY76kOF2hHER5D9X1eXwFds2Fdu+YPAT14=;
        b=Au/iMimrO2R1RGo7zphgOc1sIF6uQT7fxKTg7EG9FWi84RfTrPzT85gyM2cxoS8Exw
         71XfWLniIE51AlH06KNUna4gjEePR3YTKEFDZQmvrCaIlAkycttb+tMhgLnbQKJ1wEru
         UmHQdCXDgZuIiX+uiLiNu6KiQcfSe4nnsi2bFzKajnKRsuK0QJZOuMJjrZX8EpNPZbOA
         6cObzowQ7tklnOJznDIKWh/ffiS5RMUvYKldJyCvXkYaDiRAKk3jPxXPEFgf1rtOcrCq
         CicMtsfsm6JKYWkL89QlwM3RziYFgKhHqmw+85IG9Eu/FzKUtIIAdQzSlmQMSPaP5Y03
         +pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116238; x=1795721038;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CrF3nFAcJDY76kOF2hHER5D9X1eXwFds2Fdu+YPAT14=;
        b=TcHVTD72gz1Oyv6I6xuTS8w6mU3+uy9UgOg7od1/8WVBvIcdfuq6M3TReySc+trHKn
         tB3vZbd5qZYs3l7aeeEO6GFnGF6QDUZQdRnoIhT8Ou0CBY0mkr1CUqIzp2+6fMhUrh2C
         1LtQeuzetr3Ty+FMePBlRLjw+NhO2wuZc/XbbD8k2S3VuNAKqLoORTpW7Dup65X+LpoL
         ijb/lRTj+xmVAyC1xgF69Tb2yzqfWJR4MHOBcPzL8o1OkY1lPIOlmf2+Yz/XcQMbnVtq
         EN4/cuS5n54ODg/d9b+IEJxEPtmr84z+MWwwnxu8Yo/n3Quai16m5s2Lsz2QW6wO0r7r
         J0bw==
X-Forwarded-Encrypted: i=1; AL+hErHMbbFCLsbvVWLOKyPSB7pjPs9NX5TdyeO27DrFrZ/IfgeSdFbqDpBb0PVXQ5i+e7o3c+WTeA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Ge/1ouWo+pqcrQNWkI8nTqQ8VXHC0MhdNWtae1OpfEc2iGgRy
	7HnHqObewzjWtqhkOmtO0/E2nDo+u64jOMiMIxtwdCbWtgE5pHIt3CpBkbz+Ej7YHRfq5oRm+rw
	S9w==
X-Received: from pjbrm6.prod.google.com ([2002:a17:90b:3ec6:b0:3b3:a2d4:ce8])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c84:b0:3b4:a90:7f2e
 with SMTP id 98e67ed59e1d1-3b41c7c4e5cmr415179a91.5.1795116238132; Thu, 19
 Nov 2026 11:23:58 -0800 (PST)
Date: Thu, 19 Nov 2026 19:23:55 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192355.2428207-1-praan@google.com>
Subject: [PATCH v3] iommu: Clarify uAPI errno for unsupported data types
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>, 
	iommu@lists.linux.dev, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The IOMMU_HWPT_INVALIDATE uAPI says that an empty request array "can be
used to check if the given @data_type is supported or not by kernel",
but not what to look for. And the iommu_copy_struct_*() helpers and the
Intel VT-d, ARM SMMUv3 and selftest invalidation ops reject unsupported
data types with -EINVAL, which means that the request was understood but
a field is not correct.

Return -EOPNOTSUPP for an unsupported data type instead and document it
as what the probe looks for. Since arm_vsmmu_alloc_domain_nested() uses
the copy helper, it now returns -EOPNOTSUPP, like the other nested
domain allocators. Update and extend the selftests accordingly.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c      |  2 +-
 drivers/iommu/intel/nested.c                   |  2 +-
 drivers/iommu/iommufd/selftest.c               |  4 ++--
 include/linux/iommu.h                          |  6 +++---
 include/uapi/linux/iommufd.h                   |  3 ++-
 tools/testing/selftests/iommu/iommufd.c        | 18 ++++++++++++++++--
 6 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e68b46485095..51c2b13cf280 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -493,7 +493,7 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
 
 	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3) {
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index df72724242bf..b024688b0bb5 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -99,7 +99,7 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 	int ret = 0;
 
 	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_VTD_S1) {
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 037e54f3d2ba..dfe7cdb1b12f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -642,7 +642,7 @@ static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
 	int i;
 
 	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST) {
-		rc = -EINVAL;
+		rc = -EOPNOTSUPP;
 		goto out;
 	}
 
@@ -876,7 +876,7 @@ mock_domain_cache_invalidate_user(struct iommu_domain *domain,
 	int i;
 
 	if (array->type != IOMMU_HWPT_INVALIDATE_DATA_SELFTEST) {
-		rc = -EINVAL;
+		rc = -EOPNOTSUPP;
 		goto out;
 	}
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a36..253ac566aaf7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -470,7 +470,7 @@ static inline int __iommu_copy_struct_from_user(
 	if (WARN_ON(!dst_data || !src_data))
 		return -EINVAL;
 	if (src_data->type != data_type)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	if (src_data->len < min_len || data_len < src_data->len)
 		return -EINVAL;
 	return copy_struct_from_user(dst_data, data_len, src_data->uptr,
@@ -567,7 +567,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
 	int ret;
 
 	if (user_array->type != data_type)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	if (!user_array->entry_num)
 		return -EINVAL;
 	if (likely(user_array->entry_len == kdst_entry_size)) {
@@ -609,7 +609,7 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
 	if (WARN_ON(!dst_data || !src_data))
 		return -EINVAL;
 	if (dst_data->type != data_type)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	if (dst_data->len < min_len || data_len < dst_data->len)
 		return -EINVAL;
 	return copy_struct_to_user(dst_data->uptr, dst_data->len, src_data,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 010f47f7d3d2..79424a8c1b5a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -986,7 +986,8 @@ struct iommu_viommu_arm_smmuv3_invalidate {
  *
  * An empty invalidation request array by setting @entry_num==0 is allowed, and
  * @entry_len and @data_uptr would be ignored in this case. This can be used to
- * check if the given @data_type is supported or not by kernel.
+ * check if the given @data_type is supported or not by kernel: the ioctl fails
+ * with -EOPNOTSUPP for an unsupported @data_type.
  */
 struct iommu_hwpt_invalidate {
 	__u32 size;
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 964df8f73610..1e58ab4c292e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -536,9 +536,16 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 					 sizeof(*inv_reqs), &num_inv);
 		assert(!num_inv);
 
+		/* Negative test: Invalid data_type with zero-length array */
+		num_inv = 0;
+		test_err_hwpt_invalidate(EOPNOTSUPP, nested_hwpt_id[0], inv_reqs,
+					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST_INVALID,
+					 sizeof(*inv_reqs), &num_inv);
+		assert(!num_inv);
+
 		/* Negative test: Invalid data_type */
 		num_inv = 1;
-		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0], inv_reqs,
+		test_err_hwpt_invalidate(EOPNOTSUPP, nested_hwpt_id[0], inv_reqs,
 					 IOMMU_HWPT_INVALIDATE_DATA_SELFTEST_INVALID,
 					 sizeof(*inv_reqs), &num_inv);
 		assert(!num_inv);
@@ -3090,9 +3097,16 @@ TEST_F(iommufd_viommu, vdevice_cache)
 				   &num_inv);
 	assert(!num_inv);
 
+	/* Negative test: Invalid data_type with zero-length array */
+	num_inv = 0;
+	test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
 	/* Negative test: Invalid data_type */
 	num_inv = 1;
-	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+	test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
 				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
 				   sizeof(*inv_reqs), &num_inv);
 	assert(!num_inv);
-- 
2.56.1.750.gf70dc682cf-goog

