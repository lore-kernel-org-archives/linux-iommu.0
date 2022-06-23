Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6793C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C4B1410E3;
	Thu, 23 Jun 2022 08:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C4B1410E3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=i4lCagk9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbE3LYqsCIxq; Thu, 23 Jun 2022 08:08:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9DEAA410EE;
	Thu, 23 Jun 2022 08:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DEAA410EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3615FC0032;
	Thu, 23 Jun 2022 08:08:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6970C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9123561362
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9123561362
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=i4lCagk9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1cMcMpN6lqvu for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:08:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADE7760B32
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADE7760B32
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:07 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id
 e85-20020a25e758000000b00668ad2fcfdcso15893793ybh.8
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=0/eFU0mji1Y5TeAdS+iFtwLqEv6S9QVvc5w9MNgKvSI=;
 b=i4lCagk9B7bXzBTSvydWESPGMcIaTy587NpbP2mYAtDZ6jSJjooH6C+Y7/cK+vDe8p
 tjaVXz9Xf6G/kwdEKbckuIRmvlKQc0Isg70swEZfiBMBCe+S3DqlsKW/Vc8ddBvOPVjR
 lIvPheRYRhyuT/aqrXKaS7dyrpjaT1bLTWLtv8vqGjAQoGAdfDNhim8Pekrgn/FN48t1
 D/gMxBflHbRNNpG4enBqhdLz1PNLhMs6W1UECUryzvBYRrirEIKEhJEPYAfsSr+73pFd
 dJS6KNGeJqtSU8cTmMdAQUt0LX8fu7kIoK2f2KVE7L/935rTbDztPIh8OGI8pjdX5HBe
 1Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=0/eFU0mji1Y5TeAdS+iFtwLqEv6S9QVvc5w9MNgKvSI=;
 b=6L7ao7Rsn693cmTrlPppGZiJ5g5fkkZdKPHKXGw65WFqNyK9j80ePi/R6+w+T+L162
 eJA9ixvvxMVQoAT/8Mn+7vLphFbmFXSJo6acMtZHzAWTUps34K38+bv9/Z+yqleldCR/
 pLGOSYBXuWnIpNlOh5h2wajZ8UP5hE+flou5CPeu1vNpgD9T13wRB2xPyJGRoRfxBaz0
 8G7UU9PGLd0n+GzkbecZ1Ix2qhF6f6py0Ws0a4kZZHIpmnCmZWSzZ3UvBw/l8o6SJlyh
 3bRtZ2+MKXfCwy3grMdbmlGijBN4FGjpH8T8o3rby0J/IdOVXwgqRp05/DHB1ZSDYLgT
 kcAA==
X-Gm-Message-State: AJIora+0LCmEdyV0IRO1La0rby12qhCATqnIbh/Uc9qJFjcZPAZ2I7N7
 Hu4BgPN10NQ+iYGwXH5LkiCTrEIw8JCEdVg=
X-Google-Smtp-Source: AGRyM1tKZUYuUk4jgIOeWzWC4DuvxuYDkBy6JPSb9aejRHfp70WxuRAHiujgQUdpkfHS1fKlas2dvEUoIip4TbQ=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:8b2d:9894:73a4:8e1f])
 (user=saravanak job=sendgmr) by 2002:a81:9b97:0:b0:313:7c6f:8685 with SMTP id
 s145-20020a819b97000000b003137c6f8685mr9446552ywg.201.1655971686587; Thu, 23
 Jun 2022 01:08:06 -0700 (PDT)
Date: Thu, 23 Jun 2022 01:03:41 -0700
Message-Id: <20220623080344.783549-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 0/2] Fix console probe delay due to fw_devlink
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

fw_devlink.strict=1 has been enabled by default. This was delaying the
probe of console devices. This series fixes that.

v1->v2:
- Added missing NULL check
- Added Tested-by tags

-Saravana

cc: sascha hauer <sha@pengutronix.de>
cc: peng fan <peng.fan@nxp.com>
cc: kevin hilman <khilman@kernel.org>
cc: ulf hansson <ulf.hansson@linaro.org>
cc: len brown <len.brown@intel.com>
cc: pavel machek <pavel@ucw.cz>
cc: joerg roedel <joro@8bytes.org>
cc: will deacon <will@kernel.org>
cc: andrew lunn <andrew@lunn.ch>
cc: heiner kallweit <hkallweit1@gmail.com>
cc: russell king <linux@armlinux.org.uk>
cc: "david s. miller" <davem@davemloft.net>
cc: eric dumazet <edumazet@google.com>
cc: jakub kicinski <kuba@kernel.org>
cc: paolo abeni <pabeni@redhat.com>
cc: linus walleij <linus.walleij@linaro.org>
cc: hideaki yoshifuji <yoshfuji@linux-ipv6.org>
cc: david ahern <dsahern@kernel.org>
cc: kernel-team@android.com
cc: linux-kernel@vger.kernel.org
cc: linux-pm@vger.kernel.org
cc: iommu@lists.linux-foundation.org
cc: netdev@vger.kernel.org
cc: linux-gpio@vger.kernel.org
Cc: kernel@pengutronix.de

Saravana Kannan (2):
  driver core: fw_devlink: Allow firmware to mark devices as best effort
  of: base: Avoid console probe delay when fw_devlink.strict=1

 drivers/base/core.c    | 3 ++-
 drivers/of/base.c      | 2 ++
 include/linux/fwnode.h | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
