Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438776;
	b=UpwoQeF6vhQXWqOY+PpZtyUSRcv4TrlOAk5IuHrTIh4jCx0H4e9LfKEy1eNf4OjrdwpS
	 OaSQrn+958HGfg6RlI68shUnxPiheZWQ2cY56Jp72EEjz+bGd+xxeC1R7Xy2BMeYo6M3O
	 NGiZ8QoboCiF0kg+QEZy/N6f3DlCxXcYCqV1qFWCC7TQJhXWaHK8V/Q6/U3ZkfOLStjKD
	 bEH9vESJ4I8hmxJ+3so8L5zer8mtq/UrJZoo+qE6eVQii0L57dlX7IahVkAgRPprFiWAF
	 AYiRboI6lqQND6Ob0CQ9hfyKo7nS1XxUKuU0dS/RCn+RfQG69AambAfWeBC8Ejv77YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438776;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=vEMZMK0Re/UwHhA8b3WXi0Dtpsb6OJa9eiUgk7u+9gk=;
	b=3byQBDM7RaWp5c7jkNIBX1engguFJWrHPRGpCZSV5ExFgda8CkmfwpXXaAeKhzDmRwlN
	 Tc3/w1U/ydUjubbJeKhis+T2BGzAORGSq6akrpM+Yor8o2Sdh1JqwsGEmJOgMitLpSUXu
	 15oUMEsww2itj8R6yHltkyDBy7OKjhm+po5hezTegB+zb/QpeKOOLdqdIiqRZi1Oln7NH
	 kkHRbR4RVXZAmfkgjnjDZcHT/aACh4HOZuTUPoqwIwamB5AUlDbIt63cOAH/nn5Uex87y
	 cSl1/5MrxviFCgBtQZZq9XJKIhprfC1GxaEM57/7t4YpPF/Hbp/qVIyXFSDKwfqPpew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=gzug4Vpd;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09C606A321
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A09C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=gzug4Vpd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438775; x=1825974775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vEMZMK0Re/UwHhA8b3WXi0Dtpsb6OJa9eiUgk7u+9gk=;
  b=gzug4VpdBUx3mkFpDXZUXF08DXg/aoP0rt06vGvWxb/TziZjGM1ixseI
   LMTThM/qYY00AX8fG67DTG2UV5c8dgOIz1kV25pErSpO54taLdaSQ81Cw
   IO420JmUfnr2OGFI+2TR6Dhom3yBj9NgsflSZR2w02g0L5qD5iQarCn/d
   XetJqLX7VkkPI7H5qyRIg+Nx4stWtMztQU72b/D6jIL7KbnNwh/g8YQC/
   tMxS2MTDv4wwE0yWfzYhMElHz+Qz1vV0Ie/NER28XY5EdIyJhPcWXGd3Y
   Ae6uudEvdy4x6vtVv7ZtjoIB6WXBoFiBLLo7O2dinrtHB38MUbFA8WMkv
   Q==;
X-CSE-ConnectionGUID: mKnDkw2bQhejxBLto6192Q==
X-CSE-MsgGUID: pR8KfXqTQBC12qvOfUASNw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33663815"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:12:54 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25483]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 4a9643e4-42b7-4517-8fba-e39f75437681; Wed, 11 Nov 2026 23:12:54 +0000 (UTC)
X-Farcaster-Flow-ID: 4a9643e4-42b7-4517-8fba-e39f75437681
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:12:53 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:12:51 +0000
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
Subject: [PATCH 38/40] nitro_enclaves: Add NE_GET_CAPS
Date: Wed, 11 Nov 2026 22:59:42 +0000
Message-ID: <7908d660c8c691565ec53f5de0007c60a70dd80c.1794393491.git.graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

User space that launches Nitro Sandboxes needs to know which of the new
calls and launch flags the kernel and the host implement, how many
devices a slot takes, the size of the info page, the queue limit per
device and the configuration space NE_ADD_DEVICE takes, before it
allocates or fills them.

Add the NE_GET_CAPS ioctl on the /dev/nitro_enclaves fd. struct ne_caps
reports those sizes, the NE_CAP_* bits of the optional calls this kernel
implements, NE_ABI_VERSION, and how many bytes the kernel filled in.

supported_matched_flags reports the matched launch flags this kernel
passes on, and hypervisor_matched_flags those the device reports.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c |  73 +++++++++++++
 drivers/virt/nitro_enclaves/ne_pci_dev.c  |  33 ++++++
 drivers/virt/nitro_enclaves/ne_pci_dev.h  |  22 ++++
 include/uapi/linux/nitro_enclaves.h       | 124 +++++++++++++++++++++-
 4 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index e79740eac6f29..abbba71bbef06 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -154,6 +154,19 @@ static_assert(sizeof(struct ne_enclave_start_info) == 16);
 static_assert(offsetof(struct ne_enclave_start_info, flags) == 0);
 static_assert(offsetof(struct ne_enclave_start_info, enclave_cid) == 8);
 
