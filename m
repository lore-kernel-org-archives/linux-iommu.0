Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABD9C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0CCF84581;
	Thu, 23 Jun 2022 08:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0CCF84581
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=X3cn1S0C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55uoPpB3uW5A; Thu, 23 Jun 2022 08:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B2A484704;
	Thu, 23 Jun 2022 08:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B2A484704
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70BC7C0032;
	Thu, 23 Jun 2022 08:08:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54EE8C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 219C960B32
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 219C960B32
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=X3cn1S0C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tm7qsfZTg5Ci for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:08:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CF7461360
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CF7461360
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:10 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 n22-20020a17090ade9600b001ecdd9695c7so1794267pjv.9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=zZJrI+RbMRkrmHfhlt/j/MmMDuQlYzWrcboe4IkTaNE=;
 b=X3cn1S0CzIm4FWlNm7Ryg2/2EhJ00v8hxnIIDKiY0q1xKgtQnRGMiDKSXOEkZbvZhP
 4uuCwD503iseCprVScSWZ4pQAjCrhi5cSXg2767cmkjO+dH6ZtTzMD8IgkJml4P1nS5Y
 KRkC8Q3fbKTSbVuwwYgY40M7YBq7K4GfinxXw1gKkP9ckyTCf5jZEnxIrlT4m5ctvBId
 aFDhAWxWEib2HfJK+X0wU6lZpwgwBLpDzcd7ufJxyOwRN0hhKAFrayM0jxIwcjjWVfRA
 dKJY5P21I5RqGps1wnOhf0Q0ky3RmaD6EK6D2UEz4teRjKPN/KhAkLDsA4wB4nGaqEqu
 RHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=zZJrI+RbMRkrmHfhlt/j/MmMDuQlYzWrcboe4IkTaNE=;
 b=DtJ9lIvKgHFZRD3biMNUqRqE1efpzQUTm7WNmScQug4p8wKGD4faFf/v4Mukk8tPJq
 bdOKD7+IXAoQ4VaTvd1qhRmfa322ZKJuruuqZ8JviMFBt9yRZoGSkLTgfcGZDpjiUZZu
 7nxNpgdEBal2DKrp1FnnK/DFpcvRG+7uIdCB83ccBOCCrgZ7reD3KpL37sgjweH3Deuk
 5jUxBN7vrIFqXJlmfHV+biCN36KtzKl8ndPM9vrC6xsngK8A9IV+M4EdxcMA3eMlCjyV
 VzRUTnlhPy8vnfjLMrEIIaCXY66HOIlns+QyOQFRF2yrQlZBDNwgyx3uFIyRkBq6TaNr
 mbUA==
X-Gm-Message-State: AJIora+ldjlwatrWN+sRiO3hOFc03263k4xtVSkp4qSPTj7gdWjICSGD
 gOxqkIoN30NIFj9Zq4N5b/uwMtttS7uNsGk=
X-Google-Smtp-Source: AGRyM1tnEDDd6vXWrrgmwo6F71ebTbd/zg3maYPwEQqNaZ5fOSmTNlY8C2FC3Fw0+TpkwTsE/6rFVWhkzcP3DDw=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:8b2d:9894:73a4:8e1f])
 (user=saravanak job=sendgmr) by 2002:a17:902:8309:b0:167:9a4c:cd58 with SMTP
 id bd9-20020a170902830900b001679a4ccd58mr37342398plb.166.1655971689836; Thu,
 23 Jun 2022 01:08:09 -0700 (PDT)
Date: Thu, 23 Jun 2022 01:03:42 -0700
In-Reply-To: <20220623080344.783549-1-saravanak@google.com>
Message-Id: <20220623080344.783549-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 1/2] driver core: fw_devlink: Allow firmware to mark
 devices as best effort
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 devicetree@vger.kernel.org, linus walleij <linus.walleij@linaro.org>,
 ulf hansson <ulf.hansson@linaro.org>, eric dumazet <edumazet@google.com>,
 pavel machek <pavel@ucw.cz>, will deacon <will@kernel.org>,
 sascha hauer <sha@pengutronix.de>, kevin hilman <khilman@kernel.org>,
 russell king <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, paolo abeni <pabeni@redhat.com>,
 kernel-team@android.com, len brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 hideaki yoshifuji <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 david ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel@pengutronix.de,
 "david s. miller" <davem@davemloft.net>,
 heiner kallweit <hkallweit1@gmail.com>
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
Tested-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/core.c    | 3 ++-
 include/linux/fwnode.h | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 839f64485a55..ccdd5b4295de 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -968,7 +968,8 @@ static void device_links_missing_supplier(struct device *dev)
 
 static bool dev_is_best_effort(struct device *dev)
 {
-	return fw_devlink_best_effort && dev->can_match;
+	return (fw_devlink_best_effort && dev->can_match) ||
+		(dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT));
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
