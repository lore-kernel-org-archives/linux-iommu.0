Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59743988FF;
	Tue,  3 Mar 2026 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532805; cv=none; b=QgjHd/wzdULymJXSeaoxibCA8PLhhgWM3A/tJwQwoyTi53v5kteEeS88o1NoRv2xGx6AIq0Ehg0RLzdwHZi0gFYfivm2xshQ4cLMgiwRWA1jzzPTxYjeM0rfp+EZWDV17vwFCKLPVegeEyuSD5EnZZIVTQP9HGxmyC7X/IBOjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532805; c=relaxed/simple;
	bh=/kD6F1ZhpnmLA/clOq4s+dTJhu8QKey3+LKztnUIF5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5II3E4/qwxfl6NZx8oFyErLb0/dXfamCC52gBUW5Wy6i0b2odG8gBhm3VlsWRmEFRm1YCdmZxl3vj5MMJ41/2qJORXDn3JLpO+tJVb726a3ewImZbvajKOlui/O0qaIKyG+NBGYSFNrVhQtnBS2v0Ve6Bhf+XfwxTIGkrJByeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYrAVUhL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYrAVUhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10289C2BC87;
	Tue,  3 Mar 2026 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532805;
	bh=/kD6F1ZhpnmLA/clOq4s+dTJhu8QKey3+LKztnUIF5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CYrAVUhLcajw0Hs2gmC7vITgu9E3uQi3s+JDHWTE6IMBijS9oIioAh8MReB57fC+W
	 VBChglhx2cEWfjmxfPe2urdQuwHQugtQBgVSXl9cM4LdoUzSuQA4ChjI//qRcD/PsX
	 V+jZC4Dnz3MDiWQoEBHOVX+Bp/UEkLDaun9hnvQGs02U5arp2Q7TJS6eLMBi3T+vDa
	 OJmT5m9BSWcj/GsWoTf4hjEEmJv4beLLwIqspBL1rM4HIkTxa6s/VR4P1wgB8psaZI
	 apERoK/GEY0CTLHnMFT6kxxP3t3P7GGKapmnVrC/5uxyo9ZihIQC1hN0ShuAeGScLH
	 fhl/wWxSiFjlw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 03 Mar 2026 11:13:06 +0100
Subject: [PATCH v3 3/8] dma: contiguous: Make dma_contiguous_default_area
 static
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-dma-buf-heaps-as-modules-v3-3-24344812c707@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/kD6F1ZhpnmLA/clOq4s+dTJhu8QKey3+LKztnUIF5o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnLtpg++eZieDDufVSmyImd5x7eO7LSXnZ2kGrvloxHM
 7ou7txV2jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAm4hzNWB/txW9UyDu53uyb
 8NtD5exPzyyeJvI323Hl6r/5Z7PtXq1IDovoS8yS+fow87/PHIZ9hxkb7sp+WsI9Ked2lzTPDrH
 PlWdO3I3//IerfdJsgyt/VofN3JTl/Osgc/58+ZMub3YovPj8DAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Now that dev_get_cma_area() is no longer inline, we don't have any user
of dma_contiguous_default_area() outside of contiguous.c so we can make
it static.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/linux/dma-map-ops.h | 2 --
 kernel/dma/contiguous.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 6b8e6a2a08e2cb380de764bd6cacb2cb24c22871..94fbf16646c105fa2e1d34d407a830bf989d4fc8 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -89,12 +89,10 @@ static inline void set_dma_ops(struct device *dev,
 {
 }
 #endif /* CONFIG_ARCH_HAS_DMA_OPS */
 
 #ifdef CONFIG_DMA_CMA
-extern struct cma *dma_contiguous_default_area;
-
 struct cma *dev_get_cma_area(struct device *dev);
 
 void dma_contiguous_reserve(phys_addr_t addr_limit);
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 		phys_addr_t limit, struct cma **res_cma, bool fixed);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 9a9ed7248fb823105609c5db5a51113e54a40192..a4279d800d4658bf1c33b9b1da100eee1367d42f 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -51,11 +51,11 @@
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
 #else
 #define CMA_SIZE_MBYTES 0
 #endif
 
-struct cma *dma_contiguous_default_area;
+static struct cma *dma_contiguous_default_area;
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
  * This is useful mainly for distro maintainers to create a kernel
  * that works correctly for most supported systems.

-- 
2.53.0

