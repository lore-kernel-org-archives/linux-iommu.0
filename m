Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0620C433DF
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 18:30:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7087722B40
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 18:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FctVSqVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7087722B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7DE186382;
	Mon,  3 Aug 2020 18:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 38etB0MhoR3N; Mon,  3 Aug 2020 18:30:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 244D686233;
	Mon,  3 Aug 2020 18:30:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 054C3C0050;
	Mon,  3 Aug 2020 18:30:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69B94C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 18:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 231FA204CB
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 18:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UUMkFtZdCeYb for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 18:30:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by silver.osuosl.org (Postfix) with ESMTPS id E9AC42047B
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 18:30:49 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id q17so21260858pls.9
 for <iommu@lists.linux-foundation.org>; Mon, 03 Aug 2020 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=JwRRg79Yf9uvematvciZtAtNIlwaUYjaYnclD9uw6H4=;
 b=FctVSqVyXofv5zMutLQ7zuQIvasuCC7A9icLXoYneOOXCjHX3zzJQEE4nNeOovplIa
 gY/nnHyLj3jq9KHqyW66FZFHXJmRT8PojCDw8we6Z03MSmXjSWutPpgcEnBikuCd1ham
 ONO2Moe94Z3yB6jpuhL6ylgyjJp0OplWvbkz3cYDc5JqN+KxmfhVRfkWxR7c9nLyeEYj
 MOgAHuU8b+yLNpwOCs0zph1t+5mTJvhfugjJVRhM1wyF+1AH0Hf9UR8EhJIx1M2p2wM9
 yqACjQYYOfpT8VGhwkqjDgfF8RcVknlYzDWiR5MDyCb8Ugz9RZ0nrWc5lXGWsBYyE0A6
 7Gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=JwRRg79Yf9uvematvciZtAtNIlwaUYjaYnclD9uw6H4=;
 b=INBZ/szigdULX9mACpv7C9nMLT9WNgP2ch/B5+ubltZN4AcHB/FKLV6AnWlgNC7IOu
 N0KoAgHuPXpobU9inzYHjugbix0Fe5k+8v8sUq/qIAxWu8He0QzreWjubrOajLYP7haA
 ze0NkPdows2Us2A/cybUsw+QnOOI1ErekNkLDwufxQPmK/Hs7ipf3UBMhLSDRutdu8py
 hcbtXWpCUdLYclBZ4x1an8dL/f4LYXp9iyw+SxpayEcnoQk5AJm4ikFqHtVpSw/RR++M
 oAU/YNDAq7lzY6fnSEGyPPk2tSdoY2MobPLZmnXtV+ncRSOLBidoVqIJG985xdAXslKJ
 0isA==
X-Gm-Message-State: AOAM532u4MS5mozObEKCx93trzZhdLXhHP5+uEk9ATLQn6NqLVDX0Zjv
 ZOQCVpUO5AEZ1iRgk+YG+X52sA==
X-Google-Smtp-Source: ABdhPJyqaqNiXglF2QS7oRLi/bJBq42L+GWqFa3PM1bL+aVK+h3vWol8OmcMqCbeQ4k7SHZsV0Ts6Q==
X-Received: by 2002:a17:90a:e551:: with SMTP id
 ei17mr597529pjb.224.1596479449160; 
 Mon, 03 Aug 2020 11:30:49 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667]
 ([2620:15c:17:3:4a0f:cfff:fe51:6667])
 by smtp.gmail.com with ESMTPSA id e8sm19778735pfd.34.2020.08.03.11.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 11:30:48 -0700 (PDT)
Date: Mon, 3 Aug 2020 11:30:47 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: revert scope for 5.8, was Re: dma-pool fixes
In-Reply-To: <20200803064438.GA19014@lst.de>
Message-ID: <alpine.DEB.2.23.453.2008031128160.683224@chino.kir.corp.google.com>
References: <CAMi1Hd09EbzOgTU5P4EDS8BQ6J2jFntvyR49BePyAqJ15DBB0Q@mail.gmail.com>
 <20200731130903.GA31110@lst.de>
 <alpine.DEB.2.23.453.2007311204010.3836388@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2008010105560.4078406@chino.kir.corp.google.com>
 <20200801085706.GA2991@lst.de>
 <CAMi1Hd2tCfbDUuBP=OKoG8fPVCTpiARmqrkPadEJjJ52fgc_-Q@mail.gmail.com>
 <20200801173952.GA15542@lst.de>
 <CAMi1Hd3wU3pH4dfxcxqKfWmLWxPXD--4hkYC+VQywwQn1mokMg@mail.gmail.com>
 <CAMi1Hd2MLYx_NkXug+Ow7qFn+tzkMFQy_u0iF_-J6amnXZhckA@mail.gmail.com>
 <alpine.DEB.2.23.453.2008022109280.483838@chino.kir.corp.google.com>
 <20200803064438.GA19014@lst.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Cc: Amit Pundir <amit.pundir@linaro.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 iommu <iommu@lists.linux-foundation.org>, jeremy.linton@arm.com,
 Caleb Connolly <caleb@connolly.tech>, linux-rpi-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 3 Aug 2020, Christoph Hellwig wrote:

> On Sun, Aug 02, 2020 at 09:14:41PM -0700, David Rientjes wrote:
> > Christoph: since we have atomic DMA coherent pools in 5.8 now, recall our 
> > previous discussions, including Greg KH, regarding backports to stable 
> > trees (we are interested in 5.4 and 5.6) of this support for the purposes 
> > of confidential VM users who wish to run their own SEV-enabled guests in 
> > cloud.
> > 
> > Would you have any objections to backports being offered for this support 
> > now?  We can prepare them immediately.  Or, if you would prefer we hold 
> > off for a while, please let me know and we can delay it until you are more 
> > comfortable.  (For confidential VM users, the ability to run your own 
> > unmodified stable kernel is a much different security story than a guest 
> > modified by the cloud provider.)
> 
> Before we start backporting I think we need the two fixes from
> the "dma pool fixes" series.  Can you start reviewing them?  I also
> think we should probably wait at least until -rc2 for any fallout
> before starting the backport.
> 

Thanks Christoph, this makes perfect sense.  I see Nicolas has refreshed 
the two patches:

dma-pool: fix coherent pool allocations for IOMMU mappings
dma-pool: Only allocate from CMA when in same memory zone

and posted them again today on LKML for review.  I'll review those and 
we'll send a full series of backports for stable consideration for 5.4 LTS 
and 5.6 around 5.9-rc2 timeframe.

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
