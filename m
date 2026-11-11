Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438502;
	b=y2C0mykFA9fyBNO8twcYI+igQZJSD1Lemn3qTo9/UtyEfj2lzCpne0dIbXAjJppVjCr9
	 sVBTPEW3b4u/EstOyYFyjsRpG65doWuDuqWc+dHgBF0G80t10Q+puQQfmeqdT8p3m/l2e
	 Ei++1DNpAhpn6fspBdubvCZaz5hdKrMLjw4dyGxt8SgkFDpenmHTkUoH6mkQvLDUrY5JY
	 1HAiT5qOadLgv+KBd+h7/a9bcS8A3n6aRe4AavvzT7Bs9zAt/guHTFaH96nQ5+2Xsx/qD
	 uu7DCblJ/hdcHWU2d/R/zhohiCMBZFZ8KL54ZNIrIBWW+Lk/FmWT3qEEkBZMPhI7sYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438502;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=RK7kpfAjoPywfgR+N70hvvGPGWI32V8MYa9gOVo/jjM=;
	b=NdYP1O+nK1O2332nJF+jpd0VVHxqFot6bFIUOraOUfcN5HyhtB6zY2svfo5s9aMw674P
	 eREWvrRGLtqktaf4FkYrO70D8NOocbq4LKKLUp/ju6lnuJjqod+YGDfwopFPdDkMSGYHg
	 2GE9EAo5NDeHpN0R4eESJMJumoZ+yPdXw3rWbsk+ulP2+hJjKLgE4rIewAn4a59PRgNAD
	 J8b8b3+bDnjNk+qMbTIlVjDxqGWQPMCb5XJpt3rULK4C5qKchbn6gP2AA+bXxwiau7ncv
	 y6L6cV7Gq0TKo1e+IdovG/JNjPuj0eYHD4ckH2sq0ryTmTPYvguqbEWUvE5rpovfLRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=pYbMwgFu;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327B606A326
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B327B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=pYbMwgFu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438501; x=1825974501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RK7kpfAjoPywfgR+N70hvvGPGWI32V8MYa9gOVo/jjM=;
  b=pYbMwgFu5Qe470URCMHJ/VkYqaDxrLEQTuek7hqBf4KYMFq2Wsi34vKB
   ojcjncPOEoOKpQDyaPgeTmVMAeTrvTqTUtv6ip3YY4TvdDliHW0U7OdDm
   WmDgnLwmwpJ9AO+shdN7rsvKG9dSyCmYGG96idevXFc03aiBpMQeQ7OgM
   gyHCAApgsaJWZvop8F23dSq68tHNFc4h0cai6O2bvAAaVAOdbOjh4BNJF
   vwoNH6GSYVYV8iGzrpgv6o7CsUsSJ3vbBWDQcUG2Bl1ZYdVHFdLyfFN70
   hWdSILC9lkNiFwR6vezIPIQi/kFBGw3IwCoIMh89bUISrCBxsaiKY5IPJ
   A==;
X-CSE-ConnectionGUID: QcZ0PHCVSS6F/Zir3mxyaw==
X-CSE-MsgGUID: cfTgxcjZTeiYun9AxnbMSQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33789795"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:08:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:9818]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.127:2525] with esmtp (Farcaster)
 id 8d33acb3-6daa-492b-8e6b-b62946e8f22f; Wed, 11 Nov 2026 23:08:21 +0000 (UTC)
X-Farcaster-Flow-ID: 8d33acb3-6daa-492b-8e6b-b62946e8f22f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:08:20 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:08:18 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	<nh-open-source@amazon.com>, <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: [PATCH 30/40] nitro_enclaves: Count multiplexed interrupts under debugfs
Date: Wed, 11 Nov 2026 22:59:34 +0000
Message-ID: <b1e780eafc116a5e31c5bee606aee7f152b35d0c.1794393491.git.graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1794300002.git.graf@amazon.com>
References: <cover.1794300002.git.graf@amazon.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

