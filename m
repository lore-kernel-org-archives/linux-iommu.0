Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BB2C433FE
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 07:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D33F340902;
	Wed,  1 Jun 2022 07:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZV8HYe_U-NmK; Wed,  1 Jun 2022 07:07:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9202840895;
	Wed,  1 Jun 2022 07:07:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 681B9C0039;
	Wed,  1 Jun 2022 07:07:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81C49C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60E4D40543
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g5-c0ChCD6Lw for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 07:07:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2A7A40535
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:15 +0000 (UTC)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-30c2aa26ebfso8520887b3.4
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 00:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Eq6nH6aGeuKpMU9nM7ibONmheABIDjQM7t9UjsNcl+w=;
 b=dvfs6aw0o9enYr6q5JvsoITL1cIodQJtPwQKFVNV/ElWQiITwvlgBGIYVXYubJ0EWb
 hQZknjUn8hWhfVG63Q26ahXT/ybuECTh3IQ0hlFzpMrRfffJaSxehOVATgqcGdOl5B63
 UAGusDHfZ1+bZx3UPXTCMA74yfTvat1qBDbQNIwN2gBcEL0s2lgJJxBkvLKW4seHwHfy
 yy/kVDyKrdiePicpV782RiPioPYMYI6dNrIPSqSRQjnVUQlBHfFoZNPq2vXgAhQA5tJ2
 qPRfgtRDz89n2glwq1xvIPHXD3I9kan+rQBxaKWDF0fkq11SsjvYI3DlubXtUCtJ5N2t
 udoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Eq6nH6aGeuKpMU9nM7ibONmheABIDjQM7t9UjsNcl+w=;
 b=XHCGaXp0J6e7YazL9v6cYa0Xze0RmenFZdfX+SGO9FnBaYaydtyqEQCng7o315kOVu
 hxUuf7LoabHkK9JxuPqZTiKs4kBcG1N3BzZw67LqsqRFTk4oCYfuLts8JqZHVYE1kfcT
 bXmedbwMV87vn/xfHke02m7TqFv3YzCG3rVd9tJf+rzidSRUuiEqowqhxThPFBTjXBmV
 5UXb2EbwilQiv+zAPtL2oUkInBSrufYWQ7QB01GCEFbkrCM5v6qcfdjuA/YGgElgFvkD
 jIEP1LjVdGley5mkCQdPBbzGj2DIuGwObF+5Mew92pFOn020+MTRPScllamLuImmCX3R
 ncKg==
X-Gm-Message-State: AOAM530XM48bCriNC3XIR/JuXbJ3KyaomXYCfD4P6v+ICGco3gm+qQLo
 Zvu27WwpH+8OcQ32AEo44CmCQkK2S3SZfX4=
X-Google-Smtp-Source: ABdhPJyEEJmzYE3LJbKEPxep9Txd8IS2Y3Ohb4w4RDlkBWekTGGi+00/Yu83BjSHoAA0YZYV1qdNB+xcoJAZ8NA=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a25:2e06:0:b0:65c:ed2e:31bd with SMTP id
 u6-20020a252e06000000b0065ced2e31bdmr13135711ybu.244.1654067234572; Wed, 01
 Jun 2022 00:07:14 -0700 (PDT)
Date: Wed,  1 Jun 2022 00:06:57 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 1/9] PM: domains: Delete usage of
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
2.36.1.255.ge46751e96f-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
