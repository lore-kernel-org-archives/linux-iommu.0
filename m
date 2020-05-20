Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6435C433E1
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 16:35:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80380206BE
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 16:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSeCxkUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80380206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5A16D88209;
	Wed, 20 May 2020 16:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzYsakNvc-qM; Wed, 20 May 2020 16:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF01088178;
	Wed, 20 May 2020 16:35:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79F93C088A;
	Wed, 20 May 2020 16:35:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58BF3C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 16:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 533B488209
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 16:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X5J69tLj0Ag2 for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 16:35:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D10B488178
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 16:35:23 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id b91so3774363edf.3
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=9LZ3N6eS+xeL2WycYe0EBKoO7cMTBM5h/pIzNPU0uoA=;
 b=nSeCxkUXkPBkC+bMaKiWwAFF5HRebqDVpy2P07v1pSBINuZBVZrf4qlB2nen9i6sAH
 IFNiIXIrUN7/tuSC8zY/0mc8OLB/Dy5M/PqFtsy+MvROKnmEOEYbxNmjNHHBtP5yR1wC
 e3mZqcCzaFHe66Jr3xmpznlMHFjMLoTVZB0MgFUVehc0ZWRuhc1CBINkbiW5bMx402RA
 87X4TCTW7B0+1j7zhQSNK60EnPn3zd6L5qJOHgbA7z/RpFx8aGqHVD0urC9LHIk5Vfi6
 FEN2xhZPC6SHsRR4Ng2Dwg8VngjkQbLwxZe9nm5LmdmlYvpg5d0xoqbdQSeqKVYSjbaF
 i37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=9LZ3N6eS+xeL2WycYe0EBKoO7cMTBM5h/pIzNPU0uoA=;
 b=PoiUKlrtNy/aQqvvtBBfqrtliJQ4ZkNJ2tCGPggOgPNLdwR21Iq/iAre0cmMklP/Yu
 kKBiMZT10/GMuTxq/j9FJQbZKkCL9HaRT8ICveAffpPaEb8UMBIIBKNajb7K02Edhi1m
 vTTp9CoE8BCA11c6pAT/cEO8nb02NRE+3Tuy2DFo9jSyyEWT0Y6IsU/v/0zVvGfbxvCp
 7+dPqspf9tVvBFNsqb/KLBFZ9tjlPbvZ6zMUfAE6eYbMTxYNwXMc91A/C5qD4k7b4rSb
 F5zgqJzTjZ/Apnl80YnOnDfvSiqTfazVVUExT4IXdYzT/uE3ODzvlSKPh0k0CzHkx3ox
 mbIw==
X-Gm-Message-State: AOAM533lAA/3jBHdjklr6cUWY4OTJCe5MhBUQsdW3JlTqZxlLsn6Wz/Z
 GfaMBGco8CgZKPui8HFwayTwJpn0pME32Rx3PqOK+hUs
X-Google-Smtp-Source: ABdhPJztbIVCpypzfMmeE5wi7QZW2wjqt6WJKlmD8c/fGvtyo/k1t0yxQTzmcpir4NVu6nGdGh39/iZWxPahJYBNZUU=
X-Received: by 2002:a50:d7c7:: with SMTP id m7mr4323197edj.101.1589992522103; 
 Wed, 20 May 2020 09:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
 <1580249770-1088-3-git-send-email-jcrouse@codeaurora.org>
 <20200318224840.GA10796@willie-the-truck>
 <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
 <20200518151838.GL32394@willie-the-truck>
 <CAF6AEGswv3ZaJyy_kYv6FKAjO5=_juDwEtK+VE9TcVMLGvrdwA@mail.gmail.com>
 <20200520125700.GD25815@willie-the-truck>
 <20200520151312.GB31730@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20200520151312.GB31730@jcrouse1-lnx.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 20 May 2020 09:35:42 -0700
Message-ID: <CAF6AEGtF+_Q3=GxaVrAtqsPC3B6p_Dc5PB+DQ=btsg3wAej5bg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] arm/smmu: Add auxiliary domain support for
 arm-smmuv2
