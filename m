From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/5] Implement SMMU passthrough using the default domain
Date: Thu, 19 Jan 2017 18:19:10 +0000
Message-ID: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

A number of people have expressed interest in having the SMMU come up in
a passthrough configuration, and then allow subsequent translation for
things such as VFIO. Rather than do this in each SMMU driver, it's much
cleaner to allow the default domain to be configured to be something other
than DMA.

This patch series implements a command-line option to configure the
default domain type. Currently, it supports "dma" and "identity" which
is sufficient for the passthrough use-case.

Tested on an ARM fastmodel.

All feedback welcome,

Will

--->8

Will Deacon (5):
  iommu/arm-smmu: Restrict domain attributes to UNMANAGED domains
  iommu/arm-smmu: Install bypass S2CRs for IOMMU_DOMAIN_IDENTITY domains
  iommu/arm-smmu-v3: Install bypass STEs for IOMMU_DOMAIN_IDENTITY
    domains
  arm64: dma-mapping: Only swizzle DMA ops for IOMMU_DOMAIN_DMA
  iommu: Allow default domain type to be set on the kernel command line

 arch/arm64/mm/dma-mapping.c | 17 ++++++++++++-----
 drivers/iommu/arm-smmu-v3.c | 20 ++++++++++++++++++--
 drivers/iommu/arm-smmu.c    | 26 +++++++++++++++++++++++---
 drivers/iommu/iommu.c       | 19 +++++++++++++++++--
 4 files changed, 70 insertions(+), 12 deletions(-)

-- 
2.1.4
