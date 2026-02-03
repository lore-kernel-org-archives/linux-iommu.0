Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36887378831
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156600; cv=none; b=bnEnEAAfcHVcCnAZcg/T2Eme9FqZ7m5cZDe/AO6k4T9dMY8NeFnyqg0Ohth5WpdoBoTZPtCyjAHWVGe4LwbSfo312lIHVdQpXMKJOVWZt1gx75QawNJyUMDIP4Jz2pab76Pgw6jBrLxJZMdY2obj99PTMZpa9c+HRjM44JOqlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156600; c=relaxed/simple;
	bh=XmH949+cFNYEHjPb6Flo1g0WANgdqrWkFIs/6XqOnbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c+J4Br+ZfuKtRPdjnTongQmEI+zPgdNqiYKe2BNAMAI8yOcL84PF9NY03ryZ91Wpz7WYfkf5Szqz28na/UCQ36UteZ5ajEaj9Uj91lhEZVrmNCYNZwfe/nyHKIE4YFudPdF/W33QBrF6r4y84GP0p1i/bvedXnJ5L5sQp8gZ1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5Ryh5Q/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5Ryh5Q/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a8c273332cso159217265ad.1
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156598; x=1770761398; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiKJgtR9ONUoXQPN4oexiJxFq7KWJtr+8+pAjx8UEac=;
        b=C5Ryh5Q/703wCRvErBXlDWvgJvWAbgxM/eL3+77z/wwavLrDjoOjf8W+itE0ffeG6i
         iHiPaJ1w6Cztpc2k/oeagadHvkj+kzqZNVbbtCcfHghSLYI8NQ8nCnB9yTh8Tvn2Ucu0
         E40H4WAMj15EnRCCJv4qAlt0v/Ne9uPeRJYobqUbuOssvZ4DRapLFywEiEYbmkRruOHI
         ErVX7FDv+yUNmFuyObRPnQ1JgRXevUqNoLLt381sQ+EdbcQBoiITb5N4cK0Xzg9gAL2+
         KS/wx44j1fM36vn1eDbgVaU37ok1OYLtppu2+5tuYdJyAonGwdad23RdqJAmCN9H6Wm7
         l3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156598; x=1770761398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yiKJgtR9ONUoXQPN4oexiJxFq7KWJtr+8+pAjx8UEac=;
        b=sBgiilhr+EcAt3uYqgusDt10tB9wZroDjesiAvNnfN/JNdQ9oPDAapfxeBCgilhRwu
         kI+eP9MyrrCtU/CnHcont5s98aWL71C/kBosROjkRUZ0RcU3AsZP0tXFKF+RTwMGeUo7
         5z+tkwlLZ/7M3mWj2eg69YGwAfdOIKKuzj8vpwloP2i2aj1dFTM26WOlCZ+krokeRQrr
         tZncc/ouQi0+WVbZWxrE7inVGfp8rtakRcn2oqO62nIpHPQAUdGiOz1aNw+/dFFUXPcr
         8mEkVv8eelmhy7XlODLGAj2mk/+HcJ83/ensfwUl3HbHQfnL4VHIJ9LP0Zz9Cu0SZKIB
         CjZg==
X-Forwarded-Encrypted: i=1; AJvYcCX6fXNsavW/mU/3x3v+SmxJ5p7jHb/WC1VUwVfYirbacpVF9JZnCwhBPnOL9f9OC1Cl2a3+iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzEmU9Ssspn0ptmTG9FWRk944IcLk/GQ4LqNxnkdtXalbAysdl
	WSzs9yB1RhOTbXnS1XVIzreq+5YQZFw+8opHWhjawJLbEcVEb2+WbPdqyLnfig8EEXcUI+ILXgQ
	KPWjUuxVy+ZTFRg==
X-Received: from plgz17.prod.google.com ([2002:a17:903:191:b0:2a7:8c71:aa97])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1ac3:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2a933bbe729mr7724415ad.3.1770156598471;
 Tue, 03 Feb 2026 14:09:58 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:39 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-6-skhawaja@google.com>
Subject: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore callbacks
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement the iommu domain ops for presevation, unpresevation and
restoration of iommu domains for liveupdate. Use the existing page
walker to preserve the ioptdesc of the top_table and the lower tables.
Preserve the top_level also so it can be restored during boot.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 96 +++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    | 10 +++
 2 files changed, 106 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 3327116a441c..0a1adb6312dd 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -921,6 +921,102 @@ int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
 
+/**
+ * unpreserve() - Unpreserve page tables and other state of a domain.
+ * @domain: Domain to unpreserve
+ */
+void DOMAIN_NS(unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	iommu_unpreserve_pages(&collect.free_list, -1);
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unpreserve), "GENERIC_PT_IOMMU");
+
+/**
+ * preserve() - Preserve page tables and other state of a domain.
+ * @domain: Domain to preserve
+ *
+ * Returns: -ERRNO on failure, on success.
+ */
+int DOMAIN_NS(preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+	int ret;
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	ret = iommu_preserve_pages(&collect.free_list);
+	if (ret)
+		return ret;
+
+	ser->top_table = virt_to_phys(range.top_table);
+	ser->top_level = range.top_level;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(preserve), "GENERIC_PT_IOMMU");
+
+static int __restore_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	int ret;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_restore_page(virt_to_phys(pts.table_lower));
+			ret = pt_descend(&pts, arg, __restore_tables);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
+
+/**
+ * restore() - Restore page tables and other state of a domain.
+ * @domain: Domain to preserve
+ *
+ * Returns: -ERRNO on failure, on success.
+ */
+int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+
+	iommu_restore_page(ser->top_table);
+
+	/* Free new table */
+	iommu_free_pages(range.top_table);
+
+	/* Set the restored top table */
+	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
+
+	/* Restore all pages*/
+	range = pt_all_range(common);
+	return pt_walk_range(&range, __restore_tables, NULL);
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 9eefbb74efd0..b824a8642571 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -13,6 +13,7 @@ struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_driver_ops;
 struct iommu_dirty_bitmap;
+struct iommu_domain_ser;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -198,6 +199,12 @@ struct pt_iommu_cfg {
 				       unsigned long iova, phys_addr_t paddr,  \
 				       size_t pgsize, size_t pgcount,          \
 				       int prot, gfp_t gfp, size_t *mapped);   \
+	int pt_iommu_##fmt##_preserve(struct iommu_domain *domain,             \
+				      struct iommu_domain_ser *ser);           \
+	void pt_iommu_##fmt##_unpreserve(struct iommu_domain *domain,          \
+					 struct iommu_domain_ser *ser);        \
+	int pt_iommu_##fmt##_restore(struct iommu_domain *domain,              \
+				     struct iommu_domain_ser *ser);            \
 	size_t pt_iommu_##fmt##_unmap_pages(                                   \
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
@@ -224,6 +231,9 @@ struct pt_iommu_cfg {
 #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
 	.map_pages = &pt_iommu_##fmt##_map_pages,       \
+	.preserve = &pt_iommu_##fmt##_preserve,		\
+	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
+	.restore = &pt_iommu_##fmt##_restore,		\
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 #define IOMMU_PT_DIRTY_OPS(fmt) \
 	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
-- 
2.53.0.rc2.204.g2597b5adb4-goog

