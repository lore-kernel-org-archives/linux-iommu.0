Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437040;
	b=yXDJIx1cBjHrXn3KZKQsESb2YlGzlnNLLhXIA1sZusx2cX7+GUangeiPn2u+88J0qhoh
	 oYV5hrMPCneuzCJv3DY1ZmSK5h9N2abk1M2l+CwVhKRvHfGpikyseoBB1/2sqdZK023G3
	 4ZoU/mdtoC8wJTnkIRmjali0DGTFSC2d0ZsrzY4C3Wu/HYmdpdILwUyQlvw0frq9Hn66v
	 FbVNqf7uojZ4S9fL70Uxib3hX/OT70coURrJm4jOIb4zNWjkig/nZTLiCaJyS72HMrFE+
	 svuIPCmExRRyDSeCg+rhDm5QRECujeWvrz/PXfjK7UwnpH3Tsyfu8H8Jy0+HNHUT6tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437040;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=wJjMYgz1PxuwUEJMcsvLW+MBhNnHPcTwlN3u7yQ5KPM=;
	b=Z/aw+AJUHp7u7M3WdlA6HRs7Fbil6WntZLkeRH+qwSSaaAGLE2MZ5/PCrpbGGNVdYnNG
	 aZU2HYDOUHw4rouyxkEqNVBIfmgAZU8G20O8uPdAy2r0GS1+6b/yNDDb6TXjsKZUdcElQ
	 xgYYQXnApWwesoWxQytb+l+6VyK7V7Q2YYW1htozcuXsS3IOds8TkGWQ/HQ6lYwrNVkxk
	 kKjHEj+ku7qgRLGOVJLpB3QZUe/R6egpqOCKuHkbJQNGGzSHZbkqw+2MA5xkoH/+k6rvX
	 v8ME/pOslx4vUVtET9AcjUSWBM23IzSiGrUju2pV+2mPPFBmttriyEpvP6zzF0TogbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=EA8Iuxyb;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3F606A33F
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F3F606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=EA8Iuxyb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794437040; x=1825973040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJjMYgz1PxuwUEJMcsvLW+MBhNnHPcTwlN3u7yQ5KPM=;
  b=EA8IuxybiE+gReqGh7IToBFy6po5AAaN+BQ8F2nTyjV2pDswX4nfd3c9
   bqbO6s2LhamC9kQDd3tA8YEIPB40qyvPrucIO1LXdH2T/KnpmqLuprgoF
   jwDQpWR+J2OOTxlVz6lf26o/qRqcRdnTQWp97G+KKj0QWOZ5ehwAaglXh
   XHlf5riUqUjsDsqhW5g4xFx0rASkQlm3ZSc/PeQLQDFtLPUuCcwIVa3Lr
   WKYCgfXRZ273MglzF51/Az9Qe5QwV3NREAu1B9NxauIrxMpXQHpycREXq
   PznP+mCMCTHpA3wEBwuMMvUnNxv8oOtEq9luXbs3SXa2vPVWX4imL1j6/
   w==;
X-CSE-ConnectionGUID: Cs8OzKSgQCaEFf6lQyWf2Q==
X-CSE-MsgGUID: e9wvUfnWQSiUc9y4a+yklQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33549811"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:43:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:23954]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id d283ee22-8d0d-49a9-81b8-62fd5a464c05; Wed, 11 Nov 2026 22:43:57 +0000 (UTC)
X-Farcaster-Flow-ID: d283ee22-8d0d-49a9-81b8-62fd5a464c05
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:57 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:55 +0000
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
Subject: [PATCH 09/40] nitro_enclaves: Document the memory pool
Date: Wed, 11 Nov 2026 22:41:54 +0000
Message-ID: <1119ca93f65bd771345d9153c8b8c133e951506a.1794393490.git.graf@amazon.com>
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

An admin reserving memory for enclaves needs to pick the CMA area and
the kernel parameters that fill it. Document the pool: allocating with
NE_ALLOC_MEMORY, writing the image through the returned descriptor and
adding it with NE_ADD_MEMORY_REGION, the config options a reservation
needs to be reachable, and the difference between private and shared
allocations and how long an allocation lives.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 Documentation/virt/ne_overview.rst | 83 ++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/ne_overview.rst b/Documentation/virt/ne_overview.rst
index 223ee7fdec51b..4c4b7febaff0a 100644
--- a/Documentation/virt/ne_overview.rst
+++ b/Documentation/virt/ne_overview.rst
@@ -113,9 +113,10 @@ each node in turn, and sets numa_node to NE_NUMA_ANY when it does not
 care. Both start from a free thread of a core the enclave already holds,
 and only take a new core once there is none.
 
