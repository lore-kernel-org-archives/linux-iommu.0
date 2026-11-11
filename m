Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405890;
	b=qxYQczMT/pApaZXFERKW8C3bcXp+mLG67WIlb2YUEIDOEgKu4KOTJvzUqmvjyZBIClMj
	 kUrFuDbNnLuLn6fh9UNpNMO/FCRqnan9OFVkTbUSOQpnEZ60bmVs1RPyaZ+HktRe9AQ/r
	 HdSJ0bkoZ9igstH8i3Bix2OXVWpqoS0nTLJaANN16R9GJYQqCULKEYdLI9QFahfuSC+om
	 SKMVw0+Vnfh32bAd0Ic7bzwgITBgKOSPLzivgr7HNd/L/6zKR/OJs4wOcWPdipARFdoOR
	 z/VO6GyABPi/dXHPhKSBnLRfXsOXDPkPQL33C7qNFc7OFJGKdF1VDUVH8Zv4o18TMzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405890;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=ajXEYqjwM+nCEIVJkZ6WILdonbk+OIty74QS6bYQ+DU=;
	b=k/JDw3ku2NPFVI+Xqf3p0cDJ6aZHJFHUUlPbAzITnYfN4SpwHGHoZ12qL7EftzMR8cMP
	 Mda6heZF77UNULY/DL6kPQN1gqOWvd9Qn/W7e3DxI23ZvVzQrXzKG2E23jSp0ftBG5OVe
	 aFHmrnGnlfo3fj3bQhJmJMBIhJIfoQ4yfAYABbAagZvLre7nbtVoq3kpeQCWRXQgbknhL
	 DWORIu1osiAesHy/QcPAefW9Q76tMe3ZmcpMwxEWNpy0Pvaoc1vtne6adJANfvJhZDlEl
	 dZeDRbZIpMw2hON7GMC6a1Iqii901HpDvKzpO/bjc0R5V0OIo52lREIxQ0MZc1iVVSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="X/rDSNse";
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B822606A332
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 14:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B822606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=X/rDSNse
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794405889; x=1825941889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ajXEYqjwM+nCEIVJkZ6WILdonbk+OIty74QS6bYQ+DU=;
  b=X/rDSNseJUL5D1mDWpguwOaxmfSRzzZk5u1qHIXQ8ci8qitdNyXR3xxs
   blkKgqRul4vyMVPqeODvgGxiwjlWmM41xFnedjc6LJNXSWy/aaANbrUwX
   GLIN+rOREBy+usQ6SEsBF7sIihP4nNJghbHL9/npKgHw08VaAhViJSi7b
   kiNNpeuZCMiSgrbyXYtDIt0dnzolQvjRQv8Uaa1qgveSKbWRP+ELio2dv
   SuSCxDR7PeSKgmk+D0/Z2W3ruNrSPQU2OYS6WGENinxO3WM43r341R1hu
   h/CjebbxH5t3ePUuWkwe+mQrkgODC9ODRvje5jOCRGTUhlE99p44iDwCN
   w==;
X-CSE-ConnectionGUID: mp+qsCQeQSa3lZBPareIIw==
X-CSE-MsgGUID: OV2cOm+zQAGswQmM5sZIqw==
X-IronPort-AV: E=Sophos;i="6.27,207,1787011200"; 
   d="scan'208";a="33751363"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 14:04:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:17225]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id 5ffd8552-4597-40d9-9dd4-121f17a20803; Wed, 11 Nov 2026 14:04:45 +0000 (UTC)
X-Farcaster-Flow-ID: 5ffd8552-4597-40d9-9dd4-121f17a20803
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 14:04:44 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 14:04:42 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	<linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, <nh-open-source@amazon.com>,
	<linux-mm@kvack.org>, The AWS Nitro Enclaves Team
	<aws-nitro-enclaves-devel@amazon.com>
Subject: [PATCH] dma-contiguous: support percentage sizes in cma_pernuma= and numa_cma=
Date: Wed, 11 Nov 2026 14:04:40 +0000
Message-ID: <20261111140440.43024-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
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

