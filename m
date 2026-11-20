Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136833;
	b=rsiRakGUn/Dt/kxObvxJXxunY6n5WuQ+fqBfUuth/Ezbaj32FygLzdBFBl/ii7LdSYbu
	 mW7IwvamaJ+c8FDiFzOgWNf3lAu+jytoGfg2S1MCERZN0xLYga7k+3+Bgq9vlgBDowYFi
	 jjuVx6IhZg2UfuCzd7njQm4VR7/zerxqKchhACfVRGd/q5s5j7BOGcpQkZqu1yYxKE9UC
	 Bw2S8a6FyrjWANZHQeJGRq/Zxx3WGhXyQsoCOBdWIqiFZHPYE7PYq6nQB77hB9SfYUbLf
	 Np6c+uvLYqnpmgiVlbwxnFr7imkCZ/5ZRUNua/B9jtyZssT2g7aUcwaIbM0aPjtNHhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Ut9IgsodJz9rQhj0smx0VJpNs6AreC5f8aEMQj1btrk=;
	b=H9i15D+z21Fc2uKG7xEabxVfIYlOCtueuFKtr49oYrMIpEBqyOnsSpjGge81jXcexNBu
	 9Ae6FaQBCho81hq0losvIpSVTnyVrpnicLmFsg7ZX+Uy5DoEciTXhARhEmlyZV4QZLjQU
	 jStq3fLk/ss9m6GYrCQIiw5gIf+1yJKhK5PTgsv0eCKvYlXPd/6bsFKTVZ3jOog4TErpx
	 Z3yHqr/UIkzrpAp0/GuweCzs8wXYd7M33YlBmmlcf5xFZf5976cb1eXOsii9fHq3COCco
	 3DykiITYkQI0Lg4iAjIALrLvB9X0TOw7fGUcXOIpoWzGeVelTx6ohXSzYb1/vF6pgsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MnCtIbCa;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393C60A5BFC
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 01:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E393C60A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MnCtIbCa
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b8b0fffdb9so217936a12.2
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 17:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136829; x=1795741629; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ut9IgsodJz9rQhj0smx0VJpNs6AreC5f8aEMQj1btrk=;
        b=MnCtIbCaYy6SMuWUd0SMXme2lZY24wlqnD96slf/UJX2T8iM2gdtUs6ocwmcJT0wmm
         za4KRLM/QtfDCX3CuETmHAc5hf9I62EsRTtzjcDhagpR7V5+7wvtBkDUygk3CgjVT3X2
         n2cvVXXqcW/m8oPFPjFndTrco6uQniiB/7Gl+djeu1ZMmpCHnxnsO9jOm1E0IGEZiaax
         hsbhdeJGRNZm7wp7gcBRmxgBI6hdQD7L4VYm9DiNxj4EWsDPZqfexkuZOSxBN30sxhT+
         SLIJyhYKwrUx20l+g7ry+q9wcFUBRLRqCzj/K5u6WgUaVT6gt3kWUjZsq1cWu7VNavMN
         xfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136829; x=1795741629;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ut9IgsodJz9rQhj0smx0VJpNs6AreC5f8aEMQj1btrk=;
        b=dF/Aexal2mP0LYcto7VYlsOdccTxN/gjoML1S85kveMM9fo85R5ttxfvdAXzlTWO7u
         ePUKCt+TsYLZwAQ0aRNJX4Fq3PF0HROughoIHY3vS/LTPv74MSFF4Lrw2IMHn1yJc6lV
         758PJf3EQeg6k/it84aBtObE+nTEJbXrZNeGUGU3lHBMOrj/mgllD0zIQOmCn227EuAk
         wt9cEfQpm1lu4VDBWSze6ayISY6HZNcH+E8XUyXpVTqV/xqh+Wozc7csfcYuF1vKwjJy
         9wTn+6gnTh+evzcSTeMDb1KjtRq6BF/Qb/d7Rioa41/FwS1eK+Te00vb77hkKZ7WEilD
         Fq+w==
X-Forwarded-Encrypted: i=1; AL+hErEOM2bAilKhtybZhZFVz6v98gB+s6yt30Si2da+ly5laM/slAWaYBF+BVt8XsSwywnuQRrwZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Uo7e7bv2W8j+irH7/4EkveDlBxmQJyHSx8/zLzp//Q61ocPFC
	Szaj3X8R5gWWO/Cuvt6wkxE5h95P8Egd9EguGDD4hxgwFcMb2OvFl/3P8F6sDtg0ucbNrDBT+D4
	4PB+WeA==
