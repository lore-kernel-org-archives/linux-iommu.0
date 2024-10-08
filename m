Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82D3FB1B
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360703; cv=none; b=cu/OEzSlgJUfNwSLtcog8nVxyZ4jw1XuJQyalre7kIKK3osqXy7Dt2TMM5qXc+QPrq9jjDDZ4vo/HFr4UnTVE94stThUVDLR1Bu5NkProCZoa6qfakVxquHI1BTSYTJZwqU0dUVfVnN/3VNY289clObPNpjBwm3ysyrNQTkCX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360703; c=relaxed/simple;
	bh=xHUeZPjnyNfxgmZvay/uXpUvSXQlNZnyff8aXOYTIhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIXsbNw2OcJt4BpuHZfEOOKiMCde+Ov093DC5p0GfzRYXVNZ6XY4CHhAG2bWGBkXsvPSh8v1twK4Nz85OgRQMHwm7ETKefEXdzHg/Tn7kbAjvf9jZlBza38rsndNDpZyKYWRgs9B4V3WrGcgbv6wxI7J1AY2EBZoktmp6lmC7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXNVx+2t; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXNVx+2t"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b061b7299so96205ad.1
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728360701; x=1728965501; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt8hffJScv5jNjHoFtqD8thrv7v16Xwl3JO7k28wD2s=;
        b=iXNVx+2tPnXfvM6r4N1zTXVRYXaOmRmAgKI75EM0L36h1qWDtMWJ2F+/Mqrts/wOax
         NIQ1cbjMld9u6aLbKc8pT9djlzOixSqRemREsLrxS9gBjkaG0sCq9y+w7b/KFPcq7DtH
         u7HMS+r/fkeccpZi2S//yL83XoF66MZeeCh3Iukcl1QL9IcdwOr7PtKJdy2Xq2qCNv50
         mJfzuEJLCzcrF682hRcv8JUF1oBw1hh1ijz5+MemsBKdjfEVDazc0CRQoh7HNnNB359R
         ehXWDyNuNcvjsrC1rTku5GH4EwtGK2W6JAOeZ1lL9SnCNvrc5rzxaODXHQyr0enOHu4W
         x4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360701; x=1728965501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt8hffJScv5jNjHoFtqD8thrv7v16Xwl3JO7k28wD2s=;
        b=I0gRryITPi173EwyD9i4KXo3qB9APtxDt370NW0S3KS9t4gNMv41BXa6DANb4oLrxE
         E/HhRHuP0YFaNNLv8HQ/26tJYhiEMUss7kyWkyT5y+aBIwjkOt+vLnXEseQaCOrbtPgu
         iJSPtyTWsoRygB+NhsepR2n8U6+K3MVXUhUuYaFks/wz8d5fW56aoJfi7mlRpWjXfZ2o
         IfHpzEoPjvrQYypNx6A3FTNsklZz4xyie5g4AkJ/RofarM++e1pvb1Ppwja5yEi73uJw
         j5R8Ufhi1tUzR2hiPJt1jANf5oR6cccROzzq75t/PERYFZMV0w0NJ+8/OH0nSQeslwX1
         C1vg==
X-Forwarded-Encrypted: i=1; AJvYcCUW4fTO0xGdr8yBrIIz4h9/6wzEtBODMSUtY9WbLnSWjkdVK91wyNvx1LaTJLFwG4eY8+waOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv9vMtVxFNK1XZgMv4niA/PWpSBxtExG8H2ehZMSABTa7gBIlj
	SaY1nTL/ehonka8P0EwP4PoZs12tAvntEWtcfc8cKeHPaLQatRBwALkSsj4UQg==
X-Google-Smtp-Source: AGHT+IEWOcc+/xlAlRTOTLbj2HgNvO32Gnzd5pqkk7sJNk0Hnf6Q819vTTIrdHPhT4iJJ/Aj8kG2XA==
X-Received: by 2002:a17:902:d50b:b0:20b:8776:4901 with SMTP id d9443c01a7336-20c5352f6b0mr1131265ad.27.1728360700548;
        Mon, 07 Oct 2024 21:11:40 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4665dsm5211374b3a.116.2024.10.07.21.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 21:11:40 -0700 (PDT)
Date: Tue, 8 Oct 2024 04:11:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jean-philippe@linaro.org, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix overflow with sid_bits when
 computing level1 table index
Message-ID: <ZwSw9OK5vMKgY6Q8@google.com>
References: <20241008031831.1254130-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008031831.1254130-1-aneesh.kumar@kernel.org>

On Tue, Oct 08, 2024 at 08:48:31AM +0530, Aneesh Kumar K.V (Arm) wrote:

Hi Aneesh,

> As per the spec, max bits of StreamID can be a value between 0 - 32
> inclusive. With the FVP model, SMMU_IDR1.SID_SIZE returns value 32 which
> results in arm_smmu_init_strtab_2lvl computing the last_sid_idx wrongly.
> This caused a failure in ahci disk initialization with the FVP model as
> shown below.
> 
> [    7.147067] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
> [    7.147177] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [    7.458320] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   17.643140] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
> [   17.643251] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   17.643359] ata1: limiting SATA link speed to 3.0 Gbps
> [   17.954651] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 320)
> [   48.107079] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
> [   48.107190] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> 
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Will Deacon <will@kernel.org>
> Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 737c5b882355..01a2faee04bc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>  	u32 l1size;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>  	unsigned int last_sid_idx =
> -		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> +		arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);

There's another patch [1] from Yang Shi for this discussion already.
Daniel had another similar patch [2] which was converged with [1].
>  
>  	/* Calculate the L1 size, capped to the SIDSIZE. */
>  	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
> -- 
> 2.34.1
> 
>

[1]
 https://lore.kernel.org/linux-arm-kernel/20241001180346.1485194-1-yang@os.amperecomputing.com/

[2]
 https://lore.kernel.org/all/fd04bbc8-8ebb-4091-b56d-32072587fa99@os.amperecomputing.com/T/

Thanks,
Pranjal
