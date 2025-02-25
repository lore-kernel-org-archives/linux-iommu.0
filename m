Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7018DB1E
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501961; cv=none; b=X2YemEO28cEnVlkdG016R51ws+97KFPiQ4wTDDbu1L77CXI7zpdd2g+zmrXKKuyqwJWAXpqk7Cn/BwIDO+OxAyS+JRIFna9OWRh39yb6xzKbR+rTYo/pg+QQYKN4uXtmyr3mZkdL83SCHXpI/0dj6/t1QB1GItl6kHzhH4Nvcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501961; c=relaxed/simple;
	bh=3pkC9Zan/5soR9iiYT3dS1raXOelzZooR8jSMhW1DW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjNDs/VrSB8Z/lvgecQb9RqNxVbFrhfVPxE6/EzwGc6xFEretD9tQSjxfLpa9fpRP6M5Ai6ds25tl8w+LRpCHaZ15J5oYhLz4ZA3NPNDkIeWZi2p4Ajkw5z1Mv/tXH2PynJSgT0FHs0Zo8cflIsg/MzT6kzCpCZTpq/QqfYWjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSb0bCg1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSb0bCg1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22117c396baso194535ad.1
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740501960; x=1741106760; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvJy2eU2NKOX06+H5Vs2S45nqKcJ32b1n8dkLQorqiw=;
        b=wSb0bCg1e93HySdMHiwDl0dVSGfx5fSazmyQmNOELU03fGSoOaCUtb7nLg8VyB3wAh
         p/jI/WB3Eeo3YVNTfzrW3CVdEIjj/SMcWSXmWa7ykbHhYPcfMD6/E8dvJemJ5YMfiMI2
         +69taLUTQU0j/hvOPtuELSZJ1GXTnHkgVUN1GYtnSa66XLa1SIBSHX3jzTZ8POHRLkuJ
         n5bMTj4VHxfDSWUAkSJPi/pTJtE3F7s2emXY41V2yl6KiadSpuUdmKJ3umDyVWz8qqfb
         vZ8qV9fkw2Ic/1h1uJ4Wif4RCW4oCHeznlLyki9FeFxUDHQehaHi6lfLzmaC19sbfURE
         et5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501960; x=1741106760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvJy2eU2NKOX06+H5Vs2S45nqKcJ32b1n8dkLQorqiw=;
        b=VKT/qV5esS8NPled4oMSeNr7RiSbL1BupDZ4jQbjt+hO2Ni7zj+AktYdCq4qDa1BuQ
         ppvpNU8Wf+GDJJppFg6Vosh4fEc4SqV/hdgiCP1JfNXWEa43da/sJ9hKCglnKrCPAn2K
         9OMGzevwqTcWx+OmqG3FAIprMXWnbCLUcDN/tPQk1E/K0j4v4Ye+jqkM9UvIsQRT7tMk
         X/dpGw8TldyP6vAicua6x1pLCIhsfh05twyZkGjF05rbX3FSoRKQgb5IBGFsevo4sdGt
         TsJw/hng29SzQs4y9MnNbsaYfz9FrBPZne86wXmSP1gXIdsRq5UEI/kF+55Nwhe9AEM6
         Ve6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUz58abEc49tJfE/9RuzqXoNOl39Hd7ekD17fM/U0zpD5r34EIURPWZlHM0K7ZWfelAkHXkDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+3Z2styx5iLaRK7eNVTxF9WsyrWLgZfvs4NuSXrj0RJ/RL+xk
	wJE8TX3KyZIMXlzkajpOe4iekRZqK4816Sp1401O8SI4zCHF5B1pPRc8F5UKvw==
X-Gm-Gg: ASbGncs0SCmTVEUXLBdA/OnVhWSw8YCxyceh3uI1TsebtLHP41Qiop/NwxXOXZm6Q3u
	AXlhwaWyCIqJI45OZDCrZGM4/fw34VoTcyFCNbuUjPrwvhxOxoNQdDT59tPgsee7WXfmUwUtXbS
	bAwjCfcZjmk31ZotdtPS7BLTli+P6B0sklLEvjGwaAgeaYvId6yjanazrHcRVOq6oiPQ0U9iHYv
	jvvoCQrZSCeoRaCcT9dtc6Q5ypd/Fa+Sgw3Xw7JOsh5kHFW4InTjdrAKkKoLDOK72BC5cQiCS9f
	8e+IH10VLLBqYD3sNc1nkr/XBHDs0NTlldis6hnzgcbpeHGlwNg5zqmAHvi+qeY=
X-Google-Smtp-Source: AGHT+IEN5DYqq3Kc3cWdCDht37pR+ox7Pyn1fNUO9eOSCsjsyhHHqegeAVtSYgiTkCHpwG2cFWbA4w==
X-Received: by 2002:a17:903:2445:b0:215:9ab0:402 with SMTP id d9443c01a7336-22307a98a03mr3458305ad.18.1740501959581;
        Tue, 25 Feb 2025 08:45:59 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6fa230sm1709220b3a.70.2025.02.25.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:45:58 -0800 (PST)
Date: Tue, 25 Feb 2025 16:45:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z73zvIbsXzJMCaNt@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
 <Z7zqdrQn7Q8yXfcn@google.com>
 <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
 <Z70EnQ5CXacc4ysT@Asurada-Nvidia>
 <20250225160225.GA593877@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225160225.GA593877@nvidia.com>

On Tue, Feb 25, 2025 at 12:02:25PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2025 at 03:45:33PM -0800, Nicolin Chen wrote:
> 
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > @@ -95,8 +95,6 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> >  
> >  	iommu_group_mutex_assert(state->master->dev);
> >  
> > -	if (domain->type != IOMMU_DOMAIN_NESTED)
> > -		return 0;
> >  	nested_domain = to_smmu_nested_domain(domain);
> >  
> >  	/* Skip invalid vSTE */
> > @@ -122,19 +120,9 @@ void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> >  {
> >  	struct arm_smmu_master *master = state->master;
> >  
> > -	mutex_lock(&master->smmu->streams_mutex);
> > -	if (state->vmaster != master->vmaster) {
> > -		kfree(master->vmaster);
> > -		master->vmaster = state->vmaster;
> > -	}
> > -	mutex_unlock(&master->smmu->streams_mutex);
> > -}
> > -
> > -void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> > -{
> >  	mutex_lock(&master->smmu->streams_mutex);
> >  	kfree(master->vmaster);
> > -	master->vmaster = NULL;
> > +	master->vmaster = state->vmaster;
> >  	mutex_unlock(&master->smmu->streams_mutex);
> >  }
> 
> I'd leave the clear_vmaster just for clarity. Commit should not be
> unpaired with prepare in the other functions.
> 

Ack. I'd like to pair prepare and commit as well. I'm just confused
about the check if (state->vmaster != master->vmaster). Maybe a helpful
comment about what are we checking for would make things cleaner.

With this nit:

Reviewed-by: Pranjal Shrivastavat <praan@google.com>

Thanks,
Praan

