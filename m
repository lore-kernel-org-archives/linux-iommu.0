Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406F1B85C2
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990806; cv=none; b=hK1ZbXnALmc96fXYqJEruvmx5+L5s41tOfVgwLT9PAq9K34Za/Nt/QOCZyNBtRRsAbjAJDfApz5IDVMkPswJUXBdtL3ndd9oVbuco6ITUjf4vWGDU0LI/Z75Wz+3mU0vLMB8jVheX2t8ucKrXBD6HxSD0NQkPU5e2S9RScLKZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990806; c=relaxed/simple;
	bh=8OMFa8UYxV13W6GTLp4d2jhCFDVnab0v/lWZxuKPqKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6ZlfXZXol+3sXw7KZhsYv+mrhfY1bsekLyXop9xPd5I9fzlSW9j4Zpyww4XiXCrC34BL/skSfbf0ynRtyPn061w91IQH2yWLJziqI1ntOActHRb7T/AL5rI7yv67QzovTKt6mWaelA85a7E9MAb1pCEJUDMzgSSYBOF0fniteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SpR7g4sf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpR7g4sf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b3d1a77bbso60865ad.0
        for <iommu@lists.linux.dev>; Thu, 03 Oct 2024 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727990804; x=1728595604; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnPDNzNeLg6fKLMys4hlWiNalo7756TbAjsw1jVexTg=;
        b=SpR7g4sf46GEVSRERWGXExGsipnMPicW4K6goHe/SDhJlysLVZxvwYDPxS/bcKeU62
         RpGdtPjV2m3kw4VcJbs5o6B2aS0zgpmF0TwmynUciuSYff5+1x48HaOwTTB3yaqtUIJ1
         Mbnfvl5Y8WeIwH6YKjNO42exIlP7g2Mz2Ban0GRqK7dhRtBkLDnPHQZO6tpwD3Yu0gtb
         e0JiAItoMyCN4CROJ0YvFjp+78ipwmBwDStBLkmfW/yeQYjOYAdMuha/plzrsjSYxp2f
         rqQBR4OPoXRNyrguEFFQ+gTUVxB+6zdv7Ek7JWGKHY+Wwwe88pASR3uqb5V2KGTKs3Kw
         HOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990804; x=1728595604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnPDNzNeLg6fKLMys4hlWiNalo7756TbAjsw1jVexTg=;
        b=RGDzZcu9U/tAVH7Nnh07VknJr3SCItxC+6ylT60nwRbmnngYtOmzZohxvrLiE6rfdy
         4YPrWbILRtEqmOpQbFqbwN+TSyPwkS/ccCRccv8XVTpPjXBOxUSXsYnHEQBMqlVfhXY5
         GNJ7SdNbdXIgrCTdFTkSxXnNfT43Fez+wl4VzI2PrGFc/1meff5Ai/ZRmxXXARNxz2Tn
         JFyRP0D6mbAL0xV2NPPv3TJxdvkOSnS+ngqe/r3Y4FBJK4aIFxue93bKpWlBQNjHeZfc
         +7+XWz0l0risq9j98jPte75WHfeAnjEQlSdut6cIu7gXlS0PQVvFC5sgcpUasijiJFxc
         FwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk3bndZYEti/OGoJMmCm9YDl2TwEXd4x4WEDdHkrkqSaWXgmDQdiYXYYGU2luLT+lKqtEfQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGiJrnmuetxjuwvYywLa0Fgc9kfZCqcwBQEKSruGi0moCCQvHn
	hf7ATx7BLWkvkMg0p3ng/suIeEt3X3yDdS3haXbdvEqXBKHE+2+Jcrvhq/VhUA==
X-Google-Smtp-Source: AGHT+IE2fZQn3gvYsHj4lqwSolTikhBSkYZH3ZDHlQEdSL8eY6en/5cwa8W5bRdG0qD5zjFvFk03CA==
X-Received: by 2002:a17:902:ce88:b0:20b:5046:376 with SMTP id d9443c01a7336-20bffb76fecmr462885ad.1.1727990803973;
        Thu, 03 Oct 2024 14:26:43 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d6dfefsm1899644b3a.10.2024.10.03.14.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:26:43 -0700 (PDT)
Date: Thu, 3 Oct 2024 21:26:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zv8MDB4a_P3Jj6x1@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
 <20241002135728.GD1369530@ziepe.ca>
 <Zv168jJMZpxGLFmR@Asurada-Nvidia>
 <20241002171052.GJ1369530@ziepe.ca>
 <Zv2BRcOjpLSe+1cn@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv2BRcOjpLSe+1cn@Asurada-Nvidia>

On Wed, Oct 02, 2024 at 10:22:13AM -0700, Nicolin Chen wrote:
> On Wed, Oct 02, 2024 at 02:10:52PM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 02, 2024 at 09:55:14AM -0700, Nicolin Chen wrote:
> > > > dev_name()'s result can't leave the lock either, at least not with out
> > > > some refcounting on the struct device.

Agreed, I missed that! Maybe we can avoid reading the master name in the
`arm_smmu_get_evt_info` and move it within the `arm_smmu_handle_evt`
under proper locking? Since the event won't be dumped before it's
handled, we can avoid locking at two places for doing the same thing?

> > >
> > > I found dev_name returns "const char *" so the string source is
> > > likely in the data section? If so, could the result of a locked
> > > "master_name = dev_name()" get away from the lock?
> > 
> > The name is allocated memory freed when the struct device is freed.
> 
> Oh, reading it a bit further, I found kfree_const() at kobj->name
> and some of the dev->init_names aren't coming from static strings.
> 
> We could kstrdup alternatively, but keeping the dump() inside the
> lock is just simpler.

kstrdup is a good idea too.. overall, I wouldn't wanna *accidentally*
mess up locking for logging (no rhymes intended).

Hence, we have 2 options:

1. Read the master_name within `arm_smmu_handle_evt` (at one place only)
2. Use kstrdup to copy the master_name elsewhere and dereference it.

Personally, I won't prefer 2 as we'd also have to free the memory
allocated for the dup'ed string after logging everything in
`arm_smmu_handle_evt` which is a bottom-half. LMK what y'all think?

> 
> Thanks!
> Nicolin

Thanks,
Pranjal
