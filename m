Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.13.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438639;
	b=vBRzONzEKDUsSS5J6HO5MyaKC2srg+g9ZsqhpwuyXvBCSATO+DGow9h4oa79Ch/S4Pgl
	 8LSdzVZ6IsGIkLArLfWRL9V4skr/v78yRjVGtplq9xdGBUru0cT8txS4MWxq8cKL5UNWu
	 Kx6sffjy8bDIbyjiuYNtnPeUYv/j2C7kTlg5SUPdDJfg+zasVTVkcYLi9dIxCB1TSupFe
	 HKl9epBCiAtSd9ibdXwO1BBLqsIA6ltrChTV2YXQhSV80zBBEgbJc2vjpTLT6pJtnDrLQ
	 kvYdNXK6QD5PYnlpSyXV8pP7H7iV8vIMq9NGxpOXnMVK4p/CwH2cxSUJYbJtpFx8s1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438639;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NCnIXJwEIeew7GeEdm/L9dlF07S94PYfaBGXUGwdBts=;
	b=CHLi/sT7F5NRn5TEf/Rvs5Er/xZR7s0uCoXzQBqhLxoump9kIyU9tYz8l7IKbnODiTBy
	 rHyB4y5PC2K1Nt+NAG2nnzriTiH5gtMGFTydggqKWHykIRAunAlL/ul7iYCjLYX1U8jIG
	 fbg11Cfj6YBmV7whGG+D+gDbDg1n7lmAt6aA4u9sH+eu4QvDv9srDHBrRhZnuiBBlrwR0
	 I1bbMBwL1e5oZT765tET+jAHko9KJ8uxaGwS4pdl+bO+ZVHUfZCh+jdygSbGgWlLDCbM/
	 b5UHdq6bsU0FL9BW9sGo1a9mv6XkaEonjgkX3wVaqIRrT9VE5Fdmhq7gd/uvdzjyk2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=AGym41kZ;
	arc=none smtp.remote-ip=52.13.214.179
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8B606A327
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA8B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=AGym41kZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438638; x=1825974638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCnIXJwEIeew7GeEdm/L9dlF07S94PYfaBGXUGwdBts=;
  b=AGym41kZiZl6o1Kf3Ulykl5JTIsXVTPUyrawmkMQjcZKG3e+9MmnAR8C
   9iUVXsK4hFIYcrZJZ2ylYzr1jwXADqPfUC/6/8+kVgV+PwdjuPNp3TJ9t
   N1w5dC6GJq1p2UrU0hVS3ictGGMNXIiHHspKZMhRAL2ra7sxGRQ/t3hXk
   jeowZgvu6DWGLbWJVgky83EL18DBncQ6LM7QWkds+w15sOLVnRqU3h+gF
   +I4CtEYeCZzZdFbFZgNUTxdtQ9C80Sz8kV84m0YE6Av2WdKinQpb6WBbc
   xw9sCu6s1TNDUGklwGn74kj65RbwxUvv7JLc+/+HGX8T2hye+ZFxcttUi
   A==;
X-CSE-ConnectionGUID: /fgMkoezTtGxeD4JZ0Tswg==
X-CSE-MsgGUID: Hu4Um1q4ReSCGa71KDbHFw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33739627"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:10:37 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:28980]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id 0791c7fc-c29d-4b30-b989-231e12d448a5; Wed, 11 Nov 2026 23:10:37 +0000 (UTC)
X-Farcaster-Flow-ID: 0791c7fc-c29d-4b30-b989-231e12d448a5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:10:37 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:10:34 +0000
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
Subject: [PATCH 34/40] nitro_enclaves: Pass on the Nitro Sandbox launch flags
Date: Wed, 11 Nov 2026 22:59:38 +0000
Message-ID: <70da7aa106af963deb9eb197fcd1c63453e63087.1794393491.git.graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Nitro Sandboxes support multiple flags to enable or disable particular
bits of functionality. These bits are typically in sync with the EIF file
and need to get set already on slot creation, not only when we start the
sandbox.

Add definitions for the first batch of launch flags and make sure user
space can only set known flags:

