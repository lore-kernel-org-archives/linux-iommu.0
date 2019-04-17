From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/9] Add PCI ATS support to Arm SMMUv3
Date: Wed, 17 Apr 2019 19:24:39 +0100
Message-ID: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series enables PCI ATS in SMMUv3. Changes since v2 [1]:

* Fix build failure when building arm-smmu-v3 without CONFIG_PCI
  Patches 1 and 2 are new.

* Only enable ATS if the root complex supports it. For the moment, only
  IORT provides this information. I have patches for devicetree but
  they are less mature and I'd rather make it a separate series.

* Tried to address most comments. I'll see if I can improve the firmware
  code when adding devicetree support (see [2]).

Note that there is a small conflict with the SVA API. This series
applies on top of Joerg's api-features branch for v5.2.

[1] https://www.spinics.net/lists/arm-kernel/msg719722.html
[2] git://linux-arm.org/linux-jpb.git ats/current

Jean-Philippe Brucker (9):
  PCI: Move ATS declarations outside of CONFIG_PCI
  PCI: Add a stub for pci_ats_disabled()
  ACPI/IORT: Check ATS capability in root complex nodes
  iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
  iommu/arm-smmu-v3: Store SteamIDs in master
  iommu/arm-smmu-v3: Add a master->domain pointer
  iommu/arm-smmu-v3: Link domains and devices
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Disable tagged pointers

 drivers/acpi/arm64/iort.c   |  11 ++
 drivers/iommu/arm-smmu-v3.c | 345 ++++++++++++++++++++++++++++--------
 include/linux/iommu.h       |   4 +
 include/linux/pci.h         |  31 ++--
 4 files changed, 306 insertions(+), 85 deletions(-)

-- 
2.21.0
