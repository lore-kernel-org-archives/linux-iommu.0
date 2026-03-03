Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF383112AD;
	Tue,  3 Mar 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532809; cv=none; b=Ux+WbMtdIA4bwYYNlpbYSGk2lxIy7LDYjMthM8oeOGPnb2XuKDAF4CvHl8bUhC6Z8j+nbfVVi1OjY07aTGXCa4XVrM6w597870rh4EKa3hJKaG+1Qrm1aqL3eb4aUJalIADVcAFN6SJ86/T2J9G6gppM9gqn9MxZ764scFu92MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532809; c=relaxed/simple;
	bh=0cHZ5LTDrjAloaUBF1Lu8YxebKzlQ2YWzvzsPNmbff4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BphOSzHB6iIVIGGAG3ZNfM1YBN2ZvEgzO3a9Gfd/w8yWBWh+/N+SUeesX+FKOQca0hSiQMQ9N6Ksl+Cc5I7XqQRObUVahi9sQ6e1OMWBliLlgshOhcBPaX9Gv4IVyVvsVnCP+pwe8zB/A1yTZOKlalN6ORrc0HmOqeKo2gLkFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhiXIqIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhiXIqIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E906FC116C6;
	Tue,  3 Mar 2026 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532809;
	bh=0cHZ5LTDrjAloaUBF1Lu8YxebKzlQ2YWzvzsPNmbff4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GhiXIqIFH0pFdYOVF4v4vn3elAc684typ5RQw/1l4WLHgkKnANNAhTHgTa3ZCshI3
	 IrWaY8DZnVM0Oimi0CVwPTFymDhv2Yy4FSm4OiqnjTt6tanBc4J/pHsTGVGjtlhPkj
	 gnM2J+eS8+Ekvz4itIaa27OozlW4J+QHuGWCq1oRv+S/c1vI/k3uMlyGh6CSQLFtNI
	 LfHn5u2j7yXmci2q+10ex5iIsC4GlWch4cZ9SL/aK0jiLFQEv2ODRZgl/BP8XCsR8q
	 Oo7ncNQwHpA2Yqi0w5i2xVC8aU/v0Z7+pp2C25p48QE1sOZsJyhEn8FGVBD+4J8jw0
	 QAY9Syplot4RQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 03 Mar 2026 11:13:07 +0100
Subject: [PATCH v3 4/8] dma: contiguous: Export dev_get_cma_area()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-dma-buf-heaps-as-modules-v3-4-24344812c707@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0cHZ5LTDrjAloaUBF1Lu8YxebKzlQ2YWzvzsPNmbff4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnLtpj+rwkN3X/RpsuSU2dZw8NGZodEu44ndV5bp/3o/
 35Koc+hYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkpDxjw9e/Pz8anKhvkrF8
 sNnTxsdyWoBDzfXAqfzWaRYfNtt5fPuXZFtreMhjzyq+ULZqxaZ7jA0TT9p3q2TbaX26JehvL3n
 nmvPl+QkR19KKX7fc8uiSFT6342m2tU9zoP2FdxcjxXo3SAEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The CMA dma-buf heap uses the dev_get_cma_area() function to retrieve
the default contiguous area.

Now that this function is no longer inlined, and since we want to turn
the CMA heap into a module, let's export it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 kernel/dma/contiguous.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index a4279d800d4658bf1c33b9b1da100eee1367d42f..ad50512d71d3088a73e4b1ac02d6e6122374888e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -106,10 +106,11 @@ struct cma *dev_get_cma_area(struct device *dev)
 	if (dev && dev->cma_area)
 		return dev->cma_area;
 
 	return dma_contiguous_default_area;
 }
+EXPORT_SYMBOL_GPL(dev_get_cma_area);
 
 #ifdef CONFIG_DMA_NUMA_CMA
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;

-- 
2.53.0

