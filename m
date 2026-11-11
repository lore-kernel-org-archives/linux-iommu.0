Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438057;
	b=QiFvy7KqsPN5DaaaUKR/X0wXBMy10QLUIYUiJc7oqshJMl/g2RzEAmnnItreeE3gofpI
	 XenGp7YK3PAOALZAUiAe1TzLlcxHzM/BxKn79k/y/nHRXWoqUK/LQNairSlhwEuKmX+zg
	 F+4Q1IP8APYMzbWuj4eg0BXefR0cKjLRWwt+KkUogRoJ1gXH2viNdJ0fcq9KRJy7aAoOY
	 kbAVBwV/fuklRLQygANhQJf8X5KfMzArf4GNpuTa6c4akYd6RXASYevho6tsDha45phui
	 QmK9m7LXvPkmcpDuFKEO/pWwPyK1iLqAso5GgOg3IwCupMNoSpieT3wNpG4ShkuoESA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438057;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=XmuKZ2loZKyTAGGj5N0MglpczGlu5fP4eNsQMpnqo5g=;
	b=IYORBqJgpPGgQpj2e8SpUSuT8SHSSyVx0nDDjX5N7UudJlp2o/oMKAvevlsUYWLsu9jg
	 G4Ixm1IMFwNNOoty7FVZtl5zwT5nhIQjlf195KOH/JFHIV0TjE1B3fD/o1O/6haBebxGA
	 QBP9iob3rifb+khHHBEqoiLaSJEEMIM1o65ZjWoJNRBon4YxcQG/lb8SEU0tN8qaASx5c
	 7cAymkGRagcZTDPlB6gZdTd5xRRPgyIo8MqrWHLpJ/y33hhx3jl7+1eZWTZlqgEPvblBW
	 pNG4OsnWvhu2GNd0BzQOP8DOQNcMIMSM9seXiMAgaMABpY57giy3vwfOpYXvM1sTGng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=n0nnbeg1;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812BE606A890
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 812BE606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=n0nnbeg1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438057; x=1825974057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XmuKZ2loZKyTAGGj5N0MglpczGlu5fP4eNsQMpnqo5g=;
  b=n0nnbeg14YedPm7xDPFVOZwGENY1v6DHrCC8XUsZYvmXjLJ3IVkpFiqB
   QE37eph3xxPGEzZ+6idxwJjIEk1QXAig95zuwqFBwEaRXvQXeMCsHQn31
   5h1m5e+HKgcC6CWEg40uIZgGWi63Uc1VLsQiWc8ikhxZLxDHbzt8W/eau
   BgtZi2djoB7sbQFca7F7Hq8Y5sSwa5UqghFP4dgtFOMaWG5mDfrN6K6Rl
   Z32GOfae/MNLBdMTyA0Lv9jjMmb4RGlYm9CPT/jCNEsMm3jMEC6YHHaHQ
   m2z1GynJgOt9mNlrbJC4TyBqBrx3JsoQ+nfwxybvJjazrZA0CdbL1LMBQ
   w==;
X-CSE-ConnectionGUID: u0wPrw6NQ/K2I7KjcEQL/g==
X-CSE-MsgGUID: sexqQlZdRrysFYK8rx374w==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33757115"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:00:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:6966]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id 4a210c56-7070-43a0-9871-00ea9c7c08f5; Wed, 11 Nov 2026 23:00:56 +0000 (UTC)
X-Farcaster-Flow-ID: 4a210c56-7070-43a0-9871-00ea9c7c08f5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:00:56 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:00:54 +0000
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
Subject: [PATCH 17/40] nitro_enclaves: Add the slot pool donation commands
Date: Wed, 11 Nov 2026 22:59:21 +0000
Message-ID: <8a4509d7542883afe7337af9c1bf759740572a81.1794393490.git.graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Nitro Sandboxes introduce the concept of memory donations. In order to
launch more sandboxes, the parent instance needs to donate some of its
memory. A device that supports Nitro Sandboxes keeps its slot pool in
that memory: the descriptors of its slots and the memory the slots run
on. In preparation to donate that memory, add the commands that donate
memory for the slot descriptors and the registers that say how much of
it the device wants.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_pci_dev.h | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index 835413fca8040..e651e74ab656e 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -95,6 +95,42 @@
  */
 #define NE_RECV_DATA_SIZE	(240)
 
