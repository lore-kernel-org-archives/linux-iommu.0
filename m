Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4561C433F5
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A00DD845BF;
	Thu, 26 May 2022 08:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2_3-prBTrHwd; Thu, 26 May 2022 08:16:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 92B7184591;
	Thu, 26 May 2022 08:16:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D608C0039;
	Thu, 26 May 2022 08:16:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF982C0039
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B631484592
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ptw-oqTXSxNk for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:16:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E7D58458F
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:03 +0000 (UTC)
Received: by mail-pg1-x54a.google.com with SMTP id
 e1-20020a656781000000b003f9d9fa2ce4so527951pgr.21
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=DUCLIv3fIFZkN4IwkAbrdxyKeVczdAPuMH/CpPcV4SU=;
 b=CyzwtSa5kL7asxlJAQxy6KynJEIdFhvGau0g94npATBUb08mCN7xWPYiqWSpgyW7pp
 AeKTLb8s+1yIbjcvPRGqkRXa/d5TFin/hQLWeMaJAETlo6oYW5f14ntDOqjhIvmFKH7Y
 to71h+gy1/+mvnPHDbGWIsuAvvkUo1tnVwOwiNBYAz/Th1IFA4cu6ZOpIDrj4HrVUFgZ
 8TxgahJGhhjYVYLYmfpUFt435KgFpIWHwyX3O6yL6OwYx2jNmvoxtX57zkKnPlBhHjOv
 6ap3F7Gzmj4ck2T+A1f3T4XMo/l1Sr7ClNm8Ko3J8AHf9Vnb1FGRV7j+BHxzraC/ZahT
 26MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DUCLIv3fIFZkN4IwkAbrdxyKeVczdAPuMH/CpPcV4SU=;
 b=mGQyBviqJnG3vnldOg1TT7N/5PRaZzPK3SXaGBPMp0nIORS6uh9RHTnJFhTV13ZThx
 6/08HV7hVD+WMpGvKANnCt5dWObH+gHnsF/h370wAx1MZlhlj32FwhoBISGy3lhZUDiz
 nvyUw64z4Ve34TRBXPpxR6RE8ejz2DkE3EqRRJdzh27vBjf1/OQsHBAq5HqdLACDiz1s
 8JlzlnhwT/sxBKw2xTScg+3kAijZ1l+3hXGU0loCoVUPI3FJiqRn/nJw9vlohDrM2xZa
 Lxfcn9WEy8qubWBVl+bN+wJKH29ja98YcTuEbZ0HorknG64E9ugCvHND7VSpxa6UXaPG
 mP5A==
X-Gm-Message-State: AOAM530FmSjgQhlfHyZtrOHFspYbeVF9dZXdX193ePL+YjCk3rtROHJE
 UGWdEwQIQDBEsWDSa+QcQt4mp1KvCEt6I4c=
X-Google-Smtp-Source: ABdhPJw2pOLycSo0Dk2hnHYGrYjnmnj9FmTbJXx5Eil6VtjWJt3Y4OCof/7QvyjmXMAMae1GQK5aRzIjQ2vExSg=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a63:343:0:b0:3f6:52e5:edbe with SMTP id
 64-20020a630343000000b003f652e5edbemr29501334pgd.272.1653552962496; Thu, 26
 May 2022 01:16:02 -0700 (PDT)
Date: Thu, 26 May 2022 01:15:42 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-4-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 3/9] net: mdio: Delete usage of
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

Now that fw_devlink=on by default and fw_devlink supports interrupt
properties, the execution will never get to the point where
driver_deferred_probe_check_state() is called before the supplier has
probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/net/mdio/fwnode_mdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 1c1584fca632..3e79c2c51929 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -47,9 +47,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 	 * just fall back to poll mode
 	 */
 	if (rc == -EPROBE_DEFER)
-		rc = driver_deferred_probe_check_state(&phy->mdio.dev);
-	if (rc == -EPROBE_DEFER)
-		return rc;
+		rc = -ENODEV;
 
 	if (rc > 0) {
 		phy->irq = rc;
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
