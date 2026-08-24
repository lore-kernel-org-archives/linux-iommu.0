Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CB43F4D4
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585383; cv=none; b=H7/BdOvcjJEjMFXO0BcqlNDdh4dy7umhZs4hJnxIRin9vtBA9t6RX6ZagOqsyxSUsn5AiwPS1HllifcJE9goW/nmLvRL2NhW4SdJQxl9BGeWlwJYstkxlZG4ciCBJdc9Q+JmE3qi08EdPy1cBos+ZCtH0S4BLjAvjDbf6HD3tgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585383; c=relaxed/simple;
	bh=7RZvhwMCHTgYFqTlYPD6pPoVluRWmRUCimtR35dflb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cr3j5rjPWhLewAZWKtYDMPOmFU8A/H2wdVGLv+rFcmHPgMAVr8NUZG9s5FaOumBbcU20o2rw4DYB8KCV9Jcf7XYabw8BDC2vZjFZ0jsAAMKUbhc93nptNBDeC5dqZ/F69Xbpwtda3KAwRaJ7AqUHiRHa4t3jt/X2IHkXKgdRI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wF0MgmhP; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wF0MgmhP"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15ddb61f13so336762666b.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585379; x=1788190179; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIIxKJ/h4TdOX2PzM8xN9SJKh2HJ62O9uv+0COVNyBw=;
        b=wF0MgmhPOT+iINolwhmatvgqA8w7vN0uQtXWKyRmcGTIdsz8K3N/0iE1bQOl44q0Ph
         b/Avrgoa0OsEVYBhyFENgs1UXhPiPrIwJuzm1ZJrakLz7PPITMW4JMRvS/8TiPfGIglO
         oFCe0TJOdOA9/+VJ0QDSl4xr6ihiYnfDis8vwaAwsBf/nibbjdYMcaKcfIZn/heIjJ1G
         6h3znaXATzzjEFJuOjDKi8var5RzuOqsl1ufOtqjiypnYCA/nGff0KKBkaeFbEggKTT6
         BZQGD533fQUaBCgXm7C7qcWgFP4FdfydZNgMSTQKCDmtedTA9UAmYYFCRiioFv0/4fQ8
         ZPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585379; x=1788190179;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rIIxKJ/h4TdOX2PzM8xN9SJKh2HJ62O9uv+0COVNyBw=;
        b=YkXLJCZgrvjywhhrdyRpgkkf83pPROe7AgPxeYjGGZgDYYjB9GcW4xvKKOpI1Vklrj
         qJvYykR+LD5Ue8PU28XwIMnujwSoogSAVugWOUmMguQwFPkx6xG6pr8TMLDWPbevqSaR
         Y8G3rEwTItKbJzKdI8mbt8gWdFDIzlY94hxVAqDXqVQuRq8F4Fk2/DZVzTFsrEUajkrC
         W5cW6qSq6LGLK5oEU+NQxV0ilar1Pik9i5Nh+h4RZVKEU/JxzvgMWDGs0xI4AbKbeERA
         eRJdVAxhDSknNBfaD6aWqwNzz7Idzf19oe8qcvc9wokFJZ4nXVRaLMOv6PDNAZ0HvE6T
         mq7A==
X-Forwarded-Encrypted: i=1; AHgh+RrrYcwThpoH4yvFfmmbBVUsgVv2/+ihGn/ABl8z865DYfN1VPR3dWl/lnTj89h0/t64VLGsgQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lfEaKxYZJqhaYzIN4FKR2JFWnmR/ZLtt/P6Q229M1jxBa6fxsF
	v9F8TgSI9WMs7KaQg4Xg5mSj1KXICYS8jJbAMlEfCpcbs3SMutTIEaKE8id60vs5GTvD/EPIVxz
	jlIK3Wg==
X-Received: from ejzq1.prod.google.com ([2002:a17:906:b281:b0:c12:5229:7355])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:f509:b0:c19:49ee:19b9
 with SMTP id a640c23a62f3a-c246a654f4emr3342635466b.15.1787585378467; Mon, 24
 Aug 2026 08:29:38 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:29:30 +0000
