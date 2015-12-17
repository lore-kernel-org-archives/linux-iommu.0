From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 00/13] iommu/arm-smmu: Current patch queue for 4.5
Date: Thu, 17 Dec 2015 12:12:00 +0000
Message-ID: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, zhangbo_a-95E7rUnPDLLQT0dZR+AlfA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's what I currently have queued for 4.5. There are also a couple
of outstanding patches that might still make it:

  * The short descriptor stuff from Robin
  * The Broadcom STE.VALID workaround

Anyway, assuming there are no objections, I plan to send a pull request
to Joerg at the beginning of next week.

Cheers,

Will

--->8

Markus Elfring (1):
  iommu/arm-smmu: Delete an unnecessary check before
    free_io_pgtable_ops()

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

-- 
2.1.4
