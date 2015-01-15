From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/3] vfio/type1: map/unmap chunking + conditional rescheduling
Date: Thu, 15 Jan 2015 10:35:08 -0700
Message-ID: <20150115171023.29162.90105.stgit@gimli.home>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series is inspired by the IOMMU tracing code added by Shuah Khan
and a request to report some of those traces for vfio-based device
assignment.  What I saw in the trace was an absurd number of calls to
iommu_unmap().  In fact, I had to up the trace log buffer size several
times before I was actually able to capture a full guest startup and
shutdown.  The problem was that I was testing on a VT-d system without
IOMMU superpage support, which the current code relies on to produce
any sort or optimization in the unmap path.  Without it, we explicitly
unmap every single page.  We can do better.  In fact, doing better on
Intel simply requires asking the IOMMU for the next translations to
determine the extent of a physically contiguous range to unmap.  With
hugetlbfs, this can boost a synthetic VM test case by upwards of 40%,
30% even without hugetlbfs.  An IOMMU with 2M superpage support does
pretty well with hugetlbfs, so we break even there, but when using
non-hugepages we can still see about a 30% improvement.

The trouble comes with AMD-Vi, which has crazy awesome fine-grained
superpage support.  The above change hurts the existing hugetlbfs case
by about 25% and maybe marginally helps the non-hugepage case.

The solution I've come up with is to attempt to detect fine-grained
superpage support and only enable the vfio-based unmap chunking when
not detected.  This maintains AMD-Vi performance while still helping
Intel VT-d.  I'm curious to see what this will do on other IOMMUs.
Please test and report.

The trace also showed that we do single page mappings for invalid and
reserved memory regions, like mappings of MMIO BARs, for no good
reason.  We only need to skip the accounting here, not the chunking.

Finally, the trace showed that we can run far, far too long with
needs-resched set, so I've sprinked in some cond_resched()s after
potentially time consuming IOMMU operations.

All said, on the troublesome Intel case, these changes result in
about 2% of the iommu_unmap() calls we had originally and only
sporadic needs-resced sightings.  Thanks,

Alex

---

Alex Williamson (3):
      vfio/type1: Add conditional rescheduling
      vfio/type1: Chunk contiguous reserved/invalid page mappings
      vfio/type1: DMA unmap chunking


 drivers/vfio/vfio_iommu_type1.c |   80 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 11 deletions(-)
