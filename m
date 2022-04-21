Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB766C433FE
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 08:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 662D3405C2;
	Thu, 21 Apr 2022 08:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lM7mlQ_9bmDz; Thu, 21 Apr 2022 08:02:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A077400E5;
	Thu, 21 Apr 2022 08:02:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1201FC0033;
	Thu, 21 Apr 2022 08:02:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE0F9C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B887F60C26
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONiyDZYC46xP for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 08:02:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B79960C22
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:02:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4EBD061BBC
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C18CC385B9
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650528154;
 bh=85ztGE8SAOJYsSsE/m/ye56564WWRnDCXfBI1VMh6w8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gx80Hh2cCildDpD/QBFdHR9o5EQI4TZJNxY+M5H7fSxIckh3WEkeA61atMMdcjAs3
 S1eAqplyh6FpSWhZlnE0zDt0DMoZ8vQJuuaC4Dyt6mtvcJHJGQlslG5tWAyufFpN7U
 +m0rH/jQNDvZtdE/ERPjRIKmMtCRfEgSCJgh2GuB0cb3cWfOQPdDoOuidIcQKuG0iY
 Sm9In6QEX7I7ZUBytG03Y7EH+G6pbZrkiy+sLch/OlLXMVfSl9zmTeQMB6R8FT7Xr5
 vWGQ0s3//ga4gycac/gtSC/F4l8SxARO/sZm4JlDqEsV2KSP7jzaKcflBXrbYPAdoM
 n/ugXKlhfRznQ==
Received: by mail-wr1-f47.google.com with SMTP id c10so5500583wrb.1
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 01:02:34 -0700 (PDT)
X-Gm-Message-State: AOAM531lbYgY9Rsy37b4zWWVDc78MvnwU0kiKTkvF+Cewl53uArQ9pHO
 2P7oyQxATXf8KWDALIDXzQ96YqEnGoOjgXulbug=
X-Google-Smtp-Source: ABdhPJwd18r+4oxvbBvNk4Ssn0sgurWbN+G4WyUL66cAw98TCXAYMvuBOOjMpSguCZLqOVEc5MnPUhcs76UVW8oNVSU=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr18349140wru.192.1650528152748; Thu, 21
 Apr 2022 01:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
 <20220421074204.1284072-6-hch@lst.de>
In-Reply-To: <20220421074204.1284072-6-hch@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Apr 2022 10:02:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2M-R+S9SFe2ti3j41qy3KCVgc-povo6GwDQn_Dj_AB4A@mail.gmail.com>
Message-ID: <CAK8P3a2M-R+S9SFe2ti3j41qy3KCVgc-povo6GwDQn_Dj_AB4A@mail.gmail.com>
Subject: Re: [PATCH 5/7] ARM: use dma_to_phys/phys_to_dma in the dma-mapping
 code
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, USB list <linux-usb@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Thu, Apr 21, 2022 at 9:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the helpers as expected by the dma-direct code in the old arm
> dma-mapping code to ease a gradual switch to the common DMA code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
