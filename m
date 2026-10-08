Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B849EC4C
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463951; cv=none; b=uZClnYwc23dlarrWM8XRDWSOXOKR7E70Bo7JfUpyR79SFKwiw92qqi+yoQdn+PMzuhWUp92gp4oJH5oFOU+jUjOe2j+RVIoH/h8n1TO8zy72eEG7lHn7PD2NebtA0Hfhu/Lytp8nGAKGyZ64HXnO5YyENTYgZ6H2L7X3rOkCXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463951; c=relaxed/simple;
	bh=Wk3GMpFjIDl4QJkl4IKzSh8OdV8Drwf9bMXDLiPrdTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6LcUnZw9zkRW7UVyNR/ohE+lbWQWxHD732J5TYdaoAfBwYP0peBFiug11ZzlGmYByL2UffHvs8HLQqfZryevFJ0YOxHLMvAPj/rU7xZ9chhzcGyaFeVuY7AeGTM/WyU6Uw49SwNslsWvLzhObi0mgc42YNEiBj7X+gaPaSd+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwiDOewd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwiDOewd"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so4471278f8f.1
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791463946; x=1792068746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oP3CoR3Js1p41C4R3FYAhUOlcXWKDV5aZYuCff3A1Zc=;
        b=WwiDOewdPpNQDZDZk7h8xI5sKfcwTKeMl5v/gOcSOIBpJb0JzmCVr2DI0lZmxWPFxF
         lvAY3ORzx/mCBy6n1yvRbwznEWLk0wnoVMhJfANszkv2LqtLRj/3YU80f31N2H9rzpQK
         skNBpQhloIGKwgMTzFpxm+hA72sau1g7Gl01SKnPBNa7ePrC6Y9juvrQeizXznktQEF6
         vdcYKklnOZdFkCJgXJfABaM4DVhYhuSFGbWMnrQrOUYVvuc5HxC637PiW+HshKJzDyYW
         ZWU4pTZ8+hFYWtTk+ppIvbhaBVKa43FEuHoKACxMZ7J1XRs+tiiNepz163heKgiirKGR
         IuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463946; x=1792068746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oP3CoR3Js1p41C4R3FYAhUOlcXWKDV5aZYuCff3A1Zc=;
        b=asjJP7WYAWIoaKbn697MY9Ynlkp1y5rbJqxymm8NfD9ElhgwlQUOfwfE3JX0f4eWgH
         7Kv/mW2b5fGiVRZ96x+HPSZ27pVmaQGjjpA63M/oyQvzMfX+GKpJDN0k8dtrwFT6u04r
         Nym/W3Rquwlaa0T/SYBpwfNgICqCwS8WW10n3tFcrRADLZA61j24aZsjwRd11pKKcIAp
         lxnDHtQ4QdK/we0tyvEi6UGjS/DuBAb9gjw43+6qyCzoF35sZcY2E+jtfZA/jmGReSLc
         vv0jUO/0gAAlN82gUfxtI73TJ/Sy/8SCYXiUBNwhuCdQW1J1AFcLXb47OqR52y+9690G
         Ztlw==
X-Forwarded-Encrypted: i=1; AKwUvBwn5xDV3n2mLP2Mq+9BWiCUmiQlEdUGRnRz+kR2YYqi+XOmpFqYKiw/mdwvLGUWhxupopHSOQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJWOkE5KbAP86HFToWt22RRB7rVA5TYkpIbBLyFumRhIcGNxKrS
	YsXNIqApcQazskd9GAsrgun3WrIUJLiZHYmxqE835hqLN4NFZWYOti8/
