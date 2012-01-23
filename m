From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 5/5] vfio: VFIO core Kconfig and Makefile
Date: Mon, 23 Jan 2012 10:21:14 -0700
Message-ID: <20120123172114.26865.89847.stgit@bling.home>
References: <20120123165620.26865.51875.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120123165620.26865.51875.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, aafabbri-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Enable the base code.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 MAINTAINERS           |    8 ++++++++
 drivers/Kconfig       |    2 ++
 drivers/Makefile      |    1 +
 drivers/vfio/Kconfig  |    8 ++++++++
 drivers/vfio/Makefile |    3 +++
 5 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 drivers/vfio/Kconfig
 create mode 100644 drivers/vfio/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index df8cb66..2f3a5c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7129,6 +7129,14 @@ S:	Maintained
 F:	Documentation/filesystems/vfat.txt
 F:	fs/fat/
 
+VFIO DRIVER
+M:	Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+L:	kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	Documentation/vfio.txt
+F:	drivers/vfio/
+F:	include/linux/vfio.h
+
 VIDEOBUF2 FRAMEWORK
 M:	Pawel Osciak <pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org>
 M:	Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index d5138e6..f168bf3 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -114,6 +114,8 @@ source "drivers/auxdisplay/Kconfig"
 
 source "drivers/uio/Kconfig"
 
+source "drivers/vfio/Kconfig"
+
 source "drivers/vlynq/Kconfig"
 
 source "drivers/virtio/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 71a1f16..6be03a1 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_FUSION)		+= message/
 obj-y				+= firewire/
 obj-$(CONFIG_UIO)		+= uio/
+obj-$(CONFIG_VFIO)		+= vfio/
 obj-y				+= cdrom/
 obj-y				+= auxdisplay/
 obj-$(CONFIG_PCCARD)		+= pcmcia/
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
new file mode 100644
index 0000000..9acb1e7
--- /dev/null
+++ b/drivers/vfio/Kconfig
@@ -0,0 +1,8 @@
+menuconfig VFIO
+	tristate "VFIO Non-Privileged userspace driver framework"
+	depends on IOMMU_API
+	help
+	  VFIO provides a framework for secure userspace device drivers.
+	  See Documentation/vfio.txt for more details.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
new file mode 100644
index 0000000..088faf1
--- /dev/null
+++ b/drivers/vfio/Makefile
@@ -0,0 +1,3 @@
+vfio-y := vfio_main.o vfio_iommu.o
+
+obj-$(CONFIG_VFIO) := vfio.o
