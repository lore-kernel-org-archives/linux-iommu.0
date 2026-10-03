Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DD49E5EF
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062592; cv=none; b=GGcVoMua8PeR/ZrvcZaoPHse9n07k0wzSWeE5MVizxDDiCV1fHaZ7kWwbNbYWPnhdfZ0wCkAs4Cyz2xsvFkFIh3kQtGGxyo2rPH2b5EeWixCsTJNGRu7o43xbx9k63wKL4TTM1M272Eo6xQ6Qdt+6SmifC5YNNFNiPpGwfHruIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062592; c=relaxed/simple;
	bh=7/+K5UbPoLVagSVVzP6ds9SnbBN5AQfhr70LFIIqoBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XfxAs3rKreTq9OEeMcGp2b7/LSGz3Um8oTWVn3xHkAaQoL49GRTvrwLHnDeo4nWMzuWhYUcgKYl1eNy+nBNgZx8edAVm7k/Ed4fmiJvSRUtjdxPhNI4l5miI+IOCj0KUMgICdOEw7tWIw/RLfrOP79+oAuYFswXXMBjqK6EsZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIbUydBa; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIbUydBa"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2dd399f761so82638266b.3
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062582; x=1791667382; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Y6eccMU3oNOC6nPRXFDlu2gRIyDfLt0ekbGijFBkOg=;
        b=aIbUydBa4gC80nweq2yiJ+5VWfqIDEs+VK2h94hzL37G3ZS0CDMCPvHq/EbIXnnjUd
         HyD3xEla65BcrsHKuMjOAdkI0McnZ/7heTX2aBi+ndrGcKi5iMtaw8/8MIrIMI+aKPtP
         h+nFRKDsKVSPMAn9LtZQVg6QZzATMpSA3e+Sa0TD5y8hL6zGGLOCPyMW+usI28mH9isM
         0S0qiHU1GsziH0v006gM9a/ncjUPRgAbn+pVe4yeFp5pacc6dfvez0EExV5RC6nvykoF
         JXmiSmUfH/b4CuhjipG1MIgxRlpmpJt1l3218n8FpJAXWqeJb3HpuyVh0tvEHDHLmxiK
         n4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062582; x=1791667382;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Y6eccMU3oNOC6nPRXFDlu2gRIyDfLt0ekbGijFBkOg=;
        b=cbNnKIyv1Hl8MI4n5J/dSt9SYYcNwu/zfHT24hxvNI+SeSY3OIAxW69JmOW3F2A43i
         0fxQ8mg3MskWquWYysXej27chp/SxNB1jO10hEKJ+GtqW9zHOQQRCpQn1AQQeqcfsd57
         +h1EIL1bK382modbJ4Ep3lPaHx2O7LdXa7kIokgwdlIA3PexHsWNRlHc6Hw/EwWtBRre
         Jw0944HMYfAvC+gKdCENgV3sqn7h2SVQ/kO701nuO1QWiYej7II4FTymEDHDmpddZwMK
         VYmyxde5tofdRIKhTFhTYG7NVdOLojGdPYblWrP0HfrPVPsIhwWfbP6drxeeqR9F6arw
         fM9A==
X-Forwarded-Encrypted: i=1; AKwUvBy3GYxszJ60Y2fFnricEazSPZhmVTNHSO+EP6n12mSkToHzszFo5PUr2oLN6pNAo+g5s+CwTw==@lists.linux.dev
X-Gm-Message-State: AFuF++lWdptmzA8MkXolzJ4N0F8HTKoZosxTajhymfBUt7cEw6XPNcSw
	qMh5H5OcKwHxddcRi2AsbZqH8/axNU+0bq3WqL+k92oU5RNuAyxYGKGbJdISnNc2MLYIL3pk082
	9GcAJ6Q==
X-Received: from ejbs7.prod.google.com ([2002:a17:906:607:b0:c2e:1f26:6d02])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:72cf:b0:c2d:cbc9:3529
 with SMTP id a640c23a62f3a-c2e4af393e2mr567647366b.20.1791062582284; Sat, 03
 Oct 2026 14:23:02 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:31 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-13-lrizzo@google.com>
Subject: [RFC: DMA_PMD 12/22] net/core: Use per-CPU DMA_PMD pools for skb_page_frag_refill()
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add sysctl net.core.tx_enable_dma_pmd to back skb_page_frag_refill() with
per-CPU order-3 (32KB block) and order-0 (4KB block) DMA_PMD page pools.

When enabled, TX socket buffer page fragment allocations draw fragments
from DMA_PMD physical pages registered with per-CPU dma_pmd_pool. The
first allocation maps the entire DMA_PMD page, subsequent allocations
reuse the cached PMD_SIZE IOVA mapping locklessly without per-packet unmap
or IOTLB flush.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/sock.h         |  3 ++
 net/core/sock.c            | 86 +++++++++++++++++++++++++++++++++++++-
 net/core/sysctl_net_core.c |  7 ++++
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60ea55dc18854..a06b53e9ff225 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3092,6 +3092,9 @@ extern __u32 sysctl_rmem_default;
 
 #define SKB_FRAG_PAGE_ORDER	get_order(32768)
 DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
