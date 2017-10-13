From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/4] iommu/amd, vfio: Reduce IOTLB Flushm Rate
Date: Fri, 13 Oct 2017 16:40:09 +0200
Message-ID: <1507905613-30695-1-git-send-email-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

these patches implement the new IOTLB flush interface in the
AMD IOMMU driver. But for it to take effect, changes in VFIO
are also necessary, because VFIO unpins the pages after
every successful iommu_unmap() call. This requires an IOTLB
flush, so that we don't save flushes.

So I implemented vfio-gather code to collect up to 32 ranges
before they are unpinned together. This significantly
reduces the number of necessary IOTLB flushes in my tests.

Please review.

Thanks,

	Joerg

Joerg Roedel (4):
  iommu/amd: Finish TLB flush in amd_iommu_unmap()
  iommu/amd: Implement IOMMU-API TLB flush interface
  vfio/type1: Make use of iommu_unmap_fast()
  vfio/type1: Gather TLB-syncs and pages to unpin

 drivers/iommu/amd_iommu.c       |  12 +++-
 drivers/vfio/vfio_iommu_type1.c | 128 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 128 insertions(+), 12 deletions(-)

-- 
2.7.4
