From: Alex Williamson <alex.williamson@redhat.com>
Subject: [GIT PULL] IOMMU fixes for v4.15-rc3
Date: Wed, 6 Dec 2017 11:44:24 -0700
Message-ID: <20171206114424.730621df@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

I'm still filling in for Joerg while he's out on paternity leave[1].
Please accept this iommu pull request.  Thanks,

Alex

[1] https://lkml.org/lkml/2017/10/22/72

The following changes since commit cf9b0772f2e410645fece13b749bd56505b998b8:

  Merge tag 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2017-11-16 16:05:01 -0800)

are available in the git repository at:


  git://github.com/awilliam/linux-vfio.git tags/iommu-v4.15-rc3

for you to fetch changes up to 29a90b70893817e2f2bb3cea40a29f5308e21b21:

  iommu/vt-d: Fix scatterlist offset handling (2017-11-17 10:28:58 -0700)

----------------------------------------------------------------
IOMMU fixes for Linux v4.15-rc3

 * Fix VT-d handling of scatterlists where sg->offset exceeds PAGE_SIZE

----------------------------------------------------------------
Robin Murphy (1):
      iommu/vt-d: Fix scatterlist offset handling

 drivers/iommu/intel-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
