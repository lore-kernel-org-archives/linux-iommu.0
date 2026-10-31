Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793411334;
	b=4Mh9k/Wh7Zwv6uJWNadB0XYYxykhcVBfe+88FkZFC5SnVbLkljUT1qOUFfKNfP260w89
	 FoK1bP2zzfyTGsNmXaM6Diu/voepzqxw/dG6KT7k0eV0TfgkirCnTuSf6dhsLPMrzotQO
	 6KLIWmwIcb9O88Il2vF2pbfz5rZHQrrkKu31BB00r8Aeylg4FRNV5f8mQ+bLZWWxODxVC
	 wGH8eD8HcdJAzsvwkfsh4E8OeBKENoKkzgyMHnAAasn0vnpCsPsZZnYqaMKX41w3Wq7P7
	 3vCkh8rXlVcgk7zOE5Ehj3o/kXTTsYiyYFTfNsYbYUpH7j8SyJ/PccsOrj8J9G0o1qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793411334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DDNUkdp/AZl9JhN6WFKJZe6JzjdwBOldOY8jhM6xHPs=;
	b=2h5TCDVb0NMCvVrCXP2sUkXkRkH7okf3NQiJ8YqPQUQeikV95yYCHlhqF44dnmj7qYwX
	 cR92gOk4BC3ZOLw+QsJnDX+T9XxdzAW0ZSPWVHpNRbUUYVogvZsq1V5tOM6m/r3VOeL7m
	 pImkuLLuxTTO4F/hiRk1ZtmErBN+TGeaqNBsEWShWCT5CD7hM0QWcJVfOjlzqI/aSipJP
	 9BICUf0gZ4zjbvw1rSQqkmci9UNt6oXOz3yH+PYjUUsLUHGgo2g/9FxBAK3+Bqwum/DpJ
	 WquZHQkgq29o71pCBZs24Ymj1h4LYXYoNpKL5fM1FJMF0LzixE4OZ2mXAMcm9WnvfBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YFLOWBkv;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE1606A31A
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 01:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAE1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YFLOWBkv
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so15945ad.1
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 18:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793411333; x=1794016133; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DDNUkdp/AZl9JhN6WFKJZe6JzjdwBOldOY8jhM6xHPs=;
        b=YFLOWBkvaVbHnSiSVfyK8aJ/R+xK4Fpa3ZVCCUg1NsdfPf5NLwWYBe9ik3km10IwnA
         kUOB8LOpdRoZ3Qdi5scXpjGIsnggNanguJJBvdQVjAyI3hFiRmZuSlAV/q3SXd4dZMUj
         AGt9LbRQOoj0UvaiGdG1xnq6aEdkcCzTqTp4sZOvtNbLJxasODZrBoioi4z/hZsLy8V9
         94T0+gl/6ohpYxWgtTK/Cl5mJjVtubOTDMj3JgMsRwHJnMYcwRMnx07BogqGX15BhID0
         R6D6gccKcguZRX3ts9j8gCCCN87raqmHzrW1r98d7QWqVWpP58O7hdI5ZHOYrBsNgwmG
         dskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793411333; x=1794016133;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDNUkdp/AZl9JhN6WFKJZe6JzjdwBOldOY8jhM6xHPs=;
        b=S8YGsqNDhnUQHr53zN52s2/UgdgoxUe02yjqn0Qj3XeD3qIMcapvWCsSIoPg0zJaXI
         wqpe4cHB01i/dkSWJGpFNRJFfQ1OAHw8ojwGCksjSq8GkM+k0E2yTBt3eJXU2tWCH0lT
         VsUGZ5WvDx2XCxraJ4UCxXNGc7W84loG8JnpR4bA+O6E+GSycJHuCegJl+5ytAxFXPGg
         u6uLSeHrqqicd8Y3FmbX7rTU6lk5EMxMSoG2zdbCOkFxdkWiYAPHQjQci+yHxMp/pbCL
         ht4EznznyAzLLn6QydrldU3xgYFrdf2QpW8LBdS0rwcdr6gSWNy7pRtn5tRqK2K8GYjs
         DXAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLwkMuMabrrvIhY0mCxIz7/+ddl4HCw1lyL1wHtBpqel5GbDhbXlgju0y8dGy2QMJ3E9cZqw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJXD3ckRquDedhbixT4RJGKUijQeJlEQQf2zz22GjpjKGmeMA5g
	1vKgvj48UrH4OnKE+cf+qiByjgTtqCS5UNm5xDbBlUyM+jG6Na55Sq+Fxs8mLzzfig==
