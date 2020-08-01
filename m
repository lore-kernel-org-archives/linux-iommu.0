Return-Path: <SRS0=Zw9n=BL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A37BC433DF
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 11:57:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71412064B
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 11:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Osy2kmUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71412064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 54B6488558;
	Sat,  1 Aug 2020 11:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBjZK4iiXagt; Sat,  1 Aug 2020 11:57:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8AC54884C3;
	Sat,  1 Aug 2020 11:57:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7456DC004F;
	Sat,  1 Aug 2020 11:57:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4EE2C004D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 11:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8C2CC87ECA
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 11:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qgmXi7BCR0VH for <iommu@lists.linux-foundation.org>;
 Sat,  1 Aug 2020 11:57:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A4F9987E75
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 11:57:42 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id f1so29596439wro.2
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 04:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9xnxWZrttxQf2cUUXQG3y46AMeLBO1WHvAsLPL1N7e8=;
 b=Osy2kmUPSIFe1gOQdnNgwXtPnlx+z+UIan/VP/RJT78Hs2l2uLnMMDRV1mCT371SQ/
 9CHJvn8BfAnBCrdl9y8maetCoWJjk9ZapQXlj1KIX5MVh6PvhgVXoaB3hcZxe5JbivxG
 ZQoaVTQHby266rPzNZhKcHCq58jAP+PYkruGQbvaIBGzNWB0sulTYB5TTUs4j05Z/jVn
 M2XphPkN6kqDwld5NwVwq5ARoYDIlRraXmzenZhmdcj8bGamZ595SPfUAs1rsJUR74Fh
 9gn9Azs9cRyzbpRETpKaMUuf3nJYswo6yw+opuBKCgFYADz0V5uA8EhH40E/WtOTyUVp
 xenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9xnxWZrttxQf2cUUXQG3y46AMeLBO1WHvAsLPL1N7e8=;
 b=ai46Ubs++I3w6ec8Y78e6KwPMsxErNaycn3f/UvO3mqtiJBgeuq+KwH5dVWX7jE55X
 77hLJScum0wUVxwX5UFD8xk4tGRnGMgiD8tuJx1/IC1YSzGKAdFbJvrVRP+++B5xvoP2
 DPthCdAC12ZjA2RhKiuS2hbdc/J9JJ9AA6vdF2+0/Vk6J4R7dGdV5yt/9MtpofdvtQP8
 fRGebL+nIsx1Qs1wsFywwS2a6FVSrcO0H9JcDwD2eg4VkZyDc5x/Pw9mYO7cZebyTjxx
 uMrdRPp3XDsbD4sasPGzP4JkSBLBT/pYukW2FljnErNWEcVzK1tcNqKvFHOVj17g813h
 TTfw==
X-Gm-Message-State: AOAM532CVYOpr243OmTko3M7BbE/1f4dCB+fFBkkRA+dt9dXZqe9dWzk
 sl12MRgGCn74xnuThkNMgQh5Gw8bYdrDVYS6JpNtRg==
X-Google-Smtp-Source: ABdhPJzKbWe3A2+f6OwxrlEHa7p9KbOmnzHB8etTuwmP/njzKr22VTTUw6uN925rSlRQt0SC6sMsY2nq0WrmvZ4Oe1I=
X-Received: by 2002:a5d:4c8f:: with SMTP id z15mr7607131wrs.9.1596283060707;
 Sat, 01 Aug 2020 04:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
 <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
 <20200728153055.GA16701@lst.de>
 <18a3b93cc5ba3e0e39ae1b14759ce31121d54045.camel@suse.de>
 <CAMi1Hd3QNtZVEFUgDprT==wcVHKv6TsvpT3RurVJTDb1op2LnA@mail.gmail.com>
 <CAMi1Hd09EbzOgTU5P4EDS8BQ6J2jFntvyR49BePyAqJ15DBB0Q@mail.gmail.com>
 <20200731130903.GA31110@lst.de>
 <alpine.DEB.2.23.453.2007311204010.3836388@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2008010105560.4078406@chino.kir.corp.google.com>
 <20200801085706.GA2991@lst.de>
In-Reply-To: <20200801085706.GA2991@lst.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Sat, 1 Aug 2020 17:27:04 +0530
Message-ID: <CAMi1Hd2tCfbDUuBP=OKoG8fPVCTpiARmqrkPadEJjJ52fgc_-Q@mail.gmail.com>
Subject: Re: revert scope for 5.8, was Re: dma-pool fixes
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>
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

On Sat, 1 Aug 2020 at 14:27, Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Aug 01, 2020 at 01:20:07AM -0700, David Rientjes wrote:
> > To follow-up on this, the introduction of the DMA atomic pools in 5.8
> > fixes an issue for any AMD SEV enabled guest that has a driver that
> > requires atomic DMA allocations (for us, nvme) because runtime decryption
> > of memory allocated through the DMA API may block.  This manifests itself
> > as "sleeping in invalid context" BUGs for any confidential VM user in
> > cloud.
> >
> > I unfortunately don't have Amit's device to be able to independently debug
> > this issue and certainly could not have done a better job at working the
> > bug than Nicolas and Christoph have done so far.  I'm as baffled by the
> > results as anybody else.
> >
> > I fully understand the no regressions policy.  I'd also ask that we
> > consider that *all* SEV guests are currently broken if they use nvme or
> > any other driver that does atomic DMA allocations.  It's an extremely
> > serious issue for cloud.  If there is *anything* that I can do to make
> > forward progress on this issue for 5.8, including some of the workarounds
> > above that Amit requested, I'd be very happy to help.  Christoph will make
> > the right decision for DMA in 5.8, but I simply wanted to state how
> > critical working SEV guests are to users.
>
> I'm between a rock and a hard place here.  If we simply want to revert
> commits as-is to make sure both the Raspberry Pi 4 and thone phone do
> not regress we'll have to go all the way back and revert the whole SEV
> pool support.  I could try to manual revert of the multiple pool
> support, but it is very late for that.

Hi, I found the problematic memory region. It was a memory
chunk reserved/removed in the downstream tree but was
seemingly reserved upstream for different drivers. I failed to
calculate the length of the total region reserved downstream
correctly. And there was still a portion of memory left unmarked,
which I should have marked as reserved in my testing earlier
today.

Sorry for all the noise and thanks Nicolas, Christoph and David
for your patience.

Regards,
Amit Pundir


>
> Or maybe Linus has decided to cut a -rc8 which would give us a little
> more time.
> -
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
