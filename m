From: Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.20
Date: Mon, 1 Oct 2018 15:27:06 +0100
Message-ID: <20181001142706.GB9716@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg

Please pull these Arm SMMU updates for 4.20. The big thing here is the
long-awaited "lazy" invalidation mode, using the generic timer-based
infrastructure for moving TLB invalidation out of the fast-path. Thanks
to Zhen Lei for the initial work here, and to Robin for getting it into
shape for upstream.

We've also got some minor fixes dotted around, some of which address
issues that were found by code inspection during the lazy invalidation
code review.

I didn't manage to queue Vivek's runtime PM patches this time around.
This was partly because we ran out of review bandwidth earlier in the
cycle but also because the interaction with the lazy invalidation is
unclear at the moment.

Cheers,

Will

--->8

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 44f6876a00e83df5fd28681502b19b0f51e4a3c6:

  iommu/arm-smmu: Support non-strict mode (2018-10-01 13:01:34 +0100)

----------------------------------------------------------------
John Garry (1):
      iommu/arm-smmu-v3: Fix a couple of minor comment typos

Robin Murphy (3):
      iommu/io-pgtable-arm: Fix race handling in split_blk_unmap()
      iommu/io-pgtable-arm-v7s: Add support for non-strict mode
      iommu/arm-smmu: Support non-strict mode

Will Deacon (1):
      iommu/arm-smmu: Ensure that page-table updates are visible before TLBI

Zhen Lei (7):
      iommu/arm-smmu-v3: Fix unexpected CMD_SYNC timeout
      iommu/arm-smmu-v3: Avoid back-to-back CMD_SYNC operations
      iommu/arm-smmu-v3: Implement flush_iotlb_all hook
      iommu/dma: Add support for non-strict mode
      iommu: Add "iommu.strict" command line option
      iommu/io-pgtable-arm: Add support for non-strict mode
      iommu/arm-smmu-v3: Add support for non-strict mode

 Documentation/admin-guide/kernel-parameters.txt |  12 +++
 drivers/iommu/arm-smmu-v3.c                     | 115 +++++++++++++++++-------
 drivers/iommu/arm-smmu.c                        |  99 ++++++++++++++------
 drivers/iommu/dma-iommu.c                       |  32 ++++++-
 drivers/iommu/io-pgtable-arm-v7s.c              |  11 ++-
 drivers/iommu/io-pgtable-arm.c                  |  23 +++--
 drivers/iommu/io-pgtable.h                      |   5 ++
 drivers/iommu/iommu.c                           |  14 +++
 include/linux/iommu.h                           |   1 +
 9 files changed, 243 insertions(+), 69 deletions(-)
