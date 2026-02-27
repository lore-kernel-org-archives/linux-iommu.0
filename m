Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835BD17B506;
	Fri, 27 Feb 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198603; cv=none; b=SSlXOmV8YWY3oXAJ3bG+ZA4LgW1CtDLvLs4EHL7P4DhLzYVtgXS7hoSPf5iw2ujL0oSSte1yIKEu/hSGm+Dq1JAqHmX2GBZ81yDrzKjC8bAlAjZPYjxnFUtv1N0V9U9Wc+MgZhfE2fGOG2jQPsYAzn8gLo+czT3kzIMO+vv+xuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198603; c=relaxed/simple;
	bh=ecBBNr07Tr5A8D/sRSoG9EjORGZ7DumNUTGgwyKHMSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4QVnA+wWGIbZW+JVt2v0iXdSM2JB5MySOLU/rbJT/g7OpNeHwh4l401yYhbb9Wr5WCGPHhwnQIxVg+XdZ/pzZT+5tmxhQrCdx8hdNYtoGWD1TnPWybAX+p9UbHSvCAWw2iHDLikhAZjeMN3XxHHAyTpCmHRo9SDRbLN8uSuVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/XIt2WI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/XIt2WI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A23EC19423;
	Fri, 27 Feb 2026 13:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198602;
	bh=ecBBNr07Tr5A8D/sRSoG9EjORGZ7DumNUTGgwyKHMSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P/XIt2WI/WidM++Hn39WGIZWA7aWF12X5bGXmPZqw+SFEh7isAmWCC3IqBpF5zrke
	 i0SFNqaKfpB8UymBOh0q5A7MCmkFKYu6JfKvR20UgV9mM/3zK9TgVr1+8BhM365GHE
	 Ehzws1hufeCM/uQQx3uoNxZ+yrLLzIlDrrCK2kDR6mckl6dyxG9I+vqI4BmjjCRLZw
	 Kmm2lEmuHqKhynAXUw5231JvjEwVJhlCMv+K7zQg6/KXBSI1NErnHsMxEsyYeiZ/iB
	 o2zGFJGd4irX/x0j4btOyS4z0j11JSg7seHNwhBkmnH5iM2m2MhDpPpWX5qy68FNHv
	 56c+LQhawGnbQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Feb 2026 14:15:41 +0100
Subject: [PATCH v2 2/9] dma: contiguous: Make dev_get_cma_area() a proper
 function
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-dma-buf-heaps-as-modules-v2-2-454aee7e06cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ecBBNr07Tr5A8D/sRSoG9EjORGZ7DumNUTGgwyKHMSU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkLZ+244WWftFg15Nznw5MXh/93WaX5OcMif+a2y8qp9
 zhDXyd/75jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATidnJWMl4SPHI5Is6cRnF
 2vtyzyVbt0rVvbi56vAD1WNcqyx2ttY8FN7340HzyWeFR0L9DS+UiDPWmX+c8Fhq3+e5dYun9+7
 RjYhtOiwpPD/lnkhEadFJ6es8y1uUuI4ErhWblnSFsXPG2k9dAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

As we try to enable dma-buf heaps, and the CMA one in particular, to
compile as modules, we need to export dev_get_cma_area(). It's currently
implemented as an inline function that returns either the content of
device->cma_area or dma_contiguous_default_area.

Thus, it means we need to export dma_contiguous_default_area, which
isn't really something we want any module to have access to.

Instead, let's make dev_get_cma_area() a proper function we will be able
to export so we can avoid exporting dma_contiguous_default_area.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/linux/dma-map-ops.h | 7 +------
 kernel/dma/contiguous.c     | 8 ++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 3007c68a8ec5b85990d1938d04a2f05c1a71acdb..dc7d54ac5dd66bd22ef868d7894cc1cb2ee4c156 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -91,16 +91,11 @@ static inline void set_dma_ops(struct device *dev,
 #endif /* CONFIG_ARCH_HAS_DMA_OPS */
 
 #ifdef CONFIG_DMA_CMA
 extern struct cma *dma_contiguous_default_area;
 
-static inline struct cma *dev_get_cma_area(struct device *dev)
-{
-	if (dev && dev->cma_area)
-		return dev->cma_area;
-	return dma_contiguous_default_area;
-}
+struct cma *dev_get_cma_area(struct device *dev);
 
 void dma_contiguous_reserve(phys_addr_t addr_limit);
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 		phys_addr_t limit, struct cma **res_cma, bool fixed);
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 14bd54fb758537f01a6fe27318e7b683964e20b1..9a9ed7248fb823105609c5db5a51113e54a40192 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -99,10 +99,18 @@ early_param("cma", early_cma);
 bool __init cma_skip_dt_default_reserved_mem(void)
 {
 	return size_cmdline != -1;
 }
 
+struct cma *dev_get_cma_area(struct device *dev)
+{
+	if (dev && dev->cma_area)
+		return dev->cma_area;
+
+	return dma_contiguous_default_area;
+}
+
 #ifdef CONFIG_DMA_NUMA_CMA
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
 static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];

-- 
2.53.0

