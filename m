Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CA1CCA479
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 21:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB570410CE;
	Wed, 22 Jun 2022 21:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB570410CE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=mPUp1Zai
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Sj33o3yAe3u; Wed, 22 Jun 2022 21:59:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 74D614002B;
	Wed, 22 Jun 2022 21:59:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74D614002B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC63C0032;
	Wed, 22 Jun 2022 21:59:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63930C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 21:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 280C8410C7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 21:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 280C8410C7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wnKmai76VO1F for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 21:59:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 583D44002B
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 583D44002B
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 21:59:18 +0000 (UTC)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-317ab78a345so95616117b3.10
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=ShVpNHmjygEofAqZTHbL2NPyHgeZoFDheDozlrqz8Mo=;
 b=mPUp1ZaiPzHiX/ODKTWQHSWhTGs2yrj0nz46pJea4DKVIWXpl3q0hnFrpNlVeVuFMu
 O6opAaXQuvi5uzX9EE3KaV2tOUFGq1jDJOmlWAwGI9JnOmBxCTczh9qb6dkX4IMOxw4R
 7k5Jju5GTUCe3yiEswDVY4cctHhutRwGFrXTp4d6H7EswQNBSuousy5e+nF8IFajtZYo
 OjoVhxEhdXwBTMSSxpG6OZNtheT6Ku7+aQY740oMkBnQKdxNivQym1AS38woNuH1PkQi
 LMpv++OC1nrl7lO39MRZ8QiA8XyTUqyfG3zJSRr2zKL91xKNcPmDsDkOZgGsgRtYkxv9
 yh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=ShVpNHmjygEofAqZTHbL2NPyHgeZoFDheDozlrqz8Mo=;
 b=Zrq0oUBFRoFzed/KqN+erIWxXabNFv3npRcznqXBNVdzvWSsMlrMKHDqsGxmzqONcL
 ACbM3n7/jXL4v5LcbH5JNHq12i/n8XNxRQ+Mjcqlyeq+dNoSb0RRKnUNxPZf+1D7CX23
 23bvE4ctsxZzx6oF04N1dCs00U92CQ0v3sYaqs1In/gFQGeBQH+nOpB3ucJsuQl0tREC
 kOQTnw2NaFC+Z9/XjwB96gh+X70c3CCe2xJ4CLuuGqHUtsTR+bvsj7FlCQ1OoPScqmF7
 ojb3I/dJoPyDU1e1XAdZyBzITcevX4Iei4txGvfIVdDsDXDkxadG4PRnVk1kP0fdRm1W
 sASQ==
X-Gm-Message-State: AJIora8+6Du7urIr+VZVNoM6PJdTvqqIRSSmpd89ZJnGGSb/wqQvs1V2
 adrIwQ9CwgECOkZdLP2hFvDUMiSiYytEmG8=
X-Google-Smtp-Source: AGRyM1sPRolQYIbNGET+LNO41EG5xKdb86jsaddJpKTB6LWlD19bkf1RVr0BB1uN5nuhu99u7pbeK+zWsKcFtIE=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:be1f:89ac:a37d:6bb4])
 (user=saravanak job=sendgmr) by 2002:a25:73d7:0:b0:668:e7db:d62 with SMTP id
 o206-20020a2573d7000000b00668e7db0d62mr6272113ybc.265.1655935157166; Wed, 22
 Jun 2022 14:59:17 -0700 (PDT)
Date: Wed, 22 Jun 2022 14:59:09 -0700
Message-Id: <20220622215912.550419-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v1 0/2] Fix console probe delay due to fw_devlink
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

fw_devlink.strict=1 has been enabled by default. This was delaying the
probe of console devices. This series fixes that.

Sasha/Peng,

Can you test this please?

-Saravana

Cc: Sascha Hauer <sha@pengutronix.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: kernel-team@android.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
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
