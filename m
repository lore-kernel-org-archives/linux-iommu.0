Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7E3CF046
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161176; cv=none; b=gy8KaCzmXoj91LCcAL08YpY6LVZMhx4X7x0KSwwW8XRoljWmnkR+2NfdLFjMl1d9QzY4PNkxeQSF3LeFlYPiEUA5my2kcQFZjVnmM8Mt+C/A6qz16VqDE5mQKdAM1rKSHMXeMVDP1UT4OHBPgWuUG5FXnNrSrwI/UuBLn4WLiDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161176; c=relaxed/simple;
	bh=R/VezTFuRy+8dCiqKWzNcAEuYbrxxgqZyernvqhVsGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf8d1pO8i6RaR3MnQA1C0EhqP0OzOzivtaRjw2WFhItdCi8P8J75th23vMdFKDXyKtAwQaWF0Z2iilbElCscrRAW2f5LdFHrCj+DZvK8Xbhcsw4PbjInb9eF84A9d+oKRRSI/QdOYlZyQw6ideRKRl2IMI+z97+dkAQvaMlNpvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAXmdWOn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAXmdWOn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae3f822163so2605ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773161174; x=1773765974; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PhBHMQz2Xxv7MfAmXPun1VqA0Hi+0AdqM8NUP6BxeHU=;
        b=kAXmdWOnm2ud8GJyaUWnejH/mUH0ugYz9whCLHIfuydg3twtk9jYsSwpwPY7xKav/v
         WCVnMhpgridnZNt5ig1Y9+6CHOqZSKDJIFFpuFFBRvkJ7DVltwYsXdR4boQFs+fyZguD
         vWt/wrrQHiiEeqjWxP0grNH3mYQbuSorchPiCaPyDtD6xALbd6PaCwOy6oe70MpCAb9/
         xmrTKeYxJIOYWig8aeylHwC1yobnTjEMGWwwqst/Tdd5c0mLAqzKZ0n6tV17/DyKNurt
         vW7y8z984Py3++0OcTsgqiAMwjZDE6IaothbdkIBWE0UaQ+ADJmk/w0uIlaIBuiQ8os1
         mFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773161174; x=1773765974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhBHMQz2Xxv7MfAmXPun1VqA0Hi+0AdqM8NUP6BxeHU=;
        b=OW3MV+lueysmFIciCdZ/xgWe4V8wwMCX+k8zwkavcq+vNhJt0p3G3peLSa6+IeTvFh
         CRMFs/T9JGE172Vx/I/FfWAi1ISP5kQbUoQpHvThbrLavUKdjKDkBX4lvwv1z5bOkLez
         A23cTiZVBogBhOErv654c/PRLToGrTFbnb8r8W8ofm2Mw+HfOOMK19YCnQmizFXp6fGW
         hJm7idp9oQ0pergHrLF174xluCdmqmGHJD1EeLxb6tp3lHK/obEnyMOIcRUH1fipUdMt
         /TYVdWJbwxARCQGiCa/78oCZJXAuGjkY2CuKaz6bVRLt3IbCGGheUUbpsmraHWpOvXAR
         UFmw==
X-Gm-Message-State: AOJu0YxfhcbeYMUGTcM5KoUhhJucqFt6zj2/CYWJX5FP2g5jL/uru4Hq
	Kf/ymh0Bas0YvYUHygu58eUZ5VwNTFlspt+LmNYuWzNyOmx2JRQUqde5U4LVHJDBMw==
X-Gm-Gg: ATEYQzyi51KWzNd2i8P2yVwUO5tHQM2vOJboIj89HOWUWwCnxOwKeCdJf/x3+Zgkkq3
	fRB0ze9nusrlVBxWuXgQ/h0uyFMnAD+4XuZXTn0dRBW/EDl7Z55nSem7VZC+DrJO4BnpVb+A0O1
	CYypv39pTMp+V2l/bA6ML29eYyIX1zIsZZwy+ywQcd1ROpqTu+NNktaRyoO5SzOGukEbQLnZ7xU
	UcupnECOwt4didhm767XTJsgNs5OJSLtDReNGwLbVNtD6GMswjqpbEK2/aMIpq1a+3iR8ck+vly
	w5TQbf8B9fVV92cvv+EPgGRm+yI8siQa8OwKUELEyKNsrMZyvdA4SZXBmNV3SAeX3paItGXLPIz
	JSBBhRwQZenk/FBV+YqXlwD8YC00mY1uwtTMK5XMoynpU7I52zr3dCRjjjLESgBv4591TEzZn1s
	0GagvhE/i9Q13fTMZ9WHps4Kt8HZ/jQNt6DNI3tl3Di4PnrQKju6n3+RW7Og==
X-Received: by 2002:a17:902:e80e:b0:2ae:7d03:c911 with SMTP id d9443c01a7336-2aea44c6cb9mr1860475ad.1.1773161173671;
        Tue, 10 Mar 2026 09:46:13 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a20c0sm17181205b3a.43.2026.03.10.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:46:12 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:46:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: Re: [PATCH v5 06/10] iommu/arm-smmu-v3: Add a usage counter for cmdq
Message-ID: <abBK0EY8LEQJ4wFN@google.com>
References: <20260126151157.3418145-1-praan@google.com>
 <20260126151157.3418145-7-praan@google.com>
 <CAE2F3rD0aoTXJBnS4SPHLEEst6cTvoUxNywRZ1RhdgwNA_0JTA@mail.gmail.com>
 <aa8jkLD0l2WqMnyG@google.com>
 <aa839kz29GIgg_W3@google.com>
 <CAE2F3rDoVUCdc3c0z-jLSijh6cZmVwscVfuJLj6YoP4ZjwF8nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDoVUCdc3c0z-jLSijh6cZmVwscVfuJLj6YoP4ZjwF8nQ@mail.gmail.com>

On Mon, Mar 09, 2026 at 03:56:03PM -0700, Daniel Mentz wrote:
> On Mon, Mar 9, 2026 at 2:13 PM Pranjal Shrivastava <praan@google.com> wrote:
> > Still thinking out loud, but maybe we can have something like:
> >
> > if (owner) {
> >         ....
> >
> >         if (atomic_inc_not_zero(&smmu->nr_cmdq_users)) {
> >                 writel_relaxes(llq.prod, cmdq->q.prod_reg);
> >                 has_ref = true;
> >         } else {
> >
> >                 /* SMMU is suspended, fake a consumption */
> >                 WRITE_ONCE(cmdq->q.llq.cons, prod);
> >
> >                 /* Avoid racing with resume */
> >                 sync = false;
> >         }
> >
> >         atomic_set_release(&cmdq->owner_prod, prod);
> > }
> >
> > if (sync) {
> >
> >   ... same stuff ..
> >
> > }
> >
> > LMK, what you think?
> 
> You'd need to make sure to cover the ARM_SMMU_OPT_MSIPOLL case: The
> function __arm_smmu_cmdq_poll_until_msi() doesn't read
> cmdq->q.llq.cons but rather waits for the MSI write into the command
> queue.

why? The goal is we don't poll at all, simply setting sync = false if
the users == 0, we simply fake a consumption and move on.

Thanks,
Praan
