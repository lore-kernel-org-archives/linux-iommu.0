Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACC7C43334
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 18:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2932140643;
	Fri, 17 Jun 2022 18:55:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2932140643
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=i+a+pQW8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GOdUZ6TgTxnT; Fri, 17 Jun 2022 18:55:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D93AB400D8;
	Fri, 17 Jun 2022 18:55:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D93AB400D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0EFAC0032;
	Fri, 17 Jun 2022 18:55:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1EC0C002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 18:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 876F041C0A
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 18:55:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 876F041C0A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net
 header.a=rsa-sha256 header.s=badeba3b8450 header.b=i+a+pQW8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IMqSwasLylSi for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 18:55:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C49541A37
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C49541A37
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1655492096;
 bh=5TERitrWUvvUfTI5MhjoAnMJtaxI+oi4yMzwuHPSIUs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i+a+pQW8GlxSWj07fLslQTwc24Fe6QepDIgw4YDFU5CRqlZtOLguwhOt5xQLqK59r
 aIyVp69kLQ950G7iYgrKcM08OyMGZ2dm7qX++OTpFYtscahIzIA/+WkZ3fVeG14gbR
 r+yzaXE0SuGkW7fl6rWgl5KPY9tLoyYjLVkYH8wM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.127] ([217.61.144.127]) by web-mail.gmx.net
 (3c-app-gmx-bap03.server.lan [172.19.172.73]) (via HTTP); Fri, 17 Jun 2022
 20:54:56 +0200
MIME-Version: 1.0
Message-ID: <trinity-a3fa3f57-696b-44f1-9440-63cd249d1568-1655492096670@3c-app-gmx-bap03>
From: Frank Wunderlich <frank-w@public-files.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Aw: Re: helping with remapping vmem for dma
Date: Fri, 17 Jun 2022 20:54:56 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <88080559-0c96-ec91-6f72-df05a2d0c5af@arm.com>
References: <trinity-2d26eb5e-6a3f-485a-aed7-134c1e164942-1655482643278@3c-app-gmx-bap03>
 <88080559-0c96-ec91-6f72-df05a2d0c5af@arm.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:NEHWw+yzysQMeV3UCczydEq2+A+cbQ0zKtwmSr3mWWJSVTqpr/npypc8nYI/Lj586NJZ8
 ZQdk6Dll3i+7Lt+GdW3tkpTctzcCH647OJopRuFd5KBEKImQ3T3735UbZYfuB43hER8UQerSWrUE
 DbDyN0V0fTc5aHyWuJqK/4wKy4HtVDvAw8vyBBkX8DJ64lzl6JLDdnK76o0FImdtly1cyKCBvFbf
 aHkEJ1+1wMyZ/rMzXfyUjiOu5C+cH489uun/J0whgoyHbhM9Hvhxk1y2JPHcvZmDl3ZIXxYI4Q63
 pc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:UxGlKHXmd08=:mO4sRPmbDS3nNfb4UPq1zD
 QL/3on00tn85Gwlp9cHm+SHcY07rN4H00WATjI9vgWy0erTIvxApS5KQybYJVc1iqw1afw6oJ
 CDWsjaq0bp89rnTXVq0uosv6bG2cHQZ2p8ztoqAR6G1Z4onmoB0cefui3tD2HbWQfA51Ge9ZA
 AelTe/1RhVQUd1dr9YkVfsmKnHWFioxWBxFmjfarcZB1Fi99zFybB+scNvLNN2w4v3TW8jaHI
 oB/XCJB4quMOlwF2K8dJFLp3rMaw50/AmUHui7Aani5rt5ipI7T3VST67f43qbvr6AWMyfRq+
 0C53RM+dqlCChFCe9RdxrlUi5saXtMzyHcNWl6NAj7/+hyWMBTgURsOa4DNoCe0erudLa3VV5
 Pm5keMe0gQTEMZoVlPoFiE7mnHVwSNNcGCOrZ2+LqgKJWRyhuz4KfORDOeouj3tB/FAPYPVnR
 cu0pSxyaM/Z3aZRur0rL90NVJCMX3obV0dkplYept+pMUGozKi3MQqwx7oyXHfce5PeAKB4FC
 CwzsElTEiAqpY0KyMnzoXsTpWWAXpf1QO3S4LcwygeAB5MPEpkZBhvnTQjKeQNwIc8OxIcPMw
 ukmTOi9KdfnYPaYF9tdOiwROHm5zpMY/b2hdCEhdZVLG0XLiLEPyokardiyfrgW4iKenlR3c6
 oOrRDGagOv/Uy3Dx3igqd1D6GCGqUVc+o74IDc5QCfsmhHZnVFg0dABjg0h1x/gCeC5ABmpIM
 fUlhN48hzoXGiq2/1xZ3kjyDy20I3ZUbAl3Z5LsNIy852vxNHLAmHDSQlkW96b0GwAyXggMAr
 S0BdvkF
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
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

> Gesendet: Freitag, 17. Juni 2022 um 19:22 Uhr
> Von: "Robin Murphy" <robin.murphy@arm.com>
> An: "Frank Wunderlich" <frank-w@public-files.de>, "Christoph Hellwig" <hch@lst.de>
> Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Marek Szyprowski" <m.szyprowski@samsung.com>
> Betreff: Re: helping with remapping vmem for dma
>
> On 2022-06-17 17:17, Frank Wunderlich wrote:
> > Am 15. Juni 2022 15:17:00 MESZ schrieb Christoph Hellwig <hch@lst.de>:
> >> On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
> >>> Put simply, if you want to call dma_map_single() on a buffer, then that
> >>> buffer needs to be allocated with kmalloc() (or technically alloc_pages(),
> >>> but then dma_map_page() would make more sense when dealing with entire
> >>> pages.
> >>
> >> Yes.  It sounds like the memory here comes from the dma coherent
> >> allocator, in which case the code need to use the address returned
> >> by that and not create another mapping.
> >
> > Hi
> >
> > traced it to buffer allocated as simple uint8-array [1]:
> >
> > UINT_8 aucBuffer[sizeof(INIT_HIF_RX_HEADER_T) + sizeof(INIT_EVENT_CMD_RESULT)];
>
> Ah, so it's trying to do DMA with a stack variable? CONFIG_DMA_API_DEBUG
> is your friend; it should have screamed about that specifically.
> Allocate this buffer properly to begin with, and free it again on the
> way out of the function (it's surely not worth having to make a
> temporary copy further down the callchain). The kmalloc flags can
> probably be regular GFP_KERNEL, unless this can be called from more
> restrictive contexts like an IRQ handler - the fact that it might be
> mapped for DMA later is essentially irrelevant in that respect.

Hi,

simply replaced the stack-vars to uint_8-pointers and using kmalloc/kfree for
memory handling (needed to replace some returns to goto to always free memory).

Thanks very much for support, driver is now working again :)

https://github.com/frank-w/BPI-R2-4.14/commit/7f3a721d5b0d8ca44935c23d5513a19cc57786c0

> Thanks,
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
