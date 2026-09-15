Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F363D47C8;
	Tue, 15 Sep 2026 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458893; cv=none; b=PZ/ymEVO3KBD+C1ABxz9KrYFUWvKvibtPPnvcrqTsbpJhA4j42Pqci0bNQsbltCA4Lvfk94SdURnTJa7i7/BZvRRWCBY4dZ1d8ijN1ysR7ldAHWEN5OH+0IFr7naCfe44LxmO74Y/HQT1XecDT+R5e6Q/RHl6WQdye/fhFW8kQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458893; c=relaxed/simple;
	bh=+bSLvKPFfE0mWTsplOyHsQdZLyGLAZQBE/ezrAvUeGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JK7O4BxJGMeE3xJ7VYFxBkbdYhM8w9V8GQokAqNqu3ZaHPxxLGOKR3K7aE5Zbz921Pt95pMxDxdLY4rMgZUh+zsal6P0prPQHNn9lPFcitXw9wEjEWplHhsPN54xkDUFhovUQUED7vTDcETeDiC+XHNY6WcIDMeRvy+GK+1nvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cqf6NNUP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cqf6NNUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458891; x=1820994891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+bSLvKPFfE0mWTsplOyHsQdZLyGLAZQBE/ezrAvUeGI=;
  b=Cqf6NNUPRYJZ6M471Uu3BW0Kh0b7clrHHnpuvccV/Xy4X77yypxc9gK9
   oUjyRw+Vb080Ec1botf4NXAu12fxCz3f2SdBY4LqItEEIFGuaBFSxgGxj
   ny4aLSZ7+/NdrFDuW2W+DsFfToBDyM3Q+vD0zb+ri2x4fHVLL2iTpEwME
   oCbDEdjuuUxP8cZmrJt62U1YvFWYMaMEd0bEnGAvVH6rJ/cGqa212hBVV
   rrcMXotrME6IdlXt4CH/DUxo+qhDllpi6dIOPJhfkMKKTK88QYtJaysNf
   k3HaMZ0dXIZS4G7GSZGEeUXswWUwLpDUzwrE+IPrtUqKQOozz21JW3x3b
   Q==;
X-CSE-ConnectionGUID: Zylsh9OZQ7ScHoUXjRv3Vw==
X-CSE-MsgGUID: Vmy8qmkDTNy81Ix/aku+Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101163787"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101163787"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:54:50 -0700
X-CSE-ConnectionGUID: 8ltm7kAIT6eJpRZZZEvS+A==
X-CSE-MsgGUID: QAUsvPj6QkyJZtF7MPCZVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269205446"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2026 00:54:46 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/5] x86/virt/tdx: Read global metadata for trusted IOMMU
Date: Tue, 15 Sep 2026 15:42:30 +0800
Message-ID: <20260915074235.1219183-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
References: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
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

Thanks to Yilun for the initial draft.

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

