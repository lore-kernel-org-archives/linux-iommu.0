Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438024;
	b=T0DCkzmpbShEVRWMnELxVt2BHA4KbMLQKHPKoikDF/t3NeBnmZj6sfwkuxQ0wVse9+UG
	 SB9eOyON3BM+xtKHTeZUWqUHwoTTq7B1RMUMYknQOSxIfgpiljUbbNj/QLt/aZcdkjtAv
	 IMtLqaK7QjTU5OUg9JZXtGPkxgmtHnRi1M98eWgwYirYSTSq/z4Ni1hAXJCp3hL3tWHze
	 ui3eHDG10Cp/K7YMf2Lbf+6+Byi9jnfNenMZFTxjbwfjJzQKoDtXYac9hWpsWZfxwuilj
	 gR/Z5B0hAaEpLLKtg4FG3os1I2xvtn+jrNmVX2qEW9OcOjIbUgXhiPEzAtSvl42lOlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438024;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=l5bcno4UXP7N2txNavRMGh0sD6iLfaBBk7CthX8bdlU=;
	b=Z1nFGmVUdvTxl4369ITJ/xxzMzcUkTHgQYKG1lpNyvt6JQwNK6iGI6uM22JOcNQV+DzU
	 6i2zSudu+wbVUybOl51ha/pPE7nZxFf54FkiDP1RifzhUq0KpDo5S1Cr+7mPcIm9VcUDu
	 PkvQBqIeVeUsJ1LeKMtwyrw2dJEvaFM6kRwYFA43WI9hTJ+Wqlms77lUwfvjl4MLmedjt
	 4D7ooCzTgoljBLW8WAC1pKm2sx0h9b6CaAchJNScAGBr+j6Bh3cbu9DVU1nAFUSndeu1o
	 8wpK/+Op0s0O/l/Uobg1acLiMg4TkpT2bmOK4ew2660o1WIlJFkQtne3xAHp52CDULg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=iRtyY3z5;
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCCD606A88D
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FCCD606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=iRtyY3z5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438023; x=1825974023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l5bcno4UXP7N2txNavRMGh0sD6iLfaBBk7CthX8bdlU=;
  b=iRtyY3z5ETcuaDr9xik/PtH0jidymKFp0JqGkXHy4xTpm7ex4uzKPmmz
   RnbCT25iXg1XUP/izzhxGWrPhDRHYfyC1nsi1W3GVa4DJ/iciOe3ihxlo
   NuJXTvsuzWlgspBB2zarKkClUyH+C4MCpOrtSy0+gGpBLYuySKym3EtZD
   linfoPXlfaOnfNzCplR8NcvZBLCEBuzj9RiQs5jV8jbhzuG/JCGpGZxpa
   NImu/9Il2+YLfRIjyqdXUsdW4q6IdL8nppsq2hnyqp/QNTYBhDWJj10O/
   FIiwvSvWgZMVyeZIy8cBAdRu0nOxhpbc8i7iWsR2xz1X6Z6YY+kO56Znu
   A==;
X-CSE-ConnectionGUID: bQJCdL0lTrSHcC+Vs8ubIA==
X-CSE-MsgGUID: rcJECCCSTmuuDApB103yLw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33757073"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:00:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:2153]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id 1ab7d5a6-029a-4b3d-8053-f474fd6a8a95; Wed, 11 Nov 2026 23:00:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1ab7d5a6-029a-4b3d-8053-f474fd6a8a95
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:00:22 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:00:19 +0000
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
Subject: [PATCH 16/40] nitro_enclaves: Turn the command reply into a per-command union
Date: Wed, 11 Nov 2026 22:59:20 +0000
Message-ID: <3512d2f3fb3ecb4a9795f50b2f61f371c3ac6458.1794393490.git.graf@amazon.com>
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

In preparation to support Nitro Sandboxes, whose commands carry
unrelated payloads in their replies, convert struct ne_pci_dev_cmd_reply
into a per-command union. A command with fields of its own in the reply
gets an arm holding them, and a caller reads the reply through the arm
for the command it issued.

The device writes every reply into the same 72 byte window of the PCI
BAR and picks the offset of each field itself, so we place an arm's
fields at the offsets the flat struct gave them and name the holes where
another command owns the bytes. static_assert() on every offset and on
the total size pins each arm to the layout the device uses.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c |  6 +-
 drivers/virt/nitro_enclaves/ne_pci_dev.c  |  4 +-
 drivers/virt/nitro_enclaves/ne_pci_dev.h  | 86 +++++++++++++++++------
 3 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 610d98264e5a1..77b15eda8d120 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1749,7 +1749,7 @@ static int ne_start_enclave_ioctl(struct ne_enclave *ne_enclave,
 
 	ne_enclave->state = NE_STATE_RUNNING;
 
-	enclave_start_info->enclave_cid = cmd_reply.enclave_cid;
+	enclave_start_info->enclave_cid = cmd_reply.start.enclave_cid;
 
 	return 0;
 }
@@ -2621,11 +2621,11 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 flags,
 	init_waitqueue_head(&ne_enclave->eventq);
 	ne_enclave->has_event = false;
 	mutex_init(&ne_enclave->enclave_info_mutex);
