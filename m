From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.17
Date: Tue, 27 Mar 2018 17:37:17 +0100
Message-ID: <20180327163716.GC18435@arm.com>
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

Please pull the following Arm SMMU updates for 4.17. Changes include:

  * More graceful handling and reporting of IRQ setup failures
  * General cleanup of our register field definitions using linux/bitmask.h
  * Support for 52-bit physical and virtual addressing

Cheers,

Will

--->8

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to dcd189e6d2eca4663da6120463fbff0995bc06eb:

  iommu/arm-smmu-v3: Support 52-bit virtual address (2018-03-27 14:12:06 +0100)

----------------------------------------------------------------
Nate Watterson (1):
      iommu/arm-smmu-v3: limit reporting of MSI allocation failures

Robin Murphy (8):
      iommu/arm-smmu-v3: Warn about missing IRQs
      iommu/arm-smmu-v3: Clean up address masking
      iommu/arm-smmu-v3: Clean up register definitions
      iommu/arm-smmu-v3: Clean up table definitions
      iommu/arm-smmu-v3: Clean up queue definitions
      iommu/io-pgtable-arm: Support 52-bit physical address
      iommu/arm-smmu-v3: Support 52-bit physical address
      iommu/arm-smmu-v3: Support 52-bit virtual address

 drivers/iommu/arm-smmu-v3.c    | 542 ++++++++++++++++++-----------------------
 drivers/iommu/io-pgtable-arm.c |  67 +++--
 2 files changed, 292 insertions(+), 317 deletions(-)
