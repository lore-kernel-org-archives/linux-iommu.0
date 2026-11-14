Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668017;
	b=wd53pXv9IpnWeWNXSmGyjKmjt41aikd5Vz5t7bBs0/GdF6mjmhjZ3s0IqR0dBT1C2z+b
	 QO3glLOH1NvAnKdm7p/nNnD9oxgkk4UYQPL5vduJmCdqytzSa8WKSd4idkneg+XxFb3am
	 G1uOJjnSWqYNwRQAxeOplRhfdulV704YHbnzAsgx/LYnO8YhyW2DuaC4ROqKP7IljPmGD
	 +j6weFSdhUbeHBVXIW5aaPMjr/jVaA6dXEZwkcYqmnJtPTequjo9GGYDNfEIRSZUtb7ZL
	 yNqbW1cjkkCC5HY8GBdAqj6SC/7xOD/h0fFtpRlFlgB1xKyoNxYApf9O3GE+iCk7KLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668017;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=DUkCkLrBCsDmb/zGP0NU7kzHyOa32ewTN2QVFQyAKM8=;
	b=1cbbeIzA5g1qJo0J2EnC6IpSHiM7sNLPL1Gs5oLXt/MAW/LSqk3Ua6R/BJVR+GeOOLNZ
	 K/RxY+SFBsDlHncjiF/XIm3+go7N5HQzdT0OXPk+w42aNwpFeb57BxbvDrgKw3NNnqx31
	 xQqwojcLyjxhkjQdUwtzVAFefQLTc9CmtWCq2MlB3yahoQB2T/i5NAre6tTO/eMAjlC8K
	 fMY28aeFw7VUtvGJAnKSZFs4ZOABMMSpn93/TIbcRt62QMtdsYLr2N0fTcaPkrGRSySDC
	 wXAuyg6AacghHC72eJH6AEdG+rrFi98jMjpQq9PNuFhh4ofCTUKzbCimxr0ub13XIWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=hVRjM5Vj;
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C24606A329
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 14:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24C24606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=hVRjM5Vj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794668016; x=1826204016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DUkCkLrBCsDmb/zGP0NU7kzHyOa32ewTN2QVFQyAKM8=;
  b=hVRjM5VjmvXZnmvZ+BSRdrXNgzUsavkiAEbFa7/dVuNYYw1glZIlK4rG
   QFwPl3W/Fmuqa4Se+b1Wh/m+Nby9oyBGvDOrR5nFAXJIAVDIYBGutMlRB
   IB22aZpLgf4wSunDrCqOuZz7kUpAR/e3jtUmStuV0kSfBJCt+nNdiE6cT
   K1yKCOOkJfhDpzvVGMnCxq+Qs0P6OydSi+VLeFGa9g7PF++VT0zySWYDZ
   G0Mg+oqpptbwO3F0ipWlu7KZ5Mzmj3nfE/HRwDOYgCgoyqT74qy39td39
   JMJRVB/GJHDy1M51o356/O7GEUWdN0as340pI/7WeW+SOHoSseTPmXTxT
   Q==;
X-CSE-ConnectionGUID: aXgLchuGQbWRwMiJ4x8l6A==
X-CSE-MsgGUID: WWPIB+CaTTa+sG9gJDBplg==
X-IronPort-AV: E=Sophos;i="6.27,213,1787011200"; 
   d="scan'208";a="33813177"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 14:53:33 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:9277]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.250:2525] with esmtp (Farcaster)
 id 77f70d93-d9c9-4764-8233-67658989107b; Sat, 14 Nov 2026 14:53:33 +0000 (UTC)
X-Farcaster-Flow-ID: 77f70d93-d9c9-4764-8233-67658989107b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 14 Nov 2026 14:53:32 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 14 Nov 2026 14:53:30 +0000
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
Subject: [PATCH v2] dma-contiguous: support percentage sizes in cma_pernuma= and numa_cma=
Date: Sat, 14 Nov 2026 14:53:28 +0000
Message-ID: <20261114145328.1307-1-graf@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

