Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437046;
	b=oyp2nx6mnogZ9qw8dFMr9ljb6mJEIlKHVMMQ1TRH97wpWYsILQrFza+a2rDl1t3uMqNJ
	 DV4VbLzvcBgJuH88AIiP96jGgvj19e1iu5I2a8tFUAvOV2k411ClbP4CFajlaqagcRqjG
	 knX4Za5TJTs6s8DZ7aD6mLj6Pz4bXbDe2MI2b8vKyuPU29MtJA+pzkhnd1kE66Wt0q+25
	 XEzADNtnmtjslYWijR4k1zhTL6KnOO5/qYs/PMQUgN1wk+pSxZxXq3meicUkG/17QlkjE
	 bEm9j5T8Vs10WsU5spxvSnjkMKY+3GhRhIoATxrGOm/+Z1eZEKyUf+k6djqhdGTfDTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437046;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=n8Lc096Oet60aLIy9WQq9zqJJ5FyBT2YGQ3yPJEK0l0=;
	b=R9wt3ZXleRJ9F0Czxvxfh/6dJIOr0LXRboV0fNpgX+xhJhOIWEdZ08gHF4AFW0bwf6PG
	 A3zyck3lv7o2aI6JguxZlJY6xrUcFZFVZUakxwBlHshRrZw0C64U9WsR6oUzDuhC503QG
	 b1RFWUJDNLFHR6bxIBRyPeUiiGASV7P+RZcqvf3qgc8SYUY59rCZiW+yHZvo2/7CYgaoP
	 kgdkFrkI8sv7r2QpGSqVDPA4r2v6LkmKrMEF/fKi89hkqT78ZQ4lTrefAFK9PbUe54kx8
	 qyP4UaC6crs0x+589xngjw9nPumvJoY4t1L8sg/4tFu2NBcAFDJ2ukYUrk7+lL4soGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=FqjYNpOT;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0649606E2AA
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0649606E2AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=FqjYNpOT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794437045; x=1825973045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8Lc096Oet60aLIy9WQq9zqJJ5FyBT2YGQ3yPJEK0l0=;
  b=FqjYNpOTd7CFPCQaBtNf114crFd0a+5ghR2QgL8SC7gtp07cT4ReAXqu
   8IsqF651vclQew0ltmDc/C+pXu99B/7m9JJ4iAypif50ljJnLIQibu2Ra
   49BazQRjS/npCNsR/E92NaxK2azE5fGTre8aDNScMYxYVBnxCJ8cjPgTN
   oVvgxRJrlK3JhXgBElC8ou47eY6+taUYLbIB69rSsHJihHehuFtybR4ew
   u5PKKg7uJhucvLSCNg8MNU1rrIeaOd7yEiChYriSg9D4hyI1mznMpmFaM
   ANUM+X+043TMW3kiW3YGoU3O3CLXII/kjLQHIGXiFQbCm6UYAsBpBHoOd
   g==;
X-CSE-ConnectionGUID: rACnm+byQrOkc60LRF9f1A==
X-CSE-MsgGUID: pcu9icCDSn+CECtcsEsy0A==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33662130"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:44:03 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:30654]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.141:2525] with esmtp (Farcaster)
 id 57fa7319-0315-4534-8905-169f80a09adf; Wed, 11 Nov 2026 22:44:02 +0000 (UTC)
X-Farcaster-Flow-ID: 57fa7319-0315-4534-8905-169f80a09adf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:44:02 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:59 +0000
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
Subject: [PATCH 11/40] nitro_enclaves: Add NE_ENCLAVE_PCIE_MODE launch flag
Date: Wed, 11 Nov 2026 22:41:56 +0000
Message-ID: <a183902fff38e2e2aab7be409569cdfa3aee4a4a.1794393490.git.graf@amazon.com>
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

Nitro Sandboxes give their guest virtio devices that the parent
provides, on a PCIe bus. The hypervisor sets up that bus when it
allocates the slot, so user space asks for it with a launch flag.

Define NE_ENCLAVE_PCIE_MODE, the first launch flag, and forward it in
SLOT_ALLOC. struct slot_alloc_req gains a flag word, and at offset 0,
over the unused field, a payload_version byte that tells the device to
read it. We send version 1 when a flag is set, and the all-zero request
of today otherwise.