X-Gm-Gg: AYBFou1loP+93TrCeBVjCN0lDjmDbFxTNEImw8iUAL1PdDhUbBwZ4khZIb4+UKe4k+M
	rcVndMdsb/wUB/hLK7z2MVb0DgZQLXPyA3VYxQ5w1a9VKyAPYlDj/w2l01K1fXqcLacAxiARRQm
	G356FNJ4kMD8Ms7wjyQ6Uo7qtJWgdun8lQLGDeIvtImC/sEILJY5oHAv2AESMvaDkIat/DyxZ+B
	fWkV0eoDaI5xXUCV7XCHaPV3Iq473lPFhypNLB6c322XZ7QtjkNRvVBjoAdbkrl+cMQKvjquvnH
	5U+7/LQQkt1mqbDNlXxhXGoJ2gO4jx2fJQ+qBDKm6iDOWBUNhXOxj6ZdeHrzHPZMBcSYq3Cgouk
	u9YE5K33bUrG7PBKxeUdEz0Y3gdqMvDWOJt+2RKUddddbypwJtsdGG/lIGujRh18NvDgqFshiJg
	o+0ac+KSWaEs5tQl8SkSTQvZ0wVSJpzl7DkS+Z7xFnLPyeQf/vun5Ag7ukRtkSN61so0mMLmdkh
	56mo1RotKzFhXQwnDQkEzdE+Cjo8aEQYya0NHiyCsY+V3s8ZIMYnOk=
X-Received: by 2002:a05:6000:4a18:b0:48b:e25:21d6 with SMTP id ffacd0b85a97d-48c7289e37dmr9164721f8f.41.1791463946411;
        Thu, 08 Oct 2026 05:52:26 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.41.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3032csm10584338f8f.45.2026.10.08.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:52:24 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iommufd/selftest: Check dmabuf MMIO mappings filled from another domain
Date: Thu,  8 Oct 2026 14:52:04 +0200
Message-ID: <20261008125206.11990-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008125206.11990-1-parri.andrea@gmail.com>
References: <20261008125206.11990-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that a dmabuf keeps IOMMU_MMIO in a domain that is filled
from an already mapped area: a second domain added to the IOAS after
the dmabuf has been mapped, and the domain of another IOAS the dmabuf
is copied into.

The mock page table has no memory type bits, so a mapping made with
IOMMU_MMIO cannot be told apart from one made with IOMMU_CACHE. Wrap the
mock's generic_pt map_range and unmap_range ops to record, per domain,
the pages mapped with IOMMU_MMIO, and add IOMMU_TEST_OP_MD_CHECK_MMIO to
check that a range is recorded. The check rejects ranges that wrap or
do not fit in unsigned long.

dmabuf_mmio_new_domain maps a mock dmabuf, checks the existing domain,
allocates a second HWPT on the same IOAS and checks it too.
dmabuf_mmio_copy maps a mock dmabuf, copies it with IOMMU_IOAS_COPY into
a second IOAS that has its own mock domain, and checks that domain.
Without the previous patch the checks on the second domain fail in the
three mock domain variants; with it all checks pass.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  5 +
 drivers/iommu/iommufd/selftest.c              | 92 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 51 ++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 13 +++
 4 files changed, 161 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 52b78cbcc920d..3c8111dfb928a 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -31,6 +31,7 @@ enum {
 	IOMMU_TEST_OP_PASID_CHECK_HWPT,
 	IOMMU_TEST_OP_DMABUF_GET,
 	IOMMU_TEST_OP_DMABUF_REVOKE,
+	IOMMU_TEST_OP_MD_CHECK_MMIO,
 };
 
 enum {
@@ -109,6 +110,10 @@ struct iommu_test_cmd {
 			__aligned_u64 length;
 			__aligned_u64 uptr;
 		} check_map;
+		struct {
+			__aligned_u64 iova;
+			__aligned_u64 length;
+		} check_mmio;
 		struct {
 			__aligned_u64 length;
 			__aligned_u64 uptr;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 25387969ab753..920393b693f26 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -120,6 +120,10 @@ struct mock_iommu_domain {
 		struct pt_iommu_amdv1 amdv1;
 	};
 	unsigned long flags;
+	/* map_range/unmap_range wrappers record IOMMU_MMIO pages */
+	const struct pt_iommu_ops *pt_ops;
+	struct pt_iommu_ops rec_ops;
+	struct xarray mmio_pages;
 };
 PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, iommu, domain);
 PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, amdv1.iommu, domain);
