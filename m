Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCEEC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 05:54:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10049206E9
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 05:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pUFDPhuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10049206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C20FC8793D;
	Tue, 30 Jun 2020 05:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u+lc8PuZXcGk; Tue, 30 Jun 2020 05:54:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 31B70878BC;
	Tue, 30 Jun 2020 05:54:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8A4AC07FF;
	Tue, 30 Jun 2020 05:54:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3530C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B1907883B0
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rSicYj4L3dQJ for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 05:54:35 +0000 (UTC)
X-Greylist: delayed 00:56:45 by SQLgrey-1.7.6
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 803FC8839E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 05:54:35 +0000 (UTC)
Received: by mail-pf1-f202.google.com with SMTP id d10so7496208pfn.21
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=LmsPf5jTSure7oX6gJRaMQO8tovJK9Co8tSqz8HCgCs=;
 b=pUFDPhuB/v2g/yvpNhhyyJ30IsV514WJIVZPfX5DchICNB/3GB3lrCK6wRqtA9Kdv1
 KirdW6N6jhQU3OKtY9lACnobzV8sB8+2CkYIz1YnW+Loh1i2w3neTw5UWwOXfihNQ1ff
 nA+KP13GeFBnWQp2ys6B8/qyELYdICgAPBmgVsWtLeEcU29Kws4iqqXBD7tOtSkYZdyu
 urkBWk/wQDdyOy2xwdLQOSVBFa0eV3POZYDjntsphRtU0JA474jLJpe4ICxh6YiBV06Q
 SQKxby71IyV7+sKNgl0upW0Pkq2p65CVWwppw1WE7mzrU9PiekhEdfP7SJASalXvti76
 5afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=LmsPf5jTSure7oX6gJRaMQO8tovJK9Co8tSqz8HCgCs=;
 b=mMPloYyEQD3KPjrVDAdSoz/yXGML2N6EF8sxcrZxzPuqGGLwq3do8oUgifl3/c3cLt
 /qChsl/DXcsbDkHatYa/Bc1dbrZ693fXgS+O4DSyKjwbw/U+qD88C5YytkddheMV0bPZ
 LOYZxI36gXmrB3zdUT8JU8Rlx+l6EukX9+XyctjiRkvOJmw47vvXxCV8S5WgudOA9tD+
 aEs8snh2O8YsVz3AVVXK7T/GuI4UaSzDksKgEWM+AVQZ/zHVR40W7vzINBVA7zL8e085
 w9I1nzd4MCUahKM7parHR4m6D99+kaXgY7soziyQtQXa5Mv9r/8j93xtxUUYMKYQq78G
 5Plw==
X-Gm-Message-State: AOAM533rDZ17UdnT0WEWJusHim0nJCzWhrGTcG6r7ykDsU2+7B0eHTiW
 0T2mkFGkfN1Gr7/ui85o0x1JCnZKa419
X-Google-Smtp-Source: ABdhPJy6mFvmXqDrITIrdGqh6QYCNW4V7diNoS4nldl3h9MgHWUBDraMbYOO32BHpWqaZ1XfnXNP7f0yffta
X-Received: by 2002:a0c:83c4:: with SMTP id k62mr4468584qva.19.1593492597294; 
 Mon, 29 Jun 2020 21:49:57 -0700 (PDT)
Date: Mon, 29 Jun 2020 21:49:41 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-6-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 5/7] driver core: Add device location to "struct device"
 and expose it in sysfs
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>, 
 lalithambika.krishnakumar@intel.com, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Prashant Malani <pmalani@google.com>, 
 Benson Leung <bleung@google.com>, Todd Broch <tbroch@google.com>,
 Alex Levin <levinale@google.com>, 
 Mattias Nissler <mnissler@google.com>, Rajat Jain <rajatxjain@gmail.com>, 
 Bernie Keany <bernie.keany@intel.com>, Aaron Durbin <adurbin@google.com>, 
 Diego Rivas <diegorivas@google.com>, Duncan Laurie <dlaurie@google.com>, 
 Furquan Shaikh <furquan@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Christian Kellner <christian@kellner.me>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com, 
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rajat Jain <rajatja@google.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add a new (optional) field to denote the physical location of a device
in the system, and expose it in sysfs. This was discussed here:
https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/

