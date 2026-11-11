Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438672;
	b=Rr2u7ywVm6SJ55ZzbCnvKkPtfBAO76Mpc6btLjLrpLjx0TxGw6NVZCC5eEha0sYNaV0T
	 VSSJLhaYIOMbUmJBHKqlfhs45TXj3WZzwJ4q5dfqDDmDDeg7g34yAM3zOUlFhyC9meuRl
	 f5ZZwI1V50BcXfY/GtRvIiiRsp/iRehsNkhb5Spvk99gSedLzj+OVJt6BV+MxGyT9eiFF
	 vuEIntO4UDK060AfNnm+juan8ZLyzjyM+LEvVBCajAaMhVd3jdAiZTSG3+bs54ed1RQOH
	 4DTs1NHkcv2sGs7dO17djx0GQJm0+beXr/LubA85jYN9p/mWwiaLDWL8WFV7MjYk1Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438672;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=fWy7BP4ZrwP8pEFVqTn9HpToBI15x6F3H7BoABp2EPI=;
	b=3PJ0q8RTM8NCMbYNXhLhKjpQBYgFfwbVivcS1LPUMk3hWmZ2VUudQimdumifNss6sVtF
	 ndZ9qQw2TxPGOdMe7p/MvzGT+0zynOO455N0kF1ZhgTcIaFLzWBDpd+8/O8Bb+2jfvpGz
	 8OH/nfKubFt9K9LFWw+p0hYVbtoX4ABhRjLEHLJGFxTNzhahLoBDk2ZzYmaPtoXMMYMbu
	 ZeoSEY7Y9GJ4riStSqMfMX3sI3/ai7JGHY2x/jIFW8sCG5JloKfM7nQOJlV+HvIgENqkF
	 yTM+IVhu0ZYru3G26LurGvf4FcS9tcx9z9yMO32qzzEmw681Ly4ubPCNnQ1aZkz1+yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=amZUwBkL;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C00606A333
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C00606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=amZUwBkL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438672; x=1825974672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWy7BP4ZrwP8pEFVqTn9HpToBI15x6F3H7BoABp2EPI=;
  b=amZUwBkLEzAVouAECGaoURa+KEnVn2Tyrk2TdmrPvI6oUfLsYsukMqAG
   2x2pY62bht0BTHcBrFQ4I2e5Y7Cy1kVhqIts17TcEkie4PeZSZopOvRU9
   UDtLYLjBraiuW6+grTgEcjHkO8UGKyIhVdF08r04QTEzCn7fu4PNP9X5d
   BSWmjl9kZZefSwm6N0lZr6502WXu3I1cB2yc5IUWxWh8O97rjzSYYKdCN
   4TWn96nUBg9X76+blJwYNVw2DwnbGpOJGlWRqpxI+OlmEwHVD8PfSc8il
   xiLP9e2B7KqS/RCHqI4Xm55P43oXwZ1vuiIvRxwyC5ZqYfZsONBLiT8cX
   Q==;
X-CSE-ConnectionGUID: RQ9PyuNdQue3OfBlvbzVWQ==
X-CSE-MsgGUID: pzf0JfnxTuOsJb/W1g02Bg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33630361"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:11:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:23343]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.127:2525] with esmtp (Farcaster)
 id 7d76ce78-6b44-4386-afba-122728c2c947; Wed, 11 Nov 2026 23:11:11 +0000 (UTC)
X-Farcaster-Flow-ID: 7d76ce78-6b44-4386-afba-122728c2c947
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:11:11 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:11:08 +0000
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
Subject: [PATCH 35/40] nitro_enclaves: Add NE_ENCLAVE_DIRECT_MODE
Date: Wed, 11 Nov 2026 22:59:39 +0000
Message-ID: <af6ee68b7edf080cfac1552f3a31a8ffdf42cbf6.1794393491.git.graf@amazon.com>
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

Nitro Sandboxes introduce a mode called direct mode, in which the parent
keeps access to most of the memory it donates to the sandbox. This mode
disables any attestation, but enables guest kernels that are not aware
of the Device Memory Buffer (DMB) to work. A DMB-aware guest kernel
places its virtqueues and buffers in memory the device provides, so the
parent needs access to that memory only.

Add NE_ENCLAVE_DIRECT_MODE, which asks the hypervisor for a direct-mode
slot. Remember the flags a slot was allocated with in
ne_enclave->launch_flags. Allow NE_ADD_MEMORY_REGION to use an
NE_MEMORY_SHARED allocation for a slot that carries this flag.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 Documentation/virt/ne_overview.rst        |  4 +++-
 drivers/virt/nitro_enclaves/ne_misc_dev.c |  9 +++++++--
 drivers/virt/nitro_enclaves/ne_misc_dev.h |  7 ++++++-
 include/uapi/linux/nitro_enclaves.h       | 19 +++++++++++++++++--
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/ne_overview.rst b/Documentation/virt/ne_overview.rst
index 012fcb394a2ef..5984fd32ec07a 100644
--- a/Documentation/virt/ne_overview.rst
+++ b/Documentation/virt/ne_overview.rst
@@ -183,7 +183,9 @@ memory region per contiguous run it is made of, or fewer where runs turn out
 to be physically adjacent. It also ends writing: the memory is the enclave's
 from that point, so an image goes in first. It takes private allocations
 only, since memory the parent can still reach is not memory the enclave has
