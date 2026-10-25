Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894795;
	b=A84LKymFz3842v4YGbkAOY7gHJFMHI70GmErTIu/fHrBK3Qj+fLLzwTu7/C5CA29kSb+
	 8SHlNwwNviFEpE2z9hc3PuXStSgrhrRmeAZfurVgYvC5QWWheILqOgRNNQXV1RUmMjyZn
	 LAY18kYVOAMFkOoQ8/7S/uQh47ffwYCAqSbGAd78UsxMMgf+WztBr2TImmAqf5Q2k7Vp3
	 H57jqJa8PTsx28w46+MEFfLP/UbcdYMU5sMjCCYwABjJgxeDaauvhd5F0tJFSMNgAGAZ7
	 SRutrDHuK7+r/Sjd4F6/K0SXcSg7/kTpYjxFv1YXSgOtRSBDYufXlSuDuiCM2QDxnnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=W7EkGOGjayoaP5fzXBEU5K7kgGFGC1qKp7YCNgcNpP8=;
	b=QMOYrP8EsHUwwgteXobHWRPc6AsdK67vOhVob3IYtlBJN76N2E22FQnUPWOORhG38mgI
	 fGFgDEMq3tagKDLpd9gFQnjd1hGwMhWXkg6HsiZfpfBIPh0p4CFptOgMVNDSDIPNg/Xkp
	 +nDZCpIzDQCUtDDuqilVenFHt7qMJHn+WeJV1BXcp3nPgQDFQfB3lrmV84PqMSnrciVIo
	 KaxtfEBGKIpL6Wdqvfx9Bhl68jOYc5S9SvcAPzbZfMFFXq6xdYIzQDQTM7/EmwL5li2+2
	 xF4p6PJLeAZfmrpq7UVcWXvbKFf3ssO92fldZOmbiZDZapB17dk94wYkeS47dmrY6DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fP+urplg;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC4606D69D
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 02:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CDC4606D69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fP+urplg
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd8b299b0abso1079659a12.1
        for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 19:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894794; x=1793499594; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7EkGOGjayoaP5fzXBEU5K7kgGFGC1qKp7YCNgcNpP8=;
        b=fP+urplg3h6BHLDhMnW3k1jAO3EZcLzqtjBtVhNR4Hf++Rc8dv29TF9xXZnTI7ZmEn
         cxklzwHZEe3JceihrItTLTJT5Gas4uqQXjBR69SSyvZ5Hs+2qGVqnEFio4N953yBQ2hV
         PW/kEikztNZznKTSedOc+nRilKGT7A/edJPkk9jtm1ncvpGFhti2uVOuH8sDrsPfEUd9
         RZv2XWbfYSAKrAMXh2VY22maiE6t4JhLoHyz/ZHnAiIjX4JFt2tL8o9nqAaMt+EzCIXK
         bNtmnsuKFUHdKdYbyoxlZkXi5Y92JO6KpidAp6BoA+yy5rjdLV3VouPuJJ0TTsZmaAXA
         tcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894794; x=1793499594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7EkGOGjayoaP5fzXBEU5K7kgGFGC1qKp7YCNgcNpP8=;
        b=aQ56WX+Fp/JjT061J3NX/7Vr4qyT4Lj+I+7wu9zeC/O/lBBU/ci51YYgkYE3Sw/FHr
         cCzWisbk7PjTrTHBaV0JZChvXVULEc6K9wmvZC34Sgvann42WUpcBNOmayQUOJ9QtGEV
         6iT7eltz0oDNWA8GFSguQMv5E2uZ8+rwZ7kl1KCs+d4IxWYbyej6QHdJuPAXD2G47vTM
         c5JT3cwwdA6K+HZqPOdvsj9tTGitAgPhUdfnD5I4Rk9yt2d5Yt1w+4xS8BRWVEfIj2wF
         rTla37HkAIWJ3VetkS6o19tB26VSGTO+HKz00ShHHe7QGBapnKEmZ2+oIZkkwGWcFHGo
         GEWg==
X-Forwarded-Encrypted: i=1; AKwUvByKue3KGBfqFajh6oreTQ3bMURwpbN52gKWP8Jo9PIDOiM0VSXRABFpacoQNiqXt/hdL33zpA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKznvlUpseKsS3aTEymHlcjPnVn6wsdNLJCh2hW+plQELZwEmXA
	0HzPxidt1Uy6ZnLLOUGaYonkX2ItEauL7ZRNDxw3spFJBay1Sz8xmmLkOy0m9At525l71tlfGBU
	gF3mPGGd2PYHbXA==
