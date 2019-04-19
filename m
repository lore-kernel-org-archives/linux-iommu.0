Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD81C282E0
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 23:09:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1147B21736
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 23:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1147B21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D0A2929B6;
	Fri, 19 Apr 2019 23:09:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EF8D82998
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 23:09:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
	[209.85.160.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 50732466
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 23:09:19 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id l17so116215qtp.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 16:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=eiIG7Pb3xDPcfV7jEiMiHEtsXa/Lg5s5QjuoOEMCk98=;
	b=byg3/C6DI0tEpvKWbUeTVCR7eXtYEA6Dk6rwCpKQfkVF+6rx1tPlr/9anjBfhR8cgZ
	x2vmWnmx4b9y0NId5JpyRiZbAKxCRrgZcnrCq2ldsIPMAaWWBYef8TrN/sPfZWoE525C
	UDW+9lyr7DKmf79vUE0GVAkNdk2uokEziUMX9JNh4v1QIQX1DQzICBUqHGgdBdXCJjqF
	F9JMjOxSBh3uCi9rAWWZE7HWVO35ePF79pR3/bRBSuWRlu9T1Q/etSeQjFrsWd32Dt8z
	6WYU6c/TFKi+2VUdoqxNaUkZg5MWknU8OiCWoZVxI4Bm/xFTzz1hQ9zvTlAKbMAPt8m7
	7u6w==
X-Gm-Message-State: APjAAAUqTIWGr97NdSmxosBhXSRW8b3+dnvvRYe6uhkO7BFoLwQof9pU
	Y5mIoryYM8oNPBV7gjYPUKnJdw==
X-Google-Smtp-Source: APXvYqzc+Oknvzn5/bfow/gVNDiuxgawFCmjDhR4so8tN2tHXw8P82DLmcdD4cOgfhPRh23gLYZ3MA==
X-Received: by 2002:ac8:5298:: with SMTP id s24mr3022746qtn.263.1555715358471; 
	Fri, 19 Apr 2019 16:09:18 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	f129sm2699616qkj.47.2019.04.19.16.09.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 19 Apr 2019 16:09:17 -0700 (PDT)
Date: Fri, 19 Apr 2019 19:09:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190419190258-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<877eefxvyb.fsf@morokweng.localdomain>
	<20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a7go71hz.fsf@morokweng.localdomain>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190419230914.HFyvFnEQrIo24zfWCM7srVdoCqGMgoh2eDGxbrH9mow@z>

On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
> >> >> >From what I understand of the ACCESS_PLATFORM definition, the host will
> >> >> only ever try to access memory addresses that are supplied to it by the
> >> >> guest, so all of the secure guest memory that the host cares about is
> >> >> accessible:
> >> >>
> >> >>     If this feature bit is set to 0, then the device has same access to
> >> >>     memory addresses supplied to it as the driver has. In particular,
> >> >>     the device will always use physical addresses matching addresses
> >> >>     used by the driver (typically meaning physical addresses used by the
> >> >>     CPU) and not translated further, and can access any address supplied
> >> >>     to it by the driver. When clear, this overrides any
> >> >>     platform-specific description of whether device access is limited or
> >> >>     translated in any way, e.g. whether an IOMMU may be present.
> >> >>
> >> >> All of the above is true for POWER guests, whether they are secure
> >> >> guests or not.
> >> >>
> >> >> Or are you saying that a virtio device may want to access memory
> >> >> addresses that weren't supplied to it by the driver?
> >> >
> >> > Your logic would apply to IOMMUs as well.  For your mode, there are
> >> > specific encrypted memory regions that driver has access to but device
> >> > does not. that seems to violate the constraint.
> >>
> >> Right, if there's a pre-configured 1:1 mapping in the IOMMU such that
> >> the device can ignore the IOMMU for all practical purposes I would
> >> indeed say that the logic would apply to IOMMUs as well. :-)
> >>
> >> I guess I'm still struggling with the purpose of signalling to the
> >> driver that the host may not have access to memory addresses that it
> >> will never try to access.
> >
> > For example, one of the benefits is to signal to host that driver does
> > not expect ability to access all memory. If it does, host can
> > fail initialization gracefully.
> 
> But why would the ability to access all memory be necessary or even
> useful? When would the host access memory that the driver didn't tell it
> to access?

When I say all memory I mean even memory not allowed by the IOMMU.


