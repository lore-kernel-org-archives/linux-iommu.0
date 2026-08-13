Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23987346A07
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633931; cv=none; b=A7mL9gTsH0i8WB3703T3T70ivx80yQFp+BIhiAWnj3pX9Tfdz3jG9uBErTk94H9W2ldRQL7gm4V16dq20dCV3xNkvSZ25ccrnsDkMWFS18xbWWBg8+LxGKmnkXp97iNyetBenk0BimIOYeWxusdvRxkjyXEOZnTohGaJtCjA7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633931; c=relaxed/simple;
	bh=kh4zC29toRXjwtuA0yBHRcNgVKlbLvrLAXcDzghJHFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9P1opfZDS5udU/vGvn4WRlx1081/Zz73eucARJMl5uDIBSwTxetjisgdYeR8mdJnnfrUvkxJZlDIbvBDGOfTAf4ldPozAFzDzCp8Z9Ha+TNMNtzkeEsWIVVsGRrW6k6bKLS+GZ+bW3WsrpFHOKcHM11tNA9ppLXQpsy20WQK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qp8FXydi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qp8FXydi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-498012a61f6so46165e9.0
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786633928; x=1787238728; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIiI9SltfPrXcp9GxH8c00S+yO98PCAJKDJI9QVodgA=;
        b=Qp8FXydi6QhTptiIqN+KuKoZEUxSHOrwFVRyZ6hp5Zh7VutuGuQ4xBm+IZsv0bbkI3
         oSdz4MdTysXV/jXAZTo3P8WjIKFquRLyBbA33kdPGSCx91BhiKvm0PVA2R9OQsY2jmMj
         xYFJJKnGga751Eylar9+6ifvBjewHMmnoUSTygsb1pQg6H3/sFgCaqtUqYBgbfR11++O
         TraKEOUzeL8WzI8DWiIxLBgL1p5xrl8JVJkTA0TXXBnvQQf6pOJ0Z4ApZyuEtokbwpXf
         9fsN7OOF3dA1VhqPGClfMw8tGgb4c+zAqTnWvJff6Axr8h7IvktH0MZ2u14B0COwwmzb
         burA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786633928; x=1787238728;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIiI9SltfPrXcp9GxH8c00S+yO98PCAJKDJI9QVodgA=;
        b=eYoFybimL1dl/Lo7n/q8kNROv6mRei5HZsqVwh61I3JVqOSM+fRxYYWSHNyAFXIXPB
         xuVyFTwg7nkBMX+T8GZ/6iU7ODTZgj4rw0voAw3+mHcXYdm9Q3FiNuY3YoqdXgCWAk8P
         3lhJJcXngV12dVECIOBadQAmNp9OfhOqaa2QyIqTxEBk0JdbJGUhA65og6FAdt+ejweC
         RF4/lUmN45E4SXM4ROYuY5spUvvAE1/eHBn776J0Q1Gc28IX8pwYuGrdrDpifA5Bd+xE
         HMWdzbxhmfwh4hNqpezOxYo6mjpm8C2N/AXSHK4QVV9iPOhmjG+ULrHAS8b/NWrLOEOT
         igvg==
X-Gm-Message-State: AOJu0YwavNwKhFXn8gGW/zwgA8+oV1Qxo1CheEHP+H3arkwQFdICGBYg
	mzx6+Q2G0pWJOVug0PgOF6z41Y3Ie1jKJQvJ6NxmRlL69O5LNphZ4Wd4GNPyvB+Gxg==
X-Gm-Gg: AR+sD12okcrxppA+0AtLDluB5/itC3ej5w4TwK84JbdSWMnULUaZGDcy5GpIoYZQSMq
	YOCPoBj+Q5yxV33Y7UvpAaKAgb0xuTbuyARqTr+65Neo9dWgCpneS+hX4xYc6iHvGOt9jRV3psq
	rKjTMcJjEi/V//ziHgjQt00hzytiiWC47VjocW7Ka4Lmmvlyv/wo7x7NQI4agzrSct9Bn0vn4kn
	mzbBgcrXyuElZlxmZIUZFD8TS+5WGAPm6FzZbcw0P4Vfp9JX/DKdSxdbneEXXqp8wjS7H6phZd3
	ZWt9Im0GU+9QK9eLF+27bI2uv4153u/+RUdTf84yGcP4IYKT4TE+1v6l2neBQSFMa7kcIJ8Hfy/
	DTOZuu9RQhqnWtcnppaKzfQvK48NHIqOSvEk0KPO1XMzFdbY78yc1dVgY32N4/6Ybm/3dXEpDqL
	VoNSerdpwMZsJEm0X52Pou+VMjaqvKhTZMbiEMvVlNz/h/jDqk+5lFk3JYY+dTLDo/1T3CXzvNs
	Lp5cn6sopPGBImfABFEKaiJkRtzSQ==
