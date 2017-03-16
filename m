From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/4] IOMMU reserved region tweaks
Date: Thu, 16 Mar 2017 17:00:15 +0000
Message-ID: <cover.1489683129.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Here's v2 incorporating Eric's feedback and R-b tags, with patch #4 added
to finish the job. Whilst presented as a logical series because it's all
touching the same code, it doesn't necessarily need merging as such - I'd
be happier with patch #1 going into 4.11 before anyone starts using the
sysfs region info in anger, but it's your call; #2 is really a standalone
fix (other than context conflicts) but is non-urgent; #3 and #4 can
happily wait for 4.12.

Robin.

Robin Murphy (4):
  iommu: Disambiguate MSI region types
  iommu/dma: Don't reserve PCI I/O windows
  iommu/dma: Handle IOMMU API reserved regions
  iommu/dma: Make PCI window reservation generic

 drivers/iommu/amd_iommu.c       |   2 +-
 drivers/iommu/arm-smmu-v3.c     |   4 +-
 drivers/iommu/arm-smmu.c        |   4 +-
 drivers/iommu/dma-iommu.c       | 111 ++++++++++++++++++++++++++++++++++------
 drivers/iommu/intel-iommu.c     |   2 +-
 drivers/iommu/iommu.c           |   5 +-
 drivers/vfio/vfio_iommu_type1.c |   7 ++-
 include/linux/dma-iommu.h       |   5 ++
 include/linux/iommu.h           |  18 +++++--
 9 files changed, 127 insertions(+), 31 deletions(-)

-- 
2.11.0.dirty
