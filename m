Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED89EC9
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 03:53:18 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3f38a9918d1so622871cf.1
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683777197; x=1686369197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEnFZ3b0l12xZ9FfK/rY8jy10P1V5kN/l6JT2CZl8wg=;
        b=eMsesteKW69BSCBVof2zFprojUKDL2/ZGa1ZFGQYSYWINh/VOYm8xRNe+k+zQ0+Sk3
         n/FQkyqbJoBEbyoiibKrIFZ83W55ZTK/FoBXyUsoEQPiZaFw+599Z5cO0uvJWUtIWbMq
         p+gplDuXblN3txvyhOcg3jZrtgCxu5OL8F3QzRGNBSjh4eY4xmFdyu7rDHLbrNNFey7h
         sNL2ze8LvfqLqHHp38TpLwaTWPGXcg+W92WG8nJeCWHjWC0Ub5XfoVrnsC7pJL5QwqEs
         2/VqEH4IQ/fbNqewJ5a8KqxZYptTlvaEj4ljj1bH4F5bFSLqkm1B1/i56MGE172yJLl7
         LN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683777197; x=1686369197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEnFZ3b0l12xZ9FfK/rY8jy10P1V5kN/l6JT2CZl8wg=;
        b=laug5duUXjwAhQm/+b5OuQYeydD59L7Ul9HwS7lQan+10fZwOdpcZ8tr49HGH5ltjk
         zAlCAmw3Vh/litQxqMywjFqaNqY/Bsrj3kTEYZ9n180oeOPE3OXQbTllqydlqwkP3dpD
         +r91X7XxxnNNqIltpB+eEku/tOS3UofwLOeMaX+LZTk9ppezpYorfyCHMd9ptC2n65SW
         mDXENx9FCwZKXxuL3/DIVZm0jHdig8I90gtM0NGz17OFFq4yqTN5CnVe654j976SS8ot
         7ZR9SgiS3o8BZk9yLC4pfBHruCEQWlP+1Tlj05JFy7eRJrk1mrDNypMQyJi3+odJK9Hx
         Qxpw==
X-Gm-Message-State: AC+VfDwvYOaP80LE9sD9ariyAEqo5uWIeFOAldIMxydSj7qQ4Mnu6FSL
	dqtk5RFpkE2/tBvRbtp1IsPLrIZy1NsY8trk1T8OPA==
X-Google-Smtp-Source: ACHHUZ4aXC7oLv7s1rlgGpxqbUu6FGKhMrhFOJ8UUisecFOJ7K52Sa/Z8JCdD18AUJQ8fXOEpXogV1OOTdEYMV7AX1w=
X-Received: by 2002:ac8:7d4a:0:b0:3ef:a55:7f39 with SMTP id
 h10-20020ac87d4a000000b003ef0a557f39mr269916qtb.12.1683777197246; Wed, 10 May
 2023 20:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com> <ZFwIWz8kBL+bti1m@nvidia.com>
In-Reply-To: <ZFwIWz8kBL+bti1m@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 11 May 2023 11:52:41 +0800
Message-ID: <CAKHBV26rbPXr6QUAx1MSbX58Zr4B7iLhojOgfn9c0tc1wKaP+w@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add PASID support to SMMUv3 unmanaged domains
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Logically when an iommu_domain is attached to a device or a PASID a
> STE or CD is generated from the iommu_domain's configuration but the
> iommu_domain doesn't "hold" it
>

Ah yes, I was using iommu domain and arm_smmu_domain interchangeably
here since there's a 1:1 mapping between the two. In the current
smmuv3 implementation, arm_smmu_domain holds the s1cfg structure which
represents the s1 portion of an STE.

> I always thought of this as sort of a pre-calculation of the STE, that
> gets cached in the iommu_domain? Not sure the pre-calculation is that
> valuable though..

I think we can consider the case where an iommu domain is attached to
multiple masters as a form of pre-calculation and resource sharing.
When attaching an iommu domain that has been attached before, its
arm_smmu_domain contains an already finalized STE configuration that
can be immediately written to the smmu. I don't think there's anything
specific to SVA about this behavior however, SVA will do the same
amount of work whether the cd table is owned by some special iommu
domain or by the arm_smmu_master (since we require that special iommu
domain be attached to the master and disallow detaching it).

> Ideally the iommu_domain should only hold a pointer to some table
top. Depending on the domain type this would be a S1 IOPTE table, S2
IOPTE table or a CD table. Plus the non-table domains like IDENTITY
and blocked.

Gotcha. So this patch series should be less aggressive, but is
probably still workable with the nested domain patch series:
1. For (stage 1) unmanaged/dma and sva domains, arm_smmu_domains
should hold a single CD. For the nested domain series, arm_smmu_domain
can alternatively hold an entire s1cfg.
2. arm_smmu_master should own an s1cfg (which holds a cdtable) that is
used by unmanaged/dma and sva domains attached to this master.
3. arm_smmu_master also holds a pointer to the live s1cfg, which may
either points to its owned s1cfg, or the nested domain's s1cfg, or
null (bypass or stage2)







> > path forward for set_dev_pasid support? Or could a uAPI that only
> > exposes a single CD instead of the entire STE be an appropriate fit for
> > the nesting use cases?
>
> The uAPI is to create an iommu_domain that holds a CD Table Top
> located in user memory, it cannot deviate from this. These kinds of
> iommu_domain's can only be pointed at by STEs.
>
> Again it doesnt really "hold" the STE, but we can compute a STE that
> points to the SD Table that it does hold.
>
> Other than this, it is good to take this project on, getting PASID
> support aligned with the new API is something that needs to be done
> here!
>
> Thanks,
> Jason