X-Received: from pgbj17-n2.prod.google.com ([2002:a05:6a02:61d1:20b0:cd5:f7a5:5490])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a110:b0:3e1:c6e6:d101 with SMTP id adf61e73a8af0-3e7bfaab4cbmr2429790637.29.1792894794139;
 Sat, 24 Oct 2026 19:19:54 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:26 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-16-skhawaja@google.com>
Subject: [PATCH v6 15/18] iommufd: Persist iommu hardware pagetables for live update
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

Register iommufd with the LUO framework and implement the preserve and
unpreserve ops to save marked HWPTs.

To make sure mappings do not change during preserved state, add a
liveupdate_immutable flag to IOAS. When an HWPT is preserved, its IOAS
is marked immutable and any map/unmap attempts will fail with -EBUSY.
This is synchronized using the domains_rwsem to prevent races with
concurrent mapping operations.

The preserve callback iterates over the marked HWPTs, verifies that the
backing memory pages are preserved, and calls iommu_preserve_domain() to
preserve the associated IOMMU domain.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                             |   1 +
 drivers/iommu/iommufd/io_pagetable.c    |  24 ++
 drivers/iommu/iommufd/iommufd_private.h |  16 ++
 drivers/iommu/iommufd/liveupdate.c      | 327 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  10 +-
 include/linux/kho/abi/iommufd.h         |  56 ++++
 6 files changed, 433 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/kho/abi/iommufd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 78af4e3dc106..9ff159eaa8f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13742,6 +13742,7 @@ F:	drivers/iommu/iommufd/liveupdate.c
 F:	drivers/iommu/liveupdate.c
 F:	include/linux/iommu-liveupdate.h
 F:	include/linux/kho/abi/iommu.h
+F:	include/linux/kho/abi/iommufd.h
 
 IOMMUFD
 M:	Jason Gunthorpe <jgg@nvidia.com>
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4e447ce74cf6..e1021de3a6fa 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -30,6 +30,19 @@ struct iopt_pages_list {
 	unsigned long length;
 };
 
