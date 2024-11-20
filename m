Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C71AB6CD
	for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103199; cv=none; b=pcFwJ11e7OPWl14SwO+8Se4o7yR1dh/na6US4UBmsW/zgE4N66t/ZCA3AQ/h6XxFJSbimirzKusTPHZlViqmcvSPrxEfVOxWXhSiUeEtej8bgEEx41hBaP4xhjw0woBdKJxnpSy+zaex7mHZhCcfrBIbWsDytkl6Wk0iMMDQRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103199; c=relaxed/simple;
	bh=rp++6jPnff6NA1IwgyTxHeQ68PGUF+Hxm732a8dtNhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzqsP3V04dJDzcOAqRYHZXfNoK6mqJZmLxXQRwQoZHtKDcX6F9loIjWfpptmWeAVhTCdX8li9B7VPXxP4pccL623lZWecxU8Tm+/HFUE+lKJYvrGUmm1OB1TkuZVPTO+OSp+ReyFLx5b8Xwb+aSdbUeBwZgPO/KLj7CX4pPNXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwmApfeh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwmApfeh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21238b669c5so308375ad.0
        for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 03:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732103197; x=1732707997; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ1cN1/CIF2wdEOQRrJY6MAHjJdHWlc6/1ZMs08CxD8=;
        b=fwmApfeh9K/Dgsk9mcrAtTrxFKSD47SdWs+xK5WuzZta0JVrglj2U4GFqVpc15Y8GU
         AhGGu/pgvNSgSIfLTpJXoCiNVPuaHb58RKKjGV8kPfmmPltrZ+Fb27F60JzONEaP8tjq
         Q3XfQVWSGGEnIPTHF3EiWcl03pcdiW28DblCfmEMIN+vqtHN4VrPe9e0FNW57rJlXdEG
         tErGLkh2oHUyKrW6misACkz7VD6lSv3dn71noVBCR/bmKtfnAQA37fdkYi3TK7a+VPMi
         cu4ZxYzKxv2j7S8SqwzHsJdJXir++RXg3M0872RZtr5D3x2jEIPLDKXt8E/rg9DO/sa9
         y/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103197; x=1732707997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZ1cN1/CIF2wdEOQRrJY6MAHjJdHWlc6/1ZMs08CxD8=;
        b=AkeeEaP10PTAwyKKDNWVcVpSFkdsUp6tYsamtEMswd3bia2YQF78w+U8F/0DTzJQWQ
         C+OGi72HpxcD05pMztWMohCAWTdtCaH9R67XioPto7gOwHcsd0Q72x18bY4COKfnhe58
         DDInTxB4dhFdvoHEpFalRP8pHgATWiaIOCCe+LfL14zIM++pd6sowUmAaENkz0r0elhe
         1GIw3KxyaDp1G2nIvHAnYetbkLqMTffNhFSAwzoNWneFNC3TIA2M5BSFAmE+MehPtqmM
         GWZjF8XTTnXEab1woBWU/UXAWBi2scMWHn7H71+iY/aSQ/Tn0ME78lFsVI+uZ3MkFoOX
         +2AA==
X-Forwarded-Encrypted: i=1; AJvYcCXjnQr7bydmBuSs1H+R127N6qTl4m7xL5D14KXjpbK4/gNBw3p2fV4Y6voRRG3q0aXTBGbxIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykeFTL0FDvN7ZYigJjThLaBqEMd3sE1Gt/PJouQUv/pc+W28vB
	C6uBHzLEcrSRRxSFvdkZIzi1uoupommnWZmamLdZA0++3FbgRCE9cs6MP7Uhnw==
X-Gm-Gg: ASbGncslzSv62IzJHeEQ84FDb+5oUzp78I+uORc22Uq3Tj3AorVZLos3OddkEptzMu0
	98Xdwn1fg8cpeShkbrHXjJudy/WrzeRELsEHnIDBmopN+c0y83XV6uge0f0+RKkNTD/eU0ry+77
	cFHBkXDTG2cDgJOkKTW2k6iQGim4zpHZ5JYF/RxXUbkkutE2TWDyC/LXwyYj/GxZnmoWoJLrCUl
	QI6q7qzwTVB4B54bCM2fy5KGq2CVb9NB9xtMewN4FGd27CqEiIwy/ddeGyBjk7CukRvmL4iVuBc
	sNi1vqMrvh0=
