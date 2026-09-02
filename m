Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD944AA004
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365065; cv=none; b=Tj/hIX/EOe3XXO7XQPBIcy+ST6L4ze0pqjkqpkCdhRWPAwCkzraU9eUqrF8TiaXjKyerNGnvTnDpRaCxp5vitretVDqtShdOk6tF/qYSKs4Qkk7yz0bhHSVavjd2yXcoxvEz2Lq+NNUADPGVRkW7coC/fk0EO+eoiZN1/deicnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365065; c=relaxed/simple;
	bh=yR+vADeY/E+y9Yh0xh8cmEqHmOwpXwRRsABDw+OhvW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3/ofri9ElkJ+vEf+v0xY3DUsMrPueYpePYluB4nOe9vLfMWvKPlU+GWepRTVXvfZJHgxbnY+FLMBZ5cDyDcUYuC4Fe92o57gIVr4k0LJZ1YtlByb1TScc6ZCw7Q5V7BreyQkCr8Yl7tHmg1z94vNdj+j4sAS562jqV+c9efo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4h02lGR; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4h02lGR"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6aso54655ad.0
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788365063; x=1788969863; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s89HKPvU4YvoN9YtsXsmTL/PEt02chX0FDoHKTym9u0=;
        b=C4h02lGRmzj1mCabwLj2MnXNWEaEw2LeLe5a4y7u8lbhcD+wA7xBiJNvtVszjr2vTV
         mPgLPBDGnrpeu+r9xX4AAenRVX4BtjPazyYBaXm0L52yBMXJGq6Q7uEWqHvSbxc7092g
         fU79+gVIDL8gpuCCHWoz/ilbXykXh/X0ep04ZtKsLkVPTB/Xcrki5eLiLHStbWWXykeP
         l7iZmb515EtbE0+b05+ScNZICadakmXJ4nr96jJy5bf992PwwuaH61vgDUScwT+Jcxlp
         yGLbXNofUhvqn4PfMmG1V4AaGt3cvROoMxH9ZVbnkvlV5iSciMeMNA9h6EQhD5Wuz3tc
         K9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365063; x=1788969863;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s89HKPvU4YvoN9YtsXsmTL/PEt02chX0FDoHKTym9u0=;
        b=JNAR7f0S4SfTVjsahi2X7Mh6eRVAHaNqwjU1sHDoMYIxGdS/3b9TlzVPwlVgCVXwoi
         /szPDLATyH0cKlPNOTsgP7fMSPA3oLmgY3pj/bze2jwifd3w5v47BfXxv38WcX4qyrw4
         UFMVRfBsh83T5w1YGhGVugRPeIuwK+lLAdAQg3f5eOmLOgMWKfN1LcNoMGf0x6irMAVz
         BJuor/aMt8sdIm+Lv05Fln7xl5rLgmeVunyS7CVci9a4dcLetFW5xwFJvbv3wl8gkVsf
         oSsJNV+AINNFNaX5XZFY+5sUqUxvNIrnLgmaOGDM85B/T94j6Ui+dJqjpOmWBmxZ1vEI
         mrPA==
X-Gm-Message-State: AFuF++n+dhbE8Z6vEeuNZrWy2oa5OQkLDjGkF/jwMJmnm7Hps+f7Pcul
	ESjvaFqv/mddmKXZAxz66xYgJExTS7SBM4SESeCq74YBrGHzchSGrqzj6ROVQco2PA==
X-Gm-Gg: AYBFou2cAUSP9aipdG2Gw/BE35NFJxGk9babSZORN2NxdSbo59Ww2OdrQe0hw9IsKKf
	lBGczEfikgIhXO+zeZrJL1oh361pORz2rDk0RIf3WpY36jGPxjjGUhz782XgLwgWlDD3RD9EJeO
	OCzkl7xboMWXufUpIgVtzY+6CaQnyy1YuFdnWXP5LvZE/HK+W8tTL8AZL2iJdQitpjQDNxmnjS8
	zhaCu/kZWHW3HD87RqMOFowJ0uV+X7XKg+sfPV6M25hNV4f1dfQ/ciCzLn4mSwPW4s9A3Qvxl1y
	dQ4/epyBCSDmjeFtlAQWwkiCR+2vIrmIsRt5/lkSbY1mgl6+8WBTimDkIqBTROAv1ZoTdv0VwB4
	S1qxGEdb7gAw8qkTrdXZs9tE46wr0MWmqecQBHyyOsDEJcc0j1GvhxvY/2L2QUz8HLm7xaEgj8X
	sRikvZE8e/1tiDQsNTeWTItTmAAIf+uyaV+Rf1mCj7frQA4r9XynzZENH+ZkyOiMLZadHH5cLOn
	bb4gGV+bcL8qMp2RJBwhtzjgnxfIakDv2xJ
X-Received: by 2002:a17:903:22c9:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2daf6c6b04cmr1950585ad.2.1788365061621;
        Wed, 02 Sep 2026 09:04:21 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd357facsm15774005ad.12.2026.09.02.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:04:21 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:04:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Peter Shier <pshier@google.com>
Subject: Re: [PATCH] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <aphI_yNLYA64iOrw@google.com>
References: <20260902124333.2461949-1-praan@google.com>
 <apg9KNnBSjej2deN@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apg9KNnBSjej2deN@nvidia.com>

On Wed, Sep 02, 2026 at 08:13:44AM -0700, Nicolin Chen wrote:
> On Wed, Sep 02, 2026 at 12:43:33PM +0000, Pranjal Shrivastava wrote:
> > The IOMMU_HWPT_INVALIDATE ioctl uAPI explicitly allows an empty
> > invalidation request array by setting entry_num == 0. The uAPI
> > documentation in include/uapi/linux/iommufd.h mentions:
> > 
> >   " An empty invalidation request array by setting @entry_num==0
> >     is allowed, and @entry_len and @data_uptr would be ignored in
> >     this case."
> > 
> > While the core iommufd_hwpt_invalidate() handler honors this by
> > skipping its bounds checks, the generic array copy helper
> > iommu_copy_struct_from_full_user_array() incorrectly rejects it
> > by returning -EINVAL, breaking the uAPI.
> > 
> > Fix this by returning 0 instead of -EINVAL when entry_num is 0.
> 
> I think the caller of this API should be aware of that and check
> the entry_num. I have submitted an SMMU patch doing so:
> https://lore.kernel.org/linux-iommu/5223275dbc8ef00af233f3fee01efa09e45f26b5.1788127877.git.nicolinc@nvidia.com/
> 
> Not very sure this API should be changed though..

Ack. Yes, I remember the smmuv3 fix. However, I think other IOMMUs would
trip over this while adding support for invalidation. If not this API,
should we add a note above the cache_invalidate op to remind them?

Furthermore, users of the item-by-item helper (like intel/nested.c) get
entry_num == 0 support naturally because their loop:
	for (index = 0; index < array->entry_num; index++)
simply skips execution.

I'm not sure if we should be returning -EINVAL for 0 because nothing's
*really* invalid (and we check index >= src_array->entry_num at places
where it is). It's like getting -EINVAL from copy_from_user for len=0.

I'm okay either way but it feels wrong to have specific users to check
if (entry_num == 0). Would like to discuss this behaviour?

- Praan
