Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438571;
	b=Z3wGaOEFx3KK2XFbLJVc39A9kE6+S+TJcfkXGszAvZCLj8WTgt0r7Spu03H2nPLMSilF
	 0HIdLDwsKl4kVKJv6EnmiCHpZ9Iksvwaa4NWa/O78U0ZOlJLmbGIWF8op/0VTmCcxg7iW
	 SPpDYZh4qureBf8CjqDpK8YiiYE+qGLFP7JW8P9tGII4L2mknOoTv5tZZvzyk0b31CE+1
	 KlGcF9izxyVRNDzq/55RGEj20Q6sYln53XF2ZFNrhff+52+AMl4s8rMgio2Q9pDJAWaiU
	 tre2nNoTe7BfdO9O8siO3Q34l0jUqcDL9eFzOLGRzuF6mBTyeuNKVKd/98g6Sq0ZBww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=+WbEucm/NTdicaxUIqSbDPQ1RzHPTc2+7fUrt3GmyyM=;
	b=qaOWnqoY7SqVSNuYZVbq1wIzcIXojo9v3oJaPkKdBIYCWLaiOA11d34dP5bJwJ4W59Am
	 gW3eWz5cy9CapzcaXG0z24eAOgLz/jr7kLMihca0oZNELBBoiRU+Wr2K2ce2waJiVcAMe
	 5+6dZHySaOr1QeC9bH5KA/Hxd8MoXeL9fg6W7k7TXqc+8lD+tKJye0kWcpILFWn0KpHuH
	 H686bpgvRRrvzTm7Lp+Uuz93U4XwIhSg3kNr6walctZstlRErc5CgCd3GghRNleuTQRXQ
	 ISBSEqmiIxu1E19eb8LPmgJn9KlK//jcevW+hLfyhjsGPmaGVM7FJWL29kJ9/0ZjtoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WufunhDx;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38433606A321
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38433606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=WufunhDx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438570; x=1825974570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WbEucm/NTdicaxUIqSbDPQ1RzHPTc2+7fUrt3GmyyM=;
  b=WufunhDxtpcR8H16IGwK2DDiyQhNeZWAkwulYmPnsFoWgINIfSk0gpfS
   aGal/M5/o+09wNCYHesTxjbBhgHrCttCOzLIRpfDuRyRI2Qo9TZpJQuRa
   Q5iNBvPn/TneO9JxGTmRd/RrQCKu65HOf9k4jG+1wf+QEZztdOX3JrLgD
   7V1YGDhEiUIXkgOU83x7xGPVLglBYEZ/DfucNUm7jMovvVxtfsiaOZZFF
   Da0sdfG9R6qUJqg4wZBypa8BpgQd7BpuCV3uau91PjSCl/ZJtp+HJ3Ipg
   i28MTo8Zdaa49V1VGhTZaYoDZre5wEtCLL5CburxZse/VXwMgk4mgRq88
   A==;
X-CSE-ConnectionGUID: vVK+CoXZQt6ArJlkP5aUeA==
X-CSE-MsgGUID: TwnWeJI+TtCBtJklJVMd4Q==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33663665"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:09:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:28423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.141:2525] with esmtp (Farcaster)
 id 794bf9a5-bbbb-4dbe-8a8a-3d74948f90ab; Wed, 11 Nov 2026 23:09:29 +0000 (UTC)
X-Farcaster-Flow-ID: 794bf9a5-bbbb-4dbe-8a8a-3d74948f90ab
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:09:29 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:09:26 +0000
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
Subject: [PATCH 32/40] nitro_enclaves: Add NE_SET_VRING_CALL
Date: Wed, 11 Nov 2026 22:59:36 +0000
Message-ID: <3dcf974ea023b8005258bb890b0564abc482e88c.1794393491.git.graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Nitro Sandboxes let a device backend in the parent tell the sandbox that
a virtqueue has data waiting. Give user space a path to trigger this by
signalling an eventfd. The driver then turns that signal into a write
to the doorbell of the queue.

