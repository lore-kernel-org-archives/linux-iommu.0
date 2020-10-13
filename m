Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58757C433DF
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 16:11:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9CC25271
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 16:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ3kr1Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9CC25271
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 409E28732F;
	Tue, 13 Oct 2020 16:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QDr8ESRIZWZA; Tue, 13 Oct 2020 16:11:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCE09872C7;
	Tue, 13 Oct 2020 16:11:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2329C07FF;
	Tue, 13 Oct 2020 16:11:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FE3DC0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 16:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4EC82872C7
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 16:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8rJDztdo1sNT for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 16:11:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3952F87280
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 16:11:39 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e18so24730039wrw.9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UHsDQCy295Hvw56mXeSaZ5ilmXgdKd81n9fHINsRJmg=;
 b=nZ3kr1ZvmphGw+hCXwxd1FBiNBdH15+XmV7uCx/N1aEPWdhltNbxfRJsOrYzCW5DYi
 p28N16Qv3CesL618NYcwzKJl8ExdPBSsAxEVpNuBjc2t7Y3vSDiCUCXqUsTPP3ri+xa3
 pYSiUdCkoFloRscJR5nF2nOA0n77jg0+DyulydlIg2O5dvN37b/KSTRSu0SrWqgYipLY
 Bv2SinElVWGIxKdfjR2keb0VyF7cTpeW4ZZMmz56ud2NUc4LXZYnfMSWKg7cjru34Jnt
 +3aGTZF5ErCoVoAaJUURuRybNuDUZmE1TuG1eiCC2mcWhrl0X3gWCU5HjivWDiRih7lu
 Lf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UHsDQCy295Hvw56mXeSaZ5ilmXgdKd81n9fHINsRJmg=;
 b=pxF0nYh+HTdOSEO7Ti6wDx+UUoDv0x+EoU8kZSkRjFqoAD1gb9TwnnfL8h0Ud0icQN
 p9K3EBpXL9XhKRgGHKyTqnwgcBh4td3XKw6OHgsw/FjlBTnUkdKR7dGhgQ7lgqYON3Nj
 7x5r8AbUe6Ds9vw9pTEcVFKH78Ab5eDxEIVKTVqCG/Lk9lUkMpQJUC0Dp+Dsxt3uVw7u
 Zq58MSmo2MOnayN1r52ZAINPa1SHdhjnJZYW/Xgo82dgjz6qG+iaQztrp+RkXRkVD2X3
 LrnWIQB0DPqmKApqB7jIsAQOcilTp2oYuNyLesSogm0gRttTRw1ziNiSJjSYapCG4fTI
 QjDg==
X-Gm-Message-State: AOAM531bjE6A7GUa7qw9ztzE9ZG/QNPYjNrLd1Lr03ja4ufEDbqGT2wN
 +ZxKG5mUPhb51P/BIMr4CYEW3dE+qcWaaVALTVs=
X-Google-Smtp-Source: ABdhPJxoD/2hTBypyfQGrCSNRV+Y6GtVMvHZ5uXUCdqyEiDvm0aXKSn04M6vBj6fqcnsx8/6ebXXeOA3cJnZw688USo=
X-Received: by 2002:a5d:4987:: with SMTP id r7mr377398wrq.327.1602605497546;
 Tue, 13 Oct 2020 09:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201001002709.21361-1-jonathan@marek.ca>
 <20201001002709.21361-3-jonathan@marek.ca>
 <20201002075321.GA7547@infradead.org>
 <b22fb797-67b0-a912-1d23-2b47c9a9e674@marek.ca>
 <20201005082914.GA31702@infradead.org>
 <3e0b91be-e4a4-4ea5-7d58-6e71b8d51932@marek.ca>
 <20201006072306.GA12834@infradead.org>
 <148a1660-f0fc-7163-2240-6b94725342b5@marek.ca>
 <20201007062519.GA23519@infradead.org>
 <c3baadae-8e20-86a6-44f5-4571a8d3035e@arm.com>
In-Reply-To: <c3baadae-8e20-86a6-44f5-4571a8d3035e@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 13 Oct 2020 09:11:26 -0700
Message-ID: <CAF6AEGtyczviULunw0tQK0Q9M22vkib19j=R_jTT2EtP5aqRCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm: add DRM_MSM_GEM_SYNC_CACHE for non-coherent
 cache maintenance
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 freedreno <freedreno@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sean Paul <sean@poorly.run>
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

On Tue, Oct 13, 2020 at 6:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-10-07 07:25, Christoph Hellwig wrote:
> > On Tue, Oct 06, 2020 at 09:19:32AM -0400, Jonathan Marek wrote:
> >> One example why drm/msm can't use DMA API is multiple page table support
> >> (that is landing in 5.10), which is something that definitely couldn't work
> >> with DMA API.
> >>
> >> Another one is being able to choose the address for mappings, which AFAIK
> >> DMA API can't do (somewhat related to this: qcom hardware often has ranges
> >> of allowed addresses, which the dma_mask mechanism fails to represent, what
> >> I see is drivers using dma_mask as a "maximum address", and since addresses
> >> are allocated from the top it generally works)
> >
> > That sounds like a good enough rason to use the IOMMU API.  I just
> > wanted to make sure this really makes sense.
>
> I still think this situation would be best handled with a variant of
> dma_ops_bypass that also guarantees to bypass SWIOTLB, and can be set
> automatically when attaching to an unmanaged IOMMU domain. That way the
> device driver can make DMA API calls in the appropriate places that do
> the right thing either way, and only needs logic to decide whether to
> use the returned DMA addresses directly or ignore them if it knows
> they're overridden by its own IOMMU mapping.
>

That would be pretty ideal from my PoV

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
