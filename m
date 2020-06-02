Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A463C433E1
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 06:32:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A32206A2
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 06:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUDscq8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A32206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 07871875C7;
	Tue,  2 Jun 2020 06:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xx7H4AiozMJL; Tue,  2 Jun 2020 06:32:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3804A87117;
	Tue,  2 Jun 2020 06:32:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2AFDC0178;
	Tue,  2 Jun 2020 06:32:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56072C0176
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 06:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4261C871E0
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 06:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jCugxDgezwS1 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 06:32:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 62B4E87117
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 06:32:14 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id y18so948173plr.4
 for <iommu@lists.linux-foundation.org>; Mon, 01 Jun 2020 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b+M/coCkFNl7rEB1+V9a1SGv0MbqkwxWHT5JS/FD5kU=;
 b=KUDscq8WItKoh9ZYSx8jWuci35Nw048l0iXzgRVyQNROloiXf5EDGPMxaYe40ytsfc
 7tzL55dftrs+QMwkqTdiodq2N8ZWMmLGst4MFycYH/KwplJZf7c1hurZa2MrQVPYUm9Z
 0u0j0yJqrH/+bHMnGrM4KLjgs4VZxEJLD3+q8rbI9pKCvgLMWyyP6HJnYpWnroAJVTOv
 caH7/VDudXhENr5UEvSEpFioSFfzRuyXUSN0a8UmQdYPFHFBFZ6DyWsi1G125N8sJhSL
 3NopBKEm9MvPaBjxc4O8AdWAxCzTs5dU1BSHm/v6l5A94OOISy6xU8k+9nvxuBQKd5MB
 L92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b+M/coCkFNl7rEB1+V9a1SGv0MbqkwxWHT5JS/FD5kU=;
 b=Z49LjYW7LGK2BMySQHFgpDaaCO1ssDOdrpM0Q/TVhA9HEK8m1fIOxsLX2o48VeKatU
 CczwPIPB2xdc0SdHDvYLvBE8EllnPv5dEHweDw5kk3QM8/y+Xyrud5fxjjV5C/C1PsSD
 rFmlcHVj1/t4DbbGbx3VWLQVLVNIqAMW2hH4p/XR98Y3KGWdcJjYhJDezyGeQMJHNtsA
 lfvi4HHh129YMCbuGENxe2hNcxED4promcl+PqWDHFUqCmSAQREGEpD9qMArh86AYrQf
 nWigr6Ahua1Y8c0sRx+807SE6/YP5CiM1k8v997t5ZiBm4fbV851sgX3ttThUx/D8BvI
 Vf3A==
X-Gm-Message-State: AOAM531RfR8rYlOTlqipj8YLk9Qqr9fsfv8R8HFCDIWhLHWMhkZ5afUD
 7Zy0HBE0lcKFzDCO37+1liyyCw==
X-Google-Smtp-Source: ABdhPJy5cUvakA8S6grGUMTST0kl4+hlBnKMXzZSlSFWY+9TVWtjdijoQ9DEyc9FF+kCM3nqIrBYGQ==
X-Received: by 2002:a17:90a:ee82:: with SMTP id i2mr731084pjz.29.1591079533656; 
 Mon, 01 Jun 2020 23:32:13 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id k14sm1228630pgn.94.2020.06.01.23.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 23:32:12 -0700 (PDT)
Date: Mon, 1 Jun 2020 23:32:10 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200602063210.GT11847@yoga>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder>
 <20200514193249.GE279327@builder.lan>
 <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
 <20200527110343.GD11111@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200527110343.GD11111@willie-the-truck>
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

On Wed 27 May 04:03 PDT 2020, Will Deacon wrote:

> Hi John, Bjorn,
> 
> On Tue, May 26, 2020 at 01:34:45PM -0700, John Stultz wrote:
> > On Thu, May 14, 2020 at 12:34 PM <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Thu 27 Feb 18:57 PST 2020, Bjorn Andersson wrote:
> > >
> > > Rob, Will, we're reaching the point where upstream has enough
> > > functionality that this is becoming a critical issue for us.
> > >
> > > E.g. Lenovo Yoga C630 is lacking this and a single dts patch to boot
> > > mainline with display, GPU, WiFi and audio working and the story is
> > > similar on several devboards.
> > >
> > > As previously described, the only thing I want is the stream mapping
> > > related to the display controller in place, either with the CB with
> > > translation disabled or possibly with a way to specify the framebuffer
> > > region (although this turns out to mess things up in the display
> > > driver...)
> > >
> > > I did pick this up again recently and concluded that by omitting the
> > > streams for the USB controllers causes an instability issue seen on one
> > > of the controller to disappear. So I would prefer if we somehow could
> > > have a mechanism to only pick the display streams and the context
> > > allocation for this.
> > >
> > >
> > > Can you please share some pointers/insights/wishes for how we can
> > > conclude on this subject?
> > 
> > Ping? I just wanted to follow up on this discussion as this small
> > series is crucial for booting mainline on the Dragonboard 845c
> > devboard. It would be really valuable to be able to get some solution
> > upstream so we can test mainline w/o adding additional patches.
> 
> Sorry, it's been insanely busy recently and I haven't had a chance to think
> about this on top of everything else. We're also carrying a hack in Android
> for you :)
> 

Thanks for taking the time to get back to us on this!

> > The rest of the db845c series has been moving forward smoothly, but
> > this set seems to be very stuck with no visible progress since Dec.
> > 
> > Are there any pointers for what folks would prefer to see?
> 
> I've had a chat with Robin about this. Originally, I was hoping that
> people would all work together towards an idyllic future where firmware
> would be able to describe arbitrary pre-existing mappings for devices,
> irrespective of the IOMMU through which they master and Linux could
> inherit this configuration. However, that hasn't materialised (there was
> supposed to be an IORT update, but I don't know what happened to that)
> and, in actual fact, the problem that you have on db845 is /far/ more
> restricted than the general problem.
> 
> Could you please try hacking something along the following lines and see
> how you get on? You may need my for-joerg/arm-smmu/updates branch for
> all the pieces:
> 
>   1. Use the ->cfg_probe() callback to reserve the SMR/S2CRs you need
>      "pinning" and configure for bypass.
> 
>   2. Use the ->def_domain_type() callback to return IOMMU_DOMAIN_IDENTITY
>      for the display controller
> 
> I /think/ that's sufficient, but note that it differs from the current
> approach because we don't end up reserving a CB -- bypass is configured
> in the S2CR instead. Some invalidation might therefore be needed in
> ->cfg_probe() after unhooking the CB.
> 
> Thanks, and please yell if you run into problems with this approach.
> 

This sounded straight forward and cleaner, so I implemented it...

Unfortunately the hypervisor is playing tricks on me when writing to
S2CR registers:
- TRANS writes lands as requested
- BYPASS writes ends up in the register as requested, with type FAULT
- FAULT writes are ignored

In other words, the Qualcomm firmware prevents us from relying on
marking the relevant streams as BYPASS type.


Instead Qualcomm seems to implement "bypass" by setting up stream
mapping, of TRANS type, pointing to a context bank without
ARM_SMMU_SCTLR_M set.

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
