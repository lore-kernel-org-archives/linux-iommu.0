Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAB311C36
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521303; cv=none; b=LVovfPK//ED05Ln3LdKQtylVQPxARjw2PZe2KuvHTI6GfJD7h3Em3fTV7l8Mr1fy3ZrDxmq3mY2sBLfZs05u4l1ntXXNfFGhg9yggHpstfYwdYxc9dgknFmKmGx20FjQfgoOzDt7ssZGrH3jatTI+rsO30QN8ZdmIX9qQNMNx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521303; c=relaxed/simple;
	bh=xCvkHIm7qec+IuTZyhD3i3j8fJiu+BYGzrZ6a014T/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBGiSfPldOYAGn9zKurDi1c9CdTFuzWAEUiFRUOIjJzdiMxWZKS+HkAKw079puzod497ycYIyUf6UVeDssyhFyIIWlApnNSNHNrOIBG4T9IQSUmrhcNI9c60VlfH8LvmLdV+5FERfMLUaRbwJD+vcv1k7qq3QevyTLAAcjQtpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PvFShShV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PvFShShV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-470ff2f6e56so36465e9.0
        for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760521300; x=1761126100; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7gNIafNOAAdT8vVW1v+tnHUrlaQMtRV3mgcHVHcyVA=;
        b=PvFShShVw13F2hPCyIVj6nC+dhaAfhmkwT+LoM3h16w28EXvT9vUni8+PqSOa2gdTH
         H3DtOZqud7TDuamy1SAjWMoD3UO/XHu9bzKFXH+yfUvwyOMEZNKy+klh6aIgo4aubW3U
         F8/H5W/vfzXkUsiCaFmq7v7ulfI8Sd7Y0Lq/+tZI3aImOhmjqPHePuDksNyJbb0PNqI+
         gnOc0rZ61PKiw6Aw4mT7K/GngBpELvNWAXO8V/z9GwT/Xt0LCiJHP3Ztu3XN9gZv8HD+
         8vXTyXfR6r/B9DR43OoOfD8xACAyP7Zl2YLldNWil1x13gpdiX+nF3JHU6jqogEEyhSa
         OzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521300; x=1761126100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7gNIafNOAAdT8vVW1v+tnHUrlaQMtRV3mgcHVHcyVA=;
        b=mGkI/EncwVBJx56qxQhdvZhZzaDT6KwB2b9wtoY5w1VWeq4R1+A2+Dcsc2iG7LemRy
         1wJ82u6DZpT1/P4eqUhQZbN/olkN5p5xuy8QqpDms1GWCaVJmIrkVBXxff3Q/vbivN1b
         asMkmOGT9e84LjT3yIRFUM9/+WULs1O5cim8Pg2L+KTn0szyX8h0v0c3kiM0ddfLZ8LX
         B2E2exrI/EEotsA/qJHAjYGMW32iXgYLzqlUY5wDpuk+XFIOAXc1vg3IRDGPByCZ89/n
         9XaozyUtJIwuamjcJcQzTN6jJ24gcGOGSEIk8DpW1kKIRI0g7KArgZaFckZFT309CbQf
         +duQ==
X-Gm-Message-State: AOJu0YzCNkmdmuPPF9yqdlWlDMAHcJpcPqZDSZYdUzC8W5PkZKKz5dH6
	RHwgetp9ZxvBfM/UDAt8gDLt8rFl56OpWAYEzlLOkf6N3+vChdKGAQ6fEZgtdsRa8Q==
X-Gm-Gg: ASbGncsRUXeBzYVhULD6Yp/ycevMbem73Nmbyq7bRd/Sbu5s4+nL1mRK0fGDjQGJgIS
	3cgsD5Y/sEcYItW62fINZjDiH3ZRpE9exX4rsm0jCJn01fGoAmEi+TRU9dJ2gztT16UfC4zA6Vv
	u8Piv/C+w0hx3+evSGTJkVEQUCtFkE9/WqxKAu45IeZbqU/liKteF48SPmscEZksdUe9oaf8zJ1
	7kvwBFgo86pA73Cf8kK4eU9sRObsjZSqvD94a+rD12cLibs7A0T9a1EISn0RJTkA4t3s4RKEndg
	4mQg/aV5KT8/6v00gcFghvijyTomTNsBcbjujy9Nh67gsCLee3ikVXBGwAK3Xs6kMfVyGbVnXmH
	kXv4c0x+g9klFE/9xZLA4ntQX6DpD93cDkfTwr5DEy2kH9a9KYmFExyFCIrzvkZHVR++fGyVEm+
	4GJW0PfVN5KA==
X-Google-Smtp-Source: AGHT+IHR5pyr1xnwIimpgjpOhjIZXkvm+AJq3ntKDNIiM5QNlOCKNqqBRMSb2N3JBImOJuWcOi7CEA==
X-Received: by 2002:a05:600c:a316:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-470fd76ca76mr1181095e9.4.1760521300016;
        Wed, 15 Oct 2025 02:41:40 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm28388114f8f.34.2025.10.15.02.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:41:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 09:41:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org,
	jgg@ziepe.ca, praan@google.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 1/4] iommu/io-pgtable-arm: Simplify error prints for
 selftests
Message-ID: <aO9sUNYmOg9W2Vru@google.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-2-smostafa@google.com>
 <526186fa-d17a-4b79-b51d-83492b19c941@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526186fa-d17a-4b79-b51d-83492b19c941@arm.com>

On Tue, Oct 14, 2025 at 12:09:56PM +0100, Robin Murphy wrote:
> On 2025-09-29 4:49 pm, Mostafa Saleh wrote:
> > At the moment, if the self test fails it prints a lot of information
> > about the page table (size, levels...) this requires access to many
> > internals, which has to be exposed in the next patch moving the
> > tests out.
> > 
> > Instead, we can simplify the print, using ias, oas, pgsize_bitmap
> > and fmt is enough to identify the failed case, and the rest can
> > be deduced from the code.
> 
> That is the same cfg information already logged at the start of the test, so
> if it's not useful to dump the actual internal details of the ops then just
> remove the whole function and make life even simpler. (Otherwise export it
> or turn it into a callback.)

I see, I think it's better to just remove the whole function.

Thanks,
Mostafa

> 
> Thanks,
> Robin.
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 7e8e2216c294..00218af5d5f7 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -1299,14 +1299,10 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
> >   static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> >   {
> > -	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
> > -	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> > -		cfg->pgsize_bitmap, cfg->ias);
> > -	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> > -		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> > -		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
> > +	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit oas %u-bit\n",
> > +		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
> >   }
> >   #define __FAIL(ops, i)	({						\
> 
