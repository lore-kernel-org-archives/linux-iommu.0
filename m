Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAC241122
	for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420275; cv=none; b=qozOHQEPBSDrLR+fIIsAbRylZTmAsgMr3I5y9uJVZTEYZKUDzzq1qSHaONCLPVugvblNzfqxGKjU3unjyoc4elHAGF0DmFq5sZVPALGN9334YG5I9vGj1XSQKDx0TOR+Q1c542qL/RynHQdnqQ0Fqvn8fduIL/5b6feYm3kdHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420275; c=relaxed/simple;
	bh=l6dE3XVGUiPeU5nmiSZ0jJ0PyvZFUH2gVZbYvaYkIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COeSGdOaga9UufjeYhm8RADwxHu013pFy7Kuz44HqYhuzigbjCbtdcmuZYwRWmZI2AmfOYPd0teSgPuNn25zwigLdWGMERnSfqVFSZIc2O3Hqr8nS1riy6aMFUDMxFCx18RFB5cVgkGbuT3ov2zW/87OO6OEo2/NZ+BAfK0XSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtUI0iL4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtUI0iL4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237f18108d2so115675ad.0
        for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 22:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753420273; x=1754025073; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJRrie+evisFjv3ojJcmxiW8N4BF+TiSqioS6un+K1k=;
        b=TtUI0iL4Fk0DA87qUDPnc9aXwHigIeK/A9pNDLf/UU/EIQpCfospgAP9N+s/hxPVgw
         BfprAoXpdfZS0ctqZ7CIgV0Eiwf+QGj3UC1lsPHHfsfJyDs0PTjO7K5+j+XI5XAb6rbM
         rE+yoe3H/7FSnjmyuz6At1Wz8w2rAv9ed7cfYeT6yxhi5/hUFm0S9YYmqfvDl8hORsle
         1pKkXOGu0GG/hmBev8ugfT/gHBsjzWP+bT8VrE6gpeYyUP9O6XEXm/xi8cacDkxguhM4
         6rILQVcKUpVgJlBHKhzZrglAwC3GR+RxtHp0eWzsJ/8KITEv+NzwrKDYfPqrFMHK56o1
         RHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753420273; x=1754025073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJRrie+evisFjv3ojJcmxiW8N4BF+TiSqioS6un+K1k=;
        b=BFtHbaj8U6CUfqnDQ7+Yy/uZEaJTG5rF+uAqvNuHfNyfqzeDioY07KdrGqDkLPNQok
         bqjApoubRj8fTGbq68WBqvR0BKSm270eXkNGt0gV1Y+asA9B50p4XnuVgDiiM9tz7FxB
         IPmsP961yxufRtJ+ylY/eL7IM4Tf2cYunZnIZDR+LAPhZZ7le2AlcU0CONiWGbMxKean
         //d34dBg/MT/prHmtd34FHfyg/qbgJ2FhIoELtAcM6WnGrUe5kxr3fYoJI4mktLfsAMt
         fN4eRYlgCStFEFS9AHYhQVsqqICpJi2Pc4/1bc6IUh/iBLCXMc8WGIzi1sXjC8atqtlS
         BlFw==
X-Forwarded-Encrypted: i=1; AJvYcCU7GBbEDfKdAjLHIbltf8pGyVWmsdi9v62gWE6kkypK+GofaJN/enG9ypjIJwVzFN27o8xafQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsjE2UI250/Lo4+CAYUlyWqKvBdRqUcqOIQ2kCYqpovG52z7MA
	p3J1Mnl7B/KUnl3sVWkR2H8o7HhXq8xb7ueeCJKTAzuG63cWS99R+HXjyj3Gz/Hl0w==
X-Gm-Gg: ASbGnctJRnjJaGFQdVtpcf7ZKczxR+0c6hEyxwIEOl7lzi2WNNYUFSZKlybKfVRIot5
	YNw5IkKIkh13p0QWAlb48Trts1VF6bD530G1KCSGMfUuzZc/D0k+oEITnQ4WyfBplgPRGZPwaTh
	q5+zUUN5XiH4K2ZSikMPYXX/FXHC0jiPH5MDjJTNigemB5W4I1m+mL0zLHs26N2zjy7cX37htoG
	EKMy05KF+E3QiogXDMk7gXeDDhc3ULOVtb65YVr4XDVNjjc5jKS5ePRiQvcIEqSxAewoCpmx0Q3
	uSdPrQUkT3Sz4Hd9xupTJO6WzxaEn6OnPInp008FJ3GxqixLXlQRhA0kT+pDGhOb0MkMaafHwup
	vthXN+vtO16RMeecB2VwrwaOoaQ1/0H5jb3e/ICTrz1Cq5aTYUrIFRyuv1AYWc+UmSwM=
X-Google-Smtp-Source: AGHT+IGG4QZQwavYhcLFszK2mSaWOfTBLnCc2XFKEIjBG7genN2zVTCSUApFR5trIV9DREmiDkhIQw==
X-Received: by 2002:a17:903:4b04:b0:23c:8f12:7c4b with SMTP id d9443c01a7336-23fada582fcmr1953485ad.10.1753420272915;
        Thu, 24 Jul 2025 22:11:12 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7630c947b6fsm575750b3a.33.2025.07.24.22.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:11:12 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:11:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIMR6xxR3Jdpy8kX@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIKqaGMMpsIuAVab@Asurada-Nvidia>

On Thu, Jul 24, 2025 at 02:49:28PM -0700, Nicolin Chen wrote:
> On Thu, Jul 24, 2025 at 08:55:50PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 23, 2025 at 06:58:20PM +0000, Pranjal Shrivastava wrote:
> > > On Wed, Jul 23, 2025 at 11:05:26AM -0700, Nicolin Chen wrote:
> > > > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > > > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> > > > > >  	phys_addr_t page0_base;
> > > > > >  	int ret;
> > > > > >  
> > > > > > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> > 
> > Sorry, if this wasn't clear in the previous comment. I meant this
> > comment must be updated, the "unsupported type" wasn't rejected in
> > vintf_size, rather the type got corrupted which brought us here.
> 
> Any unsupported type would be indeed rejected by the init op
> callback. There is nothing wrong with that statement.

The comment mentioned tegra241_cmdqv_get_vintf_size() which isn't the
init op. The statement: 

"unsupported type would be indeed rejected by the init op" 

isn't the same as:

"Unsupported type was rejected in tegra241_cmdqv_get_vintf_size()"

> 
> It indicates that we shouldn't see an unsupported type here,
> unless some serious kernel bug like data corruption happens,
> which is implied by the WARN_ON itself.
> 
> > Had the
> > vintf_size rejected it, we wouldn't be calling the init op.
> 
> A data corruption could happen any time, not related to the
> init op. A concurrent buggy thread can overwrite the vIOMMU
> object when a write access to its adjacent memory overflows.
> 

I'm agreeing with all of it, it's just that the comment says something 
was rejected in by the size op, which raises confusion as to why we're
in the init op. The init op rejecting something due to data corruption
is a different thing..

I totally get the point about data corruption, i.e.:

size op -> returned something valid
<data corruption>
init op -> rejecting corrupted type

Wheras I was just trying to understand a case where as per the comment:
"Unsupported type was rejected in tegra241_cmdqv_get_vintf_size()", 
i.e. ->size op returned 0, yet we ended up calling the init op

I guess I should've been more clear. Sorry for all the confusion.

> Nicolin

Praan
