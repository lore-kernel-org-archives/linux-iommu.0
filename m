Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DADCCA482
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 06:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5DA682BEB;
	Wed, 29 Jun 2022 06:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5DA682BEB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MnKE4/OS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5xSBCW6xZVNV; Wed, 29 Jun 2022 06:41:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D1F1817AF;
	Wed, 29 Jun 2022 06:41:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D1F1817AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F5B0C0032;
	Wed, 29 Jun 2022 06:41:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C87BC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66CB041574
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:41:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66CB041574
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=MnKE4/OS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fCiCrFwV0Qo for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:41:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34EA3414C1
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34EA3414C1
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:41:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2264AB821B8;
 Wed, 29 Jun 2022 06:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C8AC34114;
 Wed, 29 Jun 2022 06:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1656484894;
 bh=VUdU1ZN0gTQSz41n281wqpCvgg5hDjrNyKaxOQ1mkWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MnKE4/OSuFQtLTiqSAMzWNNgin1pU5O0ltB0nO8+NNjT1seiimVqcDmx1Kf7GDsnG
 a1jqthF+q/2fe4oLJFG3+ZaiRzIPPTxNyDgzjA90/QohX8K9143NSIBaG0vNVsMppZ
 lZUDQFkMnCtwzJ/W1sAHLHAWg00kp+3Xcc5ulIqs=
Date: Wed, 29 Jun 2022 08:41:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: fully convert arm to use dma-direct v3
Message-ID: <Yrv0HLSj3xAHa+av@kroah.com>
References: <20220614092047.572235-1-hch@lst.de>
 <20220629062837.GA17140@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220629062837.GA17140@lst.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>,
 Robin Murphy <robin.murphy@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
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

On Wed, Jun 29, 2022 at 08:28:37AM +0200, Christoph Hellwig wrote:
> Any comments or additional testing?  It would be really great to get
> this off the table.

For the USB bits:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