In-Reply-To: <20260824152932.1583506-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260824152932.1583506-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824152932.1583506-4-lrizzo@google.com>
Subject: [PATCH v2 3/5] net/swiotlb: Track bounce device per socket
From: Luigi Rizzo <lrizzo@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <lrizzo@google.com>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Record, on each network socket, the underlying hardware device that
requests DMA mapping of tx packets. This is used for nocopy confidential
computing, so that sockets can eventually allocate socket buffers directly
from the swiotlb pools.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/base/core.c       |  1 +
 include/linux/netdevice.h | 21 +++++++++++
 include/linux/swiotlb.h   | 36 +++++++++++++++++++
 include/net/sock.h        | 46 ++++++++++++++++++++++++
 kernel/dma/swiotlb.c      | 73 +++++++++++++++++++++++++++++++++++++++
 net/core/sock.c           | 39 +++++++++++++++++++++
 6 files changed, 216 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a19..091062228740d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3925,6 +3925,7 @@ void device_del(struct device *dev)
 	unsigned int noio_flag;
 
 	device_lock(dev);
+	swiotlb_change_epoch();
 	kill_device(dev);
 	device_unlock(dev);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e6..2457f4e464acf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5429,13 +5429,34 @@ static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
 	return ops->ndo_start_xmit(skb, dev);
 }
 
