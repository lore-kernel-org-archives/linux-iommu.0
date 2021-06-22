Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F39C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 20:10:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4151B61075
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 20:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4151B61075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60BB340545;
	Tue, 22 Jun 2021 20:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wxs7QLHQSRJL; Tue, 22 Jun 2021 20:10:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0F4740534;
	Tue, 22 Jun 2021 20:10:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4289C001C;
	Tue, 22 Jun 2021 20:10:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D6CCC0010
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 20:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A2244015C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 20:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTsXAwxu8321 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 20:10:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0B89400AF
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 20:10:48 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id t9so399716qtw.7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FEaj5TzKzhC7h9IFSKKjMs8DSuzea5RNxJgmYoQLtDo=;
 b=gAVB6WdGFfSF8M3fXNSIPpQmdJeqZQsRwA717UsvPbCaHtHJwO67jeInsCAEu8fZ9h
 uHT5p2OxZYu2RG7C998+c+PSzH1bWfNmR/AKE4JJasXBiXiAvt9eghjBffcqzfsWT6O8
 itPCAH6dnbArXOZBiLxZWkyFcZYrakdwz1qMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FEaj5TzKzhC7h9IFSKKjMs8DSuzea5RNxJgmYoQLtDo=;
 b=X5Kgmv5ER/7IlQswm7aIu7+fc+I8mmi+kGW+PEX1kCiHSwTT08Jcd8vwQnWFV8LfWK
 SmJtmCTYq3BPQiJ/BkwADXvLmZQdXjx3kIZFmPLLP+cjfagAYG/gZMkIPFtGNfi2lJF5
 dHlv8e9XX4FJk/6LIC6Ml+trhvLRTJhnFCGp9oMRrCfp2QRJD+r5u7UHnWI3z8CbogZi
 WhayRXw2XekaCJCXk2wuZaoWcv6hO9xtN3Mx0iuLBvndea12cUyYsuRg8KRvAg+wHH49
 P0iDwq8KoWWzuU7QHlIPLRd8/g46QHcJZcftz1Qzuh3MdfdPE/nT2xf6WxMYM6OW3DO/
 P2Kg==
X-Gm-Message-State: AOAM530sxgo8cmYIbFA5LlNbyWE0WY8uNvwsDFRwFzv9b4GUOSg+bkFL
 rP2xzDQmGzMkftTt1Z8FLpjwbcN7jEC1bw==
X-Google-Smtp-Source: ABdhPJy6iLcaZ2XDgBgxVp1xkdQfQb9Tlhol8D5lh0xlpBGVjAyvnXYc95o0uF1ZMN5aYuk81BEy3g==
X-Received: by 2002:ac8:41c4:: with SMTP id o4mr508212qtm.162.1624392647606;
 Tue, 22 Jun 2021 13:10:47 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com.
 [209.85.222.180])
 by smtp.gmail.com with ESMTPSA id i21sm13749549qkl.20.2021.06.22.13.10.45
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 13:10:46 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id w21so28994536qkb.9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 13:10:45 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr7216839ybm.345.1624392645386; 
 Tue, 22 Jun 2021 13:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
 <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
 <20210622200219.GA28722@robh.at.kernel.org>
 <CAGETcx8Cpjvsr2K6f2oDNJDcGiu2T1fEf3D_2S4THduH4cPzKQ@mail.gmail.com>
