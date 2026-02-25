Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452E3E9587;
	Wed, 25 Feb 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037732; cv=none; b=bdlE0vfnMcAVl2JLosKsR5aAE8kpJHKswo7kHy+0xJcqa2kZuOJ+LTMviI8Z8NsKNPOYZ0B7aGOxKi9pU9GPAi2wQMK3lTuZGnB1plfit04wHVhz9UZSZMnqThP9RsMTh0qRvDEXuUUytQS86JJRHXlSK30HqUqlzp2wbznUg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037732; c=relaxed/simple;
	bh=5eRES9IJzrhq6zmZepgudykCny//SFXm37BLxrFr738=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAwOGb6gN5pdg7SZ05OH7THhDyuvkohdwBqf2a6aCAY1I8qyred5Ccgx2Bon8uxDm1xof4mVoafvh5spREjROulKDLZQgEk8HVB+h+N2zVpOEV6Pbu/SG9/HcIDa9jVS4OiUbqxirNyZnzb5FJgJ30of+Bk8TnecOgy4vVmENIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaWdSdqJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaWdSdqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909BEC2BC87;
	Wed, 25 Feb 2026 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772037732;
	bh=5eRES9IJzrhq6zmZepgudykCny//SFXm37BLxrFr738=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gaWdSdqJyk2rfO6R2i/Rq4sZfKC56WS1WM40M314C2+MoUqCykXKONzIZmhjmX93J
	 A+uAsrfN1mLpl+PeVLbATaGnWena2lmfuRS9bevZN1n8GBXvtWxNX68KGx7XqJUXSj
	 kVPdOYauJvjgcRHZvyJp7m4nobJIz1i7KmEo3BBCda4nKwi0Txy5KB5966/jVKVV3C
	 pNGpsdPDFU/kbF+RG7FhZmFiu85dNOMRrGowNJU5+totaLK3gA1KjJo9Ikg/rA0eHx
	 451KMUgszIHvYsQoByint44EISSPFCrbWNXQs3e1Fu+2RUhYE9lYMvJcZ2XAaRrZ/Z
	 MZqdN5+gmhVEg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 25 Feb 2026 17:41:53 +0100
Subject: [PATCH 5/7] dma-buf: heaps: Export mem_accounting parameter
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-dma-buf-heaps-as-modules-v1-5-2109225a090d@kernel.org>
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5eRES9IJzrhq6zmZepgudykCny//SFXm37BLxrFr738=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnz1QJa+s1ijMu9+XLnvVgTuiJkztL1Ez9dZDkl5cDWk
 uK4bEZ2x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIsC9jw67djtzh+g/PW7+c
 7bqE8dPDGKW25vm1uY+33phvn1UoHTSLfwWr0ad4br1M7cmxDRrOjHW2j3pqNeyurbWr/6Sy6zj
 r29och4ufjLuCl1QyX7+l6Tb7rCHTsYlpSt+sIisF3lQdygMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The mem_accounting kernel parameter is used by heaps to know if they
should account allocations in their respective cgroup controllers.

Since we're going to allow heaps to compile as modules, we need to
export that variable.

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

