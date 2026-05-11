Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E43D8133
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495660; cv=none; b=UhnCP8UO7nrTCzJXLGYzkZuYXyxw26FCpr6iuMP7Dwo0uFW12LDKgP29yC5F26k2Apkwr369QZ1OBTgjUb2LvjIw0rOQ7cKA89vSCwwp127+hAUdy6h4SLSal3hWv5L/QpxLESlirw8Lm0LWx2BRAXozgexda9d1h+9U2bpavGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495660; c=relaxed/simple;
	bh=OBjJ4qWY2VNba0vgmOYHWkVFmsOhC9ZRZRJDpBNdUpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuRwqnXelUc7ZIlgFiDlCjVkwyB3pnruy+VMGvhOMRK80M6FUbYQt0xYHPobiLVDCIuQt03zJM7khl0y1tVhs1ryAtOyP4qSaOxh5NMO3QJBsg8kKr5IfX000xAosS6sm7lAy/H+H5qk7bq5o60izQJctp9zmNk8CfJF+Iys6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HH5zERF1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HH5zERF1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso505ad.0
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778495657; x=1779100457; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1RmAL1G6V7aOO8kOtNRCIE/n9eFhH+hpo5Ze/Bw3SM=;
        b=HH5zERF1ypgVNOE5MbIYGzi3dcvB0iZ59VX6D60pAZx4b//sf0zfKF3Q0VMciMpMRA
         erE8ns52gY5hAOMBgzpwiX9xRkfsOXIf+ULguhQIyI//BeVuCusrOWB5unYondJyZwB2
         BocjEof6XHRXeo8qVfYX8FQodn/xSQ/3alCKU9zxzUv66ytUxGdDAhwefwPRxhPYW2mx
         YyU2cCpTO3J+tN5ZMnBE3f9aozDf+YmNBXw/g/UqNNp+DUtnjADXJyc+4Am5eckLvRyt
         vzJzaaMQkdFTQj+4NN0+9RRAUzVs0m4V2HOLLejP2oOeo+JC7WTTFNbQQQWrR1uHZXiM
         gKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778495657; x=1779100457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1RmAL1G6V7aOO8kOtNRCIE/n9eFhH+hpo5Ze/Bw3SM=;
        b=lncRQK0SzeimHgzu3S056B9WVnOLkzyBvfxuhjTf9Ze3aaKM3mwC0ixBxg65I8V/67
         SO0jhx/bVyXpWdLP6Uk/ET3GQSOrIrC8rthrUbwW1BxgzvOD5zhCwtwNkQC2Tw8TxwEL
         4xZhMYcX3qoe4BnYTgI/M0fABR0T0xlG3JLxcY1MdJrOTAP9w2k+BpCnT2L2zvb40nMN
         CMw3i/sXsOX1oBn/nG01kb/h9g0875K6NaN6sVh463jAXgwgTjHW6iNCZjNM5cSqvwLy
         c8XX0NLlq8qwJIUZEWM277Yw1O5+OtGN+mVDCMqqKyPBFXx1jeWq7xNUVK1N62j/daGq
         1yuQ==
X-Gm-Message-State: AOJu0YzwQoA4GXOyUAa1nmglGQqg8SH5TxC1YyjUOj9ycVJsmLTFN1Rw
	hMQt8YR0+mzJIjBVlp6FJeDPFMYv7NUN4+6rc+tXEKl1DPULUfhQquTW6iEu6IBBjg==
X-Gm-Gg: Acq92OHPTlWDYK5sQK9br4MPb9+zRWiQT8lgsuCVraGxHNxWnCRkgXdohiAE395jKCB
	hJbzu8kx7BB4CTLKIisb3Gaa/HIXkt4EmoDX+YcC5UR2y4jsiZyb3WVJaGqiezbfAqbfk28jgxi
	Zihob2yJBEFgQG8ab75lTPs/QXF5IYhY7FJbivdifWVMwxk69ONx9EjPWq+9SAHXAcY44pWGyQf
	5a5Yl4dId98iMKVPXWEIINB2gcjDiel3AfTnNlt3dtPHmqFbMtq02KQ/I6U1nRKflVZGYCYQ8Fp
	TDXxwBjv9zlUT13mnk9jG6lhbppCI8uGiDWm8WXC8VhpYmgSlNOxwQhLZK4SPsX1vxT+EovTvyg
	vw4aW0xy4M2rm7b2vBONUG6OdXUe321i8RsgVuB0CARZp2gD6ATioBV8KCiCy1ePZ9Mpj9cfS+8
	ZGYM/Se0MDDRas3q4Q12RAfP+qLfKGVXN2t3b6nfJJMRXmrZ9CdCvpZ/UQDeelK5dP6EBe
X-Received: by 2002:a17:903:1c3:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2bc746fc88cmr4737145ad.6.1778495656102;
        Mon, 11 May 2026 03:34:16 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d63e03f6sm7798313a91.12.2026.05.11.03.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:34:15 -0700 (PDT)
Date: Mon, 11 May 2026 10:34:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 7/9] iommu/arm-smmu-v3: Directly encode CMDQ_OP_ATC_INV
Message-ID: <agGwoYJD3s2T00fX@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <7-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <af3NH0cihPUQ8PST@google.com>
 <20260509165401.GL9254@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509165401.GL9254@nvidia.com>

On Sat, May 09, 2026 at 01:54:01PM -0300, Jason Gunthorpe wrote:
> On Fri, May 08, 2026 at 11:46:39AM +0000, Pranjal Shrivastava wrote:
> > On Fri, May 01, 2026 at 11:29:16AM -0300, Jason Gunthorpe wrote:
> > > Add a new command make function and convert all the places using
> > > ATC_INV.
> > > 
> > > Split out full invalidation to directly make the cmd instead of
> > > overloading size=0 to mean full invalidation.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > 
> > Nit: I guess it's worth mentioning that we remove CMDQ_ATC_0_GLOBAL as
> > we don't set ent->atc.global = true anywhere in the driver anymore.
> 
> I added this:
> 
> In section "3.9.1 ATS Interface" of F.b the specification says:
> 
>   When the SMMU returns an ATS Translation Completion for a request that
>   had a PASID, the Global bit of the Translation Completion Data Entry
>   must be zero.
> 
> Even though it faithfully forwards the G bit through to the ATS
> invalidation command there is no way to create G mappings so there is
> never any need to send a G invalidation. Thus don't expose global in the
> new helpers and leave CMDQ_ATC_0_GLOBAL unused.

Ack. Sounds good. Should also add that the only other place we might need
G=1 is for a full ATC wipe. However, we don't since the PCIe Spec 10.3.8,
mentions issuing an invalidation without a PASID prefix (SSV=0) already
forces the device to invalidate all ATC entries for any PASID at all 
addresses, e.g. arm_smmu_atc_inv_master(master, IOMMU_NO_PASID).

Although the comment in arm_smmu_enable_ats should suffice too.

Thanks,
Praan
