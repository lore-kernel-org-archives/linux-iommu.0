Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458635;
	b=HM3/1NhUcd7n6R0jJvxsKcftMdELWC4dF5dpdnCgY8sM7pT1CLH9+tBQNsmLr62CA9Lx
	 SPjnxwyZ7hV/wIvh7u8e5I+doU1edAj0bqvtE0VsWwus395F/rLy8x/iR//R/Up9rl46m
	 yNmDaz6iG/zrpAh/SfwvS4bz4idnMy+eGwjHpE/IplmZTncIXWywS8pxi2bNys4aZZaDe
	 BJt7Ztmreknz8HW+GxtqkiYZSXl1/6SeBoCQ6n7EvNAy9OHU3ZF5Agb4AYH06LqhJJTXk
	 j42NfUlI0iS9G5jun+Zqvhgf2ECeRx2Kx+IvbvQGFZYCrq4IYK9T1O5B7npXKZUx35A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458635;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OoHMoMToIprNUXVBdA2mO+/FOcNrc2DuZ0JLihC2jkM=;
	b=reSg4t+mf+myQ/gNu33gvHZeszMEffQPGJku5ebuZPD2tcgs1oetpp0HxnX6irK6swEa
	 BAod+KCftetkVU4DqQwf8yR5yBN+zaSWNozMdieDsJcsQSxaHhTTH27zJA3NHeDtDt/h5
	 zbv4pvXoS6L95APG/MOSSoO5gcd328wH1VIkFxOp1kyfkdhGKKFSGvlbmHSggIfUSM0Nu
	 JpWVEJlI+FZ9/kORXLFRC7NRsqOJfHhQfde/eJRYaf3uwI4JpjF3w6OMDzeriM50Zji2C
	 PgA7yc6Wj3mbTceIFYe2ajpxsWypSWVMkaa4rRtBhWO4uhOeQ7xHoC7DwdrmIkP8WnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DZXfL7Os;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F42606A890;
	Thu, 12 Nov 2026 04:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F42606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DZXfL7Os
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458634; x=1825994634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCWt7wIqylSLc7vcyqZ/asKX+Bzo7aUx/mqcDdFe6k8=;
  b=DZXfL7OsUjCnf4wgVxEpfh97+ssssmAQgSeCG9sIMMy4axZHEudULaiL
   S6P+1Uow+z9qpymXlo4Pm+UhXT2Ttfqv0HqLmmRpBK9AMKNZ6qyqajmcY
   oqQGdmiprUblwnUiFY62UPm4Um5sb2h/EOvXbbu6gyhOnajP7nYFQKYJU
   IQP9ufsV/YDOJW9ncMxJP2Z86VW+OB8bZ6c6eeo4NtTS6qq8nUuySutIX
   vyT1NdmsxqVPogI9DEqWOrSGoYl2cTM1xhhLPfhFJQ1i5Aepk6EWTAM71
   +iJcqjisBMCAUW6WsETgImRn2/uaIoGBDBCY7SIfsjTHlmMJu/Q5EyeGk
   Q==;
X-CSE-ConnectionGUID: hOpe8L2wQgS8XGyA7jEcaQ==
X-CSE-MsgGUID: zseH2qNNTCS7JP2dvDB6qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318327"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318327"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:43:54 -0800
X-CSE-ConnectionGUID: GeU2LoC1Suadvhir2Oz7jA==
X-CSE-MsgGUID: PXJA8cVyRXaN9Y52OwJwDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728625"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:43:51 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 2/9] x86/virt/tdx: Read global metadata for trusted IOMMU
Date: Thu, 12 Nov 2026 12:30:47 +0800
Message-ID: <20261112043054.2664857-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
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

Add support for reading the global metadata of the trusted IOMMU.

The trusted IOMMU feature is optionally enumerated via TDX_FEATURES0.
Check this feature bit before reading the metadata to avoid causing
the entire TDX initialization to fail on platforms that do not support
it.

The read value represents the number of pages required for the IOMMU
metadata. The host will allocate this count of pages and provide them to
the TDX module when it configures the IOMMU to operate in Secure TDX mode
via the TDH.IOMMU.SETUP SEAMCALL.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h                  |  1 +
 arch/x86/include/asm/tdx_global_metadata.h  |  5 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 20 ++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d077990802b9..0ed0062c9b0a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -35,6 +35,7 @@
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
+#define TDX_FEATURES0_TDXCONNECT	BIT_ULL(6)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_DYNAMIC_PAMT	BIT_ULL(36)
 #define TDX_FEATURES0_EXT		BIT_ULL(39)
diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index f18e63b671c2..e5e54159ad36 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -51,12 +51,17 @@ struct tdx_sys_info_ext {
 	u32 required_pages;
 };
 
+struct tdx_sys_info_connect {
+	u16 iommu_mt_page_count;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
 	struct tdx_sys_info_tdmr tdmr;
 	struct tdx_sys_info_td_ctrl td_ctrl;
 	struct tdx_sys_info_td_conf td_conf;
+	struct tdx_sys_info_connect tdx_connect;
 };
 
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 9ab4d021017f..9b46f34cb469 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -139,6 +139,20 @@ static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
 	return 0;
 }
 
+static __init int get_tdx_sys_info_connect(struct tdx_sys_info_connect *sysinfo_connect)
+{
+	int ret;
+	u64 val;
+
+	ret = read_sys_metadata_field(0x3000000100000003, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_connect->iommu_mt_page_count = val;
+
+	return 0;
+}
+
 static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
@@ -164,5 +178,11 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
 		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
 
+	if (ret)
+		return ret;
+
+	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT)
+		ret = get_tdx_sys_info_connect(&sysinfo->tdx_connect);
+
 	return ret;
 }
-- 
2.43.0

