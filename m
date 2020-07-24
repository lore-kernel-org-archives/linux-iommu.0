Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B852BC433E4
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 11:07:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793262073E
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 11:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BiTqCQ6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793262073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 485DB864EE;
	Fri, 24 Jul 2020 11:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80-DF1ms7g5i; Fri, 24 Jul 2020 11:07:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5A03A86311;
	Fri, 24 Jul 2020 11:07:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27E70C004D;
	Fri, 24 Jul 2020 11:07:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6259C004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 11:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8F23486311
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 11:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w4cZ4-BMN5Ir for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 11:07:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9572686302
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 11:07:30 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id 88so7936875wrh.3
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EdQT63Ax+A3aODmg5U77uJh2icVxckFwj6Fw6w57Kic=;
 b=BiTqCQ6xZwjFwNXUjnfNOQmwwbGF1zO/bDH/fbt/YsdrblLH+TYtPD8oR2abGh2AGY
 c4KVUJWL0dLVAKBfwxEjla2NwHMKtsIeHSglXl2ti3i5MiAD5W3Agr2WayGqZWON7EZe
 WsS2ZgvcgFWo4s9AzQYU2z2iFbG1DPfpW1T3G5dxoN7rPmyCB1uIh6/z9u3rvo0ZAt6I
 LuUyoizw5wj/HRRE0juJfJgcOQYucim9Qdv0t3mHx/seCoWqKQSexSJkkri/uq469nj+
 KYQ7vNsS3wWE14fFfWpRQDxtZNSuhGwgTUHVj3Ttdo5pBgyEK53y5p7JXEIz1mEBl97U
 WqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EdQT63Ax+A3aODmg5U77uJh2icVxckFwj6Fw6w57Kic=;
 b=AQL9X4SFXVY1v/CFDFURnsI/vHJG0CwVyNagK/t+0urSYV0HhHLS25PkoTv2hT/MrM
 vtPMat6P3Sz7BQ8ZJsuwG7e1AxW7jp92GxlX8CNQgYaUbflU93pewf1RXfbSIBTZelpj
 tiRdzA8exUG99JyWYo+RLiU20y/tIvEO2PtfqNwW82fTzz+HksrLuM90dv4s/UIjFDJf
 882OwckXcGQW99hSfQruaSyz05NdTxOFKJtQZjCoOPCZ6ilEy0flKsG7omSDSdC21MdX
 Hnd0Opy8udblK2sDPkopTPRFHASLuG+6gCnVFXzNgU6CmVLFz0py9LWJlFhn5yrkjMaW
 RhVA==
X-Gm-Message-State: AOAM531JPeXdFhUZZL8RYXcHqBLFyru+RTdhJcNGp3At6q+2A0G21j9i
 semwCGEDaRB1Ojz8pEjqgy3HV8C7ELY1/VHX09e7Pw==
X-Google-Smtp-Source: ABdhPJxNaOA56Km6atDzUVWw9zPvlssdJZaf1ujzptAwAuQ3K/AVgnDaKbLddCq5PjILSV0SwQLvRTdywfHIhRtq6MI=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr8503038wrp.114.1595588848909; 
 Fri, 24 Jul 2020 04:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
 <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
 <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
 <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
 <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
 <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
 <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
 <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
 <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
In-Reply-To: <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 24 Jul 2020 16:36:52 +0530
Message-ID: <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Fri, 24 Jul 2020 at 15:06, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Amit,
>
> On Thu, 2020-07-23 at 10:44 +0530, Amit Pundir wrote:
> > Hi Nicolas,
> >
> > Sorry I got stuck on other things yesterday.
>
> No worries :)
>
> > On Tue, 21 Jul 2020 at 21:57, Nicolas Saenz Julienne
>
> [...]
>
> > >
> > > Let's get a bigger hammer, I'm just looking for clues here. Can you
> > > apply this and provide the dmesg output.
> > >
> > > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > > index 6bc74a2d5127..2160676bf488 100644
> > > --- a/kernel/dma/pool.c
> > > +++ b/kernel/dma/pool.c
> > > @@ -268,6 +268,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
> > >                         schedule_work(&atomic_pool_work);
> > >         }
> > >
> > > +       dev_info(dev, "%s: size %lx, phys addr %llx, flags 0x%x\n", __func__, size, phys, flags);
> > > +
> > >         return ptr;
> > >  }
> >
> > I never made it to dma_alloc_from_pool() call from
> > dma_direct_alloc_pages(), dma_should_alloc_from_pool() returns False
> > from gfpflags_allow_blocking() block.
>
> I'm a little sceptical about this. The only way you can get memory from these
> pools is through dma_alloc_from_pool(), and given how changes in the pool
> initialization affected the phone, it's pretty clear some amount of pool
> allocation is happening.

Maybe from here iommu_dma_alloc_remap()?

I see two paths to dma_alloc_from_pool(), one from
dma_direct_alloc_pages() which I mentioned above and
2nd one is thru iommu_dma_alloc(), but the flow doesn't
reach up to dma_alloc_from_pool(), and always returns
from iommu_dma_alloc_remap().


Regards,
Amit Pundir

>
> Regards,
> Nicolas
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
