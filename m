Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D62DC334
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060796; cv=none; b=bZg6J8SQ4R1M5ZFQq4fKKeuO1fn6cmLIcfLWqOLwQjdoOxRqGP/8gErsNEXAQu6qMxI1Rgiw7w1EQRFsMLFATofQCWPMRq/55SddXDcoS9b5R25C73fRQZYPCVpALsPqeo6lp72lR57ulfMfeHQpjgMMTWCuUqpq65Iw5EhJIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060796; c=relaxed/simple;
	bh=5Htsj0SZkfA6ZP0/HAN45E09cEbxnJudVmnNQCDCgCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X84TlHuTHN28OiaaJ7hcpBmi4N/QllvJBqtvqCVeUvG0K2qJhXcDKV3J0aPg/tFdlhNwljvn+Inay7XY8Nhcznm3AMjkDPyMSXY3jnfNXVxaq8jU0oqBYa8KQQANSfbfz/FTal3rtjxHzGRtbVQFqC4tJmFBMugyA2oTsiHeLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k7SRm6lZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k7SRm6lZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso65398205e9.3
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778060792; x=1778665592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Htsj0SZkfA6ZP0/HAN45E09cEbxnJudVmnNQCDCgCE=;
        b=k7SRm6lZspLLioznhaPaOsmMxoku1U9iLs0qgE6G/5Sl79y7gKwTyoAIZQL7DPPsKK
         e8Q3ZddBLYuGiRQaN8GR2lz1sxfnggoQwVhR6HZwVwMDEk8hQsn8UaA1tF8tEjM/ptNA
         MisaP/gul85vvpiycTnIXkIrPw0M/xUcNXhZSZ9yf8+eIVJXbeNVmIwy7LaHxOT1IxYX
         oKWWtQeabyazalTvJhXius4Lri/DBSAH+1t60TUH7+w31rEpmy/iExYcLbqKq/2wGnrI
         HgsbSJ4O9Lq+OMBles53hbFaEErU6G4G0NF1wL6zKuT06HEsBM2dzIMfYKLJmlGvq10G
         9A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060792; x=1778665592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Htsj0SZkfA6ZP0/HAN45E09cEbxnJudVmnNQCDCgCE=;
        b=jC1wkTUwD31L6g5KvBFmkNnoA8FIL27K9VlpQPZAeBAf7/Prd3kcqwZFNhI8zpjHxX
         hcEVEtd7jqu4moag3TRyPZpGeBisFVKGMBeNgNcGil+PxaBiZfY/95QDxL8QXnO2+YcF
         gKHSVBxRbliGHeVvVxItEfNywAnM8srpf8Brxpcj4FkZczGrlqHKS/MhTJ56oxHBIT6d
         c21qzliCDrF7ydMADyxg1/FOkBbrygAsdT7HTyKTJU2+iLvrMARSIvj3PsZobx7B3S92
         SqY3Kn50DPJmx9QdS5HPKY2QfsZE8RMx9Y/abOOEWR+mJRuM53P4P0k5fA6PNybj+MuA
         KD9A==
X-Forwarded-Encrypted: i=1; AFNElJ/lTj7pd3tMPW4exm07H5ynS3/NJWfyazHC/ZxBZAIqDMG34dOIIHRjiIkG9IVb5x+j8norag==@lists.linux.dev
X-Gm-Message-State: AOJu0YydN6RBtTF+48Pqf9kCNuT0uF94x69ZbxFcFpppgj+N0WqmhSgt
	k0t4p5attMHc9t6tArLrTM2bykXwsbqLfXuyTrkJ1NU3DxjLvNs7OIvBRMPjBeaNH9I=
X-Gm-Gg: AeBDies2hrpjaphp8cMfSVGGYH6M+wV/YZCgne3+Cr0aIqxgG1ModmhCobpD97yPhYo
	S6N6MAVVA4+FNhI7BbPvCVl0/miwJnSNiZDYstdruI5uQm8MdkM7AWmIYElKZ4R4F1BxAPqbURh
	Ekm9ThSJ7COfrRAyINi33wIWcRvDgwj8U6Oyv00qMGgvxuVsTazf5MEPgTc54P3US2X72txT+gm
	k1LeibyM2ayx0eOdRLwRMgUe7hkpEAtuWYVEA/dh99XxliunXkcSWW+4xf+tGagY0r/KFgATRWv
	Z57AWrjgFkh1zTeCU19lIhEUE6Gnlwv23ZIrVRXeyXP9ZjVr2WuMirNrPa+avWKuwFh5hIwW6ip
	96qlj9gA+fp3GXctPkXM2q1G+PeMOOx8Hbk6wdjc2FQxvjs1/6jW3thY2Kf68rj9qTMcd211iyl
	KX7vDYVwvdrM8UNahECQ==
X-Received: by 2002:a05:600c:a307:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48e51f4111fmr36566115e9.19.1778060792096;
        Wed, 06 May 2026 02:46:32 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53157734sm12386735e9.35.2026.05.06.02.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:46:31 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKYpq-0001eL-Bg;
	Wed, 06 May 2026 06:46:30 -0300
Date: Wed, 6 May 2026 06:46:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afsN9jrsfuigV+DM@ziepe.ca>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpwCIjQXwfImPXm@google.com>

On Tue, May 05, 2026 at 10:32:40PM +0000, Pranjal Shrivastava wrote:
> The PF shows no ATS Cap:

Yeah, that's complete broken and unusable. We should be failing things
not trying to patch around it. quirks should be used to deal with
this non-compliant HW.

I like the idea of prepare ats failing on the VF if the PF isn't setup
right and then either failing probe or just disabling ATS on that
device.

I also like the idea of failing attach when ats enable fails so we
keep a consistency, but it should be a WARN_ON path that shouldn't
happen do the prepare_ats dealing with it.

> which means pci_ats_supported returns true for such broken HW. Ideally,
> it should return false for VF if the PF doesn't support ATS!

That's also a possible option, but I also wonder if ats_supported and
prepare_ats should maybe be merged together? Why does the iommu driver
have to call both? If prepare succeeds then allow ATS otherwise HW
does not support ATS, turn it off ?

Jason
