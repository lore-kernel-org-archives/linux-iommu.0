Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2457C433EF
	for <iommu@archiver.kernel.org>; Tue, 18 Jan 2022 16:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64C0E401B4;
	Tue, 18 Jan 2022 16:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kGW3UexWiiKr; Tue, 18 Jan 2022 16:53:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3130A409B6;
	Tue, 18 Jan 2022 16:53:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C8C2C0039;
	Tue, 18 Jan 2022 16:53:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFB0EC002F
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 16:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDBD281A92
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 16:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbcodsJwFJk7 for <iommu@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 16:53:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 286DB81A29
 for <iommu@lists.linux-foundation.org>; Tue, 18 Jan 2022 16:53:32 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A1DE6B81238;
 Tue, 18 Jan 2022 16:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC88C340E0;
 Tue, 18 Jan 2022 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642524808;
 bh=hj6cgF8nqJUDMXfSevCsDKP3HTwnEamooJYkoM7Kvns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cI/3+ELb1BO7XjuTEVngbV/xxNGYbpZJOS87HYLo3jL/W9zr4VIkXF/j+dr1KzeB5
 Y6UJE6RbT6KBGFSFyXF/JJY84pQf8y6RngMXN8PO6Kta7EOw2X0u+K6tkYlObhXBFs
 25A/VWJUZMDedKwIZ8u3svG5O3LJfq/iZzvu0O6LYipOlmnQFchv4wVNM3B/41XCA7
 +oj7aRU332K+PadAKKj6JaKugkbGvhJRGj59KBKNN1URwG5XXGWUz2iP/7lighYZOv
 FzLzYvS+fpKVMoTsQ5EoIp75D5NEm8XvSCkQwXTwvNwOQPndKrCzBKm1zlIlkMmmS7
 IEsRPgff81FBA==
Date: Tue, 18 Jan 2022 08:53:25 -0800
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: nvme: IO_PAGE_FAULT logged with Intel SSDPEKKF512G8
Message-ID: <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
References: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org
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

On Tue, Jan 18, 2022 at 03:32:45PM +0100, Paul Menzel wrote:
> On a Dell OptiPlex 5055 with an Intel SSDPEKKF512G8, Linux 5.10.82 reported
> an IO_PAGE_FAULT error. This is the first and only time this has happened.
> 
>     $ dmesg --level=err
>     [    4.194306] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc080 flags=0x0050]
>     [    4.206970] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc000 flags=0x0050]
>     [    7.327820] kfd kfd: VERDE  not supported in kfd
>     $ lspci -nn -s 01:00.0
>     01:00.0 Non-Volatile memory controller [0108]: Intel Corporation SSD Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)

I think it's a bug with the iommu implementation. If it causes problems,
you can typically work around it with kernel parameter "iommu=soft".
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
