From: Alex Williamson <alex.williamson@redhat.com>
Subject: [GIT PULL] IOMMU fixes for v4.15-rc7
Date: Fri, 5 Jan 2018 15:09:15 -0700
Message-ID: <20180105150915.1ccea127@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

No sign of Joerg returning from paternity leave yet this year, so please
accept this pull request including fixes via Will Deacon for
arm-smmu-v3.  Thanks,

Alex

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the git repository at:

  git://github.com/awilliam/linux-vfio.git tags/iommu-v4.15-rc7

for you to fetch changes up to 563b5cbe334e9503ab2b234e279d500fc4f76018:

  iommu/arm-smmu-v3: Cope with duplicated Stream IDs (2018-01-02 16:45:51 +0000)

----------------------------------------------------------------
IOMMU fixes for Linux v4.15-rc7

 * Fix duplicate Stream ID handling in arm-smmu-v3

 * Fix arm-smmu-v3 page table ops double free

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3: Don't free page table ops twice

Robin Murphy (1):
      iommu/arm-smmu-v3: Cope with duplicated Stream IDs

 drivers/iommu/arm-smmu-v3.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