X-Gm-Gg: AYBFou3wma87qFKEoyaomBTGDXw1JchWmRLZaqwYLaH838R/RfQrxCkC0UvhXBtbjMR
	Jmm6+PhC5GSX8QvidICzQG6y45K3M7hLdXcqkFfFgzLWl8JF+PvSOosIWnJ0l+0KMaTcEdpQhEH
	3QnXHiY1gs4NymhIaGh68hWdfcwUnyZrY7byyRUyTo0IRDngyIIRjKuHHlTz4SawPPKkieuwFRb
	zAk6o7s73sL32tt4SIKMCnlLEjladwFIVnOujJsHoyFCh2bhrlaIsHosFWU0jlThszMnmrOuL4/
	MeCaC1yzl7yvsv8cPQRuZo2DQLaUWMNsC7Or84W9cP3oP7rshmNGTau/3/3esMgzzYlZ8Zt1sD3
	YyJHqMIvKlTke19689dpp8gMx1k4fZ1xCF3SWO57ByNeN7rhoL2ihYNC0DuC0k4Ql9vr9EHdbv1
	cMdZBz8RoSoJxAb1zomBf69e3pHp8taluaVjhGAU0wjaLHGLxrklqyd2Om2IuPuo5sJ5DuR2ufs
	tG2J8hZ94dDa1gYy161PnaiPekgCqN2D1tWfJEs0ils4nS0Bi4me3Hyw0uKE1eeAh0rI17FwFbo
	WX9i/fQhCiNkEiOP5L2M8v3sR3QsUWHIsgJoGcBdWAtD2u0263pdUbg7YAmwIiMZcnFsaocql8L
	bEjyzmX1r720D0zhINKzADg==
X-Received: by 2002:a17:903:1a2b:b0:2ea:7180:3abf with SMTP id d9443c01a7336-2eb019a757fmr21235195ad.15.1793411332583;
        Fri, 30 Oct 2026 18:48:52 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada6c2c28sm444881b3a.43.2026.10.30.18.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:48:50 -0700 (PDT)
Date: Sat, 31 Oct 2026 01:48:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	YiFei Zhu <zhuyifei@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 14/18] iommufd: Implement ioctl to mark HWPT for
 preservation
Message-ID: <auVIrh3NVgcYEOIx@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-15-skhawaja@google.com>
 <887b7c7e-38b8-4798-84a5-bf96bc13ef04@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <887b7c7e-38b8-4798-84a5-bf96bc13ef04@linux.intel.com>

