Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116046;
	b=k8fBcIerPQrElLzbdhs9BPckzU8DYZMM0UDMj1GMZBTh5IF80vq5wDvx1/dn4BfkkbMF
	 QzB6pD8z84nQ/zBwNsixLOh833NlGPN8PzFo1UWVCynutujoSSdXHzMgdfYvMCVuRJw5G
	 Xx49/80OWHSH+9TnyzVShc/YjqkzqXY6IwCNwOsyINHlcdhXJL3lurFcsqxE7G1qRvOAG
	 /30YhYpBsYcIiln+Gy4/o2mUvxGKePS/t/UAaa6mR53V5wBvsOHP3+aTxcQNTmJQqENY9
	 i5c4QZzPdjmGIbxsyNQvU8GLEmfgVpSD9W/8oaHjj17k3ocecUN0MS3HFiqspQ+K6Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sPt0JYZ7MHrW6GDHRZTQpzJzKe8DOikeeLCfWsSdkp8=;
	b=JlvVqkR9bP4p6VGH2WE9RRGOt9LylxiU8+98mGAXTSachps1VffXc5SB9zIU4Kln7Iov
	 dSo9kNwS2nrcgNm6zgqRW7IwtduEzjwPyzHUGoOQ4GSkhJ1EW28EB7qc5WU4JKlrPbxCz
	 Kpb4QIZLTQYHMebr/FRaDOYiP0/WJLooxGYO4eZrInid3adZiO0P74oD8J7dZDT+NGf3O
	 YgQg0S5ql4ahoWpN2taB7+FOiGVDrxmb79k6LSR4yXy5Y0dWvGXLufgP48JU/FKQCIhkW
	 a9FoNLdR7SrtDyOTNPLunXVZAkahsoSU9RITEBVgmyJl/o/yQe2sqt5apsAfdriFuNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbebCG9a;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E8606FCA2
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 245E8606FCA2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HbebCG9a
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b486e1d02eso44237a12.2
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116045; x=1793720845; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPt0JYZ7MHrW6GDHRZTQpzJzKe8DOikeeLCfWsSdkp8=;
        b=HbebCG9a6AQE5jJBif2Ehw3mdc+edeklKOsskVZTI+ile/XxVc09B8uBODqWg98nYI
         OeE4jLf4fNL3cRr86QjkZW0eJ2ZqcsenTeR1wnzSzczfIWfOJmJf+EtOH0yFMI3Xmote
         gSyoDueUZcgqUC7LYjPppYZQsug5cut5BI05mVfSCtgVeLzJk3XglNqpHQ/O0XCO41B0
         PlSMtTJl3jaoD4Ua14Y2ZTkjzkhixn3je2rV/q5M0sa7D7FDh5JHQytD6KWZw7Rn8Ks2
         R7JmIB2Rm8SZG0WCYDH16pV3RGR2u5DFv99+YhWSpSjv3wMIuHzcfLXDPMkdFQ0yzoJB
         KgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116045; x=1793720845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPt0JYZ7MHrW6GDHRZTQpzJzKe8DOikeeLCfWsSdkp8=;
        b=O80AXd7XK6H5r2U8Z2Nh8nyQuP4TRKhEMWJzgmllmbZowhRveH4jdhOGL3pUpHxXiK
         EMHAoML8aUtVgh0aqWpfpaMb/yUiGnNE4OvHyA8URYhhqmYLaOBr0MDTfsOMqUINHcx0
         ROMJ/FLBXZA7k/XP/4GHL8wSPKV22yGLUB3wCnMFraXBp8XL9puMib/d3Lk0uONODJEr
         4SDwWtWmm4+pEmO2COX/FBDsMpGLemkdIr13BdKHNfRSymaIUTr/j23azwlCdxgaDR4J
         v0Q2vgJ95MJdE84nmIIFpgELDIEW+L/q2jaY7ksDgKZ0FVgafF3/u54wD6otr1EIgTKb
         sRHg==
X-Forwarded-Encrypted: i=1; AKwUvBwwNFlijlEuC/R5unGJRVfPPB54ybUlOyM4/6k5hV27ofVzBJ6HBjTpbzxqn1RQs4NSvXAI5w==@lists.linux.dev
X-Gm-Message-State: AFq9FYI6DkGn40fL882F0pZFi+FiHUM7JjIHgCIEcx+xi71pIZzPTCdc
	047CAVNns+iulOfqmGJeO1K0qjTn7jjw+8P6Ur6pQSwSGIOHAJWzUTcz
