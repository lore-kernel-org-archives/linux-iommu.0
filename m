Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395320;
	b=XadeSnw8zunsUgX1ILrtU5VKLaB35edxm0XlwX2nGzlIMq/DOy21YfTF4IHkQ8bvnp37
	 hgoU8OD1Oi0qan+FWSK7OOva0KkT4as4wX8cUm5+uDrNxYr2NNSCliWsbilBwLLH7/vRN
	 pXyNYcaWX1n6a0SYCNz72/nMSkTPLt9U+/1IeO9wg8T79Amo30qaFBjNvwoAzqN0NYq+M
	 gjrAWTJLLBzHl/xVHd0EtK/ovx5rRXBKHNpYkaq878PehhcejB82YsHP4aTucjidbXxQ/
	 4bNlVvc6YnfE7CXm/Hm+/NCI1eT6LJXAgyb8krbY+7KVWsMBQzKHzLASnttiI+ipswQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=laMYshk/IpUNzmzRXv9ltVTwYgsKb/6KaHojH4Vu9w4=;
	b=OdPmngddfc1pk95I+9j+vOcaKidZ4zg4EtnVbDb7hwGA6eKc7fU4jv6/15cpKpeC2MEO
	 QsZM5wAjvFE25XW4UyvMM680TcTU6hckJ34NYCPJmDA5cBp4VHRz8HMD48/xnJ0wkgdf2
	 cJ9ZvXz01cOUu7WfF4iQqbxCxKd38fIHp/Pq3C0lRzXuGPy72A+2C/oT46g4dWuGWBp4O
	 5JpAxzyn1g+4pdO95URSeMKCp0G/kG8t9iaSgDmbi/B6a5YwTj3hQXQ7hhBxP+AFXgZWH
	 S4FOfjKfUWlIoCVaN2t4PtX0vngRs4RL7qBCMx4ReEwWNesyFGqtNPWOMozQjg/dlWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZNy0CfRd;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286B60A5BEB
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8286B60A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZNy0CfRd
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4ba078abd78so6913585e9.1
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395319; x=1795000119; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=laMYshk/IpUNzmzRXv9ltVTwYgsKb/6KaHojH4Vu9w4=;
        b=ZNy0CfRdHj2je0sC61qQR9/qvp9CJvxwUAI+dSbfICIKtd66uqd1vsDokbRn0GbLzF
         +w0KvwNIgHw+/I2pIKyDAZXAAiKfMKsvGS9M1svqF4IzQiLkgi/IQz5FU+LRSYVp/0UL
         efuRd4UlcI22dj302V53quRGujGF9qfP+Esg9SPsy1+Y/ackhgfNEQ8TZ/0Vxe43+9/z
         uURv5MAaT0epJNdVi/QkZjfHxdDfBCRbpDLVGOD1eflV+tc8CHrm/IMY0fWLwfyHKCOE
         sWZgu854091R3pFQc15rioDRH7h4rKhwUv0daiv3S6VEz2piNQqqwszxK2tW5RGur9VS
         o6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395319; x=1795000119;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laMYshk/IpUNzmzRXv9ltVTwYgsKb/6KaHojH4Vu9w4=;
        b=k0oncqPNip2vUecNPpkl5NUQ8KKHoyDhHbHLrhNzfLFbtwCmvk2Gpeyh93gVLykx3p
         QTXq7NRI/SZYJelUA3tmfdJR7OZgy+OlH1AibNnDFjC+Jw7yZE9xfQVffuLNMBQOjGqK
         PZHGsrGPXkRSXy7TaEhWDs/HzJag6OzTJUn/PlFzYWtjGNA107JltJoj+LwrzG5kz/SL
         8AzLxRslhDfn1x6A6090ApDXgAkXzttnYkB5Vxox6zs7/tSaI6H0P++UwE6iIO+wA6Uo
         ZxT1tHbDTjY671/Mnj8XEBVdGlpd7qGbPS/ZajwHVBnuwPC3I9cPyX4H54c2QtX+dM73
         clxQ==
