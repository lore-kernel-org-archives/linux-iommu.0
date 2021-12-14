Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CA5C433FE
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 14:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BA29402FE;
	Tue, 14 Dec 2021 14:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GJEERVcjPVTX; Tue, 14 Dec 2021 14:48:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 76D2140284;
	Tue, 14 Dec 2021 14:48:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A238C001E;
	Tue, 14 Dec 2021 14:48:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BDC2C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0859A40132
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACNlLE_hG9Jv for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:48:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F297640125
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:48:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C923E61541;
 Tue, 14 Dec 2021 14:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B98C34606;
 Tue, 14 Dec 2021 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639493327;
 bh=XSs0hwoBZKJiQwXo79v4ykpR7MoyXobF2GtdyXH8Igw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dLjDuhWiykgHlSirhPAAbWPY0E9aziSEZa17Um8F2TtWciH/ofX+oITQanU3rNJwZ
 b0HAYDtUj51I9CBSTsoEhoGaIhi7iRUXzP1oZOL8WpunFeT/OVrsm3nHMaY/eD/bIH
 oGffz9MUsGTWi9JW8yvF5pUgRLbo9Yc20pY1PDmOrb7j4HANhERoV8zeViLvgbpFlG
 vbJkpb4UbZDxwljyQ7bHAioLsfN3fBky1y1deaatNve9djJj5+i/e37oQLhrnz8/J1
 7rEKT8Yqjvz50/c4ncilJeXJVc9PJdsltzWb/CJq1iEBN2HnfYOyMhuC5Pxg/7v6rM
 yAxMkmfusSygg==
Date: Tue, 14 Dec 2021 14:48:42 +0000
From: Will Deacon <will@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] Revert "iommu/arm-smmu-v3: Decrease the queue size of
 evtq and priq"
Message-ID: <20211214144841.GB14837@willie-the-truck>
References: <1638858768-9971-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1638858768-9971-1-git-send-email-wangzhou1@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Dec 07, 2021 at 02:32:48PM +0800, Zhou Wang wrote:
> The commit f115f3c0d5d8 ("iommu/arm-smmu-v3: Decrease the queue size of
> evtq and priq") decreases evtq and priq, which may lead evtq/priq to be
> full with fault events, e.g HiSilicon ZIP/SEC/HPRE have maximum 1024 queues
> in one device, every queue could be binded with one process and trigger a
> fault event. So let's revert f115f3c0d5d8.
> 
> In fact, if an implementation of SMMU really does not need so long evtq
> and priq, value of IDR1_EVTQS and IDR1_PRIQS can be set to proper ones.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

I'd like an Ack from Zhen Lei on this, as the aim of the original patch
was to reduce memory consumption.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
