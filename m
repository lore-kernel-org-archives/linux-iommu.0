Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E813019D9
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716608; cv=none; b=YJPN4xYBp791n7pMZA/lWxLYosBUe4zZ4sZI9DUyvkBF88baBuTlBgkGsTpKHSqKz8ZbRgO4I0ggCVYqn5EbG4ayfhgx1cCzkTxHsSjuYQOPnKWvh5kR0pP/EHyeveCiJ73v55sboessjRUaQwBdGSBEmM1CCyfsgeyo8RsJFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716608; c=relaxed/simple;
	bh=5EO4h0IYIljW6ybeUHco/uMBEgrKfuEgFW6VwP6trU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dbgKDr3QSITjjX7Ed/vIGsxjjXHwCz8T1zMcQD/7NDMsxgOY+KqhGv21ioaTNuxOnAlb2QwtAr8M0kld1M/H4vtDxvIcCTAKv/D2p/jM+83LeGjiMXoDQfDFFicCbBos1gV2VxyxksC+tZZrTPHhV2649jljUL6HzgId4r8Lghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exNVXGA3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exNVXGA3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29846a9efa5so111382335ad.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716606; x=1765321406; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F231xQfOrNMI7yp4iMcUXD0NMzWVqJGC997u+Z4FZI0=;
        b=exNVXGA3cjI0m8+cRgfIqqaarhseV3dwcAJDHzp0bjnokD05vRJUXAyIwbzBgLNG/t
         rPlgXW3z9LU+c3y3mZ2mNdntdw7NqOPSuuCIkHx3fCJepwFabYezLUMzI/mCEagKcS1o
         jRy1Z6eOEDOsi7GJFe90WY2K01pP6tooH7pRaENDtKSp5HD/erRCjQThnCW2Sdi93z0A
         IDD9ztFaaYt4dXmFNj/fZiyrS6ag0n3SRTkb2JqnGOfHK2LDS7jGIYRPaJqYOHeZoP/n
         4HezXJQR9u0h5BZlUU/SeK+Cdm1OZzfTUoL6w7LJ5xm0t/d0ehIy+lRECF8QdyM7QVZW
         ubeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716606; x=1765321406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F231xQfOrNMI7yp4iMcUXD0NMzWVqJGC997u+Z4FZI0=;
        b=JWnpiKEUtd1NoSKsGSLHr6zFj69Y1oAU5sE6xbymyxfvm/n/iwEuCZzcelmgm8BGNF
         4rm/F9Ypj4z2bx6p8TRP/mY5H4FO828FPx5VH0VIOpk/bdwEAM2skOFKtuOuTRJNfhzB
         v18dOnMhw3bLLegP4alwdMtbuox4UVnaNMH5C/14uYCbOxqEPEJG+h/PXh2O5gFUUuP/
         yrqXvNV9rgPb24OjTcYktxP2PcZqB78getsPD4BC5kSUHVZPjKC7y+z+85GW3y0Z8I8j
         s7272qW4ZLfY79hCzAWQONWUptrkQJv0mDe8idXC51Pi9z8p7JX8ZYjQkwJ8Nh42EAPV
         5uoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5OjW4BeZWNn2H09BSm0bDT8/DD2MvsGZ7yA1eTvHrcvYnTyaejTlxb7dFQkmxgri+ng3gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS+t8H9CSLr4nr8O499c7s5O+6iPss636pXfgtIVJxGFnmfxLU
	W6tepPswpACry5nQ1WAC4HCG05hSjGwsuCuNikbV4Gh9aVQopPwb53Bmq/NWeaBiAmA0Y0+5uum
	ntTEFbTKyGGrrGA==
X-Google-Smtp-Source: AGHT+IGUqs3cxHowTWSyeAdbJPGHuWbTlSkfFr0dgRLiy4bDIBar36BxyW52CazeICFSdn7wFC5FQWW+Axy82w==
X-Received: from plmn10.prod.google.com ([2002:a17:903:188a:b0:297:ec3d:d08b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:234d:b0:295:9b3a:16b7 with SMTP id d9443c01a7336-29d6833a7efmr2477995ad.4.1764716606410;
 Tue, 02 Dec 2025 15:03:26 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:44 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-15-skhawaja@google.com>
Subject: [RFC PATCH v2 14/32] iommufd: Use the iommu_domain_preserve/unpreserve
 APIs
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Remove the stub implementation of iommufd_domain_preserve and unpreserve
APIs and use the APIs exported by the IOMMU core.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 --
 drivers/iommu/iommufd/liveupdate.c      | 19 ++++++++++++-------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 15afff6ba0ea..0d358e5486d0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -730,8 +730,6 @@ int iommufd_hwpt_lu_set_preserved(struct iommufd_ucmd *ucmd);
 int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd);
 
 /* TODO */
-#define iommu_domain_restore(x) ERR_PTR(-EOPNOTSUPP)
-#define iommu_domain_preserve(x, y) (-EOPNOTSUPP)
 #define iommu_domain_has_attachments(x) (false)
 #else
 static inline int iommufd_liveupdate_register_lufs(void)
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 782585aff44a..5b45071d7dd2 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -59,6 +59,7 @@ static int iommufd_save_hwpts(struct iommufd_ctx *ictx,
 			      struct iommufd_lu *iommufd_lu)
 {
 	struct iommufd_hwpt_paging *hwpt, **hwpts = NULL;
+	struct iommu_domain_ser *domain_ser;
 	struct iommufd_hwpt_lu *hwpt_lu;
 	struct iommufd_object *obj;
 	unsigned int nr_hwpts = 0;
@@ -119,8 +120,11 @@ static int iommufd_save_hwpts(struct iommufd_ctx *ictx,
 			hwpt = hwpts[i];
 			hwpt_lu = &iommufd_lu->hwpts[i];
 
-			rc = iommu_domain_preserve(hwpt->common.domain, &hwpt_lu->domain_data);
-			goto out;
+			rc = iommu_domain_preserve(hwpt->common.domain, &domain_ser);
+			if (rc < 0)
+				goto out;
+
+			hwpt_lu->domain_data = __pa(domain_ser);
 		}
 	}
 
@@ -201,7 +205,7 @@ static void iommufd_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 		if (!hwpt->common.domain)
 			continue;
 
-		/* TODO: WARN_ON(iommu_domain_unpreserve(hwpt->common.domain)); */
+		WARN_ON(iommu_domain_unpreserve(hwpt->common.domain));
 	}
 	xa_unlock(&ictx->objects);
 
@@ -276,6 +280,7 @@ int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd)
 	struct iommu_hwpt_lu_restore *cmd = ucmd->cmd;
 	struct iommufd_hwpt_paging *hwpt = NULL;
 	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommu_domain_ser *domain_ser;
 	struct iommufd_hwpt_lu *hwpt_lu;
 	struct iommufd_lu *iommufd_lu;
 	struct iommu_domain *domain;
@@ -303,10 +308,10 @@ int iommufd_hwpt_lu_restore(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(hwpt))
 		return PTR_ERR(hwpt);
 
-	/* a successful iommu_domain_restore mars the point of no return */
-	domain = iommu_domain_restore(hwpt_lu->domain_data);
-	if (IS_ERR(domain)) {
-		rc = PTR_ERR(domain);
+	domain_ser = __va(hwpt_lu->domain_data);
+	domain = domain_ser->restored_domain;
+	if (!domain) {
+		rc = -ENOENT;
 		goto err_destroy;
 	}
 
-- 
2.52.0.158.g65b55ccf14-goog