While CMA_SIZE_PERCENTAGE supports percentages for built-in defaults, the
CMA allocation kernel parameters currently only take a fixed size argument.
That makes it difficult to have a single system image that sizes its CMA
allocation based on the available memory. To use CMA as backing pool for
large, physically contiguous guest memory, I want to be able to say
"allocate 90% of system RAM minus 1 GiB for CMA". Per NUMA node.

Extend the CMA parser logic to accept command line options like this:

  cma_pernuma=80%, numa_cma=0:95%-1G,1:4G

To avoid incomplete allocations on parsing errors, check for them
before actually allocating.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 .../admin-guide/kernel-parameters.txt         |  64 +++++-
 kernel/dma/contiguous.c                       | 184 +++++++++++++++---
 2 files changed, 217 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd94..1ca82f8c29f97 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -862,10 +862,13 @@ Kernel parameters
 			contiguous memory allocations and optionally the
 			placement constraint by the physical address range of
 			memory allocations. A value of 0 disables CMA
-			altogether. For more information, see
+			altogether. The size is absolute; the percentage form
+			is accepted by 'cma_pernuma=' and 'numa_cma=' only, and
+			CONFIG_CMA_SIZE_PERCENTAGE sizes this area as a fraction
+			of memory instead. For more information, see
 			kernel/dma/contiguous.c
 
-	cma_pernuma=nn[MG]
+	cma_pernuma=nn[MG]|nn%[-nn[MG]]
 			[KNL,CMA,EARLY]
 			Sets the size of kernel per-numa memory area for
 			contiguous memory allocations. A value of 0 disables
@@ -875,14 +878,61 @@ Kernel parameters
 			first try to allocate buffer from the pernuma area
 			which is located in node nid, if the allocation fails,
 			they will fallback to the global default memory area.
-
-	numa_cma=<node>:nn[MG][,<node>:nn[MG]]
+			The size may also be given as a percentage (nn%) of
+			each node's memory present at boot as seen by memblock;
+			hot-added memory is not counted. It is evaluated at
+			reservation time.
+			A percentage of 0 reserves nothing, like an absolute
+			size of 0. A value that does not parse, such as a
+			missing size, text after the value or a percentage
+			above 100, makes the whole parameter invalid: no node
+			takes a size from it, and
+			it does not fall back to mirroring the default area
+			onto every node either. An absolute size takes
+			priority over a percentage whichever order the two
+			were given in. A 'numa_cma=' on the same command line
+			still applies.
+
+			A percentage may be followed by a size to keep back
+			from it, so cma_pernuma=95%-1G reserves 95% of each
+			node less 1G. Keeping back at least as much as the
+			percentage came to reserves nothing on that node, and
+			warns as any other percentage resolving to nothing
+			does. The size kept back belongs to the percentage: a
+			later 'cma_pernuma=' percentage given without one
+			keeps nothing back.
+
+	numa_cma=<node>:nn[MG]|nn%[-nn[MG]][,<node>:nn[MG]|nn%[-nn[MG]]]
 			[KNL,CMA,EARLY]
 			Sets the size of kernel numa memory area for
 			contiguous memory allocations. It will reserve CMA
-			area for the specified node.
-
-			If it is setup together with upper 'cmd_pernuma='
+			area for the specified node. A per-node size may also
+			be given as a percentage (nn%) of that node's memory
+			present at boot as seen by memblock; hot-added memory
+			is not counted. It is evaluated at reservation time.
+			A size of 0, absolute or percentage, is the same as not
+			naming the node at all, so the node falls back to
+			'cma_pernuma=' when that is given. An entry that does
+			not parse, such as a node number of MAX_NUMNODES or
+			more, a missing size, text after a size or a
+			percentage above 100, makes the whole parameter
+			invalid: no node named
+			here gets an area, and there is no fall-back to
+			mirroring the default area onto every node either. A
+			'cma_pernuma=' on the same command line still applies.
+
+			A node may be named more than once. The last value of
+			each form is the one kept, and an absolute size takes
+			priority over a percentage for that node whichever
+			order the two were given in, so numa_cma=0:4G,0:50%
+			reserves 4G on node 0.
+
+			A percentage may be followed by a size to keep back
+			from it, per node, so numa_cma=0:95%-1G reserves 95%
+			of node 0 less 1G; see 'cma_pernuma=' above for what
+			keeping back more than the percentage came to does.
+
+			If it is set up together with upper 'cma_pernuma='
 			(unlikely), its size setting takes priority for the
 			specified numa nodes.
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627d..c04d50ee0f7c8 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -41,6 +41,7 @@
 
 #include <linux/memblock.h>
 #include <linux/err.h>
