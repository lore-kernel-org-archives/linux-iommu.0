Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F903E959F
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312620; cv=none; b=ZpybJcZCA7LhRtzGzgA6T2LYgODtWuDntFTQSg1HROQafbnyYapbUKlwYBrQX/IbsuYX6pjaQjKTe8ZA4juLnDaA3C8xwdYHFT3z+pJQTei0dCdQ6tirK1Rvfsg3lEbuOGPDb/QobnCKPEpZ7mtGSdN4d8IgYxPQYTfnkM1vy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312620; c=relaxed/simple;
	bh=CVIYa5QcZaOW9apPhx1U4HXpAStxdlZcik0CSC95ejI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=coTwczHsdWR+hnpPzPObxSJC9R7q2oa60SwcrHNZvrtMcQrnTlcNhtrmGBupEwA0IfJND7Vj1eNEK/ERw7TFkBk8k0ISxB6j5vmshANEq9mn7cfq5ZED5sYkh6svkRDIJD+GXqLsaaK4lchfYzJgmB5w3YnoTViaBeYLJWN0pUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5V98Xpf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5V98Xpf"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso12654807a91.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312617; x=1777917417; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6d7fZ2lPrXUtnnQpkPpt+aKk/Do4o0Jzv5MNMm2roeE=;
        b=G5V98Xpf9fIAuuceLpjjEYnKoM2f+kuiMGD8RvnTnVWADVTKxHj3dzf+5l9VBlHY8d
         5/93zXv11HT/ltSU4QfMf10Fk6sMHN7phfkGTd8BfzBfiBu1RpQmfcmrJv0DEoEWWows
         FBerkqUgxkvBXGn8OX85KSRoVaJfqrEvZWyODCikL/w4TRInQ1HOFj4o9ndXLOcG2h5t
         TUG7X8sk6+w/8n6XlzO3MbnuNx3LORs5CDMq2LrWts1YVNqVXv879b2RcNRrFwUn+MuW
         CFINc7XghaPyHE71oMojAP0yi6unnoE5q9BtDRMR6GmI49sLG1lmTzAQn3n04bIYH91i
         5AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312617; x=1777917417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6d7fZ2lPrXUtnnQpkPpt+aKk/Do4o0Jzv5MNMm2roeE=;
        b=a5/H+wzwEIIZR54zF+vRUKRZYovyl4m4HQx/OX4rLeLdJPdi5/RAqYWySntwrF/dPe
         QJKgp8aFbeGJew068sY+qmg+lyQvrPuJTZdyfxJ7KODoIcM+NNqRwOHrz1IZTu959DD4
         tuO/p7NhgcbAgKKFckn1Hn7ADqH9ZyrXPdp0k2Ogz9Mw2ULPySpn5b90crVs5hJQhSuB
         l+UYybKyrqvGi+ecI4J7UUhnHB+lncjgagPa74BEdAjr9uUkSvyPmeCBjK1cqbwglL3Z
         7yNS819jUT3VqSP3ocutaxLkzF2kfqTI7lfiVE/zFu9HvtbKDaU6FXAO95pdnhcZeHR7
         cFUA==
X-Forwarded-Encrypted: i=1; AFNElJ+p6v4bPOtHZ56cNqSDXLvtE0Sc09NRGiaxpNNCc5gP2THUTj487aHaXkYpj55FFRs5w69KvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrAyhTZv+mzQkxW67bhONW47O9CmEWoNQgIW1edji+mDo3FRuj
	vWQ/Uy6khS88Q1UVGh+M2O/3a/RGwFaZPRtH9I7e2SxlF65wgfxStsU9rA7AHqKk3G7zxxQGpBw
	hQX5zj2EdPO3rug==
X-Received: from pjhh23.prod.google.com ([2002:a17:90a:517:b0:35f:c7e7:222e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b45:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-36490de9a96mr42262a91.11.1777312617266;
 Mon, 27 Apr 2026 10:56:57 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:30 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-14-skhawaja@google.com>
Subject: [PATCH v2 13/16] iommufd: Persist iommu hardware pagetables for live update
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
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
backing memory pages are preserved, and calls iommu_domain_preserve() to
preserve the associated IOMMU domain.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                             |   1 +
 drivers/iommu/iommufd/io_pagetable.c    |  11 +
 drivers/iommu/iommufd/io_pagetable.h    |   1 +
 drivers/iommu/iommufd/iommufd_private.h |  27 ++-
 drivers/iommu/iommufd/liveupdate.c      | 287 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  10 +-
 drivers/iommu/iommufd/pages.c           |   7 +
 include/linux/kho/abi/iommufd.h         |  51 +++++
 8 files changed, 393 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/kho/abi/iommufd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bf6a2ad61989..6005b737d1c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13500,6 +13500,7 @@ F:	drivers/iommu/iommufd/liveupdate.c
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
index 111f4d42e210..3c88aa115d08 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -98,6 +98,9 @@ struct io_pagetable {
 	/* IOVA that cannot be allocated, struct iopt_reserved */
 	struct rb_root_cached reserved_itree;
 	u8 disable_large_pages;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_immutable;
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
+	return iopt->liveupdate_immutable;
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
index 2d3abfa9e9f8..3cb220557d0d 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -9,9 +9,22 @@
 
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
+static void ioas_set_immutable(struct iommufd_ioas *ioas, bool immutable)
+{
+	down_write(&ioas->iopt.domains_rwsem);
+	ioas->iopt.liveupdate_immutable = immutable;
+	up_write(&ioas->iopt.domains_rwsem);
+}
 
 int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
 {
@@ -50,3 +63,277 @@ int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
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
+	bool ioas_made_immutable = false;
+	int rc;
+
+	if (!hwpt->ioas->iopt.liveupdate_immutable) {
+		/*
+		 * Make IOAS immutable so the DMA mappings do not change while
+		 * the HWPT is preserved. Since one IOAS can have multiple
+		 * HWPTs, if an error occurs this call needs to make the IOAS
+		 * mutable again if it was the one that made it immutable.
+		 */
+		ioas_made_immutable = true;
+		ioas_set_immutable(hwpt->ioas, true);
+
+		rc = check_iopt_pages_preserved(session, hwpt);
+		if (rc)
+			goto err;
+	}
+
+	hwpt_ser->token = hwpt->liveupdate_token;
+	hwpt_ser->reclaimed = false;
+
+	rc = iommu_domain_preserve(hwpt->common.domain, &domain_ser);
+	if (rc < 0)
+		goto err;
+
+	hwpt_ser->domain_data = virt_to_phys(domain_ser);
+	return 0;
+
+err:
+	if (ioas_made_immutable)
+		ioas_set_immutable(hwpt->ioas, false);
+
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
+		iommu_domain_unpreserve(hwpt->common.domain);
+		if (hwpt->ioas->iopt.liveupdate_immutable)
+			ioas_set_immutable(hwpt->ioas, false);
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
+	if (!mem) {
+		rc = -ENOMEM;
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
index 9bdb2945afe1..3b0c0acb8856 100644
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
@@ -1428,6 +1430,11 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
 	pages->file = get_file(file);
 	pages->start = start - start_byte;
 	pages->type = IOPT_ADDRESS_FILE;
+
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
2.54.0.545.g6539524ca2-goog

