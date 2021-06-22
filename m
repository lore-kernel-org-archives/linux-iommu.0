Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6805EC49EA2
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 16:06:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D61F61107
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 16:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D61F61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C53E76089B;
	Tue, 22 Jun 2021 16:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDbdkmRMhGcf; Tue, 22 Jun 2021 16:06:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C2186080A;
	Tue, 22 Jun 2021 16:06:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F56EC0010;
	Tue, 22 Jun 2021 16:06:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CA73C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 16:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EC1D83443
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 16:06:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KNfNlMvKzJeX for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:06:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52B2A8300C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 16:06:19 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id r7so16373113qta.12
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=27TVSpBBxDt2V9AC2sSKfX2OLzeZI7qCt0FynkFE4h0=;
 b=Ynk7wRsFyvpT95XM0xfR8pPSpaKhc1aGG9sYY9vD7q+6CkrKHU8tOKYrBk2Q7Mp6fp
 s+4/Zq5HmwR0VVKGBrsD6IR7wLEr/+QSn8/UfoMPBQ8Ntd0mFmKDAI7KWYZWyagDWtNr
 yMdORTYYlNaLpAKRj+yBSDhNYdhBiorvwkJUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=27TVSpBBxDt2V9AC2sSKfX2OLzeZI7qCt0FynkFE4h0=;
 b=d4lJKg4+s0yxEr+TWHcDwtasrayJptNc6wZ/O9a9eNTXGcLf2RYmKNPyIVTJhF1F0b
 5IVniOzaqdkM3o3gQbKL/hfHI0veG9bIZ0HEmpmRyn9Me7k60tLI22S5IhBRbFyDnA1B
 lG1MZNM7G2kiPlI0IKfUbhQS13wI5JCp/BnOg2Q+9BkC0zy9/vHkoavH1zMHlinu54BN
 5SNg5wuVMLbNc1Pe+ty8jCOKfX4oZ7Hkm2kTGYHMBt9ERP0bsVVMeoBINlU26/f9N5X3
 MaFj2Td2tGbhvHdZukn5UncPxfZx7rOwhoisf02rJtJaykrKtxM3uOtbn7MkHwM+QoIi
 NvqQ==
X-Gm-Message-State: AOAM533Zkbp25p6ZrHg9XiVFQcVuiy1EVF9pQjZxqtsnNBRpmVEnbay2
 r7HOIC3trYA5iku/qgh5D2r+8u9ot7TFCg==
X-Google-Smtp-Source: ABdhPJy7QtrO1nQRJThn4wNpIwYuswYwy51k4XClqQwZKmX2HuQe+rJqaDupmGN2Uiv7oGNd69r3gg==
X-Received: by 2002:ac8:7d48:: with SMTP id h8mr4051066qtb.317.1624377977999; 
 Tue, 22 Jun 2021 09:06:17 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com.
 [209.85.222.180])
 by smtp.gmail.com with ESMTPSA id d23sm1877988qto.74.2021.06.22.09.06.15
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 09:06:16 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id g4so39611785qkl.1
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 09:06:15 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr5576344ybk.405.1624377975055; 
 Tue, 22 Jun 2021 09:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
In-Reply-To: <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jun 2021 09:06:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
Message-ID: <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
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
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>
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

On Tue, Jun 22, 2021 at 4:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Doug,
>
> On 2021-06-22 00:52, Douglas Anderson wrote:
> >
> > This patch attempts to put forward a proposal for enabling non-strict
> > DMA on a device-by-device basis. The patch series requests non-strict
> > DMA for the Qualcomm SDHCI controller as a first device to enable,
> > getting a nice bump in performance with what's believed to be a very
> > small drop in security / safety (see the patch for the full argument).
> >
> > As part of this patch series I am end up slightly cleaning up some of
> > the interactions between the PCI subsystem and the IOMMU subsystem but
> > I don't go all the way to fully remove all the tentacles. Specifically
> > this patch series only concerns itself with a single aspect: strict
> > vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
> > to talk about / reason about for more subsystems compared to overall
> > deciding what it means for a device to be "external" or "untrusted".
> >
> > If something like this patch series ends up being landable, it will
> > undoubtedly need coordination between many maintainers to land. I
> > believe it's fully bisectable but later patches in the series
> > definitely depend on earlier ones. Sorry for the long CC list. :(
>
> Unfortunately, this doesn't work. In normal operation, the default
> domains should be established long before individual drivers are even
> loaded (if they are modules), let alone anywhere near probing. The fact
> that iommu_probe_device() sometimes gets called far too late off the
> back of driver probe is an unfortunate artefact of the original
> probe-deferral scheme, and causes other problems like potentially
> malformed groups - I've been forming a plan to fix that for a while now,
> so I for one really can't condone anything trying to rely on it.
> Non-deterministic behaviour based on driver probe order for multi-device
> groups is part of the existing problem, and your proposal seems equally
> vulnerable to that too.

Doh! :( I definitely can't say I understand the iommu subsystem
amazingly well. It was working for me, but I could believe that I was
somehow violating a rule somewhere.

I'm having a bit of a hard time understanding where the problem is
though. Is there any chance that you missed the part of my series
where I introduced a "pre_probe" step? Specifically, I see this:

* really_probe() is called w/ a driver and a device.
* -> calls dev->bus->dma_configure() w/ a "struct device *"
* -> eventually calls iommu_probe_device() w/ the device.
* -> calls iommu_alloc_default_domain() w/ the device
* -> calls iommu_group_alloc_default_domain()
* -> always allocates a new domain

...so we always have a "struct device" when a domain is allocated if
that domain is going to be associated with a device.

I will agree that iommu_probe_device() is called before the driver
probe, but unless I missed something it's after the device driver is
loaded.  ...and assuming something like patch #1 in this series looks
OK then iommu_probe_device() will be called after "pre_probe".

So assuming I'm not missing something, I'm not actually relying the
IOMMU getting init off the back of driver probe.


> FWIW we already have a go-faster knob for people who want to tweak the
> security/performance compromise for specific devices, namely the sysfs
> interface for changing a group's domain type before binding the relevant
> driver(s). Is that something you could use in your application, say from
> an initramfs script?

We've never had an initramfs script in Chrome OS. I don't know all the
history of why (I'm trying to check), but I'm nearly certain it was a
conscious decision. Probably it has to do with the fact that we're not
trying to build a generic distribution where a single boot source can
boot a huge variety of hardware. We generally have one kernel for a
class of devices. I believe avoiding the initramfs just keeps things
simpler.

I think trying to revamp Chrome OS to switch to an initramfs type
system would be a pretty big undertaking since (as I understand it)
you can't just run a little command and then return to the normal boot
flow. Once you switch to initramfs you're committing to finding /
setting up the rootfs yourself and on Chrome OS I believe that means a
whole bunch of dm-verity work.


...so probably the initramfs is a no-go for me, but I'm still crossing
my fingers that the pre_probe() might be legit if you take a second
look at it?

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
