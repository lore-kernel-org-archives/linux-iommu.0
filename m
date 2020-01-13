Return-Path: <SRS0=W82T=3C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C62C33CA9
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 22:02:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D2B2072B
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 22:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V1MN9px7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D2B2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 663E82048A;
	Mon, 13 Jan 2020 22:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CDnN0w-VW9ZD; Mon, 13 Jan 2020 22:02:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A212B203DC;
	Mon, 13 Jan 2020 22:02:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83262C1D80;
	Mon, 13 Jan 2020 22:02:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5B35C077D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 22:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9E4B585BD5
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 22:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9cOcOEa4CR3i for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jan 2020 22:02:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 71E3085B73
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 22:02:27 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id d62so9827544oia.11
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cd49OSVdZ9LTep9c3KV58DkHSqhp0BUiJTKdB++3ceo=;
 b=V1MN9px73AsTv5pBjLvGmnLBq22efaTJLeq7STQTtJy+r5kr3ih30Q/lDizhgN8a8A
 r/LhoU680SQ38PG96u0OhAKcVWlpeHb154AyhbBf4frkwsY4eBc8sl7zxVvdHb+oQIOt
 gwrvhh78DXPtrVqiaM+wA4DqMXoxJArwPtZkLlxRSF7ylE0/aiVNixPfkfBxVzUOW5I+
 Bq00of94jG3o0qIc9CO+yramhofaCz6lwP/3QTuYj0RMMDwr7+Pg1AACMyQ6nHX7iZT8
 GZwzP8xQn4if2n6IQisoCDgQhAG8Qpevjv7OEfgcRgmuFPupgV2/KSYXyw0+gjexnc/r
 ypwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cd49OSVdZ9LTep9c3KV58DkHSqhp0BUiJTKdB++3ceo=;
 b=fpRaEHPQO7jNxjXFJcQLTJsyiIuSUA87QUCcYUdjZXDaS9WxfL1weXGW2tKt3vmooV
 jZwJHcqEcUir9wxuy+PFaS8FXGWR9jzWkty0FTVGZaoViLWm1RDXNoMvzc2BffOs/h3r
 VMfGusVTlgw2hHvKA93WouBwuIZqcvrEYVoXNsZwpP2flwEM2yDVzCJ+DTyVnhAO+J6/
 SaQmF5awhSPP2SY5aWH/cOQ2rqSNzR0Fu3RVA9yqk66kkheY9JqSztMLj5BWwrfJkEqr
 agz72L2bLWd3dV93rNwIW5JvvUq3a7+upQ6oamUVqZVLxp0GCdXEFtooRo7ghvBbbaKD
 HA4w==
X-Gm-Message-State: APjAAAUwOuNJROI8oaQH4MjpXO2/Z2QdI7WTHy+T8bKV/uwOIytPbxya
 9mwZwhOOWKAbjYNod8/86Q5oaaG+ymLAVXTk/EnjVA==
X-Google-Smtp-Source: APXvYqzGvhre6GvVTiJhKltGrKhqtAyPAvqf2KdGb++c4lW9rtmPUmMmjTIO1woOTe8H/EjiWr95GayxXMVjc1XkmeA=
X-Received: by 2002:a54:4f8d:: with SMTP id g13mr13693211oiy.43.1578952946039; 
 Mon, 13 Jan 2020 14:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200111045639.210486-1-saravanak@google.com> <20200113140751.GA2436168@ulmo>
In-Reply-To: <20200113140751.GA2436168@ulmo>
Date: Mon, 13 Jan 2020 14:01:50 -0800
Message-ID: <CAGETcx8YAXOdr1__gTCT2xCPq47Cg9vGj+5HJ_ZLzy4mHxU2xA@mail.gmail.com>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Android Kernel Team <kernel-team@android.com>,
 Patrick Daly <pdaly@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Pratik Patel <pratikp@codeaurora.org>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

I added everyone from the other thread, but somehow managed to miss
the Bjorn who sent the emails! Fixing that now.