X-Gm-Gg: AYBFou1ygT8MDJu2VfJGkWtchv0weNIaHvLuE2rSgsaeyF9x3bT6ZZx/4ZXXZ6ntvO0
	K37nwF/BXZMmWYzNFaQKPN4ZwTlDgfMfKv4Og40MCh5XQWvAxf8wsXz7a0ZLzmX9x1tzQgCbXCf
	qZ+44A/2L31d42CEOapPYWuCzMrGcMZKAbup7NnP4M+F+RdPwSVwNdnEbrkd3it/Vm9jg8zpEIY
	28IcO0YA/gWL0P8kqAL+F/Ak57/gd6/+MEl/E1YvYQCh2XcfLNyTo/weU5PrIPnut+dkyeEPQJt
	9XWkzpuYOzsELI2ElCrrLedVn0H7b6ih8wzh0cKbKU2yr3CcRM9ufreTUeQDlzC9G5deHkJLmTY
	esgW71k1E6nlxiqcLAHZp9cKj+iytCClRaOq4wbmN6Da4uqcAUxYO5P1LJ6uuA0En/cTsfqjifN
	5ABpuduR+LGj7eh0DocVbzFoep2vuHu+u62pq79dZm4gBhz0wO6SN+HM3kITfu1jiq1qjWSvmpU
	0UU48wdlclVVGKUPpatYr9wCVl+bI8umBPsDAMLV6pqUkGrZnbZCvVQSgJckqVJDpioX1rWv4JU
	FhyIHWOSHXVcqDyDXPGKGx4lIHlnJ1dzHDLc78y/hRWz1PTt84pThyx7bAdVn9rD4GrWqHAiS7J
	4mSSy+aknRUChiGAAzv5sCydUXFEjzc8lrGmgiIBXWOhZ0NsURiWRHwspN33FsMapkg==
X-Received: by 2002:a05:600c:8183:b0:4a2:8c5:5f2 with SMTP id 5b1f17b1804b1-4a35ac99b41mr172717785e9.5.1793116032487;
        Tue, 27 Oct 2026 08:47:12 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:11 -0700 (PDT)
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
Subject: [RFC PATCH 08/14] iommufd: Track the domains of revocable pages in struct iopt_pages
Date: Tue, 27 Oct 2026 15:46:43 +0000
Message-ID: <20261027154649.91571-9-griffoul@gmail.com>
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

guest_memfd pages, like dma-buf pages, can be taken away from iommufd
whatever references it holds, but the list of (area, domain) pairs to
unmap on a revoke lives in struct iopt_pages_dmabuf.

Move it to struct iopt_pages, rename the iopt_dmabuf_*track* helpers to
iopt_pages_*, and add iopt_pages_tracked() for the page types that need
it, so that other page types can use it. No functional change.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/iommu/iommufd/io_pagetable.c | 24 +++++-----
 drivers/iommu/iommufd/io_pagetable.h | 33 +++++++++-----
 drivers/iommu/iommufd/pages.c        | 67 ++++++++++++++--------------
 3 files changed, 67 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4e447ce74cf6..43d518e4ce58 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1086,14 +1086,14 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 				WARN_ON(!area->storage_domain);
 			if (area->storage_domain == domain)
 				area->storage_domain = storage_domain;
-			if (iopt_is_dmabuf(pages)) {
+			if (iopt_pages_tracked(pages)) {
 				if (!iopt_dmabuf_revoked(pages))
 					iopt_area_unmap_domain(area, domain);
-				iopt_dmabuf_untrack_domain(pages, area, domain);
+				iopt_pages_untrack_domain(pages, area, domain);
 			}
 			mutex_unlock(&pages->mutex);
 
-			if (!iopt_is_dmabuf(pages))
+			if (!iopt_pages_tracked(pages))
 				iopt_area_unmap_domain(area, domain);
 		}
 		return;
@@ -1111,8 +1111,8 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 		WARN_ON(area->storage_domain != domain);
 		area->storage_domain = NULL;
 		iopt_area_unfill_domain(area, pages, domain);
