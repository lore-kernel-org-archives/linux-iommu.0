Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248749;
	b=df5CKXctHh0X7shnCxrc0NjGs5Hirx0HMXuvJt7tfmW4ZQfW2wFxLJpMuD50PMoorAhu
	 hn3pJvJYIDXXWv3LqLOOHDrISgEjFNtsgZEqi1otWsx7jugHU3XjcJHV6OKTsQ4F0+2S4
	 Vjgis3FjmF5sBgxpmZHJORZ1ZUZDsxLgeKoDvprKvucX047TXAq353yfOC9zAoHzqglzd
	 E1D8awAYMPa7IbFm35wcrYvxku4jjqtTE4ZZ8MTRwefYu5rgAp/zrR9aJZUPQpgogii0/
	 Y4v/RDt6Bs3AFMScqCdKwBlVmfJyyxPkEyqQ/ImnZqWxIHcV2lyHlqQ5Eowc0/eZXCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KIwBzE5/gTDRHFi1rb7GevJXqS3ssTxf1jc5qeulzMc=;
	b=3BJ/oOe7sSKgZiRSmxFL/LYWdxvIlcP4WAmB4s6A23F5TCCqrgUho+dqVS5+TNhZXHfD
	 jEjSjCR8n836UOkSg7/W9w2zzkfiR6kP0OXicCr28ud/S6OEmVdQ6awIGjs3vgWR2uzWV
	 e66OUywf/hhUmU4mYS+eggGJC2kma8vi+i8AVIWm804TJElGWuIEhVXM5uTGj7Z6VQW7Q
	 XEYPYydIIDM9qbNCi/D75HtplB0OYW04xEIVfzm5IYiVnlHe1jHhBZO6+aiUv0TZQ6rs+
	 W2xCASiXCjgccPEFE2ugs8jx6+FnzetZ2Mx/k9ROvIaQNS/rDoKSfkPN/wcOqU0SBGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pOoqQPWG;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3660A6F52
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 18:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B3660A6F52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pOoqQPWG
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b564783d3fso1359330a12.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248747; x=1794853547; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIwBzE5/gTDRHFi1rb7GevJXqS3ssTxf1jc5qeulzMc=;
        b=pOoqQPWGFpj/iotCD1SOfWw3TT+hRJ33qnP0CYhRkJUxJ3KOqJIfvq1ub/UDZGXduB
         JYVYE176AQcnrKHQxF2bLsJdXQp1XoJpfbbYu+GAPqALyIPu7o50UBxJ0YMnq4rsmejx
         l4fla6P9PfncLogcQRG8y8dVc2/OsIx19QgDNr9CQpMJnoiOhZJz8Mnermds/QBm57Es
         5C8ib+zBFlbRbylC/S+8hREWaWu49GLT83JmIQkbPITrBpa67JU3Lgwsg9ZtBHcx13FD
         0S4pfLWYRJxvcSI4+2gmdEyVUa9Eam9Ytl6vgTXdCSwYjkzY3G8UIaSP6zLYL0uPWzLF
         AT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248747; x=1794853547;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIwBzE5/gTDRHFi1rb7GevJXqS3ssTxf1jc5qeulzMc=;
        b=K+/aH4EQxV4EZNlW8H/ntMa1HYzOjmstpWdtt7SijKtRtPtfbiodqhv7etHpXHwJP2
         3LkVt6J3DZwtoGDwP3qPzozg24IiogPMeMupH3TEQ6mV0JATsetNC0jblXirVnlOVhUj
         ig9Bjopvu8d/j8SPkY0CCS6379rKqkdWC/ySjKnxHcl3hRb8T4iBRIBFo5xArRMuga2q
         UIfikkSpXQWqzwF2yo6yb2dPFofGW+EPo/ISRQgDHN6gL17MO9nLylPpI545GEb6Bgas
         +1GrXmn4VbM5YH3E+bQ62PAwfe1ml/s+GKkx0H1xD1/s3N9CpoB0o6sqxOGZcsgkok1/
         uEvg==
