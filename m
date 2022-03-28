Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC4AC4332F
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 09:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AE6F40591;
	Mon, 28 Mar 2022 09:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Os0i0AsX7VS; Mon, 28 Mar 2022 09:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB17B4054A;
	Mon, 28 Mar 2022 09:57:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B25B8C001D;
	Mon, 28 Mar 2022 09:57:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 565F4C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44A5440554
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5NkjPjLEsyR9 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 09:57:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:4433::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BA0C40448
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=zDjy6QdYMZfzrDBM8z3vmKyXyiyg4NDUsUB16DZQfq4=; 
 t=1648461464; x=1649671064; b=UH6b4NIvopRVAzMa3bCp21YnfgYRvz2wKKPlyNtOm/5l7Bx
 zidQmCp78kWhq94JmnVBI4Sjp6hftur7hpIxHYsyfot3b240KdM+iIJnJR2yfvzumMWj4tTQT551K
 tT7Uxyzq/GxMKif6riOAe9s1pJV1ZEL0hLA4ewpRwWP8x99T1GPTK4JEpw+KB5FbRAv/XT4BR+Eh0
 sQlsS4TIoJ+FIo35KVxww8Ur2b4T4XSOxFbk+T2DirF2EPh7w4DQUfgMUivjYUd8Z/ULRi8ykQCkN
 uY/+VEnymDcNX6av1ziQYFxMIZ2NmjBYbQWUhRpx586dwvvL0sb2pTaKWWw4KwKA==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.95) (envelope-from <johannes@sipsolutions.net>)
 id 1nYm7v-001X9R-7G; Mon, 28 Mar 2022 11:57:31 +0200
Message-ID: <ab02e1298955d6f535928e2c34079973e656e3b8.camel@sipsolutions.net>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
From: Johannes Berg <johannes@sipsolutions.net>
To: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 28 Mar 2022 11:57:30 +0200
In-Reply-To: <bf9a4949635c01c5dec53b0e873eccec4e2b0d33.camel@sipsolutions.net>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com>
 <298f4f9ccad7c3308d3a1fd8b4b4740571305204.camel@sipsolutions.net>
 <CAHk-=whXAan2ExANMryPSFaBWeyzikPi+fPUseMoVhQAxR7cEA@mail.gmail.com>
 <e42e4c8bf35b62c671ec20ec6c21a43216e7daa6.camel@sipsolutions.net>
 <20220327051502.63fde20a.pasic@linux.ibm.com>
 <f94c4fc26251262de0ecab003c74833617c1b305.camel@sipsolutions.net>
 <bf9a4949635c01c5dec53b0e873eccec4e2b0d33.camel@sipsolutions.net>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Cc: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Netdev <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 2022-03-28 at 11:50 +0200, Johannes Berg wrote:
> No I worded that badly - the direction isn't useless, but thinking of it
> in terms of a buffer property rather than data movement is inaccurate.
> So then if we need something else to indicate how data was expected to
> be moved, the direction argument becomes useless, since it's not a
> buffer property but rather a temporal thing on a specific place that
> expected certain data movement.
> 

Yeah, umm. I should've read the whole thread of the weekend first, sorry
for the noise.

johannes
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
