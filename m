Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C87F5
	for <iommu@lists.linux.dev>; Sat, 12 Nov 2022 04:04:58 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso6064042ybq.21
        for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 20:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s3sgmVlNCJPhymcazOWxttEdW083uKMqd63z0b1pzWw=;
        b=YWx26bIQpAnqqXnlRJ9bDLkeneEJfnzvCyvS6fyoFatJSsejPUfmU8e9QabCQQ2kMF
         heRK7H0ZUgYrekpr+f9xMZ2DbATYsyfwX++XaM+EZzpdT0QXHzYHo7juO+OO6fuhzvEo
         Tndb0wiaEdFajeyKCszx9Pun004j0gyxfpKDB3TET5YB3tynY/qNx3wSZvDita3RnNsV
         LHGyG21DytY6Vcfpkx3y3+h/76zRTwo6yjplsSVfHGavoNnLOW522BZ2z2jkn6yLyxi9
         TxoAjRb1fjC4UF9GxZznB4jZX9+D1Y1VlH78KVQG+O4sEMaRzuh7kYNuwcUILJQQpLNn
         KkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3sgmVlNCJPhymcazOWxttEdW083uKMqd63z0b1pzWw=;
        b=2oeBS3jU/PsQ/8lEm4b6/PkQr3tu0gcywszewiAjBsIdzxvb5ECYg0D9Z30UGA73/m
         NaQe5IhfxEoPxLCBb5vMfAG3Ru8toiYg5cn8MJ+e7WZdUKhcrTfhNFVN1OhXRiWMR9Va
         /QqgEiu0vWk5ciPYkM5g7Op0PmBRpatfE/dIWcGPg6u6kvPRki0BHHrW8u6xQS51tAf0
         1d3n+ueAHwjFAc3+vPLGVR8QjHC5Sh3K1ewsA9o5tsOM3E/6hN+Hy52aBI9wZWDELN++
         jbynACOt/fznBT/NFYPN+TeuUDyYwfA7ZJaDssfsJ7fZQxNt1RIVTIJQn1/SqBZxIei+
         uCRg==
X-Gm-Message-State: ACrzQf2JNEINz6heyXtwIjMV9Dgg2zob6Nu2BaP//NYc/yD+qFSIPoB+
	JIfeARvgbL20AeBTBbsGEbLV5xoMUOdWTg==
X-Google-Smtp-Source: AMsMyM5aW413wYUCK8QITgjM6Wv7c9MESFWak+wN0jT6UWWSBrvlI9bmSEF/OFOs3/KzbWZFwufBS/mRP2hw8Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:5d7:0:b0:367:300a:b24a with SMTP id
 206-20020a8105d7000000b00367300ab24amr65639715ywf.128.1668225897151; Fri, 11
 Nov 2022 20:04:57 -0800 (PST)
Date: Sat, 12 Nov 2022 04:04:52 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221112040452.644234-1-edumazet@google.com>
Subject: [PATCH -next] iommu/dma: avoid expensive indirect calls for sync operations
From: Eric Dumazet <edumazet@google.com>
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Quite often, NIC devices do not need dma_sync operations
on x86_64 at least.

Indeed, when dev_is_dma_coherent(dev) is true and
dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
and friends do nothing.

However, indirectly calling them when CONFIG_RETPOLINE=y
consumes about 10% of cycles on a cpu receiving packets
from softirq at ~100Gbit rate, as shown in [1]

Even if/when CONFIG_RETPOLINE is not set, there
is a cost of about 3%.

This patch adds a copy of iommu_dma_ops structure,
where sync_single_for_cpu, sync_single_for_device,
sync_sg_for_cpu and sync_sg_for_device are unset.

perf profile before the patch:

    18.53%  [kernel]       [k] gq_rx_skb
    14.77%  [kernel]       [k] napi_reuse_skb
     8.95%  [kernel]       [k] skb_release_data
     5.42%  [kernel]       [k] dev_gro_receive
     5.37%  [kernel]       [k] memcpy
<*>  5.26%  [kernel]       [k] iommu_dma_sync_sg_for_cpu
     4.78%  [kernel]       [k] tcp_gro_receive
<*>  4.42%  [kernel]       [k] iommu_dma_sync_sg_for_device
     4.12%  [kernel]       [k] ipv6_gro_receive
     3.65%  [kernel]       [k] gq_pool_get
     3.25%  [kernel]       [k] skb_gro_receive
     2.07%  [kernel]       [k] napi_gro_frags
     1.98%  [kernel]       [k] tcp6_gro_receive
     1.27%  [kernel]       [k] gq_rx_prep_buffers
     1.18%  [kernel]       [k] gq_rx_napi_handler
     0.99%  [kernel]       [k] csum_partial
     0.74%  [kernel]       [k] csum_ipv6_magic
     0.72%  [kernel]       [k] free_pcp_prepare
     0.60%  [kernel]       [k] __napi_poll
     0.58%  [kernel]       [k] net_rx_action
     0.56%  [kernel]       [k] read_tsc
<*>  0.50%  [kernel]       [k] __x86_indirect_thunk_r11
     0.45%  [kernel]       [k] memset

