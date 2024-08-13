Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205719B59C
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556411; cv=none; b=kj1LjxI8gv7ghBLqZk6PyylY45+QaYjO04HW68GAxUSKFLTzDKV75RpkE4eTFJPG/zpcUDwXuAcZS06Few8lGx3KxpDUOz+OzsdId9/58Y+HPHeNUjcAYro8pCK4SVcdat9rEz+ljy2hgQBfayz8FmHD0nxH2CXHS2PCDfAP1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556411; c=relaxed/simple;
	bh=858VKP5wdxus3iAQughoZMO3MbRsGJImJ8GB4BVPZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpjrdveTF5da9OcR89af0y9jI154bH+mVi8O0VZxNeXUH4GDP833npXddTUd3350FuJaz/Qgm2+v40zjqAsJT/hjuj36SjH1f34OW0NimKeiOCGhJ0L43o8u2RRsmCIkLrNu95Y27Fp3gS1s7p2tZ6prAJM4FeUe68USoh4jeUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHhCCKGt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHhCCKGt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427fc9834deso32555e9.0
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723556408; x=1724161208; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VwMV+d/24nmdzqweqrHjOWK1WqG9SPFvkXHNO/cskp8=;
        b=GHhCCKGtPCnux1obXa8YT6iNl5rZT6yS84L1G0YxZMFUWRBQleMe+Uk/hhHRm2fQrX
         8yP184yXoLMZtGZ2ytv0Kqf+9xfHeTlHA+DjJLW+PEbdnaQvB0QuaZqz7H1W8cP/Folw
         1a7OfnIgvByt0m7On6vwWmd9VOqoce7PQIsNhoCljPnivsFjQ67Ewk/tdIlvSMgdL96n
         RZFdebk1fi65SW9OzcQW4Plt9JESTJJxLVN6gyf9V72abKmPWTpANqlbp/9CdLxtMHLm
         OT2UBwoXQkyjqO0aNeYwe7bpAwGnrsoNgSjcW8QFuJsb1edivQIb65qIVoqjCcQGuCfJ
         fdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556408; x=1724161208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwMV+d/24nmdzqweqrHjOWK1WqG9SPFvkXHNO/cskp8=;
        b=vo8VF+LANLXPAhknbDAIxZiMUVD3+qLjjEDRvvuHPrpvhuIwvfcRTKcKZBsOnGZlcJ
         jVhQMjL0Oj+vY8XT325Qzvr1sy4QSnEvmCMyBvXzMLwvygdL8zu3LB31NINIly905n2k
         GEBpvsKlkyJhG+dJ+SwAyB9bXr0zoA2CwemquQoc/2fnl2P9F60L7ebSuh4L7pmPfiuh
         hWrK7ymxvNQv8xAOLf0p9NH38wR9i7jT76QlAEi7vG4DirYcCHZdu/BUVb9hkkvCqi9I
         ca1KD17nblxL9bk595cIHXLbKWHhSMhKNRLqJJnqoGxSN0Q6ChO/t42Y384fQuVhz+EM
         8G7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX90Pw4/UINUklFWt20BW39iIdNDXh5es3vY7SvRXu2wTKn7JgEjFf8Md5TBKnAsNFLnkvO1qBIUaeAplfysJrju4IoiMQ=
X-Gm-Message-State: AOJu0Yxa64WwvAB5pfQWOxrvogrmUI+dsQT+z3wQZbu8UeaFeLKe34pC
	ZDpH8Eq2sE9v1GdNt7rlwSxzEss/wnOtU2+vyOMvdDHCxOW2O2OIZfpxEMYqbA==
X-Google-Smtp-Source: AGHT+IGzihwEYjxxVx7+f1NJuiQnxOAZ92M9WPFwek7xX6OzFxHriBfJrZekTSS6jeVCS17HOiYQmA==
X-Received: by 2002:a05:600c:1d95:b0:426:8ee5:3e9c with SMTP id 5b1f17b1804b1-429d715b507mr568645e9.6.1723556407703;
        Tue, 13 Aug 2024 06:40:07 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd2bb4sm10455272f8f.91.2024.08.13.06.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:40:07 -0700 (PDT)
Date: Tue, 13 Aug 2024 13:40:03 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <ZrtiM3J4jEFOZ1y5@google.com>
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-2-smostafa@google.com>
 <fc80ffde-2d19-4bd6-9590-a80049302ad7@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc80ffde-2d19-4bd6-9590-a80049302ad7@arm.com>

Hi Robin,

On Tue, Aug 13, 2024 at 12:46:26PM +0100, Robin Murphy wrote:
> On 12/08/2024 9:52 pm, Mostafa Saleh wrote:
> > S2S must be set when stall model is forced "ARM_SMMU_FEAT_STALL_FORCE".
> > But at the moment the driver ignores that, instead of doing the minimum
> > and only set S2S for “ARM_SMMU_FEAT_STALL_FORCE” we can just match what
> 
> This was highly confusing, until the 3rd reading when I realised that maybe
> "instead of..." does not in fact belong to the description of the current
> behaviour, and it does start making sense if you swap the previous comma and
> full stop with each other.

Will do, I will also reword it to make it more clear.

> 
> > S1 does which also set it for “ARM_SMMU_FEAT_STALL” and the master
> > has requested stalls.
> > This makes the driver more consistent when running on different SMMU
> > instances with different supported stages.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index a31460f9f3d4..8d573d9ca93c 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1562,6 +1562,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> >   		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> >   		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
> > +	/* S2S is ignored if stage-2 exists but not enabled. */
> > +	if (master->stall_enabled &&
> > +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> > +		target->data[0] |= FIELD_PREP(STRTAB_STE_2_S2S, 1);
> 
> In the middle of the ASID?

Agh, of course it should be [2], sorry about that; it was late when I
wrote the patch :)

I will send a v2 with the fix.

Thanks,
Mostafa
> 
> Thanks,
> Robin.
> 
> > +
> >   	target->data[1] = cpu_to_le64(
> >   		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
> >   		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 14bca41a981b..0dc7ad43c64c 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -267,6 +267,7 @@ struct arm_smmu_ste {
> >   #define STRTAB_STE_2_S2AA64		(1UL << 51)
> >   #define STRTAB_STE_2_S2ENDI		(1UL << 52)
> >   #define STRTAB_STE_2_S2PTW		(1UL << 54)
> > +#define STRTAB_STE_2_S2S		(1UL << 57)
> >   #define STRTAB_STE_2_S2R		(1UL << 58)
> >   #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
