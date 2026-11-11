Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436956;
	b=JvNQKwA86Gh/tw1nfoYYoxBv9zqbGQPBwGVjHrsh5S1zuK2dhz3yO6NF3G0TSq6LKmSX
	 6aj/ckXZq84B+UDEe2ahqjO905OrmIsrDkY7CUtIGAGCbJNlHKXTUYwIes0EKsU+3D6ss
	 qfe/Ndx2GVo1K4S946nySGdSWpvz8+0ReeuiGhE8p26WN3V8uYhL4k41asRICBb02s2kc
	 ecMA7Zfz8lLQAmEJPKUM6V1vuB8A/uR8FbJlD8mYTMug53+oy37l8u/9CkOSvgo4OjF5T
	 4caWMpGbGkIQId/UrsPMfNhDEwhqUTOdm22Wi1Vnj0b7ULqJwlbgQey2hOmKUBdcLow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436956;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=UxYweRxm1jxmevq4ssKlYUqBx3+MSGqJMKtXpG6cMZs=;
	b=s0hayht/xvFoG+rM61+FYmKFq+AQ/suwvfMzw5x2kixOcwCSRZhfLlmJ2EMCEQoFAHlH
	 gCC72a/+7Qf/WIT9anLC+FYImJ96gxaLxjaSYIu5M3b5JOhGE5b61wAmQZqYe0n6Iix4x
	 ojTBrCyCiHNl8IOHfh1UMpVqJL+nseoqVcWmnQgBcEQhnDvdNX47PPQ3QnxP3ocECcvLF
	 yBQpBtUpHHppFuXsKr6LLIIXbp/jUePcwnMnVEDf0ZfdrB98sBvQCB1v3snddsogLmaM4
	 DbVppXrr07EqFkWumMGUkgdHncsNApHs6gOQVj2E6uhKHemWHbYZaVFOfjqz0YPDMDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=mvzxoq5q;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4D606A33F
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92B4D606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=mvzxoq5q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794436955; x=1825972955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UxYweRxm1jxmevq4ssKlYUqBx3+MSGqJMKtXpG6cMZs=;
  b=mvzxoq5qgBGQyQgdYlsVD4tt6LQwCUWniW0RPEnXKzr2vL6UZLaXyYiU
   ZPIibTNMItUMGIceSXMuFR8wL9wsGxtQAysoTiSg9Vtz9T4Gu+JJ++njT
   TVC4CgVtbsofCfNIwsmiv2MLFdS35pb6/ueZWIbEZ9pQZnPHqLXSouxTH
   MaIJppW/Czl4sK1f+9T2HYhj/y2CpINnskFJR7qy2qdH9cBwBv/0gfN4K
   l2kL2CumhumyTWT//4kCDhQo0o+yPn7df0+SB7bWDYWEUNXNuIeUc6N86
   A98dWxn2+5RYSPk9OZxa0P2qw1939UmX0BoyS5W+mA2hauiXzdWQVK9nC
   w==;
X-CSE-ConnectionGUID: rXovG/BETqmn+vbmyNsKtQ==
X-CSE-MsgGUID: RqVgO+5rQaKtb0DX5vPaTA==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33756177"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:42:35 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:20493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id fc83ea97-8a60-4672-82e4-94100366064e; Wed, 11 Nov 2026 22:42:35 +0000 (UTC)
X-Farcaster-Flow-ID: fc83ea97-8a60-4672-82e4-94100366064e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:42:34 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:42:32 +0000
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
Subject: [PATCH 02/40] nitro_enclaves: Add NE_ADD_ANY_VCPU
Date: Wed, 11 Nov 2026 22:41:47 +0000
Message-ID: <205db2f63e5458098d7d147a28efa04af2d4930d.1794393490.git.graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A Nitro Sandbox can span multiple NUMA nodes. The current NE_ADD_VCPU ioctl
only takes a target CPU id as input or a special ANY id. With NUMA, we want
to be able to take any CPU from a specific NUMA node. Add a new
NE_ADD_ANY_VCPU ioctl with nid parameter to select the target node. The new
ioctl returns the selected CPU id or NE_ERR_NO_CPUS_AVAIL_IN_POOL.

