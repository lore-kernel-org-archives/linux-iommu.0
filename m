Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D41E32C5
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514503; cv=none; b=QlRCp7Q6ZN9npS8fBeXEwxCSTNwOPbvvZ6BkSdSFy5GDPMLQns1bjApXGrhw4WcqsU2ly5y2dSdmrI/gwQAoqnWUX71hneKTUAVZgU7rr+UqEd+zyuvnat2/jxaXstIFbp7n6tuhTh724r1Qrq6X4cS5vMDK+VQEQwBfPHrlvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514503; c=relaxed/simple;
	bh=JsrZeCaQVws/kN74M+/NHZMiMZ6c+wWQ4TuRJScgEVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKeAQLNYraVCiCCbcNP4VMrbHicO8ift7JBNXII7LzMM5OdI3vAeT4GhbHtwyaQxre1pK2a6o3AchalN+LSwEqPbDshfP3QSn8svoE3MbNFewPveT9uClHFf0a489vkvoyRrgmAAbRb9jAwdKq+QMt5ez1VK1kgyCTGHJVARh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TewnthPC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TewnthPC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so2720374a91.2
        for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 05:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736514501; x=1737119301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgih/EBtfLFxrdcl1A6l0hBJazS5MO7S7hSeQH4Z6XE=;
        b=TewnthPCwB9KYob5yukE4JofSN9sGObaat3fAtVH9NX2U3eDiGoQAPRcOcvb1I1+uP
         hIws1yz9Wfevnpjlzolj7WiKm83ooqsGMR+w45Qlpwo7f6y09omi8lUDLA+FPdaKwQqL
         fD0crOmCXP0FBiJ+0CRNdhEoUSrNHWlvLISgRWabB+hiCx46x4ZAk8MzZDhO5b9E6dcz
         BHSbG/zmJEPY5IjAsac7SXkWBs8rRSAXyJo9fwAQVZCcgn6AMQ3nSaW5J+qsnkOud8Ql
         Jn2/ZyR6gnlXeWaQZ6qMtYPeLjnkymXFECVD5mno50wPHsRyE5yl7HRvsKNHh83m2qrg
         gcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736514501; x=1737119301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgih/EBtfLFxrdcl1A6l0hBJazS5MO7S7hSeQH4Z6XE=;
        b=vHqeppJvl7xRZ5uxqWxMM2nUKonnlWweU6bpwBYER8xr95csjB47y1eNuN/tIFtdQq
         c9lmJK/dKoD32MoSxKD05+DU60OITLnMFr7HYduETh1DbFCRv72u+9TasuLfLAQNBdgY
         Agz24qF/2OY4OA16UbyV3WCqVdXexBi+VrWLVWHX/3egZbLcEI+H2WL48i+PX2de3y9b
         EJNYjbaZIXb/fCy1YYTpBG7Aee2xw0qj8IVx9BH8w3WBvZKUb8TkyDlagugDFHV0fZaU
         ox+9ToCqMn9DBmbhlffn5i7PLQts8sH6CWmsC4jmovf6PcH8xW9nWZkogv6GB3UoGXn7
         uZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6zOzouOkjn2/aYQzvaTMZu/0mceYGGI9VFwyxB6IQQzrQ2ct7reYpGpaP/jQkiEnYyYWOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIWOP/SkurRGEaXGH4SZMbYw/FOdp8pVNJJQ1rCmFd2QPazKQB
	v+q2I4Rh/9cTnsYUx3zbGmJUP3B+WcLY3QknJYjpFHrRdTb6qSXH
X-Gm-Gg: ASbGncvTCEJb2teBZm+7+hiBCBUznjXP9T5PFuYEVf9fCxogB4aK1ZXPQHj9oannVkj
	69H5dbGZMRAowXqq09HdoiITuoIbOfNyzYw7vJ/ihJeweQqHIgZncUaODP3+vSWkvRPd0wuLr7w
	Hon/EtAD9uxvyn68ZdY0/Z3BXrmDzIw6vg87jPQwA2pyH82W26MuakiAQ4RpBMVWKH3UXajGyR+
	rvH1vp8Be4mOIRM44AA537I9glUtCLKVtKMVSfCqWDwOsVHOLGUA9PdnLYJ4JNVBnrS4hQ=
X-Google-Smtp-Source: AGHT+IFkr+n8d73G3zWz2Bg14lU+1QRZhpo2LfDVF0mrFi/lS/dIhRADbnJh3ATz66EUei6eRNSvIg==
X-Received: by 2002:a17:90b:2c84:b0:2ee:8430:b831 with SMTP id 98e67ed59e1d1-2f548f1628fmr16429682a91.2.1736514500972;
        Fri, 10 Jan 2025 05:08:20 -0800 (PST)
Received: from tiger.hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593fead5sm3209069a91.11.2025.01.10.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 05:08:20 -0800 (PST)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: 
Cc: Wencheng Yang <east.moutain.yang@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drviers/iommu/amd: support P2P access through IOMMU when SME is enabled
Date: Fri, 10 Jan 2025 21:07:25 +0800
Message-ID: <20250110130756.333265-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <y>
References: <y>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SME is enabled, SME bit is set in IOMMU page table pte entry,
it works fine if the pfn of the pte entry is memory. However, if
the pfn is MMIO address, for example, map other device's mmio
space to its io page table, in such situation, setting SME bit
in pte would cause P2P failure.

Clear SME bit in io page table if the mapping is MMIO rather
than memory.

Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 7 ++++---
 drivers/iommu/amd/io_pgtable.c      | 2 ++
 drivers/iommu/amd/io_pgtable_v2.c   | 4 +++-
 drivers/iommu/amd/iommu.c           | 2 ++
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fdb0357e0bb9..b0f055200cf3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -434,9 +434,10 @@
 #define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
 #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
 
-#define IOMMU_PROT_MASK 0x03
-#define IOMMU_PROT_IR 0x01
-#define IOMMU_PROT_IW 0x02
+#define IOMMU_PROT_MASK 0x07
+#define IOMMU_PROT_IR   0x01
+#define IOMMU_PROT_IW   0x02
+#define IOMMU_PROT_MMIO 0x04
 
 #define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
 
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index f3399087859f..204f497f0b88 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -373,6 +373,8 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 			__pte |= IOMMU_PTE_IR;
 		if (prot & IOMMU_PROT_IW)
 			__pte |= IOMMU_PTE_IW;
+		if (prot & IOMMU_PROT_MMIO)
+			__pte |= __sme_clr(__pte);
 
 		for (i = 0; i < count; ++i)
 			pte[i] = __pte;
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index c616de2c5926..a03db2d2390e 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -65,7 +65,9 @@ static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
 {
 	u64 pte;
 
-	pte = __sme_set(paddr & PM_ADDR_MASK);
+	if (!(prot & IOMMU_PROT_MMIO))
+		pte = __sme_set(paddr & PM_ADDR_MASK);
+
 	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
 	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 16f40b8000d7..9194ad681504 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2578,6 +2578,8 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 		prot |= IOMMU_PROT_IR;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
+	if (iommu_prot & IOMMU_MMIO)
+		prot |= IOMMU_PROT_MMIO;
 
 	if (ops->map_pages) {
 		ret = ops->map_pages(ops, iova, paddr, pgsize,
-- 
2.43.0

