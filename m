Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437990;
	b=qct2+3Aiumo47YM1JIH39V30m/ACXGrSEgirzIc/kuPSXzn2E2LF6lERcwxs4CRhtCxn
	 vO4AuNdN+Df625zZ5nWCVEwVWbnT6i/nLZhTgc4EAm5vJ5O3Q0SWTAcFbWruwdqjzx4Te
	 jURsGZxiCCfpmWRhR7SOwAddJUJHRXq2d7AC+VEgUovMS+L4sene0SgbL81VWt+RpI3rl
	 2/jjVBK/nZCHg4+GViiPIPZCw8ztteI0JY6YePQyZ9VHUQVWwByjnkNeBvMbegQ4udG7k
	 UN14izRaeCXllEZ66HRiT+kIki8SQ8oBzIGONQ9Gcxi8QjKrHfdwrRl4rTnD90C97SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437990;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NxlZ3d0PBPnk05nrYhRlkiXhE+5MZd2ltaw+yg5jqDs=;
	b=u4bkzII6TsB8EzvR6pvRQnSNDuewGx/EhZgtHjXwRPbGUjptJ0eblY7FAgp1wJVPK3Fb
	 EoqvkPMeTDiazXICiQuC32UKmbg9a6K04Y083DkeQ6j1yLq5U/LoHjnFLXqzDQPo4lPEy
	 YykawQOpxFPDemB/hnjzdjuTkMWMOmOitjsVUP6sm8UTEzSbQ2JyaYBRrTYON+b4lN/7M
	 11hEQ1JhcFakndbeRWa/8lbySdXfGCWRyYApo0D5Q9gZcgPoAtsDrfLKa+cGv2PVGN9AD
	 49AOl718kTTC4FYcHZGFqAJZ1j2sXULHGUPs8I+MQxVIUpfdUfBGB1Vt8Nbu3k+FjYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="IO/PpZn+";
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37F606A321
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F37F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=IO/PpZn+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794437989; x=1825973989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NxlZ3d0PBPnk05nrYhRlkiXhE+5MZd2ltaw+yg5jqDs=;
  b=IO/PpZn+Wzfc35UQWMioQZS5/HJokM5d/IX6H296oT7ZOajbqXGpxeqs
   w06gOOUA1X3RMZGKCl0ATE2DIoFIdYlboGz4Xx6d4oDr8uulcJL32HVMm
   nDDMZtoAFdFFeuQnZRySZeBgh+9dDgx2tWyvF5UYJOtTIQkQ5h5TcIr9m
   T9MTwA8o6/ejNApBR5b1+T4P2Ra+CVkWl4AD6+zrUBcO4jNxjL1JlH6j4
   0DnnDsae28UezxNIj8X490yGnWFQ3q6MJaKP7MzLNuwIFmADPg5IUczPd
   NIl6Q3AkHOJvqBG50WvFTZwStIE5/dRDNCAbla0L/Y3rVDDPtd4lf273F
   Q==;
X-CSE-ConnectionGUID: tfAma2DzRFOFb8bdIGIDVw==
X-CSE-MsgGUID: iyTsTEHxS0uD4j25ZbIutg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33573114"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:59:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:10977]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id f883803e-6c22-4425-9ce0-85931add301b; Wed, 11 Nov 2026 22:59:48 +0000 (UTC)
X-Farcaster-Flow-ID: f883803e-6c22-4425-9ce0-85931add301b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:59:48 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:59:45 +0000
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
Subject: [PATCH 15/40] nitro_enclaves: Document the info page in the memory pool
Date: Wed, 11 Nov 2026 22:59:19 +0000
Message-ID: <e7f196dd3055426734dc363f9a75a45e442d3eec.1794393490.git.graf@amazon.com>
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

An info page takes one contiguous allocation from the same CMA
reservation as enclave memory, so an admin reserving the pool needs to
leave room for it. Document its size, that it is registered before it is
mapped and is read-only to user space from then on, and that it keeps
its allocation alive like a memory region does. Also say that a larger
NE_ALLOC_MEMORY request comes back in several runs where it has to.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 Documentation/virt/ne_overview.rst | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/ne_overview.rst b/Documentation/virt/ne_overview.rst
index 4c4b7febaff0a..3cfc50f788433 100644
--- a/Documentation/virt/ne_overview.rst
+++ b/Documentation/virt/ne_overview.rst
@@ -150,10 +150,11 @@ node enables to name the node a reservation lands on. cma= needs neither, so
 on a host with one online node the driver's own select is the whole
 requirement.
 
-NE_ALLOC_MEMORY on the enclave file descriptor allocates 2 MiB aligned,
-physically contiguous memory from one host NUMA node's CMA area. A request
-that area cannot serve fails with -ENOMEM, so the reservation bounds what the
-enclaves on a node can take between them.
+NE_ALLOC_MEMORY on the enclave file descriptor allocates 2 MiB aligned memory
+from one host NUMA node's CMA area, in one physically contiguous run where it
+can and several where it cannot. A request that area cannot serve fails with
+-ENOMEM, so the reservation bounds what the enclaves on a node can take
+between them.
 It returns a file descriptor for the allocation. For an enclave whose cores
 all sit on one node the ioctl refuses any other node, so name the same node
 here and in NE_ADD_ANY_VCPU. An enclave built out of a pool that spans nodes
@@ -195,9 +196,22 @@ a caller reaches and not for all of it. It keeps the memory reachable from the
 parent for as long as it lives, so an allocation that is only being handed to
 an enclave stays private.
 
+An enclave can also have an info page: an allocation the NE PCI device writes,
+provided to the device by NE_SET_INFO_PAGE. It does not become the enclave's
+memory. Only the device writes it, so from NE_SET_INFO_PAGE on it is read-only
+to user space: write() on the descriptor fails and a mapping has no write
+access. The call fails while a mapping made before it exists, so a caller
+maps the page after it. It is asked for as NE_MEMORY_SHARED, since a mapping is
+the only way for the parent to read back what the device wrote. The device is
+given one address and one length for it, so it has to be one contiguous run,
+and 2 MiB is the only size that cannot come back split. Ask for 2 MiB per
+enclave that will have one, on the node its cores sit on, or on every node it
+may draw from where the pool spans nodes.
+
 NE_SET_USER_MEMORY_REGION is unchanged and still takes the address of a
 hugetlbfs region.
 
-The allocation lives until the last of its descriptor, its mappings and the
-regions given from it is gone, so neither closing the descriptor nor
-unmapping takes memory away from a running enclave.
+An allocation lives until the last of the things holding it is gone: its
+descriptor, its mappings, the regions given from it and the enclave it is the
+info page of. So neither closing the descriptor nor unmapping takes memory away
+from a running enclave.
-- 
2.47.1

