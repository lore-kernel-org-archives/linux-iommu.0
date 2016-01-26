From: Wan Zongshun <vincent.wan@amd.com>
Subject: [PATCH V2 0/8] iommu/amd: enable ACPI hardware ID device support
Date: Tue, 26 Jan 2016 18:14:29 -0500
Message-ID: <1453850077-2539-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Borislav Petkov <bp@suse.de>, Ray Huang <ray.huang@amd.com>, ken.xue@amd.com, vw@iommu.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org, Wan Zongshun <Vincent.Wan@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Wan Zongshun <Vincent.Wan@amd.com>

There are some devices indentified using ACPI HID format in AMD chip.
This patch series enable iommu support for those ACPI HID device, 
since the existing AMD iommu only supports PCI bus based device.

The latest public version of AMD IOMMU specification that describes
the support for IVHD type 40h and ACPI HID IVHD device type, 
implemented by this patch series, is available here:

http://support.amd.com/TechDocs/48882_IOMMU.pdf


The V2 adds two new patches: patch 5 and patch 8 according to Joerg's
comments.

There is a little modification in patch 6 to distinguish pci and none pci.


Suravee Suthikulpanit (3):
  iommu/amd: Modify ivhd_header structure to support type 11h and 40h
  iommu/amd: Use the most comprehensive IVHD type that the driver can
    support
  iommu/amd: Introduces ivrs_acpihid kernel parameter

Wan Zongshun (5):
  iommu/amd: Add new map for storing IVHD dev entry type HID
  iommu/amd: Make call-sites of get_device_id aware of its return value
  iommu/amd: Add iommu support for ACPI HID devices
  iommu/amd: Manage iommu_group for ACPI HID devices
  iommu/amd: Set AMD iommu callbacks for amba bus

 Documentation/kernel-parameters.txt |   7 +
 drivers/iommu/amd_iommu.c           | 167 ++++++++++++++++---
 drivers/iommu/amd_iommu_init.c      | 309 +++++++++++++++++++++++++++++++-----
 drivers/iommu/amd_iommu_types.h     |  14 ++
 4 files changed, 440 insertions(+), 57 deletions(-)

-- 
1.9.1
