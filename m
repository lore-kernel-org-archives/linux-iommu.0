Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7821019C
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746136007; cv=none; b=nwi+VyH5c6+WlMVCjZTO1tQjrXvibegGeiQze8+YVLuTDvrE4YtRhT9neiM/kLu/DCtjJzBHtdZoBjTDleBctQJcE8awxUvETJ8Ira17Ag1FLYcpkQPd4baVqu6QZhP0i0F0LwcyV3ij5dLiVPL3Kbqz91fbNuYI1YvaUuiuh3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746136007; c=relaxed/simple;
	bh=zREa4RUqnytl3tRJyZ1VEkek+EoTDe7j9JuQy8pDoNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsgojBHGPD3EJTLD7BTYIgyffMfLckVGBa1pMGF1kBKA9kaS2T/Yg2q3y5syBxwQnAVu6ylvghuV6sPoWBd/W6xNnGbqjgxQcPgfbB808UGeNP2ZyUbwROH+7qocFwwn+j0xfak7RwRmhZ7LsJWPKhy10qFS1jPevb9HicNi4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KC6Q3W66; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KC6Q3W66"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so60755ad.0
        for <iommu@lists.linux.dev>; Thu, 01 May 2025 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746136004; x=1746740804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9r6A8pjeBdT9CIMooiOuLDzT6g9hy9vPLljDSfADzUo=;
        b=KC6Q3W66jqf/0X1SthWpV0T3eOVln0fhabGMnmOTtGrjaacCodwQccGuRFAvBqBe0C
         BR1EM2Kn5xmZ+AFrLmo4+SYQe50URKczfpODsrRDZb0eP7fZeNtBdxHcBxIm3XdDFFY4
         VKDVZozRNw9pSpt3LhB3R1i3rw/4uzhI+QGLp/leAtcBvYVLNhoAfDwAVj5qj94bpSrK
         xo/LEQHwTYTBFPFJ+iy96egzEspljLG4KVpWdL6U7MORsvaCJ/2iVUnLmrV7XDGo4h5T
         IVmAqKlNC8dRXhG7TMJ25I31TQ768D4U05Pdo68Xo2EI+MsrigyEGTqI4qBQyNiE3n/T
         l6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746136004; x=1746740804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r6A8pjeBdT9CIMooiOuLDzT6g9hy9vPLljDSfADzUo=;
        b=rdldwXcmSWCo5GLJ553KXAMx9IrDj+ExypDx5YntIeqtedNYa03bvSN8oELAUm3VXp
         PncgKe2LsSvu43/GvaN33q4Jc91uydx0X9nOcKF3vX5t4+pBHTyyrs4o97i+uo5j/V57
         ZU9QbLp8txf9joHSDUwQdD9LZe7Gxv5LJIhLkC66oZhmFqlOXWo8T8anjnd4mGt0KoAn
         D9Szn8IkCiViUiazucAHgGaPxn+5L8WTvwJhhT3yTf1AVtnJ3EJMG1cn+Yxw7CI0PAaa
         0+/hzk3I3J2VXiovRvdPV4lNRLk4SIri2u+FBp1DQRP1ZA3k9xuqgr2t9GIdy+2gUYmx
         eQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4Xkn+lICjeTQ/39XCAkR1tNIjeNCBC4w+gpPgPD+H7x7RYkul7SHQlhXn3CTYgvnyMYsdIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSQOdYieRFAEGt9MHPKl8UCo/do3lYGioVP+nAwZzyc9GKbNn7
	vFte13QT2dUBh1lvhi9+/XdwhSPYZoRt4lKmWG9/uYNU80bqc3dP/T5r50Twkw==
X-Gm-Gg: ASbGncs6LUqTKQu/gAiZ8H1qLosmOp/W3VoWb1B1mLR3cxyLuvQNF2MbvdilzhshkOf
	MQ635IJKtSQAcqCdHLeo0MiBZRTBaMl0rXChAl2/QJ39Z/k3yyHicxuWpIjK1e/slqyw2moXp0u
	1ik5VIfyOl8SXSGtK4dv8intvw2sM+W2spM0dLgM1byLyS0doCcCwRTkfTqNn1HwYcT7jcWgmVI
	1IDlcCG4kTV6bm+nd1PKBe5DRJOoZsCqsPxEaoZjjibKXHwwJ4h1mNp77A+ySfgwtHqOw5fAPWw
	M8CC6FTV2xtRBhWiNEk6Jp5FlkodZJENW1tUmjnxveBmeftMH5jqOX5b8OwOqyioocabSQOZ
