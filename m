Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9012B94
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120218; cv=none; b=gS4+iXtxY15UFSE+yA14RFyY0KlAumPD59kaytY9oFRXlqZjQYU/uojI99Xm8HnHZ3DPZ8DATex4hplX2X237Se2bVvE+O9nTlC/trQh6NIodZMb4IyftfiYFhnq+z+SlIpV7yAR3ih6E1RlUFXySdINpIESxyocqGypk0VoeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120218; c=relaxed/simple;
	bh=xaYAGKNR5teVXSTbMIqN33NUXwD6fmITNKM3gCe5N4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0ECGhsb9XWPs7J7lekERi98R70CXAgfn7MyWmiqgORFXu3ShFL4UeAVChTmIshXCTFc9SNjkJZCB7AR++zpFY3mkh6TDr092NGu+MIZpSphkHVUv0ZJSzeCIfsc4ObOCVP77MynXSlUco/ovOvd41INaXxVDvUQOx3scLWFs3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjUN3qjU; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjUN3qjU"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a0a87595so1267956a91.1
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120216; x=1792725016; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6w2trImMBsUXcJxF+8CP2LmtHij/l89KoLcRCpS0ni8=;
        b=PjUN3qjURl865TY0z/UxK307iLiUqXSAcmHsyhtSFdF3A2D96WFjWK+0R9lfV5Yy2v
         SnMitYRI6PerbtVEtdz6dhEG7A+Go2c3TPW/PP0G9Z/ePa6X70AZx60vS6H0imEpI79e
         ZzHGJ9cn0u/PHssshOuqv4ROlnETlyYkcvid3yYiwHEvz08Iw7V7qJ7PZkGEHr3DzAMl
         Oi+srD0SBo0pI9vKyRGEfTnWSR9KKtdbj6L5qYQGOWsgBhVWmzCiG1ue8Yq6m10NJr5m
         mCijftSXV/uYw2hktoJIKWhbCNOT+D1PhPv3neD4G9/0ePegiD+eiGAZ4vFPfU5FEAu8
         3Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120216; x=1792725016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6w2trImMBsUXcJxF+8CP2LmtHij/l89KoLcRCpS0ni8=;
        b=dFJay8EITDpAEjZiPfu0jdlj74aIKbkAf24pMwCl7QaXmpJanhHSGfqbzo3jU7RZy5
         U6tsJOn0p1jhUSIn7MkNCBtcdK4XMS4a/UkzV/bihbrBLik6NFocEsZuuXUnfci188lF
         ljUa0+ng8kwnARZyg9loazfgtv0Vd8A/gZaurNZlLxHr36JLWBR8Nevyg5jrJOkG/QB3
         hAf3Wu3xjAW8qkzdHAd1qN3eoSE0Xj/V81fmC/XXajQ1vuglF9OeS0KYPR9IremNUxw/
         SUDroAneXHkzSAuZikot+K6RyMBagALLI2Y91q8xkek2JNVrUaQK7RX8XCFR8jKNBK+f
         OfuA==
X-Forwarded-Encrypted: i=1; AKwUvByBdKC6KItd9LxkAhz3kGvtqWvmPp4O+uE+R+TQQGuhE3WqMf1d7lCTpL/E9CRWGT/aHKLyHQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYImCVXmlpAp+CANgd/BRTpw+VMKAoF5lVJNQLrG7qRM1wB1YanG
	qyv1952ntpgXAC6HuwyrEDOaFV1Uo7miIy72m9nTyLE4E3hQPY0/XJ7B
X-Gm-Gg: AYBFou3/exo0m633QDqBCwp+H2Mx/+hji6uermMHj4sWQhSgOuutSvFfuUYLFqKQeLu
	fDkXM5BvipINFF0MjvLHmfPGLDkqiEACqVrN4xj0lSfIG3lxqzxvdcX94aVEBcsEUsKn04bAZu/
	jVYgjhVpEAvLG0GZb1zol0LBdSLuAJc01VdI/YR41xBMTRK3q76t+Px8gFjo1u9Zr4O73hW/14j
	Fr60dRWyPuAmzkmhAlB1aFq7SG23EKxhzITktLKW7vxDgf7NzR8Y8Um+HNJtt8WzEDhWQT8TsYE
	Uz3Bp3M1/wJJXXrev4IgcbHV+u6L2YSxxHCqYX5sT/TGxTMPlMO6DnGT+HNXQRi3VCkx3uoFg3s
	2lMUtSB6KMAd9rF+DENHNFNjAbk1BfGRpmiSELTY6vupnJ7T8Ki1Otvf7h6a0zfdqnrd1KW7DOe
	lT7vC2LwgLqfbXbeGIlNqDisFRRvmxNADKo+p2KFGKpGTiVInl13Tx3f5cSehvvPkeNlIQOtjMx
	9LnN7w4EaQ=
X-Received: by 2002:a17:90b:224c:b0:3a8:bbc2:5551 with SMTP id 98e67ed59e1d1-3ab3a0f0a1dmr21861671a91.0.1792120216184;
        Thu, 15 Oct 2026 20:10:16 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3cc73c7sm370085a91.4.2026.10.15.20.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:10:15 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v8 5/8] memblock: introduce MEMBLOCK_NODUMP flag
Date: Fri, 16 Oct 2026 11:08:52 +0800
Message-ID: <20261016030855.4062882-6-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016030855.4062882-1-chenwandun1@gmail.com>
References: <20261016030855.4062882-1-chenwandun1@gmail.com>
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
index ea288cf21400..04fbdff2b808 100644
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
index cbb172fbf06a..31c89bd64036 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1204,6 +1204,21 @@ __init int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size)
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
@@ -2880,6 +2895,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_NOPRSRV)] = "KHO_NOPRSRV",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0