X-Forwarded-Encrypted: i=1; AL+hErE95mlRISC2kt75afeLt5om4tj3i16+K68gpEso4IcjCfiqCo2k6b+nCKcCrlq/WMwS84ULlA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+VAerLxvIXdg42O2i9eXGxrxr/u78S8P5L6ddTOg71EMhugeVP
	NMz/S650vjIjdDr/E+/2aXxhN7W3cMnpBDJnjikKqIMO/KupdzhTh140eVALfgicpJYigRB844n
	egfUp+A==
X-Received: from edsl3.prod.google.com ([2002:aa7:d943:0:b0:6ac:afe8:e21a])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:a6c6:10b0:6b5:6a24:6cf9
 with SMTP id 4fb4d7f45d1cf-6b756ae3a73mr246715a12.45.1794248746339; Mon, 09
 Nov 2026 10:25:46 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:17 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-10-lrizzo@google.com>
Subject: [RFC PATCH v2 09/25] driver core: Add per-device pisa_* sysfs
 attributes for PISA optin
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
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

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/base/core.c        | 64 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-alloc.c | 24 ++++++++++++++
 drivers/iommu/pisa-kunit.c | 67 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/pisa-priv.h  |  1 -
 include/linux/device.h     | 12 +++++++
 include/linux/pisa.h       | 19 +++++++++++
 6 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cbe05197d4a0b..97cd2d03ff77c 100644
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
@@ -2907,6 +2908,54 @@ static ssize_t removable_show(struct device *dev, const struct device_attribute
 }
 static const DEVICE_ATTR_RO(removable);
 
+/* Per-device configuration to selectively enable PISA */
+static ssize_t pisa_attr_store(const char *buf, size_t count, bool *field)
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
+	WRITE_ONCE(*field, val);
+	return count;
+}
+
+#define PISA_BOOL_ATTR(name)						\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	return sysfs_emit(buf, "%u\n", READ_ONCE(dev->name));		\
+}									\
+static ssize_t name##_store(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	return pisa_attr_store(buf, count, &dev->name);			\
+}									\
+static DEVICE_ATTR_RW(name)
+
+PISA_BOOL_ATTR(pisa_coherent);
+PISA_BOOL_ATTR(pisa_rx_bufs);
+PISA_BOOL_ATTR(pisa_tx_bufs);
+PISA_BOOL_ATTR(pisa_tx_skb_heads);
+
+static struct attribute *dev_attr_pisa[] = {
+	&dev_attr_pisa_coherent.attr,
+	&dev_attr_pisa_rx_bufs.attr,
+	&dev_attr_pisa_tx_bufs.attr,
+	&dev_attr_pisa_tx_skb_heads.attr,
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
@@ -3014,8 +3063,20 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_removable;
 	}
 
+	if (IS_ENABLED(CONFIG_PISA) && dev->dma_mask) {
+		error = device_add_group(dev, &dev_attr_pisa_group);
+		if (error)
+			goto err_remove_dev_physical_location;
+	}
+
 	return 0;
 
+ err_remove_dev_physical_location:
+	if (dev->physical_location) {
+		device_remove_group(dev, &dev_attr_physical_location_group);
+		kfree(dev->physical_location);
+		dev->physical_location = NULL;
+	}
  err_remove_dev_removable:
 	device_remove_file(dev, &dev_attr_removable);
  err_remove_dev_waiting_for_supplier:
@@ -3039,6 +3100,9 @@ static void device_remove_attrs(struct device *dev)
 	const struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	if (IS_ENABLED(CONFIG_PISA) && dev->dma_mask)
+		device_remove_group(dev, &dev_attr_pisa_group);
+
 	if (dev->physical_location) {
 		device_remove_group(dev, &dev_attr_physical_location_group);
 		kfree(dev->physical_location);
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index f98142882519c..b0d968aa9181c 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/cache.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/pisa.h>
 #include <linux/export.h>
@@ -392,6 +393,29 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred
 	return pisa_alloc_bulk(pa, gfp & ~__GFP_PISA_RW, nr_pages, page_array, frozen);
 }
 
