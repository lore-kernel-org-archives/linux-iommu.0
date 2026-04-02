Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3C365A1B
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775104904; cv=pass; b=dX1+Hd/1+0XpZZghAW5KcATlsjQk8lW2wi+Az2xQJ01e47WHRGSS3mlndLj+3ibv8y683AI3vMWweA67hRoErdeBXyWeUsw8TUTComz/chiqyA41t2yUJIUECHLd9e18u+vcCyP+ELzSZqA2NZme8mzwK15L2xtEkxUPpTRnT9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775104904; c=relaxed/simple;
	bh=8M0uK/dY9UfmR0xcTfEk17ugbKg+8eIoSDrEidIpkIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMAx5Oo9YZ2EOQWYr0vWvb/2hKu2yak71lwtaXlsbjF3A/cALNPnulg+3CdCcb+aPu5Y816Nv+YxtlpiavOlP6iJL2/zgzauTtMdIoihWbXpvpZvN5B5xKkAmdJGT7jADBXvs06NSs072TUsvKkWrIdbxSeFnGKS5JCKrCOu4eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAkA1lFS; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAkA1lFS"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9a0762ed5fso64694966b.1
        for <iommu@lists.linux.dev>; Wed, 01 Apr 2026 21:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775104901; cv=none;
        d=google.com; s=arc-20240605;
        b=TvfC9hUN292Wa+jtEMMepqfhLKcKAencV0WT62urmQ7DaQTGW2YBJXom9W51V3OtvI
         24qNvi+iI2Lh+dzmtJVwcPkZ6UUnD+ahf20O15PdIleq7A2VkeVPUtmxOOi27kFN4a0b
         JazxOYSwZA3SyHIlomdw7gNvcfLM6a31ZKRQ+QGJtBZacpwUYJ5NwIZI9YBbhIQPFYxi
         T8S//Qe/CUfp4znbzV1XcD5WCdSxWbFrFU7YDpN+s6jrA8xeez/jxb1/yts4496iAIVZ
         BemW0Z3MurmavrLpL+7mVDOCGwjCGqESFiGPcyxO6n/TpSQ3B+Wjqfee89CrGbh6SeIb
         PZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MsqizXttng34qJSYG1+nQy1RthHCf+vtWgekNCi7+qE=;
        fh=wTZX6HLpJONa8w5FGjcpeWJmDb4/nAUd4kFjTHiK30Q=;
        b=HgXnVmti722eny7V6ZKK2ZKYoF4tlGFOIMsCuH/5QYnKb8oQRfru1pNpZpzJxAeiOg
         aXyz/FcVRRM7M6wUmzmzEEY1pwjpr4sW3QZjSYFQTRWK8V3i8OKaPaWRZ1iApb4Ub1y1
         eMWYZPm7LIh9/yJeeQPaYuXkbHerpkhXjBLa8XSBnhvUkZuhVu1w+ITvpqYreuye/Ldz
         RN16qVNbkxAVSSx8tCufPflAfJZgEgWDZ1bOdVNw4ev0cjTOJC0g4kxTSxz5jhgPExc0
         S8Lss0Wh5uGFVxt31GKdQryuAD2JVxGkVa2Itj8aM5woA+HfNCRYGFwW5td/YepurPNY
         m1mA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775104901; x=1775709701; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MsqizXttng34qJSYG1+nQy1RthHCf+vtWgekNCi7+qE=;
        b=bAkA1lFSIdqefpMgJ8gLEiUfxvU+W0yJECb/eEtUaCSEH2+HJQwKOBvhWVf0sf6WeV
         SLfp9mAMV5HxbbLogy+3rwwalVM7JZ2cPfYG770STZFnwrBP36gZP006xFN6ffHtLEb+
         rNwsOXUEJdgu+i3tMRWGeXLchFW3emmhdJI60fcsWoixF1erS5u3tl5vJKcX+DG8RG/A
         nr87VhPryhj0T4c5cgKCyWJ6t0hSW6NKy0AQe2xGeKKI9/cuHfVGfmgK8ZLtK3fLdrXJ
         Yv7C4n6raODhKNgJM2VNgDnzn8WC9/R35bYinncMBkzaP1T/uLz2O74KyvLZAQHzlGqT
         argg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775104901; x=1775709701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsqizXttng34qJSYG1+nQy1RthHCf+vtWgekNCi7+qE=;
        b=VYOs8bIkupAm6vji08AwUj5Uf184QOAOQcz87n5IoEvffNcuTfLgUs/qiOa87zOeLs
         qlOZ8iXnUIROCnSO+Cgs6FLSgOzniq8bscz6M0hLpP6ebMpLXfCKqIskCazLhgUyqRvs
         HdmWupkfx7kHpoLGvGiXitX9sDlklMusd5JV+li4ITYcnzDrZYYIM8fKnCeLWFVfOGGJ
         j9fD1kAV7BFbN0R4HS5UE879XLNlf9fVbM3g/RqvvkubEUP7x72cy5uFkZhHpo/NVzg/
         jZ9qUYqflmacsWw8ZK7m8A8ad/DagEqvIijq/tNCiN5LHQUq+H7xfMYxhwLOYltCxK8/
         c31w==