-to itself.
+to itself. A slot allocated with NE_ENCLAVE_DIRECT_MODE asks for an enclave
+whose memory the parent keeps access to, and takes a shared allocation as a
+memory region.
 
 An enclave's memory is laid out in the order its allocations are given to it,
 and the offset NE_GET_IMAGE_LOAD_INFO returns is an offset into that layout.
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 961b821d6038b..cccfceeb575cc 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -3447,6 +3447,8 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 flags,
 	if (!ne_enclave)
 		return -ENOMEM;
 
+	ne_enclave->launch_flags = flags;
+
 	mutex_lock(&ne_cpu_pool.mutex);
 
 	ne_enclave->nr_parent_vm_cores = ne_cpu_pool.nr_parent_vm_cores;
@@ -4603,9 +4605,12 @@ static int ne_add_memory_region_ioctl(struct ne_enclave *ne_enclave,
 	/*
 	 * The parent may map a shared allocation and keeps any mapping it has
 	 * for as long as the allocation lives. Memory a region is made of is
-	 * the enclave's alone.
+	 * the enclave's alone, unless the slot was allocated for an enclave
+	 * whose memory the parent keeps access to, which is what
+	 * NE_ENCLAVE_DIRECT_MODE asks for.
 	 */
-	if (mem->shared) {
+	if (mem->shared &&
+	    !(ne_enclave->launch_flags & NE_ENCLAVE_DIRECT_MODE)) {
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "The memory region allocation is shared\n");
 
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.h b/drivers/virt/nitro_enclaves/ne_misc_dev.h
index b0d0438157260..1fd93bddf7766 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.h
@@ -22,7 +22,8 @@
 /*
  * NE_ENCLAVE_FLAG_VALID_MASK - Every launch flag this kernel passes on.
  */
-#define NE_ENCLAVE_FLAG_VALID_MASK	(NE_ENCLAVE_PCIE_MODE | \
+#define NE_ENCLAVE_FLAG_VALID_MASK	(NE_ENCLAVE_DIRECT_MODE | \
+					 NE_ENCLAVE_PCIE_MODE | \
 					 NE_ENCLAVE_PCIE_VSOCK_MODE | \
 					 NE_ENCLAVE_PCIE_VIRTIO_MODE | \
 					 NE_ENCLAVE_PCIE_NUMA_MODE)
@@ -203,6 +204,9 @@ struct ne_doorbell_binding {
  *				so that the device keeps the page after user space
  *				has closed the descriptor. NULL until
  *				%NE_SET_INFO_PAGE is called.
+ * @launch_flags:		The launch flag word the slot was allocated with,
+ *				as %NE_CREATE_VM2 received it. Read to answer a
+ *				later call the way the slot was asked for.
  * @notify_bindings:		List of the notifications this enclave has bound
  *				an eventfd to.
  * @devices:			List of struct ne_device_wiring, one for each device
@@ -243,6 +247,7 @@ struct ne_enclave {
 	bool			has_event;
 	u64			id;
 	struct file		*info_file;
+	u64			launch_flags;
 	struct list_head	notify_bindings;
 	struct list_head	devices;
 	u64			max_mem_regions;
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index 67be5c383c54b..b346e0582c5fa 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -58,6 +58,17 @@
  */
 #define NE_ENCLAVE_PCIE_MODE		(1u << 6)
 
+/**
+ * NE_ENCLAVE_DIRECT_MODE - Allocate a slot whose memory the parent keeps
+ *			    access to. The enclave produces no attestation,
+ *			    since nothing separates its memory from the VM that
+ *			    launched it. An %NE_MEMORY_SHARED allocation can be
+ *			    given to such a slot as a memory region, which a
+ *			    slot without this flag refuses. Requires
+ *			    NE_ENCLAVE_PCIE_MODE.
+ */
+#define NE_ENCLAVE_DIRECT_MODE		(1u << 1)
+
 /**
  * NE_ENCLAVE_PCIE_VSOCK_MODE - Allocate a slot whose PCIe bus holds one
  *				virtio-vsock device, attached before the enclave
@@ -440,7 +451,9 @@ struct ne_add_memory_region_args {
  *			  enclave image goes in before this call. The allocation
  *			  has to be %NE_MEMORY_PRIVATE, since memory the parent
  *			  can still reach is not memory the enclave has to
- *			  itself.
+ *			  itself, unless the slot was allocated with
+ *			  %NE_ENCLAVE_DIRECT_MODE, which asks for an enclave
+ *			  whose memory the parent keeps access to.
  *			  An enclave's memory is laid out in the order its
  *			  allocations are given to it, and the offset from
  *			  %NE_GET_IMAGE_LOAD_INFO is an offset into that layout,
@@ -461,7 +474,9 @@ struct ne_add_memory_region_args {
  * * EINVAL				- The argument is shorter than @flags, or @fd
  *					  is not a descriptor from %NE_ALLOC_MEMORY, or
  *					  the allocation was made for another enclave,
- *					  or the allocation is %NE_MEMORY_SHARED.
+ *					  or the allocation is %NE_MEMORY_SHARED
+ *					  and the slot was not allocated with
+ *					  %NE_ENCLAVE_DIRECT_MODE.
  * * EIO				- Current task mm is not the same as the one
  *					  that created the enclave.
  * * E2BIG				- The argument is longer than this kernel knows
-- 
2.47.1

