Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB733E3163
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334372; cv=none; b=PqU+cOQXUSEEs1Poc2245WiWf9KPCbR/r0+KeXdoZdUaol973X4007fVMgKbU3P71xqn+MX2wq8S9EO9OhEr2rXH40os2AUupaWl+RRx4eAR7NYD2Q+a3whWvbni5E/N/jsqsKvYl3cDQQOm/saFWP32Bm/gbGpr0SABuNBrVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334372; c=relaxed/simple;
	bh=sSy2WFH17+09Ag7fXYDKW/ARjxfJxT8aeCAfz6vIU4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fefpcOooAx7i/883ORCiyNPWRm2tpXJfFB/korrjNO/Nmnx928uM1mxuxzDHGjnV/AEUXACqF1Ekn7YmjBY57nHGSfvy0wkqYxtobUCoRBN6u7S7c+EHW5DhMe71zinUq6GQWFP+KEkk44X8hp2BUD67lKc9zgpJA+FncGAcXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9n7C+om; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9n7C+om"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca7fcfe1669so413734a12.0
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334370; x=1788939170; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vi97MWhfZddiqmimgtB8vYuipDLussxDN6BUz0TYMFc=;
        b=Y9n7C+omh9H9jdrfkXnQNqanH7kIjLc99avN45bqJqUhPoxk+Kphy6CE91V7o5Vj8o
         sFc+KuzRkg6S4cHwDIdu0969IOY2JBGNBU011RT2yg9X7DOIGMIjorLcxh7+l1GOomua
         +UHUulXy1x81/ju/10b48bQZRFjxuwGzblrHZZW5Gxkb0hugbRDX9DEStuqxwYfO01Su
         huK0ntteKuHFYRU7+KJD19WuK9XRGk88ocaQ8ktNNxcNREwmGuV82UkxRhBqpCY0CFLU
         ZlxYDnpjBcgXzFIq8gfGNvDslmOggp7MGdw/JOE8UUaOL05M0898PFti53c3eICjv7SX
         zCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334370; x=1788939170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vi97MWhfZddiqmimgtB8vYuipDLussxDN6BUz0TYMFc=;
        b=J146to/6eCr0Ekz4O0asGAYFGreixlGYTUeyw161CkOdSxJG7oKeweSITH5L0whBuE
         G+XF5DG1Oi06xT19E4T3fsMgS06zkR5pBhTw6nRFLQC41goBo1Arj16LriiWmZehhhfy
         Hwobr4cvB6ZF05gSL8koZ60gRX4YPVNId3k5f2MeV1w0OPrA1dbsOi7SEFbqfEAIx70X
         bmd49IbYvPmEpRyVzhtnKmWc5sj5k0d3MQq6dC5QituRAB+Y8cI6nnb2+2h/qwFFMpJu
         Z+6i4/Fwqvcpw06agNU5eZurvLlsQxys27gZeuPTiBA4bcZ/WU49oMxyRvfExf5c8VHC
         ENSQ==
X-Forwarded-Encrypted: i=1; AKwUvByBelqLRKlga3iaWVDTwiGOKtM6Q47WZmLoPL5Fs1rAGkMrXTjY+AGk5QmqeiotbTX3f0FxNw==@lists.linux.dev
X-Gm-Message-State: AFuF++meOdMMUIhgGDLozNYjD/tbBHV3XBu3zjcJCADmxBFbQS1OP1hj
	T2gMG9D5L0kX0SfTiglvUvI+kZQ53Lkogxy3tVpoLbpiltoTiv5OIC2e
X-Gm-Gg: AYBFou3WtQypwva6vuIXjEBqETSuizCwecXsYA5+ihaBTFHZzKddc4BRnUO9KrqX4GR
	2C4jkKVBd7khCJI9B0/YZJ5reiBt6EL5nFgGi5/cV3iDeet8tvWBwc9R4bwo1HqLnnTDjkLMUCK
	e7UMpoBX7kdsnNeZvGstrhU+EBktu+CS0vtmOyYTLbOOIhytIAHR6n+MQyFdFnKeptiZV5QTS5G
	HKGoPpQjleJiwbYPo2YV4jEjWW1wvlOKgQvGvCJoyXYWWonLrBAsJ2NmRYuKW/HBT9mIsq716Yj
	lMdJif2RuWNMTX6XXMrlvN+1zPtO+dXQB7kvEgWZ1EZHu0TwqtkDGf0OtMQowRMmL/Uj6e8e75F
	HpY5LAlBUFzkCtLuZyyDczilDv/3pxoagApNxuGTIA1a4w5RoQEN7lGU5QmMR6gzsiH2/xDMoob
	AnjyaGHPXyVnG5GAQaLpv1Dnuj5T6VdVazO5h8dT/S0ukeuHyK38zx90bHtrCWwvw/4N2rbU8W
X-Received: by 2002:a05:6a00:8017:b0:851:ba04:ca02 with SMTP id d2e1a72fcca58-85ed398adccmr5532767b3a.16.1788334370199;
        Wed, 02 Sep 2026 00:32:50 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:32:49 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
Date: Wed,  2 Sep 2026 15:31:12 +0800
Message-ID: <20260902073116.802752-7-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Add MEMBLOCK_NODUMP to mark regions that should be excluded from
kdump vmcores.

The flag is meant for reserved memory that carries no data useful for
crash analysis. Reusable reserved regions such as CMA may hold useful
data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
patches wire this up for /reserved-memory and /memreserve/ entries.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d62db9e776cf..b2fcf11fba2b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
  * kernel that we know is good to use. It is the only memory that
  * allocations may happen from in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
+ * for crash analysis (e.g. firmware carveouts).
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +65,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
 };
 
 /**
@@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 void reset_all_zones_managed_pages(void);
@@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_SCRATCH;
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
index f2952d725c10..2e87f39826dd 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1204,6 +1204,21 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_SCRATCH);
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
@@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0

