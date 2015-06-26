From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/8] iommu/arm-smmu: bugfixs and add support for non-pci
	devices
Date: Fri, 26 Jun 2015 16:32:56 +0800
Message-ID: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

As Documentation\devicetree\bindings\iommu\iommu.txt mentioned, a master may
belongs to many SMMUs or have more than one device-id(stream id). But on current
arm/arm64 platforms, a master with only one stream id. So I directly add two
members(of_smmu and device-id) in struct dev_archdata, and only support a master
with only one stream id. If some platforms that a master belongs to more than one
SMMUs or have more than one device-id, we should dynamic memory allocation to record
all information.

Zhen Lei (8):
  iommu/arm-smmu: fix the assignment of log2size field
  iommu/arm-smmu: fix the index calculation of strtab
  iommu/arm-smmu: fix the values of ARM64_TCR_IRGN0_SHIFT and
    ARM64_TCR_ORGN0_SHIFT
  iommu/arm-smmu: set EPD1 to disable TT1 translation table walk
  iommu/arm-smmu: rename __arm_smmu_get_pci_sid
  iommu/arm-smmu: add support for non-pci devices
  iommu/arm-smmu: enlarge STRTAB_L1_SZ_SHIFT to support larger sidsize
  iommu/arm-smmu: suppress fault information about CMD_PREFETCH_CONFIG
    execution

 arch/arm64/include/asm/device.h |   2 +
 drivers/iommu/arm-smmu-v3.c     | 135 +++++++++++++++++++++++++++++++++-------
 2 files changed, 116 insertions(+), 21 deletions(-)

--
1.8.0
