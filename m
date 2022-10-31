Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BDD7E
	for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 01:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667178369; x=1698714369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EMDXCRdwqlGlnOwAqWbXNb8UnPKBXi5/6JNHQV9oHYo=;
  b=lJnS513ozjh8KIJzacLkEvZ+5l2c3TUR1O18N2h1AATalXBUFrfIjdqk
   WdyfCqi4+s0gxGHpGdsqgqttW/x2hR3VgjjS8VMkii8n3pvKi29+xmO5b
   3uEyXmqYz9uCIK88O9TJQOTFSOPGvcYXoUXT+0FURD2cY20NevZdVq/W9
   AhbD3EcdZKsxqyLaRykJJ2xZ4WSKmFyeWkmVs8GahjTDLTLPwOW7U9AUW
   9Goautn20XifBfBfzjvrucEJFPbyDAK3n6jOTRtgE6F1frsMj6MvSiYN4
   ady+8yl2HhobvsStC0NJh6wcIAtjU1bjqxAH07i1ZmzuwW9DpT39IoTCW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="335447125"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="335447125"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584496166"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="584496166"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 18:06:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v14 04/13] PCI: Enable PASID only when ACS RR & UF enabled on upstream path
Date: Mon, 31 Oct 2022 08:59:08 +0800
Message-Id: <20221031005917.45690-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031005917.45690-1-baolu.lu@linux.intel.com>
References: <20221031005917.45690-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Requester ID/Process Address Space ID (PASID) combination
identifies an address space distinct from the PCI bus address space,
e.g., an address space defined by an IOMMU.

But the PCIe fabric routes Memory Requests based on the TLP address,
ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with PASID that
SHOULD go upstream to the IOMMU may instead be routed as a P2P
Request if its address falls in a bridge window.

To ensure that all Memory Requests with PASID are routed upstream,
only enable PASID if ACS P2P Request Redirect and Upstream Forwarding
are enabled for the path leading to the device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/pci/ats.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..f9cc2e10b676 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -382,6 +382,9 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
+	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
+		return -EINVAL;
+
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
-- 
2.34.1

