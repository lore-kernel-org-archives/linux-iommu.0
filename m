Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC28C07E96
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 14:41:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFD561626
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 14:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFD561626
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6BCE5400E6;
	Thu,  8 Jul 2021 14:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JO-RTkCOO5DN; Thu,  8 Jul 2021 14:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B8C94000B;
	Thu,  8 Jul 2021 14:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2823EC001A;
	Thu,  8 Jul 2021 14:41:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AABAC001A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 14:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CB0A83C0C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 14:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XTPcQcUNGJIA for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 14:41:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 931DA83C08
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 14:41:44 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id i4so2424985qvq.10
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=72Nulo0ReEKh1o09njcEPjT3ZEsb/u/uPS+kUmVy8sU=;
 b=FWRbODpJvUDW1Hvvw6jBbIxh3B4HQaPFbePSQUSLSnU3oLIOtqDyL5r0r30yICdLR5
 yPDKdQ08N64edmb3D42lPuwAt1byFqGLzD6Q9oAWRnvo2NBTHJameLigCEbX0UTLUCUf
 YeA2vARMIdIU5/CZ+Oz55gYoydq3XkuhCgH0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=72Nulo0ReEKh1o09njcEPjT3ZEsb/u/uPS+kUmVy8sU=;
 b=CmqWMnCsnncm/ClFeYBWTDentThlr4H7Fc+4hJVetY/TTStN6EI/MyTXk+vJo5Pvd4
 qbLaidWrmDg0bqAkUirM4EhFCXtRZ6MuIda8FW3kYNQOvni837qqTzxsAJWKl1PZ4ptU
 THmQU8tb80JRRBVRtMBOnPc2Sn7yFgpgMUTYHzE1yKhhya+PEN+CHVCMB2U0TsSiq5MQ
 MxIgc9Onkqd1JEpVEOkSWvW/Hc9JJ6P3g9PcXOa4u/TeM3EhPTWTOqsjyvsxKyDimLZi
 KbXvj6iNajIidVjAFqldAQmHUZd76Rrje1xDOutlEctfxJ3+s1JsSb6bDFa0ciyWMfpD
 iWug==
X-Gm-Message-State: AOAM533HLg7sPDnD5/FSj8XYCFiRZ42I9dHsZ/ku6S9dxvDYLFv6b5o9
 JDmG5zDTSUlUyBKlK/0TemOTzRWR1a58BQ==
X-Google-Smtp-Source: ABdhPJzUpr9h478aHZJioaRsyJa6morvLaOKDlRU/mCNr7hS5U7QekRhODN/hQthobY46ADC6mjK3Q==
X-Received: by 2002:a05:6214:2aa8:: with SMTP id
 js8mr16228873qvb.4.1625755303263; 
 Thu, 08 Jul 2021 07:41:43 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com.
 [209.85.219.178])
 by smtp.gmail.com with ESMTPSA id i21sm999597qti.45.2021.07.08.07.41.43
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 07:41:43 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id r135so9391954ybc.0
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 07:41:43 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id
 u130mr41384789ybb.257.1625754992872; 
 Thu, 08 Jul 2021 07:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org>
In-Reply-To: <YOaymBHc4g2cIfRn@8bytes.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Jul 2021 07:36:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
Message-ID: <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To: Joerg Roedel <joro@8bytes.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>, Jonathan Corbet <corbet@lwn.net>,
 quic_c_gdjako@quicinc.com, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Sonny Rao <sonnyrao@chromium.org>,
 Vlastimil Babka <vbabka@suse.cz>, Randy Dunlap <rdunlap@infradead.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
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

On Thu, Jul 8, 2021 at 1:09 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Wed, Jul 07, 2021 at 01:00:13PM -0700, Doug Anderson wrote:
> > a) Nothing is inherently broken with my current approach.
> >
> > b) My current approach doesn't make anybody terribly upset even if
> > nobody is totally in love with it.
>
> Well, no, sorry :)
>
> I don't think it is a good idea to allow drivers to opt-out of the
> strict-setting. This is a platform or user decision, and the driver
> should accept whatever it gets.

Sure, I agree with you there. The driver shouldn't ever be able to
override and make things less strict than the user or platform wants.
It feels like that can be accomplished. See below.


> So the real question is still why strict is the default setting and how
> to change that.

I guess there are two strategies if we agree that there's a benefit to
running some devices in strict and others in non-strict:

* opt-in to strict: default is non-strict and we have to explicitly
list what we want to be strict.

* opt-out of strict: default is strict and we have to explicitly list
what we want to be non-strict.

I guess the question is: do we allow both strategies or only one of
them? I think you are suggesting that the kernel should support
"opt-in" to strict and that that matches the status quo with PCI on
x86. I'm pushing for some type of "opt-out" of strict support. I have
heard from security folks that they'd prefer "opt-out" of strict as
well. If we're willing to accept more complex config options we could
support both choosable by KConfig. How it'd all work in my mind:

Command line:

* iommu.strict=0 - suggest non-strict by default
* iommu.strict=1 - force strict for all drivers
* iommu.strict not specified - no opinion

Kconfig:

* IOMMU_DEFAULT_LAZY - suggest non-strict by default; drivers can
opt-in to strict
* IOMMU_DEFAULT_STRICT - force strict for all drivers
* IOMMU_DEFAULT_LOOSE_STRICT - allow explicit suggestions for laziness
but default to strict if no votes.

Drivers:
* suggest lazy - suggest non-strict
* force strict - force strict
* no vote


How the above work together:

* if _any_ of the three things wants strict then it's strict.

* if _all_ of the three things want lazy then it's lazy.

* If the KConfig is "loose strict" and the command line is set to
"lazy" then it's equivalent to the KConfig saying "lazy". In other
words drivers could still "opt-in" to strict but otherwise we'd be
lazy.

* The only way for a driver's "suggest lazy" vote to have any effect
at all is if "iommu.strict" wasn't specified on the command line _and_
if the KConfig was "loose strict". This is effectively the "opt-out"
of lazy.


If you think the strategy I describe above is garbage then would you
be OK if I re-worked my patchset to at least allow non-PCI drivers to
"opt-in" to strict? Effectively I'd change patch #3 to list all of the
peripherals on my SoC _except_ the USB and SD/MMC and request that
they all be strict. If other people expressed their preference for the
"opt-out" of strict strategy would that change your mind?


> Or document for the users that want performance how to
> change the setting, so that they can decide.

Pushing this to the users can make sense for a Linux distribution but
probably less sense for an embedded platform. So I'm happy to make
some way for a user to override this (like via kernel command line),
but I also strongly believe there should be a default that users don't
have to futz with that we think is correct.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