-		if (iopt_is_dmabuf(pages))
-			iopt_dmabuf_untrack_domain(pages, area, domain);
+		if (iopt_pages_tracked(pages))
+			iopt_pages_untrack_domain(pages, area, domain);
 		mutex_unlock(&pages->mutex);
 	}
 }
@@ -1143,15 +1143,15 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 			continue;
 
 		guard(mutex)(&pages->mutex);
-		if (iopt_is_dmabuf(pages)) {
-			rc = iopt_dmabuf_track_domain(pages, area, domain);
+		if (iopt_pages_tracked(pages)) {
+			rc = iopt_pages_track_domain(pages, area, domain);
 			if (rc)
 				goto out_unfill;
 		}
 		rc = iopt_area_fill_domain(area, domain);
 		if (rc) {
-			if (iopt_is_dmabuf(pages))
-				iopt_dmabuf_untrack_domain(pages, area, domain);
+			if (iopt_pages_tracked(pages))
+				iopt_pages_untrack_domain(pages, area, domain);
 			goto out_unfill;
 		}
 		if (!area->storage_domain) {
@@ -1180,8 +1180,8 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 			area->storage_domain = NULL;
 		}
 		iopt_area_unfill_domain(area, pages, domain);
-		if (iopt_is_dmabuf(pages))
-			iopt_dmabuf_untrack_domain(pages, area, domain);
+		if (iopt_pages_tracked(pages))
+			iopt_pages_untrack_domain(pages, area, domain);
 		mutex_unlock(&pages->mutex);
 	}
 	return rc;
@@ -1393,7 +1393,7 @@ static int iopt_area_split(struct iopt_area *area, unsigned long iova)
 		return -EBUSY;
 
 	/* Maintaining the domains_itree below is a bit complicated */
