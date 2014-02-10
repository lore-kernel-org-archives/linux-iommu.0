From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: fixes for 3.14
Date: Mon, 10 Feb 2014 18:32:32 +0000
Message-ID: <20140210183232.GH12826@mudshark.cambridge.arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull the following arm-smmu fixes for 3.14.

The brief summary is:

  - Andreas Herrmann took the driver for a run with a real SATA
    controller, which caused the new mutex-based locking to explode
    since we require mappings in atomic context

  - Yifan fixed an issue with the page table creation, which then caused
    breakages with the way in which we flush descriptors out to the
    table walker

  - I ran the driver on a system where the SMMU is hooked into a
    coherent interconnect for table walks, and noticed a shareability
    mismatch between the CPU and the SMMU

These issues are all fixed here and have been tested on both arm and
arm64 based systems.

Cheers,

Will

--->8

The following changes since commit b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed:

  Linux 3.14-rc2 (2014-02-09 18:15:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to d123cf82d339c5cc4ffe2a481e0caa23a501d4ac:

  iommu/arm-smmu: fix compilation issue when !CONFIG_ARM_AMBA (2014-02-10 17:02:27 +0000)

----------------------------------------------------------------
Will Deacon (4):
      iommu/arm-smmu: really fix page table locking
      iommu/arm-smmu: fix table flushing during initial allocations
      iommu/arm-smmu: set CBARn.BPSHCFG to NSH for s1-s2-bypass contexts
      iommu/arm-smmu: fix compilation issue when !CONFIG_ARM_AMBA

Yifan Zhang (1):
      iommu/arm-smmu: fix pud/pmd entry fill sequence

 drivers/iommu/arm-smmu.c | 103 ++++++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 42 deletions(-)
