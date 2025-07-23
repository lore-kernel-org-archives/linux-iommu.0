Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB91225762
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297108; cv=none; b=QAhgrl5vrnm4AqxbudiOlWq3M7Pc6C8YRs4TMSkev3yaqklWwFBM5g75zQbMVMdkyOeMMb+PmWlcegX/fY5LYUUk+UF6ZXsFayBXOJ9LvE1uTnzd4syYi308bPT6yQsS+I+yAVhWH8bgMmlSdIIVP2wJ1yeOi8OZ5z0GO0DlNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297108; c=relaxed/simple;
	bh=mmzQsMhl6rfhBdXQys7xatXOBT6V9yF5g+naRmfEqMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKZcS5cp2gidMzl2yI1j6u8auGDSUeJpLqbOJKNmuxZm5V31K/L58O9aQoiCN6NCAum5NZgO1MinGQnI1ytRm1/Uvhs0qymkNobrlBwZsid0OYdZQeNSuApMHpJGvL+6HtAGjVgOb23A+I+MNwegSTq+CiQlf5HOU3Zd7HfaBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edOnYph4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edOnYph4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e389599fso38445ad.0
        for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753297106; x=1753901906; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgyxBCBooV+1URrR0k+S4ytxsHSs18Tgj8DW+tHKzAo=;
        b=edOnYph48RATsxWhvSZLEYDhAqBJkidBgAUQn77bVkXU7DZ4KWsKDVirdd3FY9cmBX
         QN1CI9DCIhbhLfxmGSI2UCwDLFRJYSbzKC0nxS0CqrZGrlu/0TuMRisg3tONjjZrUUHC
         hxRi+oDeFypdrPvGrJbplb/h0KeW1mE0khM2QR0vPq4qGZ+X3hqRg9hXn0ctd27yXiSs
         YFhuiIU/QHgdY6ugq8uP8LVZdrFAmLhjaGwjNhh9P+Au6V5Zx9JcPvQnYXDqTfwaqqwi
         7Vv4JG+PVypgf2nbFBqdHYL7Wzf+qFcHEUd+anRzYlJa12V7XR8KZy3/nR16138jhCWy
         ru7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297106; x=1753901906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgyxBCBooV+1URrR0k+S4ytxsHSs18Tgj8DW+tHKzAo=;
        b=tn0IWCjVahB2s8pEPXAAh/PUi0KR1VQIyarVy/AW9vraDiLhOjct11/srt4eRwVPVQ
         XzMuFbalu+GVCL3mZ90Ai3IQRnQO7cEPQOWVuS3yvZoOlVRKeoYQhbcSESFfE3HH3S68
         y6zjOsoWNFZlcqQvz9qqJYMYpz4b30CgTOZrhMHxdK2EhmQsSlYuUjiQxEbKap53+Gg7
         LY0KEayCYOSR1D9HwYjCTyc6rE5kPsUoAfTE7B4OSLHftSaopFJMIXluzP5kjgvtKXeS
         sSYTG+nwoR8O75k3irGmQ/Yig8uXh/mkVLyGeNrCVPpGt8LpBJdhSEIjyehBV4e7qABC
         gMSg==
X-Forwarded-Encrypted: i=1; AJvYcCX7+hVmvg9f16Jbh26OiwRfTMLDRvAspwlfriF43CDm//ZO4DWiEcA8ugNm/alei8y497t3lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpGG52GczhS9UOj1sqt6vyva1Pz3ykUJDs+RvHAGtVUXo/b12p
	9m0jI7xO+DnwkjvEFOmhdSaFj2yD9xJcpmuYHHfQpBzAYUcg7HSiTR666j8GIdrVOw==
X-Gm-Gg: ASbGncskYU1Eyi7dvhI3Q+G9COP1NdYn/ukOmLDq39a0E20VKnVuhTMfUxgy9EUmm4p
	QLgvWxp6Xk18Td0xr2cxVssv1Y/62PAZgeMqqXo8kZRYw7FZWqerqPv9EDjtcs1pNzJ/H6C7J/l
	HEdbYSnAJUoQWWZ7V1zMIfv42BGzUC0NAcrK8bYiPvonFfS1PLzXTpCq+d1pwum2yc+Akv1mMDG
	IuBUlg9eiJG9FnVFBZa95q2oiqPVAF/NMbwJ+XANlLPXckUIz66YUHXIFpMIcU8gKeykBP6m62h
	u4vRhZP5kZ3S+zC7rPSsixm10rB5q/xBy4tLoW6qGSvvWBtG8CdHeHeAffIkRQyp/nlvck0mZCx
	HGrTYIQZAv++/MAukhznu9/e2KrIIayGJARLpRR+JVGYWvV4pnz3qJvcE
X-Google-Smtp-Source: AGHT+IHUkgfjZ7uajnt2ygxd4BiWFzqlf8/UuEEurXoZ/+uZ0jw37E8kKbO1K9MhbyfBxy1R4DSPBQ==
X-Received: by 2002:a17:903:124f:b0:22e:1858:fc25 with SMTP id d9443c01a7336-23fa2ef97efmr184175ad.9.1753297105524;
        Wed, 23 Jul 2025 11:58:25 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbd66eecsm10238885b3a.142.2025.07.23.11.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:58:25 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:58:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIEwzM7mKUI8-h9U@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>

On Wed, Jul 23, 2025 at 11:05:26AM -0700, Nicolin Chen wrote:
> On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> > >  	phys_addr_t page0_base;
> > >  	int ret;
> > >  
> > > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> > > +	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
> > > +		return -EOPNOTSUPP;
> > > +
> > 
> > Nit: I don't think we'd expect a call to this if the vintf_size returned
> > 0? I see that in iommufd_viommu_alloc_ioctl, we already have a check:
> 
> It's added in the previous patch where I explained that this is
> to detect data corruption. When something like that happens, it
> would be often illogical.
> 

Right.. I got mis-led by the comment, my point is that if an
"unsupported type" was rejected in _get_vintf_size, we wouldn't be here
calling viommu_init since we error out based on the check in
iommufd_viommu_alloc_ioctl.. but yes, if there was some data corruption
that changed the viommu type between these calls, I guess it makes sense
to check and error out here.

> > And call ops->viommu_init only when the above isn't met. Thus,
> > if we still end up calling ops->viommu_init, shouldn't we BUG_ON() it?
> > I'd rather have the core code handle such things (since the driver is
> > simply implementing the ops) and BUG_ON() something that's terribly
> > wrong..
> 
> BUG_ON is discouraged following the coding style:
> https://docs.kernel.org/process/coding-style.html#use-warn-rather-than-bug
> 

Noted. Thanks.

> > I can't see any ops->viommu_init being called elsewhere atm, let me
> > know if there's a different path that I missed..
> 
> I see it as a precaution that should never get triggered. But in
> case that it happens, I don't want it to proceed further wasting
> precious HW resource given that this function allocates a VINTF.
> 

Agreed.

> Nicolin

Praan