-	if (iopt_is_dmabuf(pages))
+	if (iopt_pages_tracked(pages))
 		return -EOPNOTSUPP;
 
 	if (new_start & (alignment - 1) ||
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 27e3e311d395..0dddfb5db5fd 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -70,15 +70,14 @@ void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
 void iopt_area_unmap_domain(struct iopt_area *area,
 			    struct iommu_domain *domain);
 
-int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
-			     struct iommu_domain *domain);
-void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
-				struct iopt_area *area,
-				struct iommu_domain *domain);
-int iopt_dmabuf_track_all_domains(struct iopt_area *area,
-				  struct iopt_pages *pages);
-void iopt_dmabuf_untrack_all_domains(struct iopt_area *area,
-				     struct iopt_pages *pages);
+int iopt_pages_track_domain(struct iopt_pages *pages, struct iopt_area *area,
+			    struct iommu_domain *domain);
+void iopt_pages_untrack_domain(struct iopt_pages *pages, struct iopt_area *area,
+			       struct iommu_domain *domain);
+int iopt_pages_track_all_domains(struct iopt_area *area,
+				 struct iopt_pages *pages);
+void iopt_pages_untrack_all_domains(struct iopt_area *area,
+				    struct iopt_pages *pages);
 
 static inline unsigned long iopt_area_index(struct iopt_area *area)
 {
@@ -194,7 +193,8 @@ enum iopt_address_type {
 	IOPT_ADDRESS_DMABUF,
 };
 
-struct iopt_pages_dmabuf_track {
+/* One (area, domain) mapping of revocable pages, on iopt_pages::tracker. */
+struct iopt_pages_track {
 	struct iommu_domain *domain;
 	struct iopt_area *area;
 	struct list_head elm;
@@ -205,7 +205,6 @@ struct iopt_pages_dmabuf {
 	struct phys_vec phys;
 	/* Always PAGE_SIZE aligned */
 	unsigned long start;
-	struct list_head tracker;
 };
 
 /*
@@ -246,6 +245,12 @@ struct iopt_pages {
 	struct rb_root_cached access_itree;
 	/* Of iopt_area::pages_node */
 	struct rb_root_cached domains_itree;
+	/*
+	 * Of iopt_pages_track::elm.  The owner of these pages can revoke them
+	 * whatever references iommufd holds, so every (area, domain) that
+	 * maps them is listed here for the revoke.  See iopt_pages_tracked().
+	 */
+	struct list_head tracker;
 };
 
 static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
@@ -255,6 +260,12 @@ static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
 	return pages->type == IOPT_ADDRESS_DMABUF;
 }
 
+/* The owner of the pages can revoke them, so their domains are tracked. */
+static inline bool iopt_pages_tracked(struct iopt_pages *pages)
+{
+	return iopt_is_dmabuf(pages);
+}
+
 static inline bool iopt_dmabuf_revoked(struct iopt_pages *pages)
 {
 	lockdep_assert_held(&pages->mutex);
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 404f31d8f729..cf0f08c4e9a6 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1384,6 +1384,7 @@ static struct iopt_pages *iopt_alloc_pages(unsigned long start_byte,
 	pages->npages = DIV_ROUND_UP(length + start_byte, PAGE_SIZE);
 	pages->access_itree = RB_ROOT_CACHED;
 	pages->domains_itree = RB_ROOT_CACHED;
+	INIT_LIST_HEAD(&pages->tracker);
 	pages->writable = writable;
 	if (capable(CAP_IPC_LOCK))
 		pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
@@ -1434,13 +1435,13 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
 static void iopt_revoke_notify(struct dma_buf_attachment *attach)
 {
 	struct iopt_pages *pages = attach->importer_priv;
-	struct iopt_pages_dmabuf_track *track;
+	struct iopt_pages_track *track;
 
 	guard(mutex)(&pages->mutex);
 	if (iopt_dmabuf_revoked(pages))
 		return;
 
-	list_for_each_entry(track, &pages->dmabuf.tracker, elm) {
+	list_for_each_entry(track, &pages->tracker, elm) {
 		struct iopt_area *area = track->area;
 
 		iopt_area_unmap_domain_range(area, track->domain,
@@ -1557,7 +1558,6 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 	pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
 	pages->type = IOPT_ADDRESS_DMABUF;
 	pages->dmabuf.start = start - start_byte;
-	INIT_LIST_HEAD(&pages->dmabuf.tracker);
 
 	rc = iopt_map_dmabuf(ictx, pages, dmabuf);
 	if (rc) {
@@ -1568,16 +1568,16 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 	return pages;
 }
 
-int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
-			     struct iommu_domain *domain)
+int iopt_pages_track_domain(struct iopt_pages *pages, struct iopt_area *area,
+			    struct iommu_domain *domain)
 {
-	struct iopt_pages_dmabuf_track *track;
+	struct iopt_pages_track *track;
 
 	lockdep_assert_held(&pages->mutex);
-	if (WARN_ON(!iopt_is_dmabuf(pages)))
+	if (WARN_ON(!iopt_pages_tracked(pages)))
 		return -EINVAL;
 
-	list_for_each_entry(track, &pages->dmabuf.tracker, elm)
+	list_for_each_entry(track, &pages->tracker, elm)
 		if (WARN_ON(track->domain == domain && track->area == area))
 			return -EINVAL;
 
@@ -1586,21 +1586,20 @@ int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
 		return -ENOMEM;
 	track->domain = domain;
 	track->area = area;
-	list_add_tail(&track->elm, &pages->dmabuf.tracker);
+	list_add_tail(&track->elm, &pages->tracker);
 
 	return 0;
 }
 
-void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
-				struct iopt_area *area,
-				struct iommu_domain *domain)
+void iopt_pages_untrack_domain(struct iopt_pages *pages, struct iopt_area *area,
+			       struct iommu_domain *domain)
 {
-	struct iopt_pages_dmabuf_track *track;
+	struct iopt_pages_track *track;
 
 	lockdep_assert_held(&pages->mutex);
-	WARN_ON(!iopt_is_dmabuf(pages));
+	WARN_ON(!iopt_pages_tracked(pages));
 
-	list_for_each_entry(track, &pages->dmabuf.tracker, elm) {
+	list_for_each_entry(track, &pages->tracker, elm) {
 		if (track->domain == domain && track->area == area) {
 			list_del(&track->elm);
 			kfree(track);
@@ -1610,36 +1609,36 @@ void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
 	WARN_ON(true);
 }
 
-int iopt_dmabuf_track_all_domains(struct iopt_area *area,
-				  struct iopt_pages *pages)
+int iopt_pages_track_all_domains(struct iopt_area *area,
+				 struct iopt_pages *pages)
 {
-	struct iopt_pages_dmabuf_track *track;
+	struct iopt_pages_track *track;
 	struct iommu_domain *domain;
 	unsigned long index;
 	int rc;
 
-	list_for_each_entry(track, &pages->dmabuf.tracker, elm)
+	list_for_each_entry(track, &pages->tracker, elm)
 		if (WARN_ON(track->area == area))
 			return -EINVAL;
 
 	xa_for_each(&area->iopt->domains, index, domain) {
-		rc = iopt_dmabuf_track_domain(pages, area, domain);
+		rc = iopt_pages_track_domain(pages, area, domain);
 		if (rc)
 			goto err_untrack;
 	}
 	return 0;
 err_untrack:
-	iopt_dmabuf_untrack_all_domains(area, pages);
+	iopt_pages_untrack_all_domains(area, pages);
 	return rc;
 }
 
-void iopt_dmabuf_untrack_all_domains(struct iopt_area *area,
-				     struct iopt_pages *pages)
+void iopt_pages_untrack_all_domains(struct iopt_area *area,
+				    struct iopt_pages *pages)
 {
-	struct iopt_pages_dmabuf_track *track;
-	struct iopt_pages_dmabuf_track *tmp;
+	struct iopt_pages_track *track;
+	struct iopt_pages_track *tmp;
 
-	list_for_each_entry_safe(track, tmp, &pages->dmabuf.tracker,
+	list_for_each_entry_safe(track, tmp, &pages->tracker,
 				 elm) {
 		if (track->area == area) {
 			list_del(&track->elm);
@@ -1656,6 +1655,7 @@ void iopt_release_pages(struct kref *kref)
 	WARN_ON(!RB_EMPTY_ROOT(&pages->domains_itree.rb_root));
 	WARN_ON(pages->npinned);
 	WARN_ON(!xa_empty(&pages->pinned_pfns));
+	WARN_ON(!list_empty(&pages->tracker));
 	if (iopt_is_dmabuf(pages) && pages->dmabuf.attach) {
 		struct dma_buf *dmabuf = pages->dmabuf.attach->dmabuf;
 
@@ -1664,7 +1664,6 @@ void iopt_release_pages(struct kref *kref)
 		dma_resv_unlock(dmabuf->resv);
 		dma_buf_detach(dmabuf, pages->dmabuf.attach);
 		dma_buf_put(dmabuf);
-		WARN_ON(!list_empty(&pages->dmabuf.tracker));
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
 	}
@@ -1749,7 +1748,7 @@ static void __iopt_area_unfill_domain(struct iopt_area *area,
 
 	lockdep_assert_held(&pages->mutex);
 
-	if (iopt_is_dmabuf(pages)) {
+	if (iopt_pages_tracked(pages)) {
 		if (WARN_ON(iopt_dmabuf_revoked(pages)))
 			return;
 		iopt_area_unmap_domain_range(area, domain, start_index,
@@ -1917,8 +1916,8 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		return 0;
 
 	mutex_lock(&pages->mutex);
-	if (iopt_is_dmabuf(pages)) {
-		rc = iopt_dmabuf_track_all_domains(area, pages);
+	if (iopt_pages_tracked(pages)) {
+		rc = iopt_pages_track_all_domains(area, pages);
 		if (rc)
 			goto out_unlock;
 	}
@@ -1983,8 +1982,8 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 	}
 	pfn_reader_destroy(&pfns);
 out_untrack:
-	if (iopt_is_dmabuf(pages))
-		iopt_dmabuf_untrack_all_domains(area, pages);
+	if (iopt_pages_tracked(pages))
+		iopt_pages_untrack_all_domains(area, pages);
 out_unlock:
 	mutex_unlock(&pages->mutex);
 	return rc;
@@ -2024,8 +2023,8 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		WARN_ON(RB_EMPTY_NODE(&area->pages_node.rb));
 	interval_tree_remove(&area->pages_node, &pages->domains_itree);
 	iopt_area_unfill_domain(area, pages, area->storage_domain);
-	if (iopt_is_dmabuf(pages))
-		iopt_dmabuf_untrack_all_domains(area, pages);
+	if (iopt_pages_tracked(pages))
+		iopt_pages_untrack_all_domains(area, pages);
 	area->storage_domain = NULL;
 out_unlock:
 	mutex_unlock(&pages->mutex);
-- 
2.47.3

