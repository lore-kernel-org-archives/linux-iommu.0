Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C312C819
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474581; cv=none; b=oasPoMR95kCN02I0PxJX6Ogi/DiuPnFXKQwd58YMy2wPerDj/JusjuQuhqGUDU+Ygdj+29mcUiR6mcYP4m/au5g44RPfsHpfgGF1o5/m3jEDW/RA7r0kKJPLmat0VJsuLWjljEOcJRsAQ7TTejSKAmA0/ChDH3Ea1zN/c+cRT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474581; c=relaxed/simple;
	bh=Z7yL0U/gcDov5K0l+LMi9J5dcrJohhCp1XV2fyheWlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkn6RUlgDVp2opOShCQ5ZfOMjefOmPR+FSrTaw1ZInRxvw4Sc5Pt/86yYTcn0WrG2pRD0/bip5NE6iq9gyxoXqxtGD1STY4VKw/RNu/k92+HAUpu1Ubacd6+Zk55bcPXtbj6Pl9HKGyxuCV1CVUcz6/qe1aX7g4ricpktesCRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sv5ecrNd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sv5ecrNd"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617e42a3f94so59824517b3.2
        for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714474579; x=1715079379; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3ANzOovClROUBS3Nn4nb+rVzx+/CIWtYXFgMiBCBSI=;
        b=Sv5ecrNd+7npbosUYAM4giwW6NCC69DoWnd1kU9Vlu2xK7hgfJhkfwqRxtuADOtYMj
         cy+itSwTe8fr6uJhV5UtMScL/3VZBwoUKHWa0eq/Ki8eUic3sUN3UvIDdrvGbtMzJ1rA
         eQDxyMrFRKqDSRvOyA1CKW9s9Z391sQh/UEDBKG/Wh1ECAEi7DevxQ6EPU46Lcfo4/H1
         ImKEFuqXX1mXacVVRHlTWGW8DR4ubpFR/2ppWHEYm4M9A2/KHNqmh9sBqcONurJKp/1i
         d8DP8fOE91QbN2MOpSaFNCxQCJDbG68KjQmlfPzC6fW4+4yRowRlLXZndFkzlr/sGyyk
         Q+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714474579; x=1715079379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3ANzOovClROUBS3Nn4nb+rVzx+/CIWtYXFgMiBCBSI=;
        b=kwH5Z3BNo1b1Wd6OgauPWZ9bzKL3dsRn0bRrroTjM4t3HO0BUo17B5+YqWHjWFtzwt
         PVWUqZyLFq/HJTpKAwZnScrcIT+AW29cflv9WD8bkmziNTpugVnjqekP+5zBDVBF5TiQ
         EBrPmPuqOwb97YMiFHpqC6KrlSkg7WWhOjxHvk07ZbuSkytEQCSnkEemHaOIirKH/buY
         Dr0rpRLJmOqHj2Om37wAoA6dkZ357+bXg2DSskBzAHRSK8GlNvZfEbNqnPlq1v0peSdQ
         mZV9W0h1NZu5cpWPC6+tanaFrM535fjyJ9e+ukN11sysKmnhxQ3na38G1ketmA/dS6uV
         vIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtz7xT41q9kpqlRDgkKLGBAlbLTDUsNGrRtiNu0d+rlp5b99HtFlifmtCN6u7iVCgrnlnBDzH/968Bt6k7sKbW/yxER44=
X-Gm-Message-State: AOJu0YxClfoxLzxKzrFFaOGTqYopVjuV+49XMchHWkKqe9gStwlVejr3
	SzBfEGadSevdJ4LjIE3UaFWtnxQxypi0cfvN4+Qp+mv3DdLCINM52eT1YI4RITuFIaIgQsnQ5NH
	jjuFqR6XrdTy2oTkOEsDfip6Nyp7C0pk6t7g/0g==
X-Google-Smtp-Source: AGHT+IGpcUPe4PzDbKJZuWjVEt2j2YgVnBnHAeHmwYGgyhtthmZCRgI611EqUANkd2RSTrLN4sfimNVOJdo7rmRvZvI=
X-Received: by 2002:a05:690c:14:b0:61a:fc3b:fdd3 with SMTP id
 bc20-20020a05690c001400b0061afc3bfdd3mr14804250ywb.43.1714474578907; Tue, 30
 Apr 2024 03:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1713523152.git.robin.murphy@arm.com> <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>
 <Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru> <2662a5ba-3115-4fe5-9cec-bff71f703a82@arm.com>
 <CAA8EJprxLvYEP8+ggk8fw--kHaK+_QoYan4st2wWpPicHa6_+w@mail.gmail.com> <20d44077-d0a8-470a-bf6f-82683db894cf@arm.com>
