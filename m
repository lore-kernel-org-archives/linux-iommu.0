Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AABCCA488
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 01:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F0F38465D;
	Fri,  1 Jul 2022 01:27:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F0F38465D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=O1+XSLj0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w8cgO-ju0GIb; Fri,  1 Jul 2022 01:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB1588465A;
	Fri,  1 Jul 2022 01:26:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB1588465A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83FC3C002D;
	Fri,  1 Jul 2022 01:26:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2EA6C0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 01:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D0B240B59
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 01:26:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D0B240B59
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=O1+XSLj0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qsDOmdCnTEiV for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:26:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD55340931
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD55340931
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 01:26:55 +0000 (UTC)
Received: by mail-pg1-x549.google.com with SMTP id
 e18-20020a656492000000b003fa4033f9a7so484229pgv.17
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 18:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=N2ZBZX0ts4Mk2TYGZHAbQ0+iD2FAHUFhD02Oe5yw0x8=;
 b=O1+XSLj0oSVLFId1abGtsY3tm0452of7YtoG6NXZHX/e84inEivfhRvPM2mxa0YyIW
 IVE4lsrSj5BWadwFDlAWpmHnRK/doKl5AOePnDPGsAS+cA+NgfaWURouVPcfJ+UegMnP
 gFn2YJgYpdS58AkA+jg1y+IJirkP1kEzvd9LDdSLlSQ/Sq4aCkWSKEc/oTe6fZiOhW65
 BjkrHlyKrTJJXC29sJDuGTXqd5/40GhwO7WCZbDbcQB2MuJGIhtqAJ7KaIiPcGoYN1l9
 s4fr0zbsiZbvNiOgTU00jLdLs0pkeLRUFjFRS2ioFddA+CNMuoRvkffPzuaP06JwXoHV
 SNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=N2ZBZX0ts4Mk2TYGZHAbQ0+iD2FAHUFhD02Oe5yw0x8=;
 b=LXS3QDDd0bFDG/wUih20B9cuOYFV9YSO7Z5mYj65H2Maof+S9gBeXzUXnN/CvGUsbH
 Mxkz8oUPUXSKoHGgyzPjXnJ+0fLw4CDD13kuwBunjECAZIN/RjlTVe+mIisJC0wIXge/
 VMHIWINK7ddVjWDOh1gcDQ7h04WRWC8NIJSdS9hodmHReNIG1KOvDw7LzyAzuayGjX2s
 ZJS1dZ+y4O+Qoj1TegWYnkK3JngeT2urZ144ehKMW4UkR4rv0mbGXSJyjQL0Pt25ISxZ
 wzMYhDDcASG9gd9EdP0+75KeJktynaFQf0eaXa378dCorpMCL2Jzk0lmPOnZejdTcb70
 5CVg==
X-Gm-Message-State: AJIora8gUuY4nFPmqaaYBzaTYMw0o5/XBCG5+/TZEnOIuxfwECBzZLL0
 rzSMgSrq0ylle/w39x7O3dOIZMXlUBfL2vM=
X-Google-Smtp-Source: AGRyM1sj2jrR3+blrSHPqJTzLp24osPeSbuJ6WFdrG/ishciKwr2k4mXrnUZAcDZaxDsMilQN7eUGTW8uxdoZkM=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:3973:d0f0:34a8:bf61])
 (user=saravanak job=sendgmr) by 2002:a05:6a00:1995:b0:525:bca8:b062 with SMTP
 id d21-20020a056a00199500b00525bca8b062mr18860129pfl.26.1656638814784; Thu,
 30 Jun 2022 18:26:54 -0700 (PDT)
Date: Thu, 30 Jun 2022 18:26:39 -0700
In-Reply-To: <20220701012647.2007122-1-saravanak@google.com>
Message-Id: <20220701012647.2007122-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220701012647.2007122-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 1/2] driver core: Add probe_no_timeout flag for drivers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Jiri Slaby <jirislaby@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Paul Cercueil <paul@crapouillou.net>, 
 Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Tobias Klauser <tklauser@distanz.ch>, Russell King <linux@armlinux.org.uk>, 
 Vineet Gupta <vgupta@kernel.org>, Richard Genoud <richard.genoud@gmail.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Alexander Shiyan <shc_work@mail.ru>, 
 Baruch Siach <baruch@tkos.co.il>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Karol Gugala <kgugala@antmicro.com>, Mateusz Holenko <mholenko@antmicro.com>, 
 Gabriel Somlo <gsomlo@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Taichi Sugaya <sugaya.taichi@socionext.com>,
 Takao Orito <orito.takao@socionext.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <bjorn.andersson@linaro.org>, Pali Rohar <pali@kernel.org>, 
 Andreas Farber <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang7@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Hammer Hsieh <hammerh0314@gmail.com>, Peter Korsgaard <jacmet@sunsite.dk>,
 Timur Tabi <timur@kernel.org>, 
 Michal Simek <michal.simek@xilinx.com>, Saravana Kannan <saravanak@google.com>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 linux-aspeed@lists.ozlabs.org, linus walleij <linus.walleij@linaro.org>,
 ulf hansson <ulf.hansson@linaro.org>, linux-mips@vger.kernel.org,
 eric dumazet <edumazet@google.com>, pavel machek <pavel@ucw.cz>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 will deacon <will@kernel.org>, linux-stm32@st-md-mailman.stormreply.com,
 sascha hauer <sha@pengutronix.de>, Rob Herring <robh@kernel.org>,
 linux-samsung-soc@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 kevin hilman <khilman@kernel.org>, linux-serial@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, paolo abeni <pabeni@redhat.com>,
 kernel-team@android.com, len brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-actions@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-unisoc@lists.infradead.org, hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
 netdev@vger.kernel.org, david ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, heiner kallweit <hkallweit1@gmail.com>
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