+struct sock;
+
+#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_PREEMPT_RT)
+/* Per-CPU pointer to the socket currently performing transmission. Used
+ * to bridge the networking and DMA layers, allowing dma_map_page() to
+ * identify the socket originating the packet and apply SWIOTLB optimizations.
+ */
+DECLARE_PER_CPU(struct sock *, current_tx_socket);
+static inline struct sock *__save_current_tx_socket(struct sock *sk)
+{
+	struct sock *old_sk = this_cpu_read(current_tx_socket);
+
+	this_cpu_write(current_tx_socket, sk);
+	return old_sk;
+}
+#else
+static inline struct sock *__save_current_tx_socket(struct sock *sk) { return NULL; }
+#endif
+
 static inline netdev_tx_t netdev_start_xmit(struct sk_buff *skb, struct net_device *dev,
 					    struct netdev_queue *txq, bool more)
 {
+	struct sock *old_sk = __save_current_tx_socket(skb->sk);
 	const struct net_device_ops *ops = dev->netdev_ops;
 	netdev_tx_t rc;
 
 	rc = __netdev_start_xmit(ops, skb, dev, more);
+	__save_current_tx_socket(old_sk);
 	if (rc == NETDEV_TX_OK)
 		txq_trans_update(dev, txq);
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 4661e361c60e4..b1140db3cc397 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -202,6 +202,39 @@ void swiotlb_nocopy_inc_ref(struct io_tlb_pool *pool, phys_addr_t phys);
 void swiotlb_nocopy_dec_ref(struct io_tlb_pool *pool, phys_addr_t phys);
 void swiotlb_prep_compound_page(struct page *page, unsigned int order);
 void swiotlb_destroy_compound_page(struct page *page, unsigned int order);
+void swiotlb_safe_put_device(struct device *dev);
+
+/* Track epoch (number of delete operations) for leaf device info. */
+extern atomic_t global_device_epoch;
+
+static inline u32 swiotlb_dev_epoch(void)
+{
+	return atomic_read(&global_device_epoch);
+}
+
+static inline void swiotlb_change_epoch(void)
+{
+	atomic_inc(&global_device_epoch);
+}
+
+#if defined(CONFIG_NET) && !defined(CONFIG_PREEMPT_RT)
+/*
+ * Track the socket for the currently transmitted packet, so the dma mapping
+ * function can record there the leaf device if it needs bounce buffers.
+ */
+struct sock;
+DECLARE_PER_CPU(struct sock *, current_tx_socket);
+void sk_record_bounce_device(struct sock *sk, struct device *dev);
+static inline void dma_learn_bounce_device(struct device *dev)
+{
+	struct sock *sk = this_cpu_read(current_tx_socket);
+
+	if (sk)
+		sk_record_bounce_device(sk, dev);
+}
+#else
+static inline void dma_learn_bounce_device(struct device *dev) {}
+#endif
 void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_allocated(void);
@@ -258,6 +291,9 @@ static inline phys_addr_t default_swiotlb_limit(void)
 {
 	return 0;
 }
+static inline void swiotlb_safe_put_device(struct device *dev)
+{
+}
 #endif /* CONFIG_SWIOTLB */
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
diff --git a/include/net/sock.h b/include/net/sock.h
index 51185222aac29..39b5e81c7cc55 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -47,6 +47,7 @@
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/mm.h>
 #include <linux/security.h>
+#include <linux/swiotlb.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/page_counter.h>
@@ -70,6 +71,14 @@
 #include <net/l3mdev.h>
 #include <uapi/linux/socket.h>
 
+#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_PREEMPT_RT)
+struct sk_swiotlb_info {
+	struct device __rcu	*dev;
+	u32			epoch;
+	unsigned long		jiffies;
+};
+#endif
+
 /*
  * This structure really needs to be cleaned up.
  * Most of it is for TCP, and not used by any of
@@ -602,8 +611,45 @@ struct sock {
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
 #endif
+#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_PREEMPT_RT)
+	struct sk_swiotlb_info	sk_swiotlb;
+#endif
 };
 
+#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_PREEMPT_RT)
+/*
+ * Clear bounce device on newly initialized or cloned sockets.
+ * Note: During socket cloning, sock_copy() performs a raw bitwise copy of
+ * the parent socket without incrementing the device refcount via get_device().
+ * Therefore, we must zero sk_swiotlb.dev directly here without putting a
+ * reference. References are acquired solely by sk_record_bounce_device() and
+ * released in sk_release_bounce_device().
+ */
+static inline void sk_clear_bounce_device(struct sock *sk)
+{
+	rcu_assign_pointer(sk->sk_swiotlb.dev, NULL);
+}
+
+/*
+ * Release any device reference acquired via sk_record_bounce_device() during
+ * socket transmission and clear the device pointer. Called during socket
+ * destruction (__sk_destruct).
+ */
+static inline void sk_release_bounce_device(struct sock *sk)
+{
+	struct device *dev;
+
+	dev = rcu_dereference_raw(sk->sk_swiotlb.dev);
+	if (dev) {
+		swiotlb_safe_put_device(dev);
+		rcu_assign_pointer(sk->sk_swiotlb.dev, NULL);
+	}
+}
+#else
+static inline void sk_clear_bounce_device(struct sock *sk) {}
+static inline void sk_release_bounce_device(struct sock *sk) {}
+#endif
+
 struct sock_bh_locked {
 	struct sock *sock;
 	local_lock_t bh_lock;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6b86a1e955fb4..d4a07a7c570e1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1683,6 +1683,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	phys_addr_t swiotlb_addr;
 	dma_addr_t dma_addr;
 
+	dma_learn_bounce_device(dev);
+
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
 
 	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
@@ -2085,3 +2087,74 @@ bool swiotlb_pool_is_nocopy(struct io_tlb_pool *pool, phys_addr_t paddr)
 	return pool->slots[index].flags & SWIOTLB_SLOT_NOCOPY;
 }
 EXPORT_SYMBOL_GPL(swiotlb_pool_is_nocopy);
+
+/*
+ * Dropping the reference to sk_swiotlb.dev must be done in two steps:
+ *
+ * 1. Readers inspect the pointer inside RCU critical sections without
+ *    acquiring a reference. Use call_rcu() to wait for an RCU grace period
+ *    to elapse so lockless in-flight readers finish accessing the device.
+ *
+ * 2. The RCU callback executes in atomic softirq context, but put_device()
+ *    can block when releasing a device. Use schedule_work() to transition
+ *    to sleepable process context where calling put_device() is safe.
+ */
+struct swiotlb_deferred_put {
+	struct rcu_head rcu;
+	struct work_struct work;
+	struct device *dev;
+};
+
+static void swiotlb_deferred_put_work(struct work_struct *work)
+{
+	struct swiotlb_deferred_put *dp = container_of(work, struct swiotlb_deferred_put, work);
+
+	/* Stage 2: Safely call put_device (can sleep) in process context */
+	put_device(dp->dev);
+	kfree(dp);
+}
+
+static void swiotlb_deferred_put_rcu(struct rcu_head *rcu)
+{
+	struct swiotlb_deferred_put *dp = container_of(rcu, struct swiotlb_deferred_put, rcu);
+
+	/* RCU grace period has passed. Queue the work to do the actual put */
+	schedule_work(&dp->work);
+}
+
+/**
+ * swiotlb_safe_put_device() - Safely release device reference from atomic/interrupt context
+ * @dev: The device structure to release.
+ *
+ * Enqueues a deferred put_device() call on a workqueue using GFP_ATOMIC.
+ * If memory allocation fails, the reference is leaked to avoid an immediate crash.
+ */
+void swiotlb_safe_put_device(struct device *dev)
+{
+	struct swiotlb_deferred_put *dp;
+
+	if (!dev)
+		return;
+
+	/* Lockless fast-path: if we are not the last reference, decrement is safe */
+	if (refcount_dec_not_one(&dev->kobj.kref.refcount))
+		return;
+
+	/*
+	 * On the last reference we must defer the final put_device() to task
+	 * context because it will trigger device_release() which can sleep.
+	 */
+	dp = kmalloc_obj(*dp, GFP_ATOMIC);
+	if (dp) {
+		INIT_WORK(&dp->work, swiotlb_deferred_put_work);
+		dp->dev = dev;
+		/* Stage 1: Wait for RCU readers to finish */
+		call_rcu(&dp->rcu, swiotlb_deferred_put_rcu);
+	} else {
+		pr_warn_ratelimited("swiotlb: failed to allocate deferred put, leaking device ref\n");
+	}
+}
+EXPORT_SYMBOL_GPL(swiotlb_safe_put_device);
+
+atomic_t global_device_epoch = ATOMIC_INIT(1);
+EXPORT_SYMBOL(global_device_epoch);
diff --git a/net/core/sock.c b/net/core/sock.c
index 1ad41904db25b..ca3e08d3de141 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -103,6 +103,8 @@
 #include <linux/sockios.h>
 #include <linux/net.h>
 #include <linux/mm.h>
+#include <linux/swiotlb.h>
+#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
@@ -152,6 +154,41 @@
 
 #include "dev.h"
 
+#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_PREEMPT_RT)
+
+DEFINE_PER_CPU(struct sock *, current_tx_socket);
+EXPORT_PER_CPU_SYMBOL(current_tx_socket);
+
+void sk_record_bounce_device(struct sock *sk, struct device *dev)
+{
+	struct device *old_dev;
+
+	if (in_hardirq() || !sk_fullsock(sk) || sock_flag(sk, SOCK_ZEROCOPY))
+		return;
+
+	old_dev = rcu_dereference_protected(sk->sk_swiotlb.dev, 1);
+
+	if (dev != old_dev) {
+		/* Rate-limit updates to once per second to prevent bonding thrashing */
+		if (old_dev && time_before(jiffies, sk->sk_swiotlb.jiffies + HZ))
+			return;
+
+		get_device(dev);
+
+		/* Atomically swap in the new device and get the actual old one */
+		old_dev = (struct device *)xchg((struct device __force **)&sk->sk_swiotlb.dev,
+						(struct device __force *)dev);
+
+		WRITE_ONCE(sk->sk_swiotlb.epoch, swiotlb_dev_epoch());
+		sk->sk_swiotlb.jiffies = jiffies;
+
+		/* Only drop the reference to the device we actually replaced */
+		if (old_dev)
+			swiotlb_safe_put_device(old_dev);
+	}
+}
+EXPORT_SYMBOL(sk_record_bounce_device);
+#endif
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
 
@@ -2387,6 +2424,7 @@ static void __sk_destruct(struct rcu_head *head)
 		__netns_tracker_free(net, &sk->ns_tracker, false);
 		net_passive_dec(net);
 	}
+	sk_release_bounce_device(sk);
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
@@ -2489,6 +2527,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 		goto out;
 
 	sock_copy(newsk, sk);
+	sk_clear_bounce_device(newsk);
 
 	newsk->sk_prot_creator = prot;
 #ifdef CONFIG_BPF_SYSCALL
-- 
2.55.0.766.g2966f0265a-goog

