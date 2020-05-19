Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BDBC433E2
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 15:11:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4012081A
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 15:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G66bJ6dC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4012081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5A19A867E5;
	Tue, 19 May 2020 15:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1abJ379TY5yE; Tue, 19 May 2020 15:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6149C8651A;
	Tue, 19 May 2020 15:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3646DC07FF;
	Tue, 19 May 2020 15:11:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F044C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 15:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6AADC8651A
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 15:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vxbDB7A924Rd for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 15:11:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 03F6B864C3
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 15:11:45 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id l21so12213195eji.4
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qFmnDDUmU7bAXUCXAiIOCZYqhy9KJ7cJu0vEwn4yYb0=;
 b=G66bJ6dC8bOeKCV1WGYuwjLa+qKy7Y0+n3uWze8Gn1ZAszBOTqKWQ62WTUjzafwL9U
 +GTPdcyHtNf5XKqMcGlQmJUpD97lSXKgCjwnFB4vjmiLtm75QmbmYTM3DtiB9XBAXubk
 8oSegy8cxFNV3j8wgjPmI1EI4FQZ05wphJXLMEfxZ7N/L87ptMxbQDNAdetxkOFNUMkL
 HpE+J0BbniB9iXMsBbBOr2cxGGu68R8o5msor4h3OyP4WEVKPSwrF4l3Kxol9Kvm0vUG
 oiXtOGlLJLyzkc5iFPnvHSCYntlakDIurYnTYtiSq9/gpPVc72+0QTJLIip+97mGYOYs
 4eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qFmnDDUmU7bAXUCXAiIOCZYqhy9KJ7cJu0vEwn4yYb0=;
 b=G1twPDCwov2cPm68LKsCH5hhIpbrYVNqQ1lNqeC0macKSIXlncdDq+2V26O+IE54eD
 kJLrDzWtRCAwXxx21tu/EZ10Xtq7nCQUe7gqDGmbM5c6Q1ND9CJq5aTjM4OOQVpKTjMS
 YraOpB9rphChFDbKQT5d8JgEbxSk6BQqAxze6jh5Qwk2O8SbFgG8Uqk6nsOCM54yzIpm
 3zQ8jj7XqgqRK+0efne2bFGmhLI9PHzd2Gj8Jy61BbHMOYFdNOgpIwygUtnHhBsa1mZr
 zstOXnKn69hEwdPdsXoIGZA4Vkz5ZDoGjA2UEnFj9RSKZiY/axmelTsYnwXIjfU0pwOK
 sIEg==
X-Gm-Message-State: AOAM532tUJ+Omekwsn42gJUz8oJuAKIGP7mMyAhEbn/5/XCpT1J7wPnb
 scNG/J+rsw1tVIL3sQyHnlD0hUn1maya3wK2CXA=
X-Google-Smtp-Source: ABdhPJzO3neINwRRzJbIjXOIJwQTkTwZpvqUbx/rpVcTcaX7VHke7n+JUXqMuZyVp2d+kaG3FsnjsThgVhsZPoFWTDE=
X-Received: by 2002:a17:906:1088:: with SMTP id
 u8mr1110995eju.428.1589901102998; 
 Tue, 19 May 2020 08:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
 <b491e02ad790a437115fdeab6b21bc48@codeaurora.org>
 <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
 <20200507125357.GA31783@willie-the-truck>
 <CAF6AEGuLU+_qP8HNO1s9PTPHqJnCMHzehmcT8NiJhiAwrfSH6w@mail.gmail.com>
 <CAF6AEGvuHKObTR97XdSXjmjKB+qjQ8N1_wxM=ZU8bEkF=cXp-A@mail.gmail.com>
 <20200511173008.GA24282@jcrouse1-lnx.qualcomm.com>
 <20200518154522.GN32394@willie-the-truck>
 <5a0ad639e272026c8be57393937cda22@codeaurora.org>
In-Reply-To: <5a0ad639e272026c8be57393937cda22@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 19 May 2020 08:11:59 -0700
Message-ID: <CAF6AEGuzBtj+srindmOvhaom5BdS2adLaOF=v_MtguMja14V2w@mail.gmail.com>
Subject: Re: [PATCH] iomm/arm-smmu: Add stall implementation hook
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>,
 " <iommu@lists.linux-foundation.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Tue, May 19, 2020 at 2:26 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Will,