This flag only needs to be set for drivers of devices that meet all the
following conditions:
- Need to probe successfully before userspace init in started
- Have optional suppliers
- Can't wait for deferred_probe_timeout to expire

fw_devlink=on uses this info, as needed, to ignore dependencies on supplier
devices that have not been added or supplier devices that don't have any
drivers.  It's still up to the driver to decide which of the missing
suppliers are optional or not.

Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
Reported-by: Sascha Hauer <sha@pengutronix.de>
Reported-by: Peng Fan <peng.fan@nxp.com>
Reported-by: Fabio Estevam <festevam@gmail.com>
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Tested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h           |  1 +
 drivers/base/core.c           |  7 +++++++
 drivers/base/dd.c             |  3 +++
 include/linux/device.h        |  7 +++++++
 include/linux/device/driver.h | 11 +++++++++++
 5 files changed, 29 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index b3a43a164dcd..149822d2086f 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -193,6 +193,7 @@ extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
 extern void fw_devlink_drivers_done(void);
+extern void fw_devlink_probe_no_timeout(void);
 
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index ccdd5b4295de..8e18904a1584 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -54,6 +54,7 @@ static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
 static bool fw_devlink_is_permissive(void);
 static bool fw_devlink_drv_reg_done;
+static bool fw_devlink_no_timeout;
 static bool fw_devlink_best_effort;
 
 /**
@@ -969,6 +970,7 @@ static void device_links_missing_supplier(struct device *dev)
 static bool dev_is_best_effort(struct device *dev)
 {
 	return (fw_devlink_best_effort && dev->can_match) ||
+		(fw_devlink_no_timeout && dev->probe_no_timeout) ||
 		(dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT));
 }
 
@@ -1688,6 +1690,11 @@ void fw_devlink_drivers_done(void)
 	device_links_write_unlock();
 }
 
+void fw_devlink_probe_no_timeout(void)
+{
+	fw_devlink_no_timeout = true;
+}
+
 /**
  * wait_for_init_devices_probe - Try to probe any device needed for init
  *
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 70f79fc71539..943b0363aaab 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -324,6 +324,8 @@ static int deferred_probe_initcall(void)
 
 	if (!IS_ENABLED(CONFIG_MODULES))
 		fw_devlink_drivers_done();
+	else
+		fw_devlink_probe_no_timeout();
 
 	/*
 	 * Trigger deferred probe again, this time we won't defer anything
@@ -734,6 +736,7 @@ static int __driver_probe_device(struct device_driver *drv, struct device *dev)
 		return -EBUSY;
 
 	dev->can_match = true;
+	dev->probe_no_timeout = drv->probe_no_timeout;
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55df0272..e6246b6cf6cf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -536,6 +536,12 @@ struct device_physical_location {
  * @can_match:	The device has matched with a driver at least once or it is in
  *		a bus (like AMBA) which can't check for matching drivers until
  *		other devices probe successfully.
+ * @probe_no_timeout: Set by driver core to indicate that this device's probe
+ *		can't wait till driver_probe_timeout expires. This information
+ *		is used by fw_devlink=on to avoid deferring the probe of this
+ *		device to wait on supplier devices that haven't been added or
+ *		probed successfully.
+ *		See also: probe_no_timeout in struct driver.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
  * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
@@ -642,6 +648,7 @@ struct device {
 	bool			of_node_reused:1;
 	bool			state_synced:1;
 	bool			can_match:1;
+	bool			probe_no_timeout:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7acaabde5396..2ce60e511504 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -55,6 +55,15 @@ enum probe_type {
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @probe_no_timeout: Set to true by drivers that bind to devices that meet all
+ *		these conditions:
+ *		- Need to probe successfully before userspace init in started
+ *		- Have optional suppliers
+ *		- Can't wait for deferred_probe_timeout to expire
+ *		fw_devlink=on uses this info, as needed, to ignore dependencies
+ *		on supplier devices that have not been added or supplier devices
+ *		that don't have any drivers. It's still up to the driver to
+ *		decide which of the missing suppliers are optional or not.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
@@ -101,6 +110,8 @@ struct device_driver {
 	const char		*mod_name;	/* used for built-in modules */
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool probe_no_timeout;
+
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
-- 
2.37.0.rc0.161.g10f37bed90-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
