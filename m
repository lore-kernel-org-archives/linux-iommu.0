Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F3C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 19:50:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46F0611CE
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 19:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46F0611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60EAA404FB;
	Tue, 22 Jun 2021 19:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id glNQMm5UzGll; Tue, 22 Jun 2021 19:50:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EB0B240313;
	Tue, 22 Jun 2021 19:50:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAE07C0010;
	Tue, 22 Jun 2021 19:50:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB114C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 19:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B34FF83449
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 19:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MJLx9-_YXRhq for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 19:50:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CE3582D12
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 19:50:31 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id f5so167073qvu.8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N93FQS54KNMw/RWZd3sdd1/c5zsgaKSRIH5cGtG3wLQ=;
 b=nKSDq/oCJcM6qZHdPsZIzNgBCyluw3srCscilwpHd/8GiydqZY43q/T3vv2Nn2jbKD
 jegHEFKq7oKJUZmrnbp2L6fkE3vgH2JXF/RfOrax19gy3NpN1urkxXl0RO3exPK9Eg/i
 cQzl2nnV7iu4Ug4cNN87vHMj6sK4LHNEdz+OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N93FQS54KNMw/RWZd3sdd1/c5zsgaKSRIH5cGtG3wLQ=;
 b=hKMNb302JfqeMXtCpPIU680hDYZ07DzrJ+VqQ46l4kYLb0BouC5pxmlnVlckxatCUu
 GONIEhjZR/zRoQY78LdwBNOfQkMC89gphExNaw9TuXzn06KHnfNlnUMlf6pUGoMDrSXn
 hDdkKXftPi05cRBzUeE+BFguXF5yZPB3jAJ3mtem74OObrrNk5bjB86xQKsBeaONGsXd
 N8N0qfQNzORyZvMBsRMq50i275Aa04fAVjt2lmAk6L3VVrCNe64H6l078OfYjdn2Bf2r
 dZ6eJbIVr2maODEMMfn16PmHgSHjK8lXzgOo21rBsTBpASBZCbcMKVtJjCRDtzQX+7Bc
 /Ssw==
X-Gm-Message-State: AOAM5315fevhwTTzgw0yOM9/fcgqyQ7vsH710EeM30Np/W7jinE1RoRW
 5G3NANq87VCaM9BOA/sg9kjLyojIV9cadQ==
X-Google-Smtp-Source: ABdhPJx2U6RRSmZmjzZv4STkZRZxHr5c5ox79wAp5Y7rmm1wETn3jGxESV2tR/VJKHi8ZiwUZqDOLg==
X-Received: by 2002:ad4:5426:: with SMTP id g6mr464311qvt.47.1624391429349;
 Tue, 22 Jun 2021 12:50:29 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com.
 [209.85.222.179])
 by smtp.gmail.com with ESMTPSA id x19sm2301563qtp.58.2021.06.22.12.50.26
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 12:50:28 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id w21so28834512qkb.9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 12:50:26 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr6836288ybk.405.1624391426495; 
 Tue, 22 Jun 2021 12:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <f3078ff2-97a6-6029-b584-1589ed184579@huawei.com>
In-Reply-To: <f3078ff2-97a6-6029-b584-1589ed184579@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jun 2021 12:50:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyicdP+czVyMPFpuSDHcB_jF3ikjSjqu_X0qVsUReiOA@mail.gmail.com>
Message-ID: <CAD=FV=WyicdP+czVyMPFpuSDHcB_jF3ikjSjqu_X0qVsUReiOA@mail.gmail.com>
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To: John Garry <john.garry@huawei.com>
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

On Tue, Jun 22, 2021 at 10:46 AM John Garry <john.garry@huawei.com> wrote:
>
> On 22/06/2021 00:52, Douglas Anderson wrote:
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
> >
>
> JFYI, In case to missed it, and I know it's not the same thing as you
> want, above, but the following series will allow you to build the kernel
> to default to lazy mode:
>
> https://lore.kernel.org/linux-iommu/1624016058-189713-1-git-send-email-john.garry@huawei.com/T/#m21bc07b9353b3ba85f2a40557645c2bcc13cbb3e
>
> So iommu.strict=0 would be no longer always required for arm64.

Excellent! I'm never a fan of command line parameters as a replacement
for Kconfig. They are great for debugging or for cases where the user
of the kernel and the person compiling the kernel are not the same
(like with off-the-shelf Linux distros) but aren't great for setting a
default for embedded environments.

I actually think that something like my patchset may be even more
important atop yours. Do you agree? If the default is non-strict it
could be extra important to be able to mark a certain device to be in
"strict" mode.

...also, unfortunately I probably won't be able to use your patchest
for my use case. I think we want the extra level of paranoia by
default and really only want to allow non-strict mode for devices that
we're really convinced are safe.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
