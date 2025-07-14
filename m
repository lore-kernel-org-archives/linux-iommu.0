Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F6233D9C
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528870; cv=none; b=RSjxsv4qL5WzIQgU5CzA4h6LJQ4Sb2IJCxbuNBihwbnNpu8TPxBj6aLqdGHuwUca+sT2iM0Ab4EG2iL/m9bMtJH78XAW47wI1kEvBPVky1+LRDRG9fUsBl2ZOds04byq0lnTONNVoq3oTqTcPgDdv4QcD5gZRZYab0cGbUN0dlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528870; c=relaxed/simple;
	bh=BDSxVNaH7DxXtXg4d8lyl7WfXKs0R9S9LaI79MzV4Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQS4RCQAFyCdb06Z57uvJjlzvWuA7UrtEvdWkNORKoHweNMETjXsoNwDLxIL0r0dSqlfbhcUIDGj4/8IEVvs5pp3Ex3D+N2pEivvnxyOwbcg7SBEr+4pVxcq4JLdt2NPhqNj97WHn/o9mkwM5zYUlR/cpxuyxB8CZpo6UO+O3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K4TjW6ln; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K4TjW6ln"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e1f3b95449so190632585a.1
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752528868; x=1753133668; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjsur9DLBO9lraNK3jQ4gyxveT6GDJ/WoDBpZ+ezdw4=;
        b=K4TjW6lnDl721P1NfLfXAP3MtxZUus5qFiN/A8wBZbXz85MVo34Q/vrAZnkMkGslPs
         hGyUDuKStfm6iPFemnXpog8m7TlGpXmW9uf1vMvODvP8GSLGtyy6lEyQu/XUqlmSAQhL
         rSeoSmqBzp1BJypNKD9PFhhjsCZolPeJtAChoTiurY46NW7tVOqd8Z/q4O8RvAYoUgBr
         qlcb+Gwjeg8/qb0EqrGl9Sz7nRETFkLmms7BQz40m/pOttvhEWnJBlYL/Da43Ecgolwo
         Oeav3zAykcZJMZTZ9QWB7gFFn1j3yITsE1nXUqEfzo6HMoHojsatmk5ebDNnVkU4ZdCE
         eyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752528868; x=1753133668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xjsur9DLBO9lraNK3jQ4gyxveT6GDJ/WoDBpZ+ezdw4=;
        b=ULbITSPRSuRt+WECUOR9+yNLvW2R2uDuV1hrMGC5fxDG7nJdnimtKByRh6FTobfNiT
         oFUh7Ef2I9YbaIMirEKB+Xtvu+y9D0d3arfZkqeTDGM+iR1izhgv6RrlHwBO+pE3DTt1
         f+HabziYegkaIs1wpFW2ajK9q46Zs7gQ9lI+rMWxrOz+I3HxobU5KO2O55Mb3X8N8fAx
         22Ihl3TsQcsCAPlxBb7p/56zD+vYXgq4LKuwuezo21xp8cGhCv1dzuU4KIe5Z4avoru7
         Qz99mbWV+yZ7xdnTGffHORznAyqv/6Vk0jx5e/G+KsNyVUhvJ/2QdEPaa+R8t9fRqVds
         /ryQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB6zW1azzjp+HG7ZLkKYWyU4MXfx14T5PyRBCDCBtAyfloYlfFbmI+61Jy+bGiVhDS/g5tXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX7i7IDEjylSIQJiBWYn3ZVlnLO5JS3f5q820U5dduPOKc3N74
	eNHG0lUsO4xM1ffYJJ+UWuj8Wh2LYhR0lRQ2STVUM5dCPpDuy8oOdq5xRuxdCRTSwYk=
X-Gm-Gg: ASbGncs/c+OXeqEFVctfwBYIP06tfQv7fyUohQSg+GApNkzHc3VBkdlOsWPs+FOdr+i
	UlzmaFAwYrk1WRlCCzooQifJoDSuCjVMnb9GSW3GeHmcKU0uKKq8ogxHK9iN0V2CW6oddhD0+Oa
	K5AH+WEv1JzRIbH8Tpp/Afay1D+23qjwY/y2tyqXACVO8GK+5TYp3ITBuGJ0zym6mmTaHZqPJ8v
	G/QFCo3G28yflpYD/PT2wrtxqPKVNaxPodVi6v9JAGsjZjmDq30Cy0PyY0cY52ZgbS3B5Uv2mKt
	HM409wOaVh8Lu21nWIvgIm85R9c1k7RREVQbZ5OnlqAL8xPy5IvPWi6Gf/vy4Qtezxtm7UArOXq
	0SB9JuKP3OtaCFzXNua7XZJzdOJwIkc5mNcJH1+Cwmid9UHGnhWYxMvIcquSMdjfRPhSjz6llaQ
	==
X-Google-Smtp-Source: AGHT+IFEx3lCJSamFS7GtCIM3DJJbVlIj8bmcaZbUD5CgXC67a7uWIwLe/hJ3o7zuNw/2yCru6JygQ==
X-Received: by 2002:a05:620a:20cf:b0:7e3:3682:6dee with SMTP id af79cd13be357-7e3378dd518mr183144785a.4.1752528867626;
        Mon, 14 Jul 2025 14:34:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e3357a2f85sm57242685a.14.2025.07.14.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:34:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubQoc-00000008jqs-0p6Q;
	Mon, 14 Jul 2025 18:34:26 -0300
Date: Mon, 14 Jul 2025 18:34:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Nate Watterson <nwatterson@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra241-cmdqv: import IOMMUFD module namespace
Message-ID: <20250714213426.GJ1870174@ziepe.ca>
References: <20250714205747.3475772-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714205747.3475772-1-arnd@kernel.org>

On Mon, Jul 14, 2025 at 10:57:38PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The tegra variant of smmu-v3 now uses the iommufd mmap interface but
> is missing the corresponding import:
> 
> ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_object_depend from namespace IOMMUFD, but does not import it.
> ERROR: modpost: module arm_smmu_v3 uses symbol iommufd_viommu_report_event from namespace IOMMUFD, but does not import it.
> ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_destroy_mmap from namespace IOMMUFD, but does not import it.
> ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_object_undepend from namespace IOMMUFD, but does not import it.
> ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_alloc_mmap from namespace IOMMUFD, but does not import it.
> 
> Fixes: b135de24cfc0 ("iommu/tegra241-cmdqv: Add user-space use support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied thanks

Jason
