Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62FC20E03B
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044013; cv=none; b=n5BhPn0c98f73v6sDyzBGSLpxzEg7pR8OCCpzZU59LvXWO7GXjuSzqketz6YFpgNQAJJU/0uLdThKX8RYWIlgBpfuc0wY7uJ5CnhFfODSRssuV0InLtRevhYxwSHxAx8x4nb+fVxgMzb3fcRweC9VTj+SWWU+MYe/6wFsxIX5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044013; c=relaxed/simple;
	bh=xekbj8Um5XwrEOGdzENZPa2iQeQhDeMvkZT0NVb5BK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFQZveSpZQSa3lo2GNFCanl9OYxBIxYo/HRmvFpmat4DxTy+HC0FD69j/1oRB70JL5Mm7suPPh2Jak3jIuDbGy4NLeeAcq9VJs4W5VR+RxOZizMFtc8WOBvXAGCwtgeJ3Q9WOcqgZdKPik8wCMhqmbnUXZ6Eni87Xb5/00B02FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ypj7rpBV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ypj7rpBV"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c592764e24so501352185a.0
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744044011; x=1744648811; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVaiHAMacLy0yHf6meYzZ4WkOGggIQHdshTAyck4dh4=;
        b=Ypj7rpBVysPz5D0/qyygYpHhL6/JhVcLMka0qhmOPmui2HhhnEWmKdHWA7ArQiNv8P
         JAGnsvG1lDjPKMbopie7s5y8nMdGDq5NG6InZxAPBHmeTazZYDJluj9VTrjZeMm10LYh
         Tr7NhS+kJO6xQuAY/igAmS+eiRDIbzEqHcGpRE7lKCWk2JiEXQ91RLRn3HXkMQlLF5TZ
         zpVTZP1WkOOH5tzosls2A0wtsFVZur/vPYM/NEcQvb/04NwTHF/wAShmYHb9ChQLCp1X
         qNlk7fUv70lPC1uCyRy5mdPn3ViDmAUW6tCte5DZXMvbBdQDfltPq9pIQFyqYPoppkjR
         wJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044011; x=1744648811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVaiHAMacLy0yHf6meYzZ4WkOGggIQHdshTAyck4dh4=;
        b=VOvOzIreulIuwDbLk1jLwtBXolsewBfsdthwCaZ9h36/R945TyZt3N8scB4GXoikYq
         WRTkuB6KNNXBgmykP2qED1FeyukQ+mwwWpi+5qWyQTj221hRveaYeitoyv56/xOQ/jou
         Senrhkm+pPGYuwOw1gxR54KJ9J2tx03aXvGMlFJvGrA8ILrFhH7AgDLY3rWWLyB3Pw+W
         Ml2fVBY0CmSp3r2a/08RHgPaxPQAuxexABHRjCk/NI8uCROsuYE0fHp4tDvIZ+zYNQOZ
         P36ANe4mQphJE1Wwzit2khoj98dJqLS3HLbAqRttRz4ePo4f2B9nYZDTf2dmQJLAfCQA
         ryuA==
X-Forwarded-Encrypted: i=1; AJvYcCWLFYvrcbU602UPE1bOYgAIFsjgyC3FIFC9ekVKJpagu8NrtiORHnv9STtN19sGzKV2QEhV7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLWY1o3G+bNZtf1ybkG2DE+tBosGyYoEeAqcvkxO69r2aCPNaR
	hvgOzjaLLR6LG6cHl+hrX+8r4ZOEed3UTcX7nWj4x8+XpGFAOEr25ViKqNxQbYc=
X-Gm-Gg: ASbGncvnARjCI6pZKDSn648MlpdOws9/pSZvxKuGJmV8V6cTnqIszx4G6YAjUEVbhKT
	Je6mpmfKx1EYPNJzEn8tvPnE7jWE80Ic/eluUPfsDXCyyYpDexu3aUCdwgUjcQ/nHOXu6fdiq7E
	LgkbNLhdHhJyVWKHHqFckWyiOQECU/CirDps1PzYn7C/rB2GiZRazXNOpFoVnohItI1nWHI5PaX
	4/orMC4DVGaaga8z4V58WwwL58kxZ7hJMG7f0Fb7lgDuY5mJtqfWtut/1xF00awKiTm40RMktVD
	fN2/68P60iDAiFeroeQVIGDupjjJ1+AzWso+QHw/CaswLOVUGnokpMW46Fk6OBkUb9qnzrmSemj
	3Iuy2mOdwCRDx2WHiTGAHu1U=
X-Google-Smtp-Source: AGHT+IEFf/klcawRT/DLAKNVY/s1kWSMw+u/XuSys5u9G30IOfriJNNXl5A9JC2j6VoZritBscM43A==
X-Received: by 2002:a05:620a:25c8:b0:7c0:ad47:db3d with SMTP id af79cd13be357-7c7940ba2a0mr22422685a.21.1744044010744;
        Mon, 07 Apr 2025 09:40:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e96e870sm618914485a.60.2025.04.07.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:40:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u1pW5-00000007DRV-3Cjz;
	Mon, 07 Apr 2025 13:40:09 -0300
Date: Mon, 7 Apr 2025 13:40:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250407164009.GC1562048@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <yq5av7rt7mix.fsf@kernel.org>
 <20250401160340.GK186258@ziepe.ca>
 <yq5a4iz019oy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a4iz019oy.fsf@kernel.org>

On Mon, Apr 07, 2025 at 05:10:29PM +0530, Aneesh Kumar K.V wrote:
> I was trying to prototype this using kvmtool and I have run into some
> issues. First i needed the below change for vIOMMU alloc to work
> 
> modified   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4405,6 +4405,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
>  	if (FIELD_GET(IDR3_RIL, reg))
>  		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
> +	if (FIELD_GET(IDR3_FWB, reg))
> +		smmu->features |= ARM_SMMU_FEAT_S2FWB;
>  
>  	/* IDR5 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);

Oh wow, I don't know what happened there that the IDR3 got dropped
maybe a rebase mistake? It was in earlier versions of the patch at
least :\ Please send a formal patch!!

> Also current code don't allow a Stage 1 bypass, Stage2 translation when
> allocating HWPT.
>
> arm_vsmmu_alloc_domain_nested -> arm_smmu_validate_vste -> 
> 
> 	cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(arg->ste[0]));
> 	if (cfg != STRTAB_STE_0_CFG_ABORT && cfg != STRTAB_STE_0_CFG_BYPASS &&
> 	    cfg != STRTAB_STE_0_CFG_S1_TRANS)
> 		return -EIO;
> 
> This only allow a abort or bypass or stage1 translate/stage2 bypass config

The above is for the vSTE, the cfg is not copied as is to the host
STE. See how arm_smmu_make_nested_domain_ste() transforms it.

STRTAB_STE_0_CFG_ABORT blocks all DMA
STRTAB_STE_0_CFG_BYPASS "bypass" for the VM is S2 translation only
STRTAB_STE_0_CFG_S1_TRANS "s1 only" for the VM is S1 & S1 translation

> Also if we don't need stage1 table, what will
> iommufd_viommu_alloc_hwpt_nested() return?

A wrapper around whatever STE configuration that userspace requested
logically linked to the viommu.

Jason
