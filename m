Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C86419302
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811727; cv=none; b=rxXz727xrBkjhm7DjjVBdYxuQiDM32A6h2c56xU9/794xE+LLMiKeutFvejC7JjVb5Qau7Klfo+NFQPqPRECp324/J51Qiic+fh7ZZq6ZkppEe+HAU/5pdFkveDi6D2gMQQUfKy5rpnBtIfwVtxiEtjF76lh+glx4vZZkPEOaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811727; c=relaxed/simple;
	bh=8FoqMs3ZYEeu3bLuLfkxhhxNSLw1by1xUZ5wqDUZOY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A80yA+MDO40WGglfqXNMusGjngcmhthOnRqUSS8gsowohoSVVGjNVe74W6FaN2h9X1EUQwZugPUayHKWIJAT76YPBXJA7OIMQdLxsb8j6Y/Aj6YX6SVPrBc5qgS3wzlGy2ztcM4umkq4SoxbJSfD4AqNaFej3Swwfg9CodjHfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kpm/4f0a; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kpm/4f0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811726; x=1817347726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8FoqMs3ZYEeu3bLuLfkxhhxNSLw1by1xUZ5wqDUZOY4=;
  b=Kpm/4f0aP9g4frC2uSB0Vn0sqVqQDz470huWptb6W8LTQ85SqsnFvC7q
   tarpvVXFaDagXzQ93DAaaHZX48rZtpYR86sN2+ZoonlsYJQ9mhPOLTeRZ
   O6mENm5bSBDaCeZYat5DP+qNhE799nOA9sP+iz3bX55gr6XbJGbA915Wr
   rtbn/gluKhy7K3J7fv6s9CKr80gxpOLaIsMJopaUOgDmkdF5Gvx/Zarn7
   zbZo+FcgYkHjoOoYwr523tA7lLri9Zhj7MtRemzY4PXN9UP7oHt71oc/s
   GruqagUdug4uK3Ge5WG6k3eD+ct2YkUfaLnhON+jmI8a8DNePZYR81Ihe
   A==;
X-CSE-ConnectionGUID: Aqz49xt2TDKjPEad7+qgjA==
X-CSE-MsgGUID: WQ9k9RD1SKmXpDVYlOqXZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231300"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231300"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:45 -0700
X-CSE-ConnectionGUID: KXHweeTHS+OSrL9TjCG9pg==
X-CSE-MsgGUID: sic2wBSwSOGiDNKZUNeJiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587527"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] iommu/vt-d: Call dmar_can_force_on() for tboot opt-in
Date: Tue,  4 Aug 2026 10:37:04 +0800
Message-ID: <20260804023714.3080506-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Tian <kevin.tian@intel.com>

So the policy of requesting ACS in detect_intel_iommu() is consistent
with that in tboot_force_iommu().

Though tboot is the strongest override so far, dmar_can_force_on() may
return false due to future extensions. In this case panic the kernel,
as is already done when failing to initialize DMA remapping for tboot.

No functional impact at this point.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ce0794e82e55..5eb80aeec274 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2550,12 +2550,17 @@ static int __init probe_acpi_namespace_devices(void)
 
 static __init int tboot_force_iommu(void)
 {
-	if (!tboot_enabled())
+	if (!tboot_enabled() || intel_iommu_tboot_noforce)
 		return 0;
 
-	if (no_iommu || dmar_disabled)
+	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
+		panic("tboot: Failed to force IOMMU on\n");
+
+	if (dmar_policy_off())
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
+	/* No concurrent access to dmar_policy at this point. */
+	dmar_policy = DMAR_FORCE_ON;
 	dmar_disabled = 0;
 	no_iommu = 0;
 
@@ -2572,8 +2577,7 @@ int __init intel_iommu_init(void)
 	 * Intel IOMMU is required for a TXT/tboot launch or platform
 	 * opt in, so enforce that.
 	 */
-	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
-		    platform_optin_force_iommu();
+	force_on = tboot_force_iommu() || platform_optin_force_iommu();
 
 	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
-- 
2.43.0

