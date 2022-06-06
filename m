Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89870C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 08:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BFD74167A;
	Mon,  6 Jun 2022 08:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G6aY9yCq8YEr; Mon,  6 Jun 2022 08:41:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 36D344160F;
	Mon,  6 Jun 2022 08:41:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04031C0039;
	Mon,  6 Jun 2022 08:41:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED15DC002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 08:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB51C840D4
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 08:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUNm_TxE6KMq for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 08:41:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E73F8840BA
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 08:41:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BE33861224;
 Mon,  6 Jun 2022 08:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E79C3411F;
 Mon,  6 Jun 2022 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654504893;
 bh=6a+EaC2a8SBGdDct+a9CoWztVejwid22UKYL7hpgZY0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y51/BhpIkBjECWWRhg6vtADq71yBeW25MMG9kNeyODxwahNglM2lKyiKLHf1CZylM
 X46uKylG2NF1B5TAHu/fBMolGIZWjOglsRDqGsK5sLi0Wp+Rs+r4oOe5pnn3CMB7uG
 29JPnMftmkDKDEN9ESFjZX/qisuaYxq5+B4xlY+GR1I8rqub83eV3NrysNvfIAS5+7
 J1cRlWF3EKSEuIGJROJQ9lXIdSiaDoRDPmmy3/J0ndan2IY+UILWGrkD9Eyr71EIwl
 hNfWySF2GPuNjIDcXgjPY6myheszu5tR7zZ44yzBF1cKnrkEP6xS2XJBtwDEPxNqMi
 B7THMqhIRi/JA==
From: Arnd Bergmann <arnd@kernel.org>
To: 
Subject: [PATCH 2/6] vme: move back to staging
Date: Mon,  6 Jun 2022 10:41:05 +0200
Message-Id: <20220606084109.4108188-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220606084109.4108188-1-arnd@kernel.org>
References: <20220606084109.4108188-1-arnd@kernel.org>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Denis Efremov <efremov@linux.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Khalid Aziz <khalid@gonehiking.org>,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Arnd Bergmann <arnd@arndb.de>

