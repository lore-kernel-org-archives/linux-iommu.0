From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V3 0/9] iommu/amd: enable ACPI hardware ID device support
Date: Fri, 1 Apr 2016 09:05:56 -0400
Message-ID: <1459515965-2865-1-git-send-email-vincent.wan@amd.com>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

There are some devices indentified using ACPI HID format in AMD chip.
This patch series enable iommu support for those ACPI HID device, 
since the existing AMD iommu only supports PCI bus based device.

The latest public version of AMD IOMMU specification that describes
the support for IVHD type 40h and ACPI HID IVHD device type, 
implemented by this patch series, is available here:

http://support.amd.com/TechDocs/48882_IOMMU.pdf

The V2 added two new patches: patch 5 and patch 8 according to Joerg's
comments, there is a little modification in patch 6 to distinguish pci
and none pci.

The V3 added the fix for the booting issue Joerg experienced on the CZ
platform due to the IOMMU performance counter init code.

Suravee Suthikulpanit (4):
  iommu/amd: Adding Extended Feature Register check for PC support
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
 drivers/iommu/amd_iommu.c           | 167 +++++++++++++++---
 drivers/iommu/amd_iommu_init.c      | 329 +++++++++++++++++++++++++++++++-----
 drivers/iommu/amd_iommu_types.h     |  14 ++
 4 files changed, 457 insertions(+), 60 deletions(-)

-- 
1.9.1