X-Received: from edrv5.prod.google.com ([2002:aa7:d645:0:b0:6b8:8291:9a7])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:c4c6:20b0:6b7:8cfe:59b
 with SMTP id 4fb4d7f45d1cf-6ba37e7a050mr596195a12.15.1795136828958; Thu, 19
 Nov 2026 17:07:08 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:37 +0000
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261120010655.467825-8-lrizzo@google.com>
Subject: [RFC PATCH v3 07/25] driver core: Add per-device pisa_* sysfs
 attributes for PISA optin
From: Luigi Rizzo <lrizzo@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Naman Gulati <namangulati@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Because of the performance and security implications, the use of PISA
features is opt-in and configurable per device with a fine granularity.

Add boolean attributes to struct device exposed under
/sys/devices/*/*/pisa_*:
  - pisa_coherent:     enable PISA for coherent allocations
  - pisa_rx_bufs:      enable PISA for RX buffers / page_pool
  - pisa_tx_bufs:      enable PISA for TX socket page frags
  - pisa_tx_skb_heads: enable PISA slab cache for small TX skb heads
  - pisa_tx_zerocopy:  migrate MSG_ZEROCOPY user pages into PISA

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/base/core.c    | 75 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 15 +++++++++
 include/linux/pisa.h   | 27 +++++++++++++++
 mm/pisa-alloc.c        | 21 ++++++++++++
 mm/pisa-kunit.c        | 71 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 209 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cbe05197d4a0b..df93b6b6e125e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pisa.h>
 #include <linux/pm_runtime.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
@@ -2907,6 +2908,65 @@ static ssize_t removable_show(struct device *dev, const struct device_attribute
 }
 static const DEVICE_ATTR_RO(removable);
 
+/* Per-device configuration to selectively enable PISA */
+static ssize_t pisa_attr_store(struct device *dev, const char *buf, size_t count,
+			       bool *field, int (*setter)(struct device *, bool))
+{
+	bool val;
+	int ret = kstrtobool(buf, &val);
+
+	if (ret < 0)
+		return ret;
+	if (val) {
+		ret = pisa_meta_init();
+		if (ret < 0)
+			return ret;
+	}
+	if (setter) {
+		ret = setter(dev, val);
+		if (ret < 0)
+			return ret;
+	} else {
+		WRITE_ONCE(*field, val);
+	}
+	return count;
+}
+
+#define PISA_SET_ATTR(name, setter)					\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	return sysfs_emit(buf, "%u\n", READ_ONCE(dev->name));		\
+}									\
+static ssize_t name##_store(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	return pisa_attr_store(dev, buf, count, &dev->name, setter);	\
+}									\
+static DEVICE_ATTR_RW(name)
+
+#define PISA_BOOL_ATTR(name)	PISA_SET_ATTR(name, NULL)
+
+PISA_BOOL_ATTR(pisa_coherent);
+PISA_BOOL_ATTR(pisa_rx_bufs);
+PISA_BOOL_ATTR(pisa_tx_bufs);
+PISA_BOOL_ATTR(pisa_tx_skb_heads);
+PISA_BOOL_ATTR(pisa_tx_zerocopy);
+
+static struct attribute *dev_attr_pisa[] = {
+	&dev_attr_pisa_coherent.attr,
+	&dev_attr_pisa_rx_bufs.attr,
+	&dev_attr_pisa_tx_bufs.attr,
+	&dev_attr_pisa_tx_skb_heads.attr,
+	&dev_attr_pisa_tx_zerocopy.attr,
+	NULL,
+};
+
+static const struct attribute_group dev_attr_pisa_group = {
+	.attrs = dev_attr_pisa,
+};
+
 int device_add_groups(struct device *dev,
 		      const struct attribute_group *const *groups)
 {
@@ -3014,6 +3074,18 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_removable;
 	}
 
+	if (IS_ENABLED(CONFIG_PISA) && dev->dma_mask) {
+		error = device_add_group(dev, &dev_attr_pisa_group);
+		if (error) {
+			if (dev->physical_location) {
+				device_remove_group(dev, &dev_attr_physical_location_group);
+				kfree(dev->physical_location);
+				dev->physical_location = NULL;
+			}
+			goto err_remove_dev_removable;
+		}
+	}
+
 	return 0;
 
  err_remove_dev_removable:
@@ -3039,6 +3111,9 @@ static void device_remove_attrs(struct device *dev)
 	const struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	if (IS_ENABLED(CONFIG_PISA) && dev->dma_mask)
