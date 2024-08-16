Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584C18FC83
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815149; cv=none; b=hoEMW/HEPBLxc5gmJCb4njZbyHorrvZHVaPK4z1/Iqe3MtlJfguiUbXo4/dSXz5Q/0o7PHSk+FMz71q6VwS298ggTJ53YwRGK+zexz2goiQ+CCfx4zgwUhLmNAq4JSahBnexzFo5Gp9KCSi1/1IRkUOSMiAMFkUm9OOdc7kzC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815149; c=relaxed/simple;
	bh=x3S5s+Hej4DQldTEO6rhmuDuDxXeRxvdU3Zwg4JhmwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc4zJPLBs0CSRfb0SPHOW0B8fOu6JMwvVdOl7mp22C845897OFuiQknkGBjhuw4AGqK8hUzbUw03RpH2J5PcqXU1jgiV0cjCwECW5MGUN/maJMKMdNGgbqkGBp20zPo+C5WgFNKQasLZH4dC8MwHQ2KJZ+Um+Nb0t+TyS22x64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l0WLC0YH; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l0WLC0YH"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7ad1ec3aso7213136d6.0
        for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723815147; x=1724419947; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WLdyyDxuoCEu/ofqE3qKzxzdPAofyeH2iLCwX0g+TKk=;
        b=l0WLC0YHDRfPaaRNJa0txYeg6gWsj5UYN+9LW3r8cQL7KfolprZNFUgJ+ZZE+G1GxE
         YwQ5Wd/gf3CofRnvTSvqJRZ+mA1GNeL5N5895eLvP3Z6YaGYmQBMlYckQ2dn/1Hd256l
         fvtQQaRDFk2sJnaHZy4fHBaTT5L80LWlBwnqXofi0MXzlPXXZzhUQ7WIAqFBBMG5HhgW
         Z6IhhHjVy7+pPnGS+5WtC/nGuUmmtFH+mGTSt/etT0kiygK2o49f2wsnbExnCLR9kV5i
         G82UWkkyC6n2/StbDXYhmw58mw71sGkbLv+qpKwB8FUTIly25ipe2tWc3AzTaK8wfvr9
         OagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815147; x=1724419947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLdyyDxuoCEu/ofqE3qKzxzdPAofyeH2iLCwX0g+TKk=;
        b=VH3Kz9h+xeW8zqPjJWiE1qc1N8TddlxKOyeAHR2ZevQ/EemcMDqJtFKIytE2SEB0Ue
         0hJpO/kHTfLa6jcFt4VspCjTXZ+GAjF6V42Xzfebq3D8RRZ+6LcpwFET0UGASt1dcVkV
         N5uJO0YwvN849YSVSSiCCudn2wkp7RI5GZYxG/VAXk89aKwuZT/+dLwc6UcstAtl12XG
         lyXNyaGbedqgjjLGHpLJoyDeJIsjwimU1UDy4h+rLlwLInfQyh7jaekivNKo+VpWeF3q
         MEsAt/aX5s2WUwin/jvcUVyL41CNTiajJX5RccJcJEAiEf+Mt+sBoFYyt6L3gME1piiU
         RwTg==
X-Forwarded-Encrypted: i=1; AJvYcCU1gra8mjhf27nKjz1j+nOm4Z7uFmVWkcV1qDpidySpqPMve6RysgYctAGd0Jkg3oDRfkKcFt2IxT6ojNpLgY7hTHABeWw=
X-Gm-Message-State: AOJu0YxRaoVzWPgq9GoE36W4C4hL/wW7iO38LKwHb/E2jkM6g2iL/uQe
	YCY2FtJ181sOzGcTalgfSCX5bwukGftFnMv/hdyTPXXm116hpfDWR2EoWEoV/BY=
X-Google-Smtp-Source: AGHT+IFSYD7XIUdE2zz0q7OwzKKppto9XaQU9IEejkC+twRGET75J3c2JhhzjEgdxqdQt2xI7LB8Qg==
X-Received: by 2002:a05:6214:3f8a:b0:6bf:7aa3:92dd with SMTP id 6a1803df08f44-6bf7cd80e7cmr35004036d6.9.1723815146697;
        Fri, 16 Aug 2024 06:32:26 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0a5a6sm17351556d6.138.2024.08.16.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:32:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sex3H-009kK9-3S;
	Fri, 16 Aug 2024 10:31:35 -0300
Date: Fri, 16 Aug 2024 10:31:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240816133135.GP3468552@ziepe.ca>
References: <20240816125901.3773388-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816125901.3773388-1-smostafa@google.com>

On Fri, Aug 16, 2024 at 12:59:01PM +0000, Mostafa Saleh wrote:
> According to the spec (ARM IHI 0070 F.b), in
> "5.5 Fault configuration (A, R, S bits)":
>     A STE with stage 2 translation enabled and STE.S2S == 0 is
>     considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
> 
> Also described in the pseudocode “SteIllegal()”
>     if STE.Config == '11x' then
>         [..]
>         if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>             // stall_model forcing stall, but S2S == 0
>             return TRUE;
> 
> Which means, S2S must be set when stall model is
> "ARM_SMMU_FEAT_STALL_FORCE", but at the moment the driver ignores that.
> 
> Although, the driver can do the minimum and only set S2S for
> “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
> behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
> master has requested stalls.
> 
> Also, since S2 stalls are enabled now, report them to the IOMMU layer
> and for VFIO devices it will fail anyway as VFIO doesn’t register an
> iopf handler.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> 
> ---
> v3:
> - Set S2S for s2 and not s1 domain
> - Ignore ats check
> 
> v2:
> - Fix index of the STE
> - Fix conflict with ATS
> - Squash the 2 patches and drop enable_nesting
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
