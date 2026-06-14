Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D738C41E
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480266; cv=none; b=dRJn5VHvLju19zh0L7U7iPpBHcu1mqm6FiTxCIjfztAx3mPK3oi/wJdMC4wXag7GsDQI8kmBCYWyUQrlXYm2cTepfcN1PV2SP220hhIHAaHNym84W/D+ifGoQhLUa/g/UOoQKzK4rpxE1/SqbriKhyjz0q1EjrbJc7C2hhoiFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480266; c=relaxed/simple;
	bh=7e17X826Y+XMQZ2dnR0D4weFiCloEedzC/vljAIt4pg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVcMmgJ8vJcN+8e/mj4/kGaCdfOW1/FckT7M5h6OvgluULd1jmgBBEhFEMSlBApSNnexWv4v9jTf7RHxvsUqy+T1/PVGkNjjcMXIM+EwRgav4dHFKb1A4W+NM6yBgIIswRCdTG1CnipgmMDIWyu9dJqiNS6QpuRf4y8ypqi9Ykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xcgyuroc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xcgyuroc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423770d72dso3949735b3a.3
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480262; x=1782085062; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18McNTVspD2nXNQT/ylWiLpLakTdXbN65qMwtb85K64=;
        b=Xcgyurocjvf19TGMB7LIGSB9iWg+Zk5tynYAwecNWf6jBuyH9JN2DkCg5yPF3IF/gu
         7skpqheLvFvy5NSjeNE4aARyDqDp5vXHq/eh0kfd2U9d399XWEStPLzcVSzSO6Sx1LXy
         4Tx7QCVlvP102qGJCE2QXHobk0YpNXH005WLwAUXnQQ0HxAn+eebwIfjmGUF64h7o/sx
         xqSa8A8G0pviZ7v1xqeCWQnH/tLVuyXer4yg4jb/seIcYXg79PfwP/LkngvZyNAJ+unp
         8LvK9/C0pqQpQD0753U90sMmFoFABw4DD2hLe8pGktoZktC+2D9wtPhNFuvxceCdoGGG
         bp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480262; x=1782085062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18McNTVspD2nXNQT/ylWiLpLakTdXbN65qMwtb85K64=;
        b=gzgZ5UIULsFenDa6Z5eSNCHYq/lqMj2goeeCCt6x7sMMg1oJgaKqX46/aRqx6xsZJW
         xHTTYdJ28vQgxpsKdhBkpSAkUdirYh47sxtP5Lt65zweU45wc8TXHxZDMCeq5ooK2Qlm
         QjPHLxEZhYd4Q+I5ehph4JIt4zGY0OdXk2JGQ91Hh7EZvCZ3cSQq+ulaYCrB+pXXEnXK
         YOUBNqayRusbu7rDYdAE4M0mQT/BLJq2z/2SB8I+nph2XISafbO7oyfMZK/vJ09qFfcb
         UlszQh6U6oGaN7U9Vvwexb2BHDwhqWodZSyz9TgpEcJ7MWzEN1HmcXAVtmgsnuPbuCb7
         cnZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KYTQqe0J5igCJFnm/T68EK44RYAy269JPG0eQT4BLQUy0wHeh/sVBcLCsjXgM80MHEMbNaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw41JDJk1vaGLaS/XIpL+PXt8yx+4o8m8AmjkuaHoNJT9j4Cq7E
	sZdxKadsL6wnP2q8K6ORY9wGnihBmoL3wvbt4i4I/D7XAtLwdrx0FVJhrQbkIjIK9aXF68iP4SV
	Fwa6ND2ooN6TYBw==