+/**
+ * DOC: Slot pool registers in the NE PCI device MMIO BAR
+ */
+
+/**
+ * NE_SLOT_POOL_MAX - (2 bytes) Register reporting the highest number of
+ *		      slots the device lets the pool grow to, or zero on a
+ *		      device that needs no donation (Read-Only).
+ */
+#define NE_SLOT_POOL_MAX	(0x01f2)
+
+/**
+ * NE_SLOT_POOL_LIMIT - (2 bytes) Register reporting how many slots the
+ *			pool has room for with the pages donated so far
+ *			(Read-Only).
+ */
+#define NE_SLOT_POOL_LIMIT	(0x01f6)
+
+/**
+ * NE_SLOT_POOL_GRAN_SIZE - (4 bytes) Register reporting the size, in bytes,
+ *			    of one donation to the pool (Read-Only).
+ */
+#define NE_SLOT_POOL_GRAN_SIZE	(0x0200)
+
+/**
+ * NE_SLOT_POOL_GRAN_ALIGN - (4 bytes) Register reporting the alignment a
+ *			     donation to the pool has to meet (Read-Only).
+ */
+#define NE_SLOT_POOL_GRAN_ALIGN	(0x0204)
+
+/**
+ * NE_SLOT_POOL_BASE_SIZE - (4 bytes) Register reporting the size, in bytes,
+ *			    of the base donation (Read-Only).
+ */
+#define NE_SLOT_POOL_BASE_SIZE	(0x0208)
+
 /**
  * DOC: MSI-X interrupt vectors
  */
@@ -125,6 +161,10 @@
  * @SLOT_ADD_BULK_VCPUS:	Add a number of vCPUs, not providing CPU ids.
  * @SLOT_ADD_INFO_PAGE:		Give a slot the info page, a memory region the
  *				device writes.
+ * @SLOT_POOL_DONATE:		Donate one page of parent memory to the slot
+ *				pool.
+ * @SLOT_POOL_SHUTDOWN:		Give the whole slot pool back.
+ * @SLOT_POOL_BASE_DONATE:	Donate the base run of the slot pool.
  * @MAX_CMD:			A gatekeeper for max possible command type.
  */
 enum ne_pci_dev_cmd_type {
@@ -142,6 +182,9 @@ enum ne_pci_dev_cmd_type {
 	SLOT_ADD_BULK_VCPUS	= 11,
 	/* 12 is a command this driver does not implement. */
 	SLOT_ADD_INFO_PAGE	= 13,
+	SLOT_POOL_DONATE	= 16,
+	SLOT_POOL_SHUTDOWN	= 17,
+	SLOT_POOL_BASE_DONATE	= 25,
 	MAX_CMD,
 };
 
@@ -284,6 +327,23 @@ struct slot_add_info_page_req {
 	u64	info_size;
 };
 
+/**
+ * struct slot_pool_donate_req - SLOT_POOL_DONATE and SLOT_POOL_BASE_DONATE
+ *				 request.
+ * @paddr:	Physical address of the donated run of pages.
+ */
+struct slot_pool_donate_req {
+	u64	paddr;
+};
+
+/**
+ * struct slot_pool_shutdown_req - SLOT_POOL_SHUTDOWN request.
+ * @unused:	In order to avoid weird sizeof edge cases.
+ */
+struct slot_pool_shutdown_req {
+	u8	unused;
+};
+
 /**
  * struct ne_pci_dev_cmd_reply - NE PCI device command reply.
  *
-- 
2.47.1

