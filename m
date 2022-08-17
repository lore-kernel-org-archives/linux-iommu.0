Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5D7B
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660699568; x=1692235568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Do6sVtxouBaogNOhnjSvTVEDqqNan3ooGCy6TMbkYzE=;
  b=b2mc3M6qwTPCF/9UtcljUSXHudepqA3wCYU5scOqhLOd/JjbOo7R6hvi
   lFig62Sf4DxfY2+ADACM63Sm1ScYExcEkTif34QXDVp3Zwl3UhW8WRxmz
   rTJBI/Qs5WaGHa+PtEk+yLvrBlzeZ3AU40kzlhrea/VeX+aYex2XpPuuf
   0h5edk7/M1aW05xgqzFmwXiZAhVowf7SkHWi4GbVNiwh+CwnpjLKeWbY8
   iSvCj6m3fAUsjfGH/JmSUSPpaIprGvSv8f2iJzwUri84iCjohEUZ3gEuC
   GsYgwCMMryZGYfXg51Z1Wf2FB6gqUPemVdibuAt94RdDvH9trgfPeVHjL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="291126311"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="291126311"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="696587895"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2022 18:26:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhu Tony <tony.zhu@intel.com>,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on upstreaming path
Date: Wed, 17 Aug 2022 09:20:15 +0800
Message-Id: <20220817012024.3251276-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some configurations of the PCI fabric will route device originated TLP
packets based on the memory addresses. These configurations are
incompatible with PASID as the PASID packets form a distinct address
space. For instance, any configuration where switches are present
without ACS enabled is incompatible.

This enhances the pci_enable_pasid() interface by requiring the ACS to
support Source Validation, Request Redirection, Completer Redirection,
and Upstream Forwarding. This effectively means that devices cannot
spoof their requester ID, requests and completions cannot be redirected,
and all transactions are forwarded upstream, even as it passes through a
bridge where the target device is downstream.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/pci/ats.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..0715e48e7973 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -382,6 +382,11 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
+	if (!pci_acs_path_enabled(pdev, NULL,
+				  PCI_ACS_SV | PCI_ACS_RR |
+				  PCI_ACS_CR | PCI_ACS_UF))
+		return -EINVAL;
+
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
-- 
2.25.1