On Fri, Oct 30, 2026 at 03:20:02PM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>From: YiFei Zhu <zhuyifei@google.com>
>>
>>Userspace provides a token to mark the HWPT for preservation. Note that
>>this token is not the LUO token that is used to preserve the iommufd.
>>Once all the required HWPT are marked for preservation, the user can
>>preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
>>are marked for preservation.
>>
>>The marked HWPTs are tracked using a new XArray mark protected by a new
>>liveupdate mutex. This mutex will also be used during iommufd
>>preservation to protect against any race with the mark preserve ioctl.
>>
>>The HWPT token will be used during restore to identify this HWPT. The
>>restoration logic is not implemented and will be added later.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  MAINTAINERS                             |  1 +
>>  drivers/iommu/iommufd/Makefile          |  1 +
>>  drivers/iommu/iommufd/iommufd_private.h | 17 ++++++
>>  drivers/iommu/iommufd/liveupdate.c      | 72 +++++++++++++++++++++++++
>>  drivers/iommu/iommufd/main.c            |  9 ++++
>>  include/uapi/linux/iommufd.h            | 27 ++++++++++
>>  6 files changed, 127 insertions(+)
>>  create mode 100644 drivers/iommu/iommufd/liveupdate.c
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 15e1da41b0cc..78af4e3dc106 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -13738,6 +13738,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
>>  R:	Pranjal Shrivastava <praan@google.com>
>>  L:	iommu@lists.linux.dev
>>  S:	Maintained
>>+F:	drivers/iommu/iommufd/liveupdate.c
>>  F:	drivers/iommu/liveupdate.c
>>  F:	include/linux/iommu-liveupdate.h
>>  F:	include/linux/kho/abi/iommu.h
>>diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
>>index 67207914bb6e..cfd5b4b14ccb 100644
>>--- a/drivers/iommu/iommufd/Makefile
>>+++ b/drivers/iommu/iommufd/Makefile
>>@@ -12,6 +12,7 @@ iommufd-y := \
>>  iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
>>  iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>>+iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>>  obj-$(CONFIG_IOMMUFD) += iommufd.o
>>  obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
>>diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>>index eb2e85b27e42..a33b32708afa 100644
>>--- a/drivers/iommu/iommufd/iommufd_private.h
>>+++ b/drivers/iommu/iommufd/iommufd_private.h
>>@@ -44,6 +44,11 @@ struct iommufd_ctx {
>>  	struct file *file;
>>  	struct xarray objects;
>>  	struct xarray groups;
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+#define IOMMUFD_OBJ_LIVEUPDATE_MARK XA_MARK_1
>>+	/* @liveupdate_mutex: Protects the preservation of HWPTs. */
>>+	struct mutex liveupdate_mutex;
>>+#endif
>>  	wait_queue_head_t destroy_wait;
>>  	struct rw_semaphore ioas_creation_lock;
>>  	struct maple_tree mt_mmap;
>>@@ -392,6 +397,9 @@ struct iommufd_hwpt_paging {
>>  	bool auto_domain : 1;
>>  	bool enforce_cache_coherency : 1;
>>  	bool nest_parent : 1;
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	u64 liveupdate_token;
>>+#endif
>>  	/* Head at iommufd_ioas::hwpt_list */
>>  	struct list_head hwpt_item;
>>  	struct iommufd_sw_msi_maps present_sw_msi;
>>@@ -729,6 +737,15 @@ void iommufd_vdevice_abort(struct iommufd_object *obj);
>>  int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
>>  void iommufd_hw_queue_destroy(struct iommufd_object *obj);
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd);
>>+#else
>>+static inline int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>>+{
>>+	return -ENOTTY;
>>+}
>>+#endif
>>+
>>  #ifdef CONFIG_IOMMUFD_TEST
>>  int iommufd_test(struct iommufd_ucmd *ucmd);
>>  void iommufd_selftest_destroy(struct iommufd_object *obj);
>>diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>>new file mode 100644
>>index 000000000000..5fb491ff3a3d
>>--- /dev/null
>>+++ b/drivers/iommu/iommufd/liveupdate.c
>>@@ -0,0 +1,72 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+
>>+/*
>>+ * Copyright (C) 2026, Google LLC
>>+ * Author: Samiullah Khawaja <skhawaja@google.com>
>>+ */
>>+
>>+#define pr_fmt(fmt) "iommufd: " fmt
>>+
>>+#include <linux/file.h>
>>+#include <linux/iommufd.h>
>>+#include <linux/liveupdate.h>
>>+
>>+#include "iommufd_private.h"
>>+
>>+int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>>+{
>>+	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
>>+	struct iommufd_ctx *ictx = ucmd->ictx;
>>+	struct iommufd_hwpt_paging *hwpt;
>>+	struct iommufd_object *obj;
>>+	unsigned long index;
>>+	bool marked = false;
>>+	int rc = 0;
>>+
>>+	hwpt = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
>>+	if (IS_ERR(hwpt))
>>+		return PTR_ERR(hwpt);
>>+
>>+	mutex_lock(&ictx->liveupdate_mutex);
>>+
>>+	xa_lock(&ictx->objects);
>>+
>>+	/* PRI use cases are not supported. */
>>+	if (hwpt->common.fault) {
>>+		rc = -EOPNOTSUPP;
>>+		goto out_unlock;
>>+	}
>>+
>>+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>>+		struct iommufd_hwpt_paging *hwpt_marked;
>>+
>>+		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
>>+			continue;
>>+
>>+		hwpt_marked = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>>+
>>+		if (hwpt_marked == hwpt)
>>+			marked = true;
>>+
>>+		if (hwpt_marked->liveupdate_token == cmd->hwpt_token) {
>>+			if (hwpt_marked == hwpt)
>>+				goto out_unlock;
>>+
>>+			rc = -EADDRINUSE;
>>+			goto out_unlock;
>>+		}
>>+	}
>>+
>>+	__xa_set_mark(&ictx->objects, hwpt->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
>>+
>>+	if (marked)
>>+		pr_warn_ratelimited("Overwriting HWPT liveupdate token from: %llu to %llu\n",
>>+				    hwpt->liveupdate_token, cmd->hwpt_token);
>>+	hwpt->liveupdate_token = cmd->hwpt_token;
>>+
>>+out_unlock:
>>+	xa_unlock(&ictx->objects);
>>+	mutex_unlock(&ictx->liveupdate_mutex);
>>+	iommufd_put_object(ictx, &hwpt->common.obj);
>>+	return rc;
>>+}
>>diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
>>index 9a921b153162..fe8610fd58e3 100644
>>--- a/drivers/iommu/iommufd/main.c
>>+++ b/drivers/iommu/iommufd/main.c
>>@@ -333,6 +333,9 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
>>  	init_rwsem(&ictx->ioas_creation_lock);
>>  	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
>>  	xa_init(&ictx->groups);
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	mutex_init(&ictx->liveupdate_mutex);
>>+#endif
>>  	ictx->file = filp;
>>  	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
>>  	init_waitqueue_head(&ictx->destroy_wait);
>>@@ -395,6 +398,9 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>>  	 * iommufd_object_tombstone_user()
>>  	 */
>>  	xa_destroy(&ictx->objects);
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	mutex_destroy(&ictx->liveupdate_mutex);
>>+#endif
>>  	WARN_ON(!xa_empty(&ictx->groups));
>>@@ -440,6 +446,7 @@ union ucmd_buffer {
>>  	struct iommu_hwpt_alloc hwpt;
>>  	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>>  	struct iommu_hwpt_invalidate cache;
>>+	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve;
>>  	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
>>  	struct iommu_ioas_alloc alloc;
>>  	struct iommu_ioas_allow_iovas allow_iovas;
>>@@ -516,6 +523,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>>  		 __reserved),
>>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>>  		 struct iommu_viommu_alloc, out_viommu_id),
>>+	IOCTL_OP(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, iommufd_hwpt_liveupdate_mark_preserve,
>>+		 struct iommu_hwpt_liveupdate_mark_preserve, hwpt_token),
>>  #ifdef CONFIG_IOMMUFD_TEST
>>  	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>>  #endif
>>diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>>index 206fa667c782..93372689afec 100644
>>--- a/include/uapi/linux/iommufd.h
>>+++ b/include/uapi/linux/iommufd.h
>>@@ -58,6 +58,7 @@ enum {
>>  	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>>  	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
>>  	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
>>+	IOMMUFD_CMD_HWPT_LIVEUPDATE_MARK_PRESERVE = 0x96,
>>  };
>>  /**
>>@@ -1390,4 +1391,30 @@ struct iommu_hw_queue_alloc {
>>  	__aligned_u64 length;
>>  };
>>  #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
>>+
>>+/**
>>+ * struct iommu_hwpt_liveupdate_mark_preserve - ioctl(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE)
>>+ * @size: sizeof(struct iommu_hwpt_liveupdate_mark_preserve)
>>+ * @hwpt_id: HW pagetable ID to preserve for liveupdate
>>+ * @hwpt_token: Token to identify this hwpt upon restore
>>+ *
>>+ * The target HWPT will be preserved during iommufd preservation.
>>+ * Only file-based memory mappings (e.g. memfd) are supported for HWPTs marked
>>+ * for preservation. Mapping anonymous memory into a preserved HWPT will result
>>+ * in a failure during the preservation phase.
>>+ *
>>+ * The hwpt_token is provided by userspace. If userspace enters a token
>>+ * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
>>+ *
>>+ * Note: There is no 'unmark' operation, so any HWPTs pooled in userspace that
>>+ * are marked for preservation must be destroyed after use.
>>+ */
>>+struct iommu_hwpt_liveupdate_mark_preserve {
>>+	__u32 size;
>
>Most iommufd commands have a "flags" member here, so that the uAPI
>struct can be extended later. Why is this one different?

Agreed. I will update this.
>
>>+	__u32 hwpt_id;
>>+	__aligned_u64 hwpt_token;
>>+};
>>+#define IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE \
>>+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LIVEUPDATE_MARK_PRESERVE)
>>+
>>  #endif
>
>Otherwise, this patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
