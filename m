Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4E2528E1
	for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390559; cv=none; b=n7A2Hhoymmk3Vb40TNNIV1RBi/GK0E3BIxGr9GBbw2fLd4hRyjstoMXb1Czb6+Lyn5jB8rY6KjiB7RmfVH9ZyWQkqVitvLEe8jj7kD8QvvdrSrjIHsHPc5cU7LAQtaAZFqZB7i3SO+8Lesg8v/WcA/2FTMaQL3UY8JntwdL5puI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390559; c=relaxed/simple;
	bh=WVnPqwTo77Pc+iMCvphoAqe39pYBfadoUM7KubCgV6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9s9RAPb4rRQE21uKQhBk4qLCypkjSQ1HvbIeB+UiZfoILjHh4sbXlm7OfEsr/kk019lPZ+dJpav8oh2xJ8p8GUiqVKGIzdk9blM2wqFtAlgvoaR/d8ZC8U+VBjhWy7xvQ0ojU5ylpgz6rwo+MSYcN+gT7KEb5KKfQim6/Hn+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UgVZtZrC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgVZtZrC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23dd9ae5aacso21185ad.1
        for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 13:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753390558; x=1753995358; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTENdrjrQjKdf4LTtk0rNbYwdganBE87alZpnHbaQAo=;
        b=UgVZtZrCZ1yWXEhKmaq5e+4Ci1wcGiYmQkrUU76tCxmKxoeTbZGFTUDuS5yH5h1b02
         wyA5W6uU7Kz7NW53nLe573d+GvGxypB1BIhjfPKOu/ppMrzSfIPu7mk86PBYvuGRZD8F
         X7/QG8M96LwLI+DVOKmQN3VGv/Ci7Jp9x7C0AhOYUpq4dAGb7kvgWDdPTusFoBM3PZmd
         jKP59leOlnqcyY/tK4+EeAq1mcSWJ4EY2YQQLTMij4TwaJ9oU+ThE3KKqiHoxI7kEQ5K
         LK5vEhNup9mfwda20daFoBwI0bKOvFDIb+aAQG+mKCoOkZfKPkvzQbM33Q9DoIJrNKsQ
         13hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753390558; x=1753995358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTENdrjrQjKdf4LTtk0rNbYwdganBE87alZpnHbaQAo=;
        b=NdHwB4RZ87yb3No7hmOASq8722KzBKVIsLZpQ0bUtNkuUHeZeSwRzMZ8IKcFRDTb6d
         cukWLkaEW/ySjFwjLY81z1t3HnXSpv+ZML0BBb9za3wiiku/HGrQjuwp2yYXa8136J9S
         9eLkpk40eN60mH+XU/kj5L1bgJAcSdKLA4qrgDH0fhfIikIxkg6Hm5T+iE1NLglJspv6
         28xfbgUNRpLYU0TktXKgptLi0jnXG8znZSvelbIlpp4GQmfTZ6wpyyrktzt8ubHr2akB
         W6re8yy6v/aX41aMP8dV4jORaxua1+NOF+Pk2nOgeS1bs0HcB7482ILB/JgBuLXZKTUc
         338A==
X-Forwarded-Encrypted: i=1; AJvYcCX9bhFrZApR2sCWceFFoiI253q4LYcOCojvrLd82yJYuHAfsrTV0/Mxyj0DzddQJAdDjHAuwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4LoOG4cGMdlPcNYBUC0h77XsEdKdpKt6PZCdy3iBLIvyrDTTc
	eedwbWVBn5xEhL4omY/NVnwpMzfdA/r0Lu7vy1cEDf5/pjR4ARZRMprVVmci+LP4FA==
X-Gm-Gg: ASbGncsAbrmtnOnTGEA4t5BmRIVaPlkAqy+Rq63eCtAUZ7kf8MW8zXpCOCW4v9Oo3u0
	QdK5RF3J1IF61qCzq3WfSN+RxgvsJMDIiMHl3OHI7rjCc1NGidFLq+R2Js0wwTrIXE5cTGB1QF/
	8TCtL4m23EvBD9SZRswe7J/xzvTUUsYtnbBhNA1Vy53yjJibdutROZqErXsn7XemhU5MX31Hjp0
	DmZSpvkt8VsqZh9qmPuAKNS+TXiNKe92/U0FFoNERQS4uQNvmZRNRdesJmRGWG94mtlXVQT5N2O
	e7HkbD2ACHETuSu5oa2NViwP9TG/ajVLFEFqLwvDGp9/IR3L1uG1v/3hwwOsCFgDra+EFYG9Nl9
	FhukKDArk62ETDLyiuD9Ot5Rel6aQI3Pu71KOeJHJyHvFWKkQhzQTmLfh
X-Google-Smtp-Source: AGHT+IHAKLnuNj4dfO0gvzhHyjc+lG/rACu6++zv+Qt1qddir1QwuV7zgtdYIfUhlyrA+12IZWRoQw==
X-Received: by 2002:a17:902:ef48:b0:223:ff93:322f with SMTP id d9443c01a7336-23fada587f0mr920885ad.2.1753390556054;
        Thu, 24 Jul 2025 13:55:56 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475deafsm22232285ad.11.2025.07.24.13.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:55:55 -0700 (PDT)
Date: Thu, 24 Jul 2025 20:55:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIKd1owebUNQeN1-@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEwzM7mKUI8-h9U@google.com>

On Wed, Jul 23, 2025 at 06:58:20PM +0000, Pranjal Shrivastava wrote:
> On Wed, Jul 23, 2025 at 11:05:26AM -0700, Nicolin Chen wrote:
> > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> > > >  	phys_addr_t page0_base;
> > > >  	int ret;
> > > >  
> > > > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */

Sorry, if this wasn't clear in the previous comment. I meant this
comment must be updated, the "unsupported type" wasn't rejected in
vintf_size, rather the type got corrupted which brought us here. Had the
vintf_size rejected it, we wouldn't be calling the init op.

Thanks,
Praan

> > > > +	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > 
> > > Nit: I don't think we'd expect a call to this if the vintf_size returned
> > > 0? I see that in iommufd_viommu_alloc_ioctl, we already have a check:
> > 
> > It's added in the previous patch where I explained that this is
> > to detect data corruption. When something like that happens, it
> > would be often illogical.
> > 
> 
> Right.. I got mis-led by the comment, my point is that if an
> "unsupported type" was rejected in _get_vintf_size, we wouldn't be here
> calling viommu_init since we error out based on the check in
> iommufd_viommu_alloc_ioctl.. but yes, if there was some data corruption
> that changed the viommu type between these calls, I guess it makes sense
> to check and error out here.
> 
> > > And call ops->viommu_init only when the above isn't met. Thus,
> > > if we still end up calling ops->viommu_init, shouldn't we BUG_ON() it?
> > > I'd rather have the core code handle such things (since the driver is
> > > simply implementing the ops) and BUG_ON() something that's terribly
> > > wrong..
> > 
> > BUG_ON is discouraged following the coding style:
> > https://docs.kernel.org/process/coding-style.html#use-warn-rather-than-bug
> > 
> 
> Noted. Thanks.
> 
> > > I can't see any ops->viommu_init being called elsewhere atm, let me
> > > know if there's a different path that I missed..
> > 
> > I see it as a precaution that should never get triggered. But in
> > case that it happens, I don't want it to proceed further wasting
> > precious HW resource given that this function allocates a VINTF.
> > 
> 
> Agreed.
> 
> > Nicolin
> 
> Praan
