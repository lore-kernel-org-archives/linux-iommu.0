Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436985;
	b=MtJxBpJ0O7v5VofEOZm7+q7CgLxj4LWiitylnLGphq+r7+6WMorVUSBBNEl0gPapl3wl
	 KxqJr1jSgBKX7pVIekqNT+7aEOaAwT7ML2W8yq6rjaByBkGMbNGH0YtBWHjaumjrc+s++
	 caOsZDsLh1D6+r5UgSTt+GAxru37MQcNEpg/mGf+HywI7LUrLGsRLPteLEg5sf9Oorcok
	 YwjKgUuvgybat7yCbG+UoTCuBrPsLfoGKOkRRP03asvqECmFdGKkMKcfALi0YEcTACdzw
	 PtzzyqyPRDThhHkbXsQUpXlpkZyg0vw1B0lBa6RhPEUSy0u7MQMhzo4RcoldyhGA/NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436985;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=2ZMJ4Q9G7ZD0Yoa+if1GcEy8XdPuoEVuvEiFupJeQYU=;
	b=UAQMpzvzW+Yuqi2pkUeYm+HtjQmykys8C9baHF4LqKi1H0m4pSG7V7zK8cJGGnqKBfAq
	 MlpfYUV7ZwDb1nLzPSUOWMzWcZpPz8VgCBIw63KcQL4XYH4TKQZd8xkMfMBPurVZjneIP
	 Q5bEwJTc+ApK8zhmIhQTBF3UNFypuRJeMtaHBlwvDIuoK8yoRXp69Coth++/TNSl6niem
	 NOZkhlCIyIa9OqNMbe3H2B3kuFVmO1F33CYo5y590ObXTn5/9zJPXJo/RzlYbi1iaYI1H
	 EwgjA9dUduBTl4ne7XuAHDuOKGsE75wNXRI2TV6IPURl4GPBm9Qa8fc3BKq88YqRYlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Hn+KTOtx;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA460A2613
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39EA460A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Hn+KTOtx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794436985; x=1825972985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZMJ4Q9G7ZD0Yoa+if1GcEy8XdPuoEVuvEiFupJeQYU=;
  b=Hn+KTOtxf6tW5B76ABMvwrWjyKMJqmujjQay32IKMFXaki6Qv6rDyqfc
   kpmKl8CSE8rGwYaHi97MCeZxRytTNnyvgllrNg7RChTiPX6pF86r36T+V
   X/UXujW47tBVfk0EWFGnwHeQcaWOFDf6GyBTi7Pl5yeB4qFLAWAo38mgt
   R/mDjIajTiO7SaJhgYMPs3sQ9lboaNvUW3HyMmf3zpH+yMbNCa7WRSDpo
   MZvi/FdrlKaG15b/B47fyLrMiSJQS9T+WQcccxekgpwBv/DLMc/qseang
   QdUh40tkF9eoylJGbZAkx4HGoUyzkQ8VRoIp4u+X3cgGYF32gnVVOA3bZ
   w==;
X-CSE-ConnectionGUID: rpSiq75CQAqScimJ/gHWxA==
X-CSE-MsgGUID: 8T3304PqSW2LHdQaya1Irg==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33537522"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:43:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:18606]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.255:2525] with esmtp (Farcaster)
 id 9c406460-bb57-4d22-9e2b-7eaa8f7d1579; Wed, 11 Nov 2026 22:43:01 +0000 (UTC)
X-Farcaster-Flow-ID: 9c406460-bb57-4d22-9e2b-7eaa8f7d1579
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:01 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:42:59 +0000
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
Subject: [PATCH 04/40] nitro_enclaves: Document multi-NUMA CPU pools
Date: Wed, 11 Nov 2026 22:41:49 +0000
Message-ID: <72f6664721ada7bcde0b185a7fc7c13e5efcc479.1794393490.git.graf@amazon.com>
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

An admin placing enclaves or sandboxes across NUMA nodes needs to know
how the CPU pool, automatic CPU selection and the memory-locality check
interact.

Document those rules in ne_overview.rst, together with the per-node
sysfs directories, and point the cpu_pool ABI file at that section.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 .../sysfs-devices-virtual-misc-nitro_enclaves |  3 ++-
 Documentation/virt/ne_overview.rst            | 27 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves b/Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves
index 596054b75e0cf..c549364353186 100644
--- a/Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves
+++ b/Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves
@@ -39,7 +39,8 @@ Description:
 		avail does not list.
 
 		A read takes the pool lock, so it can wait for a write to
-		ne_cpus to finish.
+		ne_cpus to finish. For how an enclave is given cores from a
+		particular node, see Documentation/virt/ne_overview.rst.
 
 What:		/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/nodeX/total
 What:		/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/nodeX/used
diff --git a/Documentation/virt/ne_overview.rst b/Documentation/virt/ne_overview.rst
index aecd3704acaf5..223ee7fdec51b 100644
--- a/Documentation/virt/ne_overview.rst
+++ b/Documentation/virt/ne_overview.rst
@@ -48,7 +48,7 @@ be aligned 2 MiB / 1 GiB physically contiguous memory regions (or multiple of
 this size e.g. 8 MiB). The memory can be allocated e.g. by using hugetlbfs from
 user space [2][3][7]. The memory size for an enclave needs to be at least
 64 MiB. The enclave memory and CPUs need to be from the same NUMA node,
-unless the CPU pool spans several of them.
+unless the CPU pool spans several of them; see `Multi-NUMA CPU pools`_.
 
 An enclave runs on dedicated cores. CPU 0 and its CPU siblings need to remain
 available for the primary VM. A CPU pool has to be set for NE purposes by an
@@ -99,3 +99,28 @@ enclave process can exit.
 [6] https://www.kernel.org/doc/html/latest/x86/boot.html
 [7] https://www.kernel.org/doc/html/latest/arm64/hugetlbpage.html
 [8] https://www.kernel.org/doc/html/latest/arm64/booting.html
+
+Multi-NUMA CPU pools
+--------------------
+
+The CPU pool may span multiple NUMA nodes. NE_ADD_VCPU with vcpu_id == 0
+takes the first free core in the pool whatever node it sits on, so an
+enclave built that way can end up holding cores on several nodes.
+NE_ADD_ANY_VCPU names the node instead: the kernel takes a free core on
+that node, and fails rather than crossing to another node once that node
+has none left. User space builds an enclave across nodes by asking for
+each node in turn, and sets numa_node to NE_NUMA_ANY when it does not
+care. Both start from a free thread of a core the enclave already holds,
+and only take a new core once there is none.
+
+The node says where cores come from. An enclave built out of a pool that
+spans nodes has no node of its own, so the rule that its memory be on
+that node does not apply to it and its memory can come from any node.
+
+The pool occupancy is readable under
+/sys/devices/virtual/misc/nitro_enclaves/cpu_pool/, and per node under
+its ``node0``, ``node1``, ... subdirectories, one for each node that was
+online when the device was probed. A node the pool holds nothing on
+reads empty rather than being absent. The driver offlines pool threads,
+so ``nodeN/cpulist`` under /sys/devices/system/node stops listing them
+and answers nothing about the pool.
-- 
2.47.1

