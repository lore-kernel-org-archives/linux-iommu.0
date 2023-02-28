Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCA371
	for <iommu@lists.linux.dev>; Tue, 28 Feb 2023 20:59:53 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-536bbef1c5eso309424207b3.9
        for <iommu@lists.linux.dev>; Tue, 28 Feb 2023 12:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H15Wgrg45uphokJUqJE+ge3DLPSULLnvrd4PVO7cLLc=;
        b=fF7yR1zieU4gkviG5qrWrdfSWhtKPGGWlvtMBXv4KHBDu0aJ3gWsucs0SnY/VXu9xI
         98ilQKazhvCJdc/WBewUB+5SWcdhorii7J1pOeAzos6f/dQqHZdg02M4AtOUfeTq8eOO
         f09htTPMG/pkdx7lHQGqeX5kSZIxN5OkkPfc77FKJnyPHYn11vG35NdgnRPHPkAFKcea
         XgImIWOsGyc18s8CqlKSzyo64N6r/4hd/TI5CyRtFIgPb+s+gMlpDT8KVNO9m7c21yRW
         SoYMoaCOLdsdFi4o18FJKo606Yo0hMRNZOz6SykPjzCGVDwzVDiSukBxaNiAwswCzVE4
         k7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H15Wgrg45uphokJUqJE+ge3DLPSULLnvrd4PVO7cLLc=;
        b=JDb6u/9xMhu1bhGY4+P5lyl0tT38vj4jI+uSR840y6ROmq82KQAEmhXzzE8R1+dDtw
         pqbm2NxUpBMVToPBd015qXm3VsfXKs+oS2+BRvBJzTxnsYWag0DU/SRbEy/OZvMykCWZ
         odaOhDAlnaE2pxMxMnTug5MpHopdkVpCAAwnGA8F3udOCj2CGjMOsadhJ0Gomu1Sc1t8
         ELfjsn9I9une47+U165xZJO0c4XEjWl2ZfBombU/583moudx59RLb3vfD2H9gEX6kZJo
         l83szpCa9XJrTqTGcz1l+9Lvv/2sTQbEpa7v+Fueqyuma0eOSuqZ2e8yZig0TFqYznu0
         qkBQ==
X-Gm-Message-State: AO0yUKVLuCTOr8yLH8eerg5XDNTC3oryQ3gFtPsyHm4d60mHXIbOTQFJ
	E2O0DhXzj1CwMr0wGVyK3x/JHkKxtq0TvfKoOnUBUQ==
X-Google-Smtp-Source: AK7set+d6vs4ymgWzsVBho7zIKcb2AoIn1quNMhQ7GG855RnJ+2d+gNas87Vdn9aekeC5XgvBudues+ObsH6EIGw7ZY=
X-Received: by 2002:a5b:8b:0:b0:90d:af77:9ca6 with SMTP id b11-20020a5b008b000000b0090daf779ca6mr2178238ybp.7.1677617992660;
 Tue, 28 Feb 2023 12:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Y8v+qVZ8OmodOCQ9@nvidia.com>
In-Reply-To: <Y8v+qVZ8OmodOCQ9@nvidia.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 28 Feb 2023 12:59:41 -0800
Message-ID: <CABdmKX3kJZKsOQSi=4+RE8D3AF=-823B9WV11sC4WH67hjzqSQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF proposal]: Physr discussion
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linux-rdma@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, 
	Joao Martins <joao.m.martins@oracle.com>, John Hubbard <jhubbard@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 21, 2023 at 7:03 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> I would like to have a session at LSF to talk about Matthew's
> physr discussion starter:
>
>  https://lore.kernel.org/linux-mm/YdyKWeU0HTv8m7wD@casper.infradead.org/
>
> I have become interested in this with some immediacy because of
> IOMMUFD and this other discussion with Christoph:
>
>  https://lore.kernel.org/kvm/4-v2-472615b3877e+28f7-vfio_dma_buf_jgg@nvidia.com/
>
> Which results in, more or less, we have no way to do P2P DMA
> operations without struct page - and from the RDMA side solving this
> well at the DMA API means advancing at least some part of the physr
> idea.
>
> So - my objective is to enable to DMA API to "DMA map" something that
> is not a scatterlist, may or may not contain struct pages, but can
> still contain P2P DMA data. From there I would move RDMA MR's to use
> this new API, modify DMABUF to export it, complete the above VFIO
> series, and finally, use all of this to add back P2P support to VFIO
> when working with IOMMUFD by allowing IOMMUFD to obtain a safe
> reference to the VFIO memory using DMABUF. From there we'd want to see
> pin_user_pages optimized, and that also will need some discussion how
> best to structure it.
>
> I also have several ideas on how something like physr can optimize the
> iommu driver ops when working with dma-iommu.c and IOMMUFD.
>
> I've been working on an implementation and hope to have something
> draft to show on the lists in a few weeks. It is pretty clear there
> are several interesting decisions to make that I think will benefit
> from a live discussion.
>
> Providing a kernel-wide alternative to scatterlist is something that
> has general interest across all the driver subsystems. I've started to
> view the general problem rather like xarray where the main focus is to
> create the appropriate abstraction and then go about transforming
> users to take advatange of the cleaner abstraction. scatterlist
> suffers here because it has an incredibly leaky API, a huge number of
> (often sketchy driver) users, and has historically been very difficult
> to improve.
>
> The session would quickly go over the current state of whatever the
> mailing list discussion evolves into and an open discussion around the
> different ideas.
>
> Thanks,
> Jason
>

Hi, I'm interested in participating in this discussion!
