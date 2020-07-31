Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD621C433DF
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 14:15:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905BF206DA
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 14:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905BF206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4FD120385;
	Fri, 31 Jul 2020 14:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gciwokdT5cgk; Fri, 31 Jul 2020 14:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 58CEF20117;
	Fri, 31 Jul 2020 14:15:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4491EC004F;
	Fri, 31 Jul 2020 14:15:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0EB6C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9F9698868B
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P7LpLRs0QUfr for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 14:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A353388365
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 14:15:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9B82AAB8B;
 Fri, 31 Jul 2020 14:16:02 +0000 (UTC)
Message-ID: <d57334a4097e4615b01fdbcf7b5de0a0dc580b4e.camel@suse.de>
Subject: Re: dma-pool fixes
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 31 Jul 2020 16:15:48 +0200
In-Reply-To: <CAMi1Hd10=vZez7KhJYR688b9j-Sv6AM8EEDW8b8inYDXQk+6wg@mail.gmail.com>
References: <20200728104742.422960-1-hch@lst.de>
 <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
 <20200728120716.GA2507@lst.de>
 <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
 <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <a0c8eb70cedb05e310c2957a1c0f7968c1e39d53.camel@suse.de>
 <CAMi1Hd10=vZez7KhJYR688b9j-Sv6AM8EEDW8b8inYDXQk+6wg@mail.gmail.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Cc: jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, 2020-07-31 at 16:47 +0530, Amit Pundir wrote:
> On Fri, 31 Jul 2020 at 16:17, Nicolas Saenz Julienne

[...]

> > Ok, so lets see who's doing what and with what constraints:
> 
> Here is the relevant dmesg log: https://pastebin.ubuntu.com/p/dh3pPnxS2v/

Sadly nothing out of the ordinary, looks reasonable.

I have an idea, I've been going over the downstream device tree and it seems
the reserved-memory entries, specially the ones marked with 'no-map' don't
fully match what we have upstream. On top of that all these reserved areas seem
to fall into ZONE_DMA.

So, what could be happening is that, while allocating pages for the ZONE_DMA
atomic pool, something in the page allocator is either writing/mapping into a
reserved area triggering some kind of fault.

Amir, could you go over the no-map reserved-memory entries in the downstream
device-tree, both in 'beryllium-*.dtsi' (I think those are the relevant ones)
and 'sdm845.dtsi'[1], and make sure they match what you are using. If not just
edit them in and see if it helps. If you need any help with that I'll be happy
to give you a hand.

Regards,
Nicolas

[1] You could also extract the device tree from a device running with the
    downstream kernel, whatever is easier for you.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