+#include <linux/math64.h>
 #include <linux/sizes.h>
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
@@ -135,45 +136,132 @@ EXPORT_SYMBOL_GPL(dev_get_cma_area);
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
 static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
 static phys_addr_t pernuma_size_bytes __initdata;
+static unsigned int numa_cma_pct[MAX_NUMNODES] __initdata;
+static unsigned int pernuma_pct __initdata;
+static phys_addr_t numa_cma_sub[MAX_NUMNODES] __initdata;
+static phys_addr_t pernuma_sub __initdata;
 static bool numa_cma_configured __initdata;
 
-static int __init early_numa_cma(char *p)
+/*
+ * What numa_cma_parse() does with a string it accepts: NUMA_CMA_CHECK leaves
+ * everything outside the function as it is, so a caller can validate the
+ * whole string before NUMA_CMA_APPLY lets any part of it take effect.
+ */
+enum numa_cma_action {
+	NUMA_CMA_CHECK,
+	NUMA_CMA_APPLY,
+};
+
+/*
+ * Parse one numa_cma= string: a comma separated list of <node>:<size>, where
+ * <size> is a size or <percent>%[-<size>]. Anything else fails the parse.
+ */
+static int __init numa_cma_parse(char *p, enum numa_cma_action action)
 {
 	int nid, count = 0;
 	unsigned long node;
-	phys_addr_t size;
-	char *s = p;
+	phys_addr_t size, sub;
+	char *s = p, *start;
 
 	while (*s) {
-		if (sscanf(s, "%lu%n", &node, &count) != 1)
-			break;
-
-		if (s[count] == ':') {
-			if (node >= MAX_NUMNODES)
-				break;
-			nid = array_index_nospec(node, MAX_NUMNODES);
-
-			s += count + 1;
-			size = memparse(s, &s);
+		if (sscanf(s, "%lu%n", &node, &count) != 1 || s[count] != ':' ||
+		    node >= MAX_NUMNODES)
+			return -EINVAL;
+		nid = array_index_nospec(node, MAX_NUMNODES);
+
+		start = s + count + 1;
+		size = memparse(start, &s);
+		if (s == start)
+			return -EINVAL;
+
+		if (*s == '%') {
+			s++;
+			if (size > 100) {
+				pr_warn("numa_cma: node %d percentage %llu%% > 100\n",
+					nid, (unsigned long long)size);
+				return -EINVAL;
+			}
+			sub = 0;
+			if (*s == '-') {
+				start = ++s;
+				sub = memparse(start, &s);
+				if (s == start)
+					return -EINVAL;
+			}
+			if (action == NUMA_CMA_APPLY) {
+				numa_cma_pct[nid] = size;
+				numa_cma_sub[nid] = sub;
+			}
+		} else if (action == NUMA_CMA_APPLY) {
 			numa_cma_size[nid] = size;
+		}
 
-			if (*s == ',')
-				s++;
-			else
-				break;
-		} else
-			break;
+		if (*s == ',')
+			s++;
+		else if (*s)
+			return -EINVAL;
 	}
 
-	numa_cma_configured = true;
 	return 0;
 }
