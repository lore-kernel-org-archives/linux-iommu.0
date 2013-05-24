From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] vfio: type1 iommu hugepage support
Date: Fri, 24 May 2013 11:24:26 -0600
Message-ID: <20130524171613.14229.84050.stgit@bling.home>
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
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, chegu_vinod-VXdhtT5mjnY@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series let's the vfio type1 iommu backend take advantage of iommu
large page support.  See patch 2/2 for the details.  This has been
tested on both amd_iommu and intel_iommu, but only my AMD system has
large page support.  I'd appreciate any testing and feedback on other
systems, particularly vt-d systems supporting large pages.  Mapping
efficiency should be improved a bit without iommu hugepages, but I
hope that it's much more noticeable with huge pages, especially for
very large QEMU guests.

This change includes a clarification to the mapping expectations for
users of the type1 iommu, but is compatible with known users and works
with existing QEMU userspace supporting vfio.  Thanks,

Alex

---

Alex Williamson (2):
      vfio: Convert type1 iommu to use rbtree
      vfio: hugepage support for vfio_iommu_type1


 drivers/vfio/vfio_iommu_type1.c |  607 ++++++++++++++++++++++++---------------
 include/uapi/linux/vfio.h       |    8 -
 2 files changed, 387 insertions(+), 228 deletions(-)
