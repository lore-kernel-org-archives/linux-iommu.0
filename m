Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C37231836;
	Fri, 27 Feb 2026 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198622; cv=none; b=MAnqzxEMVR6ew3tBPJh51y4L6fnckw4mOnRPDh6y673BgZxV0zvOZwn5Cb28UQufiB2BBC6qVYwQlToAvyb7yv3WMc56jw3XivTOq4PoTLJ6zPYVJQ3PdMYtNKIBdnaUEjAygZN28WNoZrLvIr4iN2EVomvm/h/C0uS2G81bYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198622; c=relaxed/simple;
	bh=oNUPt44D7xewgXiELSrkzONvN2UIFpJB+B1908QRT5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTiEKcDmvH3gLMjLba4r0eKFQfT9WD5+nJHacCg1hyKrL6WFrZEwi8iU/OTSEJXsw4FcZVS15wlpsxOZmDfsCbpvcKmwB7jCPreiNeqX/2s35Yebh11xf3X5Xmeg+wbj62wnVpIx8g6XSKX6E1i4CYx3KlFGvdRpPh0pWlPg4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4LEoRTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4LEoRTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B045C19423;
	Fri, 27 Feb 2026 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198622;
	bh=oNUPt44D7xewgXiELSrkzONvN2UIFpJB+B1908QRT5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B4LEoRTuHmJOdNmQe2bAIpTovkzz+vV6SAtOec89drMCy23iGzr9QuUQY90JsnRVD
	 CJdUJ0W1oXTKFOCST58+C6Y56A2ltlrbqlCTPWSlsipO1vvYzkozxDEJXOzh1o9R2z
	 /AY4Mq7O2Zam7wrDbiUhvWz750dLAJo+fONPrFFO2CMrcPSL7inQrR2l7BxOz4Ke/I
	 ybjiA4yI3xDfbKGteRchTz4I3SbHm+g0K+hUy4+GTxBholQEeXptVvlCCv9K7uwiwt
	 ylTfvfnI+QbMYWT26sOSWsAEGV2RcMgHgm1vgp+Mbd5T//NOwKdDU6EDr9q4Nh6Hp8
	 IQZK3YvE2AKBA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Feb 2026 14:15:48 +0100
Subject: [PATCH v2 9/9] dma-buf: heaps: system: Turn the heap into a module
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-dma-buf-heaps-as-modules-v2-9-454aee7e06cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=mripard@kernel.org;
 h=from:subject:message-id; bh=oNUPt44D7xewgXiELSrkzONvN2UIFpJB+B1908QRT5k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkLZ+0WkkzIaZ7AEu++epl1YJcfp6tA5eeDsQcO/e14P
 5PtauSkjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRz88Y6wOci1V2slgKrp6p
 6hWkevoO57LE4/etK8+tNJYXzX/zb+GCrK/q/odu3diy8djjVHvNy4z1TrNqTjNKGR2+x/BUwb2
 9vNPvratzb9V1he5Z+TzTVUotd8rOuj1vU6uDgIeJisi7d58B
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The system heap can be easily turned into a module by adding the usual
MODULE_* macros, importing the proper namespaces and changing the
Kconfig symbol to a tristate.

This heap won't be able to unload though, since we're missing a lot of
infrastructure to make it safe.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/dma-buf/heaps/Kconfig       | 2 +-
 drivers/dma-buf/heaps/system_heap.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index aed0b9b4febf388376cfc41be9843980d010c4e8..e273fb18feca091ccd9b406e68f86c12efb339e9 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -1,7 +1,7 @@
 config DMABUF_HEAPS_SYSTEM
-	bool "DMA-BUF System Heap"
+	tristate "DMA-BUF System Heap"
 	depends on DMABUF_HEAPS
 	help
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
 
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index b3650d8fd6511a4a755612cfe3a9d9fee796f80e..1957403b0f2ae5e82ab39f5945dfe82808e93964 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -442,5 +442,10 @@ static int __init system_heap_create(void)
 		return PTR_ERR(sys_heap);
 
 	return 0;
 }
 module_init(system_heap_create);
+
+MODULE_DESCRIPTION("DMA-BUF System Heap");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("DMA_BUF");
+MODULE_IMPORT_NS("DMA_BUF_HEAP");

-- 
2.53.0

