Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55AC433E1
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:13:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D0420671
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Lsnqs5pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D0420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 389B788905;
	Wed, 20 May 2020 15:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZPBGsfZ5IVab; Wed, 20 May 2020 15:13:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83205888EA;
	Wed, 20 May 2020 15:13:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D359C07FF;
	Wed, 20 May 2020 15:13:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F949C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0D0862045B
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:13:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 76zVhZEoEHMT for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 15:13:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by silver.osuosl.org (Postfix) with ESMTPS id 852FD248A1
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:13:24 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1589987607; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=FU2/F0+z/dsbqHttz+iiGqnFGzScOK5dcu4PKa2fHvs=;
 b=Lsnqs5pqx+fOEWJ6WCLTcYVOtpAVJlp7c9vJ/ILZB4D9AVzvlo/BuolS2O/u63UY15gsMtqV
 2IlYCNoARAJLOkdqHmLIH+w9vTmZcZq9ugbqIklQ4hL6t8VPcFs8K2RXCWO5RqlSdChT1A+J
 bomT1KRofbfeTZHTdxqfM6C92oA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ec5490c4c3faf51e207121a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 May 2020 15:13:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 85CADC43391; Wed, 20 May 2020 15:13:15 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BBA5C433C6;
 Wed, 20 May 2020 15:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BBA5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Wed, 20 May 2020 09:13:12 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 2/6] arm/smmu: Add auxiliary domain support for
 arm-smmuv2
Message-ID: <20200520151312.GB31730@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, 
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
 <1580249770-1088-3-git-send-email-jcrouse@codeaurora.org>
 <20200318224840.GA10796@willie-the-truck>
 <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
 <20200518151838.GL32394@willie-the-truck>
 <CAF6AEGswv3ZaJyy_kYv6FKAjO5=_juDwEtK+VE9TcVMLGvrdwA@mail.gmail.com>
 <20200520125700.GD25815@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520125700.GD25815@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
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

On Wed, May 20, 2020 at 01:57:01PM +0100, Will Deacon wrote:
> On Mon, May 18, 2020 at 08:50:27AM -0700, Rob Clark wrote:
> > On Mon, May 18, 2020 at 8:18 AM Will Deacon <will@kernel.org> wrote:
> > > On Wed, Mar 18, 2020 at 04:43:07PM -0700, Rob Clark wrote:
> > > > We do in fact need live domain switching, that is really the whole
> > > > point.  The GPU CP (command processor/parser) is directly updating
> > > > TTBR0 and triggering TLB flush, asynchronously from the CPU.
> > > >
> > > > And I think the answer about ASID is easy (on current hw).. it must be zero[*].
> > >
> > > Using ASID zero is really bad, because it means that you will end up sharing
> > > TLB entries with whichever device is using context bank 0.
> > >
> > > Is the SMMU only used by the GPU in your SoC?
> > >
> > 
> > yes, the snapdragon SoCs have two SMMU instances, one used by the GPU,
> > where ASID0/cb0 is the gpu itself, and another cb is the GMU
> > (basically power control for the gpu), and the second SMMU is
> > everything else.
> 
> Right, in which case I'm starting to think that we should treat this GPU
> SMMU instance specially. Give it its own compatible string (looks like you
> need this for HUPCFG anyway) and hook in via arm_smmu_impl_init(). You can
> then set IO_PGTABLE_QUIRK_ARM_TTBR1 when talking to the io-pgtable code
> without having to add a domain attribute.

If we did this via a special GPU SMMU instance then we could also create and
register a dummy TTBR0 instance along with the TTBR1 instance and then we
wouldn't need to worry about the aux domains at all.

> With that. you'll need to find a way to allow the GPU driver to call into
> your own hooks for getting at the TTBR0 tables -- given that you're
> programming these in the hardware, I don't think it makes sense to expose
> that in the IOMMU API, since most devices won't be able to do anything with
> that data. Perhaps you could install a couple of function pointers
> (subdomain_alloc/subdomain_free) in the GPU device when you see it appear
> from the SMMU driver? Alternatively, you could make an io_pgtable_cfg
> available so that the GPU driver can interface with io-pgtable directly.
 
I don't want to speak for Rob but I think that this is the same direction we've
landed on. If we use the implementation specific code to initialize the base
pagetables then the GPU driver can use io-pgtable directly. We can easily
construct an io_pgtable_cfg. This feature will only be available for opt-in
GPU targets that will have a known configuration.

The only gotcha is TLB maintenance but Rob and I have ideas about coordinating
with the GPU hardware (which has to do a TLBIALL during a switch anyway) and we
can always use the iommu_tlb_flush_all() hammer from software if we really need
it. It might take a bit of thought, but it is doable.

> Yes, it's ugly, but I don't think it's worth trying to abstract this.

I'm not sure how ugly it is. I've always operated under the assumption that the
GPU SMMU was special (though it had generic registers) just because of where it
was and how it it was used.  In the long run baking in a implementation specific
solution would probably be preferable to lots of domain attributes and aux
domains that would never be used except by us.

> Thoughts? It's taken me a long time to figure out what's going on here,
> so sorry if it feels like I'm leading you round the houses.

I'll hack on this and try to get something in place. It might be dumber on the
GPU side than we would like but it would at least spur some more conversation.

Jordan

> Will

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