-The node says where cores come from. An enclave built out of a pool that
-spans nodes has no node of its own, so the rule that its memory be on
-that node does not apply to it and its memory can come from any node.
+The node says where cores come from. NE_ALLOC_MEMORY takes its own node;
+see `Memory pool`_. An enclave built out of a pool that spans
+nodes has no node of its own, so the rule that its memory be on that node
+does not apply to it and its memory can come from any node.
 
 The pool occupancy is readable under
 /sys/devices/virtual/misc/nitro_enclaves/cpu_pool/, and per node under
@@ -124,3 +125,79 @@ online when the device was probed. A node the pool holds nothing on
 reads empty rather than being absent. The driver offlines pool threads,
 so ``nodeN/cpulist`` under /sys/devices/system/node stops listing them
 and answers nothing about the pool.
+
+Memory pool
+-----------
+
+Enclave memory must be physically contiguous, in chunks of at least 2 MiB,
+and, for an enclave whose cores all sit on one node, on that node. It has
+traditionally come from hugetlbfs [2], which provides the hugepage sizes the
+architecture has -- 2 MiB and 1 GiB on x86, and 32 MiB, 512 MiB or 16 GiB on
+arm64 depending on the page size -- and needs the hugepage count managed out
+of band.
+
+The driver can hand that memory out itself, backed per NUMA node by the
+kernel's Contiguous Memory Allocator (CMA). Reserve an area on every node
+you intend to run enclaves on, with the numa_cma= or cma_pernuma= kernel
+parameters documented alongside the rest of them [4]. On a host with one
+online node, cma= reserves the one area there is to reserve and the driver
+uses it.
+
+Reaching a reserved area takes CONFIG_DMA_CMA, which NITRO_ENCLAVES selects,
+so the driver always has it. numa_cma= and cma_pernuma= need
+CONFIG_DMA_NUMA_CMA on top of that, which a host with more than one online
+node enables to name the node a reservation lands on. cma= needs neither, so
+on a host with one online node the driver's own select is the whole
+requirement.
+
+NE_ALLOC_MEMORY on the enclave file descriptor allocates 2 MiB aligned,
+physically contiguous memory from one host NUMA node's CMA area. A request
+that area cannot serve fails with -ENOMEM, so the reservation bounds what the
+enclaves on a node can take between them.
+It returns a file descriptor for the allocation. For an enclave whose cores
+all sit on one node the ioctl refuses any other node, so name the same node
+here and in NE_ADD_ANY_VCPU. An enclave built out of a pool that spans nodes
+has no node of its own and takes memory from any of them.
+
+An allocation is NE_MEMORY_PRIVATE unless the flags say NE_MEMORY_SHARED.
+A private one cannot be mapped, and mmap() on it returns ENODEV. Writing to
+the descriptor places bytes in either kind, which is how an enclave image
+gets into one. There is no read operation on the descriptor.
+
+A shared allocation can also be mapped, at any 2 MiB aligned offset for a
+multiple of 2 MiB, with MAP_SHARED. A caller maps one to keep an address for
+memory it goes on using after handing it over, including after the allocation
+has been donated, which is where writing to the descriptor stops working. Such
+a mapping is readable too, and is the only way to read allocated memory back.
+
+The mapping is VM_PFNMAP, so it holds no struct page references and any DMA pin
+over it returns EFAULT, long-term or not; io_uring buffer registration and RDMA
+memory registration are two that a caller might expect to work and that do not.
+Reaching enclave memory from a device in the primary VM is not something this
+interface offers.
+
+The allocation is accounted against RLIMIT_MEMLOCK. NE_ADD_MEMORY_REGION
+takes the descriptor and gives the enclave the whole allocation, as one
+memory region per contiguous run it is made of, or fewer where runs turn out
+to be physically adjacent. It also ends writing: the memory is the enclave's
+from that point, so an image goes in first. It takes private allocations
+only, since memory the parent can still reach is not memory the enclave has
+to itself.
+
+An enclave's memory is laid out in the order its allocations are given to it,
+and the offset NE_GET_IMAGE_LOAD_INFO returns is an offset into that layout.
+A caller building an enclave out of several allocations therefore picks the
+order first, writes at the offsets that order implies, and gives them away in
+it.
+
+A mapping is populated as it is touched, so it costs page tables for the part
+a caller reaches and not for all of it. It keeps the memory reachable from the
+parent for as long as it lives, so an allocation that is only being handed to
+an enclave stays private.
+
+NE_SET_USER_MEMORY_REGION is unchanged and still takes the address of a
+hugetlbfs region.
+
+The allocation lives until the last of its descriptor, its mappings and the
+regions given from it is gone, so neither closing the descriptor nor
+unmapping takes memory away from a running enclave.
-- 
2.47.1

