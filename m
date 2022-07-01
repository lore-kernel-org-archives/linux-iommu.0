Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E25C43334
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 15:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A089607F2;
	Fri,  1 Jul 2022 15:09:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A089607F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XiR5nLq4ffy3; Fri,  1 Jul 2022 15:08:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DDAAE60B5A;
	Fri,  1 Jul 2022 15:08:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDAAE60B5A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B52F9C0035;
	Fri,  1 Jul 2022 15:08:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C0B9C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 15:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA008405B5
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 15:08:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA008405B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yB2bGp4MXtmz for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 15:08:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE1B940445
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE1B940445
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 15:08:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19C17113E;
 Fri,  1 Jul 2022 08:08:55 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F3BE3F66F;
 Fri,  1 Jul 2022 08:08:51 -0700 (PDT)
Date: Fri, 1 Jul 2022 16:08:48 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
Message-ID: <20220701150848.75eeprptmb5beip7@bogus>
References: <YrQP3OZbe8aCQxKU@atomide.com>
 <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
 <Yrlz/P6Un2fACG98@atomide.com>
 <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
 <CAL_JsqJd3J6k6pRar7CkHVaaPbY7jqvzAePd8rVDisRV-dLLtg@mail.gmail.com>
 <CAGETcx9ZmeTyP1sJCFZ9pBbMyXeifQFohFvWN3aBPx0sSOJ2VA@mail.gmail.com>
 <Yr6HQOtS4ctUYm9m@atomide.com> <Yr6QUzdoFWv/eAI6@atomide.com>
 <CAGETcx-0bStPx8sF3BtcJFiu74NwiB0btTQ+xx_B=8B37TEb8w@mail.gmail.com>
 <CAGETcx-Yp2JKgCNfaGD0SzZg9F2Xnu8A3zXmV5=WX1hY7uR=0g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx-Yp2JKgCNfaGD0SzZg9F2Xnu8A3zXmV5=WX1hY7uR=0g@mail.gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Android Kernel Team <kernel-team@android.com>,
 Len Brown <len.brown@intel.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
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

Hi, Saravana,

On Fri, Jul 01, 2022 at 01:26:12AM -0700, Saravana Kannan wrote:

[...]

> Can you check if this hack helps? If so, then I can think about
> whether we can pick it up without breaking everything else. Copy-paste
> tab mess up warning.

Sorry for jumping in late and not even sure if this is right thread.
I have not bisected anything yet, but I am seeing issues on my Juno R2
with SCMI enabled power domains and Coresight AMBA devices.

OF: amba_device_add() failed (-19) for /etf@20010000
OF: amba_device_add() failed (-19) for /tpiu@20030000
OF: amba_device_add() failed (-19) for /funnel@20040000
OF: amba_device_add() failed (-19) for /etr@20070000
OF: amba_device_add() failed (-19) for /stm@20100000
OF: amba_device_add() failed (-19) for /replicator@20120000
OF: amba_device_add() failed (-19) for /cpu-debug@22010000
OF: amba_device_add() failed (-19) for /etm@22040000
OF: amba_device_add() failed (-19) for /cti@22020000
OF: amba_device_add() failed (-19) for /funnel@220c0000
OF: amba_device_add() failed (-19) for /cpu-debug@22110000
OF: amba_device_add() failed (-19) for /etm@22140000
OF: amba_device_add() failed (-19) for /cti@22120000
OF: amba_device_add() failed (-19) for /cpu-debug@23010000
OF: amba_device_add() failed (-19) for /etm@23040000
OF: amba_device_add() failed (-19) for /cti@23020000
OF: amba_device_add() failed (-19) for /funnel@230c0000
OF: amba_device_add() failed (-19) for /cpu-debug@23110000
OF: amba_device_add() failed (-19) for /etm@23140000
OF: amba_device_add() failed (-19) for /cti@23120000
OF: amba_device_add() failed (-19) for /cpu-debug@23210000
OF: amba_device_add() failed (-19) for /etm@23240000
OF: amba_device_add() failed (-19) for /cti@23220000
OF: amba_device_add() failed (-19) for /cpu-debug@23310000
OF: amba_device_add() failed (-19) for /etm@23340000
OF: amba_device_add() failed (-19) for /cti@23320000
OF: amba_device_add() failed (-19) for /cti@20020000
OF: amba_device_add() failed (-19) for /cti@20110000
OF: amba_device_add() failed (-19) for /funnel@20130000
OF: amba_device_add() failed (-19) for /etf@20140000
OF: amba_device_add() failed (-19) for /funnel@20150000
OF: amba_device_add() failed (-19) for /cti@20160000

These are working fine with deferred probe in the mainline.
I tried the hack you have suggested here(rather Tony's version), also
tried with fw_devlink=0 and fw_devlink=1 && fw_devlink.strict=0
No change in the behaviour.

The DTS are in arch/arm64/boot/dts/arm/juno-*-scmi.dts and there
coresight devices are mostly in juno-cs-r1r2.dtsi

Let me know if there is anything obvious or you want me to bisect which
means I need more time. I can do that next week.

-- 
Regards,
Sudeep
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