X-Forwarded-Encrypted: i=1; AJvYcCXA08hsbcCVnERMulN/63YujmCLPxb6SE2v26eh6o0a1yqqIhP4tPphbzFGazHpE1qaniXnbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMnQ8M2iGLIvw4dXLd/rxqlxX08D7+/p/4+UCrNsi+zPrFr3Fs
	2SYH7a6PzhGlZ6CyGnxUWV4q4bFO38P4GcAcuJmoXwGyqsvSVWVcAPrfpJda/eRcce1lu/KFy4r
	3esBySxScNRWO2tVGY6KAY2MIoOY9VP2qADSqZpFNhQ==
X-Gm-Gg: ATEYQzy9sXHV1+nbu1dWA2//k3h0+1t+Q7xrO07Bt4u/7nVqCsQlm8bnvXPtSD/ME/c
	vnRzhg/yj8n3YOaxFiZQ7Yd6U/28Y3cj3j6KHK/FA19c0yFsl44Hv71pGnPNTE94Tq0OqEx72Qn
	0ev8IWpZcpV9m75Nx2Y9UTnJqi79hTFoMDkxIx1mXtx8FJz28898TDrRmufU5H08xbya3GOQ6++
	rwy+i6cg17peNScVQTT0gtyCq2WpNq+9NP5GVsRMqjMnO1zOle29YEYqm5kFcPD20v8CjIUivKV
	3ULrJuKGdCGL82itsTQz6aIf86ynaYtKAGTBiUY=
X-Received: by 2002:a17:907:8694:b0:b93:8275:795a with SMTP id
 a640c23a62f3a-b9c46fedc2cmr44691666b.15.1775104901064; Wed, 01 Apr 2026
 21:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260325192352.437608-1-jiri@resnulli.us>
In-Reply-To: <20260325192352.437608-1-jiri@resnulli.us>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 2 Apr 2026 10:11:29 +0530
X-Gm-Features: AQROBzCoqOVd8w8IT8q-wzhadg7W4rdnhn-HGLlu-Tm0fuk9WqMGP5WDrs9ZghY
Message-ID: <CAO_48GEUXpcFBiyJAMgTcGPSq56-mZ0qnO3FrFRM2LoGd8W6HA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, 
	ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org, 
	suzuki.poulose@arm.com, steven.price@arm.com, thomas.lendacky@amd.com, 
	john.allen@amd.com, ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Jiri,

On Thu, 26 Mar 2026 at 00:53, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
> run with private/encrypted memory which creates a challenge
> for devices that do not support DMA to it (no TDISP support).
>
> For kernel-only DMA operations, swiotlb bounce buffering provides a
> transparent solution by copying data through shared memory.
> However, the only way to get this memory into userspace is via the DMA
> API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> the use of the memory to a single DMA device, and is incompatible with
> pin_user_pages().
>
> These limitations are particularly problematic for the RDMA subsystem
> which makes heavy use of pin_user_pages() and expects flexible memory
> usage between many different DMA devices.
>
> This patch series enables userspace to explicitly request shared
> (decrypted) memory allocations from new dma-buf system_cc_shared heap.
> Userspace can mmap this memory and pass the dma-buf fd to other
> existing importers such as RDMA or DRM devices to access the
> memory. The DMA API is improved to allow the dma heap exporter to DMA
> map the shared memory to each importing device.

Thank you for the patch series, it looks good to me.

Marek, if you are ok, please could you take it through your tree, with my
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

Best,
Sumit.
>
> Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0d
>
> Jiri Pirko (2):
>   dma-mapping: introduce DMA_ATTR_CC_SHARED for shared memory
>   dma-buf: heaps: system: add system_cc_shared heap for explicitly
>     shared memory
>
>  drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
>  include/linux/dma-mapping.h         |  10 +++
>  include/trace/events/dma.h          |   3 +-
>  kernel/dma/direct.h                 |  14 +++-
>  kernel/dma/mapping.c                |  13 +++-
>  5 files changed, 132 insertions(+), 11 deletions(-)
>
> --
> 2.51.1
>
