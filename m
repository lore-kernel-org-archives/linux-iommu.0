Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770527;
	b=GemS8DkYPWUL2/E9y0zfxiS3q9T3obIHHuoBtKMyP/5TvfPfIc5ASa/3N+E2LmOLnTsT
	 zrfCEYelm76MfWaEoAOmrZNbamYnKBFxBb7Pd7oe+KJG/9i80OrGEHzqrfXue1GXx+4Jp
	 /q5EVhAGzWVaG4ejpWSht26TRyeZiYtTFwMUImapwwFNatORDZ5r+KUZr9guHf3WdZ0kC
	 vCorDGrrh7lKdIkjdz1a543diMuOfiSzlhC30QQIZpQZRH35R7z0Ihw6ObZb1Sn/O9KLp
	 iteH+GnMAo6fEZxuHOYRG6SmmvtenJBY5aEF02ci8pIUH4OCLi0Xn5wC20LCn84RHaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PVjCV5oykzsIMcgSWFAsGQFYmzyPz2B20ED1sYdHTJ8=;
	b=RqRx6uzctQbsmzI6CC5LxeH7TbZXy3faX+ua15K514TSgOL6r4o4iHekh73B/Wo5JsXw
	 S3EDUfEiDbphE/SVn4W1IYVLQmNUYJBe2GyGI7wySEz3GCC0Tja8/JfMGdon2oXhc0Vh/
	 tuvHeo1MfS+qbVKZR8TIjBsyOMava+j3RnCFKU8fNKQYMPil1xoAM9bsBVACdZFFlKDNb
	 zngajzDpvtBogVUMSLdkvIWYqzDB6Ipm4kexzIZ8DdPS7lYwUXCYf5yejvo1zJdoWjreU
	 NlGgPJb+K0AKoIx6kkrERFpRqxtIkyclbiGFhxib2KlDk9iE8h2DZZveftfY5MCYsOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SMKHCCrW;
	arc=none smtp.remote-ip=74.125.227.199
