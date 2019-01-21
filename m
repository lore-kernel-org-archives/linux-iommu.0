From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v5.0-rc1
Date: Mon, 21 Jan 2019 10:45:42 +0100
Message-ID: <20190121094536.si5x3wltlllsxcod@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.0-rc3

for you to fetch changes up to e8e683ae9a736407a20135df7809090a446db707:

  iommu/of: Fix probe-deferral (2019-01-11 12:28:24 +0100)

----------------------------------------------------------------
IOMMU Fix for Linux v5.0-rc3

One fix only for now:

	- Fix probe deferral in iommu/of code (broke with recent changes
	  to iommu_ops->add_device invocation)

----------------------------------------------------------------
Robin Murphy (1):
      iommu/of: Fix probe-deferral

 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg
