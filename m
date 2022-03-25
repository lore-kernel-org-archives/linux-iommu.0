Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C85C43217
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 16:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B19BC60AE5;
	Fri, 25 Mar 2022 16:32:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DFViJLFo0OuY; Fri, 25 Mar 2022 16:32:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E2B3607F0;
	Fri, 25 Mar 2022 16:32:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 673F4C002C;
	Fri, 25 Mar 2022 16:32:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C03D4C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC6B640168
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L12dNUCx5QIb for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 16:32:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECECD40158
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 16:32:08 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id EBAC468B05; Fri, 25 Mar 2022 17:32:04 +0100 (CET)
Date: Fri, 25 Mar 2022 17:32:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Message-ID: <20220325163204.GB16426@lst.de>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
 <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
 <CAHk-=wip7TCD_+2STTepuEZvGMg6wcz+o=kyFUvHjuKziTMixw@mail.gmail.com>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324190216.0efa067f.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220324190216.0efa067f.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Mar 24, 2022 at 07:02:16PM +0100, Halil Pasic wrote:
> > If 
> > ddbd89deb7d3 alone turns out to work OK then I'd be inclined to try a 
> > partial revert of just that one hunk.
> >
> 
> I'm not against being pragmatic and doing the partial revert. But as
> explained above, I do believe for correctness of swiotlb we ultimately
> do need that change. So if the revert is the short term solution,
> what should be our mid-term road-map?

Unless I'm misunderstanding this thread we found the bug in ath9k
and have a fix for that now?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
