From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.5
Date: Mon, 21 Dec 2015 18:23:50 +0000
Message-ID: <20151221182350.GV23092@arm.com>
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
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull the following arm-smmu updates for 4.5. Highlights include:

  * Some fixes to get the driver working nicely on Broadcom hardware
  * A change to the io-pgtable API to indicate the unit in which to
    flush (all callers converted, with Ack from Laurent)
  * Use of devm_* for allocating/freeing the SMMUv3 buffers

I'll be disappearing after tomorrow, but I'll be back on 4 January.

Cheers,

Will

--->8

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 12c2ab09571e8aae3a87da2a4a452632a5fac1e5:

  iommu/io-pgtable-arm: Ensure we free the final level on teardown (2015-12-17 12:05:36 +0000)

----------------------------------------------------------------
Markus Elfring (1):
      iommu/arm-smmu: Delete an unnecessary check before free_io_pgtable_ops()

Peng Fan (1):
      iommu/arm-smmu: Correct group reference count

Prem Mallappa (2):
      iommu/arm-smmu: Fix write to GERRORN register
      iommu/arm-smmu: Use STE.S1STALLD only when supported

Robin Murphy (4):
      iommu/io-pgtable-arm: Avoid dereferencing bogus PTEs
      iommu/io-pgtable: Indicate granule for TLB maintenance
      iommu/arm-smmu: Invalidate TLBs properly
      iommu/io-pgtable: Make io_pgtable_ops_to_pgtable() macro common

Will Deacon (5):
      iommu/arm-smmu: Remove #define for non-existent PRIQ_0_OF field
      iommu/arm-smmu: Convert DMA buffer allocations to the managed API
      iommu/arm-smmu: Use incoming shareability attributes in bypass mode
      iommu/arm-smmu: Handle unknown CERROR values gracefully
      iommu/io-pgtable-arm: Ensure we free the final level on teardown

 drivers/iommu/arm-smmu-v3.c    | 210 ++++++++++++++---------------------------
 drivers/iommu/arm-smmu.c       |  23 +++--
 drivers/iommu/io-pgtable-arm.c |  49 +++++-----
 drivers/iommu/io-pgtable.h     |   6 +-
 drivers/iommu/ipmmu-vmsa.c     |   4 +-
 5 files changed, 119 insertions(+), 173 deletions(-)
