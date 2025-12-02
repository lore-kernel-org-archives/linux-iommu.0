Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC02C0F6F
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716590; cv=none; b=MlxvauIBnlxapmCQNyUWoXUCMtYv5pR2Zx6pid+YE7jHtGgf5j2MzXPA+FaZWnv4SpB16O9Apg+lOtg5GRSU/vZgYn+txh2+catktdPJ/z50pNb7+QREV9IwaoLicJUFGgwUJVE1U4JS5HqHR5RD9C4/61UDewKd59moipiScDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716590; c=relaxed/simple;
	bh=0fxXWpcTi40PtPWPrvxIElA/HVJyWzHgXtAh/9+B2ok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tG3fjrGBk9JOcPov09qOQoXReC7WpMUccOPy/DPJS/w6xQ+0TnZDLzLUNbp1oQEG901LjmXXtPUX2IVHZ/UEvH0rzT5AblbhPpD3hr/pRX6bFfgJo51wAgdJBrE9CGZu+80BEsJZCBoHW8cZvvHk72FWIiuBtVU7gwHIO8BS1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDa6hQLw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDa6hQLw"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343daf0f38aso6236067a91.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716588; x=1765321388; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOyS1+oE/MZnMqUYcDqZHpivnjj1VqEXH4ijUgP4GxM=;
        b=IDa6hQLwrHuENJa2RF+KvH3xtX7C76zdX/xFLFkmXt7jBM8MYMCKXBz6K5Zdv9G8uR
         SKcjefARywSTe/Tg46viaQbFFtQR+UDwJK49P4xgKMpu0/I5GxJ1zLCIi+GXQxDcG5bI
         4QKt15I8bB/0EwAqlqSj7zgLmFOHTirqMRFB0twi0yBDYNr1HFCkLSHyOD6z3GEeMaTG
         hDns7j7t8hdds8pb/w+QZJoyIA1/8yhWHtLO2TYUcabO9oq6M3X/y8i1G6T3vQd86FER
         5HPK/+FZoxoGmJqF+wlTbBVABHyO6wMrrmmg3medqTSxlTUaUOOek133auHZ11XRP8Bu
         NIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716588; x=1765321388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOyS1+oE/MZnMqUYcDqZHpivnjj1VqEXH4ijUgP4GxM=;
        b=UBEXAvnsB0SxSIPv3uOF/hTQV0EE9y/ncRsMyo5dRGA8G4nXk53vDCpPfbIo644pZg
         CwQd11ftPZOMeJexawyX3YYeXrz8DAE4g8AObmEygv+RSehSw1HRBp/ARVjjgPO8Qw+c
         fz2T9h3wc0QU95rarSKkLJ+Y/PbndKc9owUBMsewNJTo9zeIF8Us6fPuOog02f/Lbcz6
         PFbNgWEIAYDPXV0InM4MZztqzTXA1GsUVrlX+a+Vibi7Yngmi9S+gTtPwSCjOe3A0XOA
         vsauHB0xMH2LI0L5v89z1H5XOVOWz0+cmwsdiyfVEt44hFAYy/7rEXEcI3s3OdHhgtal
         XWyg==
X-Forwarded-Encrypted: i=1; AJvYcCWNUoMc8XX/FAWFzu/KWvHpC4+iZY8RdN8Xo77Pb6YEAmHLoQMs15pZp3T7opTzXg2hCRxtRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFGf+CkoJalY5b9YEzEr01ZrB8zId2EmenQ9lZCmP8HagbLN0L
	czCpEKtVvYOAcemUqA6vQP3jVWYTzrpB3FxB0V9kbxya99Vp/OyCt7MlIVC3OoFhvHo+itY/f7I
	zmIvhDuXlt5NJPQ==
X-Google-Smtp-Source: AGHT+IHGoMvFSNvSZtwMI7okBiN+CBcfRAk016csbZkp2Vku+dbv1pl50jnpk9FRa05GjdU15tbIjV0aFJnMaQ==
X-Received: from pjsd11.prod.google.com ([2002:a17:90a:bf8b:b0:340:e523:10dd])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5745:b0:340:b572:3b7f with SMTP id 98e67ed59e1d1-349127441e8mr331295a91.20.1764716588128;
 Tue, 02 Dec 2025 15:03:08 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:32 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-3-skhawaja@google.com>
Subject: [RFC PATCH v2 02/32] iommufd: split alloc and domain assign from iommufd_hwpt_paging_alloc
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

To avoid code duplication, these code are split off into smaller
functions that may also be called by liveupdate.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 74 +++++++++++++++----------
 drivers/iommu/iommufd/iommufd_private.h |  4 ++
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 78d2130e0061..a528f84ad429 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -90,6 +90,29 @@ iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
 	return 0;
 }
 
