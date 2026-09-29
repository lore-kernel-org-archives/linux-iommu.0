Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760A390219
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666398; cv=none; b=b2v/n1WsqdbRZSM5PPf/dUsh7pPsQKLpLcW08+Mx5k5zsfUvBAaS9WqDTXQsfGxPAtYlJqkQOQntwdkOKdm1t9klqUBeb137Bn2XtdIoLmR/pq1bxs3MRudz4XqPhIXDY5HfzgJM0jL2x2Z0thdTDld2L6ii8uJV0SKsu91fupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666398; c=relaxed/simple;
	bh=Cibc0qmVxepQBf7qjOiwlYLorjUoHG7A9mz73J9p2a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHJ1e36RSfsW7CGrbwRHDRqj/wDu5xwT/+DjeY+4u2QiPTw6VbHrd0QgxbJc/S5Hk9SRvNUTtdxWWmaZXIh8IjxMzXMFT2XYLCFGx5WuvlfCX07XAQNBxZZYOyR5zl/xsyvjA4gieuq3u92dUjayA4PonhwlPivvokuDjTY5dR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6xQHjJF; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6xQHjJF"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso2202448a12.0
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666396; x=1791271196; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oppeuWMIuYJb2+RCyuh9zePmLDu8NMomw2YlOiRHYbs=;
        b=M6xQHjJFvKEOhRJ427+lYgkKI6jB2Cgcs7gOBKH99yyb2jvSP57rkc6Bn1P5jt2bdm
         oB4tQl9w2lIWOqw1kqLdJNJFnKXymaUnuv4I9v+Et/hV4gcPxeK3EoFw7OffFLVKNs3U
         pGEGWCMgOe551eABt8VlXR9v3A2dNN244ro/DMvmDSyMdIsh95iqwKM8gSjFJRIHSAcR
         SZO6MLO+SCjuR3t0UAF+Pd2DtRQAj1ZUlUov0rhLmJqXhayy2GWQnLwafk5+L8MDq0J5
         ww1ehd50n5si9NgrrCpUnNEDWcl5cdbtWQSOqcaP8vjNyAQDPO/+/NCyJucEDOLrDMln
         XGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666396; x=1791271196;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oppeuWMIuYJb2+RCyuh9zePmLDu8NMomw2YlOiRHYbs=;
        b=jvH57x+pu1VCu4at/jg7SPjXgSXtbF6nIxUWDCU8GMc/W4U1BP9/kKgkHAPO6/PDpg
         C/NChhkGLZFdYB8f+kqgK9Xzdv3u1EWs4D5xtqJDAUZpmLQvVS+xaavK41jAnPfTiVNo
         AHfg3AMuk6JLM2TkNOZuuTmy3olj+OZ4E3lWAU2v+isyKVlh0UlyK7HwFQZxJgBTf62l
         6fM4NtNee/BqD+npaadwQVL7+0uQfyg/GN/dAsFhihdXW4jOmuuLPO5BcFBwOmYSp5Od
         KnoQO9+dy6lDTG4ajR0DHd2IrHzBjZ8X1wcpXCJpjMt6OjDLp6Mx7d8xRWfn/VBBe2na
         sx/Q==
X-Gm-Message-State: AFuF++lrALC79gdEVlxOa/3sRTpwOhOJ76yLs6xffroO3akuV1r+9lbm
	o1D8CrHGPyCwB28c+RMYbu4eS/Lmo/LporPnypmLbjg+VDwYaGfaBZrLhoCxZT6DZWt/S8/w1H7
	oroQhA2ibo42NDR/bFyelCDchsu98P1hR+YRdGBDvfppXdESTA6lIsfMJ7ujm882JmYU9+O76Bp
	pOm7ZwAYL4VbVdv9DElJ5/CPqjs/PlSA==
X-Received: from pga22.prod.google.com ([2002:a05:6a02:4f96:b0:cc7:97c8:bb2d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1d:b0:3d3:af44:ee12
 with SMTP id adf61e73a8af0-3de0e76eb53mr14711712637.27.1790666395477; Tue, 29
 Sep 2026 00:19:55 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:42 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-2-praan@google.com>
Subject: [RFC PATCH v1 1/9] iommu/kho: Extend IOMMU KHO ABI for ARM SMMUv3
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the KHO IOMMU ABI to support state preservation for Arm SMMUv3.

Introduce struct iommu_smmuv3_hw_ser to capture SMMU hardware state,
including the register base, Stream Table config and Live Update state
tokens for the preserved Stream Tables.

Additionally, introduce struct iommu_master_smmuv3_ser to capture per
master state. For now it is used to preserve CD tables for Stage-1
translation.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/linux/kho/abi/iommu.h | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 308cd83fd3e3..397fdb0449a6 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -82,6 +82,7 @@
 enum iommu_type_ser {
 	IOMMU_INVALID,
 	IOMMU_INTEL,
+	IOMMU_ARM_SMMUV3,
 };
 
 #define IOMMU_SER_FLAG_DELETED	(1 << 0)
@@ -142,6 +143,23 @@ struct iommu_device_intel_ser {
 	u64 max_pasid;
 } __packed;
 
+/**
+ * struct iommu_master_smmuv3_ser - SMMUv3 specific device state
+ * @l1_cdtab_lu_state: Live update state token for the linear/L1 CD table
+ * @num_l2_cdtables: Number of active L2 CD tables preserved
+ * @l2_cdtab_lu_states_phys: Physical pointer to an array of u64 LU state tokens
+ *                           for the active L2 CD tables (0 if linear)
+ *
+ * Note: Currently unused for Stage-2 Live Update. Reserved for future
+ * preservation of Stage-1 per-device Context Descriptor (CD) tables.
+ */
+struct iommu_master_smmuv3_ser {
+	u64 l1_cdtab_lu_state;
+	u32 num_l2_cdtables;
+	u32 padding;
+	u64 l2_cdtab_lu_states_phys;
+} __packed;
+
 /**
  * struct iommu_device_ser - Serialized state of a device
  * @hdr: Common object header
@@ -159,6 +177,7 @@ struct iommu_device_ser {
 	struct iommu_dev_map_ser domain_iommu_ser;
 	union {
 		struct iommu_device_intel_ser intel;
+		struct iommu_master_smmuv3_ser smmuv3;
 	};
 } __packed;
 
@@ -181,6 +200,22 @@ struct iommu_intel_ser {
 	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
 };
 
+/**
+ * struct iommu_smmuv3_hw_ser - SMMUv3 specific hardware state
+ * @phys_addr: Physical address of the SMMU register base
+ * @strtab_base_cfg: STRTAB_BASE_CFG register value
+ * @l1_strtab_lu_state: Live update state token for the linear table OR the L1 table
+ * @l2_strtab_lu_states_phys: Physical pointer to an array of u64 LU state tokens
+ *                            indexed by L1 index, 0 for L2 tables that aren't
+ *                            preserved (0 if linear)
+ */
+struct iommu_smmuv3_hw_ser {
+	u64 phys_addr;
+	u64 strtab_base_cfg;
+	u64 l1_strtab_lu_state;
+	u64 l2_strtab_lu_states_phys;
+} __packed;
+
 /**
  * struct iommu_hw_ser - Serialized state of an IOMMU instance
  * @hdr: Common object header
@@ -194,6 +229,7 @@ struct iommu_hw_ser {
 	u64 type;
 	union {
 		struct iommu_intel_ser intel;
+		struct iommu_smmuv3_hw_ser smmuv3;
 	};
 } __packed;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