While CMA_SIZE_PERCENTAGE supports percentages for built-in defaults, the
CMA allocation kernel parameters currently only take a fixed size argument.
That makes it difficult to have a single system image that sizes its CMA
allocation based on the available memory. To use CMA as backing pool for
large, physically contiguous guest memory, I want to be able to say
"allocate 90% of system RAM minus 1 GiB for CMA". Per NUMA node.

Extend the CMA parser logic to accept command line options like this:

  cma_pernuma=80% numa_cma=0:95%-1G,1:4G

To avoid incomplete allocations on parsing errors, check for them
before actually allocating.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
v1 -> v2:

  - Reject an empty numa_cma= and a trailing comma (Sashiko)
  - Keep the last valid size for each option or node, so an explicit 0
    now overrides a percentage (Sashiko)
  - Parse percentages as plain decimal, and reject sizes that a 32-bit
    phys_addr_t cannot hold
  - Reject a bare cma_pernuma or numa_cma without "=", which mainline
    dereferences as NULL
  - Rework the kernel-parameters.txt text accordingly

v1: https://lore.kernel.org/all/20261111140440.43024-1-graf@amazon.com/

---
 .../admin-guide/kernel-parameters.txt         |  37 +++-
 kernel/dma/contiguous.c                       | 188 +++++++++++++++---
 2 files changed, 194 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd94..d132b14ba4f73 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -862,10 +862,13 @@ Kernel parameters
 			contiguous memory allocations and optionally the
 			placement constraint by the physical address range of
 			memory allocations. A value of 0 disables CMA
-			altogether. For more information, see
+			altogether. The size is absolute; only 'cma_pernuma='
+			and 'numa_cma=' accept a percentage. Without 'cma=',
+			CONFIG_CMA_SIZE_PERCENTAGE can size this area as a
+			fraction of memory. For more information, see
 			kernel/dma/contiguous.c
 
-	cma_pernuma=nn[MG]
+	cma_pernuma=nn[MG]|nn%[-nn[MG]]
 			[KNL,CMA,EARLY]
 			Sets the size of kernel per-numa memory area for
 			contiguous memory allocations. A value of 0 disables
@@ -875,14 +878,34 @@ Kernel parameters
 			first try to allocate buffer from the pernuma area
 			which is located in node nid, if the allocation fails,
 			they will fallback to the global default memory area.
-
-	numa_cma=<node>:nn[MG][,<node>:nn[MG]]
+			The size may also be a decimal percentage of each
+			node's memory as memblock sees it at boot, optionally
+			less a size to keep back, so cma_pernuma=95%-1G
+			reserves 95% of each node minus 1G. Hot-added memory is
+			not counted. A nonzero percentage that leaves nothing
+			to reserve on a node warns and reserves nothing there.
+			If the option is given more than once, the last valid
+			value counts. An invalid value is ignored, and it still
+			stops CONFIG_CMA_SIZE_PERNUMA from mirroring the
+			default area onto every node.
+
+	numa_cma=<node>:nn[MG]|nn%[-nn[MG]][,<node>:nn[MG]|nn%[-nn[MG]]]
 			[KNL,CMA,EARLY]
 			Sets the size of kernel numa memory area for
 			contiguous memory allocations. It will reserve CMA
-			area for the specified node.
-
-			If it is setup together with upper 'cmd_pernuma='
+			area for the specified node. A size may also be a
+			percentage of that node's memory, optionally less a
+			size to keep back, as for 'cma_pernuma='. A size of 0
+			or 0% is the same as not naming the node, so it falls
+			back to 'cma_pernuma='. A nonzero percentage that
+			leaves nothing to reserve does not fall back. If a node
+			is named more than once, also across several numa_cma=
+			options, the last valid size counts. An entry that does
+			not parse, including an empty list or a trailing comma,
+			makes the kernel ignore that whole option, and the
+			default area is not mirrored either.
+
+			If it is set up together with upper 'cma_pernuma='
 			(unlikely), its size setting takes priority for the
 			specified numa nodes.
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627d..ea094d2238136 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -39,8 +39,10 @@
 
 #include <asm/page.h>
 
+#include <linux/ctype.h>
 #include <linux/memblock.h>
 #include <linux/err.h>
