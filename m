Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A93C2787
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859101; cv=none; b=lSdxlfA76pR3SM5gfAjNF47pSQJzeEM2btMyaiEDqafE1Nxy5zSWSH2zJJiVIALSCqe/dPo5pFJF9wl0upP8bkFAsco71DNWrqYmKecsSLx0hq6IMeMmADIA3TYCzPakcBLv4A9EiT+BNhucp8zTqC2HYbDdijntVYhqXkdHVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859101; c=relaxed/simple;
	bh=VsfLWzMovyZCgletBysKiuXwwrZ7tuwPcgVNb65DUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ6nXJakqNBnIl5TSN4rMstg3w9uzLmd8DBxVig+5OkKebjxY47jsM1UNg/ZNdotvYHsPS1cb5l0F/6KvP51pnbKVjZHXJxl5PPEoCeQsEES/VMRYM1nfWKBeGswHmb5HJqrlhLTb3o7z48AgxTBlW9vPG3E6aCdb20M9pLkUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTc/VZzb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTc/VZzb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so12755ad.0
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773859100; x=1774463900; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QTHQfoxLvn1BLnz0AIe35mhrO0lse0831KEHlkXxEE=;
        b=HTc/VZzb+yhdNejYoKpIoQLJL/xsxLBxdmuNU7QKoKgMogMUoESgynxE3+aPmF1pB2
         7t8/R3g1hq1X9pyIxxecLMSQacOVwurisiaqJov/awLiM9OBCRJefiA6JGAhui/baDlb
         i4mSUqjDRBzvT6sbb4wXNlj5zn7NRr2cKIgIwjVnN8upT09c5DHvpPb0aRzCkuPGQnKI
         hnElX7hh2ErQJ+KoGpETRA0ne6EMkUK36Hj5gf2VHyr4yStHi1c6UyW+byaFWiU7ymvk
         /SRfFfDE5QXlkEtz5ucjg8YH3fWKWFvuwMXj55J2vJo+wJqtpqETUgVPCab0nxGCsPwY
         lFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773859100; x=1774463900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QTHQfoxLvn1BLnz0AIe35mhrO0lse0831KEHlkXxEE=;
        b=A57Us3d4XtugkpwYPXwuQZ02rqDACyECZjEdID+LoiGfnaTgEeg2vriUTkaqHltIl5
         qImWx3x5BOmQZSC5M3sD1mJE24pLM4XT+c6mjHLI1rd/nY6fSk4U6Cir2QA/1mLT+gwn
         Fc6TWu3XIU6KAZLa9Y2ZZk+dTGm7gieurV7I4F662JAkq4lxEGWir/jPXaj7VviUzEc6
         /HpnGj43YXbd10Mm/3OpVixzbuK3UneoF/9ap3wAylNkPO5+orU9Vm9bHUO4i5D8RPDi
         5Zd7PQCNQU/NnTePdwZuulBX4OaH9CI874QZUzWBWpWjY3scigjGrtbLnuEHCMX8YK5f
         aLCg==
X-Forwarded-Encrypted: i=1; AJvYcCUBm4ByI5csyP60Hf/D5FuS0HLkSYYGfVFUiIYWwBYkd1M4Pr6Q9vcuTJHJDhz18t/OtKY6yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQZI5KvCUl3QNzpBYijGmKQewcXpHwHsTwYckU58g404VGIEFw
	eKwnqtTnN7KfhyGP2PC2h/9fN7mtpqVogrmD/tzwiVxkH2XO1XgjTu4OslIsVO/P6Q==
X-Gm-Gg: ATEYQzwwAliuketicec3HNy0yUc5rGl8xLnK9vClLLdh3NVjyMMnq+UesQpkXcttH9m
	Xcp/g7M8E3j62N+tCb8X5CjhX3Z9Ky6b5tK5JPoLXggE6NiQwwyUSGf+auP2V3192RUx3zpWfrS
	c1Vx14vYsixAeJiYct+v7KA/uTEHKYxEJNJbzgT9NOa46xiT02yqcyojdSzljfY955CBEE1YiqM
	xw/Gc1h8sFbLxrJNt4OQh23UvWQ7Z4xeyCfy+3N1LVMuOjNzXE5gW82Gr4r4XD/aSAGvkp6wzSD
	M+x6rE/YEw+DcdyKK5sQG75e/0aZhFzdoiuybp2j0AT/vbVfpFsqHYjpwKzo8k8ue2veY/HuyO1
	K0hLkygCHxmGGXao1a3SE06zMsjzmzsnxTxeMPxdXzHP7RjSqOMqTRq9eksSrARht/g0vB8PY2/
	1yebyJfuf1i6Ie2NnN3sS8d6SCccLLh5yF5NpiiA2aNKGbxSu6U4sMFZXvwxM1neGwI5gf9yTM