@@ -392,6 +396,7 @@ static void mock_domain_free(struct iommu_domain *domain)
 	struct mock_iommu_domain *mock = to_mock_domain(domain);
 
 	pt_iommu_deinit(&mock->iommu);
+	xa_destroy(&mock->mmio_pages);
 	kfree(mock);
 }
 
@@ -423,6 +428,51 @@ static const struct iommu_dirty_ops amdv1_mock_dirty_ops = {
 	.set_dirty_tracking = mock_domain_set_dirty_tracking,
 };
 
+static int mock_map_range(struct pt_iommu *iommu_table, dma_addr_t iova,
+			  phys_addr_t paddr, dma_addr_t len, unsigned int prot,
+			  gfp_t gfp, size_t *mapped)
+{
+	struct mock_iommu_domain *mock =
+		container_of(iommu_table, struct mock_iommu_domain, iommu);
+	unsigned long index;
+	int rc;
+
+	rc = mock->pt_ops->map_range(iommu_table, iova, paddr, len, prot, gfp,
+				     mapped);
+	if (rc || !(prot & IOMMU_MMIO))
+		return rc;
+
+	for (index = iova / MOCK_PAGE_SIZE;
+	     index <= (iova + len - 1) / MOCK_PAGE_SIZE; index++) {
+		rc = xa_err(xa_store(&mock->mmio_pages, index, xa_mk_value(1),
+				     gfp));
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+static size_t mock_unmap_range(struct pt_iommu *iommu_table, dma_addr_t iova,
+			       dma_addr_t len,
+			       struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct mock_iommu_domain *mock =
+		container_of(iommu_table, struct mock_iommu_domain, iommu);
+	unsigned long index;
+	size_t unmapped;
+	void *entry;
+
+	unmapped = mock->pt_ops->unmap_range(iommu_table, iova, len,
+					     iotlb_gather);
+	if (!unmapped)
+		return 0;
+
+	xa_for_each_range(&mock->mmio_pages, index, entry, iova / MOCK_PAGE_SIZE,
+			  (iova + unmapped - 1) / MOCK_PAGE_SIZE)
+		xa_erase(&mock->mmio_pages, index);
+	return unmapped;
+}
+
 static struct mock_iommu_domain *
 mock_domain_alloc_pgtable(struct device *dev,
 			  const struct iommu_hwpt_selftest *user_cfg, u32 flags)
@@ -434,6 +484,7 @@ mock_domain_alloc_pgtable(struct device *dev,
 	if (!mock)
 		return ERR_PTR(-ENOMEM);
 	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
+	xa_init(&mock->mmio_pages);
 
 	mock->amdv1.iommu.nid = NUMA_NO_NODE;
 
@@ -454,6 +505,12 @@ mock_domain_alloc_pgtable(struct device *dev,
 		if (rc)
 			goto err_free;
 
+		mock->pt_ops = mock->iommu.ops;
+		mock->rec_ops = *mock->pt_ops;
+		mock->rec_ops.map_range = mock_map_range;
+		mock->rec_ops.unmap_range = mock_unmap_range;
+		mock->iommu.ops = &mock->rec_ops;
+
 		/*
 		 * In huge mode userspace should only provide huge pages, we
 		 * have to include PAGE_SIZE for the domain to be accepted by
@@ -1180,6 +1237,37 @@ static int iommufd_test_add_reserved(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+/* Check that every page in [iova, iova + length) was mapped with IOMMU_MMIO */
+static int iommufd_test_md_check_mmio(struct iommufd_ucmd *ucmd,
+				      unsigned int mockpt_id,
+				      u64 iova, u64 length)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	unsigned long index;
+	u64 last;
+	int rc = 0;
+
+	if (!length || iova % MOCK_PAGE_SIZE || length % MOCK_PAGE_SIZE ||
+	    check_add_overflow(iova, length - 1, &last) || last > ULONG_MAX)
+		return -EINVAL;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	for (index = iova / MOCK_PAGE_SIZE;
+	     index <= last / MOCK_PAGE_SIZE; index++) {
+		if (!xa_load(&mock->mmio_pages, index)) {
+			rc = -EINVAL;
+			break;
+		}
+	}
+
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+	return rc;
+}
+
 /* Check that every pfn under each iova matches the pfn under a user VA */
 static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 				    unsigned int mockpt_id, unsigned long iova,
@@ -2105,6 +2193,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 	case IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE:
 		return iommufd_test_mock_domain_replace(
 			ucmd, cmd->id, cmd->mock_domain_replace.pt_id, cmd);
+	case IOMMU_TEST_OP_MD_CHECK_MMIO:
+		return iommufd_test_md_check_mmio(ucmd, cmd->id,
+						  cmd->check_mmio.iova,
+						  cmd->check_mmio.length);
 	case IOMMU_TEST_OP_MD_CHECK_MAP:
 		return iommufd_test_md_check_pa(
 			ucmd, cmd->id, cmd->check_map.iova,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 44193d171ba98..8f68c9aee15d5 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1599,6 +1599,57 @@ TEST_F(iommufd_ioas, dmabuf_simple)
 	close(dfd);
 }
 
+TEST_F(iommufd_ioas, dmabuf_mmio_new_domain)
+{
+	size_t buf_size = PAGE_SIZE * 4;
+	__u32 hwpt_id;
+	__u64 iova;
+	int dfd;
+
+	if (!variant->mock_domains)
+		SKIP(return, "needs a mock domain");
+
+	test_cmd_get_dmabuf(buf_size, &dfd);
+	test_ioctl_ioas_map_file(dfd, 0, buf_size, &iova);
+	test_cmd_md_check_mmio(self->hwpt_id, iova, buf_size);
+
+	/* A domain added later is filled from the already mapped area */
+	test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0, &hwpt_id);
+	test_cmd_md_check_mmio(hwpt_id, iova, buf_size);
+
+	test_ioctl_destroy(hwpt_id);
+	close(dfd);
+}
+
+TEST_F(iommufd_ioas, dmabuf_mmio_copy)
+{
+	size_t buf_size = PAGE_SIZE * 4;
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE,
+		.src_ioas_id = self->ioas_id,
+		.length = buf_size,
+	};
+	__u32 stdev_id;
+	__u32 hwpt_id;
+	int dfd;
+
+	if (!variant->mock_domains)
+		SKIP(return, "needs a mock domain");
+
+	test_cmd_get_dmabuf(buf_size, &dfd);
+	test_ioctl_ioas_map_file(dfd, 0, buf_size, &copy_cmd.src_iova);
+
+	/* The copy is filled from the domain of the source IOAS */
+	test_ioctl_ioas_alloc(&copy_cmd.dst_ioas_id);
+	test_cmd_mock_domain(copy_cmd.dst_ioas_id, &stdev_id, &hwpt_id, NULL);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+	test_cmd_md_check_mmio(hwpt_id, copy_cmd.dst_iova, buf_size);
+
+	test_ioctl_destroy(stdev_id);
+	close(dfd);
+}
+
 TEST_F(iommufd_ioas, dmabuf_revoke)
 {
 	size_t buf_size = PAGE_SIZE*4;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index b4928cbd4d9c8..4567a69de8df6 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -560,6 +560,19 @@ static int _test_cmd_destroy_access_pages(int fd, unsigned int access_id,
 	EXPECT_ERRNO(_errno, _test_cmd_destroy_access_pages(              \
 				     self->fd, access_id, access_pages_id))
 
+#define test_cmd_md_check_mmio(_hwpt_id, _iova, _length)                     \
+	({                                                                   \
+		struct iommu_test_cmd check_cmd = {                          \
+			.size = sizeof(check_cmd),                           \
+			.op = IOMMU_TEST_OP_MD_CHECK_MMIO,                   \
+			.id = _hwpt_id,                                      \
+			.check_mmio = { .iova = _iova, .length = _length },  \
+		};                                                           \
+		ASSERT_EQ(0, ioctl(self->fd,                                 \
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MMIO), \
+				   &check_cmd));                             \
+	})
+
 static int _test_cmd_get_dmabuf(int fd, size_t len, int *out_fd)
 {
 	struct iommu_test_cmd cmd = {
-- 
2.53.0

