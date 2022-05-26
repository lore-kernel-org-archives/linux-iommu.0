Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82565C433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B37561319;
	Thu, 26 May 2022 08:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOnCyiHRKtK3; Thu, 26 May 2022 08:16:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17BB660FF1;
	Thu, 26 May 2022 08:16:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDED4C0039;
	Thu, 26 May 2022 08:15:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D393C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83B4542551
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T0SoVXgd0yQL for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:15:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CF6B42535
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:15:57 +0000 (UTC)
Received: by mail-pf1-x449.google.com with SMTP id
 c4-20020aa79524000000b005180f331899so731719pfp.11
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=1IM3Fvbt8ArJUmTPEiiyr+pPYoVHFzyhPnAJGlSaBT4=;
 b=hAnSk3S9Qg0dtqCUypketAd2iTMRbAyagepCTA0NOJrVOCYo/te3z7FpVSX+BIFv7w
 HFcBaSe8ey43rsPOJ4EjkpljhrSmzZ1XVfIWV1DDuCsC0XNnyEb5qUDG+IdRWB1l+ul8
 1+Z/Ua4o1ESvV/9Kg1g2lrH9ViDRc2EvuOCNnW0G2m+ijHjBO1KC5Ck9UQlUnR4EKgjD
 We+nltaFfzSRtA+CLFGxgY+57TX8DeoDR4srqJYZz+sXUodRK7yMpUhoEFX98DiW0heG
 FyUxGgvp4/hgqLihCcZx8cKb4bTu089o4kruA0ivqPzW49fGKGvzAR3Epx0sWNWjAIVq
 1iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=1IM3Fvbt8ArJUmTPEiiyr+pPYoVHFzyhPnAJGlSaBT4=;
 b=NFC9x2NVCYuXuZn4qyyePMsxAiqgW2DMA+pbB8nwnp0YKm2E053GyJUYZtKFcUql7p
 W8frHP1aJvjwiJaWzt55yzsWg/7i6ZIUYibhg89ZRP6eg6ueCm0CbVO0/C+xtCnIJdlL
 xxlNwf0VrknjTbfyhXcI0KF+BCy4mDQA5LfDmCkY73Qz2kGCJj5E2QLGdhrAuf4Lr5iz
 dGN5zFD7wpoie66E7HXhw0jax9jb682yn7MpodrAI7r4yv7LFXmN1pJnTc9d5pO23Fyp
 dRm3MFAlwTF/2kC1MYCAgXoRw4Duk+KlyWUKPGJjajIDznrfGKdRwZPo87UmAHC3FmCc
 4U7w==
X-Gm-Message-State: AOAM533YF5if0f0mtQOFsDnY+QuIf5trtY3di0bzNZRYw9BDEDiSN7w9
 zdpfr7sOhuwcCnaExc+lrslPEE010L615e0=
X-Google-Smtp-Source: ABdhPJymfPGXL/xfcU37VydiB6tPwHU4G2U1fbHUW+y/HyW7OlytTUy4MZTLFHGyXEorOunFh2vZDJQB7oQgrz0=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a17:902:ecd1:b0:163:6120:563c with SMTP
 id a17-20020a170902ecd100b001636120563cmr5819104plh.90.1653552956872; Thu, 26
 May 2022 01:15:56 -0700 (PDT)
Date: Thu, 26 May 2022 01:15:40 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 1/9] PM: domains: Delete usage of
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

Now that fw_devlink=on by default and fw_devlink supports
"power-domains" property, the execution will never get to the point
where driver_deferred_probe_check_state() is called before the supplier
has probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 739e52cd4aba..3e86772d5fac 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return driver_deferred_probe_check_state(base_dev);
+		return -ENODEV;
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