X-Received: from pfez11.prod.google.com ([2002:aa7:888b:0:b0:844:e56c:ba8c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2443:b0:842:2280:538f with SMTP id d2e1a72fcca58-844e198117fmr9131298b3a.16.1781480261880;
 Sun, 14 Jun 2026 16:37:41 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:25 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-16-skhawaja@google.com>
Subject: [PATCH v3 15/18] iommufd: Persist iommu hardware pagetables for live update
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
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
 drivers/iommu/iommufd/io_pagetable.c    |  11 +
 drivers/iommu/iommufd/io_pagetable.h    |   1 +
 drivers/iommu/iommufd/iommufd_private.h |  27 ++-
 drivers/iommu/iommufd/liveupdate.c      | 298 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  10 +-
 drivers/iommu/iommufd/pages.c           |  11 +
 include/linux/kho/abi/iommufd.h         |  51 ++++
 8 files changed, 408 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/kho/abi/iommufd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ef9f2b75d6f..c3b71915037d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13502,6 +13502,7 @@ F:	drivers/iommu/iommufd/liveupdate.c
 F:	drivers/iommu/liveupdate.c
 F:	include/linux/iommu-liveupdate.h
 F:	include/linux/kho/abi/iommu.h
+F:	include/linux/kho/abi/iommufd.h
 
 IOMMUFD
 M:	Jason Gunthorpe <jgg@nvidia.com>
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 24d4917105d9..b18dba9dd147 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -384,6 +384,11 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
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
@@ -755,6 +760,12 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
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
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 27e3e311d395..207ff368d412 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -234,6 +234,7 @@ struct iopt_pages {
 		struct {			/* IOPT_ADDRESS_FILE */
 			struct file *file;
 			unsigned long start;
+			u32 seals;
 		};
 		/* IOPT_ADDRESS_DMABUF */
 		struct iopt_pages_dmabuf dmabuf;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 111f4d42e210..9e0e46f1f7ed 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -98,6 +98,9 @@ struct io_pagetable {
 	/* IOVA that cannot be allocated, struct iopt_reserved */
 	struct rb_root_cached reserved_itree;
 	u8 disable_large_pages;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	u32 nr_preserved_domains;
+#endif
 	unsigned long iova_alignment;
 };
 
@@ -379,7 +382,7 @@ struct iommufd_hwpt_paging {
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
 #ifdef CONFIG_IOMMU_LIVEUPDATE
-	bool liveupdate_preserve : 1;
+	bool liveupdate_preserved : 1;
 	u64 liveupdate_token;
 #endif
 	/* Head at iommufd_ioas::hwpt_list */
@@ -716,12 +719,34 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 }
 
 #ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_liveupdate_register(void);
+void iommufd_liveupdate_unregister(void);
+
 int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd);
+
+static inline bool iopt_liveupdate_immutable(const struct io_pagetable *iopt)
+{
+	return iopt->nr_preserved_domains > 0;
+}
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
 }
+
+static inline bool iopt_liveupdate_immutable(const struct io_pagetable *iopt)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index e0d2c4aa2466..621bc4526d8e 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -9,9 +9,31 @@
 
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
+static bool ioas_set_immutable(struct iommufd_ioas *ioas, bool set)
+{
+	bool was_immutable;
+
+	down_write(&ioas->iopt.domains_rwsem);
+	was_immutable = ioas->iopt.nr_preserved_domains > 0;
+	if (set)
+		ioas->iopt.nr_preserved_domains++;
+	else if (!WARN_ON(!was_immutable))
+			ioas->iopt.nr_preserved_domains--;
+
+	up_write(&ioas->iopt.domains_rwsem);
+
+	return was_immutable;
+}
 
 int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
 {
@@ -54,3 +76,279 @@ int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ictx, &hwpt_target->common.obj);
 	return rc;
 }
