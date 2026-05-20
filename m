Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23343F660B
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300160; cv=none; b=tMbGxzm/jgXWNEFbSPwFijiZ7OUQRvQkDFL8NjYX3IsSmN8wbXlpkNRx0MTqUSKHPdVdxdiz1kNRitSjkWHxIO1ROXm+813nyGTbVtW8ZLps1QR6YwTBv3yLuOsEOsnUmhYYny+hifHRico4Sxkfm/zWRkq8Fwg7/uXld//QG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300160; c=relaxed/simple;
	bh=gSR9ZF8mEMkIrcPGA22VrdnTF1lx5yIEAf4xXGH2nlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mytDQnnIUzF8vCBzp9tFVk0otFbfHJk9I1dcyeKdQ9NLCHB0MlX1WHfxMziuvzjXlCIit/lujCMnJEwo4toUvqzJNDU+XksPuGtJWcIwwe5XUpEJWgeZJQPd+WbRfn/B2xvZM3K/UDy2a+x8OuBQRvUHrzJdUJ0Ag+nCWZsJxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smxGQi5Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smxGQi5Q"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba180a022dso4705ad.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300158; x=1779904958; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKj2nsEFhwe3iqBMbsJt9SioFDYUGDCac39gv/hs+vE=;
        b=smxGQi5QAvxMCvniSX/wRdKcmw71wO2iKiYWvqil9RJsDUqRsPuN85zTY9AYkSlJOP
         IuDg2Qb+BOfkq5stBO8uTEcUdz1vf7gpSqGrAHJIU5Fxih9s65JU9//x9l38d5KL2Eh+
         nrZinIUk/wnBYMoLBT/bVQUy6yKaFOe5gj91slmce0EnE7rR5EkC7nILw8h57akkEQ0q
         TP119UH1k69Xh/Y/Oh92brxkbKEc0zHJ4+YN9HmYIkzCGWExqBVdo2ir63gt0mWfRUP9
         X5eIR2bfJDSLqI2cjByJLCipr8xNOfdbKbwE59Mgqm9j8GGWAh3+P6iSW28IEhZ9sEI1
         CoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300158; x=1779904958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKj2nsEFhwe3iqBMbsJt9SioFDYUGDCac39gv/hs+vE=;
        b=qR6he/PcUYnNHXzGeg8zhYrjqAhUlr6DVc4Y1+XgunvoTo0rfbHURiFSzD8EefXMOE
         C2Jyac+HBBckvk0KsPJsF/9kPIh3yHhh8GZ9rZoF6aHQlssBxMnuAX8Kcn0CfzD/IJdG
         if4jNGSOTDdxRnfGdd/GlWu4YEbHBCEyOn1PmKTsxOrCKy2Dm90GrvDoO7zs8z/a2Ttg
         V57wuLQXSK+ZwH01wRXyCMzkPPSdloBz+5TBNLDhauoaku4q8Ca1xq8BvkSu8htvZIRb
         9lcixZXc7zl9iehGvk/BFya39MT4WBCcyB7VJGNkpmTD11TLwJ7qmMWaFtiGIxoMFRPC
         wDGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ar1zPbr8/cWq7YQqQg44mKR43zB73ZxND8V0OgHnGxRay9yfDG3WxlHPCasT7wIqzD++oQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBbH8UhNwTjqc5RZBoNSl67iQ0KIkZ+oASUGB0dwcnH8mlcO0n
	POoSEAEN1Fk624PjTBIlZFaNK9SSbh6yHsf7IW3ytNBEgNSnm62KL54d9pvh04GYLg==
X-Gm-Gg: Acq92OGGFBOPFfNDBdlGV1HbMgVeUN3/HEkaBgFrne5FEZUACga0A63j4WEUdwN4B1J
	G4u5QZ0gTMrXnhC8w53l0vvbQw3VS1wuX0pcCVNYcJ+HzNJWAeEg5bZhpIWeOvgEQalyhwCl3Ja
	Q7PR7nwrgT5ar+CRENHKwnfFX9tg6In7utrfg2fAMfIzoKXq4IOIf9cdOTmkdAl1W34zApaDunj
	QXxrnMdNb6Kt+J0Vqv5kIjMYbigWHWmcdLuQhXzFQrnjDJQ8pIifQl1ylDuPWkI0kPPEPf62YXg
	S3Z/rrl8vJBp7hfqhyROBb1TFHtm7DMh//Ad6RuIP4M8KydcfhW1t1v/E2B6xvrH7HXX+WE3AXR
	YiAdKqL5s9kAMc6Ht7KFXjx1ktJl1yJLc81kN3t+ZJebJEaafteLRqv4VeJUxfsAVBIhnSqL0Vh
	oJ3X7sXUe1Mq94Pd6e2xdfS7CnJj5luqaS8k2jt0bqIzea7N42EClFRAKGV+v/6bzK7SvJ
X-Received: by 2002:a17:902:e749:b0:2bd:6dad:7cca with SMTP id d9443c01a7336-2be9f4474a0mr220335ad.22.1779300157257;
        Wed, 20 May 2026 11:02:37 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0ff0edsm20807015a12.20.2026.05.20.11.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:02:36 -0700 (PDT)
Date: Wed, 20 May 2026 18:02:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <ag33M2nqVBWXdQHX@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-10-skhawaja@google.com>
 <agzaTPROvwVO-3lO@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agzaTPROvwVO-3lO@google.com>

On Tue, May 19, 2026 at 09:46:52PM +0000, Pranjal Shrivastava wrote:
> On Mon, Apr 27, 2026 at 05:56:26PM +0000, Samiullah Khawaja wrote:
> > During boot fetch the preserved state of IOMMU unit and if found then
> > restore the state.
> > 
> > - Reuse the root_table that was preserved in the previous kernel.
> > - Reclaim the domain ids of the preserved domains for each preserved
> >   devices so these are not acquired by another domain.
> > 
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
> >  drivers/iommu/intel/iommu.h      |  7 ++++
> >  drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
> >  3 files changed, 105 insertions(+), 14 deletions(-)
> > 
> >  		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
> >  			iommu_disable_translation(iommu);
> > @@ -1648,7 +1661,7 @@ static int __init init_dmars(void)
> >  		 * we could share the same root & context tables
> >  		 * among all IOMMU's. Need to Split it later.
> >  		 */
> > -		ret = iommu_alloc_root_entry(iommu);
> > +		ret = iommu_alloc_root_entry(iommu, iommu_ser);
> >  		if (ret)
> >  			goto free_iommu;
> >  
> > @@ -1732,8 +1745,12 @@ static int __init init_dmars(void)
> >  
> >  free_iommu:
> >  	for_each_active_iommu(iommu, drhd) {
> > -		disable_dmar_iommu(iommu);
> > -		free_dmar_iommu(iommu);
> > +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> > +
> > +		if (!iommu_ser)
> > +			disable_dmar_iommu(iommu);
> > +
> > +		free_dmar_iommu(iommu, iommu_ser);
> >  	}
> >  
> 
> I'm wondering what happens if init_dmars fails for a preserved iommu?
> Since we have non NULL iommu_ser, we'll skip disable_dmar_iommu and skip
> free_context_table() inside free_dmar_iommu() as well. I'm concerned we
> might leak some resources in this case. If the failure happens after we
> set restored = 1, even a rmmod -> modprobe cycle won't help fix the leak
> 

Re-visiting this, I think we don't need to worry as skipping restore is
the intended behaviour.. we don't wanna attempt restore on things that
have already been restored. Please ignore this

Thanks,
Praan