Add NE_SET_VRING_CALL, which binds an eventfd to a doorbell offset that
NE_ADD_DEVICE reported to the same enclave.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 357 +++++++++++++++++++++-
 drivers/virt/nitro_enclaves/ne_misc_dev.h |  33 +-
 include/uapi/linux/nitro_enclaves.h       |  52 ++++
 3 files changed, 434 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 80ca23cd18251..e2ff807ec673e 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -2136,6 +2136,328 @@ static void ne_enclave_remove_all_notify_binding_entries(struct ne_enclave *ne_e
 	}
 }
 
+/**
+ * ne_doorbell_write() - Ring the doorbell of the virtqueue of a binding.
+ * @binding:	Doorbell binding with its doorbell address set.
+ *
+ * Context: Process context or interrupt context.
+ */
+static void ne_doorbell_write(struct ne_doorbell_binding *binding)
+{
+	iowrite16(binding->offset / sizeof(u16), binding->doorbell);
+}
+
+/**
+ * ne_doorbell_ring() - Ring the doorbell of the virtqueue an eventfd is bound
+ *			to.
+ * @wait:	Wait queue entry of the binding, sitting on the eventfd.
+ * @mode:	Wake up mode, unused.
+ * @sync:	Wake up sync flag, unused.
+ * @key:	Poll events the eventfd has woken up for.
+ *
+ * Context: Process context or interrupt context.
+ * Return: 0, so that the entry keeps sitting on the eventfd.
+ */
+static int ne_doorbell_ring(wait_queue_entry_t *wait, unsigned int mode,
+			    int sync, void *key)
+{
+	struct ne_doorbell_binding *binding = NULL;
+	u64 cnt = 0;
+
+	if (!(key_to_poll(key) & EPOLLIN))
+		return 0;
+
+	binding = container_of(wait, struct ne_doorbell_binding, wait);
+
+	eventfd_ctx_do_read(binding->ctx, &cnt);
+
+	ne_doorbell_write(binding);
+
+	return 0;
+}
+
+/**
+ * ne_doorbell_queue_proc() - Put the wait queue entry of a doorbell binding on
+ *			      the wait queue of its eventfd.
+ * @file:	Eventfd the binding is being armed on.
+ * @wqh:	Wait queue head of the eventfd.
+ * @pt:		Poll table of the binding.
+ *
+ * Context: Process context.
+ */
+static void ne_doorbell_queue_proc(struct file *file, wait_queue_head_t *wqh,
+				   poll_table *pt)
+{
+	struct ne_doorbell_binding *binding = NULL;
+
+	binding = container_of(pt, struct ne_doorbell_binding, pt);
+
+	binding->wqh = wqh;
+
+	add_wait_queue(wqh, &binding->wait);
+}
+
+/**
+ * ne_doorbell_arm() - Have a signal of an eventfd ring the doorbell of a
+ *		       binding.
+ * @binding:	Doorbell binding with its eventfd and doorbell address set.
+ * @file:	Eventfd of the binding.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex
+ *	    held.
+ */
+static void ne_doorbell_arm(struct ne_doorbell_binding *binding,
+			    struct file *file)
+{
+	__poll_t mask = 0;
+
+	init_waitqueue_func_entry(&binding->wait, ne_doorbell_ring);
+	init_poll_funcptr(&binding->pt, ne_doorbell_queue_proc);
+
+	mask = vfs_poll(file, &binding->pt);
+
+	/*
+	 * Ring for a signal the eventfd was already carrying. The count stays
+	 * on the eventfd for the wake up path to take, which runs with the
+	 * lock eventfd_ctx_do_read() needs held.
+	 */
+	if (mask & EPOLLIN)
+		ne_doorbell_write(binding);
+}
+
+/**
+ * ne_doorbell_disarm() - Stop a signal of an eventfd from ringing the doorbell
+ *			  of a binding and give up the eventfd.
+ * @binding:	Armed doorbell binding.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex
+ *	    held.
+ */
+static void ne_doorbell_disarm(struct ne_doorbell_binding *binding)
+{
+	remove_wait_queue(binding->wqh, &binding->wait);
+
+	eventfd_ctx_put(binding->ctx);
+}
+
+/**
+ * ne_doorbell_binding_remove() - Remove one doorbell binding from the enclave
+ *				  that owns it.
+ * @binding:	Doorbell binding of the enclave.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex
+ *	    held.
+ */
+static void ne_doorbell_binding_remove(struct ne_doorbell_binding *binding)
+{
+	ne_doorbell_disarm(binding);
+
+	list_del(&binding->doorbell_binding_list_entry);
+
+	kfree(binding);
+}
+
+/**
+ * ne_enclave_remove_all_doorbell_binding_entries() - Remove all the doorbell
+ *						     binding entries from the
+ *						     enclave data structure.
+ * @ne_enclave:	Private data associated with the current enclave.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex
+ *	    held.
+ */
+static void ne_enclave_remove_all_doorbell_binding_entries(struct ne_enclave *ne_enclave)
+{
+	struct ne_doorbell_binding *binding = NULL;
+	struct ne_doorbell_binding *binding_tmp = NULL;
+
+	list_for_each_entry_safe(binding, binding_tmp,
+				 &ne_enclave->doorbell_bindings,
+				 doorbell_binding_list_entry)
+		ne_doorbell_binding_remove(binding);
+}
+
+/**
+ * ne_del_vring_call() - Release the eventfd bound to the doorbell of an enclave
+ *			 virtqueue.
+ * @ne_enclave:		Private data associated with the current enclave.
+ * @doorbell_offset:	Offset the NE PCI device gave the doorbell of the
+ *			virtqueue in the doorbell window.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0 on success.
+ * * Negative return value on failure.
+ */
+static int ne_del_vring_call(struct ne_enclave *ne_enclave, u16 doorbell_offset)
+{
+	struct ne_doorbell_binding *binding = NULL;
+	struct ne_doorbell_binding *entry = NULL;
+	int rc;
+
+	rc = mutex_lock_killable(&ne_enclave->enclave_info_mutex);
+	if (rc)
+		return rc;
+
+	list_for_each_entry(entry, &ne_enclave->doorbell_bindings,
+			    doorbell_binding_list_entry) {
+		if (entry->offset == doorbell_offset) {
+			binding = entry;
+
+			break;
+		}
+	}
+
+	if (!binding) {
+		mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+		return -ENOENT;
+	}
+
+	ne_doorbell_binding_remove(binding);
+
+	mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+	return 0;
+}
+
+/**
+ * ne_enclave_owns_doorbell() - Check that NE_ADD_DEVICE reported a doorbell
+ *				offset to an enclave.
+ * @ne_enclave :	Private data associated with the current enclave.
+ * @offset:		Doorbell offset to look for.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex
+ *	    held.
+ * Return: true if one of the enclave's devices has the doorbell.
+ */
+static bool ne_enclave_owns_doorbell(struct ne_enclave *ne_enclave, u16 offset)
+{
+	struct ne_device_wiring *dev = NULL;
+	unsigned int i = 0;
+
+	list_for_each_entry(dev, &ne_enclave->devices, list_entry)
+		for (i = 0; i < dev->num_vqs; i++)
+			if (dev->doorbell_offset[i] == offset)
+				return true;
+
+	return false;
+}
+
+/**
+ * ne_set_vring_call() - Bind an eventfd to the doorbell of an enclave
+ *			 virtqueue, or release the binding on that doorbell.
+ * @ne_enclave:		Private data associated with the current enclave.
+ * @vring_call:	The doorbell and the eventfd, or the doorbell alone when the
+ *		eventfd is NE_EVENTFD_UNBIND.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0 on success.
+ * * Negative return value on failure.
+ */
+static int ne_set_vring_call(struct ne_enclave *ne_enclave,
+			     struct ne_vring_call *vring_call)
+{
+	struct ne_pci_dev *ne_pci_dev = ne_devs.ne_pci_dev;
+	struct ne_doorbell_binding *binding = NULL;
+	struct ne_doorbell_binding *entry = NULL;
+	struct eventfd_ctx *ctx = NULL;
+	bool rebind = false;
+	int rc = -EINVAL;
+
+	if (vring_call->reserved)
+		return -EINVAL;
+
+	if (!ne_pci_dev->doorbell_base)
+		return -EOPNOTSUPP;
+
+	if (ne_pci_dev->doorbell_len < sizeof(u16) ||
+	    vring_call->doorbell_offset > ne_pci_dev->doorbell_len - sizeof(u16))
+		return -EINVAL;
+
+	/*
+	 * An unaligned MMIO access is undefined on some of the architectures
+	 * the driver builds for.
+	 */
+	if (!IS_ALIGNED(vring_call->doorbell_offset, sizeof(u16)))
+		return -EINVAL;
+
+	if (vring_call->fd == NE_EVENTFD_UNBIND)
+		return ne_del_vring_call(ne_enclave, vring_call->doorbell_offset);
+
+	/*
+	 * Take the eventfd from the file the fd resolves to and arm the
+	 * binding on that same file, so that the eventfd a signal arrives on
+	 * is the eventfd the binding rings for.
+	 */
+	CLASS(fd, f)(vring_call->fd);
+	if (fd_empty(f))
+		return -EBADF;
+
+	ctx = eventfd_ctx_fileget(fd_file(f));
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	rc = mutex_lock_killable(&ne_enclave->enclave_info_mutex);
+	if (rc)
+		goto put_ctx;
+
+	/*
+	 * The doorbell window spans the whole NE PCI device, so an enclave only
+	 * binds the doorbells NE_ADD_DEVICE reported to it.
+	 */
+	if (!ne_enclave_owns_doorbell(ne_enclave, vring_call->doorbell_offset)) {
+		rc = -EINVAL;
+
+		goto unlock_mutex;
+	}
+
+	list_for_each_entry(entry, &ne_enclave->doorbell_bindings,
+			    doorbell_binding_list_entry) {
+		if (entry->offset == vring_call->doorbell_offset) {
+			rebind = true;
+
+			break;
+		}
+	}
+
+	if (rebind) {
+		binding = entry;
+
+		ne_doorbell_disarm(binding);
+	} else {
+		binding = kzalloc_obj(*binding);
+		if (!binding) {
+			rc = -ENOMEM;
+
+			goto unlock_mutex;
+		}
+
+		binding->doorbell = ne_pci_dev->doorbell_base +
+				    vring_call->doorbell_offset;
+		binding->offset = vring_call->doorbell_offset;
+
+		list_add(&binding->doorbell_binding_list_entry,
+			 &ne_enclave->doorbell_bindings);
+	}
+
+	binding->ctx = ctx;
+
+	ne_doorbell_arm(binding, fd_file(f));
+
+	mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+	return 0;
+
+unlock_mutex:
+	mutex_unlock(&ne_enclave->enclave_info_mutex);
+put_ctx:
+	eventfd_ctx_put(ctx);
+
+	return rc;
+}
+
 /**
  * ne_enclave_do_ioctl() - Ioctl function provided by the enclave file.
  * @file:	File associated with this ioctl function.
@@ -2609,6 +2931,22 @@ static long ne_enclave_do_ioctl(struct file *file, unsigned int cmd, unsigned lo
 		return ne_set_notify_eventfd(ne_enclave, &args);
 	}
 
+	case NE_EA_IOCTL(NE_SET_VRING_CALL): {
+		struct ne_vring_call __user *uargs = (void __user *)arg;
+		unsigned int usize = _IOC_SIZE(cmd);
+		struct ne_vring_call args;
+		int rc;
+
+		if (usize < offsetofend(struct ne_vring_call, doorbell_offset))
+			return -EINVAL;
+
+		rc = copy_struct_from_user(&args, sizeof(args), uargs, usize);
+		if (rc)
+			return rc;
+
+		return ne_set_vring_call(ne_enclave, &args);
+	}
+
 	default:
 		return -ENOTTY;
 	}
@@ -2796,12 +3134,15 @@ int ne_enclave_free_slot(struct ne_pci_dev *ne_pci_dev,
 			   &cmd_reply, sizeof(cmd_reply));
 
 	/*
-	 * The notify index of a queue belongs to the slot, so the device is free
-	 * to give it to another enclave once the slot is freed. Take the
-	 * bindings of this enclave out of the xarray the handler looks them up
-	 * in before that, or a bind for the reissued index finds the entry
-	 * still taken. This happens whether or not the stop went through,
-	 * because an unbind of the device tears the multiplexer down next.
+	 * The notify index of a queue and the offset of its doorbell belong to
+	 * the slot, so the device is free to give either to another enclave once
+	 * the slot is freed. Take the bindings of this enclave out of the xarray
+	 * the handler looks them up in, and off the eventfds that ring their
+	 * doorbells, before that. Otherwise a bind for the reissued index finds
+	 * the entry still taken, and a signal on an eventfd left armed rings a
+	 * doorbell the device has given away. This happens whether or not the
+	 * stop went through, because an unbind of the device tears the
+	 * multiplexer and the doorbell window down next.
 	 *
 	 * A handler that looked up a binding of this enclave before it was
 	 * erased here can still be running. Were the index reissued under it,
@@ -2815,6 +3156,8 @@ int ne_enclave_free_slot(struct ne_pci_dev *ne_pci_dev,
 		synchronize_rcu();
 	}
 
+	ne_enclave_remove_all_doorbell_binding_entries(ne_enclave);
+
 	if (rc < 0)
 		return rc;
 
@@ -3098,6 +3441,7 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 flags,
 	ne_enclave->max_mem_regions = cmd_reply.alloc.mem_regions;
 	INIT_LIST_HEAD(&ne_enclave->contig_regions_list);
 	INIT_LIST_HEAD(&ne_enclave->device_regions_list);
+	INIT_LIST_HEAD(&ne_enclave->doorbell_bindings);
 	INIT_LIST_HEAD(&ne_enclave->mem_regions_list);
 	ne_enclave->mm = current->mm;
 	ne_enclave->slot_uid = cmd_reply.alloc.slot_uid;
@@ -4860,6 +5204,7 @@ static int ne_add_device_ioctl(struct ne_enclave *ne_enclave,
 		args->vq_info[i].doorbell_offset = wiring[i].doorbell_offset;
 
 		dev->notify_index[i] = wiring[i].notify_index;
+		dev->doorbell_offset[i] = wiring[i].doorbell_offset;
 	}
 
 	args->device_uid = cmd_reply.add_device.device_uid;
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.h b/drivers/virt/nitro_enclaves/ne_misc_dev.h
index 0df403f0080e5..f9ef79fafa2be 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.h
@@ -7,12 +7,14 @@
 #define _NE_MISC_DEV_H_
 
 #include <linux/cpumask.h>
+#include <linux/eventfd.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/rwsem.h>
+#include <linux/poll.h>
 #include <linux/wait.h>
 
 #include "ne_pci_dev.h"
@@ -120,12 +122,14 @@ struct ne_mem_region {
  * @info_notify_index:	Notification the enclave raises when it has changed
  *			the info page of the device.
  * @notify_index:	Notify index of each virtqueue of the device.
+ * @doorbell_offset:	Doorbell offset of each virtqueue of the device.
  */
 struct ne_device_wiring {
 	struct list_head	list_entry;
 	u32			num_vqs;
 	u32			info_notify_index;
 	u32			notify_index[NE_MAX_VQS_PER_DEVICE];
+	u16			doorbell_offset[NE_MAX_VQS_PER_DEVICE];
 };
 
 /**
@@ -140,8 +144,32 @@ struct ne_notify_binding {
 	unsigned long		notify_index;
 };
 
+/**
+ * struct ne_doorbell_binding - Entry in the list of enclave doorbell bindings.
+ * @ctx:			Eventfd whose signal rings the doorbell.
+ * @doorbell:			Address of the doorbell in the doorbell window.
+ * @doorbell_binding_list_entry: Entry in the list of enclave doorbell
+ *				bindings.
+ * @offset:			Offset of the doorbell in the doorbell window.
+ * @pt:				Poll table that registers @wait on the eventfd.
+ * @wait:			Wait queue entry woken up when the eventfd is
+ *				signalled.
+ * @wqh:			Wait queue head of the eventfd @wait sits on.
+ */
+struct ne_doorbell_binding {
+	struct eventfd_ctx	*ctx;
+	void __iomem		*doorbell;
+	struct list_head	doorbell_binding_list_entry;
+	u16			offset;
+	poll_table		pt;
+	wait_queue_entry_t	wait;
+	wait_queue_head_t	*wqh;
+};
+
 /**
  * struct ne_enclave - Per-enclave data used for enclave lifetime management.
+ * @doorbell_bindings:		List of the virtqueue doorbells this enclave has
+ *				bound an eventfd to.
  * @enclave_info_mutex :	Mutex for accessing this internal state.
  * @detached:			The NE PCI device the enclave was created on is
  *				gone. Written with ne_devs.lock held for writing.
@@ -171,8 +199,8 @@ struct ne_notify_binding {
  *				an eventfd to.
  * @devices:			List of struct ne_device_wiring, one for each device
  *				%NE_ADD_DEVICE gave the enclave. The notify indices
- *				in it are the only ones the enclave may bind an
- *				eventfd to.
+ *				and doorbell offsets in it are the only ones the
+ *				enclave may bind an eventfd to.
  * @max_mem_regions:		The maximum number of memory regions that can be
  *				handled by the hypervisor.
  * @mem_regions_list:		Enclave user space memory regions list.
@@ -196,6 +224,7 @@ struct ne_notify_binding {
  * @vcpu_ids:			Cpumask of the vCPUs that are set for the enclave.
  */
 struct ne_enclave {
+	struct list_head	doorbell_bindings;
 	struct mutex		enclave_info_mutex;
 	bool			detached;
 	bool			slot_freed;
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index 4f2ca77f1b827..01bec4d072d6a 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -1146,4 +1146,56 @@ struct ne_notify_eventfd {
 	__u32	notify_index;
 };
 
+/**
+ * NE_SET_VRING_CALL - The command is used to bind an eventfd to the doorbell
+ *		       of one enclave virtqueue. When the eventfd is signalled,
+ *		       the driver rings the doorbell and the enclave learns that
+ *		       the queue has data waiting for it. The caller names the
+ *		       doorbell by the offset %NE_ADD_DEVICE reported for it in
+ *		       @vq_info, and the driver takes no other offset. A
+ *		       doorbell the caller has already bound is rebound to the
+ *		       new eventfd, and %NE_EVENTFD_UNBIND releases the binding
+ *		       the caller holds on the doorbell. The ioctl can be
+ *		       invoked on the enclave fd.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0					- Logic successfully completed.
+ * * -1					- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * ENODEV				- The NE PCI device is not available.
+ * * EFAULT				- Argument read failure.
+ * * EOPNOTSUPP				- The NE PCI device offers no doorbells.
+ * * EINVAL				- The argument is shorter than
+ *					  @doorbell_offset, the offset is not that
+ *					  of a doorbell in the window the device
+ *					  offers, %NE_ADD_DEVICE did not report
+ *					  it to this enclave, @reserved is not
+ *					  zero, or the given fd is not an eventfd.
+ * * EBADF				- There is no open file for the given fd, which
+ *					  is the case for every negative fd other
+ *					  than %NE_EVENTFD_UNBIND.
+ * * E2BIG				- The argument is longer than this kernel knows
+ *					  about and the excess is not all zero.
+ * * ENOMEM				- Memory allocation failure.
+ * * ENOENT				- The caller holds no binding on the doorbell to
+ *					  release.
+ */
+#define NE_SET_VRING_CALL		_IOW(0xAE, 0x27, struct ne_vring_call)
+
+/**
+ * struct ne_vring_call - Eventfd that rings an enclave virtqueue doorbell (in).
+ * @fd:			Eventfd whose signal rings the doorbell, or
+ *			%NE_EVENTFD_UNBIND to release the binding on the
+ *			doorbell (in).
+ * @doorbell_offset:	Offset the NE PCI device gave the doorbell of the
+ *			virtqueue in the doorbell window (in).
+ * @reserved:		Must be zero (in).
+ */
+struct ne_vring_call {
+	__s32	fd;
+	__u16	doorbell_offset;
+	__u16	reserved;
+};
+
 #endif /* _UAPI_LINUX_NITRO_ENCLAVES_H_ */
-- 
2.47.1

