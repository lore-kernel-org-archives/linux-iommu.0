Return-Path: <SRS0=85Jd=UY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742DDC48BD6
	for <iommu@archiver.kernel.org>; Tue, 25 Jun 2019 07:27:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C78212F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jun 2019 07:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C78212F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 00D37AAE;
	Tue, 25 Jun 2019 07:27:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 00963A95
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 07:27:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4A775883
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 07:27:01 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id s20so16263873otp.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 00:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1Qkw0w8lvC08c786EpQGX2PIdXmdvbYBqHXJse34m3o=;
	b=HsVWVz+l7TaP3N6C+Cq7p9RdH1yXoBomRtqkWJEnBAZMAeQmL1RE6oRebhftLN0Owd
	pETR5kCFw7GyjGuWL+5UyF/meWYMWMgdZu7w3Vhxpde7UIRcQDdnx2RQ+l9U9vWCT3vs
	SIzta7H+KYF73a/IdA+zpp5Eob0ww0BdtTpzgmvxfVefMQEGbfV5LV6IrWu+L6sd3DbQ
	KjxBRnlWhuASy2XZvH37c826ClT9uY0Kwonk/1+Zq0IFqrT7XawzjHY2MQBUN3Yo/2ou
	MZ4OSvL0Q8q+RAFVzdPy6AUaRQ650puGmbRNmAKZvnDE14pLXmX7Pn7JmUsIH7nRjIj8
	CaJw==
X-Gm-Message-State: APjAAAUxn2c+GuxSl5ZcCmUsEDgpBxTZVUUstPhNpv6G+BmRPCMVlgVz
	sDEfrQMhxWJCHdbKaN7F8DtAfxLCTJiBJav/krc=
X-Google-Smtp-Source: APXvYqz5kpjmhQHLOOOnAPAkjsha+t1aYf/sUnzuNLLExvWSDtZeQwEE89t+NM6TZLU8/dKbki7oQhlqiOonWEwRSj8=
X-Received: by 2002:a9d:529:: with SMTP id 38mr16990865otw.145.1561447620546; 
	Tue, 25 Jun 2019 00:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190614102126.8402-1-hch@lst.de>
	<CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
	<20190625063228.GA29561@lst.de>
In-Reply-To: <20190625063228.GA29561@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Jun 2019 09:26:48 +0200
Message-ID: <CAMuHMdUNwERTRg4MbkkD62EtNhsU7kWVy6x4kB89rYh6ann0Pw@mail.gmail.com>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To: Christoph Hellwig <hch@lst.de>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

On Tue, Jun 25, 2019 at 8:33 AM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 17, 2019 at 08:53:55PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jun 14, 2019 at 12:21 PM Christoph Hellwig <hch@lst.de> wrote:
> > > can you take a look at the (untested) patches below?  They convert m68k
> > > to use the generic remapping DMA allocator, which is also used by
> > > arm64 and csky.
> >
> > Thanks. But what does this buy us?
>
> A common dma mapping code base with everyone, including supporting
> DMA allocations from atomic context, which the documentation and
> API assume are there, but which don't work on m68k.

OK, thanks!

> > bloat-o-meter says:
> >
> > add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)
>
> What do these values stand for?  The code should grow a little as
> we now need to include the the pool allocator for the above API
> fix.

Last 3 values are "bytes added/removed (net increase)".
So this increases the static kernel size by ca. 4 KiB.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