After patch, lines with <*> no longer show up, and overall
cpu usage looks much better (~60% instead of ~72%)

    25.56%  [kernel]       [k] gq_rx_skb
     9.90%  [kernel]       [k] napi_reuse_skb
     7.39%  [kernel]       [k] dev_gro_receive
     6.78%  [kernel]       [k] memcpy
     6.53%  [kernel]       [k] skb_release_data
     6.39%  [kernel]       [k] tcp_gro_receive
     5.71%  [kernel]       [k] ipv6_gro_receive
     4.35%  [kernel]       [k] napi_gro_frags
     4.34%  [kernel]       [k] skb_gro_receive
     3.50%  [kernel]       [k] gq_pool_get
     3.08%  [kernel]       [k] gq_rx_napi_handler
     2.35%  [kernel]       [k] tcp6_gro_receive
     2.06%  [kernel]       [k] gq_rx_prep_buffers
     1.32%  [kernel]       [k] csum_partial
     0.93%  [kernel]       [k] csum_ipv6_magic
     0.65%  [kernel]       [k] net_rx_action

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/dma-iommu.c | 67 +++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9297b741f5e80e2408e864fc3f779410d6b04d49..976ba20a55eab5fd94e9bec2d38a2a60e0690444 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -522,6 +522,11 @@ static bool dev_use_swiotlb(struct device *dev)
 	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
 }
 
+static bool dev_is_dma_sync_needed(struct device *dev)
+{
+	return !dev_is_dma_coherent(dev) || dev_use_swiotlb(dev);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -914,7 +919,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
+	if (!dev_is_dma_sync_needed(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -930,7 +935,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
+	if (!dev_is_dma_sync_needed(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -1544,30 +1549,51 @@ static size_t iommu_dma_opt_mapping_size(void)
 	return iova_rcache_range();
 }
 
+#define iommu_dma_ops_common_fields \
+	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,		\
+	.alloc			= iommu_dma_alloc,			\
+	.free			= iommu_dma_free,			\
+	.alloc_pages		= dma_common_alloc_pages,		\
+	.free_pages		= dma_common_free_pages,		\
+	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,	\
+	.free_noncontiguous	= iommu_dma_free_noncontiguous,		\
+	.mmap			= iommu_dma_mmap,			\
+	.get_sgtable		= iommu_dma_get_sgtable,		\
+	.map_page		= iommu_dma_map_page,			\
+	.unmap_page		= iommu_dma_unmap_page,			\
+	.map_sg			= iommu_dma_map_sg,			\
+	.unmap_sg		= iommu_dma_unmap_sg,			\
+	.map_resource		= iommu_dma_map_resource,		\
+	.unmap_resource		= iommu_dma_unmap_resource,		\
+	.get_merge_boundary	= iommu_dma_get_merge_boundary,		\
+	.opt_mapping_size	= iommu_dma_opt_mapping_size,
+
 static const struct dma_map_ops iommu_dma_ops = {
-	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
-	.alloc			= iommu_dma_alloc,
-	.free			= iommu_dma_free,
-	.alloc_pages		= dma_common_alloc_pages,
-	.free_pages		= dma_common_free_pages,
-	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
-	.free_noncontiguous	= iommu_dma_free_noncontiguous,
-	.mmap			= iommu_dma_mmap,
-	.get_sgtable		= iommu_dma_get_sgtable,
-	.map_page		= iommu_dma_map_page,
-	.unmap_page		= iommu_dma_unmap_page,
-	.map_sg			= iommu_dma_map_sg,
-	.unmap_sg		= iommu_dma_unmap_sg,
+	iommu_dma_ops_common_fields
+
 	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
 	.sync_single_for_device	= iommu_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= iommu_dma_sync_sg_for_cpu,
 	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
-	.map_resource		= iommu_dma_map_resource,
-	.unmap_resource		= iommu_dma_unmap_resource,
-	.get_merge_boundary	= iommu_dma_get_merge_boundary,
-	.opt_mapping_size	= iommu_dma_opt_mapping_size,
 };
 
+/* Special instance of iommu_dma_ops for devices satisfying this condition:
+ *   !dev_is_dma_sync_needed(dev)
+ *
+ * iommu_dma_sync_single_for_cpu(), iommu_dma_sync_single_for_device(),
+ * iommu_dma_sync_sg_for_cpu(), iommu_dma_sync_sg_for_device()
+ * do nothing special and can be avoided, saving indirect calls.
+ */
+static const struct dma_map_ops iommu_nosync_dma_ops = {
+	iommu_dma_ops_common_fields
+
+	.sync_single_for_cpu	= NULL,
+	.sync_single_for_device	= NULL,
+	.sync_sg_for_cpu	= NULL,
+	.sync_sg_for_device	= NULL,
+};
+#undef iommu_dma_ops_common_fields
+
 /*
  * The IOMMU core code allocates the default DMA domain, which the underlying
  * IOMMU driver needs to support via the dma-iommu layer.
@@ -1586,7 +1612,8 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	if (iommu_is_dma_domain(domain)) {
 		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
-		dev->dma_ops = &iommu_dma_ops;
+		dev->dma_ops = dev_is_dma_sync_needed(dev) ?
+				&iommu_dma_ops : &iommu_nosync_dma_ops;
 	}
 
 	return;
-- 
2.38.1.431.g37b22c650d-goog

