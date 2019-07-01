Return-Path: <SRS0=o8L7=U6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014CAC0650E
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 14:25:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2020214AE
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 14:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2020214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A69974C10;
	Mon,  1 Jul 2019 14:25:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE3514C0F
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 14:25:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E249D832
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 14:25:16 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id i34so14805690qta.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 01 Jul 2019 07:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=OmUFyqrNN9sq0ZRrSpIxJ5BWTUOqPUb104pbuNvBMyo=;
	b=F6+xEFwoPvG8KYcjdDId1NnAlFisBKTWsJkK8UF1h3+iAHSzm7Ece8GD7ejTkZZDW8
	px/FYnLtuMM2gdwS/+xPIHfxBdU7+ZodY+jOESr9GFBAydjHZlsQD0q4h9ZL+VDrB7xK
	I9yf96br2+fYaCBmVAX8uUY6Ys4RxixkgviIZnbCD5h09CnLCFjc16ZBafS6nGSCK3sL
	kqnwH0THNQ61AIznoA3PpmzwJJAFx9DtjYaqVU9bDMTdXAF9SLd030F9grzseJfkujmp
	a3vFKVle2ZiGbQlyJ9y8ANJp20AljQhD7HAoL1QVTZY43Ma3pclTR5xZ9+FSdnYUFqoX
	ULAw==
X-Gm-Message-State: APjAAAU0O7d7RMdyvYD27G5T+senhnj2UM5J6nHLhesORTW3PUDCqumG
	VZPLBHI2mdyZn+x2cMPpNbOUdw==
X-Google-Smtp-Source: APXvYqztU+rrvBg2COujrfs5dvhOsWNrkGwA5oSm17/fSAfVJk0yP87nIwCfT9SyHEU4ES7CV30Tdw==
X-Received: by 2002:a0c:acfb:: with SMTP id n56mr21744226qvc.87.1561990645035; 
	Mon, 01 Jul 2019 07:17:25 -0700 (PDT)
Received: from redhat.com ([185.120.125.12]) by smtp.gmail.com with ESMTPSA id
	18sm4904132qke.131.2019.07.01.07.17.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 01 Jul 2019 07:17:23 -0700 (PDT)
Date: Mon, 1 Jul 2019 10:17:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190701092212-mutt-send-email-mst@kernel.org>
References: <20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
	<20190520090939-mutt-send-email-mst@kernel.org>
	<877ea26tk8.fsf@morokweng.localdomain>
	<20190603211528-mutt-send-email-mst@kernel.org>
	<877e96qxm7.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877e96qxm7.fsf@morokweng.localdomain>
Cc: Mike Anderson <andmike@linux.ibm.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@ozlabs.org>,
	iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
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

On Thu, Jun 27, 2019 at 10:58:40PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Mon, Jun 03, 2019 at 10:13:59PM -0300, Thiago Jung Bauermann wrote:
> >>
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> >> >> I rephrased it in terms of address translation. What do you think of
> >> >> this version? The flag name is slightly different too:
> >> >>
> >> >>
> >> >> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
> >> >>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
> >> >>     with the exception that address translation is guaranteed to be
> >> >>     unnecessary when accessing memory addresses supplied to the device
> >> >>     by the driver. Which is to say, the device will always use physical
> >> >>     addresses matching addresses used by the driver (typically meaning
> >> >>     physical addresses used by the CPU) and not translated further. This
> >> >>     flag should be set by the guest if offered, but to allow for
> >> >>     backward-compatibility device implementations allow for it to be
> >> >>     left unset by the guest. It is an error to set both this flag and
> >> >>     VIRTIO_F_ACCESS_PLATFORM.
> >> >
> >> >
> >> >
> >> >
> >> > OK so VIRTIO_F_ACCESS_PLATFORM is designed to allow unpriveledged
> >> > drivers. This is why devices fail when it's not negotiated.
> >>
> >> Just to clarify, what do you mean by unprivileged drivers? Is it drivers
> >> implemented in guest userspace such as with VFIO? Or unprivileged in
> >> some other sense such as needing to use bounce buffers for some reason?
> >
> > I had drivers in guest userspace in mind.
> 
> Great. Thanks for clarifying.
> 
> I don't think this flag would work for guest userspace drivers. Should I
> add a note about that in the flag definition?

