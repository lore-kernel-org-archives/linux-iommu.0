Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43460C433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 18:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E055D610A2;
	Fri, 25 Mar 2022 18:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OLdVhIw_ybL4; Fri, 25 Mar 2022 18:15:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C4ADA606A0;
	Fri, 25 Mar 2022 18:15:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B3EEC002C;
	Fri, 25 Mar 2022 18:15:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB91C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B15C60783
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SwhWM3gXeVc3 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 18:15:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D180B606A0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
 t=1648232133; bh=0utGQUdnredYmwlCMqdQtSEkBccDpSSgRbC0K8pIlyE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=w6KsBX3PIGQNPBEgDloGd557TP6k0E++rJTP9enh7kdXUK8fIxK8ftlFsszFTkDqJ
 II+Y/Pgar/yJX6LDWXi3wvTO5jwnoNgZPUBUbZFGztXs4kAFdc5WiMPMD2h93vyAIV
 sHpYer3QEiC1v7Dkqh+TuWhgznbszU65z6D+NJ9WsKaIjQHHAgsPnJZY2z8q70XmrP
 onr1kPSQXO6u4FGkY6a53ST6TPH9eOX4hKDjTlEuDECQeSS3kUZihtZUFUgw131lWG
 FJj7lbn92eVVKRfL+qOZXdNSYBzv9KrFNJYpt58jEkoUh7mbwjy6sxdeFvrhyLKA2L
 qB6tWvUxyilfw==
To: Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
In-Reply-To: <20220325163204.GB16426@lst.de>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324190216.0efa067f.pasic@linux.ibm.com>
 <20220325163204.GB16426@lst.de>
Date: Fri, 25 Mar 2022 19:15:32 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y20x7vaz.fsf@toke.dk>
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Netdev <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= via iommu
 <iommu@lists.linux-foundation.org>
Reply-To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Mar 24, 2022 at 07:02:16PM +0100, Halil Pasic wrote:
>> > If 
>> > ddbd89deb7d3 alone turns out to work OK then I'd be inclined to try a 
>> > partial revert of just that one hunk.
>> >
>> 
>> I'm not against being pragmatic and doing the partial revert. But as
>> explained above, I do believe for correctness of swiotlb we ultimately
>> do need that change. So if the revert is the short term solution,
>> what should be our mid-term road-map?
>
> Unless I'm misunderstanding this thread we found the bug in ath9k
> and have a fix for that now?

According to Maxim's comment on the other subthread, that ath9k patch
wouldn't work on all platforms (and constitutes a bit of a violation of
the DMA API ownership abstraction). So not quite, I think?

-Toke
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
