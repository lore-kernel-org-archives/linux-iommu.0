Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395305;
	b=SkvHw+KIrPzLv7uD4pKO+8bsMqNO3fbs0mO7s+snA5pYYtJGq0kk78nT3QKWOb6ytmCZ
	 SVXD/6D5bLEhU18cHbF9Din2GQMUZlLvUM7aX3mwm9WYIZfv7l8iCbAoMdaNXOrnMPEkQ
	 7ZL1viDNHU3u07qjFknfqiK4scEpWtwanhMCqf0AOZrLVXiw/6p817WBxaFSDC/6hexSK
	 j2LaFn4TpL7OtLjMz8O+2N1CsVJQHahf7FVPtUA2eMAs/OsOk+dBvqOmPfJhSg2xrwXMA
	 M1Kc+Va9LNenU1V4moMZ0xugd3dtdPgtsBJluNYUoWocfSQavr+afA0M1ZH5OiVS8bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Wg+r/G4UynsyjzcD9VFm7KNuI6HhIxNTVl9eF5+p1ZQ=;
	b=hVTkrdjKM39KwerlkiP/TZqRfraDfzeCqxlc86/I+IxIFRPMaypD8ZH1lJsZgqiq00uf
	 k9sMgWbVl3uoPV/O2dBgggdHXOTsldI50p48AkzlnicNbRvZxTNKgTIYHl4qoVU1udjo9
	 VnxVEAK2hYc23MKWPYMNujxcMmPpY0INNA3yUci9/XKrIKu5bUxitGB6PBJxYHAwYTOe6
	 n5gFe0BwWCjeWBKmPbhFkY+FC6Fc4G554dHpOFZaaPnSnWxdHrczp2vFgZf3yVxHAnYvs
	 VNJHa1ZSe8qpNUDe+xlxf5kIIr1sSkliAk439T57d0qWxox8mA8rv1RiMttzaFciiQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XpGV5qZE;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896560A2618
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5896560A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XpGV5qZE
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b9f7cace4bso28426745e9.3
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 03:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395304; x=1795000104; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wg+r/G4UynsyjzcD9VFm7KNuI6HhIxNTVl9eF5+p1ZQ=;
        b=XpGV5qZEiTyFOZPvjgrqb+dC3d3GARvPXwuXIpKQll/jOisJ65gaeheCrg9A+aStiE
         9doqQOYXNx+173SzfTVU9lFNSTmd+/cUQ0le8OyBNaDEdjzEufPFvJeluJQz7WE8adJA
         uOCZeK0dELSlSA6cF/USZWt03lt/f4gUu8zbHH1pZx1ysFV8aFonj7dpUQCAxktctUDp
         qzEXiRYW0nMeX8pV9JbXqO4wZ565rE3/mM+5tYj/3LD/KnDCdmsp202ycgd1H5YP8EOJ
         ouHFqMeT/oZl1SHi344rBfM5CoioMx5iRzuRreyK+SycqozOAgkuZjqEt93fiOv0Xt/s
         2wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395304; x=1795000104;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wg+r/G4UynsyjzcD9VFm7KNuI6HhIxNTVl9eF5+p1ZQ=;
        b=RZO/EKK9Sz3V5Y2GvOFvdkSEowwcQ5bmV3HEKI70FEyOFDqRFm8FZbe+0aB6da0Cba
         IxSvcWPw6Pcw0Sft6TTshKHpIon3/Za4gytxgcJKakWYPpI+iHQBqeZePMF2i3Bqj7N6
         n9ulbx/rKi3tzhjSEDp9r9qIAROsSSppmtG7TjjDBSkfdEF17cHvhiHRpRL4GqMnoJAW
         IvVtv6fkK4pvXtPzH8EZlk8ZKY+n+YP1ZPlQ/ekeKodVRI9mM/RKrOqPP7kwy0aZGOC+
         /HqIGLdp41opZJ72Ex+CjlAYPqa/WsKjhc1s5+sVXS3GPYIdSKcRlpgcPDj65VYbLLAo
         ACQA==