+/**
+ * pisa_has_free_blocks_rx - Check if @dev has free PISA RX blocks of @order on @nid
+ * @dev: Device to check
+ * @order: Block order
+ * @nid: Target NUMA node (or NUMA_NO_NODE)
+ *
+ * Return: true if @dev->pisa_rx_bufs is enabled and the per-node allocator
+ * has a free block available.
+ */
+bool pisa_has_free_blocks_rx(const struct device *dev, unsigned int order, int nid)
+{
+	struct pisa_alloc *pa;
+
+	if (!dev || !READ_ONCE(dev->pisa_rx_bufs))
+		return false;
+	pa = pisa_node_pa(nid, order, false);
+	return pa &&
+	       (!list_empty_careful(&pa->partial) ||
+		!list_empty_careful(&pa->partial_dirty) ||
+		!list_empty_careful(&pa->idle));
+}
+EXPORT_SYMBOL(pisa_has_free_blocks_rx);
+
 /*
  * Split a non-compound page of @old_order into 1 << (@old_order - @new_order)
  * pages of @new_order (compound if @new_order > 0), all frozen at refcount 0.
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index e16268d55f3de..ab64657ad5c58 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -5,6 +5,8 @@
 #include <kunit/test.h>
 #include <linux/gfp.h>
 #include <linux/pisa.h>
+#include <linux/kernfs.h>
+#include <linux/sysfs.h>
 #include <linux/iommu.h>
 #include <linux/iova.h>
 #include <linux/mm.h>
@@ -350,6 +352,70 @@ static void test_map_and_domain_lifecycle(struct kunit *test)
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
+	kunit_check_pisa_attr(test, dev, "pisa_tx_bufs", &dev->pisa_tx_bufs);
+	kunit_check_pisa_attr(test, dev, "pisa_tx_skb_heads", &dev->pisa_tx_skb_heads);
+	device_unregister(dev);
+}
+
 static void test_reservoir_and_scrubber(struct kunit *test)
 {
 	KUNIT_ASSERT_EQ(test, pisa_meta_init(), 0);
@@ -365,6 +431,7 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_window_helpers),
 	KUNIT_CASE(test_map_and_domain_lifecycle),
 #endif
+	KUNIT_CASE(test_dev_pisa_attrs),
 	KUNIT_CASE(test_reservoir_and_scrubber),
 	{}
 };
diff --git a/drivers/iommu/pisa-priv.h b/drivers/iommu/pisa-priv.h
index 8d83ec09c19a9..e5ca95d2654cd 100644
--- a/drivers/iommu/pisa-priv.h
+++ b/drivers/iommu/pisa-priv.h
@@ -133,7 +133,6 @@ struct pisa_alloc {
 	unsigned int		num_idle_pages;
 	unsigned int		max_idle_pages;
 	unsigned long		idle_jiffies;
-
 	/* Cold. */
 	int			nid;
 	struct list_head	node;
diff --git a/include/linux/device.h b/include/linux/device.h
index 429e39f647cf9..b3c11e32116ca 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -695,6 +695,13 @@ enum struct_device_flags {
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
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -799,6 +806,11 @@ struct device {
 
 	enum device_removable	removable;
 
+	bool			pisa_coherent;
+	bool			pisa_rx_bufs;
+	bool			pisa_tx_bufs;
+	bool			pisa_tx_skb_heads;
+
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
 
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index c64689b81befe..92482fce943e9 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/jump_label.h>
+#include <linux/device.h>
 #include <linux/mm.h>
 #include <linux/numa.h>
 #include <linux/rcupdate.h>
@@ -82,6 +83,13 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order,
 				    int nr_pages, struct page **page_array,
 				    bool frozen);
 
+bool pisa_has_free_blocks_rx(const struct device *dev, unsigned int order, int nid);
+
+static inline gfp_t pisa_rx_gfp(const struct device *dev)
+{
+	return dev && READ_ONCE(dev->pisa_rx_bufs) ? __GFP_PISA_RW : 0;
+}
+
 #else /* !CONFIG_PISA */
 
 static inline int pisa_meta_init(void)
@@ -109,6 +117,17 @@ pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred_nid,
 	return 0;
 }
 
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
 #endif /* CONFIG_PISA */
 
 static inline struct page *
-- 
2.56.0.542.g3ef89b7020-goog

