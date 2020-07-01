Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2BDC433E0
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 08:13:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A11F206A1
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 08:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLKbZZQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A11F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B49E58C3B6;
	Wed,  1 Jul 2020 08:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B2RUqA8kOyE2; Wed,  1 Jul 2020 08:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF0CE87D60;
	Wed,  1 Jul 2020 08:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3169C0865;
	Wed,  1 Jul 2020 08:13:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63C7BC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 08:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 531108C39F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 08:13:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id icHhnieX4-sa for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 08:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com
 [209.85.221.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3780887D60
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 08:13:10 +0000 (UTC)
Received: by mail-vk1-f193.google.com with SMTP id c11so162719vkn.11
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jul 2020 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mMc4j54dN6DGlrcAqYRepJM/zjg8dpWwhkXIc71CpRM=;
 b=pLKbZZQz699m9ep5n7JNbNAW4iGjn2GzhIMO1VK8z6xG7jJZllkF9eJQxZvqQakG+r
 cCvgzmQKi/fxXwLUEdpmpejSjMhUUICNjC/7HeBymyCTd7XOTB2BjQA5sUy5z8/Axb3P
 +66uKaLYAMCpL+/uPEEQpxqBngQCJ/p7fYumOT0oj4XzuUIIVkhtycpIInKz6c/yR9XD
 dzqT6OpazBf171fl16G0U02U9b4oMTQE8i3BvOVdYq3zAl0pSsouU8kYG8KdQ7+VZKxw
 k+nLQMyo4LLaiQsKdxK2TLGqSm2ZPtP1R9JH93n8ROP10RGmsHqj/c/b7g03l9oAcYiK
 ZXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mMc4j54dN6DGlrcAqYRepJM/zjg8dpWwhkXIc71CpRM=;
 b=WlL5NcyZ5PCbGzo9HO4kfCE2t2raR9eQYolSk4W1ja2Ok0icH4sy2sOijvEod1gGJ+
 tPulg814gSM4C/sMhuZ23fw6jBcZxfUQaUVD0uf6M8KL1wTec2GPkAqUlEU120HSGVgN
 QKxp9IEhFbp/8CRxxqVCSRxh6xulkwmrLvnklC4N+r/YxynHd/y0TvY//Mfi6A8F3T3A
 rCl5KHoGx4f8M3sWm1Dh5bqDZ6Wa83WnITHrGVlygmj3McmaTXYx8rBYRjfXmtOxvYuu
 pHy4syoKSbeJhiDwk8Ndv5NECttmDdBAAAkz19k4AMwmmOMvGREMVlN8UETGwMW1gxIL
 Ye0A==
X-Gm-Message-State: AOAM530ziO1Rj3Beb9ICadjePj2DBHH3jIuD4WblFLBCaooSOERTZ+ts
 5crGv+ijDXBRvRQzKM0mfOZeX7ISEzk=
X-Google-Smtp-Source: ABdhPJyg3Qti0THsh6aqjIZZdBzHaPEk786n7W2tpFF3WMt35frdw7VtGVYf8BCKUT6IxdM9ULX4SQ==
X-Received: by 2002:a17:902:8c8a:: with SMTP id
 t10mr18544088plo.153.1593589401062; 
 Wed, 01 Jul 2020 00:43:21 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 25sm4804965pfi.7.2020.07.01.00.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 00:43:20 -0700 (PDT)
Date: Wed, 1 Jul 2020 00:40:50 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>, Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200701074050.GO388985@builder.lan>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder>
 <20200514193249.GE279327@builder.lan>
 <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
 <20200527110343.GD11111@willie-the-truck>
 <20200602063210.GT11847@yoga>
 <a1f9ee83-66cd-1f04-3e78-3281b3cafd07@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1f9ee83-66cd-1f04-3e78-3281b3cafd07@arm.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
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

On Wed 03 Jun 04:00 PDT 2020, Robin Murphy wrote:

> On 2020-06-02 07:32, Bjorn Andersson wrote:
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
> > >    1. Use the ->cfg_probe() callback to reserve the SMR/S2CRs you need
> > >       "pinning" and configure for bypass.
> > > 
> > >    2. Use the ->def_domain_type() callback to return IOMMU_DOMAIN_IDENTITY
> > >       for the display controller
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
> Sigh...

I agree.

> at that point I'm inclined to suggest we give up and stop trying to
> drive these things with arm-smmu. The XZR thing was bad enough, but if
> they're not even going to pretend to implement the architecture correctly
> then I'm not massively keen to continue tying the architectural driver in
> further knots if innocent things like CONFIG_IOMMU_DEFAULT_PASSTHROUGH are
> going to unexpectedly and catastrophically fail. We have qcom-iommu for
> hypervisor-mediated SMMUs, and this new hypervisor behaviour sounds to me
> more like "qcom-iommu++" with reassignable stream-to-context mappings,
> rather than a proper Arm SMMU emulation.
> 

I've been going through over and over, hoping to perhaps be able to
evolve qcom_iommu into a qcom-iommu++, but afaict the new hypervisor is
different enough that this isn't feasible. In particular, the platforms
using qcom_iommu relies entirely on the hypervisor to configure stream
mapping etc - and we can't even read most of the registers.

On the other hand I agree with you that we're messing around quite a bit
with the arm-smmu driver, and I'm uncertain where we are on supporting
the various GPU features, so I'm adding Jordan to the thread.

So, afaict we have the options of either shoehorning this too into the
arm-smmu driver or we essentially fork arm-smmu.c to create a
qcom-smmu.c.

While I don't fancy the code duplication, it would allow us to revert
the Qualcomm quirks from arm-smmu and would unblock a number of
activities that we have depending on getting the SMMU enabled on various
platforms.


NB. As mentioned briefly before, "this" means: for a given compatible,
search SMR for a specific stream mapping and ensure it remains after
initialization and make sure the associated context bank is "allocated".

> > Instead Qualcomm seems to implement "bypass" by setting up stream
> > mapping, of TRANS type, pointing to a context bank without
> > ARM_SMMU_SCTLR_M set.
> 
> ...which arm-smmu specifically does not do because it's a silly waste of
> resources - typically context banks are even scarcer than S2CRs.
> 

Agreed.

Thanks,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
