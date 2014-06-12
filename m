From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/3] iommu: Expose IOMMU information in sysfs
Date: Thu, 12 Jun 2014 16:12:18 -0600
Message-ID: <20140612215954.2754.30263.stgit@bling.home>
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
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Users want to know the features of their hardware and we need a better
way to get it than parsing it out of dmesg.  This series creates an
IOMMU class and allows drivers to create and destroy a device within
that class.  Drivers may also link and unlink devices to expose the
association of a device to a specific hardware unit and create
attribute groups to expose further information about the specific
IOMMU.

An example use case for this would be to determine whether the IOMMU
for a device supports super-pages, which can have performance
implications for a device assignment scenario.  A user with multiple
IOMMU units may also want to factor load per IOMMU into their hardware
layout.  This helps to expose those connections.

I posted an RFC for this last month, but there were no comments.  This
version officialy includes AMD-Vi support and removes the kobject used
for creating the "devices" subdirectory, instead using an empty
attribute group.  I've tried not to duplicate any information
available elsewhere for the user, for example in the DMAR or IVRS
tables.  This means that while I think it might be interesting to
expose things like RMRR, the user already has access to those by
parsing the appropriate firmware table.  I welcome any additional
IOMMU driver implementaitons.  Thanks,

Alex

---

Alex Williamson (3):
      iommu: Add sysfs support for IOMMUs
      iommu/intel: Make use of IOMMU sysfs support
      iommu/amd: Add sysfs support


 Documentation/ABI/testing/sysfs-class-iommu        |   17 +++
 .../ABI/testing/sysfs-class-iommu-amd-iommu        |   14 ++
 .../ABI/testing/sysfs-class-iommu-intel-iommu      |   32 +++++
 drivers/iommu/Makefile                             |    1 
 drivers/iommu/amd_iommu.c                          |    6 +
 drivers/iommu/amd_iommu_init.c                     |   38 ++++++
 drivers/iommu/amd_iommu_types.h                    |    3 
 drivers/iommu/dmar.c                               |    9 +
 drivers/iommu/intel-iommu.c                        |   77 +++++++++++-
 drivers/iommu/iommu-sysfs.c                        |  133 ++++++++++++++++++++
 include/linux/intel-iommu.h                        |    3 
 include/linux/iommu.h                              |   26 ++++
 12 files changed, 358 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-iommu
 create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-amd-iommu
 create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-intel-iommu
 create mode 100644 drivers/iommu/iommu-sysfs.c
