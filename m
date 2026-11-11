Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437041;
	b=VGYokJZjO7giPqYg5LRFsTCkQeHxShxWiRePbZdw5kvN3PVxGPfbIz+xzvIGzU1ruEMA
	 XQeJNz05xn0gAMA7qUyjGxye5r5WppK/p4M3OaWoYh/d+uBA889zkFfaNTx5b/7mZwjDf
	 km6I1DRYJXR4VSi4dwU2aqcG+g9qD2I6IUykrXZDjYR0M04bhRLKAhhVhMRYaHMfEEdtw
	 XxW4rtv5TU/vRfKoX06odT/B5k+Re9713L/Ymrh3yw5aCgcLdXgp4X1Cio6phW0v/bD6b
	 fyEsxRQhlfUjEIZdtvruVHFj7gLbPQM/k33OT9KMpO0qmEcJyxoaD1mB/xjeYO/JLpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437041;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=/cubfczVbnds8zP6oBlBcF/d/gJnxIwiCtc/tjxJ3hg=;
	b=mjSfKITmffEo4mtkNWu8qkyyqUFbwvkziz5U+zg8SZWmxjxkgteO2bZXhOwFcxDXrbW7
	 piX2IHWCgwg/o2NwMtOTOYUE9N1L7C2EDKLnnPiL1rkhCvZVYEQRRG7zIh8qgV2gDY5nf
	 4/3swUtLagZ/cYFJ1m5F08ZMHM9no1qoq+QB8b3MF95FKwsJtLxIeIPqduzhjhW28ea8O
	 NRTvblK33l+Yx3zsvy0KcJtg6YQbmHErH3SqxA3Mvc1ebGRc5juySmuh+QOqN5j5lFEji
	 tH6WfixVvx++PnA2XoSjECOy+p0aDnH/7mV2YN6pcapz4NTMMe2Mksmxp8tyIqNEYfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=SEN7fy4P;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1ED606A88E
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB1ED606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=SEN7fy4P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794437040; x=1825973040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cubfczVbnds8zP6oBlBcF/d/gJnxIwiCtc/tjxJ3hg=;
  b=SEN7fy4PxilCkY4ssqTeFhZupHE38N6uKUuX87CLPSOatoB+uOo68OVO
   U4FLvAwS2BqFDY+NcE8UGzwlrqGZLpBHj1/wCuFs0N6pdHAOXES+c7iSP
   Glna8goNnp7M5MjaVzw4sj4HrimUh20i5roOuUR/hXlsfBx0r4blK5LZn
   gFWt/iv+Kd+j/GXD3aJUu/ASJly4ukval6yKmG9fUmjVcrGxvmG3sJtby
   J/MIvU9K+u3W8mXym2H8ErPXqWegbQ5qzH+A4NyeaEhiNgCvS1jUVO1jr
   t/5fAXzASFnYh+FHXfkmTlbD9trIq4n4N0ZK3sWI3SrUeRwYdyRLNHP3G
   w==;
X-CSE-ConnectionGUID: Gf4HsB+bSWOzc6SvbrsRUg==
X-CSE-MsgGUID: jkQaPXZKQimMvYS+zj3VKg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33273359"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:44:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:26886]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id d4e831c7-c721-48fe-8fab-b625d5675814; Wed, 11 Nov 2026 22:44:00 +0000 (UTC)
X-Farcaster-Flow-ID: d4e831c7-c721-48fe-8fab-b625d5675814
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:59 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:57 +0000
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
Subject: [PATCH 10/40] nitro_enclaves: Add NE_CREATE_VM2 with a launch flag word
Date: Wed, 11 Nov 2026 22:41:55 +0000
Message-ID: <1ef9f5e8a25e0ed11754e1def76ebd183a819c06.1794393490.git.graf@amazon.com>
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

In preparation to support Nitro Sandboxes, whose properties the
hypervisor needs before it allocates a slot, add NE_CREATE_VM2. It takes
a word of launch flags for the slot. The slot id comes back in the
same struct ne_create_vm_args.

No flag is defined in this patch, so any set bit fails with
-NE_ERR_INVALID_FLAG_VALUE.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 53 +++++++++++++++++++++--
 include/uapi/linux/nitro_enclaves.h       | 48 ++++++++++++++++++++
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 38345ad7c7985..68c497df4f14b 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -2452,6 +2452,8 @@ static const struct file_operations ne_enclave_fops = {
  *			  enclave file descriptor to be further used for enclave
  *			  resources handling e.g. memory regions and CPUs.
  * @ne_pci_dev :	Private data associated with the PCI device.
+ * @flags:		Launch-time flag word from NE_CREATE_VM2, or zero when
+ *			the caller used the flag-less NE_CREATE_VM.
  * @slot_uid:		User pointer to store the generated unique slot id
  *			associated with an enclave to.
  *
@@ -2461,7 +2463,8 @@ static const struct file_operations ne_enclave_fops = {
  * * Enclave fd on success.
  * * Negative return value on failure.
  */
-static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_uid)
+static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 flags,
+			      u64 __user *slot_uid)
 {
 	struct ne_pci_dev_cmd_reply cmd_reply = {};
 	int enclave_fd = -1;
@@ -2472,6 +2475,13 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 	int rc = -EINVAL;
 	struct slot_alloc_req slot_alloc_req = {};
 
+	if (flags) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Unknown launch flag bit set 0x%llx\n", flags);
+
+		return -NE_ERR_INVALID_FLAG_VALUE;
+	}
+
 	mutex_lock(&ne_cpu_pool.mutex);
 
 	for (i = 0; i < ne_cpu_pool.nr_parent_vm_cores; i++)
