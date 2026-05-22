Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF32FDC27
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465718; cv=none; b=eO8wd1yx7WE7TdAzxYiG8fexf2ZTDa/yVZRWQNH52nc5w+f0z3G0ESbeh18ZwFKXrJY14Fw2oMO+ovax2tUvbPvhIF/X6WlejvRlHzMp8MDvti12fu3XDyVSths7+RiAb9gAsefu6z4QMFEHj7AUPXx6hn8yHRVB4gzQBqGs2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465718; c=relaxed/simple;
	bh=RuKPNubONCAdbcGpb+4TkujB9DKqcRtbxLnmKogDOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grq9unFAVlGVkzDGL3bWPh1PVpFtbmPdnngQ7ibwPOW9zrxwlBTgpet1Uo9SVXaNxjRiMHDI992pMwYGUM9uPK3z+9dGqwJ3FIBokr55ph3P9NWvP/aelQUTGhX28wABEM7Ok0wYdp22dwfg+yo3qP9WvsKMNR9WjnN59G3am5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohpGTUXO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohpGTUXO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so635ad.0
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779465716; x=1780070516; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtKAVWQfKJfzzyI5JiK+IMb/6FsJieotyhYngLX2q4s=;
        b=ohpGTUXOQSSFevgVqEJBOh82R+aWRwP87zHs8TSz9h7/ccwU0ow8DGSxt2dVQoktAT
         5rFAEnlFt14C8d0wboQ700Rmq3funlWEofUEJVrMVnmlb6J4fENAbQ7NjbF5zTMaFnry
         twTgzOAeXEMHA5aZZd73L7KJeD17/Tf7J9IehyEtZtE/5ku2crDOdhkWb2Hfub0pG87V
         G5R6zjHtjFVZ0ob0nnoMbe8rqQ40d4fCaqc7lKG5twINoWsIj90n3i3Db7BAVDxbmOux
         4XVVITxWLb+QKIY8vhE+6cWc9dwaYUCubZDW4OhCckbNNdI6q+Jr4quY4waRfabxcTyt
         3ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779465716; x=1780070516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtKAVWQfKJfzzyI5JiK+IMb/6FsJieotyhYngLX2q4s=;
        b=p3hqhmsqY6T/Je4LyaMRdkH7yk02G1XFk61dbbmb9UGcNwA88AQ4pZ+7OZjIJdeRf9
         AdSWILsFnWOx2gTe2r+Me/Sen8w07mwuOBMYW7Pa4UZOecwA0eqreG0S256fuL0Lex3e
         AAJgFS8Kc3VscPgHzA2SPuF4i9oQrOOcMA/YJaevE/Rm2N9CjyzYVPoB36J8JEw/+tuX
         HN/Sy7xP5ZR14IQ7YlYSBzwo9ekuVOfroc7AMxx0BiEzPiSqTsuFXNs7VzawBkgnJK2c
         hTskr+cqQYZ/s0IbBw7sFO/4VWdubAaMge8kNNL4Mzl2txtnbKODVHcHodBg0cGJD+mK
         UaEA==
X-Forwarded-Encrypted: i=1; AFNElJ9Gumr1Y18nKMEYBK5MVSGDxQwZNUDZR3a0xIJ3F10BFOCGaZGVAFzFY7ZIu/t576K6sWIHzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrW2a7W3fQo0zNtnYSBXVh1GlpQucKq3EPSwKL/5ZxIQ/tSL5y
	chmtk5xS3jHoiKbVk9Ee0XwHh9gUnnBiPqSms6VQG4CUDo5WobP57avx+AhSIQHMFQ==
X-Gm-Gg: Acq92OG0jJDx3Yq5+jdxU8EXCSbBD4v0/6mV/aVNH+gCts/Y3st84Gbg/gxILXw87T8
	jPA64rUsARLCSiOtlV0peowZPv5ZWJp/PMjJz+HP93lh9xQ8D6M1Vxyttc8zpc4z8S+fRc2YtUS
	0n8HPvVdUfkR+ktm43S4RdphAWPDFbAu2PcQGYfexzmRms8CrRlh2A7R8HqlNPLqqMzdtRpIlkl
	Y6ekcg13+ckpsEZG3Ysj39fXjQIRMYpPUaoOPp4+Z6EBVl6fa/tL56X3NOeyhIXR/gY1/rRMRGx
	hFRUpcvSgQv17CIMYWiKDDa0W/DWo8/ThWD0KlxyBowWXEd8isV+oo8PQSjzISTl2gZqWLe0bG+
	7l1NRMuoHSMySU3AGSlb7fm2mjM4UZ8dGuJ+Q78nW8ZekxXavHNGmxV+NomyL+f/I0koBIk5weu
	8vXiWCBlFM5Jv1gEPGJhBCO8LiSH5fPZ3dEFX8CU93n1uTrVF1iURU1IGg57eekN9pRoNu46MBm
	lKO8c4=
