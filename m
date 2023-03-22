Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192AD8BE2
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 14:42:43 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id p34so6685524wms.3
        for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679496162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iclVlj0uRLLGWQO8Ig3rbocnokNbdehKEN39LMvr+XM=;
        b=JPC+mMlQpMmMFu647oTbAgAK5ChkEldXnrX7wvPXNL+boH7AjnOjmYClon2Ppm+UoC
         P4p+AhTWyqeuAC4S2nxtZ8q0JP9fCLJB0i/8uJjRjyIm3oiFf+UgWrdEgziEfPQOcgix
         6FvjIE4eNMJ/5Vd3SB7kSM1RG+8nqoghdDQIAhEtCdiFPVQQy/0BMz5EzwanEhmmTVFR
         3isrwC3inMonusGLefSMnljGDbFk9dchXoK+/WZEqgtelIxWhYANni8oK2vkGdLsTtZ1
         HK30Z2zlEAhJa6Q/QYA4RLNpCZSkbGiE/pPdPQl1VWg86HUq964HKSlcARI9xS+WWF2t
         yFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iclVlj0uRLLGWQO8Ig3rbocnokNbdehKEN39LMvr+XM=;
        b=EnBYfCQEW1TbgTncdO/JtfyyjRWoUW5FskA2UyhvIIASP++PChtW4YUkdaOJ0q3WeG
         ZbkKnbgstX0Ge7WGTHQnDQl6Y6MA0hd4cWF0mqzm7xaxo8jz3abzXVQMFV20IcAHlb7+
         eQnohCuwAgCkdGNP4bwMuDKwgQchWdeWyNOjxe8bXE6diI3NPxGYQzo19RrQemAqUhBB
         dCPQQI21Rq6Fu9EmuW65NYqQdYJv7ewiCMdn9GmNMAPdp0op0Z6H00u3zuKfKTExixuG
         qCE33DNUwpVfz6/MRVVJJtSisfsdJmLdI2exCG2Z1PS4z3gGkfNBYMVRgsqgTzkOLeL6
         SL8Q==
X-Gm-Message-State: AO0yUKX+LePOd4DzhUD6LY4yfswuowX9rbj6qngxyM8SP+4b2ePRUmSd
	zFJ0yXe961j0pacSzw7flrdL/w==
X-Google-Smtp-Source: AK7set+p+EwEu4H95hMdMAkUccdUvP0yEcTcBuLOgej4nfKPvES1tHXFSJqJv7OK63z4+i5uy57gJA==
X-Received: by 2002:a7b:cb91:0:b0:3eb:3f2d:f237 with SMTP id m17-20020a7bcb91000000b003eb3f2df237mr5392769wmi.6.1679496162280;
        Wed, 22 Mar 2023 07:42:42 -0700 (PDT)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003ed2987690dsm16905891wmr.26.2023.03.22.07.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:42:41 -0700 (PDT)
Date: Wed, 22 Mar 2023 14:42:43 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, dbrazdil@google.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 39/45] iommu/arm-smmu-v3-kvm: Initialize page table
 configuration
Message-ID: <20230322144243.GD594394@myrica>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-40-jean-philippe@linaro.org>
 <ZBrXNjOiqHJAxLzw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBrXNjOiqHJAxLzw@google.com>

Hi Mostafa,

On Wed, Mar 22, 2023 at 10:23:50AM +0000, Mostafa Saleh wrote:
> > +	/*
> > +	 * Stage-1 should be easy to support, though we do need to allocate a
> > +	 * context descriptor table.
> > +	 */
> > +	cfg = (struct io_pgtable_cfg) {
> > +		.fmt = ARM_64_LPAE_S2,
> > +		.pgsize_bitmap = smmu->pgsize_bitmap,
> > +		.ias = smmu->ias,
> > +		.oas = smmu->oas,
> > +		.coherent_walk = smmu->features & ARM_SMMU_FEAT_COHERENCY,
> > +	};
> > +
> > +	/*
> > +	 * Choose the page and address size. Compute the PGD size and number of
> > +	 * levels as well, so we know how much memory to pre-allocate.

(I also need to fix that comment, we're not getting the number of levels anymore)

> > +	 */
> > +	ret = io_pgtable_configure(&cfg, &size);
> size variable is overwritten here with pgd size, while used later on
> the assumption it still contains the SMMU MMIO size.
> This looks like it is not intended?

No it's a bug, thanks for spotting it. I'll try to update the pkvm/smmu
branch today with the other issues you reported

Thanks,
Jean

