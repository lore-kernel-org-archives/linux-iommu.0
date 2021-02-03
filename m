Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1798C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 22:11:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE6864E0F
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 22:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE6864E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CCB21862D4;
	Wed,  3 Feb 2021 22:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OIzMm8HMFzIN; Wed,  3 Feb 2021 22:11:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31F328624A;
	Wed,  3 Feb 2021 22:11:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08587C0174;
	Wed,  3 Feb 2021 22:11:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0278C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 22:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B284720465
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 22:11:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JqEjg+XCyxyw for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 22:11:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by silver.osuosl.org (Postfix) with ESMTPS id 1635320341
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 22:11:50 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id 7so1148317wrz.0
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 14:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DGHGJpRMiCcjJwzqK5MM6WMiK3EoPUFXs3r66DkReec=;
 b=S3MB8seuCtDvh24s/3erzEhs7gRNbrofohoVTt8xqTqq2yk5aD7eO5BlMRIGi0y4TG
 Ibrp3gdxwIu+yD/9g7ANHGFfPJYvXG0G6nVM3eygUBaxY+rDmjuWMeiJxN7ZworTUb6c
 GboKqbA4u0KibkkxLrDRr1tlPgKxxqgtR3EloTsUtqBWNVG+Q8i3yoLaESwf59DphnSw
 hKj2OflM1Vyf+VcSg5ZX1Q7HFsb5dMf17SJB+WUZpg1gXfAgf8fPU7g1RcVSbg8lEi7H
 Cnoe3fsqi0LKGjH5e58RhRvFMHVFkYow1Chm6tRBqehXGbYKcDyfXIXz/PTb67hI4Vfk
 bLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DGHGJpRMiCcjJwzqK5MM6WMiK3EoPUFXs3r66DkReec=;
 b=GkdI9ncHvUESCq9/8S2v3lROKIdkpPXvzMbV++8hOlug0ImV79WhERa1f2SNdHVz0P
 snMxifjFbEff9CQrvdOBa5zcGRjemVpwNkvp77xWw/aSsudfh08eZXjWnGl4M71Jtc0J
 QUHl1j+zGUQJmNTiHUfHThrtHHdZF7Mn1SZWAqh3S1bbTSOsfnlJS4Hy30jeY1CFZPud
 P0juBIlftiTuJjjE3IOFJRUfU4uAO48Tq982By+NUn2nsPufdp0YzyPi+Rkn+yvLX0g+
 csK1Csl+NCu8Crly84/fCahKMUJy/S9hNVhKQEs3SQKZePQ177N2nOQDKcLJiYwh1r5/
 5pQw==
X-Gm-Message-State: AOAM531lMjK0+UQpg4W2UQhLBEfNS7x3n0tK5jX97t/huCI2l1nsd7ep
 MPjifSiDyMcrGt3siFpUgQYXIV9TWFQxKjK1U0A=
X-Google-Smtp-Source: ABdhPJz2U3p64iobJT1hGITPWHLOB9zIo2IWTmX37FNqu4La4A9zuhiYu7lZ2mICc2qR9GiL9CQlmYBY/RpaXLj7x1s=
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr5894743wrq.132.1612390308448; 
 Wed, 03 Feb 2021 14:11:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <3f589e7de3f9fa93e84c83420c5270c546a0c368.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210129090516.GB3998@willie-the-truck>
 <5d23fce629323bcda71594010824aad0@codeaurora.org>
 <20210201111556.GA7172@willie-the-truck>
 <CAF6AEGsARmkAFsjaQLfa2miMgeijo183MWDKGtW_ti-UCpzBqA@mail.gmail.com>
 <20210201182016.GA21629@jcrouse1-lnx.qualcomm.com>
 <7e9aade14d0b7f69285852ade4a5a9f4@codeaurora.org>
 <20210203214612.GB19847@willie-the-truck>
In-Reply-To: <20210203214612.GB19847@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 3 Feb 2021 14:14:22 -0800
Message-ID: <CAF6AEGvjzkRqr8-z56tJdMs-LsoLMr1m5cVAq_++xCdHjTPKrQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Add IOMMU_LLC page protection
 flag