X-Received: by 2002:a17:902:c952:b0:2b0:be7d:a25e with SMTP id d9443c01a7336-2beb1a59b6emr2468155ad.18.1779465714686;
        Fri, 22 May 2026 09:01:54 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841648a2bf2sm2145075b3a.0.2026.05.22.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:01:52 -0700 (PDT)
Date: Fri, 22 May 2026 16:01:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 13/16] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <ahB957SICkiVzZBv@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-14-skhawaja@google.com>
 <agz5rFcl27H8yzTY@google.com>
 <ag4DzYZ4ToDcyfn3@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag4DzYZ4ToDcyfn3@google.com>

On Wed, May 20, 2026 at 07:40:05PM +0000, Samiullah Khawaja wrote:
> On Wed, May 20, 2026 at 12:00:44AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Apr 27, 2026 at 05:56:30PM +0000, Samiullah Khawaja wrote:
[...]

> > >  #include "double_span.h"
> > > @@ -1421,6 +1422,7 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > > 
> > >  {
> > >  	struct iopt_pages *pages;
> > > +	int seals;
> > > 
> > >  	pages = iopt_alloc_pages(start_byte, length, writable);
> > >  	if (IS_ERR(pages))
> > > @@ -1428,6 +1430,11 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > >  	pages->file = get_file(file);
> > >  	pages->start = start - start_byte;
> > >  	pages->type = IOPT_ADDRESS_FILE;
> > > +
> > > +	seals = memfd_get_seals(file);
> > > +	if (seals > 0)
> > > +		pages->seals = seals;
> > > +
> > 
> > Can caching memfd seals create a TOCTOU issue?
> > IIUC, iopt_alloc_file_pages happens at map time, However, the userspace
> > is allowed to map a memfd and then apply the F_ADD_SEALS via fcntl()
> > later in its setup sequence? For example a sequence like:
> > 
> > 1. VMM creates a memfd. It has 0 seals.
> > 2. VMM calls IOMMU_IOAS_MAP_FILE. IOMMUFD caches pages->seals = 0.
> > 3. VMM finishes its setup and calls:
> >   fcntl(fd, F_ADD_SEALS, F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL).
> > 
> > 4.VMM initiates Live Update.
> > 5.check_iopt_pages_preserved looks at the cached pages->seals
> >  (which is still 0), sees the seals are missing, & kills the LiveUpdate
> >  with -EINVAL, even though the file is properly sealed..
> 
> This is true and it is intentionally this way to make sure that the seal
> is applied during mapping otherwise user can apply the seal after
> resizing the memfd and preserve IOMMU mappings that are pointing to
> unpreserved pages. Consider following:
> 
> 1. VMM creates a memfd and seals is zero.
> 2. VMM maps memfd into ioas/hwpt.
> 3. VMM resizes the memfd.
> 4. VMM seals memfd
> 5. VMM preserves the memfd (it only preseves the current size).
> 6. VMM preserves iommufd and it succeeds as memfd is sealed.
> 
> But the pages being referred by the iommu mappings are refcounted in
> current kernel, but not preserved.
> 
> Check the comment in check_iopt_pages_preserved() also. I will add a
> comment here also.
> > 

I understand the intent to enforce a policy to Seal-at-Map to ensure
consistency. I am wondering if this policy is a little too restrictive. 
Should we consider performing a dynamic i_size check during preservation
instead? I can't think of a good use-case as of now.. (maybe let it be?)

However, if we decide to keep the current policy, we should probably 
check for the required seals during the IOMMU_IOAS_MAP_FILE ioctl itself. 
If the seals aren't present, we could pr_warn("Don't expect liveupdate 
preservation for this memory, bad seals") to let the user know that this 
specific mapping will be ineligible for Live Update preservation later. 

Thanks,
Praan
