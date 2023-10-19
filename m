Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CD2747A
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocXti95o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF50DC433C9;
	Thu, 19 Oct 2023 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697729160;
	bh=P4b6wsJEKT/3IXcqFp8KjGqq8Imdm8sdVfTi6RWsVXU=;
	h=Subject:From:Cc:Date:In-Reply-To:References:From;
	b=ocXti95o34TJcUGQJjL1VTemEZSTo7XFgSL9x327zb9g4/KyKjKuQOJJN4iN+Vlw2
	 +93yWadJ4LZ+Ew2TmR5EjM5PLLWjPsBAzXuxNTn+B0xKRkNPM2f4VYMFAqy/IW9Vq7
	 0UkS+Et/KQ1C76yEgXV3hkMgM6Ko3kSzw5uyNfwt4AUGf+A6rRF2UOQFfl05a2d1It
	 IbHjj7se3QfzvuzXk5QhkSbwRSRL6M38+qrn63gt4BT71WUDx+RofV2BD/iXCCPX+5
	 itWEmX8gSsYXDHnHzARYHMGi6XuQOFTP4yixh5fOkdtYTZ9vd9N+yk2aXXmxrZSGqa
	 sgDSxnS0Lev2Q==
Subject: [PATCH RFC 4/9] mm: kmsan: Add support for DMA mapping bio_vec arrays
From: Chuck Lever <cel@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, iommu@lists.linux.dev, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 19 Oct 2023 11:25:58 -0400
Message-ID: 
 <169772915869.5232.9306605321315591579.stgit@klimt.1015granger.net>
In-Reply-To: 
 <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
References: 
 <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Cc: Alexander Potapenko <glider@google.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Cc: iommu@lists.linux.dev
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/kmsan.h |   20 ++++++++++++++++++++
 mm/kmsan/hooks.c      |   13 +++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index e0c23a32cdf0..36c581a18b30 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -18,6 +18,7 @@ struct page;
 struct kmem_cache;
 struct task_struct;
 struct scatterlist;
+struct bio_vec;
 struct urb;
 
 #ifdef CONFIG_KMSAN
@@ -209,6 +210,20 @@ void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
 void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir);
 
+/**
+ * kmsan_handle_dma_bvecs() - Handle a DMA transfer using bio_vec array.
+ * @bvecs: bio_vec array holding DMA buffers.
+ * @nents: number of scatterlist entries.
+ * @dir:   one of possible dma_data_direction values.
+ *
+ * Depending on @direction, KMSAN:
+ * * checks the buffers in the bio_vec array, if they are copied to device;
+ * * initializes the buffers, if they are copied from device;
+ * * does both, if this is a DMA_BIDIRECTIONAL transfer.
+ */
+void kmsan_handle_dma_bvecs(struct bio_vec *bv, int nents,
+			    enum dma_data_direction dir);
+
 /**
  * kmsan_handle_urb() - Handle a USB data transfer.
  * @urb:    struct urb pointer.
@@ -321,6 +336,11 @@ static inline void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 {
 }
 
+static inline void kmsan_handle_dma_bvecs(struct bio_vec *bv, int nents,
+					  enum dma_data_direction dir)
+{
+}
+
 static inline void kmsan_handle_urb(const struct urb *urb, bool is_out)
 {
 }
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 5d6e2dee5692..87846011c9bd 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -358,6 +358,19 @@ void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 				 dir);
 }
 
+void kmsan_handle_dma_bvecs(struct bio_vec *bvecs, int nents,
+			    enum dma_data_direction dir)
+{
+	struct bio_vec *item;
+	int i;
+
+	for (i = 0; i < nents; i++) {
+		item = &bvecs[i];
+		kmsan_handle_dma(bv_page(item), item->bv_offset, item->bv_len,
+				 dir);
+	}
+}
+
 /* Functions from kmsan-checks.h follow. */
 void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 {