(The primary choice for attribute name i.e. "location" is already
exposed as an ABI elsewhere, so settled for "site"). Individual buses
that want to support this new attribute can opt-in by setting a flag in
bus_type, and then populating the location of device while enumerating
it.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: (Initial version)

 drivers/base/core.c        | 35 +++++++++++++++++++++++++++++++
 include/linux/device.h     | 42 ++++++++++++++++++++++++++++++++++++++
 include/linux/device/bus.h |  8 ++++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67d39a90b45c7..14c815526b7fa 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1778,6 +1778,32 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);
 
+static ssize_t site_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	const char *site;
+
+	device_lock(dev);
+	switch (dev->site) {
+	case SITE_INTERNAL:
+		site = "INTERNAL";
+		break;
+	case SITE_EXTENDED:
+		site = "EXTENDED";
+		break;
+	case SITE_EXTERNAL:
+		site = "EXTERNAL";
+		break;
+	case SITE_UNKNOWN:
+	default:
+		site = "UNKNOWN";
+		break;
+	}
+	device_unlock(dev);
+	return sprintf(buf, "%s\n", site);
+}
+static DEVICE_ATTR_RO(site);
+
 int device_add_groups(struct device *dev, const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -1949,8 +1975,16 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_groups;
 	}
 
+	if (bus_supports_site(dev->bus)) {
+		error = device_create_file(dev, &dev_attr_site);
+		if (error)
+			goto err_remove_dev_attr_online;
+	}
+
 	return 0;
 
+ err_remove_dev_attr_online:
+	device_remove_file(dev, &dev_attr_online);
  err_remove_dev_groups:
 	device_remove_groups(dev, dev->groups);
  err_remove_type_groups:
@@ -1968,6 +2002,7 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_site);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 15460a5ac024a..a4143735ae712 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -428,6 +428,31 @@ enum dl_dev_state {
 	DL_DEV_UNBINDING,
 };
 
+/**
+ * enum device_site - Physical location of the device in the system.
+ * The semantics of values depend on subsystem / bus:
+ *
+ * @SITE_UNKNOWN:  Location is Unknown (default)
+ *
+ * @SITE_INTERNAL: Device is internal to the system, and cannot be (easily)
+ *                 removed. E.g. SoC internal devices, onboard soldered
+ *                 devices, internal M.2 cards (that cannot be removed
+ *                 without opening the chassis).
+ * @SITE_EXTENDED: Device sits an extension of the system. E.g. devices
+ *                 on external PCIe trays, docking stations etc. These
+ *                 devices may be removable, but are generally housed
+ *                 internally on an extension board, so they are removed
+ *                 only when that whole extension board is removed.
+ * @SITE_EXTERNAL: Devices truly external to the system (i.e. plugged on
+ *                 an external port) that may be removed or added frequently.
+ */
+enum device_site {
+	SITE_UNKNOWN = 0,
+	SITE_INTERNAL,
+	SITE_EXTENDED,
+	SITE_EXTERNAL,
+};
+
 /**
  * struct dev_links_info - Device data related to device links.
  * @suppliers: List of links to supplier devices.
@@ -513,6 +538,7 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu:	Per device generic IOMMU runtime data
+ * @site:	Physical location of the device w.r.t. the system
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -613,6 +639,8 @@ struct device {
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
 
+	enum device_site	site;	/* Device physical location */
+
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
@@ -806,6 +834,20 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline int dev_set_site(struct device *dev, enum device_site site)
+{
+	if (site < SITE_UNKNOWN || site > SITE_EXTERNAL)
+		return -EINVAL;
+
+	dev->site = site;
+	return 0;
+}
+
+static inline bool dev_is_external(struct device *dev)
+{
+	return dev->site == SITE_EXTERNAL;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 1ea5e1d1545bd..e1079772e45af 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -69,6 +69,8 @@ struct fwnode_handle;
  * @lock_key:	Lock class key for use by the lock validator
  * @need_parent_lock:	When probing or removing a device on this bus, the
  *			device core should lock the device's parent.
+ * @supports_site:	Bus can differentiate between internal/external devices
+ *			and thus supports the device "site" attribute.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -112,6 +114,7 @@ struct bus_type {
 	struct lock_class_key lock_key;
 
 	bool need_parent_lock;
+	bool supports_site;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
@@ -246,6 +249,11 @@ bus_find_device_by_acpi_dev(struct bus_type *bus, const void *adev)
 }
 #endif
 
+static inline bool bus_supports_site(struct bus_type *bus)
+{
+	return bus && bus->supports_site;
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
