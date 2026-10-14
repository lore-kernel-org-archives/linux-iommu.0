Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EE4EB86C
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970676; cv=none; b=hTV/A44NFNm0jefw7n1iXR+XGyAKVY0L3gJioVQ8+YZjlknF+c4qkhpMtgMqqpfiCMQNWWV+joWCkvT6dsI4qjMRtR8jtJjhWloF+GcLiUjAlgkpJMBaVSi098OBmIk5noEFOfBVghCt61xuyitP0whcxzd8g/U4rBH3hK0lGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970676; c=relaxed/simple;
	bh=am0hAA/nRejPE4sLTQ21BeEMerAqyBcR4Wmfr7+mp98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCSdq6dm+kEFmSB26zK3iy44HisO4xg+VcF82356YeVk4dc1/u7pIiXa+7qt7uwPxDdzQiQhsxRg8wAVDRlA+zDQNYbX7uiOSkvBAN33GjXVucpeDG3zkLopjLBOMcnzKz2vER1wRZRiboQ/gK3t6rr7npgt20xoAFyobyCzi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9gZXcZ9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9gZXcZ9"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b060ec084so2529345f8f.0
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791970666; x=1792575466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XH1DvjtQ4kSOTYVjVn8rMjarIlp6Ws3f/rSFMl2hKxs=;
        b=f9gZXcZ9RWDB9DDwRDMQ3vsFoUcm4JHaZ/oXkKG5OS1BnJxPA3i5ZVHSi0B//ZChxZ
         bwNEu/Hl2emrEovwjlotixZ4NXChT4pLx+J/q9XxjMz222cNTukyyWXCE/Jq0GJ0rFh9
         dKk3D6JqS1tfKyuBZewGAfp4Q/bzPUaVYPrqf+u8dE4qgDiFHDV8yLvPH9rXjMf3HNQc
         VZUv93Mzu+yhfsWTM16bd6MNAgt6QYbJpMFOPkBHoilrHaIpjuIhCs361dOQ0FCfxW03
         RthMdbq85hbBCVBclYuzMr0FCbHBgsIlTYFYd7Gyca8akvy9jpHxFTL2bZaVjTV2Y5QK
         a8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970666; x=1792575466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XH1DvjtQ4kSOTYVjVn8rMjarIlp6Ws3f/rSFMl2hKxs=;
        b=KVwXGOfAmL/lHMEeELiQ0IH1JBpBQQr7Zzw2M/U4xyTf/PePPrLf03nQkPoX8gteGq
         3HtAer7jIP6dmnz/69NcSeyEtiUerenZVLZhpzIGm5sHM2x0a1BayTh/K52g11dzCxiZ
         YLb53k/Vj4iP4fn8tvR3QrEcLzQ99H1rQUR9OeKgPd/3iFyMWvmtilXl/MdLtM/osyBR
         89nlc94B9yf0sJGXHBCca5YNKW7JvtS420iK+BV67bI4n/QQwYGl9vdJanj7rmlZ3/Fb
         R79v847ZgSSUpRFSGXhplyLf4D5PPcSzV4zZU/vLZpSluBmyntkSqNd7WCa1exFRcBH2
         nnuA==
X-Forwarded-Encrypted: i=1; AKwUvBzyRdfah/Me+qLifFNXtcBpY+0WW1nGbp8LIbKsPuGUt9YVYSQQHvgYPFzxHu5oUSukVGJmzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKmTClZKOZzw+VPcmQDaGNuIIRJk6jAwdfXdUkZL7FQOwR7m6+C
	MIYBlom+M1Gd6gpSspi0ZGjQUce7z4W8LhfVNrcTBs8qiWSqEuDrFQrN