To debug event delivery of Nitro Sandboxes, count what the multiplexer
handler and a bind do, and report it under debugfs:

  /sys/kernel/debug/nitro_enclaves/mux_vectors
  /sys/kernel/debug/nitro_enclaves/notifications

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c |  9 ++-
 drivers/virt/nitro_enclaves/ne_pci_dev.c  | 84 +++++++++++++++++++++++
 drivers/virt/nitro_enclaves/ne_pci_dev.h  | 19 +++++
 3 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index d47fc8b514bcc..80ca23cd18251 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -2075,10 +2075,15 @@ static int ne_set_notify_eventfd(struct ne_enclave *ne_enclave,
 	 * a bit with an atomic read-modify-write on the same word, so exactly
 	 * one of the two consumes it. The bitmap words are the width the device
 	 * writes them in, which is the width the bit numbering of the handler
-	 * is in as well.
+	 * is in as well. Count the bit as delivered here, so that a bit this path
+	 * takes is counted where it is taken the way one the handler takes is.
 	 */
-	if (test_and_clear_bit(bit, (unsigned long *)ne_pci_dev->mux[vec_rel].bitmap))
+	if (test_and_clear_bit(bit, (unsigned long *)ne_pci_dev->mux[vec_rel].bitmap)) {
+		atomic64_inc(&ne_pci_dev->mux[vec_rel].nr_delivered);
+		atomic64_inc(&binding->nr_signals);
+
 		eventfd_signal(binding->ctx);
+	}
 
 	mutex_unlock(&ne_enclave->enclave_info_mutex);
 
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index cedf828240214..4678799998f4a 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitops.h>
 #include <linux/cma.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -23,6 +24,7 @@
 #include <linux/nitro_enclaves.h>
 #include <linux/nodemask.h>
 #include <linux/pci.h>
+#include <linux/seq_file.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -649,6 +651,9 @@ static bool ne_mux_scan(struct ne_mux_vec *mux_vec)
 			if (!binding)
 				continue;
 
+			atomic64_inc(&mux_vec->nr_delivered);
+			atomic64_inc(&binding->nr_signals);
+
 			eventfd_signal(binding->ctx);
 		}
 	}
@@ -670,6 +675,8 @@ static irqreturn_t ne_mux_handler(int irq, void *data)
 	struct ne_mux_vec *mux_vec = data;
 	u32 pass = 0;
 
+	atomic64_inc(&mux_vec->nr_interrupts);
+
 	/*
 	 * xa_load() drops its own RCU read-side before it returns, so take one
 	 * here to keep a binding alive for as long as it is dereferenced.
@@ -698,6 +705,66 @@ static irqreturn_t ne_mux_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * The multiplexer's debugfs files, under /sys/kernel/debug/nitro_enclaves/.
+ *
+ *   mux_vectors		one row per pooled MSI-X vector
+ *   notifications		one row per bound enclave notification
+ *
+ * A row is rendered without serialising against the handler or against a bind,
+ * so it holds a snapshot of each counter and not one of the pool.
+ */
+
+static int ne_mux_vectors_show(struct seq_file *s, void *unused)
+{
+	struct ne_pci_dev *ne_pci_dev = s->private;
+	u32 i = 0;
+
+	seq_puts(s, "vector msix interrupts delivered max_bit\n");
+
+	for (i = 0; i < ne_pci_dev->mux_nr_vecs; i++) {
+		struct ne_mux_vec *mux_vec = &ne_pci_dev->mux[i];
+
+		seq_printf(s, "%6u %4u %10lld %9lld %7u\n",
+			   i, ne_pci_dev->mux_vec_base + i,
+			   atomic64_read(&mux_vec->nr_interrupts),
+			   atomic64_read(&mux_vec->nr_delivered),
+			   READ_ONCE(mux_vec->max_bit));
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ne_mux_vectors);
+
+static int ne_notifications_show(struct seq_file *s, void *unused)
+{
+	struct ne_pci_dev *ne_pci_dev = s->private;
+	struct ne_mux_binding *binding = NULL;
+	unsigned long notify_index = 0;
+
+	seq_puts(s, "index vector bit signals\n");
+
+	/*
+	 * A replaced or erased binding is freed after a grace period by
+	 * ne_mux_binding_free_rcu(), so hold the RCU read side across the walk
+	 * the way ne_mux_handler() does. seq_printf() renders into the
+	 * seq_file buffer and does not sleep.
+	 */
+	rcu_read_lock();
+
+	xa_for_each(&ne_pci_dev->notify_xa, notify_index, binding)
+		seq_printf(s, "%5lu %6lu %3lu %7lld\n",
+			   notify_index,
+			   notify_index % ne_pci_dev->mux_nr_vecs,
+			   notify_index / ne_pci_dev->mux_nr_vecs,
+			   atomic64_read(&binding->nr_signals));
+
+	rcu_read_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ne_notifications);
+
 /**
  * ne_mux_teardown() - Take the interrupt multiplexer bitmaps back from the
  *		       device.
@@ -712,6 +779,16 @@ static void ne_mux_teardown(struct pci_dev *pdev)
 	unsigned long notify_index = 0;
 	u32 i = 0;
 
+	/*
+	 * The walk in ne_notifications_show() is kept safe by the RCU read
+	 * side against the deferred free, and not against the loop below,
+	 * which frees the surviving bindings outright. Take the files away
+	 * first: debugfs_remove_recursive() waits for a reader that is already
+	 * in one.
+	 */
+	debugfs_remove_recursive(ne_pci_dev->debugfs_dir);
+	ne_pci_dev->debugfs_dir = NULL;
+
 	if (!ne_pci_dev->mux)
 		return;
 
@@ -864,6 +941,13 @@ static int ne_mux_setup(struct pci_dev *pdev)
 		ne_pci_dev->mux[i].irq_requested = true;
 	}
 
