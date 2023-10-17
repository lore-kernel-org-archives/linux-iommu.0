Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52D8825
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 03:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox4RZBJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697512873; x=1729048873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hAomhrHNxujB2483v7YfRvTz4s8XblPgphanR++fg0E=;
  b=Ox4RZBJvghliKb3wVeYeNk9szbq8Usrm/FVbTsbpZT5hka1wYC4WNxkG
   t3ZXaPeHdKU1QeiWwU1SHx0HsBoVXYXLr0irNA1lS5+E/dPe4A52cm+uw
   G8C+phaukxFiS5gsj3TQw/2H0+awsaGoZqIcl4Dxcpi8NKo4eDI7YDXPo
   TEJbIJm017Tz28TCslPvwDBld1OOVTZoA16z7ggjk9kqDfth513TI05CZ
   7V/iCbRmwbKEe/DKbN3No8Leg96JM2zvKZffDAz+sj58YnEM6Kj2hYBUp
   cMTMQZiCr7ohXIE6J+8KD1MSo3QDjEjGrrCEBtMwruMtntFKyk8WhEvTv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389560784"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="389560784"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 20:21:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826269945"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826269945"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 20:21:11 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 02/12] iommu/vt-d: Remove initialization for dynamically heap-allocated rcu_head
Date: Tue, 17 Oct 2023 11:20:34 +0800
Message-Id: <20231017032045.114868-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017032045.114868-1-tina.zhang@intel.com>
References: <20231017032045.114868-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_head structures allocated dynamically in the heap don't need any
initialization. Therefore, remove the init_rcu_head().

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 9bf79cf88aec..f9b1f13bd068 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -334,7 +334,6 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 	sdev->iommu = iommu;
 	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-	init_rcu_head(&sdev->rcu);
 	if (info->ats_enabled) {
 		sdev->qdep = info->ats_qdep;
 		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-- 
2.39.3