To already prepare for later argument extension, filter out the size field
of the ioctl and handle the fields we know about.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 92 ++++++++++++++++++++++-
 include/uapi/linux/nitro_enclaves.h       | 54 +++++++++++++
 2 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 6e36abeff01a2..576f1909c7304 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -9,11 +9,13 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/build_bug.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/file.h>
 #include <linux/hugetlb.h>
+#include <linux/ioctl.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/list.h>
@@ -24,12 +26,15 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nitro_enclaves.h>
+#include <linux/nodemask.h>
 #include <linux/numa.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
 #include <linux/range.h>
 #include <linux/slab.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/uaccess.h>
 #include <uapi/linux/vm_sockets.h>
 
 #include "ne_misc_dev.h"
@@ -42,6 +47,23 @@
  */
 #define NE_CPUS_SIZE		(512)
 
+/**
+ * NE_EA_IOCTL() - Mask the size and direction bits out of an ioctl command, so
+ *		   that an Extensible Argument ioctl matches whatever size of
+ *		   argument the caller passed. The direction bits go with them,
+ *		   so a caller that spells the command _IOW(), _IOR() or
+ *		   _IOWR() reaches the same handler, and the handler decides
+ *		   what it reads and writes.
+ * @cmd:	The ioctl command to mask.
+ */
+#define NE_EA_IOCTL(cmd)	((cmd) & ~(IOC_INOUT | IOCSIZE_MASK))
+
+/*
+ * NE_NUMA_ANY reaches the core allocator as a node id, so the uapi spelling
+ * and the kernel one have to agree.
+ */
+static_assert(NE_NUMA_ANY == NUMA_NO_NODE);
+
 /**
  * NE_EIF_LOAD_OFFSET - The offset where to copy the Enclave Image Format (EIF)
  *			image in enclave memory.
@@ -334,7 +356,8 @@ static int ne_setup_cpu_pool(const struct cpumask *cpu_pool)
 	 * multiple NUMA nodes, set numa_node to NUMA_NO_NODE; the pool is then
 	 * treated as node-agnostic for placement and memory-locality checks.
 	 * A CPU that reports no node at all is refused, because otherwise such
-	 * a CPU would join a single-node pool and turn it into a spanning one.
+	 * a CPU would join a single-node pool and turn it into a spanning one,
+	 * and its core would be unreachable through a node-named pick.
 	 */
 	for_each_cpu(cpu, cpu_pool) {
 		int nid = cpu_to_node(cpu);
@@ -1592,6 +1615,73 @@ static long ne_enclave_do_ioctl(struct file *file, unsigned int cmd, unsigned lo
 
 		return 0;
 	}
+	}
+
+	/* Extensible Argument ioctls */
+	switch (NE_EA_IOCTL(cmd)) {
+	case NE_EA_IOCTL(NE_ADD_ANY_VCPU): {
+		struct ne_add_any_vcpu_args __user *uargs = (void __user *)arg;
+		unsigned int usize = _IOC_SIZE(cmd);
+		struct ne_add_any_vcpu_args args;
+		u32 vcpu_id = 0;
+		int rc;
+
+		if (usize < offsetofend(struct ne_add_any_vcpu_args, vcpu_id))
+			return -EINVAL;
+
+		rc = copy_struct_from_user(&args, sizeof(args), uargs, usize);
+		if (rc)
+			return rc;
+
+		if (args.numa_node != NE_NUMA_ANY &&
+		    (args.numa_node < 0 || args.numa_node >= nr_node_ids ||
+		     !node_state(args.numa_node, N_POSSIBLE))) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "Invalid NUMA node %d\n", args.numa_node);
+
+			return -EINVAL;
+		}
+
+		rc = mutex_lock_killable(&ne_enclave->enclave_info_mutex);
+		if (rc)
+			return rc;
+
+		if (ne_enclave->state != NE_STATE_INIT) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "Enclave is not in init state\n");
+
+			mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+			return -NE_ERR_NOT_IN_INIT_STATE;
+		}
+
+		rc = ne_get_cpu_from_cpu_pool(ne_enclave, &vcpu_id, args.numa_node);
+		if (rc < 0) {
+			dev_err_ratelimited(ne_misc_dev.this_device,
+					    "Error in get CPU from pool [rc=%d node=%d]\n",
+					    rc, args.numa_node);
+
+			mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+			return rc;
+		}
+
+		rc = ne_add_vcpu_ioctl(ne_enclave, vcpu_id);
+		if (rc < 0) {
+			mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+			return rc;
+		}
+
+		mutex_unlock(&ne_enclave->enclave_info_mutex);
+
+		args.vcpu_id = vcpu_id;
+
+		if (copy_to_user(uargs, &args, min_t(size_t, usize, sizeof(args))))
+			return -EFAULT;
+
+		return 0;
+	}
 
 	default:
 		return -ENOTTY;
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index 206546f24748e..e266b8a611c92 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -83,6 +83,60 @@
  */
 #define NE_ADD_VCPU			_IOWR(0xAE, 0x21, __u32)
 