X-Google-Smtp-Source: AGHT+IG0kZHQZQr8PstnJG6ErHiAlyKMnwdCaVpenyqj2Izkfqi20R19qkmuUNSVklZw2bzNtxsrRQ==
X-Received: by 2002:a17:902:d512:b0:20c:a55b:aef1 with SMTP id d9443c01a7336-21269ee7d2cmr2338395ad.6.1732103196598;
        Wed, 20 Nov 2024 03:46:36 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead035f176sm1099785a91.32.2024.11.20.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:36 -0800 (PST)
Date: Wed, 20 Nov 2024 11:46:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <Zz3MFIqALz6PITbI@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>
 <ZzdJAFc_8h6LfVL7@google.com>
 <Zze+VFpGNaXepFWC@Asurada-Nvidia>
 <20241118162442.GD35230@nvidia.com>
 <20241119090307.GA28466@willie-the-truck>
 <ZzxaE6yTt1QpFJz6@google.com>
 <20241120095607.GA29295@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120095607.GA29295@willie-the-truck>

On Wed, Nov 20, 2024 at 09:56:08AM +0000, Will Deacon wrote:
> On Tue, Nov 19, 2024 at 09:27:47AM +0000, Pranjal Shrivastava wrote:
> > On Tue, Nov 19, 2024 at 09:03:08AM +0000, Will Deacon wrote:
> > > On Mon, Nov 18, 2024 at 12:24:42PM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Nov 15, 2024 at 01:34:12PM -0800, Nicolin Chen wrote:
> > > > > On Fri, Nov 15, 2024 at 01:13:36PM +0000, Pranjal Shrivastava wrote:
> > > > > > On Tue, Nov 12, 2024 at 03:30:58PM -0800, Nicolin Chen wrote:
> > > > > > > On Tue, Nov 12, 2024 at 08:30:16AM +0000, Pranjal Shrivastava wrote:
> > > > > > > > +struct arm_smmu_event {
> > > > > > > > +       u8                              stall           : 1,
> > > > > > > > +                                       ssv             : 1,
> > > > > > > > +                                       privileged      : 1,
> > > > > > > > +                                       instruction     : 1,
> > > > > > > > +                                       s2              : 1,
> > > > > > > > +                                       read            : 1;
> > > > > > > 
> > > > > > > Feels odd to do so...should all of them be:
> > > > > > > 	u8			name : 1;
> > > > > > > ?
> > > > > > 
> > > > > > Hmmm, do you mean something like the following?
> > > > > 
> > > > > Never mind. I see amd_iommu_types.h does something just like that.
> > > > 
> > > > I certainly expect to see the u8 repeated and not use , for members of
> > > > a structure. Also don't add excessive horizonal alignment.. C code is
> > > > not excel. :)
> > > 
> > > I think the comma syntax is fine (there's precedence for it and it works),
> > > but agreed on removing some of the tabs.
> > 
> > Ohh alright. I'm assuming both of you are referring to the tabs before
> > the colon ':' ? 
> > 
> > As in, is the following fine?
> > 
> > struct arm_smmu_event {
> >        u8		stall : 1,
> > 			ssv : 1,
> > 			privileged : 1,
> > 			instruction : 1,
> > 			s2 : 1,
> > 			read : 1;
> > 	.....
> 
> I was actually thinking of the whitespace between the 'u8' and the field
> names. But this is silly nit-picking. Please just follow something like
> the use of bitfields in 'struct perf_event_attr', as that's a readable
> example of recent-ish in-tree code.
> 
> Ta,

Ack. Thanks for the reference, I'll fix it!

> 
> Will

Thanks,
Praan
