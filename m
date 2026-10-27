Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116040;
	b=Z8Cn2nU9Q5xB3uemPbPg1K1jAB56Ndx+2SloXP1ttSZqPf70D6rcuyrKHqKr/V8VymuE
	 iiqXIicXHJNWVXhGCFyGCC1BxYiUt43pFC+VNUk7PdiWm3c9pTIKr1TZ2l9zD7+HVauCC
	 AHKzt/e7Dd3uy5Va2hQWdKmXzODENY2XC5iaYSD5Uz1WO5R7IUWMxwc2poSaWg+nJSoD8
	 UBc2wbMhito/z0PgpOOfMs80pHA2LUxkp3GXcERn1SrEZLPp4Kl3pZkxOs6pDBfcuNxXD
	 o5uG9T6ycZKi0obo4QZB9oDECnn99bWJfl/tuu4zyHsP40zBWQRHB1K1Ujntc+u05dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4B5d9m5IGzIPEeB3GJQ3GiQrHdJ7xnPhjgrZIgnZaI8=;
	b=MuVlL8MqCXJgSu5QF2RzSjzsLjK3Ti+usm9xn17yqPUp0T4DkTdj7lFuT3kPmoxGiPH0
	 z3T0kFrPg7V9eOUtSEFICA7KcNPYkAsz2KTri32i1tclCeYrO/XGf8BvjTx+xFlHI26JA
	 CiTmbCZwbZPmKhw4b9LDcXWJ6rXCWispFxfwS7iDz9ZsqHm7ZZeQsRd8xg0XqQbRa4leU
	 wJJRuTcVeeLxg6F4c6m5tblH0sOUwv50YkbL7MFnulCOKYYYhiRSv0QOjc8aqAvxTVbF8
	 9UfpRZDzguor12qddk2pdEAPch8JSRrdjrLsjPOJfNYkytBETwWjI+Ao2HF2aIiGhbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BAf0RfTp;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982560A2629
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9982560A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BAf0RfTp
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e47347279so2015355f8f.1
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116038; x=1793720838; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4B5d9m5IGzIPEeB3GJQ3GiQrHdJ7xnPhjgrZIgnZaI8=;
        b=BAf0RfTpmbr0zvBH7zXvHnvK1uMQ6sR+k+g39kdARfHKVSeYj7TULtBVT7GH2/a+eF
         Zo7FVMGsZSZD+qWcZB4BdswoNrMbylWdS4MbY5nGZ4minz028d/ljv0gV/mlux7jCUxM
         pmbx/QdU/6qgwKu/rWWEDxXPq+H+fO8h97PmJ0aV0bZWXKJ65tgGE6+s/NqLKUXDsAjD
         cdGcWNnIR/SkRechMfWbTUUEGcRG2B+86rDhRprn0HoOHTTI2OgmAZOx6RDczxkeFuso
         MuM1LhdVF2Ofzb9fhpQdxkF9ViqQW9EGoEv8t/7r2+i+TNo9f6W8l1gN9m4Ar3os2CIv
         8iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116038; x=1793720838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4B5d9m5IGzIPEeB3GJQ3GiQrHdJ7xnPhjgrZIgnZaI8=;
        b=JYkwx7mKglGsex8rWEx19VFGyyr5zDn40DhFOaGhT20F7EODJG/ai5gA1Fqy3D9VYm
         2ZNsJ82KgeZtf9J7KS5WcsRHNjvrxkTqr7hHp8bQD2f2NynQgCiYBVC97m0I29Izlu5g
         0urXigM+ihNxj+MFY51TdtRkoTs77tyzzqmDA9PdOvwhUpZJuKWULmClPn3yvrXssNwx
         5balB8MdzQYoQZ4ha0L08CQAJz1F594R9u569UvErppynPFgcjks57VdaMqs/JVS4J8i
         EPICJwCCd8NKkjddIjXcMPNsKpiWaD4nwM6S1sNSgbPkdHj9Upxvo+mb5fv9c9/0p7qk
         0YTg==
X-Forwarded-Encrypted: i=1; AKwUvByGxtzq4rID/3byVqTP9fmZeKCSlS6ymsqUvmAIZd9TrpZDK+gUdjqJdoBBcVGb22XQcWOUXA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLgZCEYGwJzIPjeUGCCEecWRDhNPcT4fH/KCafENW5VsFTRCMpE
	9UyUfBR++E4iNS5NgGe9JPbxt2tBix4RbELG5tgM9B4KmlHhSxpbb3HY