> >> >> >> > But the name "sev_active" makes me scared because at least AMD guys who
> >> >> >> > were doing the sensible thing and setting ACCESS_PLATFORM
> >> >> >>
> >> >> >> My understanding is, AMD guest-platform knows in advance that their
> >> >> >> guest will run in secure mode and hence sets the flag at the time of VM
> >> >> >> instantiation. Unfortunately we dont have that luxury on our platforms.
> >> >> >
> >> >> > Well you do have that luxury. It looks like that there are existing
> >> >> > guests that already acknowledge ACCESS_PLATFORM and you are not happy
> >> >> > with how that path is slow. So you are trying to optimize for
> >> >> > them by clearing ACCESS_PLATFORM and then you have lost ability
> >> >> > to invoke DMA API.
> >> >> >
> >> >> > For example if there was another flag just like ACCESS_PLATFORM
> >> >> > just not yet used by anyone, you would be all fine using that right?
> >> >>
> >> >> Yes, a new flag sounds like a great idea. What about the definition
> >> >> below?
> >> >>
> >> >> VIRTIO_F_ACCESS_PLATFORM_NO_IOMMU This feature has the same meaning as
> >> >>     VIRTIO_F_ACCESS_PLATFORM both when set and when not set, with the
> >> >>     exception that the IOMMU is explicitly defined to be off or bypassed
> >> >>     when accessing memory addresses supplied to the device by the
> >> >>     driver. This flag should be set by the guest if offered, but to
> >> >>     allow for backward-compatibility device implementations allow for it
> >> >>     to be left unset by the guest. It is an error to set both this flag
> >> >>     and VIRTIO_F_ACCESS_PLATFORM.
> >> >
> >> > It looks kind of narrow but it's an option.
> >>
> >> Great!
> >>
> >> > I wonder how we'll define what's an iommu though.
> >>
> >> Hm, it didn't occur to me it could be an issue. I'll try.
> 
> I rephrased it in terms of address translation. What do you think of
> this version? The flag name is slightly different too:
> 
> 
> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
>     with the exception that address translation is guaranteed to be
>     unnecessary when accessing memory addresses supplied to the device
>     by the driver. Which is to say, the device will always use physical
>     addresses matching addresses used by the driver (typically meaning
>     physical addresses used by the CPU) and not translated further. This
>     flag should be set by the guest if offered, but to allow for
>     backward-compatibility device implementations allow for it to be
>     left unset by the guest. It is an error to set both this flag and
>     VIRTIO_F_ACCESS_PLATFORM.

Thanks, I'll think about this approach. Will respond next week.

> >> > Another idea is maybe something like virtio-iommu?
> >>
> >> You mean, have legacy guests use virtio-iommu to request an IOMMU
> >> bypass? If so, it's an interesting idea for new guests but it doesn't
> >> help with guests that are out today in the field, which don't have A
> >> virtio-iommu driver.
> >
> > I presume legacy guests don't use encrypted memory so why do we
> > worry about them at all?
> 
> They don't use encrypted memory, but a host machine will run a mix of
> secure and legacy guests. And since the hypervisor doesn't know whether
> a guest will be secure or not at the time it is launched, legacy guests
> will have to be launched with the same configuration as secure guests.

OK and so I think the issue is that hosts generally fail if they set
ACCESS_PLATFORM and guests do not negotiate it.
So you can not just set ACCESS_PLATFORM for everyone.
Is that the issue here?


> >> >> > Is there any justification to doing that beyond someone putting
> >> >> > out slow code in the past?
> >> >>
> >> >> The definition of the ACCESS_PLATFORM flag is generic and captures the
> >> >> notion of memory access restrictions for the device. Unfortunately, on
> >> >> powerpc pSeries guests it also implies that the IOMMU is turned on
> >> >
> >> > IIUC that's really because on pSeries IOMMU is *always* turned on.
> >> > Platform has no way to say what you want it to say
> >> > which is bypass the iommu for the specific device.
> >>
> >> Yes, that's correct. pSeries guests running on KVM are in a gray area
> >> where theoretically they use an IOMMU but in practice KVM ignores it.
> >> It's unfortunate but it's the reality on the ground today. :-/
> >
> > Well it's not just the reality, virt setups need something that
> > emulated IOMMUs don't provide. That is not uncommon, e.g.
> > intel's VTD has a "cache mode" field which AFAIK is only used for virt.
> 
> That's good to know. Thanks for this example.
> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
