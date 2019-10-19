Return-Path: <SRS0=Xbod=YM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C35CA9EAD
	for <iommu@archiver.kernel.org>; Sat, 19 Oct 2019 05:38:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAE3222C5
	for <iommu@archiver.kernel.org>; Sat, 19 Oct 2019 05:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2ArurjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAE3222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3E3CFAF0;
	Sat, 19 Oct 2019 05:38:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 38B702F
	for <iommu@lists.linux-foundation.org>;
	Sat, 19 Oct 2019 05:38:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 708B9608
	for <iommu@lists.linux-foundation.org>;
	Sat, 19 Oct 2019 05:37:59 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id g13so6765678otp.8
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=dZD1rhZmQDM/H+GbTbYnSSIXxS9iO4DRfvqaZaVLmHA=;
	b=I2ArurjZWxXb7+XpLicdsV0rlFMZFv7gBdh8euQxI0hZMDcpnlpIoJZu5ltMe9sWnb
	DMG+2YBnDafJ9umzHpMqXhkhj8pHS4XAOZ0TDHp/p4y+cMp1hx3IHzeWCuB39zcqgjfj
	msjJ1LArDkb6x6lsD8lb1dJ5GD204iI8auQKUnK539L4cpwBf/8UM1kNERPkdY+d/W66
	P3H41YvHbbcfSy2/P+MzhkN72fgSNkI1nzurPybrCZqAzztSOhcEaDbR09FqlasCoovs
	kXvovL0pU9ESneKb2ZJioZPYRBxw23HwTU2ZRSGD1TRQR7AgDrGP6LcPUVNL0U7swV7S
	YbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=dZD1rhZmQDM/H+GbTbYnSSIXxS9iO4DRfvqaZaVLmHA=;
	b=C1FzGyi2mMEnVP9h3UhyFQp9qoe7Nk8SiH3kVCNU8C6yZvy5y0XVjcp9tHWtHxZa1/
	Y7UHIA9SLwJplp9u2yWmz0K5ivDsdk7e/jUNMoGh7bCnAGXBLj1g1+FgYAo0zkAfeINc
	Gxcb6TaL0RiLfPH3dQWaNR8wd9xwQNh8A7JI7mEd3XUhr6H7uKqQP59sWme2LbRqLHJf
	XmqR7TtCumplg1mokvqigUIeJu9AlT/VRHSyke3XHyMhA6TR0YuRLTRpt0dhkJyyaJ6N
	lUoaVTE5uJj3R9YzHMTyuDGP4bE9MkEhYELupCGFJFNVs5Aadk9dWR8SJ0yIiFW4bn+N
	11+A==
X-Gm-Message-State: APjAAAUudUEDOkPXpns6W2xlRIqE5qutYW88WnqnyrVGKtbMkPAE04J2
	iwYibUxG6OTGQSWk+fbT6DykSnY3oeJHw2dpExI=
X-Google-Smtp-Source: APXvYqxWRplW90eHZs/5G1y76NalbYYyDOet1jwKXgcM26aLqw7XHltBJMnUYIgx0qdZyyIcHCdpk3LqAa+mZJoGEFY=
X-Received: by 2002:a9d:6e1a:: with SMTP id e26mr10354403otr.307.1571463478507;
	Fri, 18 Oct 2019 22:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191012122918.8066-1-mayhs11saini@gmail.com>
	<95842b81-c751-abed-dd3f-258b9fd70393@arm.com>
In-Reply-To: <95842b81-c751-abed-dd3f-258b9fd70393@arm.com>
From: Shyam Saini <mayhs11saini@gmail.com>
Date: Sat, 19 Oct 2019 11:07:47 +0530
Message-ID: <CAOfkYf7iEe8A0gFB6XG2RDfkHxQtdM_CUZFnsZADedsyMAm8+A@mail.gmail.com>
Subject: Re: [PATCH] kernel: dma: Make CMA boot parameters __ro_after_init
To: Robin Murphy <robin.murphy@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
	Christopher Lameter <cl@linux.com>, Christoph Hellwig <hch@lst.de>
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

Hi Robin,

Sorry for the late reply.


> This parameters are not changed after early boot.
> > By making them __ro_after_init will reduce any attack surface in the
> > kernel.
>
> At a glance, it looks like these are only referenced by a couple of
> __init functions, so couldn't they just be __initdata/__initconst?

yes, You are right it is only used by __init calls and not used anywhere else.

I will resend the updated version.

Thanks a lot for the feedback.


> > Link: https://lwn.net/Articles/676145/
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Christopher Lameter <cl@linux.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
> > ---
> >   kernel/dma/contiguous.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 69cfb4345388..1b689b1303cd 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -42,10 +42,10 @@ struct cma *dma_contiguous_default_area;
> >    * Users, who want to set the size of global CMA area for their system
> >    * should use cma= kernel parameter.
> >    */
> > -static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> > -static phys_addr_t size_cmdline = -1;
> > -static phys_addr_t base_cmdline;
> > -static phys_addr_t limit_cmdline;
> > +static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> > +static phys_addr_t __ro_after_init size_cmdline = -1;
> > +static phys_addr_t __ro_after_init base_cmdline;
> > +static phys_addr_t __ro_after_init limit_cmdline;
> >
> >   static int __init early_cma(char *p)
> >   {
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
