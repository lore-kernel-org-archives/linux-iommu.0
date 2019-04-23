From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC v3 0/3] vfio_pci: wrap pci device as a mediated device
Date: Tue, 23 Apr 2019 20:14:37 +0800
Message-ID: <1556021680-2911-1-git-send-email-yi.l.liu@intel.com>
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
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patchset aims to add a vfio-pci-like meta driver as a demo
user of the vfio changes introduced in "vfio/mdev: IOMMU aware
mediated device" patchset from Baolu Lu.

Previous RFC v1 has given two proposals and the discussion could
be found in following link. Per the comments, this patchset adds
a separate driver named vfio-mdev-pci. It is a sample driver, but
loactes in drivers/vfio/pci due to code sharing consideration.
The corresponding Kconfig definition is in samples/Kconfig.

https://lkml.org/lkml/2019/3/4/529

Besides the test purpose, per Alex's comments, it could also be a
good base driver for experimenting with device specific mdev migration.

Specific interface tested in this proposal:

*) int mdev_set_iommu_device(struct device *dev,
				struct device *iommu_device)
   introduced in the patch as below:
   "[PATCH v5 6/8] vfio/mdev: Add iommu related member in mdev_device"


Links:
*) Link of "vfio/mdev: IOMMU aware mediated device"
	https://lwn.net/Articles/780522/

Please feel free give your comments.

Thanks,
Yi Liu

Change log:
  v2->v3:
  - use vfio-mdev-pci instead of vfio-pci-mdev
  - place the new driver under drivers/vfio/pci while define
    Kconfig in samples/Kconfig to clarify it is a sample driver

  v1->v2:
  - instead of adding kernel option to existing vfio-pci
    module in v1, v2 follows Alex's suggestion to add a
    separate vfio-pci-mdev module.
  - new patchset subject: "vfio/pci: wrap pci device as a mediated device"

Liu, Yi L (3):
  vfio_pci: split vfio_pci.c into two source files
  vfio/pci: protect cap/ecap_perm bits alloc/free with atomic op
  smaples: add vfio-mdev-pci driver

 drivers/vfio/pci/Makefile           |    7 +-
 drivers/vfio/pci/common.c           | 1511 +++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_mdev_pci.c    |  386 +++++++++
 drivers/vfio/pci/vfio_pci.c         | 1476 +---------------------------------
 drivers/vfio/pci/vfio_pci_config.c  |    9 +
 drivers/vfio/pci/vfio_pci_private.h |   27 +
 samples/Kconfig                     |   11 +
 7 files changed, 1962 insertions(+), 1465 deletions(-)
 create mode 100644 drivers/vfio/pci/common.c
 create mode 100644 drivers/vfio/pci/vfio_mdev_pci.c

-- 
2.7.4