To: Will Deacon <will@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
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

On Wed, May 20, 2020 at 8:13 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Wed, May 20, 2020 at 01:57:01PM +0100, Will Deacon wrote:
> > On Mon, May 18, 2020 at 08:50:27AM -0700, Rob Clark wrote:
> > > On Mon, May 18, 2020 at 8:18 AM Will Deacon <will@kernel.org> wrote:
> > > > On Wed, Mar 18, 2020 at 04:43:07PM -0700, Rob Clark wrote:
> > > > > We do in fact need live domain switching, that is really the whole
> > > > > point.  The GPU CP (command processor/parser) is directly updating
> > > > > TTBR0 and triggering TLB flush, asynchronously from the CPU.
> > > > >
> > > > > And I think the answer about ASID is easy (on current hw).. it must be zero[*].
> > > >
> > > > Using ASID zero is really bad, because it means that you will end up sharing
> > > > TLB entries with whichever device is using context bank 0.
> > > >
> > > > Is the SMMU only used by the GPU in your SoC?
> > > >
> > >
> > > yes, the snapdragon SoCs have two SMMU instances, one used by the GPU,
> > > where ASID0/cb0 is the gpu itself, and another cb is the GMU
> > > (basically power control for the gpu), and the second SMMU is
> > > everything else.
> >
> > Right, in which case I'm starting to think that we should treat this GPU
> > SMMU instance specially. Give it its own compatible string (looks like you
> > need this for HUPCFG anyway) and hook in via arm_smmu_impl_init(). You can
> > then set IO_PGTABLE_QUIRK_ARM_TTBR1 when talking to the io-pgtable code
> > without having to add a domain attribute.
>
> If we did this via a special GPU SMMU instance then we could also create and
> register a dummy TTBR0 instance along with the TTBR1 instance and then we
> wouldn't need to worry about the aux domains at all.
>
> > With that. you'll need to find a way to allow the GPU driver to call into
> > your own hooks for getting at the TTBR0 tables -- given that you're
> > programming these in the hardware, I don't think it makes sense to expose
> > that in the IOMMU API, since most devices won't be able to do anything with
> > that data. Perhaps you could install a couple of function pointers
> > (subdomain_alloc/subdomain_free) in the GPU device when you see it appear
> > from the SMMU driver? Alternatively, you could make an io_pgtable_cfg
> > available so that the GPU driver can interface with io-pgtable directly.
>
> I don't want to speak for Rob but I think that this is the same direction we've
> landed on. If we use the implementation specific code to initialize the base
> pagetables then the GPU driver can use io-pgtable directly. We can easily
> construct an io_pgtable_cfg. This feature will only be available for opt-in
> GPU targets that will have a known configuration.

Agreed about using io-pgtable helpers directly.. the gpu's use-case is
pretty far different from anything normal/sane, and I don't think it
is worth designing some generic iommu interfaces with precisely one
user[*].  We just need enough in arm-smmu(/-impl) to bootstrap things
when we power up the gpu.

BR,
-R

[*] all the other gpu's that I've seen so far, even if they sit behind
an iommu, they have their own internal mmu

> The only gotcha is TLB maintenance but Rob and I have ideas about coordinating
> with the GPU hardware (which has to do a TLBIALL during a switch anyway) and we
> can always use the iommu_tlb_flush_all() hammer from software if we really need
> it. It might take a bit of thought, but it is doable.
>
> > Yes, it's ugly, but I don't think it's worth trying to abstract this.
>
> I'm not sure how ugly it is. I've always operated under the assumption that the
> GPU SMMU was special (though it had generic registers) just because of where it
> was and how it it was used.  In the long run baking in a implementation specific
> solution would probably be preferable to lots of domain attributes and aux
> domains that would never be used except by us.
>
> > Thoughts? It's taken me a long time to figure out what's going on here,
> > so sorry if it feels like I'm leading you round the houses.
>
> I'll hack on this and try to get something in place. It might be dumber on the
> GPU side than we would like but it would at least spur some more conversation.
>
> Jordan
>
> > Will
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