The VME subsystem graduated from staging into a top-level subsystem in
2012, with commit db3b9e990e75 ("Staging: VME: move VME drivers out of
staging") stating:

    The VME device drivers have not moved out yet due to some API
    questions they are still working through, that should happen soon,
    hopefully.

However, this never happened: maintenance of drivers/vme effectively
stopped in 2017, with all subsequent changes being treewide cleanups.
No hardware driver remains in staging, only the limited user-level
access, and I just removed one of the two bridge drivers and the only
remaining board.

drivers/staging/vme/devices/ was recently moved to
drivers/staging/vme_user/, but as the vme_user driver is the only one
remaining for this subsystem, it is easier to just move the remaining
three source files into this directory rather than keeping the original
hierarchy.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/driver-api/vme.rst              |  4 +--
 MAINTAINERS                                   |  4 +--
 drivers/Kconfig                               |  2 --
 drivers/Makefile                              |  1 -
 drivers/staging/vme_user/Kconfig              | 27 +++++++++++++++++++
 drivers/staging/vme_user/Makefile             |  3 +++
 drivers/{vme => staging/vme_user}/vme.c       |  2 +-
 .../linux => drivers/staging/vme_user}/vme.h  |  0
 .../{vme => staging/vme_user}/vme_bridge.h    |  2 +-
 .../bridges => staging/vme_user}/vme_fake.c   |  4 +--
 .../bridges => staging/vme_user}/vme_tsi148.c |  4 +--
 .../bridges => staging/vme_user}/vme_tsi148.h |  0
 drivers/staging/vme_user/vme_user.c           |  2 +-
 drivers/vme/Kconfig                           | 16 -----------
 drivers/vme/Makefile                          |  7 -----
 drivers/vme/bridges/Kconfig                   | 17 ------------
 drivers/vme/bridges/Makefile                  |  3 ---
 17 files changed, 40 insertions(+), 58 deletions(-)
 rename drivers/{vme => staging/vme_user}/vme.c (99%)
 rename {include/linux => drivers/staging/vme_user}/vme.h (100%)
 rename drivers/{vme => staging/vme_user}/vme_bridge.h (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_fake.c (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_tsi148.c (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_tsi148.h (100%)
 delete mode 100644 drivers/vme/Kconfig
 delete mode 100644 drivers/vme/Makefile
 delete mode 100644 drivers/vme/bridges/Kconfig
 delete mode 100644 drivers/vme/bridges/Makefile

diff --git a/Documentation/driver-api/vme.rst b/Documentation/driver-api/vme.rst
index def139c13410..c0b475369de0 100644
--- a/Documentation/driver-api/vme.rst
+++ b/Documentation/driver-api/vme.rst
@@ -290,8 +290,8 @@ The function :c:func:`vme_bus_num` returns the bus ID of the provided bridge.
 VME API
 -------
 
-.. kernel-doc:: include/linux/vme.h
+.. kernel-doc:: drivers/staging/vme_user/vme.h
    :internal:
 
-.. kernel-doc:: drivers/vme/vme.c
+.. kernel-doc:: drivers/staging/vme_user/vme.c
    :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..d8e2cdbb93e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21229,12 +21229,10 @@ M:	Martyn Welch <martyn@welchs.me.uk>
 M:	Manohar Vanga <manohar.vanga@gmail.com>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	linux-kernel@vger.kernel.org
-S:	Maintained
+S:	Odd fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	Documentation/driver-api/vme.rst
 F:	drivers/staging/vme_user/
-F:	drivers/vme/
-F:	include/linux/vme*
 
 VM SOCKETS (AF_VSOCK)
 M:	Stefano Garzarella <sgarzare@redhat.com>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index b6a172d32a7d..19ee995bd0ae 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -183,8 +183,6 @@ source "drivers/iio/Kconfig"
 
 source "drivers/ntb/Kconfig"
 
-source "drivers/vme/Kconfig"
-
 source "drivers/pwm/Kconfig"
 
 source "drivers/irqchip/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 9a30842b22c5..dadf2678277f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -165,7 +165,6 @@ obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
 obj-$(CONFIG_EXTCON)		+= extcon/
 obj-$(CONFIG_MEMORY)		+= memory/
 obj-$(CONFIG_IIO)		+= iio/
-obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_IPACK_BUS)		+= ipack/
 obj-$(CONFIG_NTB)		+= ntb/
 obj-$(CONFIG_POWERCAP)		+= powercap/
diff --git a/drivers/staging/vme_user/Kconfig b/drivers/staging/vme_user/Kconfig
index e8b4461bf27f..c8eabf8f40f1 100644
--- a/drivers/staging/vme_user/Kconfig
+++ b/drivers/staging/vme_user/Kconfig
@@ -1,4 +1,29 @@
 # SPDX-License-Identifier: GPL-2.0
+menuconfig VME_BUS
+	bool "VME bridge support"
+	depends on STAGING && PCI
+	help
+	  If you say Y here you get support for the VME bridge Framework.
+
+if VME_BUS
+
+comment "VME Bridge Drivers"
+
+config VME_TSI148
+	tristate "Tempe"
+	depends on HAS_DMA
+	help
+	 If you say Y here you get support for the Tundra TSI148 VME bridge
+	 chip.
+
+config VME_FAKE
+	tristate "Fake"
+	help
+	 If you say Y here you get support for the fake VME bridge. This
+	 provides a virtualised VME Bus for devices with no VME bridge. This
+	 is mainly useful for VME development (in the absence of VME
+	 hardware).
+
 comment "VME Device Drivers"
 
 config VME_USER
@@ -11,3 +36,5 @@ config VME_USER
 
 	  To compile this driver as a module, choose M here. The module will
 	  be called vme_user. If unsure, say N.
+
+endif
diff --git a/drivers/staging/vme_user/Makefile b/drivers/staging/vme_user/Makefile
index 5380115139b0..8dcc6938ce5c 100644
--- a/drivers/staging/vme_user/Makefile
+++ b/drivers/staging/vme_user/Makefile
@@ -3,4 +3,7 @@
 # Makefile for the VME device drivers.
 #
 
+obj-$(CONFIG_VME_BUS)		+= vme.o
 obj-$(CONFIG_VME_USER)		+= vme_user.o
+obj-$(CONFIG_VME_TSI148)	+= vme_tsi148.o
+obj-$(CONFIG_VME_FAKE)		+= vme_fake.o
diff --git a/drivers/vme/vme.c b/drivers/staging/vme_user/vme.c
similarity index 99%
rename from drivers/vme/vme.c
rename to drivers/staging/vme_user/vme.c
index 8dba20186be3..b5555683a069 100644
--- a/drivers/vme/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -26,8 +26,8 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
-#include <linux/vme.h>
 
+#include "vme.h"
 #include "vme_bridge.h"
 
 /* Bitmask and list of registered buses both protected by common mutex */
diff --git a/include/linux/vme.h b/drivers/staging/vme_user/vme.h
similarity index 100%
rename from include/linux/vme.h
rename to drivers/staging/vme_user/vme.h
diff --git a/drivers/vme/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
similarity index 99%
rename from drivers/vme/vme_bridge.h
rename to drivers/staging/vme_user/vme_bridge.h
index 42ecf961004e..0bbefe9851d7 100644
--- a/drivers/vme/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -2,7 +2,7 @@
 #ifndef _VME_BRIDGE_H_
 #define _VME_BRIDGE_H_
 
-#include <linux/vme.h>
+#include "vme.h"
 
 #define VME_CRCSR_BUF_SIZE (508*1024)
 /*
diff --git a/drivers/vme/bridges/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
similarity index 99%
rename from drivers/vme/bridges/vme_fake.c
rename to drivers/staging/vme_user/vme_fake.c
index 6a1bc284f297..dd646b0c531d 100644
--- a/drivers/vme/bridges/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -29,9 +29,9 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/vme.h>
 
-#include "../vme_bridge.h"
+#include "vme.h"
+#include "vme_bridge.h"
 
 /*
  *  Define the number of each that the fake driver supports.
diff --git a/drivers/vme/bridges/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
similarity index 99%
rename from drivers/vme/bridges/vme_tsi148.c
rename to drivers/staging/vme_user/vme_tsi148.c
index be9051b02f24..956476213241 100644
--- a/drivers/vme/bridges/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -26,9 +26,9 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/byteorder/generic.h>
-#include <linux/vme.h>
 
-#include "../vme_bridge.h"
+#include "vme.h"
+#include "vme_bridge.h"
 #include "vme_tsi148.h"
 
 static int tsi148_probe(struct pci_dev *, const struct pci_device_id *);
diff --git a/drivers/vme/bridges/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
similarity index 100%
rename from drivers/vme/bridges/vme_tsi148.h
rename to drivers/staging/vme_user/vme_tsi148.h
diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 859af797630c..4e533c0bfe6d 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -33,8 +33,8 @@
 
 #include <linux/io.h>
 #include <linux/uaccess.h>
-#include <linux/vme.h>
 
+#include "vme.h"
 #include "vme_user.h"
 
 static const char driver_name[] = "vme_user";
diff --git a/drivers/vme/Kconfig b/drivers/vme/Kconfig
deleted file mode 100644
index 26feabba19d2..000000000000
--- a/drivers/vme/Kconfig
+++ /dev/null
@@ -1,16 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# VME configuration.
-#
-
-menuconfig VME_BUS
-	bool "VME bridge support"
-	depends on PCI
-	help
-	  If you say Y here you get support for the VME bridge Framework.
-
-if VME_BUS
-
-source "drivers/vme/bridges/Kconfig"
-
-endif # VME
diff --git a/drivers/vme/Makefile b/drivers/vme/Makefile
deleted file mode 100644
index 2dfb929a23de..000000000000
--- a/drivers/vme/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the VME bridge device drivers.
-#
-obj-$(CONFIG_VME_BUS)		+= vme.o
-
-obj-y				+= bridges/
diff --git a/drivers/vme/bridges/Kconfig b/drivers/vme/bridges/Kconfig
deleted file mode 100644
index 9493b22b5276..000000000000
--- a/drivers/vme/bridges/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-comment "VME Bridge Drivers"
-
-config VME_TSI148
-	tristate "Tempe"
-	depends on HAS_DMA
-	help
-	 If you say Y here you get support for the Tundra TSI148 VME bridge
-	 chip.
-
-config VME_FAKE
-	tristate "Fake"
-	help
-	 If you say Y here you get support for the fake VME bridge. This
-	 provides a virtualised VME Bus for devices with no VME bridge. This
-	 is mainly useful for VME development (in the absence of VME
-	 hardware).
diff --git a/drivers/vme/bridges/Makefile b/drivers/vme/bridges/Makefile
deleted file mode 100644
index 043f9cd7a510..000000000000
--- a/drivers/vme/bridges/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_VME_TSI148)	+= vme_tsi148.o
-obj-$(CONFIG_VME_FAKE)		+= vme_fake.o
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
