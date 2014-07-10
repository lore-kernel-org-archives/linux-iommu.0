From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.17
Date: Thu, 10 Jul 2014 11:33:47 +0100
Message-ID: <20140710103347.GJ2449@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please can you pull the following ARM SMMU updates for 3.17?

The main changes are:

 - Removal of unused SMMU chaining code
 - Initial support for PCI masters
 - Misc. non-critical fixes to the capability checking code and TCR
   configuration

This has largely come out of work enabling passthrough of PCI devices
to a KVM virtual machine with VFIO, so I anticipate further patches in
this area in the near future.

Cheers,

Will

Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> 

--->8

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 2907320df3189420cb66178a86b2917f4b64018f:

  iommu/arm-smmu: fix some checkpatch issues (2014-07-09 10:38:23 +0100)

----------------------------------------------------------------
Mitchel Humpherys (1):
      iommu/arm-smmu: fix some checkpatch issues

Will Deacon (6):
      iommu/arm-smmu: fix calculation of TCR.T0SZ
      iommu/arm-smmu: add support for PCI master devices
      iommu/arm-smmu: caps: add IOMMU_CAP_INTR_REMAP capability
      iommu/arm-smmu: remove support for chained SMMUs
      iommu/arm-smmu: prefer stage-1 mappings where we have a choice
      iommu/arm-smmu: fix capability checking prior to device attach

 .../devicetree/bindings/iommu/arm,smmu.txt         |   6 -
 drivers/iommu/arm-smmu.c                           | 493 ++++++++++-----------
 2 files changed, 240 insertions(+), 259 deletions(-)