On Mon, Jan 13, 2020 at 6:07 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Fri, Jan 10, 2020 at 08:56:39PM -0800, Saravana Kannan wrote:
> > Hi Thierry,
> >
> > I happened upon this thread while looking into another thread [1].
> >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > On some platforms, the firmware will setup hardware to read from a given
> > > region of memory. One such example is a display controller that is
> > > scanning out a splash screen from physical memory.
> > >
> > > During Linux' boot process, the ARM SMMU will configure all contexts to
> > > fault by default. This means that memory accesses that happen by an SMMU
> > > master before its driver has had a chance to properly set up the IOMMU
> > > will cause a fault. This is especially annoying for something like the
> > > display controller scanning out a splash screen because the faults will
> > > result in the display controller getting bogus data (all-ones on Tegra)
> > > and since it repeatedly scans that framebuffer, it will keep triggering
> > > such faults and spam the boot log with them.
> >
> > While I'm not an expert on IOMMUs, I have a decent high level
> > understanding of the problem you are trying to solve.
> >
> > > In order to work around such problems, scan the device tree for IOMMU
> > > masters and set up a special identity domain that will map 1:1 all of
> > > the reserved regions associated with them. This happens before the SMMU
> > > is enabled, so that the mappings are already set up before translations
> > > begin.
> >
> > I'm not sure if this RFC will solve the splash screen issue across SoCs
> > ([1] seems to have a different issue and might not have memory-regions).
>
> Looking at the proposed patches, they look like they're solving a
> different, although related, problem. In your case you seem to have a
> bootloader that already sets up the SMMU to translate for a given
> master. The case that I'm trying to solve here is where the bootloader
> has not yet setup the SMMU but has instead pointed some device to read
> memory from a physical address.

Ah, thanks for explaining your scenario.

> So what this patch is trying to solve is to create the mappings that a
> given device needs in order to transparently keep scanning out from an
> address region that it's using, even when the kernel enables address
> translation.

Ok, makes sense.

> In the case where you're trying to inherit the bootloader configuration
> of the SMMU, how do you solve the problem of passing the page tables to
> the kernel? You must have some way of reserving that memory in order to
> prevent the kernel from reusing it.

Maybe "inherit" makes it sound a lot more complicated than it is?
Bjorn will know the details of what the bootloader sets up. But
AFAICT, it looks like a simple "bypass"/identity mapping too. I don't
think it actually sets up page tables.

> > > One thing that was pointed out earlier, and which I don't have a good
> > > idea on how to solve it, is that the early identity domain is not
> > > discarded. The assumption is that the standard direct mappings code of
> > > the IOMMU framework will replace the early identity domain once devices
> > > are properly attached to domains, but we don't have a good point in time
> > > when it would be safe to remove the early identity domain.
> >
> > You are in luck! I added sync_state() driver callbacks [2] exactly for
> > cases like this. Heck, I even listed IOMMUs as an example use case. :)
> > sync_state() works even with modules if one enables of_devlink [3] kernel
> > parameter (which already supports iommus DT bindings). I'd be happy to
> > answer any question you have on sync_state() and of_devlink.
>
> I wasn't aware of of_devlink, but I like it! It does have the drawback
> that you need to reimplement a lot of the (phandle, specifier) parsing
> code, but I don't think anybody was ever able to solve anyway.
>
> Looking at struct supplier_bindings, I think it might be possible to
> share the property parsing code with the subsystems, though. But I
> digress...

Yeah, I don't want to digress either. But as of now, iommus are
already supported.

> Regarding sync_state(), I'm not sure it would be useful in my case. One
> of the drivers I'm dealing with, for example, is a composite driver that
> is created by tying together multiple devices.

If you can give additional details about this, I can give a better
answer. But with the limited info, there's one way I can think of to
handle this. To make the explanation easier, let's call the device
that references the IOMMU in DT as the "direct consumer device". The
driver __probe function__ for the direct consumer device can add a
device link from the composite device to the iommu device. This will
ensure the iommu device doesn't get the sync_state() callback before
the composite device probes. Keep in mind that devices do not need to
be probed to add device links between them. Only the supplier needs to
be registered with the driver framework to be able to add device links
to them.

