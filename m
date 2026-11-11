Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438128;
	b=s1fdtwePZcRYU6cauEqbFzb/9oF8BSvro93SIIOu4+OhjCHe0IlLB9PBtgi0KBiAqMu6
	 kV0znPO2BDCatBwPHVcfXdPE5g0NHjZe9J4tEPALWWZ7DZqTfDDor1/Aj/Yv7xb+4Zzgf
	 ZfvujDkrTZj0LbB3iYUswUoJDm812BIXBUBbK4bZ/qBJ96SD6ME5nyBZL1i0SqcNDGR6Y
	 3WX8vJq9xucYqnAUU0iqZZRU1rNWlGKTuUVVpe1YZ/tK7rFbAARS1N3bAGqL1dPe3UaA/
	 5R3+a21w6wt2js2nfPGLjrPEfgI6I0xr4y5dTjjk7lP9M0m1UEEnbUw2sfLf2PZqQIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438128;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=fxeX7TnOeQeidfd0VzWFsebTuPycm/niS4h2cZ5wwxA=;
	b=MvGSNZfp866YwdPneTZyxGYEwX85dafrVKhKVmSo1supPpDwMwbgHgHorBcwPKfugDI+
	 XqvsoGVdR3ou85msCSuic0l2uNpe5KksfE+OQr9Ta+JtffG+qhsTTqENalShemII6yPRy
	 BOKs6cQH1vNVn66LLbLaq6YWwTsT4hrrcIVvft6MLXTbzsuozWqrfMVggNdkuXSxOO9WG
	 jILTl1JgC2mfwag0ZTlGdYjm9AKqOvaZKn//2H9zye4hqfPsyxzTPcnzoexIdUvsfNZYD
	 cTtlAfmYqWC/Pv3m/zAYZib7yD6P5aMY039Pc/HmY02OBWGO32FMCRE94ZlfdXQ+Oww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=ImoTMGSH;
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1710606A33A
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 23:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1710606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=ImoTMGSH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794438127; x=1825974127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fxeX7TnOeQeidfd0VzWFsebTuPycm/niS4h2cZ5wwxA=;
  b=ImoTMGSHSjc8OjdJqz1oikKV/m+rXQ7/85cajkFslk5ENHeU3bw2h1V2
   35y6Tzq5cqEN+/XoqKWWHqPxfxMcb2z42sBnS2tsz4eaTbGi/F5JsrBk9
   qxyVG20iE/PBBoQC7QMzBOOSIl+Rio9L69PFEpxYPAqkIFiLpPQtk7cYh
   1s+uCr7LkhXjwfPu8DIMyKJMYVFxyENBaUpQk1W4zhrLKzIVCLGN46vKf
   5xoSlXsMwV1EI7r0iIimWWlrjhPzX6rRgNfsonyx9UBnxQlpm1BTVJtZu
   pp2gmCKIGcJL9GhjVBYW4qPabB6TKu9UzKQszvr7pde00Tn6mWg2eH34k
   w==;
X-CSE-ConnectionGUID: zbfFMcWfRSuQ2BSmPHMGzw==
X-CSE-MsgGUID: LlLoQtmVR6aIOnk6axVbmw==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33797024"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 23:02:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:27716]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 60a5f721-d9ab-4ef8-8e59-27d90924e641; Wed, 11 Nov 2026 23:02:05 +0000 (UTC)
X-Farcaster-Flow-ID: 60a5f721-d9ab-4ef8-8e59-27d90924e641
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:02:04 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 23:02:02 +0000
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
Subject: [PATCH 19/40] nitro_enclaves: Add the slot pool growth commands
Date: Wed, 11 Nov 2026 22:59:23 +0000
Message-ID: <b16f6669871f64b97cea9ec50baf3462a44054a9.1794393490.git.graf@amazon.com>
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

In preparation to grow the slot pool at runtime, add
SLOT_POOL_MEM_DONATE and SLOT_POOL_GET_LIMITS.

