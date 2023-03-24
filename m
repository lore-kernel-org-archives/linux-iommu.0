Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2E2F4A
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 12:31:24 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id n19so1080887wms.0
        for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679661083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRSlnjBXAFAkH3Rb4PIA41wJvk7P0elOCwz/1LKKqEg=;
        b=G7jyOr/AErIu94dqZb4FfTC1eZrJa3DmGE78uAXJkZvlZ2n7+x2vuJgT0EIRILEuUf
         2bD1UrlWYzp98PM5qRACW26b7CweefXiFp5r2FSyx5nXw5v14rEbCYaAGnkjeYUSdqiW
         ry32IFcyh72cLcCvL2VjhklgaSUvATWNABTcvD5qXglqWE+USkRphvY5NM+lz4q42atO
         LNjO+PnP06su17E9q2nWVy7zMaG7qv6lf3xT367SMUbb/EJIf90rFZYDOTMHikV+nkas
         l2L46THCfMo4f2oreRvZr5xJiXHJOTa/m1zJvepZyQ+csc8mm7Txdx/7pxmsp04+PlMs
         ij6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679661083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRSlnjBXAFAkH3Rb4PIA41wJvk7P0elOCwz/1LKKqEg=;
        b=K49a4RehDNKu410PWTDCicG20ejTQkKjMqxIHgvxK2Oolm42q8hbuZMP/NqDURaAkM
         MPWgzQXe1ALwWb5N7ABQklN/E1V3NAEYKyj/01qu8q+X4bNKKS03+isWrKtt4rvMOxPv
         fOBGDcMBqOB+cFVUcBZaYCZzGTLnm0hPkXpzXavBVOd+RWVSG2OM2NBQ96fte6Y17cJf
         Ha/C6ZSg6IzZ74/ttu0gnKz6XkowcDrW+yyDeqPlrxnKtZMEpn2iiAqxNYiVMjLQPTPk
         hO8IU6cndRIEgXjVpWv1Mb/G30IN+WcM9JsdwF4aAdX6SeQjkUqX9DdMlDHejrT1flXM
         hSOg==
X-Gm-Message-State: AO0yUKWfQe1Z0bhrVIQNjjpDNcf31pqFBJ/+s1Xeb4k15u+ETSQkEP/d
	rzL6LeNvx6dlAfSEdnhbqn5THw==
X-Google-Smtp-Source: AK7set84IO2/BEEtf1NkSpZJyWXkJ80D8tn/mnF4pxyD9X5FGpL8p4NKQAsdmb0duOvbHUTZ0ehEUw==
X-Received: by 2002:a7b:ce0a:0:b0:3ed:237f:3da with SMTP id m10-20020a7bce0a000000b003ed237f03damr2483050wmc.22.1679661082936;
        Fri, 24 Mar 2023 05:31:22 -0700 (PDT)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003ed243222adsm4695985wmi.42.2023.03.24.05.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 05:31:22 -0700 (PDT)
Date: Fri, 24 Mar 2023 12:31:25 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Michael Shavit <mshavit@google.com>
Cc: Will Deacon <willdeacon@google.com>, robin.murphy@arm.com,
	Daniel Mentz <danielmentz@google.com>,
	John Scheible <johnscheible@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [Design] iommu/arm-smmu-v3: Implementing set_dev_pasid for other
 domain types
Message-ID: <20230324123125.GA1061401@myrica>
References: <CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV24u9b-=cJCF=Kt=3B4hynOyNr6gmi0F6zpO6b1mHc0Z7g@mail.gmail.com>

Hi Michael,

On Fri, Mar 24, 2023 at 05:18:36PM +0800, Michael Shavit wrote:
> Hi Jean-Philippe, all
> 
> We’d like to use the new iommu_attach_device_pasid API to control
> mappings on a per SSID basis. To that end, we’ve started investigating
> how to implement the set_dev_pasid callback in the arm-smmu-v3.c
> driver for domain types other than SVA.
> 
> As noted in your smmuv3 aux-domain patch, the arm_smmu_domain
> represents not only “the non-PASID address space but also (at least
> for SMMUv3) the whole device context, PASID tables etc.” Multiple SVA
> iommu_domains reach into a shared arm_smmu_domain to write their CDs
> into a shared CD table.
> Is moving to a model where each arm_smmu_master holds this previously
> shared device context instead of the arm_smmu_domain a bad idea?
> 
> This would allow a pretty straightforward implementation of
> set_dev_pasid for other domain types:
>     * Attaching a domain with PASID to a device doesn’t have to
> piggyback on any other domain’s CD table. The domain’s CD can directly
> be written into the master’s CD table.
>     * A domain attached with PASID is no different than one attached
> without PASID, attach_dev becomes attach_dev_with_pasid(0).
> 
> At a high-level:
>    1. The arm_smmu_domain would still own the arm_smmu_ctx_desc struct
> that describes that domain (translation table, etc)
>    2. Each arm_smmu_master would now own its own s1_cfg struct (and CD
> table). Attaching a domain to a device would write the CD into that
> device’s CD table instead of the previously shared CD table.
> 
> From an implementation POV there’s a few other changes and
> book-keeping that become required to handle edge-cases (e.g. We need
> to find all the CD entries that a domain is written to when the SVA
> driver tries to update a domain’s ASID value). Right now I’m more
> concerned about whether this idea is sane at a design level.
> 
> As a first order consequence, when multiple devices share a domain:
>     1. We’ll use more memory than we would have before.

I wonder if we could save some memory by reducing the allocation size for
single-entry context tables: it looks like dma_direct_alloc() gives us a
full page at the moment even though we only need 64 bytes per CD
(and S1ContextPtr alignment is 64B).

>     2. The SMMU will perform dma to distinct CD tables to find the
> page table; however the page table itself would still be shared.

Yes, I'd expect this to be negligible since an SMMU would cache the CD

> 
> Is that acceptable considering some users might not need the
> set_dev_pasid support this is geared towards?

That does sound like a nice cleanup. When I last looked at this years ago,
there were two cases that shared a CD table between devices:

(a) IOMMU groups, where devices cannot be isolated from each others by the
    IOMMU. Those are probably not going away anytime soon, but they aren't
    desirable. The normal case is one device per group.

(b) Devices assigned to the same VM without a viommu, using the same VFIO
    container. QEMU used stage-1 even though stage-2, which doesn't
    require a CD table, was available with VFIO_TYPE1_NESTING_IOMMU.

    I don't know what the plan is for IOMMUFD, maybe using stage-2 would
    be the right direction for new users.

For anything else I think we're already allocating separate smmu_domains
for each endpoint, each with their own CD table.

Thanks,
Jean

> Are there other consequences we've overlooked?
> 
> Thanks,
> Michael
