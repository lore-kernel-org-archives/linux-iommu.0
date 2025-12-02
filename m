Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D906233140
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716596; cv=none; b=dsdTu/natCjjyc1ylxlwkhzHoSuh5XfEsBgtmchZf9cE5eZ+QR1k3+1tuKkwtVAClkcAv4wkVTacSkEhIW+dRllXlGGRx87i2gh0shYkFUm40ChmLrBmMb9ChVueYrtHO5LINzRPKSlfiK+28g2hc+Vj+8XM7JgaRxnDhh3JLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716596; c=relaxed/simple;
	bh=nzSLAie0jFB7cPwhqutsO4BgS1XgbzmY8lUQyB1/C9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oofio0OSMOJzXg1wJqtmrvQEyDE8lP17zCkT0a6oiGEXYgQsf4NG+KWPxp4olNP+Zp233u7DObCMFKQhedK4O0i7yvQDHLScBkJ3StNGsi0lrWdKEEh4FPKG5IX17HgNwkaP+bMYZjie2ShQWsyXGWVd4Zf84poX+YmkbWN8JmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2fg2vP7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2fg2vP7"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b8973c4608so4992725b3a.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716594; x=1765321394; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=046qB4fjZ0cRNJX3X7b8SNp6xfmHPdhEjSVk0EIs0AI=;
        b=k2fg2vP7SYFduyVAB0PmLlMm3GeDUgGna+TZOmdK0RIFXCKGOLLm4MU9AmXBXoFHsW
         NOfSIKzUP0c+b+eajfGyXKTiLO+gLNRlNxXo8N/0cM1ZCSJ0mjfOpSQ1OOjlqYGKF96g
         xoC9gqO4WamOG7JS6hUX/opjPlKGDGm/Zn6gBWmet5DaEsU8J+r2C1shl+xZf2hLLuxo
         uM6ATsOAUyGeCqH1d2SOFxnGhn6OwDs2QXI5QABkrnaz5C2SF1PXedhysegmlh8FVhNC
         jTL094+R6FKsMqLHY5aBL8h/F+MUkA6km3AH8tzdW05UIdvTPKvZjv+PW0c/wSzHUKG5
         f1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716594; x=1765321394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=046qB4fjZ0cRNJX3X7b8SNp6xfmHPdhEjSVk0EIs0AI=;
        b=Oi4j52k9Drg+W1T3CLri9PUNr1P0Cmve9nbbLT0GqfZ9iP0Ht/Va/sXGGixFnf/vil
         o2n12Vhtdd+o246YXtsN7i5Q5uQ1OoO/OSMR37BBy6XvXaSQrEhIhL6FSMEWFHCI/M3f
         GitXew4GgY0U+OwpAgiMSaoHnvM608Ep4KjMI6sTw074YeT8x699MZwR4BQ9ao27IBmF
         N4oYppX86LYYbY8PBJ/G96ixT4ocBZ8uRrX8U8oAP8pTtornUzkTQts/+0yP2GjU9/wI
         T3175GNrmjP0DpMLSDnCdXah128f5FOdqTDO0IpwSYllIrD1Z3Q4gsV/BqQ2jHJkMip7
         FlAw==
X-Forwarded-Encrypted: i=1; AJvYcCWwMTwtM6Bo/Pw4tHLRd1EOOUP6Sjy3WmYnJu3RfTSF23GmoddMzZ2RS7KyVV36LTazE0kb2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxvWfT3bMWm1vF5Gfs7EOqAYkxZvV7wg6zv8PuDRX3xcpppNJo
	KY8nnE22/8jXxBiD9OmnWRkXt3j9MKc5n9zCaZvL2HuFMqznroMLTPZ16rTRTMXCrS9EYOO5B0d
	sMfiSLr8tPDXn2g==
