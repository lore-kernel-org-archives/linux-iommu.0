From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.18
Date: Mon, 22 Sep 2014 14:18:10 +0100
Message-ID: <20140922131810.GE25809@arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin.Murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please can you pull these arm-smmu updates for 3.18? Apologies for sending
this later than usual, but I was at a conference last week and couldn't
easily run the usual series of tests.

The main changes are:

  - Explicit support for MMU-401 (as opposed to choosing an SMMU
    architecture version)
  - Some address size fixes that became apparent when running under KVM
  - A new debugging option to force the use of stage-1 or stage-2 only
  - A fix for a benign bug in the page table code
  - Initial support for multi-master IOMMU groups, but there is likely
    more to come in this area

Thanks,

Will

--->8

The following changes since commit 9e82bf014195d6f0054982c463575cdce24292be:

  Linux 3.17-rc5 (2014-09-14 17:50:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to ccd359f219bee914501a8892b148e2a1315066d3:

  iommu/arm-smmu: fix bug in pmd construction (2014-09-22 11:13:01 +0100)

----------------------------------------------------------------
Mitchel Humpherys (1):
      iommu/arm-smmu: fix bug in pmd construction

Robin Murphy (2):
      iommu/arm-smmu: fix architecture version detection
      iommu/arm-smmu: support MMU-401

Will Deacon (5):
      iommu/arm-smmu: allow translation stage to be forced on the cmdline
      iommu/arm-smmu: add support for multi-master iommu groups
      iommu/arm-smmu: put iommu_domain pointer in dev->archdata.iommu
      iommu/arm-smmu: use page shift instead of page size to avoid division
      iommu/arm-smmu: don't bother truncating the s1 output size to VA_BITS

 .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
 drivers/iommu/arm-smmu.c                           | 201 ++++++++++++---------
 2 files changed, 121 insertions(+), 81 deletions(-)