The slot pool has two halves: the slot descriptors, which
SLOT_POOL_DONATE grows, and the memory the device runs slots out of,
which SLOT_POOL_MEM_DONATE grows. Its reply names the part of the
offered run that the device took. A slot needs room in both halves.
SLOT_POOL_GET_LIMITS reports both counts, along with how many slots one
memory donation adds, so that the parent knows which half to grow next.
Both replies get an arm of the reply union.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_pci_dev.h | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.h b/drivers/virt/nitro_enclaves/ne_pci_dev.h
index 4e991c4b0e70f..3718f893e4f65 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.h
@@ -164,6 +164,10 @@
  * @SLOT_POOL_DONATE:		Donate one page of parent memory to the slot
  *				pool.
  * @SLOT_POOL_SHUTDOWN:		Give the whole slot pool back.
+ * @SLOT_POOL_MEM_DONATE:	Donate a run of parent memory to the memory the
+ *				device runs a slot out of.
+ * @SLOT_POOL_GET_LIMITS:	Report how many slots each half of the pool has
+ *				room for.
  * @SLOT_POOL_BASE_DONATE:	Donate the base run of the slot pool.
  * @MAX_CMD:			A gatekeeper for max possible command type.
  */
@@ -185,6 +189,8 @@ enum ne_pci_dev_cmd_type {
 	SLOT_POOL_DONATE	= 16,
 	SLOT_POOL_SHUTDOWN	= 17,
 	SLOT_POOL_BASE_DONATE	= 25,
+	SLOT_POOL_MEM_DONATE	= 26,
+	SLOT_POOL_GET_LIMITS	= 27,
 	MAX_CMD,
 };
 
@@ -344,6 +350,16 @@ struct slot_pool_shutdown_req {
 	u8	unused;
 };
 
+/**
+ * struct slot_pool_mem_donate_req - SLOT_POOL_MEM_DONATE request.
+ * @paddr:	Physical address of the donated run of memory.
+ * @size:	Size, in bytes, of the donated run.
+ */
+struct slot_pool_mem_donate_req {
+	u64	paddr;
+	u64	size;
+};
+
 /**
  * struct ne_pci_dev_cmd_reply - NE PCI device command reply.
  *
@@ -377,6 +393,21 @@ struct slot_pool_shutdown_req {
  * @info.state:			SLOT_INFO. Slot state.
  * @info.padding1:		SLOT_INFO. Padding for the overall data
  *				structure.
+ * @mem_donate:			Fields SLOT_POOL_MEM_DONATE fills.
+ * @mem_donate.consumed_paddr:	SLOT_POOL_MEM_DONATE. Physical address of the
+ *				run the device took out of the donation.
+ * @mem_donate.consumed_size:	SLOT_POOL_MEM_DONATE. Size, in bytes, of the
+ *				run the device took, zero where it took none.
+ * @limits:			Fields SLOT_POOL_GET_LIMITS fills.
+ * @limits.meta_limit:		SLOT_POOL_GET_LIMITS. Slots the descriptors
+ *				donated so far have room for.
+ * @limits.mem_limit:		SLOT_POOL_GET_LIMITS. Slots the memory donated
+ *				so far has room to run.
+ * @limits.slots_per_donation:	SLOT_POOL_GET_LIMITS. Slots one donation of
+ *				memory adds to the memory the device runs a
+ *				slot out of.
+ * @limits.reserved14:		SLOT_POOL_GET_LIMITS. Bytes the device writes as
+ *				zero.
  */
 struct ne_pci_dev_cmd_reply {
 	s32	rc;
@@ -402,6 +433,16 @@ struct ne_pci_dev_cmd_reply {
 			u16	state;
 			u8	padding1[6];
 		} info;
+		struct {
+			u64	consumed_paddr;
+			u64	consumed_size;
+		} mem_donate;
+		struct {
+			u16	meta_limit;
+			u16	mem_limit;
+			u16	slots_per_donation;
+			u16	reserved14;
+		} limits;
 	};
 };
 
@@ -417,6 +458,15 @@ static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.mem_size) == 40);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.nr_vcpus) == 48);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.flags) == 56);
 static_assert(offsetof(struct ne_pci_dev_cmd_reply, info.state) == 64);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply,
+		       mem_donate.consumed_paddr) == 8);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply,
+		       mem_donate.consumed_size) == 16);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, limits.meta_limit) == 8);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, limits.mem_limit) == 10);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply,
+		       limits.slots_per_donation) == 12);
+static_assert(offsetof(struct ne_pci_dev_cmd_reply, limits.reserved14) == 14);
 
 /**
  * struct ne_pci_dev - Nitro Enclaves (NE) PCI device.
-- 
2.47.1