X-Gm-Gg: AYBFou0a6GQPj5XxMtEUk54Nff92U4mPOgK2qYVpeswRBwZEdrNVRYTydZ/UJRtc7GY
	64eEMiSj6JxfYq44A9oVB6rgFU1wnGuTUQ+HUctlGTpXoBHdZqnBBvF876ilkdoMOfGtRKHph1+
	cOFLYR2zVYIs8mdQTCCgsbR0ubn0kus0EctW2lUVKfwKOqsPwvYh9MsabSOMrSbFKxOKc5HLUx3
	q6OWRzCYvm5pY9yiSqTCah1wcg8oW0nsgjLLdrAZ4Horkd58pe3iJT6JiuZXzSeKi6C5mOATXZ5
	kpdVs1tAAmqLIYsC7qgVOr5tYaYD5lA5CJ2h2fD4bOYSZyzcnng1WV91v18GkghipEoKbGmVeX7
	+vuoZ9oswN2qREGJkMrg6Zu/RGMGWTgYbIFkL5eBto320qxkjDtP/1BAWFBJLSZExNYOzqtgTHC
	EOGUuP1X3z4K1xtiqrdGBt5HJ+X2ne4RsbMWoHoneQMPQy561a0rLCodcZHZEqQYywuNkzDMIXI
	KscediMlotzDZJYucY3SAD3LwfuUQNQKCye8XZXTDr3uXu4sGO692zn+A9raJ1AGPNv3u4t7P1P
	O3HbuvkTgMPRi+trpGRGXsBMQV4BF1ZOvs6XdGCBRqyO4rnrLbadIcQkGRVHBGBjEaKBOU+BRL+
	FuvJwK783/1R6sM/o
X-Received: by 2002:a05:6000:2312:b0:48d:ee59:3a30 with SMTP id ffacd0b85a97d-48e3eb8b4c5mr20222645f8f.22.1793116037586;
        Tue, 27 Oct 2026 08:47:17 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:17 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: [RFC PATCH 10/14] iommufd/selftest: Add mock-domain IOVA queries
Date: Tue, 27 Oct 2026 15:46:45 +0000
Message-ID: <20261027154649.91571-11-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027154649.91571-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

Tests of guest_memfd mappings cannot know in advance which frame an
IOVA reaches, since a revoke can unmap or replace it, and
IOMMU_TEST_OP_MD_CHECK_MAP only compares a range against a user buffer.

Add IOMMU_TEST_OP_MD_CHECK_MAPPED, which checks that a range of a mock
domain is all mapped or all unmapped, and IOMMU_TEST_OP_MD_IOVA_TO_PHYS,
which returns the physical address behind an IOVA. They hold
domains_rwsem for writing, so that a userspace unmap cannot free a
page-table level during the walk; they are not safe against a
concurrent guest_memfd update or dma-buf revoke, which the selftests do
not do.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/iommu/iommufd/iommufd_test.h |  18 ++++
 drivers/iommu/iommufd/selftest.c     | 125 +++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 52b78cbcc920..3fffcb2b20d7 100644
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
@@ -193,6 +195,22 @@ struct iommu_test_cmd {
 			__s32 dmabuf_fd;
 			__u32 revoked;
 		} dmabuf_revoke;
+		struct {
+			/*
+			 * 1: every page in [iova, iova+length) must be mapped;
+			 * 0: none of them may be. Any page in the other state
+			 * fails with -ENOENT. Any other value, or a non-zero
+			 * __reserved, is -EINVAL.
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
index ee706f18f7e9..378d7c46327e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -2068,6 +2068,122 @@ static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+/*
+ * True if [iova, iova + length) lies inside the domain's aperture.  An IOVA
+ * that the domain cannot map would read as unmapped, so the queries refuse
+ * it rather than report it as such.
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
+ * unmaps away.  A guest_memfd update, e.g. on a conversion or a punch hole,
+ * and a dma-buf revoke unmap under their pages mutex only, so tests must not
+ * run these queries while one is in progress.  A range can cross several
+ * areas and holes, so the queries take one IOAS-wide lock rather than the
+ * pages mutex of each area.
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
+ * Not safe against a concurrent guest_memfd update or dma-buf revoke; see
+ * mock_domain_unmap_lock().
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
+/*
+ * Check that [@iova, @iova + @length) is fully mapped or fully unmapped.  Not
+ * safe against a concurrent guest_memfd update or dma-buf revoke; see
+ * mock_domain_unmap_lock().
+ */
+static int iommufd_test_md_check_mapped(struct iommufd_ucmd *ucmd,
+					unsigned int mockpt_id,
+					unsigned long iova, size_t length,
+					u32 mapped, u32 reserved)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	unsigned int page_size;
+	int rc = 0;
+
+	if (mapped > 1 || reserved)
+		return -EINVAL;
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
+		/* A huge-page mock domain spans 2^38 bytes. */
+		cond_resched();
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
@@ -2180,6 +2296,15 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_dmabuf_revoke(ucmd,
 						  cmd->dmabuf_revoke.dmabuf_fd,
 						  cmd->dmabuf_revoke.revoked);
+	case IOMMU_TEST_OP_MD_CHECK_MAPPED:
+		return iommufd_test_md_check_mapped(ucmd, cmd->id,
+						    cmd->check_mapped.iova,
+						    cmd->check_mapped.length,
+						    cmd->check_mapped.mapped,
+						    cmd->check_mapped.__reserved);
+	case IOMMU_TEST_OP_MD_IOVA_TO_PHYS:
+		return iommufd_test_md_iova_to_phys(ucmd, cmd->id,
+						    cmd->iova_to_phys.iova);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.47.3