Received: from mail-pi2-f7.google.com (mail-pi2-f7.google.com [74.125.227.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23A606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 09:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E23A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SMKHCCrW
Received: by mail-pi2-f7.google.com with SMTP id 41be03b00d2f7-cd66d7e32baso1824877a12.0
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 01:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770526; x=1796375326; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVjCV5oykzsIMcgSWFAsGQFYmzyPz2B20ED1sYdHTJ8=;
        b=SMKHCCrWYoDCASnCUagv/9aP0g1h2JpiTE+s5C3LIzwaUiE9VDOnS+ydyeevJpeBSR
         DtPHcznQOEU58/aaHDfgkyu05ympxSLtEXovR2ABjLrr2HRzIumbMxAtBpbllOak5ox3
         QKL7C4aP8SJ+3juQ0rZOg5niOFOJ8XB6xYg3I+Ji484u05EdRhAGqRYRMSVxGflwu6Eh
         QIzbwvEWCY3Lqy9+WizCQttefbqayOn2jU1OMyeVdp4LE6tsGeMZIW77s+5NTmMzZ1/b
         MGr7rpHEc3nrbFN1+b8pvKsNd3mYv/pGsyc8XZ4FSEUHS3s5ZjcBJVD8gVZgUVq9+9dG
         Q3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770526; x=1796375326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PVjCV5oykzsIMcgSWFAsGQFYmzyPz2B20ED1sYdHTJ8=;
        b=E3nJn/Vawu/d0QqemcgN7BVKRdKfP8j0Ejz38sqNHAFTuc8hKw0zQgd7JPNc7RXzvo
         p3IRlvTcBb3fJOl3W450VaGWaeIu6BcliaKZovKgCQ/t1pYUvPVnDrmybdTIDDkAcJQ2
         uFfwydQJm4EopqomNdLYY8PO3Wz8nZ59qqpp2cq7BlWGlo+wDYQPJEnqGCRVvZTS2vX/
         uTIDYL0s5D3aPfQzpPnIyrWaHsKuPuvkfPh0nFX4AVQ2Q/fco9f9U7idpKTkvGyvoYWY
         ll3OCI/gjDwvDCixuHNGMenb4zEyOOrTa7l5Wpu3TK9dERmgA5nf1qPDFvFSlgGhSRhb
         +IPQ==
X-Forwarded-Encrypted: i=1; AL+hErG7eMZJ1wTClpGwE4YzvYtDGOU868ZJOsg1nrf5lvEeHcrx157M9pq8ZbfboWcs5tJ7JCVoTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+MvQtBiqpl27yF1xfTs9CbeSWARjSfzqaCPmTofCr80Yy2k1er
	6xPMH3MG77NG2n9+Qs7wiKR0kBAVpmWmXtMBaTc32+/ipQA0+cJu1Hoa
X-Gm-Gg: AZFdTZfZOSQ5vPOdYTwt9QCb3jO1fOETWQT7e8jSqxOMYJkcrWuhOEnNdjFTc0BeoE7
	+QyOOhl7PfLIVe52wTQUEUN4RPVR0AwDZaE6RFe0piCO3vW0UnlE2ZGdOhu9KPsGynILb6gaCPq
	ZKGU9B5CTmmNVi79RveXi4a4K1pQh0FgquooB0Sg1hg26hd0y/TYSPUKS0cGdw1sG0ClgCB4jIm
	iV+dwzrt3k7KKEz+J+lQlTSK4Hp+g6DQqqlko50jKJ65+Y+PiLQL/Eu7xaerQMUHH6LGT6ris9F
	iEn5hzcL2/GO6dHGHjZI5t6U7baR2clWSJ5qqN3PoBVhT30n6VzAeECUgX/E7Xmy30Gc77UeVlc
	+/eHPWXG7kgxvgSFRI7BQteaINHmDoBYvmj7Cz5Hlqa+coEdU2neWkFnDpgrQmTCCznRcrfv8jb
	FyElslR14nJRPTBitG5FZTdC2RCLrB3l9S/0hhZqusgn/osEL/2bUeaRMjd8cun3ALU/QuAZesI
	qVSKpdQb6+l0R73MExyoMW6OQMKrTgSunvtE2N3Y2EUiRKW4XXkgGqwtXh9lU+JROxmEGgxAOO/
	ump5HDJ49Rm7eyNX8K5n8DiEDUWIcKOJtJgmobvQXg==
X-Received: by 2002:a05:6a21:8982:b0:3e2:4350:1528 with SMTP id adf61e73a8af0-4014a274c36mr23147815637.7.1795770525740;
        Fri, 27 Nov 2026 01:08:45 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:08:45 -0800 (PST)
From: Wandun Chen <chenwandun1@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v10 5/8] memblock: introduce MEMBLOCK_NODUMP flag
Date: Fri, 27 Nov 2026 17:07:20 +0800
Message-ID: <20261127090723.741253-6-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add MEMBLOCK_NODUMP to mark regions that should be excluded from
kdump vmcores.

The flag is meant for reserved memory that carries no data useful for
crash analysis. Reusable reserved regions such as CMA may hold useful
data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
patches wire this up for /reserved-memory entries.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 40e6e0aa2f8d..67dbcfda6f49 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
  * know is good to use. It is the only memory that allocations may happen from
  * in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
+ * for crash analysis (e.g. firmware carveouts).
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +65,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_NOPRSRV	= 0x40,	/* memory with no KHO preservations */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
 };
 
 /**
@@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_noprsrv(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size);
+int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 
@@ -305,6 +309,11 @@ static inline bool memblock_is_kho_noprsrv(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_NOPRSRV;
 }
 
+static inline bool memblock_is_nodump(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_NODUMP;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index 0f466fcfc719..e3ee7f60ec97 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1221,6 +1221,21 @@ __init int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_NOPRSRV);
 }
 
+/**
+ * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Mark the region as not to be included in crash dumps.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_NODUMP);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2864,6 +2879,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_NOPRSRV)] = "KHO_NOPRSRV",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0

