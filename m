Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238323A1A36
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406296; cv=none; b=lzQ3rz4bRqf7tQBtM3PPyctekb1UW2+Zyd4nsp9y5YTGr8s2mUdFTN/Cd76nTgzmvcT5IlvZQPTwmt/T0kpEh5Gx5YtFL3FuQvwrv+L+7KdqsdMBPZ3cmmbuDddVz+Sfc5Vb7icyoIGpICs7ZMPAd2BqkI5MUAUapyHRg7DAE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406296; c=relaxed/simple;
	bh=ST+wzXgaA2HiUuF9iwjkXc/sOujd98rchHVrsybLf2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMKya/1pAnRmv4yrwZ+/zJCEjTsg0QCV/jvbtxmmGSsEUC64yV8XeMG7PyL0MexO6I1Oe7rSm8/SDsqepJT5JDhLPMa12NPlbyTG6axK7NfAw1qcuCk7Y/IJMvsV25MxMpPpn1uc+Grfo5Dz0wiXlrgtD+/qjyiUpFp3oiMwF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Bk8XQfK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Bk8XQfK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0d06cfa93so77635ad.1
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768406289; x=1769011089; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0On5mUa4Ad9udUf6v9yU0CLcZogBODduyNyvpvin/+A=;
        b=3Bk8XQfKnB2mG83jDfOFN1ElOqjs2AoMLaw4DbRrWkEO9nnOSbOEWbOe3pP9WbFC+t
         1UWBUsW+w2iMBlD3OqXuYyHJSKvLJjMZktOUkyzCz+rWueaNnOot/ajUStBoq+ComG2X
         tqW3f5DVqpMjbPiqpb0SKAAZVeiFkfOykoyYQYVtsbLYqXLlIzPTDXvPY+23904KbaiU
         3PNJY24AVUJt678SpTLDMqBThDJvFl5V0inLt81cmOHWrGm5Wc68/kBaVhxmwlwn4tnN
         QfGB6laR5AWnQpRqgylXz3onx1Qj1RRSwYcD+d+jWkkhylG1odXrXyXH4nV02M8SebhG
         hlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406289; x=1769011089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0On5mUa4Ad9udUf6v9yU0CLcZogBODduyNyvpvin/+A=;
        b=U04ciNXBn99qJcO64dDa+SCeE/9jmjDW56OEEBsAgU0lYltUO6BbjrNiutk8dfpGu0
         slrczzE/U4qS5Vs96kVyssatGMr0rsfbabbTG1hNoOpLqpULgehex65cK5fPbV7uOtdR
         Bjen65pVfMGbLC/qcSIlX6Avl0Hyw9XsuMFDQCZjVe3o1DEnK9iRKR9xeM8M4OX9P7jy
         a6qC4jgeFiKiTf5hgtuEfO+JRKtLb3F87aZA6vKXHepTSVxXZWbfPcrm2edqqbZkwVaf
         p4SMrOON/z8dAR15qsYwJ5cRQDmfLJqBnpGKodEekVxDGSK0zZu+LLf9thDAcC/cq/q4
         1uAg==
X-Forwarded-Encrypted: i=1; AJvYcCXN9cTVFYcVRBgWgiSCWZ7tM12x+EY+X7VWRESDvLw/Cokn8Ac+m86haTZiOzvii0D6wP1TSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd/V/uP1frJI+ifCq7iFBX5Sz2SMAi1XXns5Tfn2Oq1VgCh/+F
	u0PRy/6wMycJa4jhySJvbVaa+8ozvf/9otl5oS5FVsKIybjKzbykRORATNzinrbQOw==
X-Gm-Gg: AY/fxX4pwOYLLNTuSfjjGgh+/IPre4Y1Uo48dPtUTORxPMOT2pXDEYiyg07xXNsYoIw
	7D2g915J4P2az+xwPSVi7E3xlIwq5Q5ysLHpIOd/xCkSMfaLGpFwh++a2W5Fy7C9hrPopE8+59e
	ouiIXXbNTLfXEP2B3t6npUYIfh4c5BwXjzpgM93R8ep6ZGYFweK7M7jNBPwSFBxLxxFgK12j2fZ
	vF0nkIBgflXX/t04EzIgRWlV7Yb8hZ2NEbadzVr+Ta50Lbedo3zYmOHVn1d+oretF3jNtB3JN6O
	rh9gb2PsBBe/C8xI6R8HyB1JzScm5r10O4hMyE/r5tbYX6OCaPcrbMHG1YZBFmDogBWXad/AsGx
	5H6dAnxqpAukwcStvnQfHUzjP8DrIfEAYGsFN4IPZq5Tcg9yVOJXX/qIIql/sUBd4VmLS7bxfum
	/py2lcagngj/jmttbENsOv9qkD/Iu4hw0MLFXvCzi0HoA6+oyp
X-Received: by 2002:a17:903:238b:b0:2a1:3cdc:7720 with SMTP id d9443c01a7336-2a59aa609bemr2426085ad.21.1768406288994;
        Wed, 14 Jan 2026 07:58:08 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22922269a12.32.2026.01.14.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:58:08 -0800 (PST)
Date: Wed, 14 Jan 2026 15:58:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v6 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when
 computing the update sequence
Message-ID: <aWe9C8wwfszvqxR6@google.com>
References: <cover.1768248467.git.nicolinc@nvidia.com>
 <b8055e0f0f1b4473db2583586350b4f7aa8f3b4c.1768248467.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8055e0f0f1b4473db2583586350b4f7aa8f3b4c.1768248467.git.nicolinc@nvidia.com>

On Mon, Jan 12, 2026 at 12:20:16PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> If a VM wants to toggle EATS off at the same time as changing the CFG, the
> hypervisor will see EATS change to 0 and insert a V=0 breaking update into
> the STE even though the VM did not ask for that.
> 
> In bare metal, EATS is ignored by CFG=ABORT/BYPASS, which is why this does
> not cause a problem until we have nested where CFG is always a variation of
> S2 trans that does use EATS.
> 
> Relax the rules for EATS sequencing, we don't need it to be exact because
> the enclosing code will always disable ATS at the PCI device if we are
> changing EATS. This ensures there are no ATS transactions that can race
> with an EATS change so we don't need to carefully sequence these bits.
> 
> Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ccd6357fa5a8..58008fe94ab3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1096,6 +1096,24 @@ void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
>  	 *  fault records even when MEV == 0.
>  	 */
>  	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> +
> +	/*
> +	 * When a STE comes to change EATS the sequencing code in the attach
> +	 * logic already will have the PCI cap for ATS disabled. Thus at this
> +	 * moment we can expect that the device will not generate ATS queries
> +	 * and so we don't care about the sequencing of EATS. The purpose of
> +	 * EATS is to protect the system from hostile untrusted devices that
> +	 * issue ATS when the PCI config space is disabled. However, if EATS
> +	 * is being changed then we already must be trusting the device since
> +	 * the EATS security block is being disabled.
> +	 *
> +	 *  Note: Since we moved the EATS update to the first phase, changing
> +	 *  S2S and EATS might transiently set S2S=1 and EATS=1, resulting in
> +	 *  a bad STE. See "5.2 Stream Table Entry". In such a case, we can't
> +	 *  do a hitless update.
> +	 */
> +	if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
> +		safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);

I understand what we're trying to do here but isn't this implicitly
saying it is safe to transition hitlessly to any non-zero EATS value,
including S1CHK or RSVD. S1CHK might have other config dependencies?

>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
>  

Thanks,
Praan
