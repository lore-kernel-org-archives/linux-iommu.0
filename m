Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1472FD1AA
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716594; cv=none; b=VwoypRtWIetOq02RQKW6c+lo6OoQKKagYCFbnlTSEINoLEAzMv4R4pHy4pMqjJ5qJDqudHLGKRLh5sjnenvD+nZVqS3awi8mY60gMow2qGJcr/fXAqdRbIRXs+3vm1DFvrzjgVbns9HmeDVYxZO4OHUiceUJRBMClGTmSa1sZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716594; c=relaxed/simple;
	bh=/K8uDik6QCSK0i4Ua+hwdlpt8lNrAg5n9NpxcAWSP/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aBOD1MntszNqyCXCQ6zNc4Bb2X/zpVjlLg35H+pvsbvaaTGVJleVppSJvUUQmc1SoLviUdwMi3OoXYm2SdZX1BbWmmVEHtdjgcOUgb6JwSoj4AB/tNDD64BLQcEvlslHEwlGveYq7ZbHWn6hoUfIoyHRAKbUkRIGJOSnDYIrBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3zkhDI8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3zkhDI8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295595cd102so99859625ad.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716592; x=1765321392; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VumBE9iyIyTLHQhOOSNkQDglvxXqmYKVB+enH/zsx64=;
        b=k3zkhDI8D9FG5JRvS5Ij0EO0TOCt+mNfVgXgNCSz1ZOqhTGr4RnSafrgKU3Q1zT1b8
         J0jNbduRcLxBA22x14IE68NhZke7N22fhjlbUzFKL1cbBb1do4yhkpAUJ8OJBCCFIa0U
         yO9r6H/M0vueK2M1QvXa3ogdRfIzYjwIaWym+xzKRciOxlPIGyfBwBWAbcfEdvSuOTvg
         fUSZIyGVofE1nEA155KSAmyMS31LaIy8IMAwVO9KSLxTaYl4xzztI1w47EOOnHn+s7l2
         bk6ktXKz+KgSdPhiRpIOSMOsADs/z5a08nuY2PhxmggKWf1iE6LaJ50BM18YlsIuEwXR
         fpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716592; x=1765321392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VumBE9iyIyTLHQhOOSNkQDglvxXqmYKVB+enH/zsx64=;
        b=Q2jBPyVs45+xLRDYQBJj3W10v7mp3zhOUwpRxzhrb+l5XB4Fz708+5o8snmZma2xnX
         EDaKhQTRkPCqCBDuVvst0XCJzGzMpoDE+Vcfdvp/4eFW90RFW+LLkjyZfBBHGfmEQ7HB
         e+P78GV0596WD9huCHqN0wXIMJyd4k0jUVoOmwNaxmz7scdqMEPVrJyWzisEyWA1cyf0
         5AA1+tCGGybv0sPRo6xZ52yMv8rskfTpslYgm+wuvsU1yiWsw8bEz6MULybP1FplK98G
         rwfOHDiCINCnk6sVzZaMd173IUyeYasYz9JKW3Akr6BWJ+7xpVJ5eJPRaRCFmGxlMLm9
         LMXg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Hd2OhZwA4gWcVaLrzt9E04NCh1qEZ37jNFc0nxuBsdwt960bATQvModySEagw7e/QH/F6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXWXZ1YYp07P1e4w/CYuQ5wT9xOa9QJBfrnUkMwhDW6tthW4wu
	fQST/QVBppHK7F/2o7hVo1ZU1p1dVOJ9sBVD2OGf9dQONpTjfMs6UcTx62KH7opTncH4NuivKCk
	plg9n6dEhqsdW6A==
