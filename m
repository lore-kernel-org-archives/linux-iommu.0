Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397C22B8C5;
	Fri, 27 Feb 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198617; cv=none; b=DrwjUTdzu8qCYlnK82AJrjDbMO/Y0h0QPip3UT6xsbu8ag5mcnE8Omz78Hg5+ZLOISodzEzgdGlvx/lOCN9br7EK/jrO+gKuHuzANnPCaNJVZKHecxDu7zlU3c+M4ryzAdFpH+JhUheOGHJSlpE4zDVAZ53+SZRw1CgjoivlppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198617; c=relaxed/simple;
	bh=uocFqI6buKhD72I9T9guormXJl46wyFDpX9g7jostug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAHEdx8LxDMepyRJCwbpB8axXxo9ngw5SoJ7PeKw53XfNUhGr815PtpTThIp8b0n4VosrP+Qi9THWAhfZaPrKd4/LUpGck+sNc/7Jpg/KY8LAeRk5HHqeMoLUvhv/vtNj1TivB29OhWXfTkArfYLpo+HPN4ElDTff7MEe+LhmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecpMkkuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecpMkkuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C2BC19423;
	Fri, 27 Feb 2026 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198617;
	bh=uocFqI6buKhD72I9T9guormXJl46wyFDpX9g7jostug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ecpMkkuUspj/gJIru8op3fzbNPWELjGitExJdq/w7/qfHqcC4CNuEzgaZG1stLgsv
	 79jSbCbuKccznKaAR8fVwA+5q18KVaVRgEj/aeOcOdyyLL+NhD6m6mYTCJFWFAQNRo
	 vs+L46uRiOU83XtQHbHdgb9QML4jqT7c6Gmtv/2R+2EOz7Al2pWMMWX+RIZGIaxUBd
	 24FDoKikk7LdLS2jiTvt1niMukJYZND8Tn9IKZwMB/1rlQjAUn43JA/TlZ59izSgwt
	 szKjgxFMFue/OWXvQFcXJDIEgTH/j1TzFqK1uX/VEqrJDchUSR8dr8Ue7EoiQ1NWsh
	 EY5BIZT8ta9jg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Feb 2026 14:15:46 +0100
Subject: [PATCH v2 7/9] dma-buf: heaps: Export mem_accounting parameter
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-dma-buf-heaps-as-modules-v2-7-454aee7e06cc@kernel.org>
References: <20260227-dma-buf-heaps-as-modules-v2-0-454aee7e06cc@kernel.org>
In-Reply-To: <20260227-dma-buf-heaps-as-modules-v2-0-454aee7e06cc@kernel.org>
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
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-mm@kvack.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uocFqI6buKhD72I9T9guormXJl46wyFDpX9g7jostug=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkLZ+2Ki8n9kLHCV18veOuNicIeLwMiOv1Xl98WSn+67
 XbO1WzxjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRLSGMDQes1d02GbyXm2tv
 IRfKObu+Z/vdzpO2tZYbUsPeRFvGnJm3MG3Cntl63Fpl+vkr2NafZmz4J25xLKUpJWdzkeDfwk8
 NO842Hvv6WLVwotMLn80bM75ahwjp36jZG2z8xefg4Y8x9x8CAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The mem_accounting kernel parameter is used by heaps to know if they
should account allocations in their respective cgroup controllers.

Since we're going to allow heaps to compile as modules, we need to
export that variable.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/dma-buf/dma-heap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index ac5f8685a649496c0e1c6decbf263b63fa472d04..a76bf3f8b071a3d5bf39a8513f31e9e8aa16e02f 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -51,10 +51,11 @@ static DEFINE_XARRAY_ALLOC(dma_heap_minors);
 
 bool __read_mostly mem_accounting;
 module_param(mem_accounting, bool, 0444);
 MODULE_PARM_DESC(mem_accounting,
 		 "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
+EXPORT_SYMBOL_NS_GPL(mem_accounting, "DMA_BUF_HEAP");
 
 static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
 				 u32 fd_flags,
 				 u64 heap_flags)
 {

-- 
2.53.0

