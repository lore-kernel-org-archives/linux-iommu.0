Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3767C
	for <iommu@lists.linux.dev>; Mon,  5 Dec 2022 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670246494; x=1701782494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YYI9+dQAeNtU/Cg2+gsptBgiX5yh40A4JHayJSrxBPg=;
  b=bUIQpteWidonPHJ0LDfVqb1YpgdxCcUnz6vmL4JWHQlGIjMXCyXd1L6e
   FZ9yBJDZ+xH7tthT3IjYDyL6k1Wd3RaoB//Z6W7o8jmxnshXrxtAIvWQw
   JhVVFPQXPMqDu5w8xk21fBPBI2L2RMRimpxSBPYoDYKYSZwrS6O4r/g8U
   ArvPVx3gq29qRjZb4rbY0oiYgvwmcLSxflq/WFwUZxppnychu+owVCWtw
   5ibVR683BOzxjOzimJ6pGSwd2s7PiFSn032zZIZs0wCmAdRLe7uP56T0b
   jI74evN5R8i4btqvaWQLViflUnh7j97KLIPcs6mpPu373Jaxmkea3vPo/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="315046101"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="315046101"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 05:21:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="676583246"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="676583246"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2022 05:21:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.1
Date: Mon,  5 Dec 2022 21:14:11 +0800
Message-Id: <20221205131412.2003159-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Below iommu/vt-d fix is queued for your fixes branch. It aims to:

- Fix buggy QAT device mask.

Please consider it for the iommu/fixes branch.

Best regards,
Lu Baolu

Jacob Pan (1):
  iommu/vt-d: Fix buggy QAT device mask

 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

