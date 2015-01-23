From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/6] PCI: get DMA configuration from parent device
Date: Fri, 23 Jan 2015 17:32:33 -0500
Message-ID: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

PCI devices on Keystone doesn't have correct dma_pfn_offset set. This patch
add capability to set the dma configuration such as dma-mask, dma_pfn_offset,
and dma ops etc using the information from DT. The prior RFCs and discussions
are available at [1] and [2] below.

[2] : https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg790244.html
[1] : http://www.gossamer-threads.com/lists/linux/kernel/2024591

Change history:
	v4 - moved size adjustments in of_iommu_configure() to a separate patch
	   - consistent node name comment from Rob
	   - patch 6 added for dma_mask adjustment and iommu mapping size
	     limiting.
	v3 - addressed comments to re-use of_dma_configure() for PCI
	   - To help re-use, change of_iommu_configure() function argument
		- Move of_dma_configure to of/device.c
		- Limit the of_iommu_configure to non pci devices
	v2 - update size to coherent_dma_mask + 1 if dma-range info is missing
	   - also check the np for null.
	v1 - updates based on the comments against initial RFC.
	   - Added a helper function to get the OF node of the parent
	   - Added an API in of_pci.c to update DMA configuration of the pci
	     device.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Murali Karicheri (6): 
  of: iommu: add ptr to OF node arg to of_iommu_configure()
  of: move of_dma_configure() to device.c to help re-use
  of: fix size when dma-range is not used
  of/pci: add of_pci_dma_configure() update dma configuration
  PCI: update dma configuration from DT
  arm: dma-mapping: updates to limit dma_mask and iommu mapping size

 arch/arm/mm/dma-mapping.c |   10 +++++++
 drivers/iommu/of_iommu.c  |   10 +++++--
 drivers/of/device.c       |   71 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/of_pci.c       |   39 +++++++++++++++++++++++++
 drivers/of/platform.c     |   58 ++----------------------------------
 drivers/pci/probe.c       |    2 ++
 include/linux/of_device.h |    2 ++
 include/linux/of_iommu.h  |    6 ++--
 include/linux/of_pci.h    |   12 ++++++++
 9 files changed, 150 insertions(+), 60 deletions(-)

-- 
1.7.9.5