In-Reply-To: <20d44077-d0a8-470a-bf6f-82683db894cf@arm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Apr 2024 13:56:07 +0300
Message-ID: <CAA8EJpqu4d6G3wci7gKGhz0qBVwQ-DEJW3soG2QCyNPCg6Gq8g@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 13:20, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2024-04-30 1:41 am, Dmitry Baryshkov wrote:
> > On Tue, 30 Apr 2024 at 01:26, Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2024-04-29 5:31 pm, Dmitry Baryshkov wrote:
> >>> On Fri, Apr 19, 2024 at 05:54:45PM +0100, Robin Murphy wrote:
> >>>> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> >>>> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> >>>> which means there should be no harm in achieving the same order of
> >>>> operations by running it off the back of iommu_probe_device() itself.
> >>>> This then puts it in line with the x86 and s390 .probe_finalize bodges,
> >>>> letting us pull it all into the main flow properly. As a bonus this lets
> >>>> us fold in and de-scope the PCI workaround setup as well.
> >>>>
> >>>> At this point we can also then pull the call up inside the group mutex,
> >>>> and avoid having to think about whether iommu_group_store_type() could
> >>>> theoretically race and free the domain if iommu_setup_dma_ops() ran just
> >>>> *before* iommu_device_use_default_domain() claims it... Furthermore we
> >>>> replace one .probe_finalize call completely, since the only remaining
> >>>> implementations are now one which only needs to run once for the initial
> >>>> boot-time probe, and two which themselves render that path unreachable.
> >>>>
> >>>> This leaves us a big step closer to realistically being able to unpick
> >>>> the variety of different things that iommu_setup_dma_ops() has been
> >>>> muddling together, and further streamline iommu-dma into core API flows
> >>>> in future.
> >>>>
> >>>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com> # For Intel IOMMU
> >>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >>>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> >>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>>> ---
> >>>> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
> >>>>       is covered as well, with bonus side-effects as above.
> >>>> v3: *Really* do that, remembering the other two probe_finalize sites too.
> >>>> ---
> >>>>    arch/arm64/mm/dma-mapping.c  |  2 --
> >>>>    drivers/iommu/amd/iommu.c    |  8 --------
> >>>>    drivers/iommu/dma-iommu.c    | 18 ++++++------------
> >>>>    drivers/iommu/dma-iommu.h    | 14 ++++++--------
> >>>>    drivers/iommu/intel/iommu.c  |  7 -------
> >>>>    drivers/iommu/iommu.c        | 20 +++++++-------------
> >>>>    drivers/iommu/s390-iommu.c   |  6 ------
> >>>>    drivers/iommu/virtio-iommu.c | 10 ----------
> >>>>    include/linux/iommu.h        |  7 -------
> >>>>    9 files changed, 19 insertions(+), 73 deletions(-)
> >>>
> >>> This patch breaks UFS on Qualcomm SC8180X Primus platform:
> >>>
> >>>
> >>> [    3.846856] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x1032db3e0, fsynr=0x130000, cbfrsynra=0x300, cb=4
> >>
> >> Hmm, a context fault implies that the device did get attached to a DMA
> >> domain, thus has successfully been through __iommu_probe_device(), yet
> >> somehow still didn't get the right DMA ops (since that "IOVA" looks more
> >> like a PA to me). Do you see the "Adding to IOMMU group..." message for
> >> this device, and/or any other relevant messages or errors before this
> >> point?
> >
> > No, nothing relevant.
> >
> > [    8.372395] ufshcd-qcom 1d84000.ufshc: Adding to iommu group 6
> >
> > (please ignore the timestamp, it comes before ufshc being probed).
> >
> >> I'm guessing there's a fair chance probe deferral might be
> >> involved as well. I'd like to understand what path(s) this ends up
> >> taking through __iommu_probe_device() and of_dma_configure(), or at
> >> least the number and order of probe attempts between the UFS and SMMU
> >> drivers.
> >
> > __iommu_probe_device() gets called twice and returns early because ops is NULL.
> >
> > Then finally of_dma_configure_id() is called. The following branches are taken:
> >
> > np == dev->of_node
> > of_dma_get_range() returned 0
> > bus_dma_limit and dma_range_map are set
> > __iommu_probe_device() is called, using the `!group->default_domain &&
> > !group_lis` case, then group->default_domain() is not NULL,
> > In the end, iommu_setup_dma_ops() is called.
> >
> > Then the ufshc probe defers (most likely the PHY is not present or
> > some other device is not there yet).
>
> Ah good, probe deferral. And indeed the half-formed hunch from last
> night grew into a pretty definite idea by this morning... patch incoming.

Thanks a lot for the quick fix!


-- 
With best wishes
Dmitry
