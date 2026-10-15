Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB1221DAE;
	Thu, 15 Oct 2026 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027187; cv=none; b=fk4DhSlWsNo4+1CBDC1QpRv0PDZ4maxJ/jGOZwTxZ82lTyhvT9SjjVo1Nu1YO+Su6f2vBoMgkh6iXPLSwcW+r1fD4NSOUtaZa2gH0G8ZCpt2AzBbpp1cXilNAOOhY743jPeeyPrpE6Ztlhe5FsX9Qov5POwvpLk4KtDbaLtQQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027187; c=relaxed/simple;
	bh=UrHuveI+e0uuCVIlwFassgBSxGnbJueh/TpliWJshug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFOD4UPZylJtuvWw1hCVS1DNymvZ0BsyqKyz97F2qFipbVDcWy0YiTEEXMRu0wtxOvZWd7pXRca8x9EYOgu1R7++l0RyZ+ZODFHss36iBiF43xTfWVi7huKVwrrRbVg/ubV9tltlV2wFh2lD8rpOlX9W1+KxQgNQf4/H4mAJNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGPDKLwl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGPDKLwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792027187; x=1823563187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UrHuveI+e0uuCVIlwFassgBSxGnbJueh/TpliWJshug=;
  b=YGPDKLwlsM3a+9t3UX7x1DrYNXUgK1fo1si8Ld+1evbdp8TZC3fWgXiP
   jftwCC+QDALa7F26yRVHnVnWSJVZYqs5yrBbc8vS5f+/TP0MV3abM5h1i
   bXAVf59TfMvihZaRt1MYAUVB5oxHVNz7wv2CKrQj92ZV6l3+xHqDgHs5I
   /O+EiJxBUXWz0/3G4KwlMu9YISFyfsp3klHZisQiROYvZGCmc9kAU2oDR
   BBYvEeh19rP5DMzsw1lML203Pb6JNI18Odtn6YAQtjj2f7Af34JpIrolm
   q1DMukie61l3ibHgNwN6CI00DlKL4iW6LlZrLZa+pGlXFqVuc5H4+39JJ
   A==;
X-CSE-ConnectionGUID: MDDFi5JIStuwhlsrAuGYBg==
X-CSE-MsgGUID: U/Dku+oOSVu7jp+y1iPytg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="789211"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="789211"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 18:19:47 -0700
X-CSE-ConnectionGUID: b6lac+p4QUewDjqWRmKBJw==
X-CSE-MsgGUID: A7lOPiGVRX2YiT6ii6Jj4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1595572"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2026 18:19:42 -0700
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
Subject: [PATCH v2 2/4] x86/virt/tdx: Read global metadata for trusted IOMMU
Date: Thu, 15 Oct 2026 09:07:03 +0800
Message-ID: <20261015010705.1973284-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
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

Thanks to Xu Yilun for the initial draft.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h                  |  1 +
 arch/x86/include/asm/tdx_global_metadata.h  |  5 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 20 ++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8b5411d3eb67..9c9168822274 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -35,6 +35,7 @@
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
+#define TDX_FEATURES0_TDXCONNECT	BIT_ULL(6)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 
 #ifndef __ASSEMBLER__
diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 41150d546589..cf64452fe94f 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -44,12 +44,17 @@ struct tdx_sys_info_handoff {
 	u16 module_hv;
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
index e49c300f23d4..2ba1c5dcdbe6 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -113,6 +113,20 @@ static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff
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
@@ -129,5 +143,11 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 
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