-	ne_enclave->max_mem_regions = cmd_reply.mem_regions;
+	ne_enclave->max_mem_regions = cmd_reply.alloc.mem_regions;
 	INIT_LIST_HEAD(&ne_enclave->contig_regions_list);
 	INIT_LIST_HEAD(&ne_enclave->mem_regions_list);
 	ne_enclave->mm = current->mm;
-	ne_enclave->slot_uid = cmd_reply.slot_uid;
+	ne_enclave->slot_uid = cmd_reply.alloc.slot_uid;
 	ne_enclave->state = NE_STATE_INIT;
 
 	list_add(&ne_enclave->enclave_list_entry, &ne_pci_dev->enclaves_list);
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index a07dbc6d8a9b7..8ed2349dea878 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -404,8 +404,8 @@ static void ne_event_work_handler(struct work_struct *work)
 		}
 
 		/* Notify enclave process that the enclave state changed. */
-		if (ne_enclave->state != cmd_reply.state) {
-			ne_enclave->state = cmd_reply.state;
+		if (ne_enclave->state != cmd_reply.info.state) {
+			ne_enclave->state = cmd_reply.info.state;
 
 			ne_enclave->has_event = true;
 
diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index 4f670c53dd3c0..835413fca8040 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -286,32 +286,78 @@ struct slot_add_info_page_req {
 
 /**
  * struct ne_pci_dev_cmd_reply - NE PCI device command reply.
- * @rc :		Return code of the logic that processed the request.
- * @padding0:		Padding for the overall data structure.
- * @slot_uid:		Valid for all commands except SLOT_COUNT.
- * @enclave_cid:	Valid for ENCLAVE_START command.
- * @slot_count :	Valid for SLOT_COUNT command.
- * @mem_regions:	Valid for SLOT_ALLOC and SLOT_INFO commands.
- * @mem_size:		Valid for SLOT_INFO command.
- * @nr_vcpus:		Valid for SLOT_INFO command.
- * @flags:		Valid for SLOT_INFO command.
- * @state:		Valid for SLOT_INFO command.
- * @padding1:		Padding for the overall data structure.
+ *
+ * The device writes the reply of every command into the same 72-byte
+ * window. A command whose reply carries fields of its own has an arm of
+ * the union below holding them, at the offsets the device writes them
+ * to, and a caller reads through the arm for the command it issued.
+ *
+ * @rc :			Return code of the logic that processed the
+ *				request.
+ * @padding0:			Padding for the overall data structure.
+ * @start:			Fields ENCLAVE_START fills.
+ * @start.slot_uid:		ENCLAVE_START. Slot of the started enclave.
+ * @start.enclave_cid:		ENCLAVE_START. Context ID of the enclave
+ *				vsock device.
+ * @alloc:			Fields SLOT_ALLOC fills.
+ * @alloc.slot_uid:		SLOT_ALLOC. Slot unique id of the new slot.
+ * @alloc.reserved8:		SLOT_ALLOC. Bytes owned by other commands.
+ * @alloc.mem_regions:		SLOT_ALLOC. Maximum number of memory
+ *				regions the slot accepts.
+ * @info:			Fields SLOT_INFO fills.
+ * @info.slot_uid:		SLOT_INFO. Slot the reply describes.
+ * @info.enclave_cid:		SLOT_INFO. Context ID of the enclave vsock
+ *				device.
+ * @info.reserved24:		SLOT_INFO. Bytes owned by other commands.
+ * @info.mem_regions:		SLOT_INFO. Maximum number of memory regions
+ *				the slot accepts.
+ * @info.mem_size:		SLOT_INFO. Memory size added to the slot.
+ * @info.nr_vcpus:		SLOT_INFO. Number of vCPUs added to the slot.
+ * @info.flags:			SLOT_INFO. Slot flags.
+ * @info.state:			SLOT_INFO. Slot state.
+ * @info.padding1:		SLOT_INFO. Padding for the overall data
+ *				structure.
  */
 struct ne_pci_dev_cmd_reply {
 	s32	rc;
 	u8	padding0[4];
-	u64	slot_uid;
-	u64	enclave_cid;
-	u64	slot_count;
-	u64	mem_regions;
-	u64	mem_size;
-	u64	nr_vcpus;
-	u64	flags;
-	u16	state;
-	u8	padding1[6];
+	union {
+		struct {
+			u64	slot_uid;
+			u64	enclave_cid;
+		} start;
+		struct {
+			u64	slot_uid;
+			u64	reserved8[2];
+			u64	mem_regions;
+		} alloc;
+		struct {
+			u64	slot_uid;
+			u64	enclave_cid;
+			u64	reserved24;
+			u64	mem_regions;
+			u64	mem_size;
+			u64	nr_vcpus;
+			u64	flags;
+			u16	state;
+			u8	padding1[6];
+		} info;
+	};
 };
 
+static_assert(sizeof(struct ne_pci_dev_cmd_reply) == 72);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, start.slot_uid) == 8);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, start.enclave_cid) == 16);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, alloc.slot_uid) == 8);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, alloc.mem_regions) == 32);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.slot_uid) == 8);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.enclave_cid) == 16);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.mem_regions) == 32);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.mem_size) == 40);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.nr_vcpus) == 48);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.flags) == 56);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.state) == 64);
+
 /**
  * struct ne_pci_dev - Nitro Enclaves (NE) PCI device.
  * @cmd_reply_avail:		Variable set if a reply has been sent by the
-- 
2.47.1