X-Received: by 2002:a05:600c:6094:b0:499:83b9:4e4d with SMTP id 5b1f17b1804b1-49983b95116mr892995e9.0.1786633927802;
        Thu, 13 Aug 2026 08:12:07 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cd7ecsm7938f8f.36.2026.08.13.08.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:12:06 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:12:03 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 3/8] iommu/arm-smmu-v3: Optimize range invalidation
 for latency
Message-ID: <an3ew9xbnLe1dr5g@google.com>
References: <0-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <3-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <akzm5BoV0rToJ7ij@google.com>
 <20260708001058.GA422027@nvidia.com>
 <an3MSKEj7VhT4WkP@google.com>
 <20260813141320.GF730363@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813141320.GF730363@nvidia.com>

On Thu, Aug 13, 2026 at 11:13:20AM -0300, Jason Gunthorpe wrote:
> 
> > Sorry I lost track of this thread and I just saw v4.
> > 
> > In the mobile space, I haven't seen an SMMUv3 that does not support
> > RIL.
> 
> Oh? That's very surprising, AFAIK none of our embedded chips support it
> yet.. Even the server chips are only just getting it. Are you sure?

Yes, SMMUv3 is getting more and more common in moblie HW (opposed to
custom SoC IOMMUs). Devices that I have seen in the market in the
last couple of years have RIL. For example Pixel-10 which is currently
getting upstreamed. Also, I have a mini desktop with QCOM X1 which
have RIL.

The only SMMUv3 I have seen without RIL, is an old morello board I
have.

> 
> I gather it wasn't even available in ARM IP until recently ish?
> 
> > However, I have seen workloads that are really sensitive to translation
> > latency (display, camera...). And I'd be concerned about those
> > regressing.
> 
> Yes, those exist, but again, they are already facing these problems if
> running without RIL.

Yes, but my point is that those typically support RIL and that change
regresses them.

> 
> And, for the common case of putting something into a carve out region
> it is not so likely even an expanded RIL will intersect with a
> reserved IOVA that has a high alignment.

Not necessarily, those devices can run with a small IOVA space to
reduce the page table walk length making IOVAs quite close.

> 
> At least the things we have built are calibrated to handle a TLB
> reload occasionally. The isochronous TLB's are not even sized to be
> never-miss for all cases because things like 4k media require such a
> large amount of IOVA the area cost is too high.
> 
> While others can do something else you are reaching into a pretty
> narrow condition to hit a problem:
>  - HW that must have a never-miss TLB to work

I am not saying that, but we shouldn't over invalidate TLBs either
when it is easy to avoid that.

>  - HW that doesn't have a carve out, or has a badly aligned carve out

I do not think a carveout will help. But it's a very strong constraint
to enforce carveout on all devices specially media which are quite
complex and composite by nature.

>  - A SMMU that has RIL (non RIL is already worse)

This regression only impacts RIL, otherwise it does not matter.

>  - A non-isochronos workload that regularly exceeds the RIL/single
>    expansion thresholds
>  - Unlucky IOVA allocation that places isochronous near other
>    workloads in the IOVA space.
> 

It is not just luck, it depends on the IOVA space and access patterns
of the device.

> > There is a clear trade-off here as you mentioned with TLBI latency,
> > would it be make sense to make that behviour configurable from a
> > module param?
> 
> I think it makes sense for a driver to indicate to the core code that
> it needs isochronous and we can do more global things like change how
> single works as well. Having an isochronous flag on the domain, for
> example, would be a good overall direction.

But according to what? It makes sense to optimize server chips,
but that should not cause over-invalidation regressions on other
hardware.

> 
> I'm inclined to leave this as is and let someone come with a specific
> problematic HW, rather that try to badly guess without much
> information if it might popssibly be a problem.
> 

It's not really a guess, I mentioned some examples above, that I
have seen problems of translation latencies on them.

And why not the other way around:
- Which uses cases can't handle few RIL commands?
- Why those drivers does not unmap memory with a granule/IOVA fitting
  to RIL?
- Why those systems does not use FQ domains in the first place?

Thanks,
Mostafa

> Then we will know the HW and can mark the driver as I suggest above.
> 
> Jason
