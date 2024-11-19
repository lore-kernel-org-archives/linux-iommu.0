Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC771AE018
	for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008477; cv=none; b=Aqi+Bm745x3wNMBbdxS80h0v1ip5iZ/kkadKtXugCf0GJRdgfViCWpe1gkmAM+z6aHdQzz5bR0JrfioPIyl2JiDEQcidxOXaX/4rNQ32wfUhljvQU34Ena8aY1kIMsYoMRPFcCeCRgwmbrJkK2XAM/cxsWuYHpz/j59uHH9BTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008477; c=relaxed/simple;
	bh=XJJnoH3sh2kVdKyR1NqemxGXfjOhIqJUylkBKZZhRQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjEsWTNmxLOkOzeCgYAzSNzT+XvlrWRf5A0fLYD60N4YZkInE10P7fWZ+0ZJqkkSmWBW+lawvRBNb79R8cvnPnOZ36/pmMULDqQjGTcgpkqvucvFp4TQ12vnQG34AXLefE3SstqIXFl17sL8VfLiIrui9uTYTnHPNS6NaZQzxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDGEYAzs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDGEYAzs"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-211eb2be4a8so100235ad.1
        for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 01:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732008475; x=1732613275; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSgsts89xuObYSU8GpPsbzloGB726Iw2lFmiQXEVuwE=;
        b=mDGEYAzsaotsw6jFs3qOt8KNJ15QA5XwwZBuu9urGRrpRlJaB4N2DcpP4pSJAo7W5I
         zcyW/6KRUrEUKsKW63xfrm+ArQ89QGWwN45/YwG50/C/ZDFptvzDbFMJUtOyZxIx+fEg
         krIsc1E6s/t5tq6ca/yDWjZTIZm7WgcWl8UpjmEaLb77vDuq5ZsfHnB3R/elbLWd+qMN
         Ta9hpTTWE8X5plhej9thna2Q+RYRbwdAtT99KxNvh5wf5n/XwIiUuPHfFEU0N8V8Gl/o
         Ha0Ssvr2IvI2W0DFY1pea32TtCajM3qpA4ZFhnxRt36kO6mWKmzlQPgzpayaoZqrHJAT
         f6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732008475; x=1732613275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSgsts89xuObYSU8GpPsbzloGB726Iw2lFmiQXEVuwE=;
        b=tpyXVGIbCsVkVj0vr+DAvMZMJxrRnmyYyJ3T9IE/IPkHlIXJfVr3NXJjX9WlQ2XnUa
         VG+nF9GkCiFae5KbtDoO2ufElPTnmCwqY6SkXdWBgq104w6Aj3+AnsFUJJD/cwfb9Wnv
         OinV0zVNSYCGu94j6cdiKP2VXu+LimVn/kMdA5i3sja4pS0Zx6R5XRfSS5mk3mNeYIse
         1mHf896Jl0HcDRJljZlrbJukj6JWPKOnR+CsoDnvS0b9vqxkPFKAWTO0ZOMs4rg3Apuf
         n7NMTEzdbt5I5ZmMjfG/XLT2oNZrXd/XBCkHGWe0d2VjT/O3GX7+4zwir60OGQzQBFSb
         9ONw==
X-Forwarded-Encrypted: i=1; AJvYcCVgezSN1ogkY+a9Mll9APO4twsw/WG0Mts1rFF/xJQ5u+J9zUELREpL0dc4GxgEIAkBLxxRgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5xkwXQ3iKLR16mFox9SJn2V85Dml+yP9lu5B8EfTtdh/lokzs
	XFPiZXmb86Cbf2dkV16vLZPdw+Tf/BcC2hl8qsdhwg+sAwDR4dFtfYJSKOXH4Q==
X-Gm-Gg: ASbGnctiDL/DDfk47Os8T6D79DXuaRcNROMxFTkEZ35pLZkj5HuiR9lfLsNX1wxADQg
	ZkqmvR/7FhWiqW4XFv/bcJl4qD1AcZxCQeIXdqgvdJfDpFAGWOSYD6p7j4btUAK4JhpcXIq2MEh
	3w3JwGTMdEZzumLUeiUJQEhJ7g/WB0r3f1zlec7p5f39PXZVHs5AqrVQgtTdMF5kJLSBCzYvG9J
	yP0Hhj7EZ3zCiXZx+jwkjJUY/27MnP4RCVsaBc/OS1BXsHNDvVWWlM4DSyyi4rgjxhuckcQuoWz
	FktNCut19HU=
X-Google-Smtp-Source: AGHT+IEMsFbqfjx4VOixgidqDODs2/GzcR9NNjSgU4GhFWGKsHpgPYXIxcybCuhfK/4XGnJLi/qwaw==
X-Received: by 2002:a17:903:58c:b0:20b:5e34:1850 with SMTP id d9443c01a7336-212536ec51amr1423005ad.23.1732008475189;
        Tue, 19 Nov 2024 01:27:55 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247720044asm7705753b3a.179.2024.11.19.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:27:54 -0800 (PST)
Date: Tue, 19 Nov 2024 09:27:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZzxaE6yTt1QpFJz6@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>
 <ZzdJAFc_8h6LfVL7@google.com>
 <Zze+VFpGNaXepFWC@Asurada-Nvidia>
 <20241118162442.GD35230@nvidia.com>
 <20241119090307.GA28466@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119090307.GA28466@willie-the-truck>

On Tue, Nov 19, 2024 at 09:03:08AM +0000, Will Deacon wrote:
> On Mon, Nov 18, 2024 at 12:24:42PM -0400, Jason Gunthorpe wrote:
> > On Fri, Nov 15, 2024 at 01:34:12PM -0800, Nicolin Chen wrote:
> > > On Fri, Nov 15, 2024 at 01:13:36PM +0000, Pranjal Shrivastava wrote:
> > > > On Tue, Nov 12, 2024 at 03:30:58PM -0800, Nicolin Chen wrote:
> > > > > On Tue, Nov 12, 2024 at 08:30:16AM +0000, Pranjal Shrivastava wrote:
> > > > > > +struct arm_smmu_event {
> > > > > > +       u8                              stall           : 1,
> > > > > > +                                       ssv             : 1,
> > > > > > +                                       privileged      : 1,
> > > > > > +                                       instruction     : 1,
> > > > > > +                                       s2              : 1,
> > > > > > +                                       read            : 1;
> > > > > 
> > > > > Feels odd to do so...should all of them be:
> > > > > 	u8			name : 1;
> > > > > ?
> > > > 
> > > > Hmmm, do you mean something like the following?
> > > 
> > > Never mind. I see amd_iommu_types.h does something just like that.
> > 
> > I certainly expect to see the u8 repeated and not use , for members of
> > a structure. Also don't add excessive horizonal alignment.. C code is
> > not excel. :)
> 
> I think the comma syntax is fine (there's precedence for it and it works),
> but agreed on removing some of the tabs.

Ohh alright. I'm assuming both of you are referring to the tabs before
the colon ':' ? 

As in, is the following fine?

struct arm_smmu_event {
       u8		stall : 1,
			ssv : 1,
			privileged : 1,
			instruction : 1,
			s2 : 1,
			read : 1;
	.....
};


> 
> Will

Thanks,
Praan
