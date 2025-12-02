Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203430101C
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716605; cv=none; b=D49DF5i7eAoSJrVo8kCi+KC4XYy0j3aQcHEDAZA4y7XbbUrIDNUz6heXqaKxaPsq3hglh3rcnr7swxI8xQvegLi/1ScKFrjM/XEGINeN8C3PqesrCsaE7mPjxFZdLzrSZSHeoNFj0BGh65ooR8jpdjFx6FlpIsFbSu7Pj4sUM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716605; c=relaxed/simple;
	bh=ceuk3iPcMrf9NUlo7mbFenzTpA5bcD2b3lrV+7OnJs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Apy4J8FXDxS8EMpZmXnzRg8RDfmNbwmwlltPCg8cpLJDUw3ytsgvM7AmsL5s2U6oLLknj/LsWangyYjTl5nZtVNJLocpw3BuRHkcoIVyvGZOAdfziJub96ASo9YXm2YxK7f16XROPdAMZ2iQqa9vQB78SkyMN3jaz6vYqxc4C5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4Pud0wG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4Pud0wG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so8718836b3a.2
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716603; x=1765321403; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+zTp7kcc83o3bUaaDwi9+x43Y1GZs1prwv6EwFNWhQ=;
        b=j4Pud0wGglyiKzm1Ou8ABD/98V8Kc1+Lsmn1J3+F1/u0Vc6xvL1sPmX/W5xaTdU0w5
         RE1WREIKJTlBTOeME0ZKUwzKYDmWYEZDDedVqjO/R/re1bAv6i+ztFZNoXrUcJybdrWN
         zG1sfrasbmAY7weCxhZM1Tb4MmNJVVyIE1Yqao3kk9DIwSTqfIuDBTHdAwk477G7lM+z
         qJsVAvfp/+ONhUqGcpIkUGpEGMBSHK5Xf+X8xwjY2zN9Qzu2/S5aJ54/iOlHsm3DeZfr
         uzM+c4YLSY1Fjj5mSeN26JxbJkBwRXyjg5FfuMsxVb9uRT7KZOYAz01wUToTDihrsygz
         A7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716603; x=1765321403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+zTp7kcc83o3bUaaDwi9+x43Y1GZs1prwv6EwFNWhQ=;
        b=b4PxVETAWEZaDk5lDn4BpfCzI+nzKION8M8ojRYyDFfTduu2Ja4FglDdiQaj0fDCuB
         1n0yqS5aBxAYfGsAnTsHcAQsRPqRAPqmsTauPYXSldcE71dlNjjOJrLlxaz5b+RE5dqc
         6EeLo0/wMCXRA3o7V9igffnRCR4Fx8BIUhcAG33YfHUQXOtR9FMhvCQjiJNecVNGQ/TS
         +aIWckoZX4lfB7R7gjnD0tJB/h3/Uu4LRX2khn4qEez50XYYJIWM+i9FKRAwM2MXfREd
         vzLjknRox6on1x2C6xFarSsca2gWSElE45eD6rK+2lWo94OqPqpYggtmNT0QL42sPL+E
         GXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqJsoYH1o3poKna+lqDYvzx8ZlQYeqTu1qxTB11oeLk6XbVrO9sEZqh95qucjk0n8bZ8NXYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDoOXcrZOIMD3eMEn2p7pi3/kxvdDw6MXSaCTTqGxvprc5jFGp
	o9iB9t1obwmc08tQ/w2X5fKGZkiB0MXPsdQXcHN6pSUmkSCIAmiy16x5/0UzdSL5KQYOdVdFZcr
	EBMnaYD9Yd7orWg==
X-Google-Smtp-Source: AGHT+IHCPPSGgTwLqU/Wy2TYMd7k1ek2HPcv9nddYp8Zw6SSSJSIKUi4rl6CLzyc/VYfUhtPuv4rsYaWGvTTxg==
X-Received: from pfbld21.prod.google.com ([2002:a05:6a00:4f95:b0:7cf:2dad:ff8a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1796:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7e00a3c4f2bmr189873b3a.10.1764716603244;
 Tue, 02 Dec 2025 15:03:23 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:42 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-13-skhawaja@google.com>
Subject: [RFC PATCH v2 12/32] iommupt: Implement preserve/unpreserve/restore callbacks
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

Implement the iommu domain ops for presevation, unpresevation and
restoration of iommu domains for liveupdate. Use the existing page
walker to preserve the ioptdesc of the top_table and the lower tables.
Preserve the top_level also so it can be restored during boot.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 100 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 +++
 2 files changed, 110 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 032d04ec7b56..f71b8c92372d 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -354,6 +354,7 @@ static int __collect_tables(struct pt_range *range, void *arg,
 				return ret;
 			continue;
 		}
+
 		if (pts.type == PT_ENTRY_OA && collect->check_mapped)
 			return -EADDRINUSE;
 	}
@@ -918,6 +919,105 @@ int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
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
+			continue;
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
+	/* Collect all pages*/
+	range = pt_all_range(common);
+	pt_walk_range(&range, __restore_tables, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(restore), "GENERIC_PT_IOMMU");
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index cfe05a77f86b..d67d1d8b509f 100644
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
2.52.0.158.g65b55ccf14-goog

