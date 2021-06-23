Return-Path: <SRS0=khdJ=LR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0DC4743C
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 17:36:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897B9611C1
	for <iommu@archiver.kernel.org>; Wed, 23 Jun 2021 17:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897B9611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43902608BF;
	Wed, 23 Jun 2021 17:36:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wohUPfiAyNB3; Wed, 23 Jun 2021 17:36:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C239D606DB;
	Wed, 23 Jun 2021 17:36:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A6F6C0010;
	Wed, 23 Jun 2021 17:36:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0846C000E
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 17:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BC1083B84
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 17:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C4nF5VBvw9l1 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 17:36:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A9B083B8F
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 17:36:42 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so2740392otl.3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+ydUWrmEdj6nDidfKX+/eYYcUGvXa+c1FifMacfsvQU=;
 b=HhichcHb3lYg8f6A1A6f+TM9tCumTcNG/WqCjLQ0w5/X1cgDGILBlnABMVIYQSC4hX
 5FGPtqKGADHe5SnWI/x0Lm+MHT7Uz/XShpjncKA513+Ao3e7DYNryEeIrJMdt5ciOLXx
 upL7oGdwMLLkqwKofk0EjHmwgo/PwFb9E9Bco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ydUWrmEdj6nDidfKX+/eYYcUGvXa+c1FifMacfsvQU=;
 b=C3bk+4vZCHm4jaTMdz4+XR4KZ51Ub9Tu5qQy+PDoTtfXi5RiJ588Za7NQCPDt8QP7e
 lewKQSHe31NJRZW9/upj+1skDUt1KWWLgQJ/WAogQ874IutfuV5I20PFZr3rynJ6FSWl
 5ZX54hZVzORsvw9i98y7BGMisVG5HpEEXVfRw1oJaDxmP9pAEkHYdXuHfZr0omgo5U+N
 XvXlUAP8bb1m53cnWBUjUXkXv+ZqK5rzMRNvP7/zuOm237cbq5vPFPAL6gQ1w2J2xqii
 gVXKy12vBF/+OdVsJ6COW5tdtCJPj3GVTjE0gX0mjHWMO/nOxiBnM2x7N7MewhYokGGl
 gd4g==
X-Gm-Message-State: AOAM531CuC3wZPMAyw4gLCN/3SqMITHTdAZ0cL/62Q3X8PXeplUpySt/
 dmiwQ0JpS5ECQKHvqs/ni3r5Neo/65Q1tQ==
X-Google-Smtp-Source: ABdhPJyh7j58fg7cQFsCqLQjSLvGWAntF6YzRKEf2vVpHjxrNcGbXDc+GZj5QFnEB2j5LYe0tpA8HQ==
X-Received: by 2002:a05:6830:4d2:: with SMTP id
 s18mr870425otd.361.1624469800952; 
 Wed, 23 Jun 2021 10:36:40 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com.
 [209.85.210.45])
 by smtp.gmail.com with ESMTPSA id n20sm138051otj.11.2021.06.23.10.36.40
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 10:36:40 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id
 7-20020a9d0d070000b0290439abcef697so2744019oti.2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Jun 2021 10:36:40 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr688032ybm.345.1624469392601; 
 Wed, 23 Jun 2021 10:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
 <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
 <498f3184-99fe-c21b-0eb0-a199f2615ceb@arm.com>
In-Reply-To: <498f3184-99fe-c21b-0eb0-a199f2615ceb@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 23 Jun 2021 10:29:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQBRY4hobBWVWtC8y07NLRLhpejdvUAD+7UWw-jqP2UA@mail.gmail.com>
Message-ID: <CAD=FV=UQBRY4hobBWVWtC8y07NLRLhpejdvUAD+7UWw-jqP2UA@mail.gmail.com>
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, quic_c_gdjako@quicinc.com,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Gross <agross@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Sonny Rao <sonnyrao@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
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

Hi,

