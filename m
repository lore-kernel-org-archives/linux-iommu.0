Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438262;
	b=NwHB0Tw0LQjGLb94KizmxT4XXiCfJ09LP5WZZsqyfkQ2glDHvy0i4mykSqaWlkHvQ1xN
	 Br3FEprFzxY2bNcfTlLBDy6ttSCeZ9mHeG/NPT1DtzMYYVAq46POyPZKyBhyAdUrESc/0
	 oO4vt08R/o7SpqwPTDMgxBE/czJeitauHZyz7mPOzsm+Uk5ABsUo7wi5+ZkBgeuvz0xGu
	 WWjsjAQmnhrYD6P0yJKslL4oN8v6QD71oY85BSUVeeQF3/mCM5ZRiO5+4hoSXMhgStUDE
	 dKefSQ7JX4Y+PSAtr5X9YR3RBgavx1SktYQtvAH9JGHl0SDFTj5An3t5I8nlGrgNKsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438262;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=rOEMGTQJ+toDki7kvuJT6JtXyBGtOp4DrkKcaIoHHvs=;
	b=qE5Ij9Vmlzc3n2pSqnmaLtozFrsYC8tJVOa2kKdriFG/Y4aprHGj/nhtZx2ptyjkCN68
	 8JrAboKwyhnQAyuHZCH9vwOCifaKx3otmSRQGMmU2FRUF/UiJiQcl65EM069SrYYo1zPX
	 3a7Y+3AQdgzPG/h6t8iGMMdfHS7LLZvjH/40Q/dU8389mkj0TZtraTCKOczrI5Vsb6/HA
	 JiEuXk2+RRvrYucMNyMQx/INUtpXB+70IzmI9noR3CnkwZjIwJstlBKYKhKpJ+Rt0we10
	 MRo3+/HviwdmDy3AbAWsZQ68zV3RW7MCL+jVZyVpLbJtS0rN1A+sJ78R8vnjw5Dn+RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=rtVCOguG;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63684606A321
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63684606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=rtVCOguG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438262; x=1825974262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rOEMGTQJ+toDki7kvuJT6JtXyBGtOp4DrkKcaIoHHvs=;
  b=rtVCOguGGmNO80Z1m4GlIpRJWY4vcgLgjRV6rhSp8wtsd1PFaHrvaqEr
   QTsaUgOaIEEM5HWv+PoKtj8FfegOKFoZfwvSSmOzElr1yG5reXpURv9VB
   3AAjcQyT0ygBLBbbirCaMX7muodUinQSSc+wK0SxIsxu8hGvj0YwwY6zk
   kmCRXIKNpcP3HKq8ZmfyuvlU83NIyCVkZ0cuFA12LfmNQifZiMzJD5VJg
   yoEHjPtSOdih0ojKvrTcONDUTm2ukQaCJHdo8OzSegLxk9BAjToQGD8RX
   ZudKA1Lj+4k/wNvxFDq39nn5Z2f+oR+Xkyuk0J0fVMoN3ar8K/X6LA90W
   A==;
X-CSE-ConnectionGUID: BOL+KG0SQnitUQxlhr8h5w==
X-CSE-MsgGUID: eApXz3JaQyqH6tGmqN6HAg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33274440"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:04:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:27510]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id 528610d0-34f0-42c9-9dfc-8b5d0d7b78d3; Wed, 11 Nov 2026 23:04:21 +0000 (UTC)
X-Farcaster-Flow-ID: 528610d0-34f0-42c9-9dfc-8b5d0d7b78d3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:04:21 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:04:18 +0000
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
Subject: [PATCH 23/40] nitro_enclaves: Add the device add command
Date: Wed, 11 Nov 2026 22:59:27 +0000
Message-ID: <94acc8f58f24e29912b8859859d739460cb74406.1794393490.git.graf@amazon.com>
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

In preparation to support Nitro Sandboxes, which allow the parent to
back arbitrary virtio devices, add the command definition for adding
devices to a slot.

The device add command specifies the virtio device shape (type, nr VQs,
features, config space), but also allows to specify backing ranges for
DMB or SHM regions.

The full response with the device information is part of the info page
at the returned offset.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_pci_dev.h | 88 ++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index f5cb24312d442..3445318b84672 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -161,6 +161,7 @@
  * @SLOT_ADD_BULK_VCPUS:	Add a number of vCPUs, not providing CPU ids.
  * @SLOT_ADD_INFO_PAGE:		Give a slot the info page, a memory region the
  *				device writes.
+ * @SLOT_ADD_DEVICE:		Give a slot a device the enclave will drive.
  * @SLOT_POOL_DONATE:		Donate one page of parent memory to the slot
  *				pool.
  * @SLOT_POOL_SHUTDOWN:		Give the whole slot pool back.
