Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270FC433E1
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 19:33:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7477E206E2
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 19:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+KiM8rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7477E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 12C28226EA;
	Tue,  2 Jun 2020 19:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4KXki0eu2Kb; Tue,  2 Jun 2020 19:33:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 57DAE21080;
	Tue,  2 Jun 2020 19:33:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32781C0178;
	Tue,  2 Jun 2020 19:33:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0538EC016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 19:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9F71B226EA
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 19:33:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0dkzWczBO+kD for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 19:33:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 7D47421080
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 19:33:48 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id v2so5622006pfv.7
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=j2731q8TZbNlQF3Z/Bp/V56dsnSlRnzdVVRnH3OA0YQ=;
 b=u+KiM8rkKC+5ACEm+D37UxEKMAjZpNWVemeVjQ2DlN/fbrQljAtpcLea19wo9SJ3zZ
 tQD9Muiy3zxy6qdkHFEJTgb6g9vfXw5yNvNf50QdKL9StCfj1dQx4T74d2GFrwnesuve
 3y2hdJMz2NeBaNDZCPcbB1beX/WCymmiYkJ6ajWy16pHf2psCTbQaaxkhMwZNJUtUiiM
 A/kug+5FjorSKZRndPov3hQGuBYD8lAxS4Yu6dNmw6n5B1YOo1h0G6fUxDqT7uDBpSL2
 BZ3mKtdCY9SIwElxLu9t82mJ2t/CGRZYxVV3ZKd5e55Z+N8Yy9TCalBwiFSp2GgYyAw8
 Qg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j2731q8TZbNlQF3Z/Bp/V56dsnSlRnzdVVRnH3OA0YQ=;
 b=YuqZvYsJX8bBPSYvor83/5oC60WA1gGyKzmQzm6L1JRbswV7YfoCAtjTAcbU3aM2PM
 rV+EznN4PW1m42nS39JNF9StMcmBVLGea95Z5WMDJ/ncTQz0hHKGwoGGfrY0pdMBmDZX
 AvayrfSB9VV18lmDAvYpnkVt45hX9eMr8ivDTjykB0tGQAFDjR5Sfen2uaW/3lazG3Ia
 +lwKLEH4I+GWCcvltFZZ1NQPKFPJxLKxPtXQPAAe0wCHQBIXBItyQ9lQCmae6CpVTL6J
 FQtogQ1TvDAyom1p80foar9Nj6ty2YhNKXq7556R1S0KD2GohbM0QqMEfL1TR+LVJw7r
 R0bg==
X-Gm-Message-State: AOAM53035Nif04UmhJsRmnAeGiPqnrr+0JvOfiLb7j0PhWDkEv/ZWfHb
 tN4HR2MVTvgIOcuUU/j3JN515A==
X-Google-Smtp-Source: ABdhPJyUesfEHfZc8D0N1MFN1N5Jd1zZeoohNWHEhngaOfdDpGXggsJuQz2Z7OJYnatzZFTs893Z9A==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr25062622pgf.140.1591126427475; 
 Tue, 02 Jun 2020 12:33:47 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id m2sm2955054pjk.52.2020.06.02.12.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 12:33:46 -0700 (PDT)
Date: Tue, 2 Jun 2020 12:32:49 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200602193249.GC1799770@builder.lan>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder>
 <20200514193249.GE279327@builder.lan>
 <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
 <20200527110343.GD11111@willie-the-truck>
 <20200602110216.GA3354422@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200602110216.GA3354422@ulmo>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue 02 Jun 04:02 PDT 2020, Thierry Reding wrote:

> On Wed, May 27, 2020 at 12:03:44PM +0100, Will Deacon wrote:
> > Hi John, Bjorn,
> > 
> > On Tue, May 26, 2020 at 01:34:45PM -0700, John Stultz wrote:
> > > On Thu, May 14, 2020 at 12:34 PM <bjorn.andersson@linaro.org> wrote:
> > > >
> > > > On Thu 27 Feb 18:57 PST 2020, Bjorn Andersson wrote:
> > > >
> > > > Rob, Will, we're reaching the point where upstream has enough
> > > > functionality that this is becoming a critical issue for us.
> > > >
> > > > E.g. Lenovo Yoga C630 is lacking this and a single dts patch to boot
> > > > mainline with display, GPU, WiFi and audio working and the story is
> > > > similar on several devboards.
> > > >
> > > > As previously described, the only thing I want is the stream mapping
> > > > related to the display controller in place, either with the CB with
> > > > translation disabled or possibly with a way to specify the framebuffer
> > > > region (although this turns out to mess things up in the display
> > > > driver...)
> > > >
> > > > I did pick this up again recently and concluded that by omitting the
> > > > streams for the USB controllers causes an instability issue seen on one
> > > > of the controller to disappear. So I would prefer if we somehow could
> > > > have a mechanism to only pick the display streams and the context
> > > > allocation for this.
> > > >
> > > >
> > > > Can you please share some pointers/insights/wishes for how we can
> > > > conclude on this subject?
> > > 
> > > Ping? I just wanted to follow up on this discussion as this small
> > > series is crucial for booting mainline on the Dragonboard 845c
> > > devboard. It would be really valuable to be able to get some solution
> > > upstream so we can test mainline w/o adding additional patches.
> > 
> > Sorry, it's been insanely busy recently and I haven't had a chance to think
> > about this on top of everything else. We're also carrying a hack in Android
> > for you :)
> > 
> > > The rest of the db845c series has been moving forward smoothly, but
> > > this set seems to be very stuck with no visible progress since Dec.
> > > 
> > > Are there any pointers for what folks would prefer to see?
> > 
> > I've had a chat with Robin about this. Originally, I was hoping that
> > people would all work together towards an idyllic future where firmware
> > would be able to describe arbitrary pre-existing mappings for devices,
> > irrespective of the IOMMU through which they master and Linux could
> > inherit this configuration. However, that hasn't materialised (there was
> > supposed to be an IORT update, but I don't know what happened to that)
> > and, in actual fact, the problem that you have on db845 is /far/ more
> > restricted than the general problem.
> 
> It doesn't sound to me like implementing platform-specific workarounds
> is a good long-term solution (especially since, according to Bjorn, they
> aren't as trivial to implement as it sounds). And we already have all
> the infrastructure in place to implement what you describe, so I don't
> see why we shouldn't do that. This patchset uses standard device tree
> bindings that were designed for exactly this kind of use-case.
> 

I think my results would imply that we would have to end up with (at
least) some special case of your proposal (i.e. we need a context bank
allocated).

> So at least for device-tree based boot firmware can already describe
> these pre-existing mappings. If something standard materializes for ACPI
> eventually I'm sure we can find ways to integrate that into whatever we
> come up with now for DT.
> 
> I think between Bjorn, John, Laurentiu and myself there's pretty broad
> consensus (correct me if I'm wrong, guys) that solving this via reserved
> memory regions is a good solution that works. So I think what's really
> missing is feedback on whether the changes proposed here or Laurentiu's
> updated proposal[0] are acceptable, and if not, what the preference is
> for getting something equivalent upstream.
> 

As described in my reply to your proposal, the one problem I ran into
was that I haven't figured out how to reliably "move" my display streams
from one mapping entry to another.

With the current scheme I see that their will either be gaps in time
with no mapping for my display, or multiple mappings.


The other thing I noticed in your proposal was that I have a whole bunch
of DT nodes with both iommus and memory-region properties that I really
don't care to set up mappings for, but I've not finalized my thoughts on
this causing actual problems...

> Just to highlight: the IOMMU framework already provides infrastructure
> to create direct mappings (via iommu_get_resv_regions(), called from
> iommu_create_device_direct_mappings()). I have patches that make use of
> this on Tegra210 and earlier where a non-ARM SMMU is used and where the
> IOMMU driver enables translations (and doesn't fault by default) only at
> device attachment time. That works perfectly using reserved-memory
> regions. Perhaps that infrastructure could be extended to cover the
> kinds of early mappings that we're discussing here. On the other hand it
> might be a bit premature at this point because the ARM SMMU is the only
> device that currently needs this, as far as I can tell.
> 

For Qualcomm we got patches picked up for 5.8 that will cause the
display controller to be attached with direct mapping, so I think all
missing now is the lack of stream mappings between arm-smmu probe and
display driver probe...

Regards,
Bjorn

> Thierry
> 
> [0]: https://patchwork.ozlabs.org/project/linux-tegra/list/?series=164853
> 
> > Could you please try hacking something along the following lines and see
> > how you get on? You may need my for-joerg/arm-smmu/updates branch for
> > all the pieces:
> > 
> >   1. Use the ->cfg_probe() callback to reserve the SMR/S2CRs you need
> >      "pinning" and configure for bypass.
> > 
> >   2. Use the ->def_domain_type() callback to return IOMMU_DOMAIN_IDENTITY
> >      for the display controller
> > 
> > I /think/ that's sufficient, but note that it differs from the current
> > approach because we don't end up reserving a CB -- bypass is configured
> > in the S2CR instead. Some invalidation might therefore be needed in
> > ->cfg_probe() after unhooking the CB.
> > 
> > Thanks, and please yell if you run into problems with this approach.
> > 
> > Will


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
