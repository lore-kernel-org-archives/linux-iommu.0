Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090DCC433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C12E9845C3;
	Thu, 26 May 2022 08:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nAXKj1RopEzq; Thu, 26 May 2022 08:16:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2B79845BC;
	Thu, 26 May 2022 08:16:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E5B1C0039;
	Thu, 26 May 2022 08:16:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31900C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 113464255A
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jv1kTZOQQyxZ for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:16:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E88A42531
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:21 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 i4-20020a17090a718400b001e09f0af976so769309pjk.9
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=2cafqgyvMaG8pnmb2DwUPLH+NwqexHFaoGplVLqjY6c=;
 b=Qhvec8EM5waM3couwB4Dum8OsNReKnA1EIAEV8LpsepiAu+NTnpIDd6zPzvaScyoHi
 joLxHL0NnhEkyS300O8xI9N1fgEmoiNW+tHhgRg+C3VgA1m7nuIAVZgpAAN0SCoZaXb3
 HEB/SDIh21LxIk12AKALJ8PaTt3HoxW0TucqgFk8I+2nWe8sV+SOqE/1qyqqfeteZr3g
 EufhH6H9hKX80HxUrjS4SaCSZY+0yU4qfhVpbOF9hKztCUUvRR36MTpKRlzF3fXGT8kL
 xXPgN+vDeTbaZIcJj1bpAuXYJV78EUX8wvpAl/KOGx8ob/jDmnzqVjFH+adTvCIPzWq4
 hKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=2cafqgyvMaG8pnmb2DwUPLH+NwqexHFaoGplVLqjY6c=;
 b=fYvllG0HDPJu4t+wzy3jXggewplhe8A0+DHGZu8WOczFJq36cgjHDLaXi5IxvZRlM6
 O2e3gQ0/vNcQwsO3YhrBC3DT0Mw0KrajHdzbIjez4X4TGrsTDDk5npya9LmlT+Ea2dMf
 VDTytRKEs6QtCUGXroHLjWVNZiy6ZmuKGpJjPkuyDvgA0gAk7Ji6XDTqjEHG9uBMyLpz
 pFS3VbYIHJnm4VXHyk/u4Op2uGdUDAlFQQQb/BmFP+2W3FNEg6P4gVqmFBDPek4it1gu
 QJkbnBUkwky3QWYcEs523tj+QbE8U0UXJdA/HKyhZLGEGqLU5xoDj3ip9LUg7dp/m16n
 OhwQ==
X-Gm-Message-State: AOAM5319TyHXBl2TUP1QbUiX6K0BWPLvselqhZlZkU9GljHShMEFHAJZ
 pb/4MiY0RKAIaBAPyttus4bYLxRzfPpv4A8=
X-Google-Smtp-Source: ABdhPJyinReesiUqDbMmyw2id5J+MedifDe6OonBttcETpmdQGcuAvMkhqslxCFm255z4G73O9ROU101o9oWZy4=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a17:902:7004:b0:161:f216:4f3f with SMTP
 id y4-20020a170902700400b00161f2164f3fmr30173525plk.98.1653552980455; Thu, 26
 May 2022 01:16:20 -0700 (PDT)
Date: Thu, 26 May 2022 01:15:48 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-10-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 9/9] driver core: Delete
 driver_deferred_probe_check_state()
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
 David Ahern <dsahern@kernel.org>
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

The function is no longer used. So delete it.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c             | 30 ------------------------------
 include/linux/device/driver.h |  1 -
 2 files changed, 31 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index af8138d44e6c..789b0871dc45 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -274,42 +274,12 @@ static int __init deferred_probe_timeout_setup(char *str)
 }
 __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 
-/**
- * driver_deferred_probe_check_state() - Check deferred probe state
- * @dev: device to check
- *
- * Return:
- * * -ENODEV if initcalls have completed and modules are disabled.
- * * -ETIMEDOUT if the deferred probe timeout was set and has expired
- *   and modules are enabled.
- * * -EPROBE_DEFER in other cases.
- *
- * Drivers or subsystems can opt-in to calling this function instead of directly
- * returning -EPROBE_DEFER.
- */
-int driver_deferred_probe_check_state(struct device *dev)
-{
-	if (!IS_ENABLED(CONFIG_MODULES) && initcalls_done) {
-		dev_warn(dev, "ignoring dependency for device, assuming no driver\n");
-		return -ENODEV;
-	}
-
-	if (!driver_deferred_probe_timeout && initcalls_done) {
-		dev_warn(dev, "deferred probe timeout, ignoring dependency\n");
-		return -ETIMEDOUT;
-	}
-
-	return -EPROBE_DEFER;
-}
-EXPORT_SYMBOL_GPL(driver_deferred_probe_check_state);
-
 static void deferred_probe_timeout_work_func(struct work_struct *work)
 {
 	struct device_private *p;
 
 	fw_devlink_drivers_done();
 
-	driver_deferred_probe_timeout = 0;
 	driver_deferred_probe_trigger();
 	flush_work(&deferred_probe_work);
 
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 700453017e1c..7c245d269feb 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -241,7 +241,6 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
 
 extern int driver_deferred_probe_timeout;
 void driver_deferred_probe_add(struct device *dev);
-int driver_deferred_probe_check_state(struct device *dev);
 void driver_init(void);
 
 /**
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
