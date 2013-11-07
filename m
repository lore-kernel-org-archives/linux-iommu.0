From: Stuart Yoder <b08248@gmail.com>
Subject: Re: [PATCH 3/7] Return info for device and its memory regions and interrupts
Date: Thu, 7 Nov 2013 14:38:29 -0600
Message-ID: <CALRxmdA_7CtNWSc5Uaq0TH2Q9C4uUn-fZj2WweszhdDmbyvaWg@mail.gmail.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-4-git-send-email-a.motakis@virtualopensystems.com>
	<1380562776.2674.177.camel@ul30vt.home>
	<CAG8rG2yPXX9WtmhJqYMNE_3x4RNGkb1BDab8F3Pk8KUhntM9fg@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E15036D3803@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAG8rG2ypiSUqfhqLTxgv0+Sh9DO9KAscJy0CmCrr_oG3tmGAgA@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E15036D3D3A@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAG8rG2xA=LWAp0DR=_WdJSEC33yZXfP6LJ+oZW8WBr_HLNiarg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAG8rG2xA=LWAp0DR=_WdJSEC33yZXfP6LJ+oZW8WBr_HLNiarg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>
Cc: Yoder Stuart-B08248 <B08248@freescale.com>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, KVM devel mailing list <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Linux IOMMU <iommu@lists.linux-foundation.org>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, kvm-arm <kvmarm@lists.cs.columbia.edu>
List-Id: iommu@lists.linux-foundation.org

>>> I will look into this. However, can we rely to have access to all
>>> device resources through platform abstractions, for every type of
>>> platform device
>>
>> The only resources we care about in vfio are mappable regions
>> and irqs.  So, yes I think we can rely on access to those
>> resources.
>>
>>> It seems to me that platform devices that are not
>>> backed by a specific description mechanism (such as device tree) may
>>> include a lot of hard coded values etc in their drivers.
>>
>> If the platform device struct does not have reg/irq resources described
>> then we can't expose them to user space with vfio.
>
> Which is my concern actually. If the struct does not describe reg/irq
> resources, or even worse if it describes them partially, do we want to
> let the user shoot himself on the foot?
>
> Granted this might happen with device tree too, but I find it much
> more likely with generic platform devices.
>
> Maybe we should adopt a whitelist instead?

Just realize I never replied to this query...

If there are no IRQs in the platform device struct we should
just return 0x0 for number of interrupts.
If the information in the platform device struct is only partially
complete, we should just return an error to the caller of the
ioctl.

Stuart
