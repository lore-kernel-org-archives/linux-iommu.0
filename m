Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E20C282E1
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 18:39:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F8D21873
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 18:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTOtH5sH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F8D21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C79B2109B;
	Fri, 24 May 2019 18:39:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6A99A1097
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 18:39:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 74EAC81A
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 18:39:04 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id l25so15589427eda.9
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+zWh+e2JBmSZjNxmHFCEsBAIMZEj3CfViqQesJhg4Ew=;
	b=CTOtH5sH91k5oEblppyj2vdbuh9y9ChOJPokmxaW0k6iTVIM1Pij22UGRVBgXTMvDA
	NmJvUumCc4rqDN0MZ1BJQ7kcaYPRkP3tkS0ESt1DltSl/8MBQfQcCfbi6o/zxI/nqeC9
	CDF8JCiH9Z9qHEvy+aB+K27NleoD2JMlp6i8w6q8J42i2qONpTIQklfQkNbfg8vKb9vM
	4YcA0ZHiz6oaQ5p+zjWeMzERFBV33QNTXEHogeFJIFGZMB39ckOYr0aGslZ6zgtDtaAD
	H+uDeOsDDWE2igje7Yp/HaNmel0rqbwsllmtWEDE8AGdVGKZBwTcTU5FnMO6A/blQ55f
	yP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+zWh+e2JBmSZjNxmHFCEsBAIMZEj3CfViqQesJhg4Ew=;
	b=isAzstWBTIhAzKse2GmNu7Mk28iqjW5P4H4H4J/5jzE0zFD6yZ9BF3DK0ZOBlDga6n
	FRRbcne7a5HUstQRhOtd+JpmVlVeXhtEPMh9S4+UIF1FP6s39ybkPwQ/zd1smIDkdxCu
	9coVF2i+b7axzT3etmuCWpWekgwKzCohfMsRaW+wFierI11wcB2hmgtyVJI4Kp2NEsuw
	MrOVx4ayTnWBRzgwt12KEW+PV7boO9F98YOmRuIpRGvs6k9xUbtPaCh22JxOdQ180LdF
	0VrUIkI7UlLPfR1YzyVTb0Mex6vgYx7aQRnGWyGzenRa5J93QNDm1u4LuVVZGY/DbGRu
	rRTA==
X-Gm-Message-State: APjAAAU/RJW391T6PockgCITZfqDAmfLm8MHfNFapOxWUHOmr5Fn0Vi2
	7aTZ6+SADKHMYPxei0f+phecY7wAT+JXy4uQ7wM=
X-Google-Smtp-Source: APXvYqwKSk+tkXqI7m1a/B0AuT5MCsz5lL0eOqG1GRFEo7/oVeuc+C1m4SijaJVC+vBe/rRUNLzKhlRrwBuRlXTIGXs=
X-Received: by 2002:a50:f9cc:: with SMTP id
	a12mr106818668edq.272.1558723142887; 
	Fri, 24 May 2019 11:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180927224609.19515-1-robdclark@gmail.com>
	<20181029191000.GD16739@arm.com>
	<CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com>
	<20181113063225.GA3109@brain-police>
	<CAF6AEGuV2zh97iq+TgkRw0bK3VNSxJieD1N2KMW3N28h07M+0w@mail.gmail.com>
	<20181126193147.GB534@arm.com>
In-Reply-To: <20181126193147.GB534@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 24 May 2019 11:38:49 -0700
Message-ID: <CAF6AEGurwA-+h-dTH9nTBUknZOcw+7w-=_oRtNSrV9ZqjLDZvQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
To: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Nov 26, 2018 at 11:31 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Rob,
>
> On Tue, Nov 13, 2018 at 08:12:35AM -0500, Rob Clark wrote:
> > On Tue, Nov 13, 2018 at 1:32 AM Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Nov 09, 2018 at 01:01:55PM -0500, Rob Clark wrote:
> > > > On Mon, Oct 29, 2018 at 3:09 PM Will Deacon <will.deacon@arm.com> wrote:
> > > > > On Thu, Sep 27, 2018 at 06:46:07PM -0400, Rob Clark wrote:
> > > > > > We seem to need to set either this or CFCFG (stall), otherwise gpu
> > > > > > faults trigger problems with other in-flight transactions from the
> > > > > > GPU causing CP errors, etc.
> > > > > >
> > > > > > In the ARM SMMU spec, the 'Hit under previous context fault' bit is
> > > > > > described as:
> > > > > >
> > > > > >  '0' - Stall or terminate subsequent transactions in the presence
> > > > > >        of an outstanding context fault
> > > > > >  '1' - Process all subsequent transactions independently of any
> > > > > >        outstanding context fault.
> > > > > >
> > > > > > Since we don't enable CFCFG (stall) the behavior of terminating
> > > > > > other transactions makes sense.  And is probably not what we want
> > > > > > (and definately not what we want for GPU).
> > > > > >
> > > > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > > > > ---
> > > > > > So I hit this issue a long time back on 820 (msm8996) and at the
> > > > > > time I solved it with a patch that enabled CFCFG.  And it resurfaced
> > > > > > more recently on sdm845.  But at the time CFCFG was rejected, iirc
> > > > > > because of concern that it would cause problems on other non-qcom
> > > > > > arm smmu implementations.  And I think I forgot to send this version
> > > > > > of the solution.
> > > > > >
> > > > > > If enabling HUPCF is anticipated to cause problems on other ARM
> > > > > > SMMU implementations, I think I can come up with a variant of this
> > > > > > patch which conditionally enables it for snapdragon.
> > > > > >
> > > > > > Either way, I'd really like to get some variant of this fix merged
> > > > > > (and probably it would be a good idea for stable kernel branches
> > > > > > too), since current behaviour with the GPU means faults turn into
> > > > > > a fantastic cascade of fail.
> > > > >
> > > > > Can you describe how this fantastic cascade of fail improves with this
> > > > > patch, please? If you're getting context faults then something has already
> > > > > gone horribly wrong, so I'm trying to work out how this improves things.
> > > > >
> > > >
> > > > There are plenty of cases where getting iommu faults with a GPU is
> > > > "normal", or at least not something the kernel or even GL driver can
> > > > control.
> > >
> > > Such as? All the mainline driver does is print a diagnostic and clear the
> > > fault, which doesn't seem generally useful.
> >
> > it is useful to debug the fault ;-)
> >
> > Although eventually we'll want to be able to do more than that, like
> > have the fault trigger bringing in pages of a mmap'd file and that
> > sort of thing.
>
> Right, and feels very strange to me if we have this bit set because it
> means that your fault is no longer synchronous and therefore diverges
> from the fault model that you get from the CPU, where you certainly
> wouldn't expect stores appearing in the program after a faulting load to
> be visible in memory. However, thinking harder about it, I suppose we're
> already in a situation where the translations are handled out of order
> in the absence of barriers, so maybe it's not the end of the world.
>
> Could you dump the FSR value that you see in the fault handler, please?
> From my reading of the architecture spec, as long as clear all of the
> fault bits in the irq handler, then your machine shouldn't die like it
> does with HUPCFG=CFCFG=0..


