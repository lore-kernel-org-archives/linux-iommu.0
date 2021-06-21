Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2707C48BE5
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 04:15:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424936120D
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 04:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424936120D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 002CF40352;
	Mon, 21 Jun 2021 04:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UufLiIFlHOTS; Mon, 21 Jun 2021 04:15:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7133D40322;
	Mon, 21 Jun 2021 04:15:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44567C000E;
	Mon, 21 Jun 2021 04:15:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2E15C000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 04:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B67E083906
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 04:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rftFJmd-o4dP for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 04:15:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1372838DE
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 04:15:04 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by gw2.atmark-techno.com (Postfix) with ESMTPS id 4256920D04
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 13:15:03 +0900 (JST)
Received: by mail-pj1-f70.google.com with SMTP id
 u12-20020a17090abb0cb029016ee12ec9a1so8915376pjr.3
 for <iommu@lists.linux-foundation.org>; Sun, 20 Jun 2021 21:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0cNPlfrR3mHT9UabyMptbK269y7CX6VJikwsTnrJUAE=;
 b=V79npuFPQLbTRlAcxjdxfwQP59cDTwEZq0ZRsIuAWLcTtMgeUIGAbB2tEHbyQqiN6I
 YRgi088tEnj7eXsL3Z0kalx5r9BN6Qc1lXW0JhjBTP8Sv6H5IcMM8qUumRQiSShuQL+x
 bc3qQWNZ2HDC5IxOkRDXDQ744eyYbZfZBo09p6pq5fQHsq99eXohTA7hXaW+LmRO5IMZ
 /ED/RO5Mt4Kk0g95vUsY7rO/qkpZClX8dc+SOCB0gSgCYamf5MB/kioZ7ct+/ZzsW//6
 Mpw7tU4XiFyHkrbdBUMLSw3q+ASGD4tgiK4Izd5kYNUpSpHe561Z9JFHSgAjjqxYgCOJ
 IrBA==
X-Gm-Message-State: AOAM530sqPJvnexfVf/hUqroYU/REg2X5Pi1N8mSutp+PxA0pDhpbiBc
 uGNobWuS9SkOf8Qr6ZONUarE620kBFV8GkCP2JweTkMJHlgbWs4xokGO+RYK2oEFvwRTO4zOLvf
 2lwUa0HmNQoBgWrtrQkzvdgFS7+6hp+g=
X-Received: by 2002:a63:db43:: with SMTP id x3mr21772894pgi.383.1624248902411; 
 Sun, 20 Jun 2021 21:15:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwABzUQPm9SUU6k+/MVNgSXR0PAbNKc3mtW3pmxgxtF5tFRcVYbJO4+Phv3wJkMa6wTECEmiQ==
X-Received: by 2002:a63:db43:: with SMTP id x3mr21772865pgi.383.1624248902163; 
 Sun, 20 Jun 2021 21:15:02 -0700 (PDT)
Received: from pc-0115 (117.209.187.35.bc.googleusercontent.com.
 [35.187.209.117])
 by smtp.gmail.com with ESMTPSA id t3sm1594918pfl.44.2021.06.20.21.15.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Jun 2021 21:15:01 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
 (envelope-from <martinet@pc-0115>)
 id 1lvBKs-001Ecg-KK; Mon, 21 Jun 2021 13:14:58 +0900
Date: Mon, 21 Jun 2021 13:14:48 +0900
From: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
To: Chanho Park <chanho61.park@samsung.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YNASOEGsDxhFC8qJ@atmark-techno.com>
References: <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora> <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
 <CGME20210621020328epcas2p207e9fa2df119730ceb993543621437d8@epcas2p2.samsung.com>
 <YM/zWyZlk1bzHWgI@atmark-techno.com>
 <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
Cc: 'Aymen Sghaier' <aymen.sghaier@nxp.com>,
 'Herbert Xu' <herbert@gondor.apana.org.au>,
 'Horia =?utf-8?Q?Geant=C4=83'?= <horia.geanta@nxp.com>,
 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
 'Marc Orr' <marcorr@google.com>, 'Lukas Hartmann' <lukas@mntmn.com>,
 linux-kernel@vger.kernel.org, "'David S. Miller'" <davem@davemloft.net>,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 'Peter Gonda' <pgonda@google.com>, 'Konrad Rzeszutek Wilk' <konrad@darnok.org>,
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

Chanho Park wrote on Mon, Jun 21, 2021 at 11:55:22AM +0900:
> Sure. No problem. But, the patch was already stacked on Konrad's tree
> and linux-next as well.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/commit/?h=devel/for-linus-5.14&id=33d1641f38f0c327bc3e5c21de585c77a6512bc6 

That patch is slightly different, it's a rewrite Konrad did that mixes
in Linus' suggestion[1], which breaks things for the NVMe usecase
Jianxiong Gao has.

[1] offset = (tlb_addr - mem->start) & (IO_TLB_SIZE - 1)


Konrad is aware so I think it shouldn't be submitted :)

-- 
Dominique
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