In-Reply-To: <CAGETcx8Cpjvsr2K6f2oDNJDcGiu2T1fEf3D_2S4THduH4cPzKQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jun 2021 13:10:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xw=NBkozOb4d4TM5DwBCSOG7v3ZA5ZgpcZqtQXE5UPsg@mail.gmail.com>
Message-ID: <CAD=FV=Xw=NBkozOb4d4TM5DwBCSOG7v3ZA5ZgpcZqtQXE5UPsg@mail.gmail.com>
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To: Saravana Kannan <saravanak@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Rob Herring <robh@kernel.org>,
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
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On Tue, Jun 22, 2021 at 1:06 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Jun 22, 2021 at 1:02 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jun 22, 2021 at 09:06:02AM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Tue, Jun 22, 2021 at 4:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > Hi Doug,
> > > >
> > > > On 2021-06-22 00:52, Douglas Anderson wrote:
> > > > >
> > > > > This patch attempts to put forward a proposal for enabling non-strict
> > > > > DMA on a device-by-device basis. The patch series requests non-strict
> > > > > DMA for the Qualcomm SDHCI controller as a first device to enable,
> > > > > getting a nice bump in performance with what's believed to be a very
> > > > > small drop in security / safety (see the patch for the full argument).
> > > > >
> > > > > As part of this patch series I am end up slightly cleaning up some of
> > > > > the interactions between the PCI subsystem and the IOMMU subsystem but
> > > > > I don't go all the way to fully remove all the tentacles. Specifically
> > > > > this patch series only concerns itself with a single aspect: strict
> > > > > vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
> > > > > to talk about / reason about for more subsystems compared to overall
> > > > > deciding what it means for a device to be "external" or "untrusted".
> > > > >
> > > > > If something like this patch series ends up being landable, it will
> > > > > undoubtedly need coordination between many maintainers to land. I
> > > > > believe it's fully bisectable but later patches in the series
> > > > > definitely depend on earlier ones. Sorry for the long CC list. :(
> > > >
> > > > Unfortunately, this doesn't work. In normal operation, the default
> > > > domains should be established long before individual drivers are even
> > > > loaded (if they are modules), let alone anywhere near probing. The fact
> > > > that iommu_probe_device() sometimes gets called far too late off the
> > > > back of driver probe is an unfortunate artefact of the original
> > > > probe-deferral scheme, and causes other problems like potentially
> > > > malformed groups - I've been forming a plan to fix that for a while now,
> > > > so I for one really can't condone anything trying to rely on it.
> > > > Non-deterministic behaviour based on driver probe order for multi-device
> > > > groups is part of the existing problem, and your proposal seems equally
> > > > vulnerable to that too.
> > >
> > > Doh! :( I definitely can't say I understand the iommu subsystem
> > > amazingly well. It was working for me, but I could believe that I was
> > > somehow violating a rule somewhere.
> > >
> > > I'm having a bit of a hard time understanding where the problem is
> > > though. Is there any chance that you missed the part of my series
> > > where I introduced a "pre_probe" step? Specifically, I see this:
> > >
> > > * really_probe() is called w/ a driver and a device.
> > > * -> calls dev->bus->dma_configure() w/ a "struct device *"
> > > * -> eventually calls iommu_probe_device() w/ the device.
> > > * -> calls iommu_alloc_default_domain() w/ the device
> > > * -> calls iommu_group_alloc_default_domain()
> > > * -> always allocates a new domain
> > >
> > > ...so we always have a "struct device" when a domain is allocated if
> > > that domain is going to be associated with a device.
> > >
> > > I will agree that iommu_probe_device() is called before the driver
> > > probe, but unless I missed something it's after the device driver is
> > > loaded.  ...and assuming something like patch #1 in this series looks
> > > OK then iommu_probe_device() will be called after "pre_probe".
> > >
> > > So assuming I'm not missing something, I'm not actually relying the
> > > IOMMU getting init off the back of driver probe.
> > >
> > >
> > > > FWIW we already have a go-faster knob for people who want to tweak the
> > > > security/performance compromise for specific devices, namely the sysfs
> > > > interface for changing a group's domain type before binding the relevant
> > > > driver(s). Is that something you could use in your application, say from
> > > > an initramfs script?
> > >
> > > We've never had an initramfs script in Chrome OS. I don't know all the
> > > history of why (I'm trying to check), but I'm nearly certain it was a
> > > conscious decision. Probably it has to do with the fact that we're not
> > > trying to build a generic distribution where a single boot source can
> > > boot a huge variety of hardware. We generally have one kernel for a
> > > class of devices. I believe avoiding the initramfs just keeps things
> > > simpler.
> > >
> > > I think trying to revamp Chrome OS to switch to an initramfs type
> > > system would be a pretty big undertaking since (as I understand it)
> > > you can't just run a little command and then return to the normal boot
> > > flow. Once you switch to initramfs you're committing to finding /
> > > setting up the rootfs yourself and on Chrome OS I believe that means a
> > > whole bunch of dm-verity work.
> > >
> > >
> > > ...so probably the initramfs is a no-go for me, but I'm still crossing
> > > my fingers that the pre_probe() might be legit if you take a second
> > > look at it?
> >
> > Couldn't you have a driver flag that has the same effect as twiddling
> > sysfs? At the being of probe, check the flag and go set the underlying
> > sysfs setting in the device.
>
> My understanding of what Robin is saying is that we'd need this info
> well before the driver is even available. The pre_probe() is
> effectively doing the same thing you are suggesting.

Right, I was just about to respond with the same. ;-) So overall right
now we're blocked waiting for someone to point out the error in my
logic. ;-)


> > Though you may want this to be per device, not per driver. To do that
> > early, I think you'd need a DT property. I wouldn't be totally opposed
> > to that and I appreciate you not starting there. :)
>
> Which is what I'm suggest elsewhere in the thread:
>
> https://lore.kernel.org/lkml/CAGETcx83qCZF5JN5cqXxdSFiEgfc4jYESJg-RepL2wJXJv0Eww@mail.gmail.com/

Rob: I'd be happy if you wanted to comment on that thread. If you say
that it's fine to add a generic device tree property to control
strictness then I'm more than happy to add support for it. I've been
going on the theory that you'd NAK such a property but I'm totally
good with being wrong. ;-)

I'd be more than happy if you could suggest what you'd envision such a
property to be named.


-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
