Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CCA3E9F83;
	Wed, 25 Feb 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037735; cv=none; b=UWAC2qMGr4pMLfKOex1MTSj4ogsi+33LWYlsGY5nv20bJSXtaDobCtUJjXnO95TRraj7rBNLqHzihofNRyM/BR7D0tDUWGporKuhcHUjedwbJUKLUdhguq+iBzifvZvXBJkpFMl9PcpbrI1HAbJ6wwLlku+O/cLn5Uiz3sqRH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037735; c=relaxed/simple;
	bh=3ZfbgvU0bLE1CVEwtquKpm5fJ/GAe/ZRFRUG6VZuG1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEo/srsiyCTCb60WzRA32WSt6P/NHninw6BdLEpF+PDF2yrOiStiYlv1tjs6UeeBLyqci1rZjJJNEeTDEZ9pOWeTV7/Mvqbe/DoAwk//qQpg3+51c+bdAQOy/UmfRIZE/EHXWGqEHJPZPMzTEV2TIt13Rbrim7pCCKw5ShhHopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJjXalcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJjXalcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA1C4AF09;
	Wed, 25 Feb 2026 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772037735;
	bh=3ZfbgvU0bLE1CVEwtquKpm5fJ/GAe/ZRFRUG6VZuG1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JJjXalcpzSXkoB8Ni6wXiA74nEozWfroeKtL3vmqR4UqYOo/GcDZDki+80Li66fYn
	 eVW7TpKCNM4iPWL2SI1WaqFEI4SwYL3ysjpyCDfevFNH1iInAX9H0TLdwE2ndJTOD6
	 +Jkt42XG9qMd9WbqYVRZBzGFroRI69Dg0lBUpXfNLu3WUa1rNdAeFwU54cjsIs6cSd
	 mY4DQyX3STn0GSOGy8mzvoCTEN+0PdeVY/IFhh/amLXAnUhN71S5sAp6kYUEPbv5Se
	 fRM9FhO8Vne2ZvCdJSwPq03WOtZLXoTicIHabtEZO6+3kdhxJnq/tZOd35mKRSQ+W1
	 8e59vjrE4dMBw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 25 Feb 2026 17:41:54 +0100
Subject: [PATCH 6/7] dma-buf: heaps: cma: Turn the heap into a module
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-dma-buf-heaps-as-modules-v1-6-2109225a090d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3ZfbgvU0bLE1CVEwtquKpm5fJ/GAe/ZRFRUG6VZuG1I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnz1QIO/V0Qvq7+gY3Smi9WgS+77V5drTja5fcquX264
 6WP/+4v6pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATsdnJ2PCBec+iTTaurZdr
 pxmZLRZ0bc2a2vjh6BruogWL59UqHHxRNL90xZrM6OUBz0U5n1tqZzDW8MdcrC8XZLjRI5E8Pe7
 bRnXnRdumapw5Xmj0P36JqsoGlYK2u9UFipMWTjHtM3+3Y3sRAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Now that all the symbols used by the CMA heap are exported, turning the
CMA heap into a module becomes pretty easy: we just need to add the
usual MODULE_* macros, import the proper namespaces and change the
Kconfig symbol to a tristate.

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