X-Received: by 2002:a17:902:d2c4:b0:2b0:5ba3:2416 with SMTP id d9443c01a7336-2b077f15a5cmr403475ad.7.1773859099312;
        Wed, 18 Mar 2026 11:38:19 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb2802sm3435136b3a.31.2026.03.18.11.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:38:18 -0700 (PDT)
Date: Wed, 18 Mar 2026 18:38:14 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Yi Liu <yi.l.liu@intel.com>, pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>, 
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 01/11] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <abrvYSZ425p6a17D@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-2-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-2-jacob.pan@linux.microsoft.com>

On Thu, Mar 12, 2026 at 08:56:27AM -0700, Jacob Pan wrote:
>From: Jason Gunthorpe <jgg@nvidia.com>
>
>Create just a little part of a real iommu driver, enough to
>slot in under the dev_iommu_ops() and allow iommufd to call
>domain_alloc_paging_flags() and fail everything else.
>
>This allows explicitly creating a HWPT under an IOAS.
>
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>---
> drivers/iommu/iommufd/Makefile          |  1 +
> drivers/iommu/iommufd/hw_pagetable.c    | 11 ++-
> drivers/iommu/iommufd/hwpt_noiommu.c    | 91 +++++++++++++++++++++++++
> drivers/iommu/iommufd/iommufd_private.h |  2 +
> 4 files changed, 103 insertions(+), 2 deletions(-)
> create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
>
>diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
>index 71d692c9a8f4..2b1a020b14a6 100644
>--- a/drivers/iommu/iommufd/Makefile
>+++ b/drivers/iommu/iommufd/Makefile
>@@ -10,6 +10,7 @@ iommufd-y := \
> 	vfio_compat.o \
> 	viommu.o
>
>+iommufd-$(CONFIG_VFIO_NOIOMMU) += hwpt_noiommu.o
> iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>
> obj-$(CONFIG_IOMMUFD) += iommufd.o
>diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
>index fe789c2dc0c9..37316d77277d 100644
>--- a/drivers/iommu/iommufd/hw_pagetable.c
>+++ b/drivers/iommu/iommufd/hw_pagetable.c
>@@ -8,6 +8,13 @@
> #include "../iommu-priv.h"
> #include "iommufd_private.h"
>
>+static const struct iommu_ops *get_iommu_ops(struct iommufd_device *idev)
>+{
>+	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) && !idev->igroup->group)
>+		return &iommufd_noiommu_ops;
>+	return dev_iommu_ops(idev->dev);
>+}
>+
> static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
> {
> 	if (hwpt->domain)
>@@ -114,7 +121,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> 				IOMMU_HWPT_FAULT_ID_VALID |
> 				IOMMU_HWPT_ALLOC_PASID;
>-	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
>+	const struct iommu_ops *ops = get_iommu_ops(idev);
> 	struct iommufd_hwpt_paging *hwpt_paging;
> 	struct iommufd_hw_pagetable *hwpt;
> 	int rc;
>@@ -229,7 +236,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
> 			  struct iommufd_device *idev, u32 flags,
> 			  const struct iommu_user_data *user_data)
> {
>-	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
>+	const struct iommu_ops *ops = get_iommu_ops(idev);
> 	struct iommufd_hwpt_nested *hwpt_nested;
> 	struct iommufd_hw_pagetable *hwpt;
> 	int rc;
>diff --git a/drivers/iommu/iommufd/hwpt_noiommu.c b/drivers/iommu/iommufd/hwpt_noiommu.c
>new file mode 100644
>index 000000000000..0aa99f581ca3
>--- /dev/null
>+++ b/drivers/iommu/iommufd/hwpt_noiommu.c
>@@ -0,0 +1,91 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
>+ */
>+#include <linux/iommu.h>
>+#include <linux/generic_pt/iommu.h>
>+#include "iommufd_private.h"
>+
>+static const struct iommu_domain_ops noiommu_amdv1_ops;
>+
>+struct noiommu_domain {
>+	union {
>+		struct iommu_domain domain;
>+		struct pt_iommu_amdv1 amdv1;
>+	};
>+	spinlock_t lock;
>+};
>+PT_IOMMU_CHECK_DOMAIN(struct noiommu_domain, amdv1.iommu, domain);
>+
>+static void noiommu_change_top(struct pt_iommu *iommu_table,
>+			       phys_addr_t top_paddr, unsigned int top_level)
>+{
>+}
>+
>+static spinlock_t *noiommu_get_top_lock(struct pt_iommu *iommupt)
>+{
>+	struct noiommu_domain *domain =
>+		container_of(iommupt, struct noiommu_domain, amdv1.iommu);
>+
>+	return &domain->lock;
>+}
>+
>+static const struct pt_iommu_driver_ops noiommu_driver_ops = {
>+	.get_top_lock = noiommu_get_top_lock,
>+	.change_top = noiommu_change_top,
>+};
>+
>+static struct iommu_domain *
>+noiommu_alloc_paging_flags(struct device *dev, u32 flags,
>+			   const struct iommu_user_data *user_data)
>+{
>+	struct pt_iommu_amdv1_cfg cfg = {};
>+	struct noiommu_domain *dom;
>+	int rc;
>+
>+	if (flags || user_data)
>+		return ERR_PTR(-EOPNOTSUPP);
>+
>+	cfg.common.hw_max_vasz_lg2 = 64;
>+	cfg.common.hw_max_oasz_lg2 = 52;
>+	cfg.starting_level = 2;
>+	cfg.common.features =
>+		(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
>+		 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE));
>+
>+	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
>+	if (!dom)
>+		return ERR_PTR(-ENOMEM);
>+
>+	spin_lock_init(&dom->lock);
>+	dom->amdv1.iommu.nid = NUMA_NO_NODE;
>+	dom->amdv1.iommu.driver_ops = &noiommu_driver_ops;
>+	dom->domain.ops = &noiommu_amdv1_ops;
>+
>+	/* Use mock page table which is based on AMDV1 */
>+	rc = pt_iommu_amdv1_init(&dom->amdv1, &cfg, GFP_KERNEL);
>+	if (rc) {
>+		kfree(dom);
>+		return ERR_PTR(rc);
>+	}
>+
>+	return &dom->domain;
>+}
>+
>+static void noiommu_domain_free(struct iommu_domain *iommu_domain)
>+{
>+	struct noiommu_domain *domain =
>+		container_of(iommu_domain, struct noiommu_domain, domain);
>+
>+	pt_iommu_deinit(&domain->amdv1.iommu);
>+	kfree(domain);
>+}
>+
>+static const struct iommu_domain_ops noiommu_amdv1_ops = {
>+	IOMMU_PT_DOMAIN_OPS(amdv1),

I understand that this fits in really well into the iommufd/hwpt
construction, but do we need page tables for this as all the
iova-to-phys information should be available in the IOPT in IOAS? As the
get_pa() function introduced in the later patch is only used for noiommu
use-cases, it can use the IOPT to get the physical addresses?
>+	.free = noiommu_domain_free,
>+};
>+
>+struct iommu_ops iommufd_noiommu_ops = {
>+	.domain_alloc_paging_flags = noiommu_alloc_paging_flags,
>+};
>diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>index 6ac1965199e9..9c18c5eb1899 100644
>--- a/drivers/iommu/iommufd/iommufd_private.h
>+++ b/drivers/iommu/iommufd/iommufd_private.h
>@@ -464,6 +464,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
> 	refcount_dec(&hwpt->obj.users);
> }
>
>+extern struct iommu_ops iommufd_noiommu_ops;
>+
> struct iommufd_attach;
>
> struct iommufd_group {
>-- 
>2.34.1
>
