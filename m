From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/6] iommu/amd: enable ACPI hardware ID device support
Date: Tue, 5 Jan 2016 05:07:18 -0500
Message-ID: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

This patch series enable ACPI hardware ID device support, 

There are some devices indentified using ACPI HID format in AMD chip.
This patch series enable iommu support for those ACPI HID device,
since the existing AMD iommu only supports PCI bus based device.

Suravee Suthikulpanit (3):
  iommu/amd: Modify ivhd_header structure to support type 11h and 40h
  iommu/amd: Use the most comprehensive IVHD type that the driver can
    support
  iommu/amd: Introduces ivrs_acpihid kernel parameter

Wan Zongshun (3):
  iommu/amd: Add new map for storing IVHD dev entry type HID
  iommu/amd: Add support for non-pci devices
  iommu/amd: Manage iommu_group for non-pci devices

 Documentation/kernel-parameters.txt |   7 +
 drivers/iommu/amd_iommu.c           | 158 +++++++++++++++---
 drivers/iommu/amd_iommu_init.c      | 309 +++++++++++++++++++++++++++++++-----
 drivers/iommu/amd_iommu_types.h     |  14 ++
 4 files changed, 433 insertions(+), 55 deletions(-)

-- 
1.9.1
