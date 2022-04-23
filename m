Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D31C433FE
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 16:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4DED606C6;
	Sat, 23 Apr 2022 16:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V0zjPm_A1u04; Sat, 23 Apr 2022 16:44:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E68860784;
	Sat, 23 Apr 2022 16:44:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74C2AC0032;
	Sat, 23 Apr 2022 16:44:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 525CFC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 16:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34FFF823AB
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 16:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNPRBwTMHZna for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 16:43:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8E69813B4
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 16:43:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 99C6168B05; Sat, 23 Apr 2022 18:43:50 +0200 (CEST)
Date: Sat, 23 Apr 2022 18:43:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: fully convert arm to use dma-direct
Message-ID: <20220423164350.GA28488@lst.de>
References: <20220421074204.1284072-1-hch@lst.de>
 <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
 <e3ff279d8f00fb38ee4e9ecda0e56038@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e3ff279d8f00fb38ee4e9ecda0e56038@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

On Sat, Apr 23, 2022 at 11:27:13AM +0100, Marc Zyngier wrote:
>> I think Marc Z has a Netwinder that he can test this on. Marc?
>> I have one too, just not much in my office because of parental leave.
>
> I'm about to travel for a week. Can this wait until I'm back?
> This is one of the few boxes that isn't hooked up to the PDU,
> so I can't operate it remotely.

No rush at all from my side except that I;d love to get it into
5.19.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
