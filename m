Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8EB4AD4BB
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211075; cv=none; b=ojU1Jjxe41gby3nf6hQJIUfu/hcJnFP71HRNn3sDlB9bDxIawfQnEtTiC5zMfPlRuymIceqcWdZBo8EZkj05+VkVZCzcCe9+3P7y43JXqrewJXwqmIId9io1jbdmfyr256OlMpIE+SEos2OIYEmZikMOo6fXCiHsa5v/1gDNdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211075; c=relaxed/simple;
	bh=k2yy0i9Ozd8HQrAbA6lEnQoTA3W+0hKWx+owGdjYlHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHuFIrqq993UKsNeuXnouCl5/jW27ayEvH7AG1s+FRU10Cfw9yRC3fnoliXry5HcU8SBJwAmIOCPRbpJjVU50eM35IlwqvFMlBNIS47Fl9/V2DVVMlubSlCBB3gVJGapHayTWA9AyYQOQcYgGmRCe/h090uFAV7JQZNViiS+A5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGAmPFXg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGAmPFXg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a174a3dc9dso5648595e9.0
        for <iommu@lists.linux.dev>; Mon, 05 Oct 2026 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791211066; x=1791815866; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=20HLnZEOH1hZ+Cvo4bV11ruE2Rlk30tMBQPFR9Y6Sos=;
        b=MGAmPFXgI9LFv/J8EuCXlJPeoSy3DK0Wuk5cbBU/+IoS5MFleqyeM2pRkL+ag4rZd7
         Qcg37X4EkO5ZRm+yoAPdGAWRYNU2gtvzzsO8vBOs6+PyLPRs0URXIoRjQ6ixijLm68q3
         tS9SyXNz11HDfs9FBCka12nIROkbHG5Onodxq+d/gxf4xcRNURYken1N6Bdz1Tx020RA
         QxvdXCNRJWeP7ZCfoRcYGKlrfVarmiz2OEZiBE7ptI0tNckmtCdskCaDsjdjjmk3QrJ4
         Of4l8P1Er9kVJ4gza4sGB1hT2SopH409QHGMJYHgdPaDtd0otLKYUj3UeM0XjyPN+Ezq
         vlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211066; x=1791815866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=20HLnZEOH1hZ+Cvo4bV11ruE2Rlk30tMBQPFR9Y6Sos=;
        b=126g+BCA+s4fbx6cZm7e3F3FsgN0ShknNsyWczLhxy++2BUH/FNawzh/Wi7cxabgEQ
         S8yjPPYqNr3AEtmD37IlcqTbzwA23ubZC3BvoIF2M0zsMY/6IwhEKJwRZTFm7Z7/8rBj
         p1JKwbr70Zmq1n72kmdRlWDRSzJz7sEVxmEVvks4aagNoyVJN0p1vLfOektwvKXXaZCJ
         WhPpDl7uvuTHem6g+K3yOBdNdMA+qVyEk4rZYv3mOChn0bq5vArVa51+NeaorsWHHJrH
         uOrGS+/fjzI4zHl1CqzSh1MZCzqbFBrSATqxqM5EIJz+Pm21DXUYL8Cu2O7eXBJCT4jh
         UeBg==
X-Forwarded-Encrypted: i=1; AKwUvByg1EweBin0WDl1YsLOcvPZkISSJP4mKtGa57hSmzfWQmRRTCnqs618+ZOhbIoZPO58mT/4IA==@lists.linux.dev
X-Gm-Message-State: AFuF++m1wHoufAtDha3XOPHklOvp5RgfPKgfGbcmkCdtXzGin63bPPqW
	1AYv35xXHx5WxOPmLl5LpQDfP2p46d8GsC1c/aDwraJvWpEfUINaKI4m
X-Gm-Gg: AYBFou3q9U40XM/NiEuEp0qSojKCep5PvFsqGAxMnpcljUkerv6pWCt8rByA1Vn6Mgn
	mkSl14V2AW82RSh3/99WA5mKcxSPCJUEGo+KtkME7YDZLMB49tWOiAynW33X71IvGEBOkfRgsTy
	m2HEprnjfMRHO+I4UqAi5ZVhQW487SRx6N3ty1t32A4zzYslQaOrLK7N5kUFyJnI6nqa8KG1ysB
	+9HHgYtfR7u+9JiJDDZMg6y67+s68S7nk/5N2w6Lj1UcAta/tPg0Drd51CN9AbbBb4FjcIDpSZo
	EsvvRKBkJqCgQzaFhPWb18jKdxgxkB3aPRFkuJb9yHAGKEvD/GktzOHAQT1WaJO+2g/GYQ8ioyA
	psB2uDHoOng2wCXG2DZykCF87R7G2KJtiNJbT2nsQVrW9Bt52H5nHzDUTOQgkSSDaWYDxIvbFeD
	FohZIqXSkqIe+ysqkQggnqKwZGlVsitxsZcmENDE5dvH1PFnvqUhUyLSpzuWpe16xAdKw5mK796
	WmIGLI4Z8ooixVmOH+ARamihpJKYEA3jEVbVtM4WXN5dcyz
X-Received: by 2002:a05:600c:6091:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4a1702fc916mr70113485e9.3.1791211066464;
        Mon, 05 Oct 2026 07:37:46 -0700 (PDT)
Received: from andreayoga.localdomain ([80.188.242.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0276fa954sm348555785e9.3.2026.10.05.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:37:45 -0700 (PDT)
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
Subject: [PATCH 2/2] iommufd/selftest: Check dmabuf MMIO mappings filled from another domain
Date: Mon,  5 Oct 2026 16:37:36 +0200
Message-ID: <20261005143737.2915-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005143737.2915-1-parri.andrea@gmail.com>
References: <20261005143737.2915-1-parri.andrea@gmail.com>
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
check that a range is recorded.

dmabuf_mmio_new_domain maps a mock dmabuf, checks the existing domain,
allocates a second HWPT on the same IOAS and checks it too.
dmabuf_mmio_copy maps a mock dmabuf, copies it with IOMMU_IOAS_COPY into
a second IOAS that has its own mock domain, and checks that domain.
Without the previous patch the checks on the second domain fail in the
three mock domain variants; with it all checks pass.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  5 ++
 drivers/iommu/iommufd/selftest.c              | 90 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 51 +++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 13 +++
 4 files changed, 159 insertions(+)

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
index 25387969ab753..e700fd9250540 100644
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
@@ -1180,6 +1237,35 @@ static int iommufd_test_add_reserved(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+/* Check that every page in [iova, iova + length) was mapped with IOMMU_MMIO */
+static int iommufd_test_md_check_mmio(struct iommufd_ucmd *ucmd,
+				      unsigned int mockpt_id,
+				      unsigned long iova, size_t length)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	unsigned long index;
+	int rc = 0;
+
+	if (!length || iova % MOCK_PAGE_SIZE || length % MOCK_PAGE_SIZE)
+		return -EINVAL;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	for (index = iova / MOCK_PAGE_SIZE;
+	     index <= (iova + length - 1) / MOCK_PAGE_SIZE; index++) {
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
@@ -2105,6 +2191,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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

