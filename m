Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCEAC433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00C1041171;
	Thu, 26 May 2022 08:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k7ponrgyMnWO; Thu, 26 May 2022 08:16:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E994541172;
	Thu, 26 May 2022 08:16:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA674C0039;
	Thu, 26 May 2022 08:16:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A587C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 786F841172
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ci9ThNLtEPjQ for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:16:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2C5B41171
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:16:05 +0000 (UTC)
Received: by mail-pl1-x64a.google.com with SMTP id
 h13-20020a170902f70d00b0015f4cc5d19aso722761plo.18
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=BAxCptwO7y2xVPn5yxfUXuZaiLDAgG5VdQuxNau2t/A=;
 b=SSAklAtF5M2MvdVlYodbyAxTphyyK02Oj42SVcd3FTLXmUoOWmKohwP0jyuy7Dywnn
 z+Rwg5B5m390JADA/tH9Kd5hrRor7L7xc2HarYOOY1eeh0X5ooFq6gop9u+FKPEH68sX
 PSmyWhcvNVI+KSAsfLsiJwAoZy4hoOLroAWm7/PcoZRZ5RRn7c5QPkSzY4al45bC9y1m
 rxt4J+H9awRoebh/t2rs9NdCgcDLPVKf5pbTahtHh4OEILiQvhD1Izdrf/nBW5LrZ6Hr
 cCTqNUjkmGwlDPIsIOZy6KsBLIleiDr0kGVZMU24uQyWpnq1xNF84jdZo+Qvww3Nq5FM
 6uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=BAxCptwO7y2xVPn5yxfUXuZaiLDAgG5VdQuxNau2t/A=;
 b=R32F3fq8/18YoaYMLYiNrXNnRFKRO2HBDUT+Sys5nCV/hV5CQSYGO3rlolmAIjrv6i
 SmqdAiYKf7NPaaTpci8X+fkJvx/sP6Hps5ZknrLlpARMIlV9Bwd1+XYo7/hkN6a/pl92
 jprqYOJz0XMNVk0h2TtkpOeRBWygX8gHeMmuld09IeBCGmJJpqqWBwBD7my6Zkl9Df2M
 wWn//G413Bb9435202V9PJUw7waVQTAV3+yqxAFbZ/vrxH7x/WOGliIy/931kQ3x3Jej
 dNAPr3ZQjO/FuIxZ3WgbYuQc4iLtAWOXoJm12h45WQmbtWh3RRyyaEYbGOwUgkF8sXiv
 S0ww==
X-Gm-Message-State: AOAM530Tq4KXH7b27x26JYgzqpLnlLj2DpJGvv3cmsNXPe9fiR2h5sze
 Y1OpwjM+at3NYwBhatHZaXVdDECKtvfSLH4=
X-Google-Smtp-Source: ABdhPJz4snZQEDVmZXj6RODHXR7rp3pbTlyyKgm6WM3ongSTDnEvvxBi0qJKrzgY36D1YxzBeGXt+A93QwpkuHs=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a17:902:b58f:b0:15e:b2f4:b75 with SMTP
 id a15-20020a170902b58f00b0015eb2f40b75mr37115965pls.25.1653552965291; Thu,
 26 May 2022 01:16:05 -0700 (PDT)
Date: Thu, 26 May 2022 01:15:43 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-5-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 4/9] Revert "driver core: Set default
 deferred_probe_timeout back to 0."
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

This reverts commit 11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61.

Let's take another shot at getting deferred_probe_timeout=10 to work.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 11b0fb6414d3..f963d9010d7f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -256,7 +256,12 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
+#ifdef CONFIG_MODULES
+int driver_deferred_probe_timeout = 10;
+#else
 int driver_deferred_probe_timeout;
+#endif
+
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
 
 static int __init deferred_probe_timeout_setup(char *str)
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
