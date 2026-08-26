Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3CB442B33
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753871; cv=none; b=PEk4l28EC88i5Ki+zb22eQ6s8amVDupva8UhnZPFNpfX7aN3DjRwIUSwB/nR3PPlFwrzqOB8jt020EAne5bpJ7T5NZ++cDuPzy3WtqC/3HIFYYquH/XsQGYUiBF/oC+pzXXctLKm31jKXM0RvSZzyUuv3x4PzwbW9lj4fs+ujsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753871; c=relaxed/simple;
	bh=QxEpA896QAc9W7KD6oWW1DYsRvXzzbGHA/yWTLgGMsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvVI3lhxMlo/M0B6aSc91GLVVTzCg9lfHTYQY96g6jg2n9OmQcn5OHHFfw0FtzNsqLXDh7Hgq1SoBMVbzgXSQg44tyDcov3uL1585BQBC8inFGCrdoRnhWMcdtofwAk18TpByjrr8ELX1S2IZULiCUhpWpOEQBSr/d4QXYIyuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edRasXe9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edRasXe9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d3b445a84fso105345ad.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787753869; x=1788358669; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TSUEMARjEssv0eA3Si6cabXSmTd2euFRyWUa/d4nP9o=;
        b=edRasXe9/nPSy/sOHZY1wdjTtsvuRf0bLJwgcttYLjE1Lrv5S4P/NnqrxffT3nvkRN
         Du1M1++U7ZkaGc7IdjA0pYLCBDQOstyQl+yk6QWPArRJ1Po1p/PrdDphot65kqzNhlK7
         wFHYv+lKSX/y5jNBtrPIPPnFAzlH+1LUoTE2TqHG7TIZEwU/3qlxlW53+MCMbmgcMRc1
         OlnF8dqTB5F1tSxO2uMm64CxJZb/2Y50euRjb9gsykyxcKLjLCkQsbugt8KfB6kfCutn
         k3riq4OexU4bhjCSZcRM88UQA5IasPYwq7px8GzUcu7YW5Qpo5o3Rm/MuxzxyykMWy+Z
         30YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787753869; x=1788358669;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSUEMARjEssv0eA3Si6cabXSmTd2euFRyWUa/d4nP9o=;
        b=nLf5IiNOjCmZFPl7Ery/sO/7merLvd4t/t+AVKhUITjybFbwTMDvx4d1279WzCmPx5
         08EooKzdJ7Y+0R/np4Xch7T19LWAScUUJ0K3eVr6KL3Pe63dH9y1C4sqFA1Rnxky73Du
         5nLwzsFBWfPH/EiYCEAEtikojMo8CWRMY/qpPgaWFiBo/Hlif4K0crvtQnaJkvoqyAvL
         5XbV2Ig7YPY04EQHHUt2NKTCQ2yP4md5mN64j54Pu5XSsgupSelqyYVdDUMznshEl+iG
         EGl0z8eiu8wOeQbvk+DDtW/awynI7aW91LWxD0MbxgJBj/ySKb2OfZdtfQzXPMcxx/Xt
         +1WQ==
X-Gm-Message-State: AFuF++mPQCLrbITmZ7nYo6DNDF4azbxhW1al8Kkt7Xs/wTzUdTZ99H/u
	bN1lJPyS0CF1lKR2uDAsA4xXiQhhu5Pv0iBY5H9gmBJkDxfpPYtr0z9zrUMM1FyXkg==
X-Gm-Gg: AR+sD11ga9dISHWnRSS9wkx5UVMaYSJU7Wzd5iUiBS7/Q8w4jMx+ZlVeg+Aqxzt4Xf6
	yTb4owtJbpEQ+fI6BIea+GIIrqY1JpD/X/b/K7M5Jd6AaMvfrA9mr4W0FtvyBV5BYPv5r/oG5Ji
	fjDvwbthnrAW7iGqZguGHAnP4MLVOp8lZ5LevqLo8VhN/uPtYP+taDCmgYQnM0/mDNtvpaytERQ
	q5EK9/9+LpA1W6PNaRLBEPMHKqSqwIgqSuo6LRlL6IQYpekDwaSaDgJqF959EcQ9B876Yk4T19G
	s8DHWg+tlT9P61w4TZIKEffbl6iIxUo4+syHjNeysRqVUsgZ8smgVoAtg1OnsD49HEqOX0CXu1y
	7I2coMtH+dDuc7TaBsLrGzShbO1cCBASS5N18HKVsQivKLvVu/GTDGckTX9v8mGN17vAxaXh6YP
	YmphVgdeLQ4UDdo8a49oJMvfltyVpmYEbRoO0iGdZd6BsjXBU4LDDAM2SNgiCaLxMXiLpctl/hs
	hZH1J9DFkJIWLvJL1wKqG6qqw==
X-Received: by 2002:a17:903:2301:b0:2d5:db3d:1a42 with SMTP id d9443c01a7336-2d710527a15mr4277565ad.15.1787753868133;
        Wed, 26 Aug 2026 07:17:48 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704ba9a82sm8335085ad.48.2026.08.26.07.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:17:47 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:17:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ao71hvT6ENJf6kSy@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-10-praan@google.com>
 <178767577113.3356902.28128835506777632.b4-review@b4>
 <ao3kxwbwB9GC3EOM@google.com>
 <20260825201701.GG3325090@nvidia.com>
 <ao7TU2QSprRbGfEC@google.com>
 <20260826134757.GK3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826134757.GK3325090@nvidia.com>

On Wed, Aug 26, 2026 at 10:47:57AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 26, 2026 at 11:51:47AM +0000, Pranjal Shrivastava wrote:
> > On Tue, Aug 25, 2026 at 05:17:01PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 25, 2026 at 06:53:59PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > > I agree.. I think there are only two options?
> > > > >  1) After GBPA=Abort ATS requests are blocked, so you could full
> > > > >     invalidate all the device ATC's and now it is safe to ignore
> > > > >     ATC_INV
> > > > >  2) Just don't perform suspend once ATS is activated
> > > > 
> > > > This is a little tricky, I'm leaning towards 1) since edge devices can
> > > > have ATS enabled
> > > 
> > > Oh really? Surprising..
> > > 
> > > > However, the EP might've entered it's low power state by the time we 
> > > > reach smmu's suspend. I'm not sure if we should be waking up the EP for
> > > > ATC INV All (or if it would even wake up in such a case?)
> > > 
> > > Is its power down explicit? Could the PM stuff trigger wiping the ATC
> > > and blocking DMA for a single device before allowing it to power down?
> > > 
> > 
> > The power down is explicit, due to devlinks, the PCIe driver's suspend
> > op (runtime / system) is called before the SMMU's suspend. I'm relying
> > on PCIe driver's op to clear ATC and everything else before powering down 
> 
> So maybe everything is OK and it just need some commenting to define
> this split up?
> 

Yes, we can add a comment and a small dev_warn when ATS is enabled with
rpm clearly mentioning the reason for any unwanted aliasing (if observed)

> IIRC there is a PCI spec thing that says the ATC is cleared on certain
> config cycles?
> 

Yes, IRC, D3Cold would clear everything anyway, and D3Hot -> D0 with
soft-reset also lands in uninitialized. I'd have to check for D3Hot ->
D0 without soft-reset. However, for this discussion I think we agree
hhat it's not the IOMMU's responsibility to handle the PCIe ATC state.

Thanks,
Praan
