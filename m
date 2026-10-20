Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494863;
	b=gSdkCnsfGF/NV4JhW+kMz1K9SULBalATmnJiMjeSmxOwZ4pcjo22HGv/bujbYFaPVVtr
	 WJ0hpaMgFEt4H0vFMgGBuBZ0z/rY4DBw4MpYXMQGol56T9ZweuQq8BhI9p6sBFsP0uNpk
	 r13LnuGtkSc0a1W3XKvdDi+YmKsMz3Lb00URNvlRk88H9O349pJTMdAiAfP67/mKbx/Nr
	 nkA0FdVx2btjX6Lm12beuIE/cEd0Ntc2Dv4EXh+M7k6NQGZV3vwEYah6EvVA2wfDEkBmN
	 G8MTGQYOlJKB28aHJw00dcqPdopkr0ibmFbMVGvRMtoYpRJ2z0DC8ONRlCQcXiMYwaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Tw0/GmkNPakQA0/XiF/9z/+IJnZL/wHZ7HqV7JkBHeU=;
	b=tvPbaFyct+rZ39+Z7RkL9r2MNrRnt+EzWumuKvhW9oUJTR1IrKgoCrzP0UlqMFmMKkYq
	 IF1Dt8UWXj5UjimW7HjzftbvsplDtBKcSu5bdc2wf9HWU7RAKTwuY8ck7ITESvi8z0I7d
	 6NWoG9hB74TMHkTLEseE8SMFVylNTexxSuz9zPc37JeJpVUCGRWjxTV7Sm9bRcaWQvHas
	 5jEl1lK5gQPI45s7EsExgajIV0g8daR9twNw6dh1UW7vJZCpfHPg/30yyxCM3m3YLnW//
	 i7QT2MMZqdoooGNTDhz23nANC1drsnyIAzUPZwFD5cffsEttKGoctcbyNiYCgCiberg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U0MZIYGh;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2C606A32C
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 11:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7A2C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U0MZIYGh
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1de789b63so47515e9.0
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792494861; x=1793099661; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tw0/GmkNPakQA0/XiF/9z/+IJnZL/wHZ7HqV7JkBHeU=;
        b=U0MZIYGhqueVIRXxnZCtAmVICrB13bCn7ULkTBle1/LkqA6vGf8kIWugSfpOD/BS4x
         wOWPPsHSfAw6Bw2XrmCJfFF5mhrl+EsCLV/CCtT+eEOGi7etppp1BZn8iRm3usv3VeHP
         ICcyuDuAZsaCVdYbpk2HGtKeT7i3AarhZqrcVaTkvBPu3m0/9EvN7rkYwI+14ddqsEFl
         ne9/pjl8ftEWT64K7Eih/aGZfntV9SGHEghKqrnFN3MYlqejmlpE4ohT18gkRBa1lnA7
         ZfQYos8BD6qgzfZuBNa35KJRPVEnmWinJJi5IpiMrD75509NV/vrOnoy1VEdjRzG5EwZ
         1HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494861; x=1793099661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tw0/GmkNPakQA0/XiF/9z/+IJnZL/wHZ7HqV7JkBHeU=;
        b=Z6yvJDQhvOkD0dE1cp1hcDdi5CyIJCwBRXcUCBPyIRSXmVvx/PeT0zLQaLRDac3zkM
         cFu9QZT5ES68rPyaNJvjQWi2dLaUtRGiLyr2ZzVfvvHiqaCsSdub1b6KAXkVJkCOEAva
         ZlXTR/QPVNWWx1K51KsJjoBIf11CbzsLKjTyEsp6FKLDIgJ1HupHvOgNXAquCV0jdxAO
         78xhIJT1A5SXyQsv0TCovclhyhrsXUIr6VN0fu7v1uFNUa3pYq2o39coGuW0BvrEYyhC
         CNdLkbSBw97F5k6rsl5+gdWXMgWbvRoQ3+xWEsyN54PVAymtBXkWCMqaqE7TotMg+DZF
         dhCQ==
X-Forwarded-Encrypted: i=1; AKwUvBz24s2Nf0TYR7IyjUR4eivAGmPGKP2QFhk0l+GZi2fxq/has7R3Yx2iavnWcYnd/7oexKnrOQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLcdtZrCTgZo6Jug+hBMNEmEXGpwv+89jTHAC9Nk8o/eXJX7hSz
	Eec6KgPbXswz24ty53VI1TwX/qvugJYhb63W8oH4bDShLkZGZbO08qXV+cGwLV/afw==
X-Gm-Gg: AYBFou0vGFws4iHvz+ffm/dEGjdGTU8hwWaru77K8bgX9hlNKHekrlDVApDqIBiqa7q
	5iqLgDY7lvysIUA7zfFeN5uf443+2Eu3TMrouKKYJl/T3zBr5Tf2zDVxeZVNtwumyF0z8qgDGWt
	oCKywrhaOutRwX8Rn8QadYub9g7nADeHZvzc0S4FLT0sWs3BtTg+jpZf8DzY38VTtAQFPvEVBEH
	Wxj06CrqLZ5F+9oCho6Auf5aiPKNIYItKhbXUuEnxf5Fl0BSq/LbnNjHavM/KjUEQnjT6K5NdCW
	AVrgbWnahTSyIUP2x11yJBr5BZQkbc+uDHELAlTm65pxSt1C+Ys3Tdn5l+rNZp5aJOl7VzKQZNf
	hyGOyXY4FBMCfRLC/L89uziPgf3EkkLbhSYZHHtxqqUElJ8etM1F+JJ1AB0l56GiBY8wfrbaRKS
	UM7qrMcK0CHb9VZQgw20LqPLWncuw8oddrsRa8/5bRwrQrhHIAxYeBffHi9k1H1kOeblo/h/Ez0
	1tgpR/cra/U4TLRxSWApnxNI9ek+QFMvFkKO8btxA==
