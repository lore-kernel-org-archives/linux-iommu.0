Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9689DC433F5
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53F5D61319;
	Thu, 26 May 2022 08:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9yIE_msRdpol; Thu, 26 May 2022 08:16:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 469106130D;
	Thu, 26 May 2022 08:16:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ADF4C0039;
	Thu, 26 May 2022 08:16:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88C91C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84D2184591
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UKz7H8sn8tEw for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:16:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E35528458F
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:00 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id
 s127-20020a252c85000000b0065386279888so1033388ybs.3
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=dlvkAQYsuGB8Wv9lxWmQ5ia/pAj0723lrMJL/F7FmGY=;
 b=PY2a/ZfTWLOTKMXKyETU+koM0WgQW4QxqX3sYrgc5F8Fync7J+e5f3GBKiPIqpwgPZ
 SkDAVoB1jl7cjlSJwUihxgqBvVZnvCxi9I4QUaG5WqMu1pOMKtmDRTxpQFAeblPdDleX
 mxDvzcfuqk3TE1tsWfuNrUDu6y3Z2uQsLnSOUjywddi7iE0G0uqUtlpP3c2Gm0KnZoNS
 dnyI/ZOgNUHpkp0mB2EIPEiSrxIsj2RY5G5poVzBbXn9Rg97rrWC6Adibg/wQrj3n2xT
 kI+LY0Yk8J7Hl0wWscTOZw/YR4+r0mDtAk/VmmToHBZWaKhAHd+W02rgl8RuAea8avYR
 u8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=dlvkAQYsuGB8Wv9lxWmQ5ia/pAj0723lrMJL/F7FmGY=;
 b=kdKV5iJz72/XyaiZypw5xPgMVFBC+zopNBeZS/45dWA/jhggiedvrEMFTKHT3S2sG+
 990O25isWGmdDlm/MgcSkEHI2lkOOmChjmfw0UwXn0UpFCNj1L7KYkfSBuDcbdkAbYHz
 q718Gb738va4yyRIUC2/5Py2ZBBxdsdetYqWfdvSlXc2tzCiGE7xdi/3Xn1Lwe+zQE6F
 zccZvgs9sPOc6W5KnjCP7hvWuAwq2uuXFXBAWRVpr9X7xanU8AKnHqoD46gqbAbiRiNO
 mB+fidm5xyUXDGdIv1QmMOzRJc/ymPbt1BIsSV1L1nhZElWnLpTls+F4e3lL2kfH4Osk
 91Bg==
X-Gm-Message-State: AOAM533BVAnnsvTACWQlNX8g4HHe/cZHOTnGzBW0VLme7xx1KgzS7yQ/
 9EYKrkcDix1WJJblXHknWGdGLosA6T40XsE=
X-Google-Smtp-Source: ABdhPJxNRFl0/Al5aF4+hw2juEzzxnRNoJ08VAGxc9iz3rkpIotBWNb9jqq9kR5GKz6VAnObadTZe+xq9PgYyao=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a81:4757:0:b0:2ff:d34d:4d59 with SMTP id
 u84-20020a814757000000b002ffd34d4d59mr20437021ywa.511.1653552959732; Thu, 26
 May 2022 01:15:59 -0700 (PDT)
Date: Thu, 26 May 2022 01:15:41 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-3-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 2/9] pinctrl: devicetree: Delete usage of
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
"pinctrl-[0-8]" property, the execution will never get to the point
where driver_deferred_probe_check_state() is called before the supplier
has probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/pinctrl/devicetree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 3fb238714718..ef898ee8ca6b 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -129,7 +129,7 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
 			of_node_put(np_pctldev);
-			ret = driver_deferred_probe_check_state(p->dev);
+			ret = -ENODEV;
 			/* keep deferring if modules are enabled */
 			if (IS_ENABLED(CONFIG_MODULES) && !allow_default && ret < 0)
 				ret = -EPROBE_DEFER;
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
