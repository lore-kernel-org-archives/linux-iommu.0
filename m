Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DEBC43334
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 06:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE84883FED;
	Fri,  1 Jul 2022 06:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE84883FED
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.a=rsa-sha256 header.s=key1 header.b=T/RD+sr6;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.a=rsa-sha256 header.s=key1 header.b=K6Q2Cfyw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvYLBdVV-m8u; Fri,  1 Jul 2022 06:02:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C53183E36;
	Fri,  1 Jul 2022 06:02:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C53183E36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A765C007A;
	Fri,  1 Jul 2022 06:02:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02E25C0071
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6DCD41795
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:02:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6DCD41795
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com
 header.a=rsa-sha256 header.s=key1 header.b=T/RD+sr6; 
 dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com
 header.a=rsa-sha256 header.s=key1 header.b=K6Q2Cfyw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JVD8of_Oa8bE for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:02:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E78F84177C
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E78F84177C
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1656655324; x=1688191324;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=88W0IhCdmASo0Tm8efAxg0rx5GK9cZqYIieLJEzdB/g=;
 b=T/RD+sr6Glq4Z6Ft5QhkOPRZVMLQ+NhiXIK81iwbhsHp6Yd+r0v0PUdk
 qW/OY3lbF+F78/xpgRQmb+2FycQuB24GWW3Aj1VILTNrpRZIRs7YKonIn
 YpMk/wahVv6ixdOMbYoLGsMBX6mpWqBXfZCvCnLxo6tXtTQbIaHHHotYQ
 0ZUeh46Prd0NZj9kzia1M3IE3BCMvqKNoi54PRlO6oGmkAvUKOBmykSer
 /IhB584dRqaRtTE/hXkacjWhfaEbdeNEdJMG7J3z3MLjpzz4r/vw3aUDx
 W8XcqmO/IIpzN8NNcmHQi/E7DTRouTZR2pMfsfLzp7BujaBCfCIuquD2x A==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650924000"; d="scan'208";a="24791549"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
 by mx1-pgp.tq-group.com with ESMTP; 01 Jul 2022 08:01:59 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
 by tq-pgp-pr1.tq-net.de (PGP Universal service);
 Fri, 01 Jul 2022 08:01:59 +0200
X-PGP-Universal: processed;
 by tq-pgp-pr1.tq-net.de on Fri, 01 Jul 2022 08:01:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1656655319; x=1688191319;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=88W0IhCdmASo0Tm8efAxg0rx5GK9cZqYIieLJEzdB/g=;
 b=K6Q2CfywRqDUvlFcJVmFu6SslcG04+Frpxyc2nE7tT9SSWUzopX9hnsx
 i6hJLpLOtTHT9IVKGQC+koLLc/A/bGGIkSAIfUyMDrKbj4CHLsr+sUstl
 aKw3+7dp0h/TxION+F2+Bk8XlOfNfla4YtFnUkE/YnWbuQ43uXkNzO17g
 UCnShk/d3oJONlpNe5O3TXeunAeL5rX6ZhnfYiWsDMOQpN4WIeq0x9MvP
 FUNanteNRubdyH9vtorxD286thuUKE7eIO6xZuLlN0TxahRJb8e/k6vez
 V5LBq6rqg/eU0Vz1vkuGh6ZK93H6lyFCyiRsOzS4gP/elcCZNoqD85/w0 g==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650924000"; d="scan'208";a="24791548"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 01 Jul 2022 08:01:59 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8C3D0280071;
 Fri,  1 Jul 2022 08:01:58 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: (EXT) Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
Date: Fri, 01 Jul 2022 08:01:56 +0200
Message-ID: <5265491.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAGETcx_1qa=gGT4LVkyPpcA1vFM9FzuJE+0DhL_nFyg5cbFjVg@mail.gmail.com>
References: <20220601070707.3946847-1-saravanak@google.com>
 <4799738.LvFx2qVVIh@steina-w>
 <CAGETcx_1qa=gGT4LVkyPpcA1vFM9FzuJE+0DhL_nFyg5cbFjVg@mail.gmail.com>
MIME-Version: 1.0
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team@android.com,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
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

Hi Saravana,

Am Freitag, 1. Juli 2022, 02:37:14 CEST schrieb Saravana Kannan:
> On Thu, Jun 23, 2022 at 5:08 AM Alexander Stein
> 
> <alexander.stein@ew.tq-group.com> wrote:
> > Hi,
> > 
> > Am Dienstag, 21. Juni 2022, 09:28:43 CEST schrieb Tony Lindgren:
> > > Hi,
> > > 
> > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > "power-domains" property, the execution will never get to the point
> > > > where driver_deferred_probe_check_state() is called before the
> > > > supplier
> > > > has probed successfully or before deferred probe timeout has expired.
> > > > 
> > > > So, delete the call and replace it with -ENODEV.
> > > 
> > > Looks like this causes omaps to not boot in Linux next. With this
> > > simple-pm-bus fails to probe initially as the power-domain is not
> > > yet available. On platform_probe() genpd_get_from_provider() returns
> > > -ENOENT.
> > > 
> > > Seems like other stuff is potentially broken too, any ideas on
> > > how to fix this?
> > 
> > I think I'm hit by this as well, although I do not get a lockup.
> > In my case I'm using
> > arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts and probing of
> > 38320000.blk-ctrl fails as the power-domain is not (yet) registed.
> 
> Ok, took a look.
> 
> The problem is that there are two drivers for the same device and they
> both initialize this device.
> 
>     gpc: gpc@303a0000 {
>         compatible = "fsl,imx8mq-gpc";
>     }
> 
> $ git grep -l "fsl,imx7d-gpc" -- drivers/
> drivers/irqchip/irq-imx-gpcv2.c
> drivers/soc/imx/gpcv2.c
> 
> IMHO, this is a bad/broken design.
> 
> So what's happening is that fw_devlink will block the probe of
> 38320000.blk-ctrl until 303a0000.gpc is initialized. And it stops
> blocking the probe of 38320000.blk-ctrl as soon as the first driver
> initializes the device. In this case, it's the irqchip driver.
> 
> I'd recommend combining these drivers into one. Something like the
> patch I'm attaching (sorry for the attachment, copy-paste is mangling
> the tabs). Can you give it a shot please?

I tried this patch and it delayed the driver initialization (those of UART as 
well BTW). Unfortunately the driver fails the same way:
> [    1.125253] imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed to 
attach power domain "bus"

More than that it even introduced some more errors:
> [    0.008160] irq: no irq domain found for gpc@303a0000 !
> [    0.013251] Failed to map interrupt for
> /soc@0/bus@30400000/timer@306a0000
> [    0.020152] Failed to initialize '/soc@0/bus@30400000/timer@306a0000':
> -22

I kept the timestamps to show that these errors happen very early. So now the 
usage of the "global" interrupt parent, set at line 18,
> interrupt-parent = <&gpc>;
is not possible at this point of boot time.

Best regards,
Alexander



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
