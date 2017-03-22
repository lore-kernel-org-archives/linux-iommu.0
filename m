From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.11
Date: Wed, 22 Mar 2017 18:38:50 +0000
Message-ID: <20170322183849.GG13077@arm.com>
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
Cc: oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull these two ARM io-pgtable fixes from Oleksandr for 4.11. They're
not critical, but they mean that we detect misuses in the iommu_{map,unmap}
API instead of deferencing junk pointers in the kernel. I've had them queued
locally for a while, so Robin and I have given them a fair workout.

Thanks,

Will

--->8

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to a03849e7210277fa212779b7cd9c30e1ab6194b2:

  iommu/io-pgtable-arm-v7s: Check for leaf entry before dereferencing it (2017-03-10 18:23:34 +0000)

----------------------------------------------------------------
Oleksandr Tyshchenko (2):
      iommu/io-pgtable-arm: Check for leaf entry before dereferencing it
      iommu/io-pgtable-arm-v7s: Check for leaf entry before dereferencing it

 drivers/iommu/io-pgtable-arm-v7s.c | 6 +++++-
 drivers/iommu/io-pgtable-arm.c     | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)
