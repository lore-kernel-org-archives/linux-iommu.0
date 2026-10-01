Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFD41D114
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895754; cv=none; b=d0esR40ykaLlX1POpctNXS9L4zFge/W8aie1Q4AxRFP4k8aiN8e2rceQfwOqqk3zmgY/4uzaaZmBjYReUVXqtsQh1IuhqCFrMOvoGOtUvnQx31Ajg/+46/CETIHVZzMZk5DP9MUayQIATbqT9wgvObVAJkivjSiWiMW3PbrUE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895754; c=relaxed/simple;
	bh=k4kLbGOUGBh36x36Ow7aydJOV+hx0km11B/VqihCssI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W21x5g/VpC+Z/1AnAfcaxiNvLKxuPfSV9j6Md4r9wk98FVctg1em+TkhjMVmMxfDnr7j+jBtfWVAkIKI0rwRPDsudauI/exBLWmzFEEZjavyZF5AcAt0VTg+B2FMmHWm0J7DyFxlVGKH4u6CM9ZqGTKKJLSuXHe+r7A+pqMhroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgfgsiNE; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgfgsiNE"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2d4a8623bso28010675ad.1
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790895751; x=1791500551; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9Nsbq9QtXqLgLY/VgsHpejd7/8LcoyLy2HQz4L3CBk=;
        b=mgfgsiNEnzaPUXySXxN1+sO0a0qK52kFUWVBGQf72NgQdecTdDgiv53Odv+tAURGiF
         98CtxOWykCyEIkb/WdnogROv9Ra/I7EIrMfS1NALnDUZAPEWkSG8VANYT13DgRvdys50
         nh1uI3/o4n0HqK7gMCPsocTD7D1YAf0vOI5WFwCBKHp0k7LGbzewPlcF9iZNrqp6I+Gh
         xXFDE5To6DCryGXxUONBdBrboOGt69P7y8mBlEtRtB+r4VNl5cydJ9xhC3s3j6QW3lh5
         Uu+qlUjDltHxrCNA816fG5kxkxuOr6z7rdAP2Plyu/tdqfCHB/gC2GvR9IbgwUgWmrTt
         fGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790895751; x=1791500551;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9Nsbq9QtXqLgLY/VgsHpejd7/8LcoyLy2HQz4L3CBk=;
        b=LB9RViUWbffgWdoDoKrjZ88bKADcoTCrwCA5qWZr8FKUef5FJpRBDWZuHRgebUf6g8
         G9c7xjuDxv3qCiRvBCP2vNmuAfv9XY2GjWUFZbbaG5ExNPr5Vgpkh5QrUUwjc0osQsyc
         O7AB/hJ/e+IW/+y0xpyVgY4eBo8Kgs6wkMd7dRszUA+1iUd0boOh3/e6Jer8Kksep3mD
         oMsx+twfsq4XFvVA30c0wiRFbkE8S1+ijyJgENxsggyQXI+aaf8OSYtXdL235MLU2rg4
         IOBXyb6BlDLS77fIjeCR98cfeInvvu8ttqbBY7CadjtHdeoij367XTaPC0+oHGul3b8/
         TcJw==
X-Forwarded-Encrypted: i=1; AKwUvBxhmGBPCYDdGNuoW4hZrIxcGtRxtKNaLLgJH6lLJljcTGXLGOz3lla+lxPHHzsyFl7c2dhNoQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nKSRIQMgzbMTrOVIUjD3o1HgoGdbE4hALWV4pz2kCuEriQTsdG
	4fPKFnEzikn222wUoT5uYir896m33+s0FTmY/wkJgQLmFNy6ebhjqJc9LEC7r5/qENOSlkZQzX+
	ywQ==
X-Received: from pgbbo24.prod.google.com ([2002:a05:6a02:398:b0:cc9:f793:b98a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1f:b0:3e0:af38:a4ce
 with SMTP id adf61e73a8af0-3e0bd199495mr735761637.14.1790895750642; Thu, 01
 Oct 2026 16:02:30 -0700 (PDT)
Date: Thu,  1 Oct 2026 23:02:17 +0000
In-Reply-To: <20261001230219.818128-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261001230219.818128-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001230219.818128-4-praan@google.com>
Subject: [RFC PATCH 3/5] iommupt: Add lockless sever_branch helper
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Logan Odell <loganodell@google.com>, iommu@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new sever_branch pt_iommu_op. This helper performs a
top-down walk to locate the target parent slot and safely executes a
lockless cmpxchg to 0x0. Because generic_pt abstracts all hardware PTEs
as u64, this safely utilizes the existing pt_table_install64 to cleanly
sever the branch regardless of the underlying IOMMU format.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 40 +++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    | 14 ++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index c3d09b746eec..868242eb2d55 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -1155,6 +1155,45 @@ static size_t NS(unmap_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
 	return unmap.unmapped;
 }
 
+struct pt_sever_args {
+	phys_addr_t expected_phys;
+	bool success;
+};
+
+static int __sever_branch(struct pt_range *range, void *arg,
+			  unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_sever_args *sever = arg;
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_TABLE:
+		if (virt_to_phys(pt_table_ptr(&pts)) == sever->expected_phys) {
+			sever->success = pt_table_install64(&pts, 0x0);
+			return 1; /* Stop walking */
+		}
+		return pt_descend(&pts, arg, __sever_branch);
+	default:
+		break;
+	}
+	return 0;
+}
+
+static bool NS(sever_branch)(struct pt_iommu *iommu_table, dma_addr_t iova,
+			     phys_addr_t expected_phys)
+{
+	struct pt_range range;
+	struct pt_sever_args sever = { .expected_phys = expected_phys, .success = false };
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return false;
+
+	pt_walk_range(&range, __sever_branch, &sever);
+	return sever.success;
+}
+
 static void NS(get_info)(struct pt_iommu *iommu_table,
 			 struct pt_iommu_info *info)
 {
@@ -1208,6 +1247,7 @@ static void NS(deinit)(struct pt_iommu *iommu_table)
 static const struct pt_iommu_ops NS(ops) = {
 	.map_range = NS(map_range),
 	.unmap_range = NS(unmap_range),
+	.sever_branch = NS(sever_branch),
 #if IS_ENABLED(CONFIG_IOMMUFD_DRIVER) && defined(pt_entry_is_write_dirty) && \
 	IS_ENABLED(CONFIG_IOMMUFD_TEST) && defined(pt_entry_make_write_dirty)
 	.set_dirty = NS(set_dirty),
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dd0edd02a48a..d1ade1767a9a 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -137,6 +137,20 @@ struct pt_iommu_ops {
 			      dma_addr_t len,
 			      struct iommu_iotlb_gather *iotlb_gather);
 
+	/**
+	 * @sever_branch: Locklessly sever an empty page table branch
+	 * @iommu_table: Table to manipulate
+	 * @iova: IO virtual address associated with the branch
+	 * @expected_phys: Expected physical address of the child directory
+	 *
+	 * Context: Executed locklessly by a background Shrinker.
+	 * Uses cmpxchg to write 0x0 to the parent slot.
+	 *
+	 * Returns: true if successfully severed, false if aborted.
+	 */
+	bool (*sever_branch)(struct pt_iommu *iommu_table, dma_addr_t iova,
+			     phys_addr_t expected_phys);
+
 	/**
 	 * @set_dirty: Make the iova write dirty
 	 * @iommu_table: Table to manipulate
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

