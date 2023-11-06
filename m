Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762FBA55
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f08Szhha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699254847; x=1730790847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gWxXYuEpy8G84pCRxEr8zR2qYt2dBXJPyl6P3BJNrtQ=;
  b=f08Szhhamp4b23pSlZIzgGEi0YfL3+71aywbB0vAzu3Ds+kYTpWKCRRE
   qm+bQOE/4Ig7p1Ygswkx4dGkWYoCh/dLnM6m5bqO5/vL54Fhi5htBiVVt
   sp7TTEcfz8QoJDqg/RDzBdMM2f0gQEqyjcKs1okSVGMTQ8pFLsf+dFSMS
   dXanZIiw2Ij/NlrxpNpheubXzspwmRBM7F2N6bcA2CQntNoX9drv3vUys
   DwuP3RWKGd/moBSBib+EBW/qEIorYxbGkTnpUJ6WAbrfLBEv/eXLkIweO
   G84RGES9uCoOKZtrbnAmihPzG9OzMcT3mIL0L7s0OHGIRx23VVRzN0yaF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759059"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="10759059"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690893"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1093690893"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain) ([10.239.48.212])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:14:02 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	joro@8bytes.org,
	will@kernel.org,
	Yi Liu <yi.l.liu@intel.com>
Cc: virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 3/5] iommu/io-pgtable: Introduce struct vtd_cfg
Date: Mon,  6 Nov 2023 02:12:24 -0500
Message-Id: <20231106071226.9656-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106071226.9656-1-tina.zhang@intel.com>
References: <20231106071226.9656-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VT-d hardware cap/ecap information is needed for driver to generate VT-d
format IO page table. Add struct vtd_cfg to keep the info.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/io-pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index b2857c18f963..ae6a2e44b027 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -147,6 +147,11 @@ struct io_pgtable_cfg {
 			u32 n_ttbrs;
 		} apple_dart_cfg;
 
+		struct {
+			u64 cap_reg;
+			u64 ecap_reg;
+		} vtd_cfg;
+
 		struct {
 			dma_addr_t	pgd;
 		} virt;
-- 
2.39.3

