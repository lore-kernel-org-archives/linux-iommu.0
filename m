From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/6] iommu/arm-smmu: Updates for 4.4
Date: Thu, 15 Oct 2015 16:04:18 +0100
Message-ID: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here are the ARM SMMU updates I have queued for 4.4. I'm away next week,
so I'll send a corresponding pull request shortly.

Will

--->8

Fabio Estevam (1):
  iommu/arm-smmu: Remove unneeded '0x' annotation

Marc Zyngier (1):
  iommu/arm-smmu: Add support for MSI on SMMUv3

Tirumalesh Chalamarla (1):
  iommu/arm-smmu: ThunderX mis-extends 64bit registers

Will Deacon (3):
  iommu/arm-smmu: Use drvdata instead of maintaining smmu_devices list
  iommu/arm-smmu: fix error checking for ASID and VMID allocation
  iommu/arm-smmu: remove redundant calculation of gr0 base address

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  19 +++
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/arm-smmu-v3.c                        | 154 +++++++++++++++------
 drivers/iommu/arm-smmu.c                           |  55 ++++----
 4 files changed, 159 insertions(+), 70 deletions(-)

-- 
2.1.4