A device that takes launch flags publishes a vendor-specific PCI
capability. A device that predates them ignores the flag word and
allocates a plain slot, so refuse a launch flag with -EOPNOTSUPP on a
device without the capability.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 19 ++++++++++++++++++-
 drivers/virt/nitro_enclaves/ne_pci_dev.h  | 23 +++++++++++++++++++++--
 include/uapi/linux/nitro_enclaves.h       | 14 ++++++++++++++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 68c497df4f14b..0bf62f703806e 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -2475,13 +2475,30 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 flags,
 	int rc = -EINVAL;
 	struct slot_alloc_req slot_alloc_req = {};
 
-	if (flags) {
+	if (flags & ~(u64)NE_ENCLAVE_PCIE_MODE) {
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Unknown launch flag bit set 0x%llx\n", flags);
 
 		return -NE_ERR_INVALID_FLAG_VALUE;
 	}
 
+	/*
+	 * A device that takes launch flags publishes a vendor-specific
+	 * capability. One without it takes no launch flags and would allocate a
+	 * slot without the properties they ask for.
+	 */
+	if (flags && !pci_find_capability(ne_pci_dev->pdev, PCI_CAP_ID_VNDR)) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Device takes no launch flags\n");
+
+		return -EOPNOTSUPP;
+	}
+
+	if (flags) {
+		slot_alloc_req.payload_version = 1;
+		slot_alloc_req.flags = flags;
+	}
+
 	mutex_lock(&ne_cpu_pool.mutex);
 
 	for (i = 0; i < ne_cpu_pool.nr_parent_vm_cores; i++)
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index 19e129d14a3a0..b0957e2606ec3 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -7,10 +7,12 @@
 #define _NE_PCI_DEV_H_
 
 #include <linux/atomic.h>
+#include <linux/build_bug.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
+#include <linux/stddef.h>
 #include <linux/wait.h>
 
 /**
@@ -174,12 +176,29 @@ struct enclave_stop_req {
 
 /**
  * struct slot_alloc_req - SLOT_ALLOC request.
- * @unused:	In order to avoid weird sizeof edge cases.
+ * @payload_version:	Wire version at offset 0. Zero is the value a driver
+ *			without launch flags leaves here, and tells the device
+ *			to disregard @reserved and @flags. 1 means @flags is
+ *			valid.
+ * @reserved:		Alignment padding between @payload_version and
+ *			@flags. Zero.
+ * @flags:		Launch flag word from NE_CREATE_VM2, valid when
+ *			@payload_version >= 1.
  */
 struct slot_alloc_req {
-	u8	unused;
+	u8	payload_version;
+	u8	reserved[3];
+	u32	flags;
 };
 
+/*
+ * The device picks these fields out of the payload by offset, so a change
+ * to the layout here changes the SLOT_ALLOC wire format.
+ */
+static_assert(sizeof(struct slot_alloc_req) == 8);
+static_assert(offsetof(struct slot_alloc_req, reserved) == 1);
+static_assert(offsetof(struct slot_alloc_req, flags) == 4);
+
 /**
  * struct slot_free_req - SLOT_FREE request.
  * @slot_uid:	Slot unique id mapped to the slot to free.
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index 8e43be9a0a1fa..8ccf16e9cf5fb 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -46,6 +46,18 @@
  */
 #define NE_CREATE_VM			_IOR(0xAE, 0x20, __u64)
 
+/**
+ * DOC: NE_CREATE_VM2 launch flags
+ */
+
+/**
+ * NE_ENCLAVE_PCIE_MODE - Allocate a slot with a PCIe bus. The
+ *			  hypervisor selects PCIe backing for the slot at
+ *			  SLOT_ALLOC time, so a caller that wants it asks
+ *			  for it here and not at enclave start.
+ */
+#define NE_ENCLAVE_PCIE_MODE		(1u << 6)
+
 /**
  * struct ne_create_vm_args - NE_CREATE_VM2 argument (in / out).
  * @flags:	Launch-time flag word (in). Flags select properties of the
@@ -82,6 +94,8 @@ struct ne_create_vm_args {
  * * EFAULT				- Argument read or write failure.
  * * NE_ERR_INVALID_FLAG_VALUE		- Unknown flag bit set, or
  *					  NE_ENCLAVE_DEBUG_MODE set.
+ * * EOPNOTSUPP			- A launch flag is set and the NE PCI
+ *					  device takes no launch flags.
  * * EINVAL				- The argument stops before @slot_uid.
  * * E2BIG				- The argument carries a field this kernel
  *					  does not know, set to a non-zero value.
-- 
2.47.1

