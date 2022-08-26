Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E133E8
	for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661516260; x=1693052260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NYfZ7WyvsEWFSCcqG1ukcz7wBX70baQUiHICdtwmxwA=;
  b=oKpBHkt8Mcfw2YWw/Rx+zuOfVyilYxMGsN/TGA3BmK/8Dx7LX2INiJVE
   JTEq0gauUBUySWbmH+XrtuCdaWtWC9mXYJdD2vwS3k6fcXOtIdoehfZpM
   6ANpd07s/kTXoCQGQlm33mPqb+q/yn3eyyN8WRnbzKtMifQbdxMRrTXjt
   QvmOs1O0m7Tw0f4f0ixuHT+1IntRFScMveYqsre+ou6L26aDyzPqwAMbI
   zwO1qCLhpRck4niVu6Z9D42V5uRyq2of99O9VTuwKrufKH4DlopKlcA9t
   Iuaom+PcucpHogRLmS4WwtTqe30x7P4FH9/JsyCBdPX16w72Gmk8demhn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320587264"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="320587264"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606747576"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:17:34 -0700
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
	Fenghua Yu <fenghua.yu@intel.com>,
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
Subject: [PATCH v12 04/17] PCI: Enable PASID only when ACS RR & UF enabled on upstream path
Date: Fri, 26 Aug 2022 20:11:28 +0800
Message-Id: <20220826121141.50743-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826121141.50743-1-baolu.lu@linux.intel.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
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
2.25.1