+		device_remove_group(dev, &dev_attr_pisa_group);
+
 	if (dev->physical_location) {
 		device_remove_group(dev, &dev_attr_physical_location_group);
 		kfree(dev->physical_location);
diff --git a/include/linux/device.h b/include/linux/device.h
index 429e39f647cf9..e705df38e49af 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -695,6 +695,15 @@ enum struct_device_flags {
  * @removable:  Whether the device can be removed from the system. This
  *              should be set by the subsystem / bus driver that discovered
  *              the device.
+ * @pisa_coherent: Back coherent dma_alloc_attrs() with PISA
+ *		(sysfs pisa_coherent).
+ * @pisa_rx_bufs: Use PISA allocators for RX buffers (sysfs pisa_rx_bufs).
+ * @pisa_tx_bufs: Use PISA allocators for socket TX page fragments
+ *		(sysfs pisa_tx_bufs).
+ * @pisa_tx_skb_heads: Use PISA slab cache for small TX skb heads
+ *		(sysfs pisa_tx_skb_heads).
+ * @pisa_tx_zerocopy: Migrate MSG_ZEROCOPY user pages into PISA
+ *		(sysfs pisa_tx_zerocopy).
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -799,6 +808,12 @@ struct device {
 
 	enum device_removable	removable;
 
+	bool			pisa_coherent;
+	bool			pisa_rx_bufs;
+	bool			pisa_tx_bufs;
+	bool			pisa_tx_skb_heads;
+	bool			pisa_tx_zerocopy;
+
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
 
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index cc33e181df097..5222cb207257f 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -84,6 +84,7 @@ static inline u64 pisa_iova_size(void)
 }
 
 int pisa_meta_init(void);
+bool __pisa_has_free_blocks_rx(unsigned int order, int nid);
 bool __pisa_page_can_recycle(const struct page *page);
 
 static inline bool pisa_enabled(void)
@@ -142,6 +143,21 @@ static inline struct page *pisa_virt_to_page(const void *addr)
 	return is_pisa_page(page) ? page : NULL;
 }
 
+/* Hook for __page_pool_alloc_netmems_slow() (guarded by @pisa_key). */
+static inline gfp_t pisa_rx_gfp(const struct device *dev)
+{
+	return pisa_enabled() && dev && READ_ONCE(dev->pisa_rx_bufs) ?
+	       __GFP_PISA_RW : 0;
+}
+
+/* Hook for NIC driver RX buffer allocation (guarded by @pisa_key). */
+static inline bool pisa_has_free_blocks_rx(const struct device *dev,
+					   unsigned int order, int nid)
+{
+	return pisa_enabled() && dev && READ_ONCE(dev->pisa_rx_bufs) &&
+	       __pisa_has_free_blocks_rx(order, nid);
+}
+
 /* Hook for skb_page_frag_refill() and __pisa_free_page() (@pisa_recycle_check_key). */
 static inline bool pisa_page_can_recycle(const struct page *page)
 {
@@ -158,6 +174,17 @@ static inline bool is_pisa_page(const struct page *page) { return false; }
 static inline bool is_pisa_phys(phys_addr_t phys) { return false; }
 static inline struct page *pisa_virt_to_page(const void *addr) { return NULL; }
 
+static inline gfp_t pisa_rx_gfp(const struct device *dev)
+{
+	return 0;
+}
+
+static inline bool pisa_has_free_blocks_rx(const struct device *dev,
+					   unsigned int order, int nid)
+{
+	return false;
+}
+
 static inline bool pisa_page_can_recycle(const struct page *page)
 {
 	return true;
diff --git a/mm/pisa-alloc.c b/mm/pisa-alloc.c
index 01d8bbc8d72ff..ff8565c3206ad 100644
--- a/mm/pisa-alloc.c
+++ b/mm/pisa-alloc.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cache.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/pisa.h>
 #include <linux/export.h>
@@ -374,6 +375,26 @@ unsigned long __pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order,
 	return pisa_alloc_bulk(pa, gfp & ~__GFP_PISA_RW, nr_pages, page_array, frozen);
 }
 
+/**
+ * __pisa_has_free_blocks_rx - Check if per-node RX allocator of @order on @nid has free blocks
+ * @order: Block order
+ * @nid: Target NUMA node (or NUMA_NO_NODE)
+ *
+ * Return: true if the per-node RX allocator has a free block available, or
+ * the node's reservoir has a PISA page to give it.
+ */
+bool __pisa_has_free_blocks_rx(unsigned int order, int nid)
+{
+	struct pisa_alloc *pa = pisa_node_pa(nid, order, false);
+
+	return pa &&
+	       (!list_empty_careful(&pa->partial) ||
+		!list_empty_careful(&pa->partial_dirty) ||
+		!list_empty_careful(&pa->idle) ||
+		READ_ONCE(pisa_nodes[pa->nid].nr_pages));
+}
+EXPORT_SYMBOL(__pisa_has_free_blocks_rx);
+
 /*
  * Split a non-compound page of @old_order into 1 << (@old_order - @new_order)
  * pages of @new_order (compound if @new_order > 0), all frozen at refcount 0.
diff --git a/mm/pisa-kunit.c b/mm/pisa-kunit.c
index eb51007e66de5..2adaeb1ffe43e 100644
--- a/mm/pisa-kunit.c
+++ b/mm/pisa-kunit.c
@@ -6,6 +6,8 @@
 #include <linux/delay.h>
 #include <linux/gfp.h>
 #include <linux/pisa.h>
+#include <linux/kernfs.h>
+#include <linux/sysfs.h>
 #include <linux/iommu.h>
 #include <linux/iova.h>
 #include <linux/mm.h>
@@ -443,6 +445,74 @@ static void test_map_and_domain_lifecycle(struct kunit *test)
 }
 #endif /* CONFIG_IOMMU_DMA */
 
+static void kunit_check_pisa_attr(struct kunit *test, struct device *dev,
+				  const char *name, bool *field)
+{
+	const struct sysfs_ops *ops = dev->kobj.ktype->sysfs_ops;
+	struct kernfs_node *kn;
+	char *buf;
+
+	buf = (char *)__get_free_page(GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, buf);
+	if (!buf)
+		return;
+	kn = kernfs_find_and_get(dev->kobj.sd, name);
+	KUNIT_EXPECT_NOT_NULL(test, kn);
+	if (!kn)
+		goto out_free;
+
+	KUNIT_EXPECT_EQ(test, ops->show(&dev->kobj, kn->priv, buf), 2);
+	KUNIT_EXPECT_STREQ(test, buf, "0\n");
+	KUNIT_EXPECT_FALSE(test, READ_ONCE(*field));
+
+	KUNIT_EXPECT_EQ(test, ops->store(&dev->kobj, kn->priv, "1\n", 2), 2);
+	KUNIT_EXPECT_TRUE(test, READ_ONCE(*field));
+	KUNIT_EXPECT_EQ(test, ops->show(&dev->kobj, kn->priv, buf), 2);
+	KUNIT_EXPECT_STREQ(test, buf, "1\n");
+
+	KUNIT_EXPECT_LT(test, ops->store(&dev->kobj, kn->priv, "bad", 3), 0);
+	KUNIT_EXPECT_TRUE(test, READ_ONCE(*field));
+
+	KUNIT_EXPECT_EQ(test, ops->store(&dev->kobj, kn->priv, "0\n", 2), 2);
+	KUNIT_EXPECT_FALSE(test, READ_ONCE(*field));
+
+	kernfs_put(kn);
+out_free:
+	free_page((unsigned long)buf);
+}
+
+static void kunit_attr_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static void test_dev_pisa_attrs(struct kunit *test)
+{
+	struct device *dev;
+
+	if (!IS_ENABLED(CONFIG_SYSFS))
+		kunit_skip(test, "requires CONFIG_SYSFS");
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dev);
+	dev->init_name = "pisa_attr_kunit";
+	dev->release = kunit_attr_dev_release;
+	dev->coherent_dma_mask = DMA_BIT_MASK(64);
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	if (device_register(dev)) {
+		put_device(dev);
+		KUNIT_FAIL(test, "device_register failed");
+		return;
+	}
+	kunit_check_pisa_attr(test, dev, "pisa_coherent", &dev->pisa_coherent);
+	kunit_check_pisa_attr(test, dev, "pisa_rx_bufs", &dev->pisa_rx_bufs);
+	kunit_check_pisa_attr(test, dev, "pisa_tx_zerocopy", &dev->pisa_tx_zerocopy);
+	kunit_check_pisa_attr(test, dev, "pisa_tx_bufs", &dev->pisa_tx_bufs);
+	kunit_check_pisa_attr(test, dev, "pisa_tx_skb_heads", &dev->pisa_tx_skb_heads);
+	device_unregister(dev);
+}
+
 static void test_reservoir_and_scrubber(struct kunit *test)
 {
 	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
@@ -459,6 +529,7 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_iova_helpers),
 	KUNIT_CASE(test_map_and_domain_lifecycle),
 #endif
+	KUNIT_CASE(test_dev_pisa_attrs),
 	KUNIT_CASE(test_reservoir_and_scrubber),
 	{}
 };
-- 
2.56.1.809.ga0b61035b5-goog