X-Google-Smtp-Source: AGHT+IFvJ3H3fV2RISzlSfdE9aXZKS1sOthQYmJ7HBrcNeEykIUJQ40O50zkik2QzNRdfs+MyzFzK00BNNGiIw==
X-Received: from pfbgb9.prod.google.com ([2002:a05:6a00:6289:b0:7b8:f661:263e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3c91:b0:7ac:1444:6777 with SMTP id d2e1a72fcca58-7e00ae6ce08mr202102b3a.12.1764716594075;
 Tue, 02 Dec 2025 15:03:14 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:36 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-7-skhawaja@google.com>
Subject: [RFC PATCH v2 06/32] iommufd-lu: Persist iommu hardware pagetables
 for live update
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

The caller is expected to mark each HWPT to be preserved with an ioctl
call, with a token that will be used in restore. At preserve time, each
HWPT's domain is then called with iommu_domain_preserve to preserve the
iommu domain.

On restore, each preserved HWPT is expected to be restored with another
ioctl call, This HWPT will be recreated without a parent IOAS, and its
domain recreated with iommu_domain_restore. The caller is expected to
later swap the old restored attachments with newly created HWPTs through
normal means such as VFIO_DEVICE_ATTACH_IOMMUFD_PT.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   6 +-
 drivers/iommu/iommufd/liveupdate.c      | 161 +++++++++++++++++++++++-
 drivers/iommu/iommufd/main.c            |  19 +++
 include/linux/kho/abi/iommufd.h         |   8 ++
 4 files changed, 189 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 54c7c9888de3..15afff6ba0ea 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -726,9 +726,13 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 int iommufd_liveupdate_register_lufs(void);
 int iommufd_liveupdate_unregister_lufs(void);
 
-
 int iommufd_hwpt_lu_set_preserved(struct iommufd_ucmd *ucmd);
 int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd);
+
+/* TODO */
+#define iommu_domain_restore(x) ERR_PTR(-EOPNOTSUPP)
+#define iommu_domain_preserve(x, y) (-EOPNOTSUPP)
+#define iommu_domain_has_attachments(x) (false)
 #else
 static inline int iommufd_liveupdate_register_lufs(void)
 {
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 83d1b888d914..42b380229c57 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -9,6 +9,7 @@
 #include <linux/kho/abi/iommufd.h>
 #include <linux/liveupdate.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 
 #include "iommufd_private.h"
 
@@ -53,6 +54,82 @@ int iommufd_hwpt_lu_set_preserved(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+static int iommufd_save_hwpts(struct iommufd_ctx *ictx,
+			      struct iommufd_lu *iommufd_lu)
+{
+	struct iommufd_hwpt_paging *hwpt, **hwpts = NULL;
+	struct iommufd_hwpt_lu *hwpt_lu;
+	struct iommufd_object *obj;
+	unsigned int nr_hwpts = 0;
+	unsigned long index;
+	unsigned int i;
+	int rc = 0;
+
+	if (iommufd_lu) {
+		hwpts = kcalloc(iommufd_lu->nr_hwpts, sizeof(*hwpts),
+				GFP_KERNEL);
+		if (!hwpts)
+			return -ENOMEM;
+	}
+
+	xa_lock(&ictx->objects);
+	xa_for_each(&ictx->objects, index, obj) {
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
+		if (!hwpt->lu_preserved)
+			continue;
+
+		/*
+		 * TODO: The HWPT should be made immutable, and cannot be
+		 * destroyed
+		 */
+
+		if (!hwpt->common.domain) {
+			rc = -EINVAL;
+			xa_unlock(&ictx->objects);
+			goto out;
+		}
+
+		if (iommufd_lu) {
+			hwpts[nr_hwpts] = hwpt;
+			hwpt_lu = &iommufd_lu->hwpts[nr_hwpts];
+
+			hwpt_lu->token = hwpt->lu_token;
+			hwpt_lu->reclaimed = false;
+		}
+
+		nr_hwpts++;
+	}
+	xa_unlock(&ictx->objects);
+
+	if (WARN_ON(iommufd_lu && iommufd_lu->nr_hwpts != nr_hwpts)) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	if (iommufd_lu) {
+		/*
+		 * iommu_domain_preserve may sleep and must be called
+		 * outside of xa_lock
+		 */
+		for (i = 0; i < nr_hwpts; i++) {
+			hwpt = hwpts[i];
+			hwpt_lu = &iommufd_lu->hwpts[i];
+
+			rc = iommu_domain_preserve(hwpt->common.domain, &hwpt_lu->domain_data);
+			goto out;
+		}
+	}
+
+	rc = nr_hwpts;
+
+out:
+	kfree(hwpts);
+	return rc;
+}
+
 static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
 {
 	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
@@ -64,7 +141,11 @@ static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	if (IS_ERR(ictx))
 		return PTR_ERR(ictx);
 
-	serial_size = sizeof(*iommufd_lu);
+	rc = iommufd_save_hwpts(ictx, NULL);
+	if (rc < 0)
+		goto err_ctx_put;
+
+	serial_size = struct_size(iommufd_lu, hwpts, rc);
 
 	mem = kho_alloc_preserve(serial_size);
 	if (!mem) {
@@ -73,11 +154,17 @@ static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	}
 
 	iommufd_lu = mem;
+	iommufd_lu->nr_hwpts = rc;
+	rc = iommufd_save_hwpts(ictx, iommufd_lu);
+	if (rc < 0)
+		goto err_free;
 
 	args->serialized_data = virt_to_phys(iommufd_lu);
 	iommufd_ctx_put(ictx);
 	return 0;
 
+err_free:
+	kho_unpreserve_free(mem);
 err_ctx_put:
 	iommufd_ctx_put(ictx);
 	return rc;
@@ -92,10 +179,31 @@ static int iommufd_liveupdate_freeze(struct liveupdate_file_op_args *args)
 static void iommufd_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
+	struct iommufd_hwpt_paging *hwpt;
+	struct iommufd_object *obj;
+	unsigned long index;
 
 	if (WARN_ON(IS_ERR(ictx)))
 		return;
 
+	xa_lock(&ictx->objects);
+	xa_for_each(&ictx->objects, index, obj) {
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
+		if (!hwpt->lu_preserved)
+			continue;
+
+		/* TODO: The HWPT should be made mutable again */
+
+		if (!hwpt->common.domain)
+			continue;
+
+		/* TODO: WARN_ON(iommu_domain_unpreserve(hwpt->common.domain)); */
+	}
+	xa_unlock(&ictx->objects);
+
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
 	iommufd_ctx_put(ictx);
 }
@@ -164,7 +272,53 @@ static bool iommufd_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 
 int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd)
 {
-	return -ENOTTY;
+	struct iommu_hwpt_lu_restore *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt = NULL;
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommufd_hwpt_lu *hwpt_lu;
+	struct iommufd_lu *iommufd_lu;
+	struct iommu_domain *domain;
+	unsigned int i;
+	int rc;
+
+	iommufd_lu = ictx->lu;
+	if (!iommufd_lu)
+		return -ENOTTY;
+
+	for (i = 0; i < iommufd_lu->nr_hwpts; i++) {
+		hwpt_lu = &iommufd_lu->hwpts[i];
+
+		if (hwpt_lu->reclaimed)
+			continue;
+
+		if (hwpt_lu->token == cmd->hwpt_token)
+			goto hwpt_found;
+	}
+
+	return -ENOENT;
+
+hwpt_found:
+	hwpt = _iommufd_hwpt_paging_alloc(ictx);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	/* a successful iommu_domain_restore mars the point of no return */
+	domain = iommu_domain_restore(hwpt_lu->domain_data);
+	if (IS_ERR(domain)) {
+		rc = PTR_ERR(domain);
+		goto err_destroy;
+	}
+
+	iommufd_hwpt_init_from_domain(&hwpt->common, domain);
+	iommufd_object_finalize(ictx, &hwpt->common.obj);
+
+	hwpt_lu->reclaimed = true;
+	cmd->pt_id = hwpt->common.obj.id;
+	return 0;
+
+err_destroy:
+	iommufd_object_abort_and_destroy(ictx, &hwpt->common.obj);
+	return rc;
 }
 
 static void iommufd_liveupdate_finish(struct liveupdate_file_op_args *args)
@@ -175,9 +329,8 @@ static void iommufd_liveupdate_finish(struct liveupdate_file_op_args *args)
 	ictx = iommufd_ctx_from_file(args->file);
 	iommufd_lu = ictx->lu;
 	ictx->lu = NULL;
-	iommufd_ctx_put(ictx);
-
 	folio_put(virt_to_folio(iommufd_lu));
+	iommufd_ctx_put(ictx);
 }
 
 static bool iommufd_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b63f61331cae..a334e3da3f45 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -207,6 +207,8 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 			  struct iommufd_object *to_destroy, u32 id,
 			  unsigned int flags)
 {
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommu_domain *domain;
 	struct iommufd_object *obj;
 	XA_STATE(xas, &ictx->objects, id);
 	bool zerod_wait_cnt = false;
@@ -250,6 +252,23 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 		goto err_xa;
 	}
 
