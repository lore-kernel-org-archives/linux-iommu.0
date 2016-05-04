From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.7
Date: Wed, 4 May 2016 14:45:31 +0100
Message-ID: <20160504134531.GA31744@arm.com>
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
Cc: arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull the following arm-smmu updates for 4.7. The highlights are:

  * Support for 64k pages with SMMUv1 implementations (e.g MMU-401)
  * Remove open-coded 64-bit MMIO accessors
  * Initial support for 16-bit VMIDs, as supported by some ThunderX
    SMMU implementations
  * A couple of errata workarounds for silicon in the field

As a result of the MMIO accessor rework, there is an asm-generic change
here, but it has been Acked-by Arnd.

Thanks,

Will

--->8

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 3ca3712a42f9e632eb41da94ca4eab4f1fb06fcb:

  iommu/arm-smmu: Clear cache lock bit of ACR (2016-05-03 18:23:04 +0100)

----------------------------------------------------------------
Peng Fan (1):
      iommu/arm-smmu: Clear cache lock bit of ACR

Robin Murphy (7):
      iommu/arm-smmu: Differentiate specific implementations
      iommu/arm-smmu: Convert ThunderX workaround to new method
      iommu/arm-smmu: Work around MMU-500 prefetch errata
      io-64-nonatomic: Add relaxed accessor variants
      iommu/arm-smmu: Tidy up 64-bit/atomic I/O accesses
      iommu/arm-smmu: Decouple context format from kernel config
      iommu/arm-smmu: Support SMMUv1 64KB supplement

Tirumalesh Chalamarla (2):
      iommu/arm-smmu: Add support for 16 bit VMID
      iommu/arm-smmu: Workaround for ThunderX erratum #27704

 Documentation/arm64/silicon-errata.txt             |   2 +
 .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
 drivers/iommu/arm-smmu.c                           | 291 +++++++++++++++------
 include/asm-generic/io.h                           |   4 +-
 include/linux/io-64-nonatomic-hi-lo.h              |  25 ++
 include/linux/io-64-nonatomic-lo-hi.h              |  25 ++
 6 files changed, 265 insertions(+), 83 deletions(-)