+	ne_pci_dev->debugfs_dir = debugfs_create_dir("nitro_enclaves", NULL);
+
+	debugfs_create_file("mux_vectors", 0400, ne_pci_dev->debugfs_dir,
+			    ne_pci_dev, &ne_mux_vectors_fops);
+	debugfs_create_file("notifications", 0400, ne_pci_dev->debugfs_dir,
+			    ne_pci_dev, &ne_notifications_fops);
+
 	return 0;
 
 teardown_mux:
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index 18aafe8111a67..71aaa8f557679 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -669,6 +669,11 @@ struct ne_slot_pool_run {
  *				bound to, bounding the scan of @bitmap. It only
  *				rises, so a scan reads the words of bindings that
  *				are gone as well.
+ * @nr_interrupts:		Interrupts this vector's handler has taken.
+ * @nr_delivered:		Bits it has taken out of @bitmap and delivered
+ *				to an eventfd. An interrupt can deliver several
+ *				bits, and one that finds no bit it can deliver
+ *				delivers none.
  * @ne_pci_dev:			NE PCI device this vector belongs to.
  * @vec_rel:			Index of this vector within the pool.
  * @irq_requested:		Whether the interrupt handler of this vector is
@@ -679,6 +684,8 @@ struct ne_slot_pool_run {
 struct ne_mux_vec {
 	u64			*bitmap;
 	u32			max_bit;
+	atomic64_t		nr_interrupts;
+	atomic64_t		nr_delivered;
 	struct ne_pci_dev	*ne_pci_dev;
 	u32			vec_rel;
 	bool			irq_requested;
@@ -691,10 +698,13 @@ struct ne_mux_vec {
  * @rcu:			Head used to free the binding after a grace
  *				period, so that an interrupt handler which
  *				already loaded it can still dereference it.
+ * @nr_signals:			Times @ctx has been signalled for this
+ *				notification.
  */
 struct ne_mux_binding {
 	struct eventfd_ctx	*ctx;
 	struct rcu_head		rcu;
+	atomic64_t		nr_signals;
 };
 
 /**
@@ -706,6 +716,14 @@ struct ne_mux_binding {
  *				the device after that.
  * @cmd_reply_wait_q:		Wait queue for handling command reply from the
  *				PCI device.
+ * @debugfs_dir:		Directory holding the multiplexer's debugfs
+ *				files. NULL until the multiplexer pool is set up
+ *				and once it is torn down. debugfs_create_dir()
+ *				answers with an error pointer rather than NULL
+ *				where debugfs is not built in or the directory
+ *				could not be made, and the calls that take it
+ *				turn such a pointer down themselves, so it is
+ *				kept as it came.
  * @enclaves_list:		List of the enclaves managed by the PCI device.
  * @enclaves_list_mutex:	Mutex for accessing the list of enclaves.
  * @event_wq:			Work queue for handling out-of-band events
@@ -747,6 +765,7 @@ struct ne_pci_dev {
 	atomic_t		cmd_reply_avail;
 	bool			failed;
 	wait_queue_head_t	cmd_reply_wait_q;
+	struct dentry		*debugfs_dir;
 	struct list_head	enclaves_list;
 	struct mutex		enclaves_list_mutex;
 	struct workqueue_struct	*event_wq;
-- 
2.47.1

