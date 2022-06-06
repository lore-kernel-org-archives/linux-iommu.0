Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AC0C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 16:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A11083FA8;
	Mon,  6 Jun 2022 16:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0hsBF2sfTJj; Mon,  6 Jun 2022 16:48:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0028383FA6;
	Mon,  6 Jun 2022 16:48:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6A05C0039;
	Mon,  6 Jun 2022 16:48:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5CBBC002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 16:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B40BB41718
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 16:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hqf5cAmGzh-R for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 16:40:55 +0000 (UTC)
X-Greylist: delayed 00:05:23 by SQLgrey-1.8.0
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98F36416C9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 16:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mailout.easymail.ca (Postfix) with ESMTP id F0673E0E57;
 Mon,  6 Jun 2022 16:35:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo08-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
 by localhost (emo08-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hhyNN48mX6Hb; Mon,  6 Jun 2022 16:35:29 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
 by mailout.easymail.ca (Postfix) with ESMTPA id 87721E0E2D;
 Mon,  6 Jun 2022 16:35:29 +0000 (UTC)
Received: from [192.168.1.4] (internal [192.168.1.4])
 by mail.gonehiking.org (Postfix) with ESMTP id 689583EF5B;
 Mon,  6 Jun 2022 10:35:28 -0600 (MDT)
Message-ID: <d39fc9bb-07c1-ad74-1e89-d2aa80578cd4@gonehiking.org>
Date: Mon, 6 Jun 2022 10:35:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/6] scsi: remove stale BusLogic driver
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>
References: <20220606084109.4108188-1-arnd@kernel.org>
 <20220606084109.4108188-6-arnd@kernel.org>
From: Khalid Aziz <khalid@gonehiking.org>
In-Reply-To: <20220606084109.4108188-6-arnd@kernel.org>
X-Mailman-Approved-At: Mon, 06 Jun 2022 16:48:40 +0000
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Denis Efremov <efremov@linux.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Matt Wang <wwentao@vmware.com>, linux-parisc@vger.kernel.org,
 linux-alpha@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>, Robin Murphy <robin.murphy@arm.com>
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
Reply-To: khalid@gonehiking.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/6/22 02:41, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
> 
> The BusLogic driver is the last remaining driver that relies on the
> deprecated bus_to_virt() function, which in turn only works on a few
> architectures, and is incompatible with both swiotlb and iommu support.
> 
> Before commit 391e2f25601e ("[SCSI] BusLogic: Port driver to 64-bit."),
> the driver had a dependency on x86-32, presumably because of this
> problem. However, the change introduced another bug that made it still
> impossible to use the driver on any 64-bit machine.
> 
> This was in turn fixed in commit 56f396146af2 ("scsi: BusLogic: Fix
> 64-bit system enumeration error for Buslogic"), 8 years later.
> 
> The fact that this was found at all is an indication that there are
> users, and it seems that Maciej, Matt and Khalid all have access to
> this hardware, but if it took eight years to find the problem,
> it's likely that nobody actually relies on it.
> 
> Remove it as part of the global virt_to_bus()/bus_to_virt() removal.
> If anyone is still interested in keeping this driver, the alternative
> is to stop it from using bus_to_virt(), possibly along the lines of
> how dpt_i2o gets around the same issue.
> 
> Cc: Maciej W. Rozycki<macro@orcam.me.uk>
> Cc: Matt Wang<wwentao@vmware.com>
> Cc: Khalid Aziz<khalid@gonehiking.org>
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> ---
>   Documentation/scsi/BusLogic.rst   |  581 ---
>   Documentation/scsi/FlashPoint.rst |  176 -
>   MAINTAINERS                       |    7 -
>   drivers/scsi/BusLogic.c           | 3727 --------------
>   drivers/scsi/BusLogic.h           | 1284 -----
>   drivers/scsi/FlashPoint.c         | 7560 -----------------------------
>   drivers/scsi/Kconfig              |   24 -
>   7 files changed, 13359 deletions(-)
>   delete mode 100644 Documentation/scsi/BusLogic.rst
>   delete mode 100644 Documentation/scsi/FlashPoint.rst
>   delete mode 100644 drivers/scsi/BusLogic.c
>   delete mode 100644 drivers/scsi/BusLogic.h
>   delete mode 100644 drivers/scsi/FlashPoint.c

I would say no to removing BusLogic driver. Virtualbox is another 
consumer of this driver. This driver is very old but I would rather fix 
the issues than remove it until we do not have any users.

Thanks,
Khalid
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