X-Forwarded-Encrypted: i=1; AL+hErHGNWNwX2ime3uxuxtrsbaU3mVFtMUhMXCkII8YH6fVQ76qDb0UhvmDxWOpqNZCgjUHiD2LUw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ZBh/29Hx+mpmewZ3pQ77sBMG9y+iS1iY0HLE7nkOSFwTCLazK
	gwm+qro5E1fi8w5iPIGAgA6m2ApUGBaQVHKgH8qc15YB3ySon/G04PrlJOuQasvPDV/bxOYmjhM
	z8hvbHocXZZMbFtO7+jQWXA==
X-Received: from wmbgx4.prod.google.com ([2002:a05:600c:8584:b0:4a1:cf4b:72c2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1912:b0:4b2:612d:908c with SMTP id 5b1f17b1804b1-4ba093d13f1mr36933745e9.34.1794395318533;
 Wed, 11 Nov 2026 03:08:38 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:36 +0000
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
Message-ID: <20261111110738.872947-7-vdonnefort@google.com>
Subject: [PATCH v3 6/8] arm64: Introduce direct_map_is_ptemap()
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

Regions marked with MEMBLOCK_PTEMAP are mapped at page granularity so
their direct mapping can be modified without splitting blocks at
runtime. Introduce direct_map_is_ptemap(), which walks the kernel page
tables during init to verify that every page in a range is backed by a
present non-contiguous PTE.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/include/asm/set_memory.h |  4 ++
 arch/arm64/mm/pageattr.c            | 65 +++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 0091ba12200e..b6ec938703d6 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -3,12 +3,16 @@
 #ifndef _ASM_ARM64_SET_MEMORY_H
 #define _ASM_ARM64_SET_MEMORY_H
 
+#include <linux/init.h>
+
 #include <asm/mem_encrypt.h>
 #include <asm-generic/set_memory.h>
 
 bool can_set_direct_map(void);
 #define can_set_direct_map can_set_direct_map
 
+bool __init direct_map_is_ptemap(struct page *page, unsigned int numpages);
+
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index de7bf95003ea..c7662fd2fcb2 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -102,6 +102,71 @@ bool can_set_direct_map(void)
 		arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
+static int __init direct_map_is_ptemap_pud_entry(pud_t *pud, unsigned long addr,
+						 unsigned long next,
+						 struct mm_walk *walk)
+{
+	if (pud_leaf(pudp_get(pud)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init direct_map_is_ptemap_pmd_entry(pmd_t *pmd, unsigned long addr,
+						 unsigned long next,
+						 struct mm_walk *walk)
+{
+	if (pmd_leaf(pmdp_get(pmd)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init direct_map_is_ptemap_pte_entry(pte_t *pte, unsigned long addr,
+						 unsigned long next,
+						 struct mm_walk *walk)
+{
+	pte_t val = __ptep_get(pte);
+
+	if (!pte_present(val) || pte_cont(val))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init direct_map_is_ptemap_pte_hole(unsigned long addr,
+						unsigned long next, int depth,
+						struct mm_walk *walk)
+{
+	return -EINVAL;
+}
+
+static const struct mm_walk_ops direct_map_is_ptemap_ops __initconst = {
+	.pud_entry	= direct_map_is_ptemap_pud_entry,
+	.pmd_entry	= direct_map_is_ptemap_pmd_entry,
+	.pte_entry	= direct_map_is_ptemap_pte_entry,
+	.pte_hole	= direct_map_is_ptemap_pte_hole,
+};
+
+bool __init direct_map_is_ptemap(struct page *page, unsigned int numpages)
+{
+	unsigned long addr, end;
+
+	if (!pfn_valid(page_to_pfn(page)) || !numpages)
+		return false;
+
+	addr = (unsigned long)page_address(page);
+	end = addr + PAGE_SIZE * numpages;
+
+	/*
+	 * Called during boot before runtime linear-map splitting, so it is
+	 * safe to walk the page-table lockless.
+	 */
+	return !walk_kernel_page_table_range_lockless(addr, end,
+						      &direct_map_is_ptemap_ops,
+						      NULL, NULL);
+}
+
 static int update_range_prot(unsigned long start, unsigned long size,
 			     pgprot_t set_mask, pgprot_t clear_mask)
 {
-- 
2.56.0.542.g3ef89b7020-goog

