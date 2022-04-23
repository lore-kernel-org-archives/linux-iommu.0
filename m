Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593DBC433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 10:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F337D60DED;
	Sat, 23 Apr 2022 10:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKHljZP3WuLR; Sat, 23 Apr 2022 10:27:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E21EB60D5C;
	Sat, 23 Apr 2022 10:27:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9A57C0032;
	Sat, 23 Apr 2022 10:27:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DF9FC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 10:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D88681A50
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 10:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id brfPnFb12zoq for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 10:27:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E80C81A33
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 10:27:17 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3717D60F29;
 Sat, 23 Apr 2022 10:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958D3C385A0;
 Sat, 23 Apr 2022 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650709635;
 bh=ddKHEuTRbRut1OsQhp+YMuMz23onGUBMShLMqKxTwJU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YJC/mBali+ZaOBUhChsdgZnicBb+bq6N7bb64+3OnZP+TROX50HxrR4xfieYO162x
 dhsCX3KlNWOAYKpEryeAQZvHfVEGdx6ZeVq+PfeOiiEeEKiKAb0SNrPkx3ucGF18R+
 0dtX4SEJb4GPT3zzGZZ2V0bhQtnNEtKkrhaMOzjCZQXPFaQOr8QtJjuw2JL++U03u0
 EaZ7eaANf8LaDkVOp68CUxX+JmnrMVZFSsUw4MDHdzjdey5M4Q4M3gFyoqTry8S8Vs
 FUSZAee2FGjz0SblW0KTs0Y1GuzYa6L095a67cWfXJUwp08vEMlcYCZC6t2W9HQ+Y1
 8AIu+DMm+RV8A==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1niCyv-006Mln-7Y; Sat, 23 Apr 2022 11:27:13 +0100
MIME-Version: 1.0
Date: Sat, 23 Apr 2022 11:27:13 +0100
From: Marc Zyngier <maz@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: fully convert arm to use dma-direct
In-Reply-To: <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
References: <20220421074204.1284072-1-hch@lst.de>
 <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e3ff279d8f00fb38ee4e9ecda0e56038@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linus.walleij@linaro.org, hch@lst.de, linux@armlinux.org.uk,
 arnd@kernel.org, andre.przywara@arm.com, andrew@lunn.ch,
 gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
 gregkh@linuxfoundation.org, stern@rowland.harvard.edu, laurentiu.tudor@nxp.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Andre Przywara <andre.przywara@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-04-22 22:17, Linus Walleij wrote:
> On Thu, Apr 21, 2022 at 9:42 AM Christoph Hellwig <hch@lst.de> wrote:
> 
>> arm is the last platform not using the dma-direct code for directly
>> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
>> arm to always use dma-direct now (it already does for LPAE configs
>> and nommu).  I'd love to merge this series through the dma-mapping 
>> tree
>> as it gives us the opportunity for additional core dma-mapping
>> improvements.
> (...)
> 
>>  b/arch/arm/mach-footbridge/Kconfig                   |    1
>>  b/arch/arm/mach-footbridge/common.c                  |   19
>>  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8
>>  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4
> 
> I think Marc Z has a Netwinder that he can test this on. Marc?
> I have one too, just not much in my office because of parental leave.

I'm about to travel for a week. Can this wait until I'm back?
This is one of the few boxes that isn't hooked up to the PDU,
so I can't operate it remotely.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
