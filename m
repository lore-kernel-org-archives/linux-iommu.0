Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77168C433F5
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 08:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23E9640198;
	Mon, 30 May 2022 08:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSyFzgw-sztP; Mon, 30 May 2022 08:49:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0AED8400FE;
	Mon, 30 May 2022 08:49:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4B5CC0039;
	Mon, 30 May 2022 08:49:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B75C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 08:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0063483E9D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 08:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="oKod/4yD";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="fn7UBgTU"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ENsStDFucc7M for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 08:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A249832C2
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 08:49:15 +0000 (UTC)
Date: Mon, 30 May 2022 10:49:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1653900550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mb32qARmKX/oF5s+kHIv0X9LwS5Vfd7eo5GK1onxbS4=;
 b=oKod/4yDEBaJi9iSKiGnIgGVyCp8e+d2eVwVdzte+6E86zRPZJb6uEjvY9/CW55BhnnY43
 ebGZ+E6AvYiBDeczcq+JHuFv1HT/m6EUhkoQLyx7NvTZQEIvJydHNpHBSZnzpfeZS4/A/7
 WGOHtJFe9NMPJhsqGcfjxAiHHCgjBuhNBBwbV+/kN1yItnFW2+10TbUX85HAvObQVcfwy3
 Z/TJ45JrIoDnh3p6gb7cbvNUxJHf5ULSF687VCmIIUyqaT3WK72dn/WdaL3xTiQEswmrnn
 nOA8I3nPJmVo1oAkxzrvDFAlPJUQE6RQrsz0po9ChI7ybB+ptjNpn/bXqyZHyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1653900550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mb32qARmKX/oF5s+kHIv0X9LwS5Vfd7eo5GK1onxbS4=;
 b=fn7UBgTUB18eEO+ZPOF0lTcnEkE+cEHthbTzQs24jteMlG7VDojMV7jKwiMO1pIQklIDh2
 MZUM5BfSfn06/zCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC PATCH v1 0/9] deferred_probe_timeout logic clean up
Message-ID: <YpSFBNfGDpy3rqEV@linutronix.de>
References: <20220526081550.1089805-1-saravanak@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 John Stultz <jstultz@google.com>, Pavel Machek <pavel@ucw.cz>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Scally <djrscally@gmail.com>, iommu@lists.linux-foundation.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-05-26 01:15:39 [-0700], Saravana Kannan wrote:
> Yoshihiro/Geert,
Hi Saravana,

> If you can test this patch series and confirm that the NFS root case
> works, I'd really appreciate that.

The two patches you sent earlier, plus this series, plus

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7ff7fbb006431..829d9b1f7403f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1697,8 +1697,6 @@ static int fw_devlink_may_probe(struct device *dev, void *data)
  */
 void __init fw_devlink_unblock_may_probe(void)
 {
-	struct device_link *link, *ln;
-
 	if (!fw_devlink_flags || fw_devlink_is_permissive())
 		return;
 
and it compiles + boots without a delay.

Sebastian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
