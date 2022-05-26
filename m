Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CDEC4332F
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D85742535;
	Thu, 26 May 2022 08:16:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h2CmfWcAfyiF; Thu, 26 May 2022 08:16:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 095624255A;
	Thu, 26 May 2022 08:16:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D77C0C0039;
	Thu, 26 May 2022 08:16:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8313AC002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B18342531
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UFFeLpyFP4op for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:16:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FE504255E
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:15 +0000 (UTC)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-30047b94aa8so8012167b3.1
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=LHvrfQT4UXFPIW7HvFCMhDyzwcScgNhuNK8AAkQqhh0=;
 b=ckTLEE9Ka8zRBQWZF8bw1bzPyohHSB7lFDGLGx8zTrvE1U6jlLS2u8eGVyiyeggEvU
 f2EkV92DxtJdRwumDctwEA2IQx70gREKkuzwEB+3OV15TZsv4nnJNeHpcR3jy+FuEHO1
 E+wXrf/OpSIAmM7QLQFDf1+Hl/jJe7k56R5tSxkJdxRlRw2RMnjPZSIzlQ613IfRTFOa
 Zx8mX+wckPdc1dHZYVMnSMTwB7wl2UW03yvyEnDwGVANY6EkvB+fRXiLFfl04V8Uv38Y
 DXO0NJt9s3+k0LJaHseJ6m+c87C0hU/eJug6HuK1f5WfFNhgvCbmyh04c4hNdwY8HvkX
 PXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=LHvrfQT4UXFPIW7HvFCMhDyzwcScgNhuNK8AAkQqhh0=;
 b=vM3DnioFWqRnrL3xeIrLJ+/uWAGVYWn56ycdwaRlqWar/CffRkNwtMizi01+3iKvL7
 neHcdX0cGFKhOQlMGXqrbQ0Md5QmOrK/tIydGTrxCtFXgAYr2pAQkIjlcIWEhY5Izgcn
 6tKXVmO0rHerav7iiLe0vBJ2lUTUep0ttvXLt4oTtJl8/fgTTfGXjWZm806MiPjL/60U
 TSTm3z1baQHeWGm7LzdJ/zZz9r0bOEQfikGa32ZM9bj5N3LKouEwMiU7I+yzUBrCNoOa
 2kXsKWrIqqCHLj2HjPaKiAlD9Sre85F5p5wXjH4ygll/O8/m7cI5Ee+gguQ3LP+0mRhI
 /rAQ==
X-Gm-Message-State: AOAM530m36f3dYCT6id4PGXMOXu1f8brxYU4/WpbPpVq505HckJ1+lCg
 5hF+mNcHWRUrlzxZgHCifU7jMF1iOcYHzVU=
X-Google-Smtp-Source: ABdhPJw4+9jAT07QlqTfVdN89DFF1UyFTJg5uRAxow4srxchUBWqQAUPj+CYeVjLPhmM3eADjwvBI1mMP+o/3L0=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a25:928b:0:b0:64a:f505:427f with SMTP id
 y11-20020a25928b000000b0064af505427fmr33415597ybl.146.1653552974289; Thu, 26
 May 2022 01:16:14 -0700 (PDT)
Date: Thu, 26 May 2022 01:15:46 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-8-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 7/9] driver core: Add fw_devlink_unblock_may_probe()
 helper function
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, 
 David Ahern <dsahern@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, John Stultz <jstultz@google.com>,
 kernel-team@android.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This function can be used during the kernel boot sequence to forcefully
override fw_devlink=on and unblock the probing of all devices that have
a driver.

It's mainly meant to be called from late_initcall() or
late_initcall_sync() where a device needs to probe before the kernel can
mount rootfs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h    |  1 +
 drivers/base/core.c    | 58 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c      |  2 +-
 include/linux/fwnode.h |  2 ++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index ab71403d102f..b3a43a164dcd 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -160,6 +160,7 @@ extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
 extern void deferred_probe_extend_timeout(void);
+extern void driver_deferred_probe_trigger(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7672f23231c1..7ff7fbb00643 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1655,6 +1655,64 @@ void fw_devlink_drivers_done(void)
 	device_links_write_unlock();
 }
 
+static int fw_devlink_may_probe(struct device *dev, void *data)
+{
+	struct device_link *link = to_devlink(dev);
+
+	if (!link->supplier->can_match && link->consumer->can_match)
+		fw_devlink_relax_link(link);
+
+	return 0;
+}
+
+/**
+ * fw_devlink_unblock_may_probe - Force unblock any device that has a driver
+ *
+ * This function is more of a sledge hammer than a scalpel. Use this very
+ * sparingly.
+ *
+ * Some devices might need to be probed and bound successfully before the kernel
+ * boot sequence can finish and move on to init/userspace. For example, a
+ * network interface might need to be bound to be able to mount a NFS rootfs.
+ *
+ * With fw_devlink=on by default, some of these devices might be blocked from
+ * probing because they are waiting on a optional supplier that doesn't have a
+ * driver. While fw_devlink will eventually identify such devices and unblock
+ * the probing automatically, it might be too late by the time it unblocks the
+ * probing of devices. For example, the IP4 autoconfig might timeout before
+ * fw_devlink unblocks probing of the network interface. This function is
+ * available to unblock the probing of such devices.
+ *
+ * Since there's no easy way to know which unprobed device needs to probe for
+ * boot to succeed, this function makes sure fw_devlink doesn't block any device
+ * that has a driver at the point in time this function is called.
+ *
+ * It does this by relaxing (fw_devlink=permissive behavior) all the device
+ * links created by fw_devlink where the consumer has a driver and the supplier
+ * doesn't have a driver.
+ *
+ * It's extremely unlikely that a proper use of this function will be outside of
+ * an initcall. So, until a case is made for that, this function is
+ * intentionally marked with __init.
+ */
+void __init fw_devlink_unblock_may_probe(void)
+{
+	struct device_link *link, *ln;
+
+	if (!fw_devlink_flags || fw_devlink_is_permissive())
+		return;
+
+	/* Wait for current probes to finish to limit impact. */
+	wait_for_device_probe();
+
+	device_links_write_lock();
+	class_for_each_device(&devlink_class, NULL, NULL,
+			      fw_devlink_may_probe);
+	device_links_write_unlock();
+
+	driver_deferred_probe_trigger();
+}
+
 static void fw_devlink_unblock_consumers(struct device *dev)
 {
 	struct device_link *link;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f963d9010d7f..af8138d44e6c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -172,7 +172,7 @@ static bool driver_deferred_probe_enable;
  * changes in the midst of a probe, then deferred processing should be triggered
  * again.
  */
-static void driver_deferred_probe_trigger(void)
+void driver_deferred_probe_trigger(void)
 {
 	if (!driver_deferred_probe_enable)
 		return;
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9a81c4410b9f..0770edda7068 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/bits.h>
 #include <linux/err.h>
+#include <linux/init.h>
 
 struct fwnode_operations;
 struct device;
@@ -199,5 +200,6 @@ extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
+void __init fw_devlink_unblock_may_probe(void);
 
 #endif
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
