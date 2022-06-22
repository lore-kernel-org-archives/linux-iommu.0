Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73770C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 21:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 012EC83EE8;
	Wed, 22 Jun 2022 21:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 012EC83EE8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=JuE5h9PD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fhsmuO9cizM; Wed, 22 Jun 2022 21:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA94C81BFA;
	Wed, 22 Jun 2022 21:59:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA94C81BFA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83E4FC0032;
	Wed, 22 Jun 2022 21:59:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34171C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 21:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F33B826A8
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 21:59:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F33B826A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2bqfOOpVALDr for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 21:59:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47D0181CA3
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47D0181CA3
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 21:59:21 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id
 d67-20020a251d46000000b006694b8ea9f2so5779009ybd.9
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=TSYl2OnOPgIUVM0FnB5YWNZt0eip9Aey9fKvGeEIZ6c=;
 b=JuE5h9PD/539bkLCq5oHJhFDYzn1+YXoF+StWjq3SnT0H3RGIb3TdrcC6p2RLeJH3R
 bTIkxwMMK0AiiTTVWJr1bnvrB7sBe9i/YUJdVTUH8qCKJ6CBcy1T2AWoZC86vVyizDWt
 oGTf9T9Yk+Q1+GAdEjZWRFbG7dcw+Il6FZRB0YrQPlamrfx8M/FzcnHMkQsb8QcICNuF
 xzcttoR+dnJQmlgVy6prUYYejJtZ/WT42YW3hnr93OrR/Q5Ta/bi8BEVNuipIYaI5OO4
 8TmehohCKJnlYSQ3X9idRWuSjlYJiiVtcPtrwZ5dzjZpzQj1Q8FzEj9aHCcNtsFaA+uN
 zAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=TSYl2OnOPgIUVM0FnB5YWNZt0eip9Aey9fKvGeEIZ6c=;
 b=wAfhyAW2Xs6k+tNOMMxoDZUknXw9UuteOcQeEPd80uZoaAqdX+2uq81Cq01c5H5k5h
 th6mHc+G6mV1VwrfB+Oq2bwjTkV8bIVWP5h6WSFdgMR1crltQatGHzj5QgJWH/Nk2ujv
 mOeMpWi08BY2NZJhKMnAu3s6S1EO5z/46OJhyB7eR0OLlY/ct2nCrcrPcH5W6PTFo/sm
 NvLrqIeofZpH5L4TdCrnyu8lY6aXc6VMJyLqOasRZkbFOCrprxHtHMH0uda1R1W7t1f0
 WtRI63K5glxvh3NzvOpV3mjdpl2XKSCMqjN+864sompQ3o2XJ58fdwOFVRXWv7l6FPbl
 lnwQ==
X-Gm-Message-State: AJIora97AjH3DWTorOD9gj82c8QtV5Tb3oaCcBSaNGGUG1KWhJNiw01y
 Z7Iq/NTd8v45LUnonY4hCqzlz5JVuGbKtcc=
X-Google-Smtp-Source: AGRyM1u/ogeLy4+AFU9N+Uu+j4V9K9r4kJbRFsYGWYib4JKBkDIXDu12JK70RoVFkDx+eINHtoU6HV2JImNGlxs=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:be1f:89ac:a37d:6bb4])
 (user=saravanak job=sendgmr) by 2002:a81:ff08:0:b0:317:7e90:8910 with SMTP id
 k8-20020a81ff08000000b003177e908910mr6784104ywn.417.1655935160200; Wed, 22
 Jun 2022 14:59:20 -0700 (PDT)
Date: Wed, 22 Jun 2022 14:59:10 -0700
In-Reply-To: <20220622215912.550419-1-saravanak@google.com>
Message-Id: <20220622215912.550419-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220622215912.550419-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v1 1/2] driver core: fw_devlink: Allow firmware to mark
 devices as best effort
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Peng Fan <peng.fan@nxp.com>,
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Sascha Hauer <sha@pengutronix.de>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel@pengutronix.de,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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

When firmware sets the FWNODE_FLAG_BEST_EFFORT flag for a fwnode,
fw_devlink will do a best effort ordering for that device where it'll
only enforce the probe/suspend/resume ordering of that device with
suppliers that have drivers. The driver of that device can then decide
if it wants to defer probe or probe without the suppliers.

This will be useful for avoid probe delays of the console device that
were caused by commit 71066545b48e ("driver core: Set
fw_devlink.strict=1 by default").

Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
Reported-by: Sascha Hauer <sha@pengutronix.de>
Reported-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 3 ++-
 include/linux/fwnode.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 839f64485a55..61edd18b7bf3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -968,7 +968,8 @@ static void device_links_missing_supplier(struct device *dev)
 
 static bool dev_is_best_effort(struct device *dev)
 {
-	return fw_devlink_best_effort && dev->can_match;
+	return (fw_devlink_best_effort && dev->can_match) ||
+		dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT;
 }
 
 /**
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9a81c4410b9f..89b9bdfca925 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -27,11 +27,15 @@ struct device;
  *			     driver needs its child devices to be bound with
  *			     their respective drivers as soon as they are
  *			     added.
+ * BEST_EFFORT: The fwnode/device needs to probe early and might be missing some
+ *		suppliers. Only enforce ordering with suppliers that have
+ *		drivers.
  */
 #define FWNODE_FLAG_LINKS_ADDED			BIT(0)
 #define FWNODE_FLAG_NOT_DEVICE			BIT(1)
 #define FWNODE_FLAG_INITIALIZED			BIT(2)
 #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
+#define FWNODE_FLAG_BEST_EFFORT			BIT(4)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
-- 
2.37.0.rc0.161.g10f37bed90-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