X-Gm-Gg: AYBFou3D5ruuxJdPAGUx0t5akOok/Y35pedv85zSxoYJWAiKtlRVGhl2i7C92ahssWN
	sHPQeJ08mxbQbNLlxNVyW4k3HpywI1Ov4doE5Xe/LgSZfewq20ht2QyUjkpfPGg2hzDwl8RThsd
	XlmrE7DOFt9jyVEjwZaLVHLaY2wMzKO84FPwVbx2h/rMw7i5zlLsgXu7Tdu6vu2ev/AJbJHs//E
	AtIWUV2P7e2vOmxcXshNgjONLviMGlEY6qs7Ga2SNrUCvzqPbIRBlGw8DdNQ5d3KQP3buFCbWaj
	Mfc6ms4dXDMP8MP7BTIhQmoVH0U5E3RJGGtDI/SS5P2dfbiVewCyBBwmlDCHWrE7cvq914xW8EH
	NXTd6IhgqE417etH3p9uNHaRZR7U9x9N+G25hguYzGcs2qlnaZbKJ5bw8/Okv9KzlMEHAUc+GxR
	Qs/9WJui4kEQwpTy3WqJ1c9CtbAzFKnZbvihJYOt42XbcWqY93YZEsmBQguq9LOqyFGOGcXojRj
	PG0Xs1TNLMwxM7KMRixDHJZ4vX//0Vwo3BtvVeYpqXnBbDI8Qb65ROXOsAaY/hKAkeZyVU2zp66
	jhVnr6Y4KrCRPqTjNSBxiUa+uR20nE0dRpzi
X-Received: by 2002:adf:e001:0:20b0:48b:efb:4a66 with SMTP id ffacd0b85a97d-48dba7b405bmr21828342f8f.6.1791970666161;
        Wed, 14 Oct 2026 02:37:46 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm9365477f8f.35.2026.10.14.02.37.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:37:45 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH v2 08/11] iommufd/selftest: Add mock-domain IOVA queries
Date: Wed, 14 Oct 2026 09:37:30 +0000
Message-ID: <20261014093733.90312-9-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014093733.90312-1-griffoul@gmail.com>
References: <20261014093733.90312-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

A test of memory that can be taken back or replaced does not know in
advance which frame a device reaches. IOMMU_TEST_OP_MD_CHECK_MAP only
compares against a known buffer.

Add MD_CHECK_MAPPED, which checks that a range is fully mapped or fully
unmapped, and MD_IOVA_TO_PHYS, which returns the frame behind an IOVA,
or 0 if it is unmapped. Both refuse an IOVA outside the domain's
aperture.

