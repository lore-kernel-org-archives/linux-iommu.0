Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067913791D
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740884; cv=none; b=gunOujYFr5riaC1xEmnNn91sZuKv2Gm50umbHBWLN577EeJkOLgTtd62PwRSBcfkiIAL6cln7iJC03g+ZEFKF+iFSzin/J27+tOS9Gk4YKDsBdskSKc9OsG9+wxDLTcybEHZomERrvxgQswXHO9x4Weo5O1pMVBF2iNm3DNQEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740884; c=relaxed/simple;
	bh=v/bXOSBKu2eGpHEzaYDbJicIc8rMxQdp3cklgPly4s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+ABwseh28iOKHTbRr/C4z/WrY2eGlqSQEHaM1EC/CJ0JxONbKB9kQAcXHVuno0YHwznWfSiVRBUO6EGczyojKFuZyUoXfcmfMB2rBy2idr5C8TGKBNjhc/E4Tj3vpVyR2Ep77MtZZg9Fuu9N+AVEW4qL76ndxUGsewUYr226t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=et2Fe3Bm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="et2Fe3Bm"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7884114feb8so21730985a.1
        for <iommu@lists.linux.dev>; Wed, 06 Mar 2024 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709740882; x=1710345682; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSA2YBah1Lj30DTvNjciwv55fQTPNlhcFkEFTOf2JJk=;
        b=et2Fe3Bmgt+mh0qw8+EFNk5ZSxN31IcRKZx+ZkIRMIM+3iXykmbXeUg6JIPxq6xAiZ
         ATUsS/N3nhMHtECCiFp9dmw5dcSnfQdBtep3gTq/jTB9U/4U+dnr1NRGDvj+1uPfVQ5r
         vnU9v2oi9HLnHCzqc1mZKvPFGcJbHxdEjjvkkxzvpQhJR4wZ89QiIF4YyNlmLhSYT/4R
         991cA6I9ZAQzQ6BoorsP4AE40VvrbejZMgJOEVwEAOOYC3cJ4W6HvvLwEssCUvYUz54i
         ZidaQFcdwH5/nBmJhyNpYxQgYogB5vYYJ3y1xL0p4l/lSJ0hGylF2ygSBQWGZgAyOofG
         wpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740882; x=1710345682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSA2YBah1Lj30DTvNjciwv55fQTPNlhcFkEFTOf2JJk=;
        b=S45k8zPIlSerG9q3E6KIwth5DOopk9gZT1OXzJaGMaDtvoIbnpDlMnWEzagD0bgWC7
         Nct82L7qe/w4ej01CNYIUL51eII3KqW94SIaMn9Xvi804g4IgClTaUSq5cLMQu/lBo4v
         n2KW4NYDW7sZqYl8QvkWTg3vWBe/wIatUtao5/Mw0M27PZITyasLkQuwnix7ESAXAsNE
         iyBOfqW1xNq9KOJrjniHPCK+ZjuA9DZLQ/Ux1FHn0n01CXXaglzGBsggB6nldtIAlr24
         eZir2WTX1Rl5ezN6xrSVlFos87EsOnE/g7TozZw2tOq94Z56ZqtRxgtF2lA0OPaS7wDi
         zPqw==
X-Forwarded-Encrypted: i=1; AJvYcCUzYZ12stTIsEr3UrH/7E1CoMgotXGAlNh4QJ/lIUMA4V7AbRS01oxYpWkEbKTxAvoYPBxip6O5NjWXqdSc94nCR+Wip3Y=
X-Gm-Message-State: AOJu0YzhoHHMeKN7NW4CpJb0yJCnXdDu2o6Pk3MgreXRmw5VaPjHcdlY
	PLocoXTfkBe59B7z8e0Z9v7SYNP6Tuu2/nHFgIRhWRBZTl2gBgsQHy9MM+26U4Y=
X-Google-Smtp-Source: AGHT+IHonZr06DjH8Yk84J1MO3pfMp1YqC5mCzQ7TjuwpRdCgfCoxMkD1Wnxg7YpHS7pifKwQl02jQ==
X-Received: by 2002:a05:620a:1a9f:b0:788:3766:b145 with SMTP id bl31-20020a05620a1a9f00b007883766b145mr6022406qkb.38.1709740881754;
        Wed, 06 Mar 2024 08:01:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a29c800b007881ff8cebasm4246571qkp.92.2024.03.06.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 08:01:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhtho-001egy-PW;
	Wed, 06 Mar 2024 12:01:20 -0400
Date: Wed, 6 Mar 2024 12:01:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240306160120.GN9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
 <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>

On Wed, Mar 06, 2024 at 11:15:50PM +0800, Zhangfei Gao wrote:
> 
> Double checked, this does not send flags, 0 is OK,
> Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.
> 
> In my debug, I need this patch, otherwise NULL pointer errors happen
> since SVA is not set.

This is some driver bug, we need to get rid of these
iommu_dev_enable_feature() requirements.

Attaching domains with properties should be entirely sufficient.

Jason
