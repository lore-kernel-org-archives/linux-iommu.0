From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.13
Date: Wed, 9 Oct 2013 18:02:39 +0100
Message-ID: <20131009170238.GH8378@mudshark.cambridge.arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull these ARM SMMU updates for 3.13. The bulk of the changes are
from Andreas, who has been having fun running the driver on real hardware. I
expect some additional patches from him in the future to add support for
things like device isolation once we've ironed out the wrinkles in the
current proposals.

I've successfully tested this lot in my modelled environments without any
observed regressions.

Cheers,

Will

--->8

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 659db6f6beacae6fe49b5566debc4e82f678ff63:

  iommu/arm-smmu: Clear global and context bank fault status registers (2013-10-09 14:14:41 +0100)

----------------------------------------------------------------
Andreas Herrmann (5):
      iommu/arm-smmu: Switch to subsys_initcall for driver registration
      iommu/arm-smmu: Refine check for proper size of mapped region
      iommu/arm-smmu: Check for num_context_irqs > 0 to avoid divide by zero exception
      iommu/arm-smmu: Print context fault information
      iommu/arm-smmu: Clear global and context bank fault status registers

Julia Lawall (1):
      iommu/arm-smmu: replace devm_request_and_ioremap by devm_ioremap_resource

Will Deacon (1):
      iommu/arm-smmu: use relaxed accessors where possible

 drivers/iommu/arm-smmu.c | 69 ++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 32 deletions(-)