+DECLARE_STATIC_KEY_FALSE(net_tx_enable_dma_pmd_key);
+int net_tx_dma_pmd_sysctl(const struct ctl_table *table, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos);
 
 static inline int sk_get_wmem0(const struct sock *sk, const struct proto *proto)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index e8551df8330ff..1fd338a547ce1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -115,6 +115,7 @@
 #include <linux/memcontrol.h>
 #include <linux/prefetch.h>
 #include <linux/compat.h>
+#include <linux/dma-pmd.h>
 #include <linux/mroute.h>
 #include <linux/mroute6.h>
 #include <linux/icmpv6.h>
@@ -3173,6 +3174,87 @@ static void sk_leave_memory_pressure(struct sock *sk)
 }
 
 DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
+DEFINE_STATIC_KEY_FALSE(net_tx_enable_dma_pmd_key);
+
+static DEFINE_PER_CPU(struct dma_pmd_pool *, tx_pmd_pool_high);
+static DEFINE_PER_CPU(struct dma_pmd_pool *, tx_pmd_pool_order0);
+
+/*
+ * Lazily initialize the per-CPU DMA_PMD page pools on the first write to sysctl
+ * net.core.tx_enable_dma_pmd.
+ *
+ * Once initialized, the struct dma_pmd_pool descriptors remain allocated for
+ * the lifetime of the kernel so that lockless raw_cpu_read() in
+ * __alloc_pmd() is always safe against concurrent sysctl
+ * toggles. If pool creation fails partway through, all pools created so far are
+ * destroyed and per-CPU pointers are reset to NULL.
+ */
+static int net_tx_dma_pmd_init(void)
+{
+	static DEFINE_MUTEX(mutex);
+	struct dma_pmd_pool *pool;
+	static bool initialized;
+	int cpu;
+
+	if (!IS_ENABLED(CONFIG_DMA_PMD))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&mutex);
+	if (initialized) {
+		mutex_unlock(&mutex);
+		return 0;
+	}
+
+	for_each_possible_cpu(cpu) {
+		if (SKB_FRAG_PAGE_ORDER) {
+			pool = dma_pmd_pool_create(SKB_FRAG_PAGE_ORDER, 16);
+			if (!pool)
+				goto err_cleanup;
+			per_cpu(tx_pmd_pool_high, cpu) = pool;
+		}
+
+		pool = dma_pmd_pool_create(0, 16);
+		if (!pool)
+			goto err_cleanup;
+		per_cpu(tx_pmd_pool_order0, cpu) = pool;
+	}
+
+	initialized = true;
+	mutex_unlock(&mutex);
+	return 0;
+
+err_cleanup:
+	for_each_possible_cpu(cpu) {
+		per_cpu(tx_pmd_pool_high, cpu) =
+			dma_pmd_pool_destroy(per_cpu(tx_pmd_pool_high, cpu));
+		per_cpu(tx_pmd_pool_order0, cpu) =
+			dma_pmd_pool_destroy(per_cpu(tx_pmd_pool_order0, cpu));
+	}
+	mutex_unlock(&mutex);
+	return -ENOMEM;
+}
+
+int net_tx_dma_pmd_sysctl(const struct ctl_table *table, int write,
+			  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (write) {
+		int ret = net_tx_dma_pmd_init();
+
+		if (ret)
+			return ret;
+	}
+
+	return proc_do_static_key(table, write, buffer, lenp, ppos);
+}
+
+static struct page *__alloc_pmd(gfp_t gfp, unsigned int order)
+{
+	if (!static_branch_unlikely(&net_tx_enable_dma_pmd_key))
+		return alloc_pages(gfp, order);
+	if (order == SKB_FRAG_PAGE_ORDER)
+		return dma_pmd_pool_alloc(raw_cpu_read(tx_pmd_pool_high), gfp);
+	return dma_pmd_pool_alloc(raw_cpu_read(tx_pmd_pool_order0), gfp) ?: alloc_page(gfp);
+}
 
 /**
  * skb_page_frag_refill - check that a page_frag contains enough room
@@ -3200,7 +3282,7 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 	if (SKB_FRAG_PAGE_ORDER &&
 	    !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
 		/* Avoid direct reclaim but allow kswapd to wake */
-		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
+		pfrag->page = __alloc_pmd((gfp & ~__GFP_DIRECT_RECLAIM) |
 					  __GFP_COMP | __GFP_NOWARN |
 					  __GFP_NORETRY,
 					  SKB_FRAG_PAGE_ORDER);
@@ -3209,7 +3291,7 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 			return true;
 		}
 	}
-	pfrag->page = alloc_page(gfp);
+	pfrag->page = __alloc_pmd(gfp, 0);
 	if (likely(pfrag->page)) {
 		pfrag->size = PAGE_SIZE;
 		return true;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index eb35da3556f4a..d9a7d9cb349e0 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -651,6 +651,13 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_static_key,
 	},
+	{
+		.procname	= "tx_enable_dma_pmd",
+		.data		= &net_tx_enable_dma_pmd_key.key,
+		.maxlen		= sizeof(net_tx_enable_dma_pmd_key),
+		.mode		= 0644,
+		.proc_handler	= net_tx_dma_pmd_sysctl,
+	},
 	{
 		.procname	= "gro_normal_batch",
 		.data		= &net_hotdata.gro_normal_batch,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