+struct iommufd_hwpt_paging *
+_iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx)
+{
+	struct iommufd_hwpt_paging *hwpt_paging;
+
+	hwpt_paging = __iommufd_object_alloc(
+		ictx, hwpt_paging, IOMMUFD_OBJ_HWPT_PAGING, common.obj);
+	if (IS_ERR(hwpt_paging))
+		return ERR_CAST(hwpt_paging);
+
+	INIT_LIST_HEAD(&hwpt_paging->hwpt_item);
+
+	return hwpt_paging;
+}
+
+void iommufd_hwpt_init_from_domain(struct iommufd_hw_pagetable *hwpt,
+				   struct iommu_domain *domain)
+{
+	hwpt->domain = domain;
+	domain->iommufd_hwpt = hwpt;
+	domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
+}
+
 /**
  * iommufd_hwpt_paging_alloc() - Get a PAGING iommu_domain for a device
  * @ictx: iommufd context
@@ -122,6 +145,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
+	struct iommu_domain *domain;
 	int rc;
 
 	lockdep_assert_held(&ioas->mutex);
@@ -137,38 +161,34 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	    (flags & IOMMU_HWPT_ALLOC_NEST_PARENT))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	hwpt_paging = __iommufd_object_alloc(
-		ictx, hwpt_paging, IOMMUFD_OBJ_HWPT_PAGING, common.obj);
+	hwpt_paging = _iommufd_hwpt_paging_alloc(ictx);
 	if (IS_ERR(hwpt_paging))
 		return ERR_CAST(hwpt_paging);
+
 	hwpt = &hwpt_paging->common;
 	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
-	INIT_LIST_HEAD(&hwpt_paging->hwpt_item);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt_paging->ioas = ioas;
 	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if (ops->domain_alloc_paging_flags) {
-		hwpt->domain = ops->domain_alloc_paging_flags(idev->dev,
+		domain = ops->domain_alloc_paging_flags(idev->dev,
 				flags & ~IOMMU_HWPT_FAULT_ID_VALID, user_data);
-		if (IS_ERR(hwpt->domain)) {
-			rc = PTR_ERR(hwpt->domain);
-			hwpt->domain = NULL;
+		if (IS_ERR(domain)) {
+			rc = PTR_ERR(domain);
 			goto out_abort;
 		}
-		hwpt->domain->owner = ops;
+		domain->owner = ops;
 	} else {
-		hwpt->domain = iommu_paging_domain_alloc(idev->dev);
-		if (IS_ERR(hwpt->domain)) {
-			rc = PTR_ERR(hwpt->domain);
-			hwpt->domain = NULL;
+		domain = iommu_paging_domain_alloc(idev->dev);
+		if (IS_ERR(domain)) {
+			rc = PTR_ERR(domain);
 			goto out_abort;
 		}
 	}
-	hwpt->domain->iommufd_hwpt = hwpt;
-	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
+	iommufd_hwpt_init_from_domain(hwpt, domain);
 
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
@@ -237,6 +257,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_nested *hwpt_nested;
 	struct iommufd_hw_pagetable *hwpt;
+	struct iommu_domain *domain;
 	int rc;
 
 	if ((flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID)) ||
@@ -256,17 +277,15 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
 
-	hwpt->domain = ops->domain_alloc_nested(
+	domain = ops->domain_alloc_nested(
 		idev->dev, parent->common.domain,
 		flags & ~IOMMU_HWPT_FAULT_ID_VALID, user_data);
-	if (IS_ERR(hwpt->domain)) {
-		rc = PTR_ERR(hwpt->domain);
-		hwpt->domain = NULL;
+	if (IS_ERR(domain)) {
+		rc = PTR_ERR(domain);
 		goto out_abort;
 	}
-	hwpt->domain->owner = ops;
-	hwpt->domain->iommufd_hwpt = hwpt;
-	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
+	iommufd_hwpt_init_from_domain(hwpt, domain);
+	domain->owner = ops;
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EOPNOTSUPP;
@@ -294,6 +313,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 {
 	struct iommufd_hwpt_nested *hwpt_nested;
 	struct iommufd_hw_pagetable *hwpt;
+	struct iommu_domain *domain;
 	int rc;
 
 	if (flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID))
@@ -314,16 +334,14 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	refcount_inc(&viommu->obj.users);
 	hwpt_nested->parent = viommu->hwpt;
 
-	hwpt->domain = viommu->ops->alloc_domain_nested(
+	domain = viommu->ops->alloc_domain_nested(
 		viommu, flags & ~IOMMU_HWPT_FAULT_ID_VALID, user_data);
-	if (IS_ERR(hwpt->domain)) {
-		rc = PTR_ERR(hwpt->domain);
-		hwpt->domain = NULL;
+	if (IS_ERR(domain)) {
+		rc = PTR_ERR(domain);
 		goto out_abort;
 	}
-	hwpt->domain->iommufd_hwpt = hwpt;
-	hwpt->domain->owner = viommu->iommu_dev->ops;
-	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
+	iommufd_hwpt_init_from_domain(hwpt, domain);
+	domain->owner = viommu->iommu_dev->ops;
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EOPNOTSUPP;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb6d1a70f673..e43da269ab80 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -434,6 +434,10 @@ iommufd_get_hwpt_nested(struct iommufd_ucmd *ucmd, u32 id)
 int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd);
 int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd);
 
+struct iommufd_hwpt_paging *
+_iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx);
+void iommufd_hwpt_init_from_domain(struct iommufd_hw_pagetable *hwpt,
+				   struct iommu_domain *domain);
 struct iommufd_hwpt_paging *
 iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  struct iommufd_device *idev, ioasid_t pasid,
-- 
2.52.0.158.g65b55ccf14-goog

