From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 33/37] iommu/arm-smmu-v3: Disable tagged pointers
Date: Mon, 12 Feb 2018 18:33:48 +0000
Message-ID: <20180212183352.22730-34-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ARM architecture has a "Top Byte Ignore" (TBI) option that makes the
MMU mask out bits [63:56] of an address, allowing a userspace application
to store data in its pointers. This option is incompatible with PCI ATS.

If TBI is enabled in the SMMU and userspace triggers DMA transactions on
tagged pointers, the endpoint might create ATC entries for addresses that
include a tag. Software would then have to send ATC invalidation packets
for each 255 possible alias of an address, or just wipe the whole address
space. This is not a viable option, so disable TBI.

The impact of this change is unclear, since there are very few users of
tagged pointers, much less SVA. But the requirement introduced by this
patch doesn't seem excessive: a userspace application using both tagged
pointers and SVA should now sanitize addresses (clear the tag) before
using them for device DMA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3-context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index eaeba1bec2e9..0479cae5249c 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -221,7 +221,6 @@ static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_context_cfg *cfg, u64 tcr)
 	val |= ARM_SMMU_TCR2CD(tcr, EPD0);
 	val |= ARM_SMMU_TCR2CD(tcr, EPD1);
 	val |= ARM_SMMU_TCR2CD(tcr, IPS);
-	val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
 	if (cfg->hw_access)
 		val |= ARM_SMMU_TCR2CD(tcr, HA);
-- 
2.15.1
