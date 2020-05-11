Return-Path: <SRS0=Mzfx=6Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDEDC54E8F
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 17:30:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2A82070B
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 17:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="O3vmjNjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2A82070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4D7086DF1;
	Mon, 11 May 2020 17:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tXAqgICCcK9j; Mon, 11 May 2020 17:30:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D2F5A86C22;
	Mon, 11 May 2020 17:30:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4F76C0178;
	Mon, 11 May 2020 17:30:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E861C016F
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 17:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 11BE524BE6
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 17:30:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 66G439yFtefk for <iommu@lists.linux-foundation.org>;
 Mon, 11 May 2020 17:30:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by silver.osuosl.org (Postfix) with ESMTPS id CC2BA230A4
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 17:30:35 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1589218238; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=iPpTo3jNPE0V2FCWqXWCysaJe2BOVw+onhpjhSu1HVU=;
 b=O3vmjNjZKGQ7tOgMRHhEk8wIDX/q+vr16VFzVJT+zX1mMQLrqDjiOxEqsHhNoBcKYMPZWQ5b
 3EHmZ3Q0nEVfyXFn+x+eDepHmsrn/VI9XNzLGG3buVRlV8/dD0UVJZlQN3Z9VgN+QxO89Qax
 lYWvCbMV80HTaRQbgIeDIfKVYLQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb98ba4.7f318b92e7a0-smtp-out-n04;
 Mon, 11 May 2020 17:30:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id DDFEFC433BA; Mon, 11 May 2020 17:30:11 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 33E07C433F2;
 Mon, 11 May 2020 17:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33E07C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 11 May 2020 11:30:08 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iomm/arm-smmu: Add stall implementation hook
Message-ID: <20200511173008.GA24282@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Joerg Roedel <joro@8bytes.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, 
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
 <b491e02ad790a437115fdeab6b21bc48@codeaurora.org>
 <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
 <20200507125357.GA31783@willie-the-truck>
 <CAF6AEGuLU+_qP8HNO1s9PTPHqJnCMHzehmcT8NiJhiAwrfSH6w@mail.gmail.com>
 <CAF6AEGvuHKObTR97XdSXjmjKB+qjQ8N1_wxM=ZU8bEkF=cXp-A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGvuHKObTR97XdSXjmjKB+qjQ8N1_wxM=ZU8bEkF=cXp-A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
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

On Fri, May 08, 2020 at 08:40:40AM -0700, Rob Clark wrote:
> On Fri, May 8, 2020 at 8:32 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Thu, May 7, 2020 at 5:54 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, May 07, 2020 at 11:55:54AM +0100, Robin Murphy wrote:
> > > > On 2020-05-07 11:14 am, Sai Prakash Ranjan wrote:
> > > > > On 2020-04-22 01:50, Sai Prakash Ranjan wrote:
> > > > > > Add stall implementation hook to enable stalling
> > > > > > faults on QCOM platforms which supports it without
> > > > > > causing any kind of hardware mishaps. Without this
> > > > > > on QCOM platforms, GPU faults can cause unrelated
> > > > > > GPU memory accesses to return zeroes. This has the
> > > > > > unfortunate result of command-stream reads from CP
> > > > > > getting invalid data, causing a cascade of fail.
> > > >
> > > > I think this came up before, but something about this rationale doesn't add
> > > > up - we're not *using* stalls at all, we're still terminating faulting
> > > > transactions unconditionally; we're just using CFCFG to terminate them with
> > > > a slight delay, rather than immediately. It's really not clear how or why
> > > > that makes a difference. Is it a GPU bug? Or an SMMU bug? Is this reliable
> > > > (or even a documented workaround for something), or might things start
> > > > blowing up again if any other behaviour subtly changes? I'm not dead set
> > > > against adding this, but I'd *really* like to have a lot more confidence in
> > > > it.
> > >
> > > Rob mentioned something about the "bus returning zeroes" before, but I agree
> > > that we need more information so that we can reason about this and maintain
> > > the code as the driver continues to change. That needs to be a comment in
> > > the driver, and I don't think "but android seems to work" is a good enough
> > > justification. There was some interaction with HUPCF as well.
> >
> > The issue is that there are multiple parallel memory accesses
> > happening at the same time, for example CP (the cmdstream processor)
> > will be reading ahead and setting things up for the next draw or
> > compute grid, in parallel with some memory accesses from the shader
> > which could trigger a fault.  (And with faults triggered by something
> > in the shader, there are *many* shader threads running in parallel so
> > those tend to generate a big number of faults at the same time.)
> >
> > We need either CFCFG or HUPCF, otherwise what I have observed is that
> > while the fault happens, CP's memory access will start returning
> > zero's instead of valid cmdstream data, which triggers a GPU hang.  I
> > can't say whether this is something unique to qcom's implementation of
> > the smmu spec or not.
> >
> > *Often* a fault is the result of the usermode gl/vk/cl driver bug,
> > although I don't think that is an argument against fixing this in the
> > smmu driver.. I've been carrying around a local patch to set HUPCF for
> > *years* because debugging usermode driver issues is so much harder
> > without.  But there are some APIs where faults can be caused by the
> > user's app on top of the usermode driver.
> >
> 
> Also, I'll add to that, a big wish of mine is to have stall with the
> ability to resume later from a wq context.  That would enable me to
> hook in the gpu crash dump handling for faults, which would make
> debugging these sorts of issues much easier.  I think I posted a
> prototype of this quite some time back, which would schedule a worker
> on the first fault (since there are cases where you see 1000's of
> faults at once), which grabbed some information about the currently
> executing submit and some gpu registers to indicate *where* in the
> submit (a single submit could have 100's or 1000's of draws), and then
> resumed the iommu cb.
> 
> (This would ofc eventually be useful for svm type things.. I expect
> we'll eventually care about that too.)

Rob is right about HUPCF. Due to the parallel nature of the command processor
there is always a very good chance that a CP access is somewhere in the bus so
any pagefault is usually a death sentence. The GPU context bank would always
want HUPCF set to 1.

Downstream also uses CFCFG for stall-on-fault debug case. You wouldn't want
this on all the time in production since bringing down the world for every user
pagefault is less than desirable so it needs to be modified in run-time (or at
the very least kernel command line selectable).

Jordan

PS: Interestingly, the GMU does not want HUPCF set to 1 because it wants to
crash immediately on all invalid accesses so ideally these combination of bits
would be configurable on a per-context basis.

> > >
> > > As a template, I'd suggest:
> > >
> > > > > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > > > > index 8d1cd54d82a6..d5134e0d5cce 100644
> > > > > > --- a/drivers/iommu/arm-smmu.h
> > > > > > +++ b/drivers/iommu/arm-smmu.h
> > > > > > @@ -386,6 +386,7 @@ struct arm_smmu_impl {
> > > > > >      int (*init_context)(struct arm_smmu_domain *smmu_domain);
> > > > > >      void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
> > > > > >               int status);
> > >
> > > /*
> > >  * Stall transactions on a context fault, where they will be terminated
> > >  * in response to the resulting IRQ rather than immediately. This should
> > >  * pretty much always be set to "false" as stalling can introduce the
> > >  * potential for deadlock in most SoCs, however it is needed on Qualcomm
> > >  * XXXX because YYYY.
> > >  */
> > >
> > > > > > +    bool stall;
> > >
> > > Hmm, the more I think about this, the more I think this is an erratum
> > > workaround in disguise, in which case this could be better named...
> > >
> > > Will

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