X-Forwarded-Encrypted: i=1; AL+hErHij1aErCRiCAOIYa3Qh6FGgNzMqUGWlk3OhWUjv+lciN7Tga3P4POq7Le1IpI00/vm+r4xjQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8k6wkZ1R+AeJIa3m+8ChRSOsWkY2j6zGnYnKoQ6ZfnIHBDYhRA
	RM3QDUk6mo/76wLO0CZB57ye0Hy4uN0eNMUeryAgelt1NT8u2lj/u77RhLkMYjlRll8IS1ykUD7
	PAkKx6JKVY6R4qLQio9ZVbQ==
X-Received: from wmo18.prod.google.com ([2002:a05:600c:2312:b0:4a5:34a9:6903])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:82f1:b0:4a2:cbe:beac with SMTP id 5b1f17b1804b1-4ba093c85ebmr40371365e9.23.1794395303273;
 Wed, 11 Nov 2026 03:08:23 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:31 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-2-vdonnefort@google.com>
Subject: [PATCH v3 1/8] memblock: Introduce MEMBLOCK_PTEMAP
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, 
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, 
	ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, 
	ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, 
	danielmentz@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Keeping PTE-level mappings is interesting for arm64 as it allows
mapping/unmapping pages from the kernel direct map without the risk of
splitting blocks which, under the break-before-make rule, may trigger
page-faults the kernel can't handle.

However, mapping the entire direct map at PTE-level is costly. So
instead, create a new memblock flag MEMBLOCK_PTEMAP to selectively apply
a PTE-level mapping.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 40e6e0aa2f8d..67ef20a1c5e2 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,7 @@ extern unsigned long long max_possible_pfn;
  * know is good to use. It is the only memory that allocations may happen from
  * in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_PTEMAP: memory region to be mapped using PTE-level mapping
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +64,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_NOPRSRV	= 0x40,	/* memory with no KHO preservations */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_PTEMAP		= 0x100,/* PTE-level mapping */
 };
 
 /**
@@ -160,6 +162,8 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_noprsrv(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size);
+int memblock_mark_ptemap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_ptemap(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 
@@ -305,6 +309,11 @@ static inline bool memblock_is_kho_noprsrv(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_NOPRSRV;
 }
 
+static inline bool memblock_is_ptemap(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_PTEMAP;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index a450092a80fb..b8b6e762917a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1068,10 +1068,15 @@ static int __init_memblock memblock_setclr_flag(struct memblock_type *type,
 	for (i = start_rgn; i < end_rgn; i++) {
 		struct memblock_region *r = &type->regions[i];
 
-		if (set)
+		if (set) {
+			enum memblock_flags map_flags =
+				MEMBLOCK_NOMAP | MEMBLOCK_PTEMAP;
+
 			r->flags |= flag;
-		else
+			WARN_ON_ONCE((r->flags & map_flags) == map_flags);
+		} else {
 			r->flags &= ~flag;
+		}
 	}
 
 	memblock_merge_regions(type, start_rgn, end_rgn);
@@ -1221,6 +1226,35 @@ __init int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_NOPRSRV);
 }
 
+/**
+ * memblock_mark_ptemap - Mark a memory region with flag MEMBLOCK_PTEMAP.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * If supported by the architecture, such region is mapped using PTE-level
+ * mappings in the kernel direct map.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_ptemap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_PTEMAP);
+}
+
+/**
+ * memblock_clear_ptemap - Clear flag MEMBLOCK_PTEMAP for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_ptemap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 0,
+				    MEMBLOCK_PTEMAP);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2854,6 +2888,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_NOPRSRV)] = "KHO_NOPRSRV",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_PTEMAP)] = "PTEMAP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.56.0.542.g3ef89b7020-goog

