Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458638;
	b=U4kOJWpQB94k8p8cV9xreXmJxUiLzkr545nJkyKbn5KbZKsPsR9WTmR4qKs6f85XFvAR
	 xyv7bXOhzm/DaIeduPTHCvNOm848hcH+i89yFR2bfl0x6RCkao406j7OGhTPtgZYL35sw
	 rLQa6NXgm3yhAcv43BIpIhD8mU6vtMG2V7k9Bc3miIDAoCLuvuy+pVe4DzrHrSZP6aH+B
	 RzO8QeAQr0V8LaMp4BM1/ib7euNwgagqgC38wyum3OsHM7uvHg6DM5/anfBNsvlVwvBO1
	 htJ1cpz/tWvVTcX0iUo1RYTcKcS8Z2eiHoAiCS6wEPaEC6rouV38fPSXLYIXGZynO8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458638;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gk4J3PRpXVbZG/2lFq7fiUjf5VSexltmx6rvP44K9sA=;
	b=nkoaIIekaAxFP/5WW/v9UeXebaYm0mdLEEpzmyUbytBeAvIi2nJz4tWx9l6i2C7Vp0LU
	 FVt5FD02Bce8MyZodnZZgqvV27iyYPNV8VmCrxXXb1ThWhifhCo+1QTRd699rPy782Yzd
	 mFzhEI+CWlRythUVMmRoxUtdQdguY6sfFMhv2h0HHJOT+9qfP0ftxAEK0wYLQat8rbj32
	 W+kikZVtdeNeoCiuIu/F4urT3HtJXLVFfUmV8oK8glluMVcbAT2sBFTq4jd8qvL0MpVje
	 vUviSV9MK3rtZqsvOioKQoW2uJKsS42K7y+iCsd//nKG3j9Ap8uwmGg+jdCouFfYEaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LyGdR2sC;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C3606A8B7;
	Thu, 12 Nov 2026 04:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 599C3606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LyGdR2sC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458638; x=1825994638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/2u0wGr7E5y5ntq8rOUm26jo3YlOd8PNzJksxhIC7U=;
  b=LyGdR2sCXUzrivlFEgZTRZScsabt1ngwNeTiJUNES2Y46gE4sY2qRbJt
   LW9rDEJN9nSYjtqP2wu23M1s1SHbptVwK0mDZ+X/Mjoyh7Ts5KYLLHobz
   LTvKCJ/Ide5HX2Y12q/ZhC/v6ntHBkhllrD0NKjnCnKScbxn7nBnkXcgT
   Zf1jCpVbFjUod+11ue5hB05L31ZQcie8UXxgCyrwtsLVCJYuWLlayKb8k
   yUC8ictuSsq32WEeYmAejt0oeZBVmfRemALBoQPW2qOE40NYFxhTu8+oC
   XEPKcR+E+Yfqzb/kWkuf1sA9U6AICvFi3BJqy7ANb7+dB7iaQmEqoxRNm
   w==;
X-CSE-ConnectionGUID: g3maN806TSWrYORligLA3Q==
X-CSE-MsgGUID: IKH/NMLaRK2k/6o74g4QhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318336"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318336"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:43:58 -0800
X-CSE-ConnectionGUID: cSPp3ndbQPe5ZhGNw3dc/g==
X-CSE-MsgGUID: VtYE1s2XQGCzWcVo8aTUpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728628"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:43:54 -0800
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
Subject: [PATCH v3 3/9] x86/virt/tdx: Export Dynamic PAMT helpers to tdx-host
Date: Thu, 12 Nov 2026 12:30:48 +0800
Message-ID: <20261112043054.2664857-4-baolu.lu@linux.intel.com>
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

With Dynamic PAMT, any page handed to the TDX module needs PAMT backing
first, via tdx_pamt_get(), and must drop it with tdx_pamt_put() once the
TDX module gives the page back. Besides KVM, the tdx-host driver now
hands pages to the TDX module: the IOMMU_MT pages for TDH.IOMMU.SETUP.

Export the two helpers to tdx-host as well. A symbol can only be
exported once, so replace EXPORT_SYMBOL_FOR_KVM() with an explicit list.
Only kvm-intel calls these helpers in KVM.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a1f35188a272..3b9cfab6cf68 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2426,7 +2426,7 @@ int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache)
 
 	return ret;
 }
-EXPORT_SYMBOL_FOR_KVM(tdx_pamt_get);
+EXPORT_SYMBOL_FOR_MODULES(tdx_pamt_get, "kvm-intel,tdx-host");
 
 /* Drop DPAMT refcount for the given pfn and free DPAMT backing if needed. */
 void tdx_pamt_put(kvm_pfn_t pfn)
@@ -2470,7 +2470,7 @@ void tdx_pamt_put(kvm_pfn_t pfn)
 out_unlock:
 	spin_unlock(&dpamt_lock);
 }
-EXPORT_SYMBOL_FOR_KVM(tdx_pamt_put);
+EXPORT_SYMBOL_FOR_MODULES(tdx_pamt_put, "kvm-intel,tdx-host");
 
 void tdx_free_pamt_cache(struct tdx_pamt_cache *cache)
 {
-- 
2.43.0