+	if (obj->type == IOMMUFD_OBJ_HWPT_PAGING) {
+		/*
+		 * Normally attacments are refcounted, but this is not the case
+		 * for liveupdate-restored HWPTs.
+		 * Additionally, LUO holds a reference to struct files until
+		 * finish, which makes sure HWPTs are no-longer attached, so
+		 * this code path is not a concern in iommufd_fops_release
+		 */
+		hwpt_paging = container_of(obj, struct iommufd_hwpt_paging,
+					   common.obj);
+		domain = hwpt_paging->common.domain;
+		if (domain && iommu_domain_has_attachments(domain)) {
+			ret = -EBUSY;
+			goto err_xa;
+		}
+	}
+
 	if (!refcount_dec_if_one(&obj->users)) {
 		ret = -EBUSY;
 		goto err_xa;
diff --git a/include/linux/kho/abi/iommufd.h b/include/linux/kho/abi/iommufd.h
index 19d6b61ec3c3..f7393ac78aa9 100644
--- a/include/linux/kho/abi/iommufd.h
+++ b/include/linux/kho/abi/iommufd.h
@@ -25,7 +25,15 @@
 
 #define IOMMUFD_LUO_COMPATIBLE "iommufd-v1"
 
+struct iommufd_hwpt_lu {
+	u32 token;
+	u64 domain_data;
+	bool reclaimed;
+} __packed;
+
 struct iommufd_lu {
+	unsigned int nr_hwpts;
+	struct iommufd_hwpt_lu hwpts[];
 };
 
 #endif /* _LINUX_KHO_ABI_IOMMUFD_H */
-- 
2.52.0.158.g65b55ccf14-goog