Getting back to this after realizing I lost SCTLR.HUPCF patch that I
was carrying locally when rebasing.  Here is an example dump (w/ FSR)
of what happens:



[May24 14:33] arm-smmu 5040000.iommu: Unhandled context fault:
fsr=0x402, iova=0x7ffe35c0, fsynr=0x1, cb=1
[  +0.000034] adreno 5000000.gpu: CP illegal instruction error
[  +0.000036] adreno 5000000.gpu: CP illegal instruction error
[  +0.000017] adreno 5000000.gpu: CP illegal instruction error
[  +0.000017] adreno 5000000.gpu: CP illegal instruction error
[  +0.000015] adreno 5000000.gpu: CP illegal instruction error
[  +0.000016] adreno 5000000.gpu: CP illegal instruction error
[  +0.000076] adreno 5000000.gpu: CP illegal instruction error
[  +0.000015] adreno 5000000.gpu: CP illegal instruction error
[  +0.000016] adreno 5000000.gpu: CP illegal instruction error
[  +0.000015] adreno 5000000.gpu: CP illegal instruction error
[  +0.047100] adreno 5000000.gpu: [drm:a6xx_irq] *ERROR* gpu fault
ring 0 fence 8 status 00800005 rb 0047/0047 ib1 0000000001CC7000/0000
ib2 0000000001CC5000/0000
[  +0.000106] msm ae00000.mdss: [drm:recover_worker] *ERROR* A630:
hangcheck recover!
[  +0.000380] msm ae00000.mdss: [drm:recover_worker] *ERROR* A630:
offending task: d:flush_queue0 (./deqp-gles31 --deqp-visibility=hidden
--deqp-caselist-file=regressions
--deqp-log-filename=results/FD630/regressions.qpa
--deqp-surface-type=fbo --deqp-surface-width=256
--deqp-surface-height=256)
[  +0.501297] adreno 5000000.gpu: [drm:a6xx_irq] *ERROR* gpu fault
ring 0 fence 8 status 00800005 rb 0047/0047 ib1 0000000 ib2
0000/001CC500000
[  +0.051307] revision: 630 (6.3.0.2)
[  +0.000006] rb 0: fence:    6/8
[  +0.000003] rptr:     24
[  +0.000002] rb wptr:  71


The 'CP illegal instruction error's and following gpu fault are the
result of the faulting read from the GPU causing other non-faulting
reads to return zero.


Note that enabling STALL (CFCFG) also avoids this problem.  I suppose
maybe setting CFCFG for implementation==QCOM_SMMUV2 would be a better
idea?

BR,
-R

> > > > With this patch, you still get the iommu fault, but it doesn't cause
> > > > the gpu to crash.  But without it, other memory accesses in flight
> > > > while the fault occurs, like the GPU command-processor reading further
> > > > ahead in the cmdstream to setup next draw, would return zero's,
> > > > causing the GPU to crash or get into a bad state.
> > >
> > > I get that part, but I don't understand why we're seeing faults in the first
> > > place and I worry that this patch is just the tip of the iceberg. It's also
> > > not clear that processing subsequent transactions is always the right thing
> > > to do in a world where we actually want to report (and handle) synchronous
> > > faults from devices.
> >
> > Sure, it is a bug.. but it can be an application bug that is not
> > something the userspace GL driver or kernel could do anything about.
> > We shouldn't let this kill the GPU.  If the application didn't have
> > this much control, we wouldn't need an IOMMU in the first place[1].
> > With opencl compute, the userspace controlled shader has full blown
> > pointers to GPU memory.
> >
> > And even in cases where it is a userspace GL driver bug, having some
> > robustness to not completely kill the GPU makes debugging much easier.
> > Something I do a lot when bringing up support for a new generation of
> > GPU.
> >
> > I'm having a hard time understanding your objection to this.
> > Returning zero's for non-faulting transactions is a *really bad idea*.
>
> Wait -- who said anything about returning zeroes? Where does that behaviour
> appear in the architecture?
>
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
