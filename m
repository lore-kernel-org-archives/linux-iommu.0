Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21019BDA
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369252; x=1718905252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93F5iXdL1aFe8xiqIFZhy89J/IUrk/GxSpjv1QQ9jI0=;
  b=cbsU1tQqtOzbvjAjSnDYH37u3zK+xQrPplIQOJUoqnzf8xX6yFNUUgV+
   u7LDU0EpqNTbpkJii8FmeQbNnOd5G8CS24eNm+UqjXA/w1EsBX9mRFyNZ
   QkCSPCYcZuVe+oMh+73vouXmz5n80XpEmw3D2Rf9WL9yIV0YA56EYDNlj
   GjN/jnJxQ0NnhK1G4fyWzXQM4VKVdEa8/3dmjB3YS9x+mvluKWMizDiAF
   IffQgv55WBgRV+9La1D/TquV165FdMkvC6tibei+Ircbc6WDRqpV3MLt1
   /sJmhRAx7wbVQyvXDuUdwOTrJ03yEkcmbhEfMgfcO+JPTMbw9mrenK6GX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359120684"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359120684"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="717746145"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="717746145"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2023 10:40:36 -0700
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	steve.wahl@hpe.com,
	mike.travis@hpe.com,
	dimitri.sivanich@hpe.com,
	russ.anderson@hpe.com,
	dvhart@infradead.org,
	andy@infradead.org,
	joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	peterz@infradead.org,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	xin3.li@intel.com,
	seanjc@google.com,
	jiangshanlai@gmail.com,
	jgg@ziepe.ca,
	yangtiezhu@loongson.cn
Subject: [PATCH v2 3/3] tools: Get rid of IRQ_MOVE_CLEANUP_VECTOR from tools
Date: Wed, 21 Jun 2023 10:12:48 -0700
Message-Id: <20230621171248.6805-4-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621171248.6805-1-xin3.li@intel.com>
References: <20230621171248.6805-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of IRQ_MOVE_CLEANUP_VECTOR from tools.

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 tools/arch/x86/include/asm/irq_vectors.h               | 7 -------
 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
index 43dcb9284208..3a19904c2db6 100644
--- a/tools/arch/x86/include/asm/irq_vectors.h
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -35,13 +35,6 @@
  */
 #define FIRST_EXTERNAL_VECTOR		0x20
 
-/*
- * Reserve the lowest usable vector (and hence lowest priority)  0x20 for
- * triggering cleanup after irq migration. 0x21-0x2f will still be used
- * for device interrupts.
- */
-#define IRQ_MOVE_CLEANUP_VECTOR		FIRST_EXTERNAL_VECTOR
-
 #define IA32_SYSCALL_VECTOR		0x80
 
 /*
diff --git a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
index eed9ce0fcbe6..87dc68c7de0c 100755
--- a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
+++ b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
@@ -12,7 +12,7 @@ x86_irq_vectors=${arch_x86_header_dir}/irq_vectors.h
 
 # FIRST_EXTERNAL_VECTOR is not that useful, find what is its number
 # and then replace whatever is using it and that is useful, which at
-# the time of writing of this script was: IRQ_MOVE_CLEANUP_VECTOR.
+# the time of writing of this script was: 0x20.
 
 first_external_regex='^#define[[:space:]]+FIRST_EXTERNAL_VECTOR[[:space:]]+(0x[[:xdigit:]]+)$'
 first_external_vector=$(grep -E ${first_external_regex} ${x86_irq_vectors} | sed -r "s/${first_external_regex}/\1/g")
-- 
2.34.1