I think you need to clarify access protection rules. Is it only
translation that is bypassed or is any platform-specific
protection mechanism bypassed too?

> >> > This confuses me.
> >> > If driver is unpriveledged then what happens with this flag?
> >> > It can supply any address it wants. Will that corrupt kernel
> >> > memory?
> >>
> >> Not needing address translation doesn't necessarily mean that there's no
> >> IOMMU. On powerpc we don't use VIRTIO_F_ACCESS_PLATFORM but there's
> >> always an IOMMU present. And we also support VFIO drivers. The VFIO API
> >> for pseries (sPAPR section in Documentation/vfio.txt) has extra ioctls
> >> to program the IOMMU.
> >>
> >> For our use case, we don't need address translation because we set up an
> >> identity mapping in the IOMMU so that the device can use guest physical
> >> addresses.

OK so I think I am beginning to see it in a different light.  Right now the specific
platform creates an identity mapping. That in turn means DMA API can be
fast - it does not need to do anything.  What you are looking for is a
way to tell host it's an identity mapping - just as an optimization.

Is that right?  So this is what I would call this option:

VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS

and the explanation should state that all device
addresses are translated by the platform to identical
addresses.

In fact this option then becomes more, not less restrictive
than VIRTIO_F_ACCESS_PLATFORM - it's a promise
by guest to only create identity mappings,
and only before driver_ok is set.
This option then would always be negotiated together with
VIRTIO_F_ACCESS_PLATFORM.

Host then must verify that
1. full 1:1 mappings are created before driver_ok
    or can we make sure this happens before features_ok?
    that would be ideal as we could require that features_ok fails
2. mappings are not modified between driver_ok and reset
    i guess attempts to change them will fail -
    possibly by causing a guest crash
    or some other kind of platform-specific error

So far so good, but now a question:

how are we handling guest address width limitations?
Is VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS subject to
guest address width limitations?
I am guessing we can make them so ...
This needs to be documented.




> >
> > And can it access any guest physical address?
> 
> Sorry, I was mistaken. We do support VFIO in guests but not for virtio
> devices, only for regular PCI devices. In which case they will use
> address translation.

Not sure how this answers the question.


> >> If the guest kernel is concerned that an unprivileged driver could
> >> jeopardize its integrity it should not negotiate this feature flag.
> >
> > Unfortunately flag negotiation is done through config space
> > and so can be overwritten by the driver.
> 
> Ok, so the guest kernel has to forbid VFIO access on devices where this
> flag is advertised.

That's possible in theory but in practice we did not yet teach VFIO not
to attach to legacy devices without VIRTIO_F_ACCESS_PLATFORM.  So all
security relies on host denying driver_ok without
VIRTIO_F_ACCESS_PLATFORM.  New options that bypass guest security are
thus tricky as they can create security holes for existing guests.
I'm open to ideas about how to do this in a safe way,


> >> Perhaps there should be a note about this in the flag definition? This
> >> concern is platform-dependant though. I don't believe it's an issue in
> >> pseries.
> >
> > Again ACCESS_PLATFORM has a pretty open definition. It does actually
> > say it's all up to the platform.
> >
> > Specifically how will VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION be
> > implemented portably? virtio has no portable way to know
> > whether DMA API bypasses translation.
> 
> The fact that VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION is set
> communicates that knowledge to virtio. There is a shared understanding
> between the guest and the host about what this flag being set means.

Right but I wonder how are you going to *actually* implement it on Linux?
Are you adding a new set of DMA APIs that do everything except
translation?

> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
