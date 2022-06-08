Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50779C43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 22:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB478408DB;
	Wed,  8 Jun 2022 22:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CjaCKCdDcFkO; Wed,  8 Jun 2022 22:49:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0A14400A6;
	Wed,  8 Jun 2022 22:49:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98D29C0039;
	Wed,  8 Jun 2022 22:49:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDC54C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 22:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A64F58141D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 22:49:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id voip3A_-htxm for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 22:49:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E217813FF
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 22:49:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C261361735;
 Wed,  8 Jun 2022 22:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C22C34116;
 Wed,  8 Jun 2022 22:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654728551;
 bh=KoDfYZU8H3/Jk6nelCnyzGy1ViLp+HOvc80VTERRhLk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=c47L61jNlPTTvhMermxgEoTOR9tWN65ALmSIUqWA/wuOeo+x67eQrpqH+NwJc5S+h
 PXtQCy08WczMlRL1nrqYaTzNO8rQ7ucEMUfc1fak2OFB8n3dUP4d+rjMPwR2VNbPH0
 Mf6l5WTxg4u1Kcn783ubkdYv2krRDz2t1vUTXPBVPXt9B8mkQ0GMHULzam2VTrceSn
 vNzj7lGKeQ8LZvsupIlQG5hs80ef3vrgPzzmPrVZUmCHf0eyTLpjvNj41LJJPA7k1D
 MGP0elVE6cT4SScOWE7iEvpStoF4640FLL1sX7CvK+m4RK4FHM2MPS5Q45TdRfX4j3
 QUGUYhF+ECwLQ==
Date: Wed, 8 Jun 2022 15:49:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 0/9] deferred_probe_timeout logic clean up
Message-ID: <20220608154908.4ddb9795@kernel.org>
In-Reply-To: <CAGETcx8UO=4mk31tU4QaWU3RaNM_myA9woe0idBp6p7+X5AEgg@mail.gmail.com>
References: <20220601070707.3946847-1-saravanak@google.com>
 <CAMuHMdXkX-SXtBuTRGJOUnpw9goSP6RFr_PTt_3w_yWgBpWsqg@mail.gmail.com>
 <CAGETcx9f0UBhpp6dM+KJwtYpLx19wwsq6_ygi3En7FrXobOSpA@mail.gmail.com>
 <CAGETcx8VM+xOCe7HEx9FUU-1B9nrX8Q=tE=NjTyb9uX2_8RXLQ@mail.gmail.com>
 <CAMuHMdXzu8Vp=a7fyjOB=xt04aee=vWXV=TcRZeeKUGYFFZ1CA@mail.gmail.com>
 <CAGETcx_Nqo4ju7cWwO3dP3YM2wpCb0jx23OHOReexOjpT5pATA@mail.gmail.com>
 <CAMuHMdXQCwMQj_ZiOBAzusdCxd8w6NbTqD_7nzykhVs+UWx8Gw@mail.gmail.com>
 <CAGETcx8UO=4mk31tU4QaWU3RaNM_myA9woe0idBp6p7+X5AEgg@mail.gmail.com>
MIME-Version: 1.0
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <len.brown@intel.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund+renesas@ragnatech.se>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Wed, 8 Jun 2022 14:07:44 -0700 Saravana Kannan wrote:
> David/Jakub,
> 
> Do the IP4 autoconfig changes look reasonable to you?

I'm no expert in this area, I'd trust the opinion of the embedded folks
(adding Florian as well) more than myself. It's unclear to me why we'd
wait_for_init_devices_probe() after the first failed iteration, sleep,
and then allow 11 more iterations with wait_for_device_probe().

Let me also add Thomas since he wrote e2ffe3ff6f5e ("net: ipconfig:
Wait for deferred device probes").
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
