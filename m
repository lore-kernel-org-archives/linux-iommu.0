Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE014D2BE
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447482; cv=none; b=MneeY9AYln2oTnYuExd2pilmSJ/XPbXJYv7p3GzR485bWHefeWyzWII/q7F5sf1jEzjFR+DOwsYl+IrRN7/r2nIqc9sZJ6RuvehYC7hW30jhAJ88j4d4Hp2fllcWJjeKZy26tRqm8XrQQyPZObLPwLMp/pC+3XQlZ74ts45ltoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447482; c=relaxed/simple;
	bh=Nxe5+R4C9sbMphvd/xbGCajCmYTCQpi3ZSS8JEnsuAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ux6BrrryH0XxoTMn2CEZcxmwQ6F+rIa0hcCknhBovJnfmimxw1qIISIo6EgoMbSAYlh5duFY6CznLssuGGClp2lMKKlne+f3tZsgeMrGpn/kOs97fUF8BNAaqQn7MSkYVkHialzVHFxNW8tB5NYK2OhFbrkH/kvniJ8y+huk99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQtN6a5g; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQtN6a5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723447481; x=1754983481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nxe5+R4C9sbMphvd/xbGCajCmYTCQpi3ZSS8JEnsuAI=;
  b=gQtN6a5gcUrvHH7hZV4xMNh2yYLEPzWIvBrWmsmmDWyeQM9CcI4oLNNh
   EUy1Vx7Ynl4mcGtLt0hcBnq45aAaaI9NOfqAz9ap3DBNk9cmFRnuNFeAT
   U8/iPWo3Ov43T0EfKHeO2102Ks/vcC42FaUf16ZzDfrMDqL3qq/mLaKtS
   aMO56TF/hGN9l+Qww8vMHTxfWvhl/q5LGMTYDUvNxb9O6aSbojmfaqOz0
   Ki+0WRQU01c4BF/nEBlFDQMijmVgRpOgSzqrFlESvVkwcFTe7lIadeHd8
   I8aehE9yCZF1Qi8lcduxkThMCSsUWdQhSJLS/U0YcusO5mdKyhRyUhqXf
   w==;
X-CSE-ConnectionGUID: sONDFxLkQfmCXermWtAB4A==
X-CSE-MsgGUID: MTjTtuIsTpCRj6D2iF5Kgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32691581"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32691581"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:24:40 -0700
X-CSE-ConnectionGUID: NDAypZJySrCq1DeB69dwKQ==
X-CSE-MsgGUID: yqQutkRQTxKtBPosJ8D5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="62829617"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2024 00:24:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Dmitry Osipenko <digetx@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: linux-media@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/2] media: nvidia: tegra: Use iommu_paging_domain_alloc()
Date: Mon, 12 Aug 2024 15:21:04 +0800
Message-Id: <20240812072105.9578-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommu domain is allocated in tegra_vde_iommu_init() and is attached to
vde->dev. Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240610085555.88197-9-baolu.lu@linux.intel.com
---
 drivers/media/platform/nvidia/tegra-vde/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/iommu.c b/drivers/media/platform/nvidia/tegra-vde/iommu.c
index 5521ed3e465f..b1d9d841d944 100644
--- a/drivers/media/platform/nvidia/tegra-vde/iommu.c
+++ b/drivers/media/platform/nvidia/tegra-vde/iommu.c
@@ -78,9 +78,10 @@ int tegra_vde_iommu_init(struct tegra_vde *vde)
 		arm_iommu_release_mapping(mapping);
 	}
 #endif
-	vde->domain = iommu_domain_alloc(&platform_bus_type);
-	if (!vde->domain) {
-		err = -ENOMEM;
+	vde->domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(vde->domain)) {
+		err = PTR_ERR(vde->domain);
+		vde->domain = NULL;
 		goto put_group;
 	}
 
-- 
2.34.1

