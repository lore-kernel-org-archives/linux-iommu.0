Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECCDC43334
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 09:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDAE160E9A;
	Mon,  6 Jun 2022 09:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQZtQLxUTW05; Mon,  6 Jun 2022 09:25:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBF7D60AB0;
	Mon,  6 Jun 2022 09:25:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77014C0032;
	Mon,  6 Jun 2022 09:25:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6392C002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 09:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 835BC83E7E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 09:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id chV4GNXp0F-A for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 09:25:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 540BE83E7A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 09:25:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9E9DF61316;
 Mon,  6 Jun 2022 09:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FA8C385A9;
 Mon,  6 Jun 2022 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1654507538;
 bh=SGyOc8QTUXhFBU0FK2dbWFATxGIrz/5ZeL4pH3h6UnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o5+R3V8oO4+EAgAGTpyjUIQqB3KNAeJts/jhrJSGEBRzH1PN9a+gCBfvBwaJfsi0j
 S+xDAbHwdHZEgYXeWMOFMcC/5op2p7s+cMgBf8QSuvMTb6YuVTYwduPx5uxc+DOYFd
 fr4c0yZ5gapUx5x3IKS7vTtcG+YZNWc9Hh4gX5Rc=
Date: Mon, 6 Jun 2022 11:25:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 0/6] phase out CONFIG_VIRT_TO_BUS
Message-ID: <Yp3ID86TBFxl7qyL@kroah.com>
References: <20220606084109.4108188-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606084109.4108188-1-arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linux-m68k@lists.linux-m68k.org, Denis Efremov <efremov@linux.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Khalid Aziz <khalid@gonehiking.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 06, 2022 at 10:41:03AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The virt_to_bus/bus_to_virt interface has been deprecated for
> decades. After Jakub Kicinski put a lot of work into cleaning out the
> network drivers using them, there are only a couple of other drivers
> left, which can all be removed or otherwise cleaned up, to remove the
> old interface for good.
> 
> Any out of tree drivers using virt_to_bus() should be converted to
> using the dma-mapping interfaces, typically dma_alloc_coherent()
> or dma_map_single()).
> 
> There are a few m68k and ppc32 specific drivers that keep using the
> interfaces, but these are all guarded with architecture-specific
> Kconfig dependencies, and are not actually broken.
> 
> There are still a number of drivers that are using virt_to_phys()
> and phys_to_virt() in place of dma-mapping operations, and these
> are often broken, but they are out of scope for this series.

I'll take patches 1 and 2 right now through my staging tree if that's
ok.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
