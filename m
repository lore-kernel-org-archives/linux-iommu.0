Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFCBC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 22:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BADB861204;
	Fri, 29 Apr 2022 22:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O72voZ5MmN6Y; Fri, 29 Apr 2022 22:09:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44F37611A5;
	Fri, 29 Apr 2022 22:09:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFC5C0032;
	Fri, 29 Apr 2022 22:09:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E580EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 22:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDE7441C5A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 22:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4IqScjA6Zcwf for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 22:09:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F61B41C58
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 22:09:38 +0000 (UTC)
Received: by mail-yb1-xb49.google.com with SMTP id
 z15-20020a25bb0f000000b00613388c7d99so8570768ybg.8
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=hKM9bITdw0PGb2XwX81mFD9iQzTpEY1OKJb9nL2wmVM=;
 b=OoLk1SvFv/jTJtrMYW0SOQyQRGCBGpFgc/vEoNllR1AaKSyYPbAn38fZE7kG1JaLNw
 sexAk7BDkPLMod8qlp9KvRVu4XZVkwoG6sot1ziSm12s8n1f0lWwP3pd4NZO9hDjSCIo
 n4EVt4n/T4i6LWzvHIC5efT4Il77PiWFZq+vsVus4b88F/GLYaYnxrTF2BhYrTHjVvyZ
 YJSlHx/76rMlgL8unw+vVcNr0SJeZky16wGNg4m9e30BDCrhD2L42ccHx+nJLraDz9Cv
 QE7K62V9FK7wicbv99MdhKS9km/Q3/YCc5Tw9pA87iGWFI/wHo6va2SanzKXtugCTKxa
 BOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=hKM9bITdw0PGb2XwX81mFD9iQzTpEY1OKJb9nL2wmVM=;
 b=XijMC/Yrk/p+ZpSuIhNZ8m2titaCu1t4ohumbbBogOqQf5bXP928g0QvzMYiAqzqjr
 GmRRmF7Jz3hoPkShjNY34hc++ADnAondRZ2DvdcApfEm0vLWLfckFS7hbtoEvz9H96yd
 jXioUWrnI7rY6HE3lKURFOgjtCI6EmQd+te/3LXpvT+7u4pYUndQACN5BpXkrexBhdus
 1eSdXLgc2VlHn9UcYyuJoqegmUjLeM+rcXQbknr94I4YRINJcdDFyNtIILoxZSlR3N8z
 eL7BW/bZWoAnkezV/RJvBsO1uviDF/oRN4bxuhzxl8V59jfeX7h956jePNUlceVcgoiC
 J7yw==
X-Gm-Message-State: AOAM5337RdNfdOEc3eSd4BfOLteg1uWAeUs3GYwq7Et/FK1T/YJdMhc0
 LAK3OdGELWPtt0+eEZvJprdKvaiViw6dqWA=
X-Google-Smtp-Source: ABdhPJwkaqvpwIOQfXloIgXrKBqVrkXz9dU2lTi8+9Th0do7w1YPgiKZjeu5emN11KLpq4+CmhlxSMcUnqAj3JA=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:52dc:281f:8619:9d36])
 (user=saravanak job=sendgmr) by 2002:a81:b88:0:b0:2f7:ccdd:642f with SMTP id
 130-20020a810b88000000b002f7ccdd642fmr1475417ywl.303.1651270177291; Fri, 29
 Apr 2022 15:09:37 -0700 (PDT)
Date: Fri, 29 Apr 2022 15:09:32 -0700
Message-Id: <20220429220933.1350374-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
To: Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-doc@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
 Kevin Hilman <khilman@kernel.org>, kernel-team@android.com,
 Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Pavel Machek <pavel@ucw.cz>,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>
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

The deferred probe timer that's used for this currently starts at
late_initcall and runs for driver_deferred_probe_timeout seconds. The
assumption being that all available drivers would be loaded and
registered before the timer expires. This means, the
driver_deferred_probe_timeout has to be pretty large for it to cover the
worst case. But if we set the default value for it to cover the worst
case, it would significantly slow down the average case. For this
reason, the default value is set to 0.

Also, with CONFIG_MODULES=y and the current default values of
driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
drivers will cause their consumer devices to always defer their probes.
This is because device links created by fw_devlink defer the probe even
before the consumer driver's probe() is called.

Instead of a fixed timeout, if we extend an unexpired deferred probe
timer on every successful driver registration, with the expectation more
modules would be loaded in the near future, then the default value of
driver_deferred_probe_timeout only needs to be as long as the worst case
time difference between two consecutive module loads.

So let's implement that and set the default value to 10 seconds when
CONFIG_MODULES=y.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++--
 drivers/base/base.h                           |  1 +
 drivers/base/dd.c                             | 19 +++++++++++++++++++
 drivers/base/driver.c                         |  1 +
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7123524a86b8..fcc1dfc877a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -939,8 +939,10 @@
 			[KNL] Debugging option to set a timeout in seconds for
 			deferred probe to give up waiting on dependencies to
 			probe. Only specific dependencies (subsystems or
-			drivers) that have opted in will be ignored. A timeout of 0
-			will timeout at the end of initcalls. This option will also
+			drivers) that have opted in will be ignored. A timeout
+			of 0 will timeout at the end of initcalls. If the time
+			out hasn't expired, it'll be restarted by each
+			successful driver registration. This option will also
 			dump out devices still on the deferred probe list after
 			retrying.
 
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 2882af26392a..ab71403d102f 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -159,6 +159,7 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
+extern void deferred_probe_extend_timeout(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f47cab21430f..603379b5f9dd 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -255,7 +255,12 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
+#ifdef CONFIG_MODULES
+int driver_deferred_probe_timeout = 10;
+#else
 int driver_deferred_probe_timeout;
+#endif
+
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
 static DECLARE_WAIT_QUEUE_HEAD(probe_timeout_waitqueue);
 
@@ -315,6 +320,20 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
+void deferred_probe_extend_timeout(void)
+{
+	/*
+	 * If the work hasn't been queued yet or if the work expired, don't
+	 * start a new one.
+	 */
+	if (cancel_delayed_work(&deferred_probe_timeout_work)) {
+		schedule_delayed_work(&deferred_probe_timeout_work,
+				driver_deferred_probe_timeout * HZ);
+		pr_debug("Extended deferred probe timeout by %d secs\n",
+					driver_deferred_probe_timeout);
+	}
+}
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 8c0d33e182fd..77a77b2095cd 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -177,6 +177,7 @@ int driver_register(struct device_driver *drv)
 		return ret;
 	}
 	kobject_uevent(&drv->p->kobj, KOBJ_ADD);
+	deferred_probe_extend_timeout();
 
 	return ret;
 }
-- 
2.36.0.464.gb9c8b46e94-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
