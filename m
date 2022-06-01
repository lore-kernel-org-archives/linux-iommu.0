Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538E7C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 07:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D48041499;
	Wed,  1 Jun 2022 07:07:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTrG4zK7zvZN; Wed,  1 Jun 2022 07:07:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC2A1409A8;
	Wed,  1 Jun 2022 07:07:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A559FC0039;
	Wed,  1 Jun 2022 07:07:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4810DC002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27E1660E07
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rKEyYAHu_tLp for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 07:07:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0582860AA3
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:32 +0000 (UTC)
Received: by mail-pj1-x104a.google.com with SMTP id
 oa7-20020a17090b1bc700b001e2f6da29e6so3161359pjb.4
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=OkJpVuwUYhbhpu72ndfOfRLuS01Uvu7J1G58GhOqBxA=;
 b=kaB7C37gink8Qqvn0pctcjGVSWc9j4P8uk4v0K5AISpFKd+hvgB21RJZ41FYYZ2nfP
 UmDUvnh6V+KzZKv5WfvINI9HLMdh7n8ba4XuzBpJy5rHK6bp1b1kDpTMg0ATRjp6Lwj2
 oUK95Il9GYfC6gvX6T78R/PvRyeHepeWwdbNNm5Sr2T0TFGbeSJTp2JBkr1gp4mduXVA
 lkarklZizZ86HZBwymU9R99XtDoe9UgMCyo+4bRGBaY/9hFYylTp4hF/BbGcx22jCbiY
 nO8hfl2g+kKIMmRXfosATkgzY9XsxdnlNlEw7i2848Bd9uWVHMGW1ZotBwpbu0+owPb3
 dOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=OkJpVuwUYhbhpu72ndfOfRLuS01Uvu7J1G58GhOqBxA=;
 b=sRMkUvvEDtaDlZ7vav4WhWLxnsuQlQmhdhW0+I3KcU88E6fzy2mD3PGRpYLBnc0sUz
 YHfUGRUFA1aPbZL4UMX9Xp+hds6gQ5PMcSYm1hSQ3p7AgFFJwxUnw3+w4Exb3B1C2vEW
 chVFreBL4b7tFIKrD8jGInlHsKGSJZnll+HDMqls2EfEe5ymkjii7TDz6Zb2GHGM8rvY
 zV2ouMVSXUK2Jz3sh/l4QR7lWHghZ3iSEqR7P/qsOcirIosBT8EiDMCqVWeqJwFPk40s
 z97skHAbs8PtLnV1d/v7yOJq3eThixvgQk+5uXOJ1Nt6uqvAQafSYXcGTbg+GSwNSruW
 ymOQ==
X-Gm-Message-State: AOAM533G804gm6gzYekJNGJqWHC84FVFCvXeqT8m6lm2hqnGrfLpCqqb
 w79lB4meBmexdHlX2AaN5oGG2TVztnQNum0=
X-Google-Smtp-Source: ABdhPJztwlN85cyj2vBepMijcpN5dd/hOJ41SzfRJZ6qCQvnaOveLbdas5N5VokZNsF3pp0hEJdTKPs546XcksM=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a17:90b:3c4e:b0:1e3:36c8:8496 with SMTP
 id pm14-20020a17090b3c4e00b001e336c88496mr7944623pjb.82.1654067252323; Wed,
 01 Jun 2022 00:07:32 -0700 (PDT)
Date: Wed,  1 Jun 2022 00:07:03 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-8-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 7/9] driver core: Set fw_devlink.strict=1 by default
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, 
 David Ahern <dsahern@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com
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

Now that deferred_probe_timeout is non-zero by default, fw_devlink will
never permanently block the probing of devices. It'll try its best to
probe the devices in the right order and then finally let devices probe
even if their suppliers don't have any drivers.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 61fdfe99b348..977b379a495b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1613,7 +1613,7 @@ static int __init fw_devlink_setup(char *arg)
 }
 early_param("fw_devlink", fw_devlink_setup);
 
-static bool fw_devlink_strict;
+static bool fw_devlink_strict = true;
 static int __init fw_devlink_strict_setup(char *arg)
 {
 	return strtobool(arg, &fw_devlink_strict);
-- 
2.36.1.255.ge46751e96f-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
