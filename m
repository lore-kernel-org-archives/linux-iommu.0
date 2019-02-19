From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 0/2] Add PGR response PASID requirement check in Intel IOMMU.
Date: Tue, 19 Feb 2019 11:04:50 -0800
Message-ID: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
response message. Due to this restriction, If PASID is enabled then Intel
IOMMU driver will enable PRI only, if the endpoint is compliant to Intel
IOMMU's.

Changes since v1:
 * Changed interface name to pci_prg_resp_pasid_required().
 * Update comment header format.

Changes since v2:
 * Fixed typos.
 * Moved pci_prg_resp_pasid_required() check to PRI enable logic.

Kuppuswamy Sathyanarayanan (2):
  PCI/ATS: Add pci_prg_resp_pasid_required() interface.
  iommu/vt-d: Fix PRI/PASID dependency issue.

 drivers/iommu/intel-iommu.c   |  4 +++-
 drivers/pci/ats.c             | 30 ++++++++++++++++++++++++++++++
 include/linux/pci-ats.h       |  5 +++++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.20.1
