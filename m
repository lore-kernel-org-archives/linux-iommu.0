Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1338D407
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679339; cv=none; b=P6nEBZNxcF8M1We5QwMFhhm/9qlRFuuTW1v+lpo2aopiwWYLcQd42CWo1EMz7TxoZEPRi4TtI+r7G/VVaQPWlOC8sm+lprHI7ONAOQvqkpmMv+Kdy2+Q+a/8m6mXxXkGRsiQDU30UvMSwRWO72AXzV33vIBt7WXJqeCGaNFQQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679339; c=relaxed/simple;
	bh=VGDDNEzdcpOazILVBmVrGlbpQtUqztuHvLbCit3KQoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWFqnDeKhjQmJ9zp3ySz9dHKfTtGTOz2mDilA1rA0lYYrro+PtnhzDzVgGNbc7VWRShqZsAmMVLhVUTfGQBLqvFmGCgFczMKFaFGkLbEekUcSeHmEWWbUotrIok6yv4BPCtApWWPS3iP4grrPjMFWAXlBK4mZ3WVwJea9HtjQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdrFIPw9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdrFIPw9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d3b440b97aso7295ad.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787679335; x=1788284135; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gwb8vYO3uznd15Zsf6rDYA4qtHhV4Fr7KW8splPiq7U=;
        b=SdrFIPw9Sjl/zHVC3bR4Fx1JmYM3xVtlSS2uWa6gYobqiAZmyMr6Cgndpylhok81Q4
         hQq6mshkYV5B3m3+P4z8nzWxk+EJ1fDqfLo+fURbjeDC/8aHmh+qe0Wa0X7mHBKIFFvA
         yZNYXIYTzwmshZ4blqDgAiuM1ZglRsSXT3DfR2hVbUGIkO3HcK0jNk8TxT1B2J026azr
         YQmnVh/OZh21zY68GI8Z85oHR0v3hykoBTYRhojuxGPPBXi7/UVJtRXhASqGRS4kSJu3
         YQ3DupvZKCHlAVJGaocqFQP6F9phYAVR3yhgRMsrBL9LgkCUBAZNH4AF6fgP+9Qmfw0Q
         3B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787679335; x=1788284135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gwb8vYO3uznd15Zsf6rDYA4qtHhV4Fr7KW8splPiq7U=;
        b=rKdLavbuxpKNap6xM2X4WWdQ6BHp/bnQXbPG1BZO73pG3b6dbF3+rHCI00dWJWOOQ8
         aDiZ/5nxyE5lHTs6iJqrLcKxMpL+jmLf+drLqeoyP91rWShF60jpQak47q4bYAR554km
         k7iR5qXvAg9ZusdosBs5DkxlLQmDPR7cRwlzvECL/loEHd0pWYHWJxi+zKEHLguuoFvq
         bYUh16EejPpr3lDfP3ZO/z6rljwE5LeBZkeW4eAHcrY7Qq2LGhqhuuSKkdXGZ5LvAcp6
         2I1TpH55TEVfODYAupRrn6SnoVH3mDFkf9Px3X+18IwymsXrL2RkXOvEcymGhJ7hyGGS
         4r2w==
X-Gm-Message-State: AFuF++n6cNomtH+IQXuOYUcmO3oBDeY0kQLCA4KwmDnm97MqPmJT/DJm
	biRHQXoOyyL3SuY88yTNHJrLvcqqJIJ9XMjCd476ce5H/i5AxsgatFOfVL/g8ivFxA==
X-Gm-Gg: AR+sD13lFfGN1ua8oVKUzg2V5f4deh4kReerYuw96fg2eiTLiJrfERZVcF9H6FkPLxz
	yJPoRTwTt/s+vOvYXv7Nr5Z5W2WDM4X0Oi+TgmNcKok4TAhlZp5FKMI84bLGi6wQXnjVFvyyiyC
	g21xVan/SKoKDJbq47QIt2ZRgNlvly3qWmXawmZNEkhw19n+eJdfYbZ+ps5QLXdkBBJLv5Rk8Kn
	78hHcivGU5vmax0uN1ZsWOL8SCKhW6cPOir5fhPMMVF4+CLgCbZNbxkjYtVmDAi3+jctwsnecpo
	kTt3ZALvrtiAfDEEMNFlsFwRUe1KADSHMtafVWB6eXtfhEOowDEXvNIEaHy02a5sUUmY0emVKO0
	LuBHfeBoDsHLLTgaSSUiHwJO0jRLi5NokO3bWn6QkS+igodgIhIjvv7eRjSBUGh3A1Yflpzqt44
	TEgsmwWyOdyAWlo3pS7EYPlP4ZjRdU/EW07wtmbJGhMh7PwV5QPHhyFJj+vuaO6fC9cfunw77g/
	JbCvJWvQw4z2HanQUjfQeDnvA==
X-Received: by 2002:a17:903:8c8:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2d6e0518b75mr9553085ad.2.1787679334305;
        Tue, 25 Aug 2026 10:35:34 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668767d65sm579978a91.8.2026.08.25.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:35:33 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:35:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 01/12] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
Message-ID: <ao3SYLiFAQnsfJGb@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-2-praan@google.com>
 <178767577112.3356902.15076197547390630060.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178767577112.3356902.15076197547390630060.b4-review@b4>

On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > [ ... 84 lines skipped ... ]
> > +	/* Setup interrupt handlers */
> > +	ret = arm_smmu_setup_irqs(smmu);
> > +	if (ret) {
> > +		dev_err(smmu->dev, "failed to setup irqs\n");
> > +		return ret;
> > +	}
> > +
> 
> The sashiko remark makes sense to me, we should not enable interrupts
> until everything has been initialized and things are ready to go. So
> this is better done after the device reset call, which is the thing
> that is setting up the queue pointers in HW..
> 
> I'm not sure what to make of the MSI register ordering around kdump
> comment.. Nicolin?
> 

Ack. I agree with Sashiko's remarks, we'd need to call this within
device_reset right before the SMMU is enabled (same place as today).
I factored this out to avoid setting up irq handlers multiple times
across a suspend / resume cycle (for e.g. we can't request_irq multiple
times for the same irq). Otherwise, we'd have to de-register IRQ
handlers in the suspend callback. Maybe we could do this ONCE based on 
some smmu->inited bool?

> But the refactoing looks fine to me
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 

Thanks,
Praan
