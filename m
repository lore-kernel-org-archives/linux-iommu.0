Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9701B5808
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650715; cv=none; b=nm1tSpv7EHMuhU1ND4UN92e6P8YrLaQUCN8kkEH7EHi5slagQ/7tsHAMwnWZiaK82aCH4tXRpmixzcsQlkWBbOyR8b75qcTYMVVGWC6WITCpRw8GMa7unt7e8X/wdHoRJy3GLvRgpTlddhZo5RBk0jl+z3txvRX/2rhlgxOS0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650715; c=relaxed/simple;
	bh=8LF8erteSYXqEQ+sv6uPPqfX6ExaNFAVtl6+SQyrxXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEkYVp5uvpTKgiHFYm7D1f5lvDzin3IkPbPPTRuPHKihrEfR1SP0eMPDRdDzoOEGGHw4SAe7xb1n1NVUTqJHhpFIGLInlonvGPRsVUVi/QW1qlTmF+GPggAgF0SZIG4BAMeb9VCCDMcTie7+B26qwjOsRgHDztJ1vEVtOn3vftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HxQ9wdBX; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HxQ9wdBX"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f8b5e5671bso14108e0c.0
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723650713; x=1724255513; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T1s0TehfVbhq0HZGHpkiDt/kqWMCBY7b6/k82SpXX8k=;
        b=HxQ9wdBXqe7P8uyr024MWPer0q+LfNooByVjAU8k8CyEKvqsO/AgYL+z9MrorbVSIR
         pcGprnUrAy3XrJsY8+//rKK/lG0Y1hlZIrvI1tRvdf2zTvJcQ/XnNMM8qQxPX9WY09Ao
         ITykS609v5PkuwLiANcZSU4QvuXkTAVLIQ8lyeTsU+9D3emEdVLftSKSLSRvsJdeL8hO
         r2MQKqM9Qrl7CRtXZ5lLqhWD5PVtoP4vMwuxeKXCjY8mc4iP5X4ZIAEHylUUv0jNz/Z6
         KaKxmWa6mOb1MGW7GTAUt9W1PILVUCUgrhAmlrbYpVo/RoDBjLjbjFnNdlLkx+Oh1rX8
         JdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650713; x=1724255513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1s0TehfVbhq0HZGHpkiDt/kqWMCBY7b6/k82SpXX8k=;
        b=PQyLsFTXUjt6royOD/da5s3UH5zML5JkVsxAnHjCJgUWnfJFrbSBfN32AEEgmexNxQ
         byQgvEul2a/VsIGpdZoxmdO4Hlfrhruf1z/IdQBpWQ+em2/ZpiNk+p2ro9ZnGNb0HSP8
         HJuNAEhva5BfJC0TI9IONB53iGm6mYA9wGAIEniPapBDpRkH3W2TjYDS50t2lK8fEUrq
         ZGVRmIjUuOaKVyYkwGHDw6fovhFB5eic2dyfZx+ER+R6F//pIo2fz0Ih8gxIVFTdWtto
         /46G2sHdP0rK6UhGeo311XRLQT8RSc1Nb1/fmADQ5gCrS/W1mELXlqWX4RVBV0A5kA4f
         JRFg==
X-Forwarded-Encrypted: i=1; AJvYcCWtYiqPYZYHPtoy6FDbtM0tLN4HndJK+vI+fxkZkfpsF94PBk2nOlXptejyJ/ft5d5iI4kKUtQA2O2r6jstdDrZ4zOXYGE=
X-Gm-Message-State: AOJu0YzGjlSSJS9xNSgwrlDdr8RfE+0rjlWg7gCJ1VR8+0b73egFS1uN
	CiSLPLUBkn3BBaGQOSOS2wMbASgbUne/6UHOnx7AufNVDJGYKnCxeFOb/E6mQjQ=
X-Google-Smtp-Source: AGHT+IFg6veGNaLgvSE2E0usRoXPVwYia2SifqmSnbsKggLRSM6+BzNLtJNR7f5jIMVRK1+Y/tX3XQ==
X-Received: by 2002:a05:6122:1348:b0:4f2:ea44:fd2b with SMTP id 71dfb90a1353d-4fad1780186mr3878368e0c.0.1723650712608;
        Wed, 14 Aug 2024 08:51:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf5fa8fc5esm7797076d6.103.2024.08.14.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:51:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seGHv-00EnrX-F2;
	Wed, 14 Aug 2024 12:51:51 -0300
Date: Wed, 14 Aug 2024 12:51:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240814155151.GB3468552@ziepe.ca>
References: <20240814145633.2565126-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814145633.2565126-1-smostafa@google.com>

On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:

> Also described in the pseudocode “SteIllegal()”
>     if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>         // stall_model forcing stall, but S2S == 0
>         return TRUE;

This clips out an important bit:

if STE.Config == '11x' then
  [..]
  if eff_idr0_stall_model == '10' && STE.S2S == '0' then
      // stall_model forcing stall, but S2S == 0
      return TRUE;

And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
match the STE.Config qualification.

The plain text language said the S2S is only required if the S2 is
translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.

> +	/*
> +	 * S2S is ignored if stage-2 exists but not enabled.
> +	 * S2S is not compatible with ATS.
> +	 */
> +	if (master->stall_enabled && !ats_enabled &&
> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> +		target->data[2] |= STRTAB_STE_2_S2S;

We can't ignore ATS if it was requested here.

I think that does point to an issue, ATS should be fixed up here:

--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,6 +2492,9 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
        if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
                return false;
 
+       if (master->stall_enabled)
+               return false;
+
        return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }

And your hunk above should be placed in arm_smmu_make_s2_domain_ste()
not arm_smmu_make_cdtable_ste()

Not ignoring the event still makes sense to me, but I didn't check it
carefully. We can decode the S2 event right?

Jason
