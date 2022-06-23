Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2330C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 16:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61B0484734;
	Thu, 23 Jun 2022 16:39:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61B0484734
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J3x835Jv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TU8BEvDHHEAO; Thu, 23 Jun 2022 16:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D340846E4;
	Thu, 23 Jun 2022 16:39:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D340846E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 169D1C0032;
	Thu, 23 Jun 2022 16:39:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E683C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 16:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCE9261412
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 16:39:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DCE9261412
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=J3x835Jv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E7pfA9Wt3WXh for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 16:39:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9541061407
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9541061407
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656002375; x=1687538375;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EI+QQ+/jwbwz1xOCAJK7+a2mr8/Kd1EZs7K/UPWhtF4=;
 b=J3x835JvqM6bKk29F6ZM+vlbiHyPFOmbR0jUPhOgIprMZKtokZSh/OJH
 tlehfVKyYrWsdRr98G+ZpkrhiUT3X106mdZtHVPOt2AjQJafqXAHmjCko
 fKc/FFdhZ84WXiBogzsIlcQSy2Xl/NPaOgOp6w86o6IFZP2vxeDTwsqxa
 tQXHarmdAVKHsOXj5uYs55g9s32Fu8VnizcHzzNQMyS6eq/kdphv4rhHk
 khYKEBxm/8eZl/Y1NNDc1bNVKTTeG4OHfWp4ua6iU9jgBO5bafcY0X62Q
 HmucxNSSTPm4tH0ZrZ44+Ho2zun/hOpd4rjGKlIxQqgPtdZXdQ2zrfz9k g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="306233187"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; d="scan'208";a="306233187"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 09:39:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; d="scan'208";a="834715838"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 09:39:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1o4PrG-000tDS-Q2; Thu, 23 Jun 2022 19:39:06 +0300
Date: Thu, 23 Jun 2022 19:39:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: sascha hauer <sha@pengutronix.de>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
Message-ID: <YrSXKkYfr+Hinsuu@smile.fi.intel.com>
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220623100421.GY1615@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linus walleij <linus.walleij@linaro.org>, ulf hansson <ulf.hansson@linaro.org>,
 eric dumazet <edumazet@google.com>, pavel machek <pavel@ucw.cz>,
 will deacon <will@kernel.org>, Saravana Kannan <saravanak@google.com>,
 kevin hilman <khilman@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 russell king <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, paolo abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <lenb@kernel.org>,
 len brown <len.brown@intel.com>, kernel@pengutronix.de,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 david ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Scally <djrscally@gmail.com>, iommu@lists.linux-foundation.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
 "david s. miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 23, 2022 at 12:04:21PM +0200, sascha hauer wrote:
> On Thu, Jun 23, 2022 at 01:03:43AM -0700, Saravana Kannan wrote:

...

> I wonder if it wouldn't be a better approach to just probe all devices
> and record the device(node) they are waiting on. Then you know that you
> don't need to probe them again until the device they are waiting for
> is available.

There may be no device, but resource. And we become again to the something like
deferred probe ugly hack.

The real solution is to rework device driver model in the kernel that it will
create a graph of dependencies and then simply follow it. But actually it should
be more than 1 graph, because there are resources and there are power, clock and
resets that may be orthogonal to the higher dependencies (like driver X provides
a resource to driver Y).

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