+static_assert(sizeof(struct ne_caps) == 64);
+static_assert(offsetof(struct ne_caps, struct_size) == 0);
+static_assert(offsetof(struct ne_caps, abi_version) == 4);
+static_assert(offsetof(struct ne_caps, caps) == 8);
+static_assert(offsetof(struct ne_caps, supported_matched_flags) == 16);
+static_assert(offsetof(struct ne_caps, max_devices) == 24);
+static_assert(offsetof(struct ne_caps, max_vqs_per_device) == 28);
+static_assert(offsetof(struct ne_caps, max_config_size) == 32);
+static_assert(offsetof(struct ne_caps, reserved) == 36);
+static_assert(offsetof(struct ne_caps, info_page_size) == 40);
+static_assert(offsetof(struct ne_caps, info_page_align) == 48);
+static_assert(offsetof(struct ne_caps, hypervisor_matched_flags) == 56);
+
 /**
  * NE_EIF_LOAD_OFFSET - The offset where to copy the Enclave Image Format (EIF)
  *			image in enclave memory.
@@ -3817,6 +3830,66 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	/* Extensible Argument ioctls */
 	switch (NE_EA_IOCTL(cmd)) {
+	case NE_EA_IOCTL(NE_GET_CAPS): {
+		struct ne_caps caps = {};
+		struct ne_caps __user *uargs = (void __user *)arg;
+		struct ne_pci_dev *ne_pci_dev;
+		unsigned int usize = _IOC_SIZE(cmd);
+		size_t wsize;
+		u32 asize;
+		int rc;
+
+		if (usize < offsetofend(struct ne_caps, supported_matched_flags))
+			return -EINVAL;
+
+		if (get_user(asize, &uargs->struct_size))
+			return -EFAULT;
+
+		if (asize < offsetofend(struct ne_caps, supported_matched_flags))
+			return -EINVAL;
+
+		wsize = min3((size_t)asize, (size_t)usize, sizeof(caps));
+
+		caps.struct_size = wsize;
+		caps.abi_version = NE_ABI_VERSION;
+		caps.caps = NE_CAP_CREATE_VM2 | NE_CAP_DEVICES;
+		caps.supported_matched_flags = NE_ENCLAVE_FLAG_VALID_MASK &
+					       NE_ENCLAVE_FLAG_MATCHED_MASK;
+		caps.max_vqs_per_device = NE_MAX_VQS;
+		caps.max_config_size = sizeof_field(struct ne_add_device_args,
+						    device_config);
+		caps.info_page_size = NE_INFO_PAGE_SIZE;
+		caps.info_page_align = NE_INFO_PAGE_ALIGN;
+
+		/*
+		 * Hold ne_devs.lock over the register reads alone, so that a
+		 * fault on the argument does not hold up an unbind of the
+		 * device.
+		 */
+		rc = down_read_killable(&ne_devs.lock);
+		if (rc)
+			return rc;
+
+		ne_pci_dev = ne_devs.ne_pci_dev;
+		if (ne_pci_dev) {
+			u32 matched_flags;
+			u16 max_devices;
+
+			ne_read_device_caps(ne_pci_dev, &matched_flags,
+					    &max_devices);
+
+			caps.max_devices = max_devices;
+			caps.hypervisor_matched_flags = matched_flags;
+		}
+
+		up_read(&ne_devs.lock);
+
+		if (copy_to_user(uargs, &caps, wsize))
+			return -EFAULT;
+
+		return 0;
+	}
+
 	case NE_EA_IOCTL(NE_CREATE_VM2): {
 		struct ne_create_vm_args args;
 		struct ne_create_vm_args __user *uargs = (void __user *)arg;
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index b5a7ecfffb4b6..591c43590a845 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -1101,6 +1101,39 @@ static void ne_slot_pool_read_geometry(struct pci_dev *pdev)
 	ne_pci_dev->slot_pool_gran = size;
 }
 
+/**
+ * ne_read_device_caps() - Read what the device reports about itself.
+ * @ne_pci_dev:	PCI device state to read the registers of.
+ * @matched_flags:	Where the launch flags the device reports go.
+ * @max_devices:	Where the number of devices it reports goes.
+ *
+ * The registers are part of the block a vendor-specific capability publishes,
+ * so a device without one is not read at all and both values come back zero.
+ * A device that has the block and reports zero in one of them names no value
+ * for it, which is also what a device predating that register reads as. A
+ * caller cannot tell those apart, so a zero is not an answer it can refuse a
+ * launch on.
+ *
+ * The registers are read on every call. A hypervisor update changes
+ * which flags the host implements and how many devices it lets one enclave
+ * have, so a caller asking after one gets what the host implements now.
+ *
+ * Context: Process context.
+ */
+void ne_read_device_caps(struct ne_pci_dev *ne_pci_dev, u32 *matched_flags,
+			 u16 *max_devices)
+{
+	*matched_flags = 0;
+	*max_devices = 0;
+
+	if (!ne_pci_dev->has_vendor_cap)
+		return;
+
+	*matched_flags = ioread32(ne_pci_dev->iomem_base + NE_MATCHED_FLAGS) &
+			 NE_ENCLAVE_FLAG_MATCHED_MASK;
+	*max_devices = ioread16(ne_pci_dev->iomem_base + NE_MAX_DEVICES);
+}
+
 /**
  * ne_slot_pool_alloc_run() - Allocate one run for the slot pool.
  * @nr_pages:	Number of pages in the run.
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index 5a92e0c565ba0..44491e451082a 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -175,6 +175,24 @@
  */
 #define NE_SLOT_POOL_BASE_SIZE	(0x0208)
 
+/**
+ * DOC: Device capability registers in the NE PCI device MMIO BAR
+ */
+
+/**
+ * NE_MATCHED_FLAGS - (4 bytes) Register reporting which of the launch flags in
+ *		      NE_ENCLAVE_FLAG_MATCHED_MASK the device implements, zero
+ *		      on a device that reports none (Read-Only).
+ */
+#define NE_MATCHED_FLAGS	(0x01fc)
+
+/**
+ * NE_MAX_DEVICES - (2 bytes) Register reporting how many devices the device
+ *		    lets one enclave have, zero on a device that reports no
+ *		    number (Read-Only).
+ */
+#define NE_MAX_DEVICES		(0x020e)
+
 /**
  * DOC: MSI-X interrupt vectors
  */
@@ -835,6 +853,10 @@ int ne_do_request(struct pci_dev *pdev, enum ne_pci_dev_cmd_type cmd_type,
  */
 void ne_mux_binding_free_rcu(struct ne_mux_binding *binding);
 
+/* Read what the device reports about itself, zero where it reports nothing. */
+void ne_read_device_caps(struct ne_pci_dev *ne_pci_dev, u32 *matched_flags,
+			 u16 *max_devices);
+
 /* Nitro Enclaves (NE) PCI device driver */
 extern struct pci_driver ne_pci_driver;
 
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index bfe1ca5ef7f7f..f8eeacd2e7062 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -129,7 +129,9 @@
 /**
  * NE_ENCLAVE_FLAG_MATCHED_MASK - The launch flags the hypervisor enumerates.
  *				  It answers for them before a slot is
- *				  allocated with them.
+ *				  allocated with them, and
+ *				  &ne_caps.supported_matched_flags reports the
+ *				  ones this kernel passes on.
  */
 #define NE_ENCLAVE_FLAG_MATCHED_MASK	(0xffc0u)
 
@@ -185,6 +187,114 @@ struct ne_create_vm_args {
  */
 #define NE_CREATE_VM2			_IOWR(0xAE, 0x30, struct ne_create_vm_args)
 
+/**
+ * NE_ABI_VERSION - Revision of this interface the kernel implements, reported
+ *		    in &ne_caps.abi_version. It counts additions to the
+ *		    interface as a whole. Some additions carry a %NE_CAP_* bit,
+ *		    and a caller after one of those reads its bit. An addition
+ *		    with no bit is probed by issuing the call, which a kernel
+ *		    that does not implement it turns down with ENOTTY.
+ */
+#define NE_ABI_VERSION			(1)
+
+/**
+ * NE_CAP_CREATE_VM2 - This kernel implements %NE_CREATE_VM2.
+ */
+#define NE_CAP_CREATE_VM2		(1ULL << 0)
+
+/**
+ * NE_CAP_DEVICES - This kernel implements %NE_SET_INFO_PAGE,
+ *			 %NE_ADD_DEVICE, %NE_SET_NOTIFY_EVENTFD and
+ *			 %NE_SET_VRING_CALL.
+ */
+#define NE_CAP_DEVICES			(1ULL << 1)
+
+/**
+ * struct ne_caps - What this kernel implements, and what the device it reaches
+ *		    reports about itself (in / out).
+ * @struct_size:	Bytes of this structure the caller has (in), and the bytes
+ *			the kernel filled in (out). A caller that finds a shorter
+ *			value than it asked for has the fields past that point
+ *			unwritten, which is a different answer from a zero.
+ * @abi_version:	%NE_ABI_VERSION this kernel implements (out).
+ * @caps:		%NE_CAP_* bits (out). A set bit says this kernel
+ *			implements the calls that bit's own documentation
+ *			lists, and not that the device the caller reaches will
+ *			serve them, which is what that device's answer to the
+ *			call says. Support for a launch flag outside
+ *			%NE_ENCLAVE_FLAG_MATCHED_MASK is reported here or, in
+ *			the end, by what %NE_CREATE_VM2 does with it.
+ * @supported_matched_flags: The launch flags inside
+ *			%NE_ENCLAVE_FLAG_MATCHED_MASK this kernel passes to the
+ *			hypervisor (out). A set bit says the bit is accepted on
+ *			its own, not that every combination is. Bits outside that
+ *			mask read zero here whatever the hypervisor does with
+ *			them, so a caller masks its request before comparing.
+ * @max_devices:	Devices one enclave may have, as the hypervisor reports
+ *			the number (out). It answers a request past it itself,
+ *			so this is what a caller plans against rather than what
+ *			it is held to. Zero names no number, which is what a
+ *			device reporting no number, a device publishing no
+ *			vendor capability, a device predating the register and
+ *			no device bound at all leave here, so a zero bounds no
+ *			request and %NE_ADD_DEVICE is what answers.
+ * @max_vqs_per_device:	Largest @num_vqs %NE_ADD_DEVICE takes (out).
+ * @max_config_size:	Largest @config_size %NE_ADD_DEVICE takes (out).
+ * @reserved:		Zero (out).
+ * @info_page_size:	Size the %NE_SET_INFO_PAGE allocation has to have (out).
+ * @info_page_align:	Alignment it has to have (out).
+ * @hypervisor_matched_flags: The launch flags inside
+ *			%NE_ENCLAVE_FLAG_MATCHED_MASK the hypervisor reports it
+ *			implements (out). @supported_matched_flags is what this
+ *			kernel passes on and is the same on every host; this is
+ *			what the host behind the device answers for. A caller
+ *			requires a flag in @supported_matched_flags always, and
+ *			in this field as well when this field is non-zero.
+ *			Zero names no flag, which is what a device reporting
+ *			no flag, a device publishing no vendor capability, a
+ *			device predating the register and no device bound at
+ *			all leave here, so a zero refuses no flag and
+ *			%NE_CREATE_VM2 is what says so.
+ */
+struct ne_caps {
+	__u32	struct_size;
+	__u32	abi_version;
+	__u64	caps;
+	__u64	supported_matched_flags;
+	__u32	max_devices;
+	__u32	max_vqs_per_device;
+	__u32	max_config_size;
+	__u32	reserved;
+	__u64	info_page_size;
+	__u64	info_page_align;
+	__u64	hypervisor_matched_flags;
+};
+
+/**
+ * NE_GET_CAPS - The command is used to read what this kernel implements and
+ *		 what the device it reaches reports about itself, so that a
+ *		 caller sizes its allocations and reads which launch flags will
+ *		 be passed on and answered for. The ioctl can be invoked on the
+ *		 /dev/nitro_enclaves fd at any time, including before an
+ *		 enclave exists.
+ *
+ *		 The argument carries its own length in @struct_size, and the
+ *		 kernel writes back how many bytes it filled, so a caller built
+ *		 against a header this kernel predates can tell a field this
+ *		 kernel never wrote from one it wrote a zero into.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0					- Logic successfully completed.
+ * * -1					- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * EFAULT				- Argument read or write failure.
+ * * EINVAL				- The argument stops before
+ *					  @supported_matched_flags, or @struct_size
+ *					  names a length that stops before it.
+ */
+#define NE_GET_CAPS			_IOWR(0xAE, 0x29, struct ne_caps)
+
 /**
  * NE_ADD_VCPU - The command is used to set a vCPU for an enclave. The vCPU can
  *		 be auto-chosen from the NE CPU pool or it can be set by the
@@ -612,6 +722,18 @@ struct ne_set_info_page_args {
  */
 #define NE_SET_INFO_PAGE		_IOW(0xAE, 0x25, struct ne_set_info_page_args)
 
+/**
+ * NE_INFO_PAGE_SIZE - Size the info page allocation has to have, reported in
+ *		       &ne_caps.info_page_size.
+ */
+#define NE_INFO_PAGE_SIZE		(0x200000)
+
+/**
+ * NE_INFO_PAGE_ALIGN - Alignment the info page allocation has to have,
+ *			reported in &ne_caps.info_page_align.
+ */
+#define NE_INFO_PAGE_ALIGN		(0x200000)
+
 /**
  * NE_MAX_VQS - Highest number of virtqueues one device may have.
  */
-- 
2.47.1