>
> On 2020-05-18 21:15, Will Deacon wrote:
> > On Mon, May 11, 2020 at 11:30:08AM -0600, Jordan Crouse wrote:
> >> On Fri, May 08, 2020 at 08:40:40AM -0700, Rob Clark wrote:
> >> > On Fri, May 8, 2020 at 8:32 AM Rob Clark <robdclark@gmail.com> wrote:
> >> > >
> >> > > On Thu, May 7, 2020 at 5:54 AM Will Deacon <will@kernel.org> wrote:
> >> > > >
> >> > > > On Thu, May 07, 2020 at 11:55:54AM +0100, Robin Murphy wrote:
> >> > > > > On 2020-05-07 11:14 am, Sai Prakash Ranjan wrote:
> >> > > > > > On 2020-04-22 01:50, Sai Prakash Ranjan wrote:
> >> > > > > > > Add stall implementation hook to enable stalling
> >> > > > > > > faults on QCOM platforms which supports it without
> >> > > > > > > causing any kind of hardware mishaps. Without this
> >> > > > > > > on QCOM platforms, GPU faults can cause unrelated
> >> > > > > > > GPU memory accesses to return zeroes. This has the
> >> > > > > > > unfortunate result of command-stream reads from CP
> >> > > > > > > getting invalid data, causing a cascade of fail.
> >> > > > >
> >> > > > > I think this came up before, but something about this rationale doesn't add
> >> > > > > up - we're not *using* stalls at all, we're still terminating faulting
> >> > > > > transactions unconditionally; we're just using CFCFG to terminate them with
> >> > > > > a slight delay, rather than immediately. It's really not clear how or why
> >> > > > > that makes a difference. Is it a GPU bug? Or an SMMU bug? Is this reliable
> >> > > > > (or even a documented workaround for something), or might things start
> >> > > > > blowing up again if any other behaviour subtly changes? I'm not dead set
> >> > > > > against adding this, but I'd *really* like to have a lot more confidence in
> >> > > > > it.
> >> > > >
> >> > > > Rob mentioned something about the "bus returning zeroes" before, but I agree
> >> > > > that we need more information so that we can reason about this and maintain
> >> > > > the code as the driver continues to change. That needs to be a comment in
> >> > > > the driver, and I don't think "but android seems to work" is a good enough
> >> > > > justification. There was some interaction with HUPCF as well.
> >> > >
> >> > > The issue is that there are multiple parallel memory accesses
> >> > > happening at the same time, for example CP (the cmdstream processor)
> >> > > will be reading ahead and setting things up for the next draw or
> >> > > compute grid, in parallel with some memory accesses from the shader
> >> > > which could trigger a fault.  (And with faults triggered by something
> >> > > in the shader, there are *many* shader threads running in parallel so
> >> > > those tend to generate a big number of faults at the same time.)
> >> > >
> >> > > We need either CFCFG or HUPCF, otherwise what I have observed is that
> >> > > while the fault happens, CP's memory access will start returning
> >> > > zero's instead of valid cmdstream data, which triggers a GPU hang.  I
> >> > > can't say whether this is something unique to qcom's implementation of
> >> > > the smmu spec or not.
> >> > >
> >> > > *Often* a fault is the result of the usermode gl/vk/cl driver bug,
> >> > > although I don't think that is an argument against fixing this in the
> >> > > smmu driver.. I've been carrying around a local patch to set HUPCF for
> >> > > *years* because debugging usermode driver issues is so much harder
> >> > > without.  But there are some APIs where faults can be caused by the
> >> > > user's app on top of the usermode driver.
> >> > >
> >> >
> >> > Also, I'll add to that, a big wish of mine is to have stall with the
> >> > ability to resume later from a wq context.  That would enable me to
> >> > hook in the gpu crash dump handling for faults, which would make
> >> > debugging these sorts of issues much easier.  I think I posted a
> >> > prototype of this quite some time back, which would schedule a worker
> >> > on the first fault (since there are cases where you see 1000's of
> >> > faults at once), which grabbed some information about the currently
> >> > executing submit and some gpu registers to indicate *where* in the
> >> > submit (a single submit could have 100's or 1000's of draws), and then
> >> > resumed the iommu cb.
> >> >
> >> > (This would ofc eventually be useful for svm type things.. I expect
> >> > we'll eventually care about that too.)
> >>
> >> Rob is right about HUPCF. Due to the parallel nature of the command
> >> processor
> >> there is always a very good chance that a CP access is somewhere in
> >> the bus so
> >> any pagefault is usually a death sentence. The GPU context bank would
> >> always
> >> want HUPCF set to 1.
> >
> > So this sounds like an erratum to me, and I'm happy to set HUPCF if we
> > detect the broken implementation. However, it will need an entry in
> > Documentation/arm64/silicon-errata.rst and a decent comment in the
> > driver
> > to explain what we're doing and why.
> >
>
> AFAIK there is no erratum documented internally for this behaviour and
> this
> exists from MSM8996 SoC time and errata usually don't survive this long
> across generation of SoCs and there is no point for us in disguising it.

possibly longer, qcom_iommu sets CFCFG..

> Is it OK if we clearly mention it as the "design limitation" or some
> other
> term which we can agree upon along with the description which Rob and
> Jordan
> provided for setting HUPCF in the driver when we add the set_hupcf
> callback?

I'm not too picky on what we call it, but afaict it has been this way
since the beginning of time, rather than specific to a certain SoC or
generation of SoCs.  So it doesn't seem like the hw designers consider
it a bug.

(I'm not sure what the expected behavior is.. nor if any other SMMU
implementation encounters this sort of situation..)

BR,
-R

>
> Thanks,
> Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member
> of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
