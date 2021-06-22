Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A5C48BE5
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 21:58:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37F46137D
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 21:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37F46137D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9EFD040257;
	Tue, 22 Jun 2021 21:58:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3P7DxklFaiSh; Tue, 22 Jun 2021 21:58:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 831A0400C8;
	Tue, 22 Jun 2021 21:58:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A40AC0010;
	Tue, 22 Jun 2021 21:58:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E56C6C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 21:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB99D605BB
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 21:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7o9Pii5EhLnV for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 21:58:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9A5B60592
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 21:58:18 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id q190so193008qkd.2
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=An1CO7YkpX2LBRNnkvDhYRhDtsz5fNak0K0KltYMWHE=;
 b=G9hBpWsQA2qNJz6g8CmPS+fbzFFLh6rh7G15fLU4ZxcRyaU3QSU29x7NyPYmR8Ia/D
 n2B54HijZUbq2DwnXWIWTFpUjhpze+X82aSP8/LcdWVkRmYDlQxoRlHKyIo+qqE8FP9Q
 bZJ9oAe/6/gP2bUYJ5ZFFroBuXxolJekjgy3qddtVuXERWKt1Jcy1EIQjqWkw0C51ysM
 haXf2JVkp1uwcRw012LkgvKNWWUzIMpmOT1ctB0SsxOitZmrdQ5OIq+Lf5VI1fWUL5+I
 R8kn030r+rgR07DGG1Tpi11b0k3Is/XKRw94yDYcdtEwn5ozVyEdHEmcFv6vnQqH4GC8
 /eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=An1CO7YkpX2LBRNnkvDhYRhDtsz5fNak0K0KltYMWHE=;
 b=aPQTCt0EjjrgIDXK48rpVPM+jxHwZQDL3RZPeNSX30d0s9OdCPT031sCCsQ58lzpNd
 9cyT44+LsQNlk4KDlZmzxWspxNMC/dz3evQDKzrQ9Hr+Hf9rjG3uNqsCiMNuvqveZ/jw
 QaVKXtuvsTvgtSxvm8OolWjqRvKIsrwJMStjEWyiJzbuLxH5KPcjRPabeiUR1at5bFbi
 d+BzNuMR6pMVt0RQ7dJ0GgxxUvRQpcSjEhDzvqX7kTMijuPBe/gCbseHN3YCMXf8XOWA
 TCAsjCn6GqxACq3gB8ev7g++ix5w5O7Y2u6VSw1d6OX87TyoLtQ9amJ9ns5XgKQZXs0q
 wDJg==
X-Gm-Message-State: AOAM532jWaMJBhUTbhQj40KW6ABHeYKaFeZ7ZV2mESeoznaJoLEh6DKJ
 BFziuhqb72yEOPaoaKxO1gE=
X-Google-Smtp-Source: ABdhPJxrJylyDE4d1u5hNmra4JCUXIlB65RCzJZS6mL8q5Nn7+pP3O583qQWV0u07LTl8dOSRnF9RA==
X-Received: by 2002:a05:620a:4509:: with SMTP id
 t9mr6703948qkp.403.1624399097540; 
 Tue, 22 Jun 2021 14:58:17 -0700 (PDT)
Received: from fedora ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id 85sm12802577qkl.46.2021.06.22.14.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 14:58:16 -0700 (PDT)
Date: Tue, 22 Jun 2021 17:58:14 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YNJc9qxeIjy6VuLt@fedora>
References: <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
 <CGME20210621020328epcas2p207e9fa2df119730ceb993543621437d8@epcas2p2.samsung.com>
 <YM/zWyZlk1bzHWgI@atmark-techno.com>
 <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
 <YNASOEGsDxhFC8qJ@atmark-techno.com> <YNCROxI328u7IKdQ@fedora>
 <YNGVyOyD+CAMmPos@atmark-techno.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNGVyOyD+CAMmPos@atmark-techno.com>
Cc: 'Aymen Sghaier' <aymen.sghaier@nxp.com>,
 'Herbert Xu' <herbert@gondor.apana.org.au>,
 'Horia =?utf-8?Q?Geant=C4=83'?= <horia.geanta@nxp.com>,
 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
 'Marc Orr' <marcorr@google.com>, 'Lukas Hartmann' <lukas@mntmn.com>,
 linux-kernel@vger.kernel.org, "'David S. Miller'" <davem@davemloft.net>,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 'Peter Gonda' <pgonda@google.com>, Chanho Park <chanho61.park@samsung.com>,
 'Bumyong Lee' <bumyong.lee@samsung.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 'Christoph Hellwig' <hch@lst.de>, 'Jianxiong Gao' <jxgao@google.com>
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

On Tue, Jun 22, 2021 at 04:48:24PM +0900, 'Dominique MARTINET' wrote:
> Konrad Rzeszutek Wilk wrote on Mon, Jun 21, 2021 at 09:16:43AM -0400:
> > The beaty of 'devel' and 'linux-next' is that they can be reshuffled and
> > mangled. I pushed them original patch from Bumyong there and will let
> > it sit for a day and then create a stable branch and give it to Linus.
> 
> Thanks, that should be good.
> 
> Do you want me to send a follow-up patch with the two extra checks
> (tlb_addr & (IO_TLB_SIZE -1)) > swiotlb_align_offset(dev, orig_addr)
> tlb_offset < alloc_size
> 
> or are we certain this can't ever happen?

I would love more patches and I saw the previous one you posted.

But we only got two (or one) weeks before the next merge window opens
so I am sending to Linus the one that was tested with NVMe and crypto
(see above).

That is the
https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/commit/?h=stable/for-linus-5.14

And then after Linus releases the 5.14 - I would love to take your
cleanup on top of that and test it?

> (I didn't see any hit in dmesg when I ran with these, but my opinion is
> better safe than sorry...)
> 
> 
> > Then I need to expand the test-regression bucket so that this does not
> > happen again. Dominique, how easy would it be to purchase one of those
> > devices?
> 
> My company is making such a device, but it's not on the market yet
> (was planned for august, with some delay in approvisionning it'll
> probably be a bit late), and would mean buying from Japan so I'm not
> sure how convenient that would be...
> 
> These are originally NXP devices so I assume Horia would have better
> suggestions, if you would?
> 
> 
> > I was originally thinking to create a crypto device in QEMU to simulate
> > this but that may take longer to write than just getting the real thing.
> > 
> > Or I could create some fake devices with weird offsets and write a driver
> > for it to exercise this.. like this one I had done some time ago that
> > needs some brushing off.
> 
> Just a fake device with fake offsets as a test is probably good enough,
> ideally would need to exerce both failures we've seen (offset in
> dma_sync_single_for_device like caam does and in the original mapping (I
> assume?) like the NVMe driver does), but that sounds possible :)

Yup. Working on that now.
> 
> 
> Thanks again!
> -- 
> Dominique
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
