From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 0/9] bugfixs and add support for non-pci devices
Date: Tue, 7 Jul 2015 11:30:13 +0800
Message-ID: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
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

Changelog:
v1 -> v2:
update the implementation of patch 1/9 according to Will Deacon's suggestion.
update the comment of patch 3/9 and 4/9.
use arm_smmu_options to skip the execution of command CMD_PREFETCH_CONFIG, see patch 5/9.
patch 6/9 is base on Laurent's series, to support probe deferral.
patch 7/9 according to Robin Murphy's suggestion, remove global variable arm_smmu_devices, thanks.
patch 9/9 add support for a master with multiple stream IDs.

Addition:
scripts/checkpatch 6/9 reports a warning, this is temporary. I don't want
patch 9/9 to display too many differences just because of add tabs.

scripts/checkpatch.pl 0006-iommu-arm-smmu-to-support-probe-deferral.patch
WARNING: else is not generally useful after a break or return
#161: FILE: drivers/iommu/arm-smmu-v3.c:1938:
+		return -ENODEV;
+	} else {

Zhen Lei (9):
  iommu/arm-smmu: fix the assignment of L1 table log2entries
  iommu/arm-smmu: fix the index calculation of strtab
  iommu/arm-smmu: fix the values of ARM64_TCR_IRGN0_SHIFT and
    ARM64_TCR_ORGN0_SHIFT
  iommu/arm-smmu: enlarge STRTAB_L1_SZ_SHIFT to support larger sidsize
  iommu/arm-smmu: skip the execution of CMD_PREFETCH_CONFIG
  iommu/arm-smmu: to support probe deferral
  iommu/arm-smmu: remove arm_smmu_devices
  iommu/arm-smmu: rename __arm_smmu_get_pci_sid
  iommu/arm-smmu: add support for non-pci devices

 drivers/iommu/arm-smmu-v3.c | 238 ++++++++++++++++++++++++++++++++------------
 1 file changed, 173 insertions(+), 65 deletions(-)

--
1.8.0
