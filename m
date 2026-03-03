Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3F39B96A;
	Tue,  3 Mar 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532818; cv=none; b=C6wqgIESBlmTGHGOBTH3h/ynL/5fC7naWWDp00nbgs4pV3m0hU3yz/+vwMn837K1iFwoPcIs960UJSAYzHysUpg8FPa8ucTrv1q8kwxV0OLn166CAJvjzc6G1Rj5AXBIMXXGuQvAIto14FfJ40u23kZLcnBFf1gnay9mZn3/heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532818; c=relaxed/simple;
	bh=lO+1PMKRSkJNghp2Ly48vsH4KqRxHWKQohidvl/pe2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQj1IPuOW/+7LAsIzey20GQXKhdg5rrQR6gpQumiBk2eTJ/8LAVsgnyYXVg3eDqItwR8BgNTah4fLLVcYgH9btwpc5/DnC6MnE9zpWogOktBbY1iCrGiC5kuJF0fhrz3wQuXfVa1M3lDxJjxMk3LtHBXaMZwm3ayzte+i6rc82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig/bQomu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig/bQomu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FCFC2BC87;
	Tue,  3 Mar 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532818;
	bh=lO+1PMKRSkJNghp2Ly48vsH4KqRxHWKQohidvl/pe2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ig/bQomueXUc216uzemyo2U7Bbfzhcnc5nCEskK/mHG1BNSkp3GNVKQcUoQF5QbIs
	 3Ql14c7EzyAwIOLpNgE4RVLoyqF/JkOXcKr/QFwizysU/w7EMn4z9bPzaPwAzstxwA
	 qMrhWoIKGCrBkZJD+FuOR1K3Y02+jGyn13qfMo5Xb2VgJnvXinZWmgj4b++CO37Pgh
	 yo548YffVMv7oJbhtPYd/f+5y5R8sQgYxKJtoIuANg+MX9pwblSdpNvzWQ3qUhezm3
	 9yu90bIGAySB/Mh5tSVxPLc+Lt5oM+5mpj/Opk08gXnc1NdLEqAbSjMbSCRoX8FJ1R
	 TwqT6cZiYZ5oA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 03 Mar 2026 11:13:10 +0100
Subject: [PATCH v3 7/8] dma-buf: heaps: cma: Turn the heap into a module
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-dma-buf-heaps-as-modules-v3-7-24344812c707@kernel.org>
References: <20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org>
In-Reply-To: <20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lO+1PMKRSkJNghp2Ly48vsH4KqRxHWKQohidvl/pe2Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnLtphp/tk9K/m380aGhrutlZoh089yhxn5CWXlbGD3E
 ntoFVfbMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZyYCpjw96X696qrNmY0KzK
 lFh940Fc/q33m61bV6u/3VdYf+pliXaje4peib7Al+5/W58s2c2VyVhn8nfape47nK3J9Qv+sqe
 qN1urnd+w8b5he5eljsLOoJMfZbUsXh+WY/u3tvRlQu/97fsB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Now that all the symbols used by the CMA heap are exported, turning the
CMA heap into a module becomes pretty easy: we just need to add the
usual MODULE_* macros, import the proper namespaces and change the
Kconfig symbol to a tristate.

This heap won't be able to unload though, since we're missing a lot of
infrastructure to make it safe.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/dma-buf/heaps/Kconfig    | 2 +-
 drivers/dma-buf/heaps/cma_heap.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index a5eef06c422644e8aadaf5aff2bd9a33c49c1ba3..aed0b9b4febf388376cfc41be9843980d010c4e8 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -4,11 +4,11 @@ config DMABUF_HEAPS_SYSTEM
 	help
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
 
 config DMABUF_HEAPS_CMA
-	bool "DMA-BUF CMA Heap"
+	tristate "DMA-BUF CMA Heap"
 	depends on DMABUF_HEAPS && DMA_CMA
 	help
 	  Choose this option to enable dma-buf CMA heap. This heap is backed
 	  by the Contiguous Memory Allocator (CMA). If your system has these
 	  regions, you should say Y here.
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index f8a3d87f3ccee9630383ba28502eb40b10671cc2..7216a14262b04bb6130ddf26b7d009f7d15b03fd 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -422,5 +422,8 @@ static int __init add_cma_heaps(void)
 
 	return 0;
 }
 module_init(add_cma_heaps);
 MODULE_DESCRIPTION("DMA-BUF CMA Heap");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("DMA_BUF");
+MODULE_IMPORT_NS("DMA_BUF_HEAP");

-- 
2.53.0

