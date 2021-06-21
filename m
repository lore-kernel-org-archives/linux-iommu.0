Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4921C49EA5
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 13:16:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345F560240
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 13:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345F560240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D78E640256;
	Mon, 21 Jun 2021 13:16:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oFeHUkv6S4_G; Mon, 21 Jun 2021 13:16:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D2705400CF;
	Mon, 21 Jun 2021 13:16:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2543C0010;
	Mon, 21 Jun 2021 13:16:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B96BC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 13:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0495F83139
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 13:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFY-SF4a2Gef for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 13:16:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DAA980FBC
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 13:16:48 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id d196so30239587qkg.12
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9XTlsTLlkBEYe8ol8LyyT7LEeIfS9A4b08iDrrekDpY=;
 b=PIRykwMfGGjSO6qdHCfr4joaEAUov0orGAxskj8/4IwUE9JkgEGsPwyZ4uVFVrCAKl
 gx4DI7WYSvqTHffT5X+Yqq7iWyWKCZzRbfivFCbeot6s2hriwbR/cqsSdiQ2fANdMWbS
 RE1GOcwvRGDnKpHdSwIsd2rVyxFwLft3HAYsnVy9UqMqSJvYBq7FMJ5vcw1qcdZRByvT
 i+c8Sa1aGBsX7xFow/gE44AahIVvryWi12YvetWwUgUeAjK8cCWdBLavaBGouC0FrV9D
 Lzx08oHVaXI3PmiPkIXTRUZKdNYRjxq56r1N9u50YiLgBx3xf5NXgh8tZONpzQkKHmUC
 zx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=9XTlsTLlkBEYe8ol8LyyT7LEeIfS9A4b08iDrrekDpY=;
 b=cgwecKV2aB6vfqvT2I5exyfVvjbDG8qm1cLp99EM56AqA4ZCQItoyf1ysvUOrctWbe
 gbYP4OmQ4LrjTd2QKXOP6HSQ8npC6exjb8tpuRstbTBGv80y8W2e3qHoegnxvH3Z5slT
 MxHGImYKNabQJVk5Rr7/jQ/IUeQz5DJhs+OMk4VfqLcKuyIHJBOhTTYkeOlnLna3OOxJ
 YKtW4cdU6WilgPGVCokQvpjgmnHlZwPe1M2XwqhS2eoyv8of1lyQ6MKeJ8b/W/mDwx0k
 Q0GkbfAYYOOMoe+yzpHx2AWcWHkrkjciCX0f2/RgekgScL0ZH4lqY9hxkgr0VUj2ODUU
 I2uw==
X-Gm-Message-State: AOAM532k862fW4oRL3Dhrt2OKOvquwUyWsOj28MmqhIb35wVmg/TW3Eb
 sQg1pmkX+wC7XW6VHUOhY4E=
X-Google-Smtp-Source: ABdhPJyDFz+1dqhOAcIIkMWa6Sliq8B7hHaFaIFozLG71wqA8DbP1fs2hyPnYIkqc7WIL219TwVIjQ==
X-Received: by 2002:a37:8407:: with SMTP id g7mr23434618qkd.123.1624281407788; 
 Mon, 21 Jun 2021 06:16:47 -0700 (PDT)
Received: from fedora ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id h12sm9710218qkj.52.2021.06.21.06.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 06:16:46 -0700 (PDT)
Date: Mon, 21 Jun 2021 09:16:43 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YNCROxI328u7IKdQ@fedora>
References: <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora> <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
 <CGME20210621020328epcas2p207e9fa2df119730ceb993543621437d8@epcas2p2.samsung.com>
 <YM/zWyZlk1bzHWgI@atmark-techno.com>
 <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
 <YNASOEGsDxhFC8qJ@atmark-techno.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNASOEGsDxhFC8qJ@atmark-techno.com>
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

On Mon, Jun 21, 2021 at 01:14:48PM +0900, 'Dominique MARTINET' wrote:
> Chanho Park wrote on Mon, Jun 21, 2021 at 11:55:22AM +0900:
> > Sure. No problem. But, the patch was already stacked on Konrad's tree
> > and linux-next as well.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/commit/?h=devel/for-linus-5.14&id=33d1641f38f0c327bc3e5c21de585c77a6512bc6 
> 
> That patch is slightly different, it's a rewrite Konrad did that mixes
> in Linus' suggestion[1], which breaks things for the NVMe usecase
> Jianxiong Gao has.
> 
> [1] offset = (tlb_addr - mem->start) & (IO_TLB_SIZE - 1)
> 
> 
> Konrad is aware so I think it shouldn't be submitted :)

The beaty of 'devel' and 'linux-next' is that they can be reshuffled and
mangled. I pushed them original patch from Bumyong there and will let
it sit for a day and then create a stable branch and give it to Linus.

Then I need to expand the test-regression bucket so that this does not
happen again. Dominique, how easy would it be to purchase one of those
devices?

I was originally thinking to create a crypto device in QEMU to simulate
this but that may take longer to write than just getting the real thing.

Or I could create some fake devices with weird offsets and write a driver
for it to exercise this.. like this one I had done some time ago that
needs some brushing off.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