On Tue, Jun 22, 2021 at 3:10 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-22 17:06, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jun 22, 2021 at 4:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> Hi Doug,
> >>
> >> On 2021-06-22 00:52, Douglas Anderson wrote:
> >>>
> >>> This patch attempts to put forward a proposal for enabling non-strict
> >>> DMA on a device-by-device basis. The patch series requests non-strict
> >>> DMA for the Qualcomm SDHCI controller as a first device to enable,
> >>> getting a nice bump in performance with what's believed to be a very
> >>> small drop in security / safety (see the patch for the full argument).
> >>>
> >>> As part of this patch series I am end up slightly cleaning up some of
> >>> the interactions between the PCI subsystem and the IOMMU subsystem but
> >>> I don't go all the way to fully remove all the tentacles. Specifically
> >>> this patch series only concerns itself with a single aspect: strict
> >>> vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
> >>> to talk about / reason about for more subsystems compared to overall
> >>> deciding what it means for a device to be "external" or "untrusted".
> >>>
> >>> If something like this patch series ends up being landable, it will
> >>> undoubtedly need coordination between many maintainers to land. I
> >>> believe it's fully bisectable but later patches in the series
> >>> definitely depend on earlier ones. Sorry for the long CC list. :(
> >>
> >> Unfortunately, this doesn't work. In normal operation, the default
> >> domains should be established long before individual drivers are even
> >> loaded (if they are modules), let alone anywhere near probing. The fact
> >> that iommu_probe_device() sometimes gets called far too late off the
> >> back of driver probe is an unfortunate artefact of the original
> >> probe-deferral scheme, and causes other problems like potentially
> >> malformed groups - I've been forming a plan to fix that for a while now,
> >> so I for one really can't condone anything trying to rely on it.
> >> Non-deterministic behaviour based on driver probe order for multi-device
> >> groups is part of the existing problem, and your proposal seems equally
> >> vulnerable to that too.
> >
> > Doh! :( I definitely can't say I understand the iommu subsystem
> > amazingly well. It was working for me, but I could believe that I was
> > somehow violating a rule somewhere.
> >
> > I'm having a bit of a hard time understanding where the problem is
> > though. Is there any chance that you missed the part of my series
> > where I introduced a "pre_probe" step? Specifically, I see this:
> >
> > * really_probe() is called w/ a driver and a device.
> > * -> calls dev->bus->dma_configure() w/ a "struct device *"
> > * -> eventually calls iommu_probe_device() w/ the device.
>
> This...
>
> > * -> calls iommu_alloc_default_domain() w/ the device
> > * -> calls iommu_group_alloc_default_domain()
> > * -> always allocates a new domain
> >
> > ...so we always have a "struct device" when a domain is allocated if
> > that domain is going to be associated with a device.
> >
> > I will agree that iommu_probe_device() is called before the driver
> > probe, but unless I missed something it's after the device driver is
> > loaded.  ...and assuming something like patch #1 in this series looks
> > OK then iommu_probe_device() will be called after "pre_probe".
> >
> > So assuming I'm not missing something, I'm not actually relying the
> > IOMMU getting init off the back of driver probe.
>
> ...is implicitly that. Sorry that it's not obvious.
>
> The "proper" flow is that iommu_probe_device() is called for everything
> which already exists during the IOMMU driver's own probe when it calls
> bus_set_iommu(), then at BUS_NOTIFY_ADD_DEVICE time for everything which
> appears subsequently. The only trouble is, to observe it in action on a
> DT-based system you'd currently have to go back at least 4 years, before
> 09515ef5ddad...
>
> Basically there were two issues: firstly we need the of_xlate step
> before add_device (now probe_device) for a DT-based IOMMU driver to know
> whether it should care about the given device or not. When -EPROBE_DEFER
> was the only tool we had to ensure probe ordering, and resolving the
> "iommus" DT property the only place to decide that, delaying it all
> until driver probe time was the only reasonable option, however ugly.
> The iommu_probe_device() "replay" in {of,acpi}_iommu_configure() is
> merely doing its best to fake up the previous behaviour. Try binding a
> dummy driver to your device first, then unbind it and bind the real one,
> and you'll see that iommu_probe_device() doesn't run the second or
> subsequent times. Now that we have fw_devlink to take care of ordering,

I probably haven't been following fw_devlink as closely as I should,
but does it completely replace -EPROBE_DEFER? From what I can tell
right now it helps optimize the boot ordering but it's not mandatory
(AKA Linux should boot/work fine with fw_devlink=off)?


> the main reason for this weirdness is largely gone, so I'm keen to start
> getting rid of the divergence again as far as possible. Fundamentally,
> IOMMU drivers are supposed to be aware of all devices which the kernel
> knows about, regardless of whether they have a driver available or not.
>
> The second issue is that when we have multiple IOMMU instances, the
> initial bus_set_iommu() "replay" is only useful for the first instance,
> so devices managed by other instances which aren't up and running yet
> will be glossed over. Currently this ends up being papered over by the
> solution to the first point on DT systems, while the x86 drivers hide
> their individual IOMMU units behind a single IOMMU API "instance", so
> it's been having little impact in practice. However, improving the core
> API's multi-instance support is an increasingly pressing issue now that
> new more varied systems are showing up, and it's that which is really
> going to be driving the aforementioned changes. FWIW the plan I
> currently have is to hang things off iommu_device_register() instead.

I tried to follow all the above the best I can and hopefully
understood some of it. ;-)

OK, so what do you think about these points?

* I think you are arguing that IOMMU strictness requirements needs to
be known regardless of whether we have a driver for a given device or
not. So the whole pre_probe stuff is just not right.

* One thing that's been proposed is putting strictness info in the
device tree. In theory on device-tree systems you could still put
strictness info in the per-device nodes assuming that all devices are
actually described in the device tree. That sounds nice, but I can
believe it would be pretty hard to parse backward like this. AKA when
the IOMMU probes it would need to find all the device tree nodes that
would end up grouped together parse their details to find out if they
should be non-strict.

* Instead of putting the details in per-device nodes, maybe it makes
sense to accept that we should be specifying these things at the IOMMU
level? If specifying things at the device tree level then the
device-tree node of the IOMMU itself would just have a list of things
that should be strict/non-strict. ...this could potentially be merged
with a hardcoded list of things in the IOMMU driver based on the IOMMU
compatible string.

Do those sound right?

I still haven't totally grokked the ideal way to identify devices. I
guess on Qualcomm systems each device is in its own group and so could
have its own strictness levels? ...or would it be better to list by
"stream ID" or something like that?

If we do something like this then maybe that's a solution that could
land short-ish term? We would know right at init time whether a given
domain should be strict or non-strict and there'd be no requirements
to transition it.


> >> FWIW we already have a go-faster knob for people who want to tweak the
> >> security/performance compromise for specific devices, namely the sysfs
> >> interface for changing a group's domain type before binding the relevant
> >> driver(s). Is that something you could use in your application, say from
> >> an initramfs script?
> >
> > We've never had an initramfs script in Chrome OS. I don't know all the
> > history of why (I'm trying to check), but I'm nearly certain it was a
> > conscious decision. Probably it has to do with the fact that we're not
> > trying to build a generic distribution where a single boot source can
> > boot a huge variety of hardware. We generally have one kernel for a
> > class of devices. I believe avoiding the initramfs just keeps things
> > simpler.
> >
> > I think trying to revamp Chrome OS to switch to an initramfs type
> > system would be a pretty big undertaking since (as I understand it)
> > you can't just run a little command and then return to the normal boot
> > flow. Once you switch to initramfs you're committing to finding /
> > setting up the rootfs yourself and on Chrome OS I believe that means a
> > whole bunch of dm-verity work.
> >
> >
> > ...so probably the initramfs is a no-go for me, but I'm still crossing
> > my fingers that the pre_probe() might be legit if you take a second
> > look at it?
>
> That's fair enough - TBH the current sysfs interface is a pretty
> specialist sport primarily for datacentre folks who can afford to take
> down their 40GBE NIC or whatever momentarily for a longer-term payoff,
> but it was worth exploring - I'm assuming the SDHCI holds your root
> filesystem so you wouldn't be able to do the unbinding dance from real
> userspace. As I said, the idea of embedding any sort of data in
> individual client drivers is a non-starter in general since it only has
> any hope of working on DT platforms (maybe arm64 ACPI too?), and only
> for very much the wrong reasons.
>
> If this is something primarily demanded by QCom platforms in the short
> term,

At the moment I'm mostly focused on QCom platforms, but that's mostly
because they're the first board that I've dealt with that has iommus
on pretty much every peripheral under the sun. That's a _good_ thing,
but it also means it's where we're hitting all these performance
issues. I believe that the usage of "iommus everywhere" is about to
become a lot more widespread across the SoC ecosystem, especially as
they are important for virtualization and that seems to be a hot-topic
these days.

Basically: I could land a short-term hack a solution for me (and
probably this is the right thing for me to do?), but I'm very much
interested in finding a better solution, ideally something that we
could achieve in something less than a year? Am I dreaming?


> I'm tempted to say just try it with more device-matching magic in
> arm-smmu-qcom.

Yeah, I had this working (at least as far as my testing went)
downstream in the chromeos-5.4 tree. I basically just implemented
"init_context" for the arm-smmu-qcom driver and then if the "struct
device *" passed in matched the SDMMC compatible string I just ORed in
"IO_PGTABLE_QUIRK_NON_STRICT". That actually seemed to work fine in
the downstream kernel tree but not upstream. I believe it broke in
commit a250c23f15c2 ("iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE")
because the flush queue stopped getting initted.

I think I could revamp my patch series to continue to have the
strictness attributes in the "struct iommu_domain" but just get rid of
the bits in the "struct device" and obviously get rid of the
"pre_probe" patch. Would something like that be acceptable?


> Otherwise, the idea of growing the sysfs interface to
> allow switching a DMA domain from default-strict to non-strict is
> certainly an interesting prospect. Going a step beyond that to bring up
> a flush queue 'live' without rebuilding the whole group and domain could
> get ugly when it comes to drivers' interaction with io-pgtable, but I
> think it might be *technically* feasible...

It seems like it would be nice, but maybe with the above we could get
by without having to do this?

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