X-Google-Smtp-Source: AGHT+IG7VCw8eaNOJNxgVk4TOR4lIrv+Bnt6tRhRT5Yugq8N193VMxylwCUSAkx/8zZtEOQIev4r4qStGl2Cxw==
X-Received: from plpj3.prod.google.com ([2002:a17:903:3d83:b0:25f:48ba:97e1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4407:b0:295:5625:7e41 with SMTP id d9443c01a7336-29d6836bebdmr2461475ad.22.1764716592610;
 Tue, 02 Dec 2025 15:03:12 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:35 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-6-skhawaja@google.com>
Subject: [RFC PATCH v2 05/32] iommufd-lu: Implement ioctl to let userspace
 mark an HWPT to be preserved
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

Userspace provides a token, which will then be used at restore to
identify this HWPT.

A skeleton for te restore-side ioctl is also added.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 18 ++++++++++
 drivers/iommu/iommufd/liveupdate.c      | 46 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  4 +++
 include/uapi/linux/iommufd.h            | 41 ++++++++++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dfe9120aced0..54c7c9888de3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -381,6 +381,10 @@ struct iommufd_hwpt_paging {
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
+#ifdef CONFIG_LIVEUPDATE
+	bool lu_preserved : 1;
+	u32 lu_token;
+#endif
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct iommufd_sw_msi_maps present_sw_msi;
@@ -721,6 +725,10 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 #ifdef CONFIG_LIVEUPDATE
 int iommufd_liveupdate_register_lufs(void);
 int iommufd_liveupdate_unregister_lufs(void);
+
+
+int iommufd_hwpt_lu_set_preserved(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd);
 #else
 static inline int iommufd_liveupdate_register_lufs(void)
 {
@@ -731,6 +739,16 @@ static inline int iommufd_liveupdate_unregister_lufs(void)
 {
 	return 0;
 }
+
+static inline int iommufd_hwpt_lu_set_preserved(struct iommufd_ucmd *ucmd)
+{
+	return -ENOTTY;
+}
+
+static inline int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd)
+{
+	return -ENOTTY;
+}
 #endif
 
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index a9b5956c0dee..83d1b888d914 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -12,6 +12,47 @@
 
 #include "iommufd_private.h"
 
+int iommufd_hwpt_lu_set_preserved(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_lu_set_preserved *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_target, *hwpt;
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommufd_object *obj;
+	unsigned long index;
+	int rc = 0;
+
+	/* TODO: return error if iommufd is already preserved. */
+
+	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_target))
+		return PTR_ERR(hwpt_target);
+
+	xa_lock(&ictx->objects);
+	xa_for_each(&ictx->objects, index, obj) {
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
+
+		if (hwpt == hwpt_target)
+			continue;
+		if (!hwpt->lu_preserved)
+			continue;
+		if (hwpt->lu_token == cmd->hwpt_token) {
+			rc = -EADDRINUSE;
+			goto out;
+		}
+	}
+
+	hwpt_target->lu_preserved = cmd->preserved;
+	hwpt_target->lu_token = cmd->hwpt_token;
+
+out:
+	xa_unlock(&ictx->objects);
+	iommufd_put_object(ictx, &hwpt_target->common.obj);
+	return rc;
+}
+
 static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
 {
 	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
@@ -121,6 +162,11 @@ static bool iommufd_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 	return true;
 }
 
+int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd)
+{
+	return -ENOTTY;
+}
+
 static void iommufd_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
 	struct iommufd_lu *iommufd_lu;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 12601f9ad217..b63f61331cae 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -493,6 +493,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVED, iommufd_hwpt_lu_set_preserved,
+		struct iommu_hwpt_lu_set_preserved, preserved),
+	IOCTL_OP(IOMMU_HWPT_LU_RESTORE, iommufd_hwpt_lu_restore,
+		struct iommu_hwpt_lu_restore, hwpt_token),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2c41920b641d..4b953129f8d8 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,8 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_HWPT_LU_SET_PRESERVED = 0x95,
+	IOMMUFD_CMD_HWPT_LU_RESTORE = 0x96,
 };
 
 /**
@@ -1299,4 +1301,43 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * struct iommu_hwpt_lu_set_preserved - ioctl(IOMMU_HWPT_LU_SET_PRESERVED)
+ * @size: sizeof(struct iommu_hwpt_lu_set_preserved)
+ * @hwpt_id: Iommufd object ID of the target HWPT
+ * @hwpt_token: Token to identify this hwpt upon restore
+ * @preserved: If non-zero, HWPT is preserved by liveupdate
+ *
+ * If preserved set to non-zero, the target HWPT will be preserved.
+ *
+ * The hwpt_token is provided by userspace. If userspace enters a token
+ * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
+ */
+struct iommu_hwpt_lu_set_preserved {
+	__u32 size;
+	__u32 hwpt_id;
+	__u32 hwpt_token;
+	__u8 preserved;
+};
+#define IOMMU_HWPT_LU_SET_PRESERVED _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LU_SET_PRESERVED)
+
+/**
+ * struct iommu_hwpt_lu_restore - ioctl(IOMMU_HWPT_LU_RESTORE)
+ * @size: sizeof(struct iommu_hwpt_lu_restore)
+ * @pt_id: Output the ID of the recreated HWPT.
+ * @hwpt_token: Token to identify this hwpt
+ * @hwpt_alloc_flags: Combination of enum iommufd_hwpt_alloc_flags
+
+ * An immutable HWPT is restored without a parent IOAS, and the ID
+ * of this new HWPT is returned.
+ */
+
+struct iommu_hwpt_lu_restore {
+	__u32 size;
+	__u32 pt_id;
+	__u32 hwpt_token;
+	__u32 hwpt_alloc_flags;
+};
+#define IOMMU_HWPT_LU_RESTORE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LU_RESTORE)
 #endif
-- 
2.52.0.158.g65b55ccf14-goog