+static inline bool iopt_liveupdate_immutable(const struct io_pagetable *iopt)
+{
+	bool immutable = false;
+
+	lockdep_assert_held(&iopt->domains_rwsem);
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/* iopt becomes immutable once liveupdate preservation starts */
+	immutable = iopt->num_preserved_domains;
+#endif
+	return immutable;
+}
+
 struct iopt_area *iopt_area_contig_init(struct iopt_area_contig_iter *iter,
 					struct io_pagetable *iopt,
 					unsigned long iova,
@@ -384,6 +397,11 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
 		return rc;
 
 	down_read(&iopt->domains_rwsem);
+	if (iopt_liveupdate_immutable(iopt)) {
+		rc = -EBUSY;
+		goto out_unlock_domains;
+	}
+
 	rc = iopt_fill_domains_pages(pages_list);
 	if (rc)
 		goto out_unlock_domains;
@@ -755,6 +773,12 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 again:
 	down_read(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
+
+	if (iopt_liveupdate_immutable(iopt)) {
+		rc = -EBUSY;
+		goto out_unlock_iova;
+	}
+
 	while ((area = iopt_area_iter_first(iopt, start, last))) {
 		unsigned long area_last = iopt_area_last_iova(area);
 		unsigned long area_first = iopt_area_iova(area);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a33b32708afa..69d902b69b82 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -98,6 +98,9 @@ struct io_pagetable {
 	/* IOVA that cannot be allocated, struct iopt_reserved */
 	struct rb_root_cached reserved_itree;
 	u8 disable_large_pages;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	u32 num_preserved_domains;
+#endif
 	unsigned long iova_alignment;
 };
 
@@ -398,6 +401,7 @@ struct iommufd_hwpt_paging {
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
 #ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserved;
 	u64 liveupdate_token;
 #endif
 	/* Head at iommufd_ioas::hwpt_list */
@@ -738,8 +742,20 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_liveupdate_register(void);
+void iommufd_liveupdate_unregister(void);
+
 int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd);
 #else
+static inline int iommufd_liveupdate_register(void)
+{
+	return 0;
+}
+
+static inline void iommufd_liveupdate_unregister(void)
+{
+}
+
 static inline int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
 {
 	return -ENOTTY;
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 5fb491ff3a3d..828203d7254c 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -9,9 +9,28 @@
 
 #include <linux/file.h>
 #include <linux/iommufd.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/iommufd.h>
 #include <linux/liveupdate.h>
+#include <linux/iommu-liveupdate.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
 
 #include "iommufd_private.h"
+#include "io_pagetable.h"
+
+static u32 iopt_inc_num_preserved_domains(struct io_pagetable *iopt)
+{
+	guard(rwsem_write)(&iopt->domains_rwsem);
+	return ++iopt->num_preserved_domains;
+}
+
+static void iopt_dec_num_preserved_domains(struct io_pagetable *iopt)
+{
+	guard(rwsem_write)(&iopt->domains_rwsem);
+	if (!WARN_ON(!iopt->num_preserved_domains))
+		iopt->num_preserved_domains--;
+}
 
 int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
 {
@@ -70,3 +89,311 @@ int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ictx, &hwpt->common.obj);
 	return rc;
 }
+
+static int iopt_area_validate_file_pages(struct iopt_area *area)
+{
+	unsigned long last_index = iopt_area_last_index(area);
+	unsigned long index = iopt_area_index(area);
+	unsigned int page_offset = area->page_offset;
+	struct iopt_pages *pages = area->pages;
+	unsigned long iova = iopt_area_iova(area);
+
+	guard(mutex)(&pages->mutex);
+	if (WARN_ON(!area->storage_domain))
+		return -EINVAL;
+
+	while (index <= last_index) {
+		phys_addr_t phys = iommu_iova_to_phys(area->storage_domain,
+						      iova) - page_offset;
+		struct folio *folio = page_folio(pfn_to_page(PHYS_PFN(phys)));
+
+		if (folio->mapping != pages->file->f_mapping)
+			return -EINVAL;
+
+		iova += PAGE_SIZE - page_offset;
+		page_offset = 0;
+		index++;
+	}
+
+	return 0;
+}
+
+static int iopt_validate_preserved_memory(struct io_pagetable *iopt,
+					  struct liveupdate_session *s)
+{
+	struct iopt_area *area;
+	int ret = 0;
+
+	down_read(&iopt->iova_rwsem);
+	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
+	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
+		struct iopt_pages *pages = area->pages;
+
+		if (!pages)
+			continue;
+
+		/* Only allow file based mapping */
+		if (pages->type != IOPT_ADDRESS_FILE) {
+			ret = -EINVAL;
+			break;
+		}
+
+		/* Make sure that the file was preserved. */
+		ret = liveupdate_get_token_outgoing(s, pages->file, NULL);
+		if (ret)
+			break;
+
+		/*
+		 * Make sure the mapped pages are still associated with the
+		 * preserved memfd.
+		 */
+		ret = iopt_area_validate_file_pages(area);
+		if (ret)
+			break;
+	}
+	up_read(&iopt->iova_rwsem);
+
+	return ret;
+}
+
+static int iommufd_preserve_hwpt(struct iommufd_hwpt_paging *hwpt,
+				 struct iommufd_hwpt_ser *hwpt_ser,
+				 struct liveupdate_session *session)
+{
+	struct iommu_domain_ser *domain_ser;
+	int rc;
+
+	/*
+	 * Make IOAS immutable so the DMA mappings do not change while
+	 * the HWPT is preserved. Since one IOAS can have multiple
+	 * HWPTs, if an error occurs this call needs to make the IOAS
+	 * mutable again if it was the one that made it immutable.
+	 */
+	if (iopt_inc_num_preserved_domains(&hwpt->ioas->iopt) == 1) {
+		rc = iopt_validate_preserved_memory(&hwpt->ioas->iopt, session);
+		if (rc)
+			goto err;
+	}
+
+	hwpt_ser->size = sizeof(*hwpt_ser);
+	hwpt_ser->token = hwpt->liveupdate_token;
+
+	rc = iommu_preserve_domain(hwpt->common.domain, &domain_ser);
+	if (rc < 0)
+		goto err;
+
+	hwpt_ser->domain_ser_phys = virt_to_phys(domain_ser);
+	return 0;
+
+err:
+	iopt_dec_num_preserved_domains(&hwpt->ioas->iopt);
+	return rc;
+}
+
+static void _iommufd_unpreserve(struct iommufd_ctx *ictx,
+				struct iommufd_ser *ser)
+{
+	struct iommufd_hwpt_paging *hwpt;
+	struct iommufd_object *obj;
+	unsigned long index;
+
+	xa_lock(&ictx->objects);
+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
+		if (!hwpt->liveupdate_preserved)
+			continue;
+
+		xa_unlock(&ictx->objects);
+
+		iommu_unpreserve_domain(hwpt->common.domain);
+		iopt_dec_num_preserved_domains(&hwpt->ioas->iopt);
+
+		hwpt->liveupdate_preserved = false;
+		iommufd_put_object(ictx, obj);
+
+		xa_lock(&ictx->objects);
+	}
+	xa_unlock(&ictx->objects);
+
+	kho_unpreserve_free(ser);
+}
+
+static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
+{
+	struct iommufd_ctx *ictx;
+	struct iommufd_hwpt_paging *hwpt;
+	struct iommufd_ser *iommufd_ser;
+	struct iommufd_object *obj;
+	unsigned int num_hwpts;
+	unsigned long index;
+	unsigned int i;
+	void *mem;
+	int rc;
+
+	ictx = iommufd_ctx_from_file(args->file);
+	if (IS_ERR(ictx))
+		return PTR_ERR(ictx);
+
+	mutex_lock(&ictx->liveupdate_mutex);
+
+	/* Count the number of HWPTs to preserve */
+	num_hwpts = 0;
+	xa_lock(&ictx->objects);
+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
+		if (!hwpt->common.domain) {
+			rc = -EINVAL;
+			xa_unlock(&ictx->objects);
+			goto out_unlock;
+		}
+		num_hwpts++;
+	}
+	xa_unlock(&ictx->objects);
+
+	mem = kho_alloc_preserve(struct_size(iommufd_ser,
+					     hwpt_array, num_hwpts));
+	if (IS_ERR(mem)) {
+		rc = PTR_ERR(mem);
+		goto out_unlock;
+	}
+
+	iommufd_ser = mem;
+	iommufd_ser->size = sizeof(*iommufd_ser);
+
+	/* Preserve HWPTs */
+	i = 0;
+	xa_lock(&ictx->objects);
+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		if (!iommufd_lock_obj(obj)) {
+			rc = -ENOENT;
+			xa_unlock(&ictx->objects);
+			goto out_unpreserve;
+		}
+
+		/*
+		 * HWPT is locked so it will not be destroyed. The xarray lock
+		 * can be released here before preserving the HWPT.
+		 */
+		xa_unlock(&ictx->objects);
+		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
+		rc = iommufd_preserve_hwpt(hwpt, &iommufd_ser->hwpt_array[i++], args->session);
+		if (rc) {
+			iommufd_put_object(ictx, obj);
+			goto out_unpreserve;
+		}
+
+		/*
+		 * Mark the HWPT as successfully preserved. This is distinct
+		 * from IOMMUFD_OBJ_LIVEUPDATE_MARK, which only indicates the
+		 * userspace intent to preserve.
+		 */
+		hwpt->liveupdate_preserved = true;
+		xa_lock(&ictx->objects);
+	}
+	xa_unlock(&ictx->objects);
+
+	/* Store the actual number of HWPTs that are preserved */
+	iommufd_ser->num_hwpts = i;
+
+	args->serialized_data = virt_to_phys(iommufd_ser);
+	mutex_unlock(&ictx->liveupdate_mutex);
+	iommufd_ctx_put(ictx);
+	return 0;
+
+out_unpreserve:
+	_iommufd_unpreserve(ictx, iommufd_ser);
+out_unlock:
+	mutex_unlock(&ictx->liveupdate_mutex);
+	iommufd_ctx_put(ictx);
+	return rc;
+}
+
+static void iommufd_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
+{
+	struct iommufd_ctx *ictx;
+
+	ictx = iommufd_ctx_from_file(args->file);
+	if (WARN_ON(IS_ERR(ictx)))
+		return;
+
+	mutex_lock(&ictx->liveupdate_mutex);
+	_iommufd_unpreserve(ictx, phys_to_virt(args->serialized_data));
+	mutex_unlock(&ictx->liveupdate_mutex);
+
+	iommufd_ctx_put(ictx);
+}
+
+static int iommufd_liveupdate_retrieve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static bool iommufd_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	return false;
+}
+
+static void iommufd_liveupdate_finish(struct liveupdate_file_op_args *args)
+{
+}
+
+static bool iommufd_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					    struct file *file)
+{
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(file);
+
+	if (IS_ERR(ictx))
+		return false;
+
+	iommufd_ctx_put(ictx);
+	return true;
+}
+
+static struct liveupdate_file_ops iommufd_ser_file_ops = {
+	.can_preserve = iommufd_liveupdate_can_preserve,
+	.preserve = iommufd_liveupdate_preserve,
+	.unpreserve = iommufd_liveupdate_unpreserve,
+	.retrieve = iommufd_liveupdate_retrieve,
+	.can_finish = iommufd_liveupdate_can_finish,
+	.finish = iommufd_liveupdate_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler iommufd_ser_handler = {
+	.compatible = IOMMUFD_LUO_COMPATIBLE,
+	.ops = &iommufd_ser_file_ops,
+};
+
+int iommufd_liveupdate_register(void)
+{
+	int ret;
+
+	ret = liveupdate_register_file_handler(&iommufd_ser_handler);
+	if (ret)
+		goto out;
+
+	ret = iommu_liveupdate_register_flb(&iommufd_ser_handler);
+	if (ret)
+		liveupdate_unregister_file_handler(&iommufd_ser_handler);
+
+out:
+	if (ret == -EOPNOTSUPP)
+		return 0;
+
+	return ret;
+}
+
+void iommufd_liveupdate_unregister(void)
+{
+	iommu_liveupdate_unregister_flb(&iommufd_ser_handler);
+	liveupdate_unregister_file_handler(&iommufd_ser_handler);
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index fe8610fd58e3..86a578fb8e18 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -805,11 +805,18 @@ static int __init iommufd_init(void)
 		if (ret)
 			goto err_misc;
 	}
-	ret = iommufd_test_init();
+
+	ret = iommufd_liveupdate_register();
 	if (ret)
 		goto err_vfio_misc;
+
+	ret = iommufd_test_init();
+	if (ret)
+		goto err_liveupdate;
 	return 0;
 
+err_liveupdate:
+	iommufd_liveupdate_unregister();
 err_vfio_misc:
 	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
 		misc_deregister(&vfio_misc_dev);
@@ -821,6 +828,7 @@ static int __init iommufd_init(void)
 static void __exit iommufd_exit(void)
 {
 	iommufd_test_exit();
+	iommufd_liveupdate_unregister();
 	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
 		misc_deregister(&vfio_misc_dev);
 	misc_deregister(&iommu_misc_dev);
diff --git a/include/linux/kho/abi/iommufd.h b/include/linux/kho/abi/iommufd.h
new file mode 100644
index 000000000000..442c12b9bdad
--- /dev/null
+++ b/include/linux/kho/abi/iommufd.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_IOMMUFD_H
+#define _LINUX_KHO_ABI_IOMMUFD_H
+
+#include <linux/mutex_types.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * DOC: IOMMUFD Live Update ABI
+ *
+ * This header defines the ABI for preserving the state of an IOMMUFD file
+ * across a kexec reboot using LUO.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the IOMMUFD_LUO_COMPATIBLE string.
+ */
+
+#define IOMMUFD_LUO_COMPATIBLE "iommufd-v1"
+
+/**
+ * struct iommufd_hwpt_ser - IOMMUFD HWPT serialized state
+ * @size: Size of this struct
+ * @padding: Padding
+ * @domain_ser_phys: Physical address of the serialized state of associated domain
+ * @token: User provided token
+ */
+struct iommufd_hwpt_ser {
+	u32 size;
+	u32 padding;
+	u64 domain_ser_phys;
+	u64 token;
+} __packed;
+
+/**
+ * struct iommufd_ser - IOMMUFD serialized state
+ * @size: Size of this struct
+ * @features: Bitmask of iommufd specific features used by the preserved state
+ * @num_hwpts: Number of preserved HWPTs
+ * @hwpt_array: Array of serialized state of preserved HWPTs
+ */
+struct iommufd_ser {
+	u32 size;
+	u32 features;
+	u64 num_hwpts;
+	struct iommufd_hwpt_ser hwpt_array[];
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_IOMMUFD_H */
-- 
2.56.0.257.gf7497c7d27-goog

