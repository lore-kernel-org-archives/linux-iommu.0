From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 0/2]  Add PGR response PASID requirement check in Intel IOMMU.
Date: Thu,  7 Feb 2019 10:37:57 -0800
Message-ID: <cover.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com
List-Id: iommu@lists.linux-foundation.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Intel IOMMU responds automatically when receiving page-requests from
a PCIe endpoint and the page-request queue is full and it cannot accept
any more page-requests. When it auto-responds to page-requests with a
success to the endpoint, it automatically responds with the PASID if
the page-request had a PASID in the incoming request. IOMMU doesn't
actually have any place to check device capabilities (like whether
the device expects PASID in PGR response or not) before sending the
response message. Due to this restriction Intel IOMMU driver only
enables PASID, if the endpoint is compliant to Intel IOMMU's. 

Kuppuswamy Sathyanarayanan (2):
  PCI: ATS: Add function to check PRG response PASID bit status.
  iommu/vt-d: Enable PASID only if device expects PASID in PRG response.

 drivers/iommu/intel-iommu.c   |  3 ++-
 drivers/pci/ats.c             | 27 +++++++++++++++++++++++++++
 include/linux/pci-ats.h       |  5 +++++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.20.1
