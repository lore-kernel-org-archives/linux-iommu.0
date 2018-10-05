From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v4.19-rc6
Date: Fri, 5 Oct 2018 10:30:09 +0200
Message-ID: <20181005083005.ctclagex4fu73tvf@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Greg,

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.19-rc6

for you to fetch changes up to b3e9b515b08e407ab3a026dc2e4d935c48d05f69:

  iommu/amd: Clear memory encryption mask from physical address (2018-10-05 10:20:24 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v4.19-rc6

One important fix:

	- Fix a memory leak with AMD IOMMU when SME is active and a VM
	  has assigned devices. In that case the complete guest memory
	  will be leaked without this fix.

----------------------------------------------------------------
Singh, Brijesh (1):
      iommu/amd: Clear memory encryption mask from physical address

 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg
