Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8771A3BB9
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568496; cv=none; b=TzCtm6ibnpoMIw0xh31gaQjfol81EdCDb1amQctYrL2OReODWtaig1US/QDoV14HFm+YPrW6sDRy/+2s9iLneJTOkTDysO/9jNFihRj2nEJjyMiUnfVsrVANqH8Rl28ub/OvxpHPtHNY1NdpyoWVwVfH1YOeth1U9LpDvzdmsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568496; c=relaxed/simple;
	bh=qK7H9c8ScAhkcm7a+Iyl1+AnmCsHVRrU+XjzmjpeyjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK2IsX1CuaH9lvWfCXmKOGik9lDLVI39+UkT0SdyhB94x4fqwjxgJxqCguMcA9wq4/pI+sy1WpJzdvhnx+PaPznQCDzv7hqW2RnUTw8Fyt1WM8lk5EMrP3zxPfJFbaZ4coGDhguDIsGT5EO9rpcZ6RZyVstoljj/w5ymYiEpi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H1P9bHj9; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H1P9bHj9"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1dcc7bc05so379830485a.0
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723568493; x=1724173293; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zqcYDyfx63llFdcrlT+i8nPzWoVuQ+JI9Z24vWzRXhc=;
        b=H1P9bHj9FyMo/7h8SLL1ZE3NoHBGuhTbmtCYXCcdJxwJrYuBw70G1tjO4qcQRHDFHi
         ZZ82+4DSRtLurX8vTF6aB4WdUgaRPx8o8VHchB2GgrA3qc9YYSWbW2Ajme7bCKYvCVSu
         Yu0gsLffa+ur8uWGxEhLrsw4kmeSwqzQ8M9Q8+Yw+ACOkfCC33dpQ0VMsUKv4xvXw8G4
         Y/x5Vf1pSVuBSIAnG8Mt7IW7bdjlL1o9ZtoAnynj+2I9OFc5KhAFjqxsfLfXrtiBr4eL
         wMOtytLs4mSnTZZKWpP9AKuNC2yllms5dVuheHhBl2GYMuy11TdgPTkgCVek1zupI+UT
         pB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568493; x=1724173293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqcYDyfx63llFdcrlT+i8nPzWoVuQ+JI9Z24vWzRXhc=;
        b=osKqotWiceXgtHVETddNZl0dbNOdqS2UfUISxR3rzlVCukhfA8DLjQuagqqcZ1WIIJ
         jU9t00YBV5+0O8/Et07uXa5a7ZVjLiolDENEH5ZC8ag5v3k/rxyOdqEDhHavW9Ej6r0y
         iRpbt5W60W5wsIhqecboIerEejNbh/EVw0qNty9B6Q2owWUhXG6VW6ZWOuvAj0+eRdLn
         iR3NAMh/wCx4B0Dfg38Z7/NbLtbMlEyJvm/uaDLoyDyeYDXFx0TM7MfYsuf5YvuNWTvM
         kJWggYtX7UdCYM5EuUnW+mu4HZXYsfb1Ardfu4iuhXUj5wZe9SEo/VUz8RVFEYQKaL+h
         EvLA==
X-Forwarded-Encrypted: i=1; AJvYcCVf1a73YEEpu5ZGYtgyoabfLDur5HPVkYHmUHzEFDlJneknjV42i44F+NoejVYLE4W5A6T10UIFfjsqGKZqLj7/MmkduOQ=
X-Gm-Message-State: AOJu0Yy6JNzREid7SGAx/IzahDuPq2p4d4EmNvK4LzTNQyH1XBEV9ykl
	osSYBpoCGgxzpX5UxWH6YLRhvNeYCuE7QMGkbMpZQtXaBzVSiBrx1KG61ilqIt0=
X-Google-Smtp-Source: AGHT+IH9qH6c+uE5D7rTpZcL15JqZ+BNudgq7vqqsZepyxSSqNlsyYLjo+0/hLQXF6OoqZycQcsP+A==
X-Received: by 2002:a05:620a:40d5:b0:7a3:6dd9:efa6 with SMTP id af79cd13be357-7a4ee33e36fmr32897085a.33.1723568492820;
        Tue, 13 Aug 2024 10:01:32 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d7122bsm354386885a.40.2024.08.13.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:01:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sdutm-008ZLC-Ba;
	Tue, 13 Aug 2024 14:01:30 -0300
Date: Tue, 13 Aug 2024 14:01:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240813170130.GM1985367@ziepe.ca>
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812205255.97781-2-smostafa@google.com>

On Mon, Aug 12, 2024 at 08:52:54PM +0000, Mostafa Saleh wrote:
> S2S must be set when stall model is forced "ARM_SMMU_FEAT_STALL_FORCE".
> But at the moment the driver ignores that, instead of doing the minimum
> and only set S2S for “ARM_SMMU_FEAT_STALL_FORCE” we can just match what
> S1 does which also set it for “ARM_SMMU_FEAT_STALL” and the master
> has requested stalls.
> This makes the driver more consistent when running on different SMMU
> instances with different supported stages.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..8d573d9ca93c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1562,6 +1562,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>  		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
>  
> +	/* S2S is ignored if stage-2 exists but not enabled. */
> +	if (master->stall_enabled &&
> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> +		target->data[0] |= FIELD_PREP(STRTAB_STE_2_S2S, 1);

The style semes to be to just use

target->data[] |= STRTAB_xx

For single bit, not FIELD_PREP, even though it does work.

And as Robin noted it is data[2], the naming is supposed to make that
apparent with _2_ indicating the word.. But it is quite easy to make
this typo.

Jason
