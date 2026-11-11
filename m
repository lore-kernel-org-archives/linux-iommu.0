Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395307;
	b=biHulklj+HZiyMotWpnDn3sQOvmQALyEZbM6xpnyyyhHKOC2rvGmxxkacsIejMB8MccA
	 ONxzAcCblEC46jlGCgO1JviRxAiuYsIX9grgWZ/FWF9KTxWRZy6lhn9iBk1b5uG7uyumr
	 RxglBjAiCF37wP6A71/KT/sw1xnQzF21SfWGEMmfvmTGsJUUDs0eMH3kzvRxkaFMLVOr2
	 VvIQjmg8Nr/J/UXPGZud0pi3d2GDkDN4wFGS/C4wmuEhfcdhJRR52bxxIR8u/Ndkzf+Vz
	 VQ5l3MMDapWJV3BfNT1C8kIt52fkYhRpWRnbKXyf2I815yVz9gJARDaMmApXqGUHVog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Pd2LkXH74KyjkxP8lUXKvl1JOnJh/9hivuqWG2OIXns=;
	b=SKl7548+81wBsqPb8e5rZSgBsGigGNfFnatDMQA2Dn8fM93wdhaa2gDW7sh9EN6Ce7pO
	 RIqv0vZv+4Dbcw/tlAL0nPQ+nE1fMHQ73AxP4CBvJaGw9f8vNFYz0grAnyaN8tTfzk9uJ
	 zfgq8cqsJBUJd5rdjc04JYeBAaIfAw/ABqClTp+qwzWt8zSofnVLp08q9/ETmhlfC646X
	 uFpwN+j15saGk0uvN/+uKO4XxpQMnZZTw5U3majTlxrET2bcjEjiDB2spevEXiD54BTpA
	 BYdwuiZ62sx9NVY1DFZuFpHDdyIaTY6Q+Q71QcN8R6MT2VTpOj2fFrOMZ/2n9vYIjqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WZhcM1Sx;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF22606A8A4
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EF22606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WZhcM1Sx
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so30613845e9.1
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395305; x=1795000105; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pd2LkXH74KyjkxP8lUXKvl1JOnJh/9hivuqWG2OIXns=;
        b=WZhcM1SxBV9e4V2k4WOZ7nlWoqQfNJxQqXvBUSwyEZBpXbBOH7eAqqvWllug9GNVci
         vPcN3b263fKsfhH5kBplonNNm62NmQQ/rCYZABSAt8rwcaX7JGuqeGR9ftDYr7ylKhc5
         hvkySTntiRWDp/Tf1GCF0ZzECBEmETKVJ2Kbr5jkEDI6d7zV3XS+gvZGQNqBfizdfgGn
         3N25rSi7HnP4A4TweThknzu2w5GLsNkuJUn8hhe04oDT3zS8r+vM4jNBm8rqu9NkLSGq
         uas+YYJ32MtHBteuR3s5Ijt0hIUfGW4Zj5RCr6yZNp/zmVL4pB7KZVGdtlcihNhGI2ip
         ByiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395305; x=1795000105;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pd2LkXH74KyjkxP8lUXKvl1JOnJh/9hivuqWG2OIXns=;
        b=ZrxJ6c831sovz8EC9bQx+X8ADgiD6Y9GA0pMbBFim4+orzcp+9uQFDJOMQA/VTRkCT
         EwUnFudfgYSXOUVgwOUIcbQflMyCUizk/KDSHLwhrcPLGJzT+jHISbiUO/56mxOQRLhx
         TA6lCIJec+k0/jflB/W/vxzYPqIgmMyAfagxAcDKIZ/QJZn+PjxbvWStHiRYCqDvgzGv
         c8D3reJ7DzNvIxtLEuGufzrldb5P8uf9xfwvgcvXm4/AEnFR1kxRk38LCyLuz+Npk0bE
         kr3vsGmU//sJDVpEMfPNcdfSHKm/Om2koyjYNHAekvNbOGMdEGeZvKG/ejK5K+6rCTI0
         gk5A==
X-Forwarded-Encrypted: i=1; AL+hErHKkder2loyozIvWvjAIrA1MY18/6rNYStRKkNqIpdERZK+Oi9xG1SO/kKWImrFB1NLZO+tXg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9x16OSUTYaMOcEblPifG1NDPXETprs4DMloozVUTTzW4q/fUpY
	0/t8UQbZliN6qSvGrs98QYaYqQbqOwICsiO86du+YXnDGyG/n1bQe/Xm9q+ycjYA9xzh+Q/Cm1G
	smKh0qLJbGRUZs0aS5WOWvw==
X-Received: from wman16.prod.google.com ([2002:a05:600c:6c50:b0:4a1:e44e:ffd0])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c08b:b0:4ba:4928:8aec with SMTP id 5b1f17b1804b1-4ba49288bdemr21813875e9.9.1794395304668;
 Wed, 11 Nov 2026 03:08:24 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:32 +0000
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
Message-ID: <20261111110738.872947-3-vdonnefort@google.com>
Subject: [PATCH v3 2/8] arm64: Add support for MEMBLOCK_PTEMAP
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

With the MEMBLOCK_PTEMAP flag, force a PTE-level mapping. This also
disables contiguous PTEs to make sure any page from the memblock can be
safely unmapped from the linear map.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/mm/mmu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 140520b351e2..a4cafafa1d82 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1184,9 +1184,8 @@ static void __init map_mem(void)
 	phys_addr_t init_begin = __pa_symbol(__init_begin);
 	phys_addr_t init_end = __pa_symbol(__init_end);
 	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
-	phys_addr_t start, end;
 	int flags = NO_EXEC_MAPPINGS;
-	u64 i;
+	struct memblock_region *r;
 
 	/*
 	 * Setting hierarchical PXNTable attributes on table entries covering
@@ -1226,9 +1225,14 @@ static void __init map_mem(void)
 		       flags);
 
 	/* map all the memory banks */
-	for_each_mem_range(i, &start, &end) {
+	for_each_mem_region(r) {
+		phys_addr_t start, end;
+		int rflags = flags;
+
+		if (memblock_is_nomap(r))
+			continue;
 		/*
-		 * for_each_mem_range may return sub-page-aligned boundaries
+		 * for_each_mem_region may return sub-page-aligned boundaries
 		 * after memblock_mark_nomap() splits regions at byte precision.
 		 * __create_pgd_mapping_locked aligns phys down to PAGE_MASK,
 		 * which could accidentally map no-map memory on the boundary.
@@ -1237,17 +1241,21 @@ static void __init map_mem(void)
 		 * regions. The cost is at most one page of unmapped gap at
 		 * each boundary.
 		 */
-		start = PAGE_ALIGN(start);
-		end = end & PAGE_MASK;
+		start = PAGE_ALIGN(r->base);
+		end = (r->base + r->size) & PAGE_MASK;
 		if (start >= end)
 			continue;
+
+		if (memblock_is_ptemap(r))
+			rflags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
+
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
-			       flags);
+			       rflags);
 	}
 }
 
-- 
2.56.0.542.g3ef89b7020-goog

