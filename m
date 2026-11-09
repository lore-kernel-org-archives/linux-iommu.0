Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239074;
	b=KcLGdYfj++D7cVgovbM85l51nY3kOJvZx44lLgn//tKFysM6+PvXXTvRWYv9Y4Ac2iNQ
	 CTwZDQllaepmFeyyTF2BNMsNV2daxAxuRFwxbkhjHFJbwpPR/81UN7w8C1ujcTpzo7q2L
	 lSvHymsQqFT8r7KxixxyaJ/kuu6vQtNWCgu/4efloDItUuYzbGEJEPdz+eOunv+HhYege
	 msSzea8tizfs6j3Rdtg18jOexvNPyQcLG5CWO2Wu70RbdjFddr2TeGAmnJ7OC+RpkzJfI
	 0i+zWn4+fJqdFfTA6rE3y8A0rn9Iu14Q61Vsx+Om6PjBHtQ39e/ZC7Gtb+bec2SedUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239074;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=KeAlv0EKtTaDGrW0uWisjEOMXQElHFsb7+RWr717ehA=;
	b=YmfwYEvWO/YxG8UugvR+iC3NvilkkWCf6B/GN9dnhBuOF4baJdtN+oEEsPeyyFNXM0Mf
	 OZ0cNu4BN7PTf0B5lxp2mBl/J06MGzkZy5n3VkItuOHBi67ea+9vvckoxOtjRGHoQrrkD
	 w7o2yiDpkGyqJtk/cjk6aL5ibtcKHHibzDJrYWMdNqITxprlccoXQVdyCatl4+v/lkMS9
	 KrVguEG4VYJGFpxhlDdAYi0tKc8achKOLwIzlUrlpWhF0FoBam8E+wcW4L+8vBRyJLBh5
	 RJuWnWfT581Ad+gF2CrmLCVkxLZx5P7MRGgWf3IExngp/0ivz7TkjNakN4Y1mfhGRWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=cfWwherg;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E9606A31C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 15:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F8E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=cfWwherg
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261109154426euoutp02d66d44b2ed53b47d12ab9a09543fa707~mauy_-1B02581825818euoutp02Y
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 15:44:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261109154426euoutp02d66d44b2ed53b47d12ab9a09543fa707~mauy_-1B02581825818euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794239066;
	bh=KeAlv0EKtTaDGrW0uWisjEOMXQElHFsb7+RWr717ehA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=cfWwherg5xV/imeqUEdIped3MaPG1NuUPvyBgrjFQB1oTqeOWq7cwJdirDBQIAJ9r
	 9B80VmYk9yQhj9eClieup3vi6TAxX4rUU1eruemkXI3rOzl9qPkEq4L6qnAmC5Tq+T
	 Q0OleEfl3fFvaIpTqHegraH4WmJks+hSX8fVao7c=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261109154426eucas1p28dad751a60e6a8cd490b178bbf0400fb~mauymrWwt2987329873eucas1p2O;
	Mon,  9 Nov 2026 15:44:26 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261109154425eusmtip193b43893c43c7e8e86cb65ae041eec36~mauyQBYnB0739507395eusmtip1G;
	Mon,  9 Nov 2026 15:44:25 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, David Rientjes <rientjes@google.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: [PATCH] dma-pool: decrypt pages before creating the shared remap
Date: Mon,  9 Nov 2026 16:44:01 +0100
Message-ID: <20261109154403.384434-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
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
X-CMS-MailID: 20261109154426eucas1p28dad751a60e6a8cd490b178bbf0400fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261109154426eucas1p28dad751a60e6a8cd490b178bbf0400fb
X-EPHeader: CA
X-CMS-RootMailID: 20261109154426eucas1p28dad751a60e6a8cd490b178bbf0400fb
References: <CGME20261109154426eucas1p28dad751a60e6a8cd490b178bbf0400fb@eucas1p2.samsung.com>

atomic_pool_expand() creates the pgprot_decrypted() remap of the pool
pages before calling set_memory_decrypted() on them. The error path
when gen_pool_add_virt() fails does the reverse: it re-encrypts the
pages and only then tears down the decrypted remap. In both cases there
is a window where a decrypted (shared) kernel mapping points at a page
that is still private, i.e. encrypted, to the guest.

dma_direct_alloc() gets this right: it converts the pages first, then
creates the remap, and on error removes the remap before re-encrypting.
Do the same in atomic_pool_expand(). The pages are now converted before
arch_dma_prep_coherent() and the remap, and the error path unwinds in
reverse order.

If set_memory_decrypted() fails, the page state is unknown, so the
pages are still leaked rather than freed. No remap exists at that point
any more, so nothing else needs to be undone.

Closes: https://sashiko.dev/#/bug/linux-9212d9b5-4a56-43e2-bc00-6e69b724078b
Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
The patch was prepared with LLM assistance.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 kernel/dma/pool.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 381b3cb28368..3c67728a2471 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -106,6 +106,17 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	if (!page)
 		goto out;
 
+	/*
+	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
+	 * shrink so no re-encryption occurs in dma_direct_free().
+	 */
+	if (dma_pool->cc_shared) {
+		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
+					   1 << order);
+		if (ret)
+			goto out;
+	}
+
 	arch_dma_prep_coherent(page, pool_size);
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
@@ -117,41 +128,27 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	addr = dma_common_contiguous_remap(page, pool_size, prot,
 			__builtin_return_address(0));
 	if (!addr)
-		goto free_page;
+		goto encrypt_pages;
 #else
 	addr = page_to_virt(page);
 #endif
-	/*
-	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
-	 * shrink so no re-encryption occurs in dma_direct_free().
-	 */
-	if (dma_pool->cc_shared) {
-		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
-					   1 << order);
-		if (ret) {
-			leak_pages = true;
-			goto remove_mapping;
-		}
-	}
-
 	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
 				page_to_phys(page), pool_size, NUMA_NO_NODE);
 	if (ret)
-		goto encrypt_mapping;
+		goto remove_mapping;
 
 	dma_atomic_pool_size_add(gfp, pool_size);
 	return 0;
 
-encrypt_mapping:
-	if (dma_pool->cc_shared &&
-	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
-		leak_pages = true;
-
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
-free_page:
+encrypt_pages:
 #endif
+	if (dma_pool->cc_shared &&
+	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
+		leak_pages = true;
+
 	if (!leak_pages &&
 	    !dma_release_from_contiguous(NULL, page, 1 << order))
 		__free_pages(page, order);
-- 
2.43.0

