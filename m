Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E61C48BDF
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 07:48:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B846128C
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 07:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B846128C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE5C483216;
	Tue, 22 Jun 2021 07:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LiZagolExhtK; Tue, 22 Jun 2021 07:48:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECBF3831A2;
	Tue, 22 Jun 2021 07:48:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94D65C001A;
	Tue, 22 Jun 2021 07:48:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA5BC000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 07:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BF6C6063B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 07:48:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ogNyP7tBcH_S for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 07:48:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
 by smtp3.osuosl.org (Postfix) with ESMTP id 513DD60636
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 07:48:40 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by gw2.atmark-techno.com (Postfix) with ESMTPS id 95BD620D12
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 16:48:39 +0900 (JST)
Received: by mail-pl1-f199.google.com with SMTP id
 o7-20020a1709026b07b029011a0d4de43dso5992908plk.5
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 00:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K2/PCim2TgrlrpWsUBXXxC0v9+AUPcQxYb8PsC1cUMs=;
 b=R9RFN6AyN/7P50BrxurOj+dR3tNSWShLEjAaqsmGZnZDedoXR8dHqbgsXzuA1ijpQu
 NBpivP5L7ihy3szjTtdqh1DW8wqUUZ8thdt1tpD2B/6p7TlgsnD1z6gh670UKIAZlLc/
 zqgvkwaxHJFL+G+GTpbQKCuA4IKDLxvSNjj4ScM/5DxGJr7ve1b3MFQStx3jDB5kUs3q
 vy9SWN6RV8uqmxMsnOZUxMSDC2GjPdsf9qYz9US1djirOO7yS5p5GTGdpE+utzxyiwyl
 A2ek40d+jQ5c5SIesafYhPFKIrIw70gAM2cX7RjInZ04a83BbKGk0V1gPkoD5sOlOXaq
 BH7A==
X-Gm-Message-State: AOAM532AaOen3vE9+WH9E5FOmnJM9B6KX85k20ypB5LYfwEiA8Iqkz15
 2Yxr2sroePG6IzRak89NmATJQW8Fw0k7kcIM7EnVZ8uBmEaLBCG0aUdNqP7Gjgwf8JDUvE/KecF
 eFA/ddhJtRA2k2QxoIQfcjaXkfSr63p8=
X-Received: by 2002:a17:90a:4812:: with SMTP id
 a18mr2670008pjh.40.1624348118681; 
 Tue, 22 Jun 2021 00:48:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfgoRVVp6JmSP2/8H6vwINnTVMm7MriWlKRzk6O1jIIF/9JeL5ZPHTpSyHUlltCbzyiAQDkQ==
X-Received: by 2002:a17:90a:4812:: with SMTP id
 a18mr2669988pjh.40.1624348118458; 
 Tue, 22 Jun 2021 00:48:38 -0700 (PDT)
Received: from pc-0115 (178.101.200.35.bc.googleusercontent.com.
 [35.200.101.178])
 by smtp.gmail.com with ESMTPSA id n12sm7972919pfu.5.2021.06.22.00.48.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jun 2021 00:48:37 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
 (envelope-from <martinet@pc-0115>)
 id 1lvb98-002Mj2-Pa; Tue, 22 Jun 2021 16:48:34 +0900
Date: Tue, 22 Jun 2021 16:48:24 +0900
From: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YNGVyOyD+CAMmPos@atmark-techno.com>
References: <YMqW+/gQvM+uWUTw@fedora> <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
 <CGME20210621020328epcas2p207e9fa2df119730ceb993543621437d8@epcas2p2.samsung.com>
 <YM/zWyZlk1bzHWgI@atmark-techno.com>
 <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
 <YNASOEGsDxhFC8qJ@atmark-techno.com> <YNCROxI328u7IKdQ@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNCROxI328u7IKdQ@fedora>
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

Konrad Rzeszutek Wilk wrote on Mon, Jun 21, 2021 at 09:16:43AM -0400:
> The beaty of 'devel' and 'linux-next' is that they can be reshuffled and
> mangled. I pushed them original patch from Bumyong there and will let
> it sit for a day and then create a stable branch and give it to Linus.

Thanks, that should be good.

Do you want me to send a follow-up patch with the two extra checks
(tlb_addr & (IO_TLB_SIZE -1)) > swiotlb_align_offset(dev, orig_addr)
tlb_offset < alloc_size

or are we certain this can't ever happen?
(I didn't see any hit in dmesg when I ran with these, but my opinion is
better safe than sorry...)


> Then I need to expand the test-regression bucket so that this does not
> happen again. Dominique, how easy would it be to purchase one of those
> devices?

My company is making such a device, but it's not on the market yet
(was planned for august, with some delay in approvisionning it'll
probably be a bit late), and would mean buying from Japan so I'm not
sure how convenient that would be...

These are originally NXP devices so I assume Horia would have better
suggestions, if you would?


> I was originally thinking to create a crypto device in QEMU to simulate
> this but that may take longer to write than just getting the real thing.
> 
> Or I could create some fake devices with weird offsets and write a driver
> for it to exercise this.. like this one I had done some time ago that
> needs some brushing off.

Just a fake device with fake offsets as a test is probably good enough,
ideally would need to exerce both failures we've seen (offset in
dma_sync_single_for_device like caam does and in the original mapping (I
assume?) like the NVMe driver does), but that sounds possible :)


Thanks again!
-- 
Dominique
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
