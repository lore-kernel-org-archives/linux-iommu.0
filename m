Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F55C433DF
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 17:23:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5869A20679
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 17:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNO9sJQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5869A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D60E685BC2;
	Wed,  3 Jun 2020 17:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50gr8ZAJG49G; Wed,  3 Jun 2020 17:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C55F086BB3;
	Wed,  3 Jun 2020 17:23:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B79CEC0888;
	Wed,  3 Jun 2020 17:23:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE110C016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 17:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B9ABD87D86
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 17:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zRVGmyaHFplw for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 17:23:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 071C887D81
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 17:23:22 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id o6so2222896pgh.2
 for <iommu@lists.linux-foundation.org>; Wed, 03 Jun 2020 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3ar3esfA/vt48SBclsM8WJOD1g7kG4QWgmN6yHU/oXc=;
 b=tNO9sJQ61o9UyfrhBb16ZezG7kOCbgIYdGMnrrumT9Vk/c2n/h/s+PdRpzJbFe8FYO
 yeudGjKQZ0Pt1ICeNO6VcYJ6HjF/icPSuk1BuGZ4bH81kkEfIl/ZxByLmoGxLyCKrRFm
 CJQOubP39NApW2ReGmIXspA3q3P+0DvsyPH4488eYYXQrgcihobQVr7F2xydvRMhgc3m
 Sm4C4d2gcq2qEYqHdEZN9NoysyOvYSqiL6EXV+myDnpzY74kA6JYPfBm3qsqVuyiZWwR
 6GfEnxHpL5HlA5n+IFWn4+eIHxMiZ0XstV7KGsJiw6xOdlWck+YVpE9IQLD+F9s1wVmC
 6GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3ar3esfA/vt48SBclsM8WJOD1g7kG4QWgmN6yHU/oXc=;
 b=k1uf5JUEXPrdIS7PhIOxktvewyFDMOGd3LJyZCAa/SEVpU+spMd5qACTwHG0uBGyys
 JQA62XhmYr1iCdiJoP+GqXuuFUzCurF+zfddUcrn/5ymMVFfkt9UizZ6yOToK+TE0xCh
 kKZq6kTL3jtGeXZlkd2rr/2S2U3wAY5o9iqJim5lwQwDOVXUlssTZEIl4nt3/gSrRh/L
 teOQIkS39yAZd45wgVQ1W6qFCObZ07cAVHMtHHeOB1w+2JB2FNH2NE+cPFcyqXxKTXZV
 deqs5sl+vtEYwvA3yOh90KeiBDOX+L7pCqotHkIE8/sie9fsHbi/vdy92GTHNZmud1Am
 5EGw==
X-Gm-Message-State: AOAM530frTOX3bBIhUVxJS3/UI9niNjjy2FOPGCSJdJ1u062ubawkz4k
 ZYg2APYcnsfN1cf3EPfNFVoUhA==
X-Google-Smtp-Source: ABdhPJxy8Q5HTd5Gs4lSKz3+cPkTGrkqopHgfHUy1PStfA94XjybI5ykp5i4gqE6gRIaSm04U9EfmQ==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr445454pgp.146.1591205001388;
 Wed, 03 Jun 2020 10:23:21 -0700 (PDT)
Received: from yoga ([2607:fb90:84f0:6dc6:b843:e3ff:fe62:cb58])
 by smtp.gmail.com with ESMTPSA id y187sm2358942pfb.46.2020.06.03.10.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 10:23:20 -0700 (PDT)
Date: Wed, 3 Jun 2020 10:23:16 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200603172316.GW11847@yoga>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder>
 <20200514193249.GE279327@builder.lan>
 <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
 <20200527110343.GD11111@willie-the-truck>
 <20200602063210.GT11847@yoga>
 <20200603111159.GA8408@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200603111159.GA8408@willie-the-truck>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 John Stultz <john.stultz@linaro.org>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
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

On Wed 03 Jun 04:11 PDT 2020, Will Deacon wrote:

