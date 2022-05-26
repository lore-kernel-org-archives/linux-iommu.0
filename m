Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36166C433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC4FB4255C;
	Thu, 26 May 2022 08:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NxeD4TQR90Yi; Thu, 26 May 2022 08:16:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EB304255A;
	Thu, 26 May 2022 08:16:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68260C0039;
	Thu, 26 May 2022 08:16:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2123CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CBE842561
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HEm3rLaOHrI8 for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:16:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E1B44255F
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:18 +0000 (UTC)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-2ff3eeb2dfbso7619137b3.4
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=6dgEjD+4R2dKDRgscs/xv70YgyhfXrRwkUylnVTphfk=;
 b=XL1eUaOAcssMtqvMAb2JLoXAqGRiBPWRpPBJh6rTDvytgReAH+LjXHDFnDZXS9f9I2
 35g3JMRGxQZlCvxOhWMcOSoY7fmD/fBdQK3AfpTe4+KDVzo3ISAmWs2bpcJGBQMEHxn2
 XOrBvHACbTqtONiyNPB/vydyMzterA8qUwVfxsEqd+Vz+8qcEbmdk9FVpwyv4JToLFBL
 EPR58mdlFaKlltO8fCr0xZCvNvm+F4UFw5xJYUT6ue5rms9F3TPGMAGF7HdiGvNufzye
 R8r2YJjaY8RuLAuVFWX7SLMYTTkhhepWRDKwQDGC55z4gixqwa9JauWCwnOhgDgX/TTb
 SoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=6dgEjD+4R2dKDRgscs/xv70YgyhfXrRwkUylnVTphfk=;
 b=C5jwvNftExV+QNRGDEnjZesihToxMEphrEW+AmjmiwT0yLU2xGw9cykRC1xN7+RuNT
 wtGa7mv7xcdGdiOR0/4e2hRI9UQjCRAMCZkFt69BKZSuzjWveAnP/tpzQsA25336W9hB
 1CvXMdn3Wavnbw0VV5p1RlUaNWF8Ws9PZ27OakH9Y0lxiqBPtpcWNcVw0FtZp8TlMFbA
 4hngwaj9rvYKYPVaee2ezvEgb0pWJBL5cgkpg5ehVy9e6fSG3liBq8v+8nlM3YQ+nHNO
 if+WJO2Gt8uBnHtzaUfPcQ1xlJXfgSbssWeEBvqWUIocGa7DiFdoj/Wkp69EKcCy+YVr
 vOQg==
X-Gm-Message-State: AOAM531Qot+cOJPVQCOLVOtmbGA+wjScyRJi/0XUBXkmzPa3AYHz39rA
 mBVgH6UisdT9z54ilzEGg5JucaauzFy84AU=
X-Google-Smtp-Source: ABdhPJx5hTzSS2LFu7RkqlQ7KLRzxV0Py+PZHVG9x+dcAcINC/1HXYTnTXlf9OdhjLu3DXMEHDG7SkiPohYReIE=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a25:fb12:0:b0:64d:d6fb:406a with SMTP id
 j18-20020a25fb12000000b0064dd6fb406amr34790013ybe.433.1653552977155; Thu, 26
 May 2022 01:16:17 -0700 (PDT)
Date: Thu, 26 May 2022 01:15:47 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-9-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 8/9] net: ipconfig: Force fw_devlink to unblock any
 devices that might probe
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

If there are network devices that could probe without some of their
suppliers probing and those network devices are needed for IP auto
config to work, then fw_devlink=on might break that usecase by blocking
the network devices from probing by the time IP auto config starts.

So, when IP auto config is enabled, make sure fw_devlink doesn't block
the probing of any device that has a driver by the time we get to IP
auto config.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 net/ipv4/ipconfig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 9d41d5d5cd1e..aa7b8ba68ca6 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1435,6 +1435,8 @@ static int __init wait_for_devices(void)
 {
 	int i;
 
+	fw_devlink_unblock_may_probe();
+
 	for (i = 0; i < DEVICE_WAIT_MAX; i++) {
 		struct net_device *dev;
 		int found = 0;
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