+
+static int check_iopt_pages_preserved(struct liveupdate_session *s,
+				      struct iommufd_hwpt_paging *hwpt)
+{
+	u32 req_seals = F_SEAL_SEAL | F_SEAL_GROW | F_SEAL_SHRINK;
+	struct iopt_area *area;
+	int ret = 0;
+
+	down_read(&hwpt->ioas->iopt.iova_rwsem);
+	for (area = iopt_area_iter_first(&hwpt->ioas->iopt, 0, ULONG_MAX); area;
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
+		/*
+		 * When this memory file was mapped it should be sealed and seal
+		 * should be sealed. This means that since mapping was done the
+		 * memory file was not grown or shrink and the pages being used
+		 * until now remain pinned and preserved.
+		 */
+		if ((pages->seals & req_seals) != req_seals) {
+			ret = -EINVAL;
+			break;
+		}
+
+		/* Make sure that the file was preserved. */
+		ret = liveupdate_get_token_outgoing(s, pages->file, NULL);
+		if (ret)
+			break;
+	}
+	up_read(&hwpt->ioas->iopt.iova_rwsem);
+
+	return ret;
+}
+
+static int iommufd_preserve_hwpt(struct iommufd_hwpt_paging *hwpt,
+				 struct iommufd_hwpt_ser *hwpt_ser,
+				 struct liveupdate_session *session)
+{
+	struct iommu_domain_ser *domain_ser;
+	bool was_immutable;
+	int rc;
+
+	/*
+	 * Make IOAS immutable so the DMA mappings do not change while
+	 * the HWPT is preserved. Since one IOAS can have multiple
+	 * HWPTs, if an error occurs this call needs to make the IOAS
+	 * mutable again if it was the one that made it immutable.
+	 */
+	was_immutable = ioas_set_immutable(hwpt->ioas, true);
+
+	if (!was_immutable) {
+		rc = check_iopt_pages_preserved(session, hwpt);
+		if (rc)
+			goto err;
+	}
+
+	hwpt_ser->token = hwpt->liveupdate_token;
+	hwpt_ser->reclaimed = false;
+
+	rc = iommu_preserve_domain(hwpt->common.domain, &domain_ser);
+	if (rc < 0)
+		goto err;
+
+	hwpt_ser->domain_data = virt_to_phys(domain_ser);
+	return 0;
+
+err:
+	ioas_set_immutable(hwpt->ioas, false);
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
+		ioas_set_immutable(hwpt->ioas, false);
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
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
+	struct iommufd_hwpt_paging *hwpt;
+	struct iommufd_ser *iommufd_ser;
+	struct iommufd_object *obj;
+	unsigned int nr_hwpts;
+	unsigned long index;
+	unsigned int i;
+	void *mem;
+	int rc;
+
+	if (IS_ERR(ictx))
+		return PTR_ERR(ictx);
+
+	mutex_lock(&ictx->liveupdate_mutex);
+
+	/* Count the number of HWPTs to preserve */
+	nr_hwpts = 0;
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
+		nr_hwpts++;
+	}
+	xa_unlock(&ictx->objects);
+
+	mem = kho_alloc_preserve(struct_size(iommufd_ser,
+					     hwpt_array, nr_hwpts));
+	if (IS_ERR(mem)) {
+		rc = PTR_ERR(mem);
+		goto out_unlock;
+	}
+
+	iommufd_ser = mem;
+	iommufd_ser->nr_hwpts = nr_hwpts;
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
+		/* Mark as preserved */
+		hwpt->liveupdate_preserved = true;
+		xa_lock(&ictx->objects);
+	}
+	xa_unlock(&ictx->objects);
+
+	/* Store the actual number of HWPTs that are preserved */
+	iommufd_ser->nr_hwpts = i;
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
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
+
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
+		return ret;
+
+	ret = iommu_liveupdate_register_flb(&iommufd_ser_handler);
+	if (ret)
+		liveupdate_unregister_file_handler(&iommufd_ser_handler);
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
index 0114c1520db4..0a7e7bb586d7 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -782,11 +782,18 @@ static int __init iommufd_init(void)
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
@@ -798,6 +805,7 @@ static int __init iommufd_init(void)
 static void __exit iommufd_exit(void)
 {
 	iommufd_test_exit();
+	iommufd_liveupdate_unregister();
 	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
 		misc_deregister(&vfio_misc_dev);
 	misc_deregister(&iommu_misc_dev);
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9bdb2945afe1..1323073e3e23 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -55,6 +55,7 @@
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
+#include <linux/memfd.h>
 #include <linux/vfio_pci_core.h>
 
 #include "double_span.h"
@@ -1421,6 +1422,7 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
 
 {
 	struct iopt_pages *pages;
+	int seals;
 
 	pages = iopt_alloc_pages(start_byte, length, writable);
 	if (IS_ERR(pages))
@@ -1428,6 +1430,15 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
 	pages->file = get_file(file);
 	pages->start = start - start_byte;
 	pages->type = IOPT_ADDRESS_FILE;
+
+	/*
+	 * Get seals from the memfd during mapping to verify that these did not
+	 * change before iommufd preservation.
+	 */
+	seals = memfd_get_seals(file);
+	if (seals > 0)
+		pages->seals = seals;
+
 	return pages;
 }
 
diff --git a/include/linux/kho/abi/iommufd.h b/include/linux/kho/abi/iommufd.h
new file mode 100644
index 000000000000..e0c13b965cb9
--- /dev/null
+++ b/include/linux/kho/abi/iommufd.h
@@ -0,0 +1,51 @@
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
+ * struct iommu_hwpt_ser - IOMMUFD HWPT serialized state
+ * @domain_data: Physical address of the serialized state of associated domain
+ * @token: User provided token
+ * @reclaimed: Whether the HWPT is reclaimed
+ */
+struct iommufd_hwpt_ser {
+	u64 domain_data;
+	u64 token;
+	u8 reclaimed;
+	u8 padding[7];
+} __packed;
+
+/**
+ * struct iommu_ser - IOMMUFD serialized state
+ * @nr_hwpts: Number of preserved HWPTs
+ * @hwpt_array: Array of serialized state of preserved HWPTs
+ */
+struct iommufd_ser {
+	u64 nr_hwpts;
+	struct iommufd_hwpt_ser hwpt_array[];
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_IOMMUFD_H */
-- 
2.54.0.1136.gdb2ca164c4-goog