NE_ENCLAVE_PCIE_VSOCK_MODE - Parent may add one single vsock device
NE_ENCLAVE_PCIE_VIRTIO_MODE - Parent may add (almost) any virtio device
NE_ENCLAVE_PCIE_NUMA_MODE - Slot may span multiple NUMA nodes

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c |  2 +-
 drivers/virt/nitro_enclaves/ne_misc_dev.h |  8 +++++
 include/uapi/linux/nitro_enclaves.h       | 38 +++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index f3ad8ddc31e5b..961b821d6038b 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -3402,7 +3402,7 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 flags,
 	int rc = -EINVAL;
 	struct slot_alloc_req slot_alloc_req = {};
 
-	if (flags & ~(u64)NE_ENCLAVE_PCIE_MODE) {
+	if (flags & ~(u64)NE_ENCLAVE_FLAG_VALID_MASK) {
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Unknown launch flag bit set 0x%llx\n", flags);
 
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.h b/drivers/virt/nitro_enclaves/ne_misc_dev.h
index f9ef79fafa2be..b0d0438157260 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.h
@@ -19,6 +19,14 @@
 
 #include "ne_pci_dev.h"
 
+/*
+ * NE_ENCLAVE_FLAG_VALID_MASK - Every launch flag this kernel passes on.
+ */
+#define NE_ENCLAVE_FLAG_VALID_MASK	(NE_ENCLAVE_PCIE_MODE | \
+					 NE_ENCLAVE_PCIE_VSOCK_MODE | \
+					 NE_ENCLAVE_PCIE_VIRTIO_MODE | \
+					 NE_ENCLAVE_PCIE_NUMA_MODE)
+
 struct cma;
 
 /**
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index 01bec4d072d6a..67be5c383c54b 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -58,6 +58,44 @@
  */
 #define NE_ENCLAVE_PCIE_MODE		(1u << 6)
 
+/**
+ * NE_ENCLAVE_PCIE_VSOCK_MODE - Allocate a slot whose PCIe bus holds one
+ *				virtio-vsock device, attached before the enclave
+ *				starts. Requires NE_ENCLAVE_PCIE_MODE and
+ *				excludes NE_ENCLAVE_PCIE_VIRTIO_MODE.
+ */
+#define NE_ENCLAVE_PCIE_VSOCK_MODE	(1u << 7)
+
+/**
+ * NE_ENCLAVE_PCIE_VIRTIO_MODE - Allocate a slot whose PCIe bus takes any
+ *				 virtio device type %NE_ADD_DEVICE offers it.
+ *				 Requires NE_ENCLAVE_PCIE_MODE and excludes
+ *				 NE_ENCLAVE_PCIE_VSOCK_MODE.
+ */
+#define NE_ENCLAVE_PCIE_VIRTIO_MODE	(1u << 9)
+
+/**
+ * NE_ENCLAVE_PCIE_NUMA_MODE - Allocate a slot whose memory and vCPUs may come
+ *			       from more than one host NUMA node. Without it the
+ *			       hypervisor refuses a slot that would straddle a
+ *			       node boundary. Requires NE_ENCLAVE_PCIE_MODE.
+ */
+#define NE_ENCLAVE_PCIE_NUMA_MODE	(1u << 13)
+
+/**
+ * NE_ENCLAVE_FLAG_UNMATCHED_MASK - The launch flags the hypervisor does not
+ *				    enumerate. It answers for them when a slot is
+ *				    allocated with them and not before.
+ */
+#define NE_ENCLAVE_FLAG_UNMATCHED_MASK	(0x003fu)
+
+/**
+ * NE_ENCLAVE_FLAG_MATCHED_MASK - The launch flags the hypervisor enumerates.
+ *				  It answers for them before a slot is
+ *				  allocated with them.
+ */
+#define NE_ENCLAVE_FLAG_MATCHED_MASK	(0xffc0u)
+
 /**
  * struct ne_create_vm_args - NE_CREATE_VM2 argument (in / out).
  * @flags:	Launch-time flag word (in). Flags select properties of the
-- 
2.47.1