Both hold domains_rwsem for writing so that a userspace unmap cannot
free a page-table level during the walk.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/iommu/iommufd/iommufd_test.h |  16 ++++
 drivers/iommu/iommufd/selftest.c     | 109 +++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 52b78cbcc920..28fd9c43edc4 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -31,6 +31,8 @@ enum {
 	IOMMU_TEST_OP_PASID_CHECK_HWPT,
 	IOMMU_TEST_OP_DMABUF_GET,
 	IOMMU_TEST_OP_DMABUF_REVOKE,
+	IOMMU_TEST_OP_MD_CHECK_MAPPED,
+	IOMMU_TEST_OP_MD_IOVA_TO_PHYS,
 };
 
 enum {
@@ -193,6 +195,20 @@ struct iommu_test_cmd {
 			__s32 dmabuf_fd;
 			__u32 revoked;
 		} dmabuf_revoke;
+		struct {
+			/*
+			 * 1: every page in [iova, iova+length) must be mapped;
+			 * 0: none of them may be. Mixed is an error.
+			 */
+			__u32 mapped;
+			__u32 __reserved;
+			__aligned_u64 iova;
+			__aligned_u64 length;
+		} check_mapped;
+		struct {
+			__aligned_u64 iova;
+			__aligned_u64 out_phys;	/* 0 if unmapped */
+		} iova_to_phys;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a526..1f5cd2d00fda 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -2031,6 +2031,107 @@ static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+/*
+ * True if [iova, iova + length) lies inside the domain's aperture.  Outside
+ * it the page table returns an error code from iova_to_phys(), not 0.
+ */
+static bool mock_domain_covers(struct mock_iommu_domain *mock,
+			       unsigned long iova, size_t length)
+{
+	struct iommu_domain_geometry *geo = &mock->domain.geometry;
+	unsigned long last;
+
+	if (check_add_overflow(iova, length - 1, &last))
+		return false;
+	return iova >= geo->aperture_start && last <= geo->aperture_end;
+}
+
+/*
+ * iova_to_phys() walks the page table, so it must not run while an unmap
+ * frees a level of it.  A userspace unmap holds the IOAS domains_rwsem for
+ * reading while it unmaps the domains, so holding it for writing keeps such
+ * unmaps away.  A memory provider or dma-buf revoke unmaps under its pages
+ * mutex only, so tests must not run these queries while a revoke of the
+ * range is in progress.
+ */
+static struct rw_semaphore *
+mock_domain_unmap_lock(struct iommufd_hw_pagetable *hwpt)
+{
+	return &to_hwpt_paging(hwpt)->ioas->iopt.domains_rwsem;
+}
+
+/*
+ * Report the physical address the mock domain resolves @iova to, or 0 if
+ * it is unmapped.  Lets a test check that two IOVAs share one frame, or that
+ * an IOVA moved to another frame, without knowing the frames in advance.
+ */
+static int iommufd_test_md_iova_to_phys(struct iommufd_ucmd *ucmd,
+					unsigned int mockpt_id,
+					unsigned long iova)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	unsigned int page_size;
+	int rc;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	page_size = 1 << __ffs(mock->domain.pgsize_bitmap);
+	if (iova % page_size || !mock_domain_covers(mock, iova, page_size)) {
+		rc = -EINVAL;
+		goto out_put;
+	}
+	down_write(mock_domain_unmap_lock(hwpt));
+	cmd->iova_to_phys.out_phys =
+		mock->domain.ops->iova_to_phys(&mock->domain, iova);
+	up_write(mock_domain_unmap_lock(hwpt));
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out_put:
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+	return rc;
+}
+
+static int iommufd_test_md_check_mapped(struct iommufd_ucmd *ucmd,
+					unsigned int mockpt_id,
+					unsigned long iova, size_t length,
+					bool mapped)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	unsigned int page_size;
+	int rc = 0;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	page_size = 1 << __ffs(mock->domain.pgsize_bitmap);
+	if (iova % page_size || length % page_size || !length ||
+	    !mock_domain_covers(mock, iova, length)) {
+		rc = -EINVAL;
+		goto out_put;
+	}
+
+	down_write(mock_domain_unmap_lock(hwpt));
+	for (; length; length -= page_size, iova += page_size) {
+		bool is_mapped =
+			mock->domain.ops->iova_to_phys(&mock->domain, iova) != 0;
+
+		if (is_mapped != mapped) {
+			rc = -ENOENT;
+			break;
+		}
+	}
+	up_write(mock_domain_unmap_lock(hwpt));
+
+out_put:
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+	return rc;
+}
+
 static int iommufd_test_dmabuf_revoke(struct iommufd_ucmd *ucmd, int fd,
 				      bool revoked)
 {
@@ -2143,6 +2244,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_dmabuf_revoke(ucmd,
 						  cmd->dmabuf_revoke.dmabuf_fd,
 						  cmd->dmabuf_revoke.revoked);
+	case IOMMU_TEST_OP_MD_CHECK_MAPPED:
+		return iommufd_test_md_check_mapped(ucmd, cmd->id,
+						    cmd->check_mapped.iova,
+						    cmd->check_mapped.length,
+						    cmd->check_mapped.mapped);
+	case IOMMU_TEST_OP_MD_IOVA_TO_PHYS:
+		return iommufd_test_md_iova_to_phys(ucmd, cmd->id,
+						    cmd->iova_to_phys.iova);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.47.3