X-Received: by 2002:a7b:cc99:0:b0:4a1:83f5:44ed with SMTP id 5b1f17b1804b1-4a1f59efdabmr598905e9.16.1792494860455;
        Tue, 20 Oct 2026 04:14:20 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce33155fsm247590175e9.4.2026.10.20.04.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:14:19 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:14:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	praan@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
	Cristian Prundeanu <cpru@amazon.com>,
	Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 02/11] iommu/arm-smmu-v3: Make the ASID space per
 SMMU instance
Message-ID: <atdNCInkAepLyMow@google.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <e027296ac9db58fb7d69b1b4b5e4a2ed192dd401.1791226953.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e027296ac9db58fb7d69b1b4b5e4a2ed192dd401.1791226953.git.nicolinc@nvidia.com>

On Mon, Oct 05, 2026 at 12:30:45PM -0700, Nicolin Chen wrote:
> An ASID tags the TLB entries within one SMMU, so two instances can use the
> same ASID without ever aliasing each other. Yet the driver allocates them
> out of a single global xarray, which makes the instances share a space that
> the hardware keeps apart, and lets one instance exhaust the IDs of another.
> 
> That global space is a leftover from the BTM support that shared ASIDs with
> the CPU. Now ARM_SMMU_FEAT_BTM is never set, nothing looks a domain up by
> its ASID, and a domain is pinned to one SMMU at the attach.
> 
> Give each SMMU its own asid_map, mirroring the per-SMMU vmid_map, and clean
> it up with devres, so that both of the ID maps get the same lifetime as the
> SMMU device structure that holds them. An upcoming change will need this,
> to reserve the crashed kernel's in-use ASIDs in the new map during a kdump
> kernel's stream table adoption.
> 
> This also eases the BTM work that Jason's working on:
> https://lore.kernel.org/linux-iommu/20261004162219.GA4064@nvidia.com/
> 
> Note that arm_smmu_asid_lock stays global, as it serializes the STE and CD
> updates against any ASID change rather than guarding the map itself, which
> does its own locking. Giving each SMMU its own lock looks possible now, but
> that would touch every attach path and belongs to a separate change.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  2 +-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  6 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 18 +++++++++++++++---
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index bb048e08d613d..8f2c0b1cc4a8d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1003,6 +1003,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_MAX_VMIDS		(1 << 16)
>  	unsigned int			vmid_bits;
>  	struct ida			vmid_map;
> +	struct xarray			asid_map;
>  
>  	unsigned int			ssid_bits;
>  	unsigned int			sid_bits;
> @@ -1180,7 +1181,6 @@ to_smmu_nested_domain(struct iommu_domain *dom)
>  	return container_of(dom, struct arm_smmu_nested_domain, domain);
>  }
>  
> -extern struct xarray arm_smmu_asid_xa;
>  extern struct mutex arm_smmu_asid_lock;
>  
>  struct arm_smmu_domain *arm_smmu_domain_alloc(void);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index faeec656da9e7..489531e0027bd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -311,7 +311,7 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
>  	 * reused, and if there is a race then it just suffers harmless
>  	 * unnecessary invalidation.
>  	 */
> -	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> +	xa_erase(&smmu_domain->smmu->asid_map, smmu_domain->cd.asid);
>  
>  	/*
>  	 * Actual free is defered to the SRCU callback
> @@ -352,7 +352,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>  	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
>  	smmu_domain->smmu = smmu;
>  
> -	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
> +	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
>  		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
>  	if (ret)
>  		goto err_free;
> @@ -366,7 +366,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>  	return &smmu_domain->domain;
>  
>  err_asid:
> -	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> +	xa_erase(&smmu_domain->smmu->asid_map, smmu_domain->cd.asid);
>  err_free:
>  	arm_smmu_domain_free(smmu_domain);
>  	return ERR_PTR(ret);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 792627e1c790e..aeace4335abfe 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -90,7 +90,6 @@ struct arm_smmu_option_prop {
>  	const char *prop;
>  };
>  
> -DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
>  DEFINE_MUTEX(arm_smmu_asid_lock);
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
> @@ -3015,7 +3014,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		/* Prevent SVA from touching the CD while we're freeing it */
>  		mutex_lock(&arm_smmu_asid_lock);
> -		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> +		xa_erase(&smmu->asid_map, smmu_domain->cd.asid);
>  		mutex_unlock(&arm_smmu_asid_lock);
>  	} else {
>  		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
> @@ -3035,7 +3034,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
>  
>  	/* Prevent SVA from modifying the ASID until it is written to the CD */
>  	mutex_lock(&arm_smmu_asid_lock);
> -	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
> +	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
>  		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
>  	cd->asid	= (u16)asid;
>  	mutex_unlock(&arm_smmu_asid_lock);
> @@ -4741,6 +4740,13 @@ static void arm_smmu_destroy_vmid_map(void *data)
>  	ida_destroy(ida);
>  }
>  
> +static void arm_smmu_destroy_asid_map(void *data)
> +{
> +	struct xarray *xa = data;
> +
> +	xa_destroy(xa);
> +}
> +
>  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  {
>  	int ret;
> @@ -4848,6 +4854,12 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
>  	if (ret)
>  		return ret;
>  
> +	xa_init_flags(&smmu->asid_map, XA_FLAGS_ALLOC1);
> +	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_asid_map,
> +				       &smmu->asid_map);
> +	if (ret)
> +		return ret;
> +
>  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
>  		ret = arm_smmu_init_strtab_2lvl(smmu);
>  	else
> -- 
> 2.43.0
> 