> In that setup, all of the
> devices will have to be probed before the component device is
> initialized. It's only at that point where the SMMU mapping is
> established, so releasing the mapping in ->sync_state() would be too
> early.

With the suggestion I gave above, this might still work? I need more
details to be sure.

> One other thing I'm curious about with sync_state() is how do you handle
> the case where a consumer requires, say, a given regulator to supply a
> certain voltage. What if that voltage is different from what's currently
> configured?

The regulator sync state implementation (when it's implemented) should
only prevent voltages from going down. Probably should do the same for
current.

> According to the documentation, ->sync_state() is the point
> at which the provider driver will match the configuration to consumer
> requests. How do you communicate to the consumer that they aren't yet
> getting the configuration that they're asking for?

If the consumer is trying to increase the voltage, it won't/shouldn't
be rejected. The sync_state() implementation only needs to keep the
minimum voltage to match what the bootloader left it on at. Voltage
can go anywhere from there to max allowed until sync_state() comes.

> I suppose the example might be somewhat contrived. Presumably any
> devices sharing a regulator would have to be compatible in terms of
> their input voltages, so maybe this can't ever happen?

Example is fine. Documentation can be improved :)

> One case that I could imagine might happen, though, is if a device is
> probed and the driver wants to enable the regulator. But if the
> regulator is disabled on boot, isn't the regulator then going to be kept
> powered off until ->sync_state()?

No, the regulators that were off at kernel init won't/shouldn't be
forced to stay off. They shouldn't be limited in any way.

> If so, will the regulator_enable()
> call still succeed? If yes, doesn't that mean that the consumer device
> may malfunction because it's not actually powered on after the driver
> has requested so?

The above answer should clarify this.

> > > One option that I can think of would be to create an early identity
> > > domain for each master and inherit it when that master is attached to
> > > the domain later on, but that seems rather complicated from an book-
> > > keeping point of view and tricky because we need to be careful not to
> > > map regions twice, etc.
> > >
> > > Any good ideas on how to solve this? It'd also be interesting to see if
> > > there's a more generic way of doing this. I know that something like
> > > this isn't necessary on earlier Tegra SoCs with the custom Tegra SMMU
> > > because translations are only enabled when the devices are attached to a
> > > domain.
> >
> > Good foresight. As [1] shows, identity mapping doesn't solve it in a
> > generic way.
>
> I think your [1] is a special case of identity mappings where the
> mappings are already active. If you pass the information about the
> mappings via memory-region properties, then you should be able to
> reconstruct the identity mapping in the kernel before switching the
> SMMU over to the new mapping for a seamless transition.

Ok, makes sense. But I don't have the full details here. So I'll let
Bjorn comment here.

> > How about actually reading the current settings/mappings and just
> > inheriting that instead of always doing a 1:1 identity mapping? And then
> > those "inherited" mappings can be dropped when you get a sync_state().
> > What's wrong with that option?
>
> Reading the current mappings should also work. You still need to ensure
> that the in-memory page tables for the mappings are properly protected
> so that nobody can overwrite them. In that case, however, you may also
> want to pass those page tables into the kernel so that the mappings can
> be extended, otherwise you'll be stuck with an IOMMU domain that you
> can't modify.
>
> I can see some potential pitfalls with that. What, for example, if the
> bootloader has chosen to use a different page table format than what the
> kernel wants to use? In order to inherit the mappings, you'd have to do
> some fairly complication conversions in order for this to work.

Looks like the most real scenarios are just different ways of setting
up identity-mapping or following "memory-regions". So, we don't have
to do a full fledged inheritance until someone actually needs them.

> One major downside with inheriting the mappings from the bootloader is
> that you assume that the bootloader has already set up any mappings.
> None of the setups that I'm working on does that. So even if you can
> solve mapping inheritance in a generic way, it doesn't mean that it can
> be used on all platforms. You'll always have the case where you need to
> create the mappings from scratch to 1:1 map the physical addresses that
> hardware might be accessing.

In your case, when mappings aren't set up, it looks like the IOMMU is
behaving like a pass-thru. In which case, it's "inherited mapping"
would be the identity-mapping.

Thanks,
Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
