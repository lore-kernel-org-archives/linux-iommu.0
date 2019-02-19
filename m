From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 0/2] Add page alignment check in Intel IOMMU.
Date: Tue, 19 Feb 2019 11:06:08 -0800
Message-ID: <cover.1550602392.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com
List-Id: iommu@lists.linux-foundation.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per Intel vt-d specification, Rev 3.0 (section 7.5.1.1, title
"Page Request Descriptor"), Intel IOMMU page request descriptor
only uses bits[63:12] of the Page Address. Hence its required to
enforce that the device will only send page request with
page-aligned address. So, this patch set adds support to verify
whether the device uses page aligned address before enabling the
ATS service in Intel IOMMU driver.

Changes since v1:
 * Fixed issue with PCI_ATS_CAP_PAGE_ALIGNED macro.
 * Fixed comments.

Changes since v2:
 * Fixed Bjorn Helgaas comments.

Kuppuswamy Sathyanarayanan (2):
  PCI/ATS: Add pci_ats_page_aligned() interface
  iommu/vt-d: Enable ATS only if the device uses page aligned address.

 drivers/iommu/intel-iommu.c   |  1 +
 drivers/pci/ats.c             | 27 +++++++++++++++++++++++++++
 include/linux/pci.h           |  2 ++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 31 insertions(+)

-- 
2.20.1