+#include <linux/math64.h>
 #include <linux/sizes.h>
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
@@ -135,45 +137,135 @@ EXPORT_SYMBOL_GPL(dev_get_cma_area);
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
+ * Parse one CMA size, either a size or <percent>%[-<size>], and advance *s past
+ * it. A percentage is a plain decimal number up to 100. Exactly one of *size and
+ * *pct describes the result, so the last size given replaces any earlier one.
+ */
+static int __init numa_cma_parse_size(char **s, phys_addr_t *size,
+				      unsigned int *pct, phys_addr_t *sub)
+{
+	unsigned long long val;
+	unsigned int n;
+	char *start = *s;
+	int count;
+
+	if (isdigit(*start) && sscanf(start, "%3u%n", &n, &count) == 1 &&
+	    start[count] == '%') {
+		if (n > 100)
+			return -EINVAL;
+		*s = start + count + 1;
+		val = 0;
+		if (**s == '-') {
+			start = ++*s;
+			val = memparse(start, s);
+			if (*s == start || val != (phys_addr_t)val)
+				return -EINVAL;
+		}
+		*size = 0;
+		*pct = n;
+		*sub = val;
+		return 0;
+	}
+
+	val = memparse(start, s);
+	if (*s == start || val != (phys_addr_t)val)
+		return -EINVAL;
+	*size = val;
+	*pct = 0;
+	*sub = 0;
+	return 0;
+}
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
+	phys_addr_t size, sub;
+	unsigned int pct;
 	char *s = p;
 
-	while (*s) {
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
+	for (;;) {
+		if (!isdigit(*s) ||
+		    sscanf(s, "%4lu%n", &node, &count) != 1 || s[count] != ':' ||
+		    node >= MAX_NUMNODES)
+			return -EINVAL;
+		nid = array_index_nospec(node, MAX_NUMNODES);
+
+		s += count + 1;
+		if (numa_cma_parse_size(&s, &size, &pct, &sub))
+			return -EINVAL;
+		if (action == NUMA_CMA_APPLY) {
 			numa_cma_size[nid] = size;
+			numa_cma_pct[nid] = pct;
+			numa_cma_sub[nid] = sub;
+		}
 
-			if (*s == ',')
-				s++;
-			else
-				break;
-		} else
-			break;
+		if (!*s)
+			return 0;
+		if (*s != ',')
+			return -EINVAL;
+		s++;
 	}
+}
 
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
 	numa_cma_configured = true;
-	return 0;
+
+	if (!p)
+		return -EINVAL;
+
+	rc = numa_cma_parse(p, NUMA_CMA_CHECK);
+	if (rc)
+		return rc;
+
+	return numa_cma_parse(p, NUMA_CMA_APPLY);
 }
 early_param("numa_cma", early_numa_cma);
 
 static int __init early_cma_pernuma(char *p)
 {
-	pernuma_size_bytes = memparse(p, &p);
+	phys_addr_t size, sub;
+	unsigned int pct;
+
+	/* See early_numa_cma(): a rejected string still counts as configured. */
 	numa_cma_configured = true;
+
+	if (!p || numa_cma_parse_size(&p, &size, &pct, &sub) || *p)
+		return -EINVAL;
+
+	pernuma_size_bytes = size;
+	pernuma_pct = pct;
+	pernuma_sub = sub;
 	return 0;
 }
 early_param("cma_pernuma", early_cma_pernuma);
@@ -198,6 +290,33 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
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
@@ -214,15 +333,36 @@ static void __init dma_numa_cma_reserve(void)
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
+			continue;
+
+		/*
+		 * A percentage of a memoryless online node, and a percentage
+		 * entirely consumed by the size kept back, resolve to nothing
+		 * to reserve. Say so, since the operator asked for memory.
+		 */
+		if (!size) {
+			if (numa_cma_pct[nid] || pernuma_pct)
+				pr_warn("node %d percentage reserves nothing\n",
+					nid);
 			continue;
+		}
 
 		cma = &dma_contiguous_numa_area[nid];
 		snprintf(name, sizeof(name), "numa%d", nid);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.1

