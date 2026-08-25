Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C363515DD
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683596; cv=none; b=Wrvvp7H1iiN7yp3c0c5zcwfg/Xdyx1DqPIBAERaV94OfrFo8TMiAdUgt+5NQwZLnMbw9eD4SR8yxu3cZdngdy+Bx/Dh06LHtKl18BJVBdsnXHYsf6uvHvNY+fwVOSlQQMYhftRkjg44n4crOz324ltY9H7/Aw7DV8xN/kNYcvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683596; c=relaxed/simple;
	bh=MBAXutSpYxwjH9g4UfLSkmHw2JXLVaEMrHn18gd+ppc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCHzXuCtZqZs3kM/OSgdjfIZOtEtGVMxm8vCYqfe2yWvly2TWePx2guy157eL8UVGXsbXYgdJ4rY3gZrM7a2fPti4jSxToa/8jDTRZ7uHiKVh9FKrdRzLjMgZXSBjMP9RfrMNoRMDHAoHJj4AXs+ToxKp0yMBFzWjWh4MgLKvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9+OEfDt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9+OEfDt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccdf36f63dso22145ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683594; x=1788288394; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d5ZVhM5BdQv8jrNqiOtUyy67C6fu1vs3KMfmpNkDQyQ=;
        b=S9+OEfDt1KQuwsfzNcEza8NCrskZvJ3eZpBTU19wqczfMlhaHR/6EoALE9o8rN8NFI
         AK249DmhyP/omit0BR/LesV1FBsvE0jup9rw23nYR2VLpT/ieeGhwnEgTQkaLODa0ysD
         rsXwQnpFlAX+E2PZNfbnU/y2fMTpyDG4ysc1qk5kufdcbRF4/zLtvxOaHj9vokbz7MZ5
         poyXzvKsh0MIBX/tpZ+mh++xeDVjeAnP0r47lPSBpV/PQF1uh3N1FkeFeRNRbaOORmZX
         Amdc/1FAhHGglvtZEUeU3GktZDNikEnmVkD80Osm0LwDFztsOy9NAHTtw7YVheZiIeGN
         rPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683594; x=1788288394;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5ZVhM5BdQv8jrNqiOtUyy67C6fu1vs3KMfmpNkDQyQ=;
        b=LOJodEAVIY6HxAx7FuG9zWUmH5CigFjz6o26mGrHfsaBYX6ff8nM953TcE4v4WRDfr
         2E7edLnA1M04R7xRhX46FgfxyLmYa+PyyeRpP2hM8F0toTQX6jU4jwUumUL9FoakC61E
         8f2g5Boal+oo9Vw0pYQgU5mUdCxoBDrheOil2sbV9cHoGw7DT5OLgrJ+vqMlz4x89NIm
         7LiMv7jYS24yKBH6kx0/TSw6m+EN2rVeNdmYyYyyV2khuDOncFLTOpYYhg8N5PtxAK37
         ASXXk/PdRSr1wA5mG0F9if9HgrKxI5OYkZ49xUj5DAwQuLprwOrMJZFePnAj3MKpr+CU
         T60Q==
X-Gm-Message-State: AFuF++mFrSsp+kuIgBPoxTERaOCVqNSHhz0y6F9qF+W9EAWlB226V5Lx
	tGQa8zpOLa1zYUZStHAMzq1ACxxC1pwkMezi+/DyjM1XBra+XSj4L5HOmb+nuNVi4oiaAnbr6zY
	OyjrAHw==
X-Gm-Gg: AR+sD10bsOIVUbiQH67Foqmq+lb/tnkQnjEftHVdBK1zAOWGHoeomljA2AfmdfWnQA3
	X41t7qtUynLm6Q9YbTrgtKiFxOPPdcJRG0ms8Oz253gnj0fd0Gxrqcg8CR5BR339zwG4IDCCuRZ
	aqrm63Oj7tvPhJMWJaTwNspOWW4wUfLH7GkYzNfudlIe+IkCEzD6vcrFwvALHRQOt/LdDeWl6vo
	JDX5TT655OSlDnx6jNGWOowZZMH1/RAuzaCDjT2cJU4WSy8LahGCRYYVeoNF1vxJxKRCYO63Ipf
	4V6hUqxDYuFLdDTUuMan0YcohdIbf8JHX0XdaZzrHOTgcZ3WJ4N6A2NRb73dMNqKYc5EsZavCGo
	hFQ/mxEHqA+33TcKV4AlC9iC0EiTcrD+/OJHOhM4Xu67uvJjQBAN4DY86XEc6CQCUb1+Wl84BM6
	i1TCe+DA90lRnFsWwX2ck6kudPmF9wVo0k7+QPaluTLYwqgerAWfyoTmn9eHyDOH4PzOk/R26aX
	J8Z4FVxuOiChoSEW3pDLTlKRjJo1HtneCqe
X-Received: by 2002:a17:903:1212:b0:2ca:4bb4:4bd with SMTP id d9443c01a7336-2d707b56b7emr456705ad.5.1787683593338;
        Tue, 25 Aug 2026 11:46:33 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d69f74sm4422680a91.14.2026.08.25.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:46:32 -0700 (PDT)
Date: Tue, 25 Aug 2026 18:46:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 08/12] iommu/tegra241-cmdqv: Add a helper to quiesce
 VCMDQs
Message-ID: <ao3jA8HjxzaGqby0@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-9-praan@google.com>
 <178767577113.3356902.12387755135854957596.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178767577113.3356902.12387755135854957596.b4-review@b4>

On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > [ ... 73 lines skipped ... ]
> > @@ -467,6 +487,14 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
> >  	if (!READ_ONCE(vintf->enabled))
> >  		return 0;
> >  
> > +	/*
> > +	 * Gate all vCMDQs by setting the STOP_FLAG in a separate,
> > +	 * initial loop to ensure no new commands can be submitted
> > +	 * to any secondary queue while we are waiting to drain them.
> > +	 */
> > +	tegra241_cmdqv_quiesce_vintf0_lvcmdqs(smmu);
> > +
> > +	/* Now that all queues are safely gated, drain them sequentially. */
> >  	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
> >  		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
> >  
> 
>  [Severity: High]
>  If arm_smmu_queue_poll_until_empty() fails during this sequential drain, it
>  returns an error without clearing the CMDQ_PROD_STOP_FLAG that was just set on
>  all queues:
> 
> Make sense to me, the earlier patch added:
> 
> 		ret = arm_smmu_queue_poll_until_empty(smmu, &vcmdq->cmdq.q);
> 		if (ret)
> 			break;
> 

Yes, I plan to treat this the same as the primary CMDQ and move on 
instead of break; I'll address this in v10.

Thanks,
Praan