To: Will Deacon <will@kernel.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sean Paul <sean@poorly.run>, "list@263.net:IOMMU DRIVERS ,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Kristian H Kristensen <hoegsberg@google.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Wed, Feb 3, 2021 at 1:46 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Feb 02, 2021 at 11:56:27AM +0530, Sai Prakash Ranjan wrote:
> > On 2021-02-01 23:50, Jordan Crouse wrote:
> > > On Mon, Feb 01, 2021 at 08:20:44AM -0800, Rob Clark wrote:
> > > > On Mon, Feb 1, 2021 at 3:16 AM Will Deacon <will@kernel.org> wrote:
> > > > > On Fri, Jan 29, 2021 at 03:12:59PM +0530, Sai Prakash Ranjan wrote:
> > > > > > On 2021-01-29 14:35, Will Deacon wrote:
> > > > > > > On Mon, Jan 11, 2021 at 07:45:04PM +0530, Sai Prakash Ranjan wrote:
> > > > > > > > +#define IOMMU_LLC        (1 << 6)
> > > > > > >
> > > > > > > On reflection, I'm a bit worried about exposing this because I think it
> > > > > > > will
> > > > > > > introduce a mismatched virtual alias with the CPU (we don't even have a
> > > > > > > MAIR
> > > > > > > set up for this memory type). Now, we also have that issue for the PTW,
> > > > > > > but
> > > > > > > since we always use cache maintenance (i.e. the streaming API) for
> > > > > > > publishing the page-tables to a non-coheren walker, it works out.
> > > > > > > However,
> > > > > > > if somebody expects IOMMU_LLC to be coherent with a DMA API coherent
> > > > > > > allocation, then they're potentially in for a nasty surprise due to the
> > > > > > > mismatched outer-cacheability attributes.
> > > > > > >
> > > > > >
> > > > > > Can't we add the syscached memory type similar to what is done on android?
> > > > >
> > > > > Maybe. How does the GPU driver map these things on the CPU side?
> > > >
> > > > Currently we use writecombine mappings for everything, although there
> > > > are some cases that we'd like to use cached (but have not merged
> > > > patches that would give userspace a way to flush/invalidate)
> > > >
> > >
> > > LLC/system cache doesn't have a relationship with the CPU cache.  Its
> > > just a
> > > little accelerator that sits on the connection from the GPU to DDR and
> > > caches
> > > accesses. The hint that Sai is suggesting is used to mark the buffers as
> > > 'no-write-allocate' to prevent GPU write operations from being cached in
> > > the LLC
> > > which a) isn't interesting and b) takes up cache space for read
> > > operations.
> > >
> > > Its easiest to think of the LLC as a bonus accelerator that has no cost
> > > for
> > > us to use outside of the unfortunate per buffer hint.
> > >
> > > We do have to worry about the CPU cache w.r.t I/O coherency (which is a
> > > different hint) and in that case we have all of concerns that Will
> > > identified.
> > >
> >
> > For mismatched outer cacheability attributes which Will mentioned, I was
> > referring to [1] in android kernel.
>
> I've lost track of the conversation here :/
>
> When the GPU has a buffer mapped with IOMMU_LLC, is the buffer also mapped
> into the CPU and with what attributes? Rob said "writecombine for
> everything" -- does that mean ioremap_wc() / MEMREMAP_WC?

Currently userspace asks for everything WC, so pgprot_writecombine()

The kernel doesn't enforce this, but so far provides no UAPI to do
anything useful with non-coherent cached mappings (although there is
interest to support this)

BR,
-R

> Finally, we need to be careful when we use the word "hint" as "allocation
> hint" has a specific meaning in the architecture, and if we only mismatch on
> those then we're actually ok. But I think IOMMU_LLC is more than just a
> hint, since it actually drives eviction policy (i.e. it enables writeback).
>
> Sorry for the pedantry, but I just want to make sure we're all talking
> about the same things!
>
> Cheers,
>
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