@@ -2626,7 +2636,44 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (ne_pci_dev) {
 			rc = mutex_lock_killable(&ne_pci_dev->enclaves_list_mutex);
 			if (!rc) {
-				rc = ne_create_vm_ioctl(ne_pci_dev, slot_uid);
+				rc = ne_create_vm_ioctl(ne_pci_dev, 0, slot_uid);
+				mutex_unlock(&ne_pci_dev->enclaves_list_mutex);
+			}
+		}
+
+		up_read(&ne_devs.lock);
+
+		return rc;
+	}
+	}
+
+	/* Extensible Argument ioctls */
+	switch (NE_EA_IOCTL(cmd)) {
+	case NE_EA_IOCTL(NE_CREATE_VM2): {
+		struct ne_create_vm_args args;
+		struct ne_create_vm_args __user *uargs = (void __user *)arg;
+		unsigned int usize = _IOC_SIZE(cmd);
+		struct ne_pci_dev *ne_pci_dev;
+		int rc;
+
+		if (usize < offsetofend(struct ne_create_vm_args, slot_uid))
+			return -EINVAL;
+
+		rc = copy_struct_from_user(&args, sizeof(args), uargs, usize);
+		if (rc)
+			return rc;
+
+		rc = down_read_killable(&ne_devs.lock);
+		if (rc)
+			return rc;
+
+		rc = -ENODEV;
+		ne_pci_dev = ne_devs.ne_pci_dev;
+		if (ne_pci_dev) {
+			rc = mutex_lock_killable(&ne_pci_dev->enclaves_list_mutex);
+			if (!rc) {
+				rc = ne_create_vm_ioctl(ne_pci_dev, args.flags,
+							&uargs->slot_uid);
 				mutex_unlock(&ne_pci_dev->enclaves_list_mutex);
 			}
 		}
@@ -2639,8 +2686,6 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	default:
 		return -ENOTTY;
 	}
-
-	return 0;
 }
 
 /*
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index 16515fe27b692..8e43be9a0a1fa 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -46,6 +46,54 @@
  */
 #define NE_CREATE_VM			_IOR(0xAE, 0x20, __u64)
 
+/**
+ * struct ne_create_vm_args - NE_CREATE_VM2 argument (in / out).
+ * @flags:	Launch-time flag word (in). Flags select properties of the
+ *		enclave slot that the hypervisor has to know at allocation
+ *		time. NE_ENCLAVE_DEBUG_MODE stays a start-time property and
+ *		is rejected here.
+ * @slot_uid:	Generated unique slot id associated with an enclave (out).
+ */
+struct ne_create_vm_args {
+	__u64	flags;
+	__u64	slot_uid;
+};
+
+/**
+ * NE_CREATE_VM2 - As NE_CREATE_VM, additionally taking a launch-time flag
+ *		   word. The flags carry properties of the slot that have to
+ *		   be decided when the slot is allocated rather than when the
+ *		   enclave starts.
+ *
+ *		   NE_CREATE_VM continues to work; calling it is equivalent
+ *		   to calling NE_CREATE_VM2 with a zero flag word.
+ *
+ *		   The argument is read with copy_struct_from_user(), so a
+ *		   caller built against a header that predates a field this
+ *		   kernel knows leaves that field zero, and a caller that
+ *		   sets a field this kernel does not know is refused.
+ *
+ * Context: Process context.
+ * Return:
+ * * Enclave file descriptor		- As for NE_CREATE_VM.
+ * *  -1				- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * ENODEV				- The NE PCI device is not available.
+ * * EFAULT				- Argument read or write failure.
+ * * NE_ERR_INVALID_FLAG_VALUE		- Unknown flag bit set, or
+ *					  NE_ENCLAVE_DEBUG_MODE set.
+ * * EINVAL				- The argument stops before @slot_uid.
+ * * E2BIG				- The argument carries a field this kernel
+ *					  does not know, set to a non-zero value.
+ * * ENOMEM				- Memory allocation failure for internal
+ *					  bookkeeping variables.
+ * * NE_ERR_NO_CPUS_AVAIL_IN_POOL	- No NE CPU pool set / no CPUs available
+ *					  in the pool.
+ * * Error codes from get_unused_fd_flags() and anon_inode_getfile().
+ * * Error codes from the NE PCI device request.
+ */
+#define NE_CREATE_VM2			_IOWR(0xAE, 0x30, struct ne_create_vm_args)
+
 /**
  * NE_ADD_VCPU - The command is used to set a vCPU for an enclave. The vCPU can
  *		 be auto-chosen from the NE CPU pool or it can be set by the
-- 
2.47.1

