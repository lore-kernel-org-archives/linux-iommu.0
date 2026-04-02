Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705737CD46
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159980; cv=none; b=mJrdN5l1SabVC8ImknVVY/Rz9IH0CgQ3qIY4lRT5BPcDjQyMGfmWX0FiKzDXUatLDYvpAvEMTvEVJyfWqwz/ngP+0hREaUdlpLLLEZKEb2CRQOET/Yh2LygMoRJjNOJijTP3CJUfhHKhEaZxfsnBGjHX/ORZcqCzY8rpJ0Ck0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159980; c=relaxed/simple;
	bh=QTZbUUDXGaLy2IfDpckGo+fBj6OkjWhXIzFDDu2cejY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n4u4QPNfwCbSRY59AfcUZmYOXCbsCnkuKvsjUlCJKIrLqtCEc+XEWm0v2Wt1oLK2xmhnhle9bMLs7PuuVuKi6ROFU3FHEMsk9+jeb+F9wV2asJgIzN8RDcUdc1mXFEoquOcgxyNLKZqg+nQ2RR9WoILOZWgICNqyQbRg05W/EXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hVFSOQ8f; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hVFSOQ8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775159979; x=1806695979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qCxF4A/4lT3okZdMefpNiXUvO/imuEkeY/CxlVFdZqQ=;
  b=hVFSOQ8f4hd1Ix8+z7oFnm4AcoN5P+3gfuFs/lnUJMNZq7ZSrWkFf5Zo
   PUeBe7Pcd4LCq1GRj1eE0UJex5QtQl0NtpJO6UvVXePj7yokHrq3+RzrH
   GSVxXxBhuSXBUAwC9TLNlFPihRcethhhoPmmcq5TEcstYy7ww5kThQzsn
   ErWCgudkz1L96IcRF18wrXMXrJeK0ioKQIWf/8NLV8hgIB7cYuequziuK
   2hHyhCrfxmI36GnDgCIBNgqs/2uTWI5YDFJ7ETdzEmq9bRxu2FIgwL1H3
   RgMucMKILhcW3d3sl5MLG24Y9xdzWOZn2ut8/oYG39TU3ZQMOtJLjd7gb
   g==;
X-CSE-ConnectionGUID: VEmVeaObSIW073I4IdwCUw==
X-CSE-MsgGUID: 8hJ+VcpAQpuuXaFULy5vDQ==
X-IronPort-AV: E=Sophos;i="6.23,156,1770595200"; 
   d="scan'208";a="16429605"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 19:59:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:26166]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.176:2525] with esmtp (Farcaster)
 id 81b77452-05fd-4157-8bb7-618abb5421ac; Thu, 2 Apr 2026 19:59:38 +0000 (UTC)
X-Farcaster-Flow-ID: 81b77452-05fd-4157-8bb7-618abb5421ac
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 2 Apr 2026 19:59:38 +0000
Received: from dev-dsk-nafeabd-1d-abc270c9.us-east-1.amazon.com (10.39.200.51)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 2 Apr 2026 19:59:37 +0000
From: Nafees Ahmed Abdul <nafeabd@amazon.com>
To: <joro@8bytes.org>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Nafees Ahmed Abdul <nafeabd@amazon.com>
Subject: [RFC PATCH] iommu: Default to lazy DMA mode on ARM64
Date: Thu, 2 Apr 2026 19:59:13 +0000
Message-ID: <20260402195913.32084-1-nafeabd@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

ARM64 currently falls through to IOMMU_DEFAULT_DMA_STRICT, while
X86 defaults to IOMMU_DEFAULT_DMA_LAZY. On ARM64 bare-metal
systems with the ARM SMMU, strict mode causes synchronous TLBI
+ CMD_SYNC on every DMA unmap, resulting in significant
throughput degradation for network-intensive workloads.

Benchmarked on an ARM64 bare-metal system (AWS m8g.metal-24xl)
running Debian 13 with kernel 6.12.74, using iperf3:

  STRICT (default): 14.9 Gbps
  LAZY:             39.8 Gbps

This is a 2.67x throughput improvement simply by switching the
IOMMU default domain mode.

Distributions that do not explicitly override this Kconfig
choice (e.g., Debian, SLES) silently get STRICT on ARM64,
causing this regression on bare-metal systems. Changing the
upstream default avoids the need for each distribution to
independently carry this override.

Add ARM64 to the LAZY default to align with X86 behavior.

Signed-off-by: Nafees Ahmed Abdul <nafeabd@amazon.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f86262b11..2822aba75 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -96,7 +96,7 @@ config IOMMU_DEBUGFS
 choice
 	prompt "IOMMU default domain type"
 	depends on IOMMU_API
-	default IOMMU_DEFAULT_DMA_LAZY if X86 || S390
+	default IOMMU_DEFAULT_DMA_LAZY if X86 || S390 || ARM64
 	default IOMMU_DEFAULT_DMA_STRICT
 	help
 	  Choose the type of IOMMU domain used to manage DMA API usage by
-- 
2.47.3

