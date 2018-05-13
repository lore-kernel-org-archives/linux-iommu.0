From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma mapping fix for 4.17-rc5
Date: Sun, 13 May 2018 09:03:21 +0200
Message-ID: <20180513070321.GA14697@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

one trivial dma-mapping regression fix for you.  Note that this has
NOT been in linux-next as I didn't want to disturb the branch in
there which has the 4.18 material.  I've asked Stephen to add the
for-linus branch in addition to for-next so that this doesn't happen
again.  In addition to being entirely trivial I also made sure it
passed the 0-day build bot.

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17-5

for you to fetch changes up to 05e13bb57e6f181d7605f8608181c7e6fb7f591d:

  swiotlb: silent unwanted warning "buffer is full" (2018-05-12 11:57:37 +0200)

----------------------------------------------------------------
another dma-mapping fix for 4.17-rc:

 - just one little fix from Jean to avoid a harmless but very annoying
   warning, especially for the drm code

----------------------------------------------------------------
Jean Delvare (1):
      swiotlb: silent unwanted warning "buffer is full"

 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
