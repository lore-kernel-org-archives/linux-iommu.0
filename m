Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF67C282E1
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA304218FD
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="d0x1GTdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA304218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B2E2511F7;
	Wed, 24 Apr 2019 14:47:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B448C109C
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:47:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2FD0282B
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:47:52 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id b1so14227451wru.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XEa6rgZnUyAXDzw6k5Wm7RfYfnHAGNjNhYDmbAFVjBc=;
	b=d0x1GTdScmTi/VkiE0XNzsl/xx34iXYLR6LOxCKLsTXf+xKgooxCZ2Xyd8J8W86ncJ
	vKseDrctWz4KkIRGBf0ExMi26sVrdk7SnFZgrv4RRSsaVETnvp43d8M8tp/viyukTj+N
	MRlu6ZmZEZo1ZDzwWkG77AETW1r0ukTgnI8fDtumDz5z3Avf9SIGQPvGwh1Xd5KnGmXd
	jZHtvBnQjh33rlWdCP/1Z9O0+GiDh0yQHhB0gsbhD7Hv8JszATRIDEM7PBfPlxLYzKYn
	oTxCBZpjLoVcaf+9vcdNLLqdFnGjedTg73Fnk3NLEWKm+yYFin02gfFGpNQCabirPemr
	SOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XEa6rgZnUyAXDzw6k5Wm7RfYfnHAGNjNhYDmbAFVjBc=;
	b=fUO5h7btb86S5uQ6rMjqUjeTJOxOwzPxANbJsXylGKjlpIY4kSiJVQcYWEH8GvQG7c
	vHNyuO4okVy0rKLgIAXaKcQduexbnkdAhOn0WhVHaf9BjN6WnAEoBbcG+yoRqBim/C9n
	QbDVZ7yvH4KPTIDD2V/FgRB0hoAh3frONATEKWB3OSPyDwZgHA+eAfqMYkXUBOHEXNDP
	a1+sRMXEdoCh1lkJsK12lsEwfZIlTUlGAylqGgFmrlny1bDNBsc18GslWOPUUQFNCpk7
	od0O0lGVxvt1l2LrObPkiEcN4DZJnEygTbHYOg06r2WSstO/Zfj4tut4JMnEVkgTXkY/
	NVfg==
X-Gm-Message-State: APjAAAXFZpUen3wTMdgA0q3mB0uHxIfiHHNJWfztqc5OBu0oypnhDvSR
	STJzKTQqpriMe2+0S8tB5hcTNGDUhRqRrqps20ZJuA==
X-Google-Smtp-Source: APXvYqy+tNCx4ErCwE6WOvxEyVsF30tF7ipxrjOJfD3cHRqiIutbxkuJzuyVN13jSPde5CZ0RstcCD6CBu9IyH/PGwk=
X-Received: by 2002:adf:fb4a:: with SMTP id c10mr6821472wrs.309.1556117270817; 
	Wed, 24 Apr 2019 07:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190424141900.8883-1-tmurphy@arista.com>
	<20190424143246.GA24079@infradead.org>
In-Reply-To: <20190424143246.GA24079@infradead.org>
Date: Wed, 24 Apr 2019 15:47:39 +0100
Message-ID:
 <CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Tom Murphy <murphyt7@tcd.ie>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424144739.rmvb-7CGj4GEBv-VFhb_I2P8KL1ORLaezD6REf2tsqU@z>

>The two conditions can go into one if statement to make this a little
>more clear.
Ah, yeah of course

>And I'd really like to understand the unlikely - amd_iommu_np_cache
>is set based on a hardware capability, so it seems rather odd to mark
>it unlikely.  Dynamic branch prediction really should do the right thing
>here usually.

Here is the commit which added it without any explanation:
https://github.com/torvalds/linux/commit/270cab2426cdc6307725e4f1f46ecf8ab8e69193

should we remove it seen as there's no explanation given ?


On Wed, Apr 24, 2019 at 3:32 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 03:18:59PM +0100, Tom Murphy via iommu wrote:
> > check if there is a not-present cache present and flush it if there is.
> >
> > Signed-off-by: Tom Murphy <tmurphy@arista.com>
> > ---
> >  drivers/iommu/amd_iommu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index f7cdd2ab7f11..8ef43224aae0 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -1636,6 +1636,12 @@ static int iommu_map_page(struct protection_domain *dom,
> >               pte[i] = __pte;
> >
> >       update_domain(dom);
> > +     if (!dom->updated) {
> > +             if (unlikely(amd_iommu_np_cache)) {
> > +                     domain_flush_pages(dom, bus_addr, page_size);
> > +                     domain_flush_complete(dom);
> > +             }
> > +     }
>
> The two conditions can go into one if statement to make this a little
> more clear.
>
> And I'd really like to understand the unlikely - amd_iommu_np_cache
> is set based on a hardware capability, so it seems rather odd to mark
> it unlikely.  Dynamic branch prediction really should do the right thing
> here usually.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
