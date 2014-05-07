From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 0/2] iommu: Expose IOMMU information in sysfs
Date: Wed, 07 May 2014 17:17:42 -0600
Message-ID: <20140507230308.3124.90856.stgit@bling.home>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Users want to know the features of their hardware and we need a better
way to get it than parsing it out of dmesg.  This series adds a simple
registration interface for IOMMUs and an example base implementation
for intel-iommu.

One key hardware feature for device assignment is the IOMMU support
for superpages.  In this example, we can parse it out of the "cap"
attribute exposed, but I expect we'll want to add more human readable
entries for such features.  I'd welcome suggestions on what features
we should pull out into human friendly attributes and how to format
the contents.

I have not attempted to make a common, consistent interface for
attributes between various IOMMU types here.  I'm not entirely sure
such a thing is possible.  Perhaps instead we do like I show in the
intel-iommu example and provide IOMMU driver specific attribute
groups, clearly labeled so that we effectively give each a namespace.
We can promote consistency between drivers, but a common namespace
is probably best left to userspace tools.

Appreciate any thoughts and comments.  Thanks,

Alex

---

Alex Williamson (2):
      iommu: Add sysfs support for IOMMUs
      iommu/intel: Make use of IOMMU sysfs support


 drivers/iommu/Makefile      |    1 
 drivers/iommu/dmar.c        |    8 ++
 drivers/iommu/intel-iommu.c |   75 ++++++++++++++++++++++
 drivers/iommu/iommu-sysfs.c |  147 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |    2 +
 include/linux/iommu.h       |   28 ++++++++
 6 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommu-sysfs.c
