From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/5] Implement SMMU passthrough using the default domain
Date: Fri, 10 Mar 2017 20:49:31 +0000
Message-ID: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
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

This is version two of the patches previously posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/481275.html

I've addressed the review feedback I receive there, but the main change
is that the SMMUv3 driver now handles passthrough domains independently
of the disable_bypass parameter.

All feedback welcome,

Will

--->8

Will Deacon (5):
  iommu/arm-smmu: Restrict domain attributes to UNMANAGED domains
  iommu/arm-smmu: Install bypass S2CRs for IOMMU_DOMAIN_IDENTITY domains
  iommu/arm-smmu-v3: Make arm_smmu_install_ste_for_dev return void
  iommu/arm-smmu-v3: Install bypass STEs for IOMMU_DOMAIN_IDENTITY
    domains
  iommu: Allow default domain type to be set on the kernel command line

 Documentation/admin-guide/kernel-parameters.txt |  6 ++
 drivers/iommu/arm-smmu-v3.c                     | 76 +++++++++++++++----------
 drivers/iommu/arm-smmu.c                        | 26 ++++++++-
 drivers/iommu/iommu.c                           | 17 +++++-
 4 files changed, 90 insertions(+), 35 deletions(-)

-- 
2.1.4