+/**
+ * struct ne_add_any_vcpu_args - Argument for %NE_ADD_ANY_VCPU.
+ * @numa_node:	The NUMA node the vCPU has to come from, or %NE_NUMA_ANY for
+ *		any node.
+ * @vcpu_id:	The vCPU id the kernel chose, set on success. Ignored on
+ *		input.
+ */
+struct ne_add_any_vcpu_args {
+	__s32	numa_node;
+	__u32	vcpu_id;
+};
+
+/**
+ * NE_NUMA_ANY - Value for &struct ne_add_any_vcpu_args.numa_node that asks for
+ *		 a vCPU from any NUMA node.
+ */
+#define NE_NUMA_ANY			(-1)
+
+/**
+ * NE_ADD_ANY_VCPU - The command is used to set a vCPU for an enclave, chosen
+ *		     from the NE CPU pool. @numa_node confines the choice to
+ *		     one NUMA node; %NE_NUMA_ANY leaves it unconstrained. A
+ *		     caller that spreads an enclave over several nodes asks
+ *		     for each node in turn and stops when a node runs out.
+ *		     @vcpu_id carries back the vCPU id the kernel chose, so
+ *		     a caller collects the enclave's vCPU set as it builds
+ *		     it.
+ *		     The ioctl can be invoked on the enclave fd, before an
+ *		     enclave is started.
+ *
+ * Context: Process context.
+ * Return:
+ * * 0				- Logic successfully completed.
+ * * -1				- There was a failure in the ioctl logic.
+ * On failure, errno is set to:
+ * * ENODEV			- The NE PCI device is not available.
+ * * EFAULT			- Argument read or write-back failure.
+ * * EINVAL			- The argument is shorter than @vcpu_id, or
+ *				  @numa_node is neither %NE_NUMA_ANY nor a
+ *				  possible NUMA node.
+ * * EIO			- Current task mm is not the same as the one
+ *				  that created the enclave.
+ * * E2BIG			- The argument is longer than this kernel knows
+ *				  about and the excess is not all zero.
+ * * NE_ERR_NOT_IN_INIT_STATE	- The enclave is not in init state (init =
+ *				  before being started).
+ * * NE_ERR_NO_CPUS_AVAIL_IN_POOL - No CPUs available in the NE CPU pool on
+ *				  @numa_node.
+ * * NE_ERR_VCPU_INVALID_CPU_CORE - The core the pool handed back is outside
+ *				  the enclave's core slots.
+ * * Error codes from the NE PCI device request.
+ */
+#define NE_ADD_ANY_VCPU			_IOWR(0xAE, 0x2D, struct ne_add_any_vcpu_args)
+
 /**
  * NE_GET_IMAGE_LOAD_INFO - The command is used to get information needed for
  *			    in-memory enclave image loading e.g. offset in
-- 
2.47.1