+
+static int __init early_numa_cma(char *p)
+{
+	int rc;
+
+	/*
+	 * Per-node CMA is configured either way. Leaving the flag clear on a
+	 * string this rejects would tell dma_numa_cma_reserve() that nobody
+	 * asked for per-node areas, and on a CMA_SIZE_PERNUMA kernel it would
+	 * then clone the default area onto every node.
+	 */
+	numa_cma_configured = true;
+
+	rc = numa_cma_parse(p, NUMA_CMA_CHECK);
+	if (rc)
+		return rc;
+
+	return numa_cma_parse(p, NUMA_CMA_APPLY);
+}
 early_param("numa_cma", early_numa_cma);
 
 static int __init early_cma_pernuma(char *p)
 {
-	pernuma_size_bytes = memparse(p, &p);
+	phys_addr_t val, sub;
+	char *start;
+
+	/* See early_numa_cma(): a rejected string still counts as configured. */
 	numa_cma_configured = true;
+
+	start = p;
+	val = memparse(start, &p);
+	if (p == start)
+		return -EINVAL;
+
+	if (*p == '%') {
+		p++;
+		if (val > 100) {
+			pr_warn("cma_pernuma: percentage %llu%% > 100\n",
+				(unsigned long long)val);
+			return -EINVAL;
+		}
+		sub = 0;
+		if (*p == '-') {
+			start = ++p;
+			sub = memparse(start, &p);
+			if (p == start)
+				return -EINVAL;
+		}
+		if (*p)
+			return -EINVAL;
+		pernuma_pct = val;
+		pernuma_sub = sub;
+	} else {
+		if (*p)
+			return -EINVAL;
+		pernuma_size_bytes = val;
+	}
+
 	return 0;
 }
 early_param("cma_pernuma", early_cma_pernuma);
@@ -198,6 +286,33 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 #endif
 
 #ifdef CONFIG_DMA_NUMA_CMA
+static phys_addr_t __init numa_cma_node_size(int nid)
+{
+	unsigned long spfn, epfn;
+	phys_addr_t total = 0;
+	int i;
+
+	for_each_mem_pfn_range(i, nid, &spfn, &epfn, NULL)
+		total += (u64)(epfn - spfn) << PAGE_SHIFT;
+
+	return total;
+}
+
+/*
+ * A percentage of the node, less the size the boot line asked to keep back.
+ * Keeping back more than the percentage came to reserves nothing.
+ */
+static phys_addr_t __init numa_cma_pct_size(int nid, unsigned int pct,
+					    phys_addr_t sub)
+{
+	phys_addr_t size = mul_u64_u32_div(numa_cma_node_size(nid), pct, 100);
+
+	if (size <= sub)
+		return 0;
+
+	return size - sub;
+}
+
 static void __init dma_numa_cma_reserve(void)
 {
 	int nid;
@@ -214,16 +329,37 @@ static void __init dma_numa_cma_reserve(void)
 		int ret;
 
 		if (!node_online(nid)) {
-			if (pernuma_size_bytes || numa_cma_size[nid])
+			if (pernuma_size_bytes || pernuma_pct ||
+			    numa_cma_size[nid] || numa_cma_pct[nid])
 				pr_warn("invalid node %d specified\n", nid);
 			continue;
 		}
 
 		/* per-node numa setting has the priority */
-		size = numa_cma_size[nid] ?: pernuma_size_bytes;
-		if (!size)
+		if (numa_cma_size[nid])
+			size = numa_cma_size[nid];
+		else if (numa_cma_pct[nid])
+			size = numa_cma_pct_size(nid, numa_cma_pct[nid],
+						 numa_cma_sub[nid]);
+		else if (pernuma_size_bytes)
+			size = pernuma_size_bytes;
+		else if (pernuma_pct)
+			size = numa_cma_pct_size(nid, pernuma_pct, pernuma_sub);
+		else
 			continue;
 
+		/*
+		 * A percentage of a memoryless online node, and a percentage
+		 * entirely consumed by the size kept back, resolve to nothing
+		 * to reserve. Say so, since the operator asked for memory.
+		 */
+		if (!size) {
+			if (numa_cma_pct[nid] || pernuma_pct)
+				pr_warn("node %d percentage reserves nothing\n",
+					nid);
+			continue;
+		}
+
 		cma = &dma_contiguous_numa_area[nid];
 		snprintf(name, sizeof(name), "numa%d", nid);
 		ret = cma_declare_contiguous_nid(0, size, 0, 0, 0, false, name, cma, nid);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.1

