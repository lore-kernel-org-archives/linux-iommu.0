Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B833CC2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 23:04:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFBE60FD8
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 23:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFBE60FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B3FF40267;
	Tue, 22 Jun 2021 23:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZBq5MJeWcTHV; Tue, 22 Jun 2021 23:04:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10FDE401C7;
	Tue, 22 Jun 2021 23:04:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D858CC001A;
	Tue, 22 Jun 2021 23:04:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B153C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 23:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3158840566
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 23:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aI4zbH8k1ov6 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 23:04:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD8A14044E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 23:04:24 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by gw2.atmark-techno.com (Postfix) with ESMTPS id 670E620D16
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 08:04:23 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id
 c20-20020a17090ab294b029016fccb9582dso287930pjr.7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 16:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Zi+YumSK8qJAN2mxkpNMysen7VAorvJsTi6oKg7UA3c=;
 b=anJ9k1Hml/MUgBUUk92cGzXc+EToj8Rhgqb9Pt3S/3lHLKNhpQ0lrbac/sUZe99u4d
 MT981K09GUBFrcMZhM7NsI2TqQ4xZv/crwdW73Op/kdyxz8ghO8IulImXYMyHNxyIy7b
 HdimN+VjoJ4Spsp0E6p1aU7UJZ9WC1WmwmtpwctQtgFXjwKwIu4OTsyHOW4pSs7ttZGX
 xEvxHlwgyFHgc2c9+nxnjsUU6KJ79khHN8B5PdMZ1qr4WMffReO2jw1YI9s76olO9D3y
 WB2u3yViXWHgNNZcd+3m9746m+8drEhEhtf8fBrCcH7yvg3HubYSNVyPcsmTg/apLv22
 8zlg==
X-Gm-Message-State: AOAM531HUQ0P6fSOpEAcK7dxIukmBy8PHxVsxeL/eAQzRxbDMY2XnsHU
 ck8zCa6zQpZ0yMSKlYY3RAhL5JEaL9f5afjDaoFmSDlsPMqCHPJxdjLT/p+1MAqJEsx+N33EW26
 8UpTVgZtVoNHEwTt9AJcm5qiUIHfdc5Q=
X-Received: by 2002:a63:f4b:: with SMTP id 11mr931682pgp.250.1624403062476;
 Tue, 22 Jun 2021 16:04:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1DPt62WJkfxA5t0B59dYOyebgMR0VQB3YdAJXalVVOArvyr9AtZ9hq+qnqQudOs5PrJkKPw==
X-Received: by 2002:a63:f4b:: with SMTP id 11mr931650pgp.250.1624403062198;
 Tue, 22 Jun 2021 16:04:22 -0700 (PDT)
Received: from pc-0115 (178.101.200.35.bc.googleusercontent.com.
 [35.200.101.178])
 by smtp.gmail.com with ESMTPSA id 206sm326731pfv.108.2021.06.22.16.04.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jun 2021 16:04:21 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
 (envelope-from <martinet@pc-0115>)
 id 1lvpRM-002Ue5-4i; Wed, 23 Jun 2021 08:04:20 +0900
Date: Wed, 23 Jun 2021 08:04:10 +0900
From: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YNJsar/EYmCeTO3S@atmark-techno.com>
References: <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
 <CGME20210621020328epcas2p207e9fa2df119730ceb993543621437d8@epcas2p2.samsung.com>
 <YM/zWyZlk1bzHWgI@atmark-techno.com>
 <2038148563.21624247281621.JavaMail.epsvc@epcpadp4>
 <YNASOEGsDxhFC8qJ@atmark-techno.com> <YNCROxI328u7IKdQ@fedora>
 <YNGVyOyD+CAMmPos@atmark-techno.com> <YNJc9qxeIjy6VuLt@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNJc9qxeIjy6VuLt@fedora>
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

Konrad Rzeszutek Wilk wrote on Tue, Jun 22, 2021 at 05:58:14PM -0400:
> On Tue, Jun 22, 2021 at 04:48:24PM +0900, 'Dominique MARTINET' wrote:
> > Thanks, that should be good.
> > 
> > Do you want me to send a follow-up patch with the two extra checks
> > (tlb_addr & (IO_TLB_SIZE -1)) > swiotlb_align_offset(dev, orig_addr)
> > tlb_offset < alloc_size
> > 
> > or are we certain this can't ever happen?
> 
> I would love more patches and I saw the previous one you posted.
> 
> But we only got two (or one) weeks before the next merge window opens
> so I am sending to Linus the one that was tested with NVMe and crypto
> (see above).
> 
> That is the
> https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/commit/?h=stable/for-linus-5.14
> 
> And then after Linus releases the 5.14 - I would love to take your
> cleanup on top of that and test it?

That sounds good to me, will send with proper formatting after release.

-- 
Dominique
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
