Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C252747A
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rswgT3Yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A56C433C7;
	Thu, 19 Oct 2023 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697729192;
	bh=78EBrsEYDbjqzKz6oikO8SaOCUrBd4svH1Rn6ZfGLCE=;
	h=Subject:From:Cc:Date:In-Reply-To:References:From;
	b=rswgT3YhnWkT3o0G6MojVzyCpe1SD39xHMrPipMZmSgVISLih5aNMWaWjg0idGwlR
	 wr1ngmFiei5XhT7c+Bu0NDL/fXh4/s7CIqIKFFPFWNoEYEuA8oQFX3jQ9CBPbBczrH
	 KX6RdenvTZNcABi7dkWPz+b61ZF7orVMEZSuh78HlmyDoT3ATBRLAiRnXOUlkXDbFu
	 qoskSLR5ffA7+QCiaPDrFep6sEAilcxP52iiAf6f4m0sON8DaScP9t0vKWNIYZNnSt
	 65qEPZJWJJZyZNDRRA4SThj1yBcY53wJs1tU1afsX5b6KqbKu+THc4hyXRfHqHjmnm
	 nqTECaowlRAmw==
Subject: [PATCH RFC 9/9] RDMA: Add helpers for DMA-mapping an array of
 bio_vecs
From: Chuck Lever <cel@kernel.org>
Cc: iommu@lists.linux.dev, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 19 Oct 2023 11:26:31 -0400
Message-ID: 
 <169772919129.5232.11342896871510148807.stgit@klimt.1015granger.net>
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

Cc: iommu@lists.linux.dev
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/rdma/ib_verbs.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 533ab92684d8..5e205fda90f9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4220,6 +4220,35 @@ static inline void ib_dma_unmap_sg(struct ib_device *dev,
 	ib_dma_unmap_sg_attrs(dev, sg, nents, direction, 0);
 }
 
+/**
+ * ib_dma_map_sg - Map an array of bio_vecs to DMA addresses
+ * @dev: The device for which the DMA addresses are to be created
+ * @bvecs: The array of bio_vec entries to map
+ * @nents: The number of entries in the array
+ * @direction: The direction of the DMA
+ */
+static inline int ib_dma_map_bvecs(struct ib_device *dev,
+				   struct bio_vec *bvecs, int nents,
+				   enum dma_data_direction direction)
+{
+	return dma_map_bvecs_attrs(dev->dma_device, bvecs, nents, direction, 0);
+}
+
+/**
+ * ib_dma_unmap_bvecs - Unmap a DMA-mapped bio_vec array
+ * @dev: The device for which the DMA addresses were created
+ * @bvecs: The array of bio_vec entries to unmap
+ * @nents: The number of entries in the array
+ * @direction: The direction of the DMA
+ */
+static inline void ib_dma_unmap_bvec(struct ib_device *dev,
+				     struct bio_vec *bvecs, int nents,
+				     enum dma_data_direction direction)
+{
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_bvecs_attrs(dev->dma_device, bvecs, nents, direction);
+}
+
 /**
  * ib_dma_max_seg_size - Return the size limit of a single DMA transfer
  * @dev: The device to query