> On Mon, Jun 01, 2020 at 11:32:10PM -0700, Bjorn Andersson wrote:
> > On Wed 27 May 04:03 PDT 2020, Will Deacon wrote:
> > 
> > > Hi John, Bjorn,
> > > 
> > > On Tue, May 26, 2020 at 01:34:45PM -0700, John Stultz wrote:
> > > > On Thu, May 14, 2020 at 12:34 PM <bjorn.andersson@linaro.org> wrote:
> > > > >
> > > > > On Thu 27 Feb 18:57 PST 2020, Bjorn Andersson wrote:
> > > > >
> > > > > Rob, Will, we're reaching the point where upstream has enough
> > > > > functionality that this is becoming a critical issue for us.
> > > > >
> > > > > E.g. Lenovo Yoga C630 is lacking this and a single dts patch to boot
> > > > > mainline with display, GPU, WiFi and audio working and the story is
> > > > > similar on several devboards.
> > > > >
> > > > > As previously described, the only thing I want is the stream mapping
> > > > > related to the display controller in place, either with the CB with
> > > > > translation disabled or possibly with a way to specify the framebuffer
> > > > > region (although this turns out to mess things up in the display
> > > > > driver...)
> > > > >
> > > > > I did pick this up again recently and concluded that by omitting the
> > > > > streams for the USB controllers causes an instability issue seen on one
> > > > > of the controller to disappear. So I would prefer if we somehow could
> > > > > have a mechanism to only pick the display streams and the context
> > > > > allocation for this.
> > > > >
> > > > >
> > > > > Can you please share some pointers/insights/wishes for how we can
> > > > > conclude on this subject?
> > > > 
> > > > Ping? I just wanted to follow up on this discussion as this small
> > > > series is crucial for booting mainline on the Dragonboard 845c
> > > > devboard. It would be really valuable to be able to get some solution
> > > > upstream so we can test mainline w/o adding additional patches.
> > > 
> > > Sorry, it's been insanely busy recently and I haven't had a chance to think
> > > about this on top of everything else. We're also carrying a hack in Android
> > > for you :)
> > > 
> > 
> > Thanks for taking the time to get back to us on this!
> > 
> > > > The rest of the db845c series has been moving forward smoothly, but
> > > > this set seems to be very stuck with no visible progress since Dec.
> > > > 
> > > > Are there any pointers for what folks would prefer to see?
> > > 
> > > I've had a chat with Robin about this. Originally, I was hoping that
> > > people would all work together towards an idyllic future where firmware
> > > would be able to describe arbitrary pre-existing mappings for devices,
> > > irrespective of the IOMMU through which they master and Linux could
> > > inherit this configuration. However, that hasn't materialised (there was
> > > supposed to be an IORT update, but I don't know what happened to that)
> > > and, in actual fact, the problem that you have on db845 is /far/ more
> > > restricted than the general problem.
> > > 
> > > Could you please try hacking something along the following lines and see
> > > how you get on? You may need my for-joerg/arm-smmu/updates branch for
> > > all the pieces:
> > > 
> > >   1. Use the ->cfg_probe() callback to reserve the SMR/S2CRs you need
> > >      "pinning" and configure for bypass.
> > > 
> > >   2. Use the ->def_domain_type() callback to return IOMMU_DOMAIN_IDENTITY
> > >      for the display controller
> > > 
> > > I /think/ that's sufficient, but note that it differs from the current
> > > approach because we don't end up reserving a CB -- bypass is configured
> > > in the S2CR instead. Some invalidation might therefore be needed in
> > > ->cfg_probe() after unhooking the CB.
> > > 
> > > Thanks, and please yell if you run into problems with this approach.
> > > 
> > 
> > This sounded straight forward and cleaner, so I implemented it...
> > 
> > Unfortunately the hypervisor is playing tricks on me when writing to
> > S2CR registers:
> > - TRANS writes lands as requested
> > - BYPASS writes ends up in the register as requested, with type FAULT
> > - FAULT writes are ignored
> > 
> > In other words, the Qualcomm firmware prevents us from relying on
> > marking the relevant streams as BYPASS type.
> 
> Is this for all S2CR registers, or only the ones in use by the display
> controller? Is there any scope for stopping the hypervisor from doing this?
> 

This is for all S2CR registers. There's no chance to change this and get
it deployed on all the devices people care about.

As you know John need this for the RB3/db845c, where we might have a
chance to modify the firmware.

But I'm writing this on my Lenovo Yoga C630 and John and his colleagues
are working on various phones, such as Pixel 3. None of these boots
without this "workaround" and I don't expect that we can propagate a
firmware modification to any of them - and definitely not all of them.

> It makes it really difficult for the driver when the hardware is emulated
> in a way that doesn't match the architecture...
> 

Understood.

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
