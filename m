From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Small fixes for 5.2-rc1
Date: Thu,  2 May 2019 09:34:24 +0800
Message-ID: <20190502013426.16989-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Zhenyu Wang <zhenyuw@linux.intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

This includes two small fixes for virtual IOMMU running in
qemu enviroment. On bare metal, we always have an dedicated
IOMMU for Intel integrated graphic device. And some aspects
of the driver was designed according to this. Unfortunately,
in qemu environment, the virtual IOMMU has only a single
include-all IOMMU engine, as the result some interfaces don't
work as expected anymore. This includes two fixes for this.

Best regards,
Lu Baolu

Lu Baolu (2):
  iommu/vt-d: Set intel_iommu_gfx_mapped correctly
  iommu/vt-d: Make kernel parameter igfx_off work with vIOMMU

 drivers/iommu/intel-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.17.1