@@ -186,6 +187,7 @@ enum ne_pci_dev_cmd_type {
 	SLOT_ADD_BULK_VCPUS	= 11,
 	/* 12 is a command this driver does not implement. */
 	SLOT_ADD_INFO_PAGE	= 13,
+	SLOT_ADD_DEVICE		= 14,
 	SLOT_POOL_DONATE	= 16,
 	SLOT_POOL_SHUTDOWN	= 17,
 	SLOT_POOL_BASE_DONATE	= 25,
@@ -333,6 +335,73 @@ struct slot_add_info_page_req {
 	u64	info_size;
 };
 
+/**
+ * NE_MAX_VQS_PER_DEVICE - Highest number of virtqueues one device may have.
+ */
+#define NE_MAX_VQS_PER_DEVICE		(64)
+
+/**
+ * NE_MAX_BACKING_RANGES - Highest number of memory ranges one device may be
+ *			   backed by.
+ */
+#define NE_MAX_BACKING_RANGES		(4)
+
+/**
+ * struct ne_backing_range - One run of enclave memory a device works out of.
+ * @phys_addr:	Physical address of the run, in the parent's address space.
+ * @size:	Size, in bytes, of the run.
+ */
+struct ne_backing_range {
+	u64	phys_addr;
+	u64	size;
+};
+
+/**
+ * struct ne_vq_wiring - How the enclave reaches one virtqueue of a device.
+ * @msix_vector:		Interrupt vector the device raises for the queue.
+ * @notify_index:		Index the enclave writes to notify the device.
+ * @msix_entry:			Entry in the enclave's interrupt table holding
+ *				@msix_vector.
+ * @doorbell_offset:		Offset of the queue's doorbell in the device's
+ *				doorbell window.
+ */
+struct ne_vq_wiring {
+	u16	msix_vector;
+	u16	notify_index;
+	u16	msix_entry;
+	u16	doorbell_offset;
+};
+
+static_assert(sizeof(struct ne_vq_wiring) == 8);
+
+/**
+ * struct slot_add_device_req - SLOT_ADD_DEVICE request.
+ * @slot_uid:			Slot unique id mapped to the slot to give the
+ *				device to.
+ * @device_type:		Type of device to give the slot.
+ * @num_vqs:			Number of virtqueues the device has, at most
+ *				NE_MAX_VQS_PER_DEVICE.
+ * @device_features:		Feature bits the parent offers the enclave for
+ *				the device.
+ * @config_size:		Number of bytes of @device_config the device
+ *				reads.
+ * @num_backing_ranges:		Number of entries of @backing_ranges the
+ *				device reads, at most NE_MAX_BACKING_RANGES.
+ * @device_config:		Type-specific configuration of the device.
+ * @backing_ranges:		Runs of enclave memory the device works out of.
+ */
+struct slot_add_device_req {
+	u64	slot_uid;
+	u32	device_type;
+	u32	num_vqs;
+	u8	device_features[64];
+	u32	config_size;
+	u32	num_backing_ranges;
+	u8	device_config[64];
+	struct ne_backing_range backing_ranges[NE_MAX_BACKING_RANGES];
+} __packed;
+static_assert(sizeof(struct slot_add_device_req) <= NE_SEND_DATA_SIZE);
+
 /**
  * struct slot_pool_donate_req - SLOT_POOL_DONATE and SLOT_POOL_BASE_DONATE
  *				 request.
@@ -408,6 +477,15 @@ struct slot_pool_mem_donate_req {
  *				slot out of.
  * @limits.reserved14:		SLOT_POOL_GET_LIMITS. Bytes the device writes as
  *				zero.
+ * @add_device:			Fields SLOT_ADD_DEVICE fills.
+ * @add_device.device_uid:	SLOT_ADD_DEVICE. Unique id of the new device.
+ * @add_device.num_vqs:		SLOT_ADD_DEVICE. Number of entries of wiring
+ *				the device wrote to the info page.
+ * @add_device.reserved12:	SLOT_ADD_DEVICE. Bytes owned by other
+ *				commands.
+ * @add_device.vq_wiring_offset:	SLOT_ADD_DEVICE. Offset into the info
+ *				page at which @num_vqs entries of struct
+ *				ne_vq_wiring start.
  */
 struct ne_pci_dev_cmd_reply {
 	s32	rc;
@@ -443,6 +521,12 @@ struct ne_pci_dev_cmd_reply {
 			u16	slots_per_donation;
 			u16	reserved14;
 		} limits;
+		struct {
+			u64	device_uid;
+			u32	num_vqs;
+			u32	reserved12;
+			u64	vq_wiring_offset;
+		} add_device;
 	};
 };
 
@@ -452,6 +536,10 @@ static_assert(offsetof(struct ne_pci_dev_cmd_reply, start.enclave_cid) == 16);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, alloc.slot_uid) == 8);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, alloc.mem_regions) == 32);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.slot_uid) == 8);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, add_device.device_uid) == 8);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, add_device.num_vqs) == 16);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply,
+		       add_device.vq_wiring_offset) == 24);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.enclave_cid) == 16);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.mem_regions) == 32);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.mem_size) == 40);
-- 
2.47.1

