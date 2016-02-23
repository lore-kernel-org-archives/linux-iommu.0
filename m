From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.6
Date: Tue, 23 Feb 2016 12:33:22 +0000
Message-ID: <20160223123322.GL3966@arm.com>
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
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull the following arm-smmu updates for 4.6. This lays the
foundations for a functional IOMMU_DOMAIN_DMA for the two drivers,
although we haven't yet thrown the switch since we need to ensure
that the DMA ops all point in the right direction first. Hopefully we'll
get that going for 4.7.

Will

--->8

The following changes since commit 18558cae0272f8fd9647e69d3fec1565a7949865:

  Linux 4.5-rc4 (2016-02-14 13:05:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to cbf8277ef4562075eb4e3932ccd60cc11ee9454c:

  iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass for now (2016-02-18 15:02:44 +0000)

----------------------------------------------------------------
Anup Patel (1):
      of: iommu: Increment DT node refcount in of_iommu_set_ops()

Robin Murphy (3):
      iommu/arm-smmu: Treat all device transactions as unprivileged
      iommu/arm-smmu: Support DMA-API domains
      iommu/arm-smmu: Allow disabling unmatched stream bypass

Will Deacon (2):
      iommu/arm-smmu: Don't fail device attach if already attached to a domain
      iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass for now

 drivers/iommu/arm-smmu-v3.c | 50 +++++++++++++++-------------
 drivers/iommu/arm-smmu.c    | 79 ++++++++++++++++++++++++++++-----------------
 drivers/iommu/of_iommu.c    |  1 +
 3 files changed, 78 insertions(+), 52 deletions(-)