X-Google-Smtp-Source: AGHT+IFwvKnjZtLoQ4bY59+1gUvZDTEb4mowMJ0K70YKwsiOKp0lgYtmDTG0AdFCxAuctUKRuXVbug==
X-Received: by 2002:a17:902:db02:b0:21f:631c:7fc9 with SMTP id d9443c01a7336-22e03c81070mr3938175ad.0.1746136004118;
        Thu, 01 May 2025 14:46:44 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa8611424sm129648a12.73.2025.05.01.14.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 14:46:43 -0700 (PDT)
Date: Thu, 1 May 2025 21:46:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 21/22] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aBPruHaehW4yU-ez@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
 <aBKdMaFLPFJYegIS@google.com>
 <aBKmk6PNFreeyfLh@Asurada-Nvidia>
 <aBLGUby2dIiYCe7S@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBLGUby2dIiYCe7S@Asurada-Nvidia>

On Wed, Apr 30, 2025 at 05:54:41PM -0700, Nicolin Chen wrote:
> On Wed, Apr 30, 2025 at 03:39:22PM -0700, Nicolin Chen wrote:
> > On Wed, Apr 30, 2025 at 09:59:13PM +0000, Pranjal Shrivastava wrote:
> > > >  enum iommu_viommu_type {
> > > >  	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
> > > >  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> > > > +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
> > > > +};
> > > 
> > > This is a little confusing.. I understand that we need a new viommu type
> > > to copy the new struct iommu_viommu_tegra241_cmdqv b/w the user & kernel
> > > 
> > > But, in a previous patch (Add vsmmu_alloc impl op), we add a check to
> > > fallback to the standard type SMMUv3, if the impl_ops->vsmmu_alloc 
> > > returns -EOPNOTSUPP:
> > > 
> > > 	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> > > 		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> > > 			master->smmu, s2_parent, ictx, viommu_type, user_data);
> > > 	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
> > > 		if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> > > 			return ERR_PTR(-EOPNOTSUPP);
> > > 		/* Fallback to standard SMMUv3 type if viommu_type matches */
> > > 		vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
> > > 					     &arm_vsmmu_ops);
> > > 
> > > Now, if we'll ALWAYS try to allocate an impl-specified vsmmu first, even
> > > when the viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we are anyways
> > > going to return back from the impl_ops->vsmmu_alloc with -EOPNOTSUPP.
> > 
> > That's not necessarily true. An impl_ops->vsmmu_alloc can support
> > IOMMU_VIOMMU_TYPE_ARM_SMMUV3 potentially, e.g. an impl could just
> > toggle a few special bits in a register and return a valid vsmmu
> > pointer.
> > 
> > It doesn't work like this with VCMDQ as it supports its own type,
> > but for the long run I think we should pass in the standard type
> > to impl_ops->vsmmu_alloc too.
> > 
> > > Then we'll again check if the retval was -EOPNOTSUPP and re-check the
> > > viommu_type requested.. which seems a little counter intuitive.
> > 
> > It's just prioritizing the impl_ops->vsmmu_alloc. Similar to the
> > probe, if VCMDQ is missing or encountering some initialization
> > problem, give it a chance to fallback to the standard SMMU.
> 
> I changed to this and it should be clear now:
> 
> +       /* Prioritize the impl that may support IOMMU_VIOMMU_TYPE_ARM_SMMUV3 */
> +       if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> +               vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> +                       master->smmu, s2_parent, ictx, viommu_type, user_data);
> +       if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
> +               /* Otherwise, allocate an IOMMU_VIOMMU_TYPE_ARM_SMMUV3 here */
> +               if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +                       vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu,
> +                                                    core, &arm_vsmmu_ops);
> 

This looks good! Thanks!

> Thanks
> Nicolin

Praan
