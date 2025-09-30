Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25412DA773
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224449; cv=none; b=G51kqkkHZu2y2CnRWEHLnrRTdOcm4G+jT+2ibUwJXU3Y8fGEgL9ceM9m4oLNBQ2d9ZhaFSppN9Sh3yOckie8bEt5EvKyDWBfLcoeA/vdNaH3jGFhacXd37ks7CB4yCL8ETbC8KG+J2BJ7bc1Nv7gidQ9oRc3q1pB1XbgafCq0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224449; c=relaxed/simple;
	bh=2HX8ugR5tVnj66NMcDsSytcxmQ8znP8neJT/Ryq2niU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX5xNjAsvG78DIDs9P4HecJw86gc2a491rcx77nqWwrTTv2p1gNpYoofITRuRrpuhLo9qdwbWXTWZbDO5uugM3vCvGIyoZ8U5Vpxc5fW6z7mPeaSweUpQ6YCt1aNcGuL7YsVXrH2n/rj2TSZMGXmBNwGe2U5gzEg25fjsdXGzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffFg+yet; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffFg+yet"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so38905e9.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759224446; x=1759829246; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QN7PHWfqfHR5N/DcATDm3hhOqXSyCS3Nkqfi3WstvM8=;
        b=ffFg+yet1nEUBJBUaEx6TtRzhHE8TMbp6GwfZ16JKaRggXsG5kz8JXyXN4L/Wva5CI
         OIfb+X2K34idR6we5XQdutKGUs/rik63fzCOeGCA0QtjbX+p1t7IW+hH7fylyU3Ar2pR
         1tDvbEJNxudk6AjfxaPXy3vpNXf4l1NpRSt4tsTE3pkUrwooD+b3B00xPE5u8wQwHt4y
         3K2QSQ0yC7636+g+L0iD/NnHAfB5TAz2AkuiyRyPIqMKjd8QQkqLc/45E1AvjIaVNbhB
         Yzb+KnxFoj6P+HXtuO1jcONRWUVh2XCf7WEO1NRxQBfqqQf1fcyHg64ukYvwgJBvo5r1
         gV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759224446; x=1759829246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN7PHWfqfHR5N/DcATDm3hhOqXSyCS3Nkqfi3WstvM8=;
        b=H21uhDE6atStSOo9PMP2EX8yNkSad0U+mddbJHY75FAhRf1y8i60YSYP6x4cSDiE5a
         oiJuoUxVmqz/MTwTY/gNYDkp/Spyi5re6fu/OYJxoPhKHWqSu8l+uL++0CSpDx0LL9PC
         Lo6DP4GFVEULHfx0xLvYogrrBhkEKPVU6juF0CWvSJzdmFhrCAfqyVYpqcbBfeELP7bg
         M6SgUfBOgPGFghpRKkZQmvt2f85g977kGiYvF1hpRo2owAvDoCn6boUcDIzqdZwlSrTV
         /sVg4hlrXacCsdp79nvdC30+tOpsWIP3vPwQ+9SY5wZAsqR3C+Jd5q7csFbv0Sbcehzz
         7h6g==
X-Forwarded-Encrypted: i=1; AJvYcCXXqmFddtNlWiXzCngDCpwU+qOwBNCMnUpseqz2RHaUZd3wpXy1jgRwmoq3aJTVRtUCzSsdIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIcyayDbdTjA+WV6XcjnKjXl6cVCamezNGqJb+g75S+6tlISK6
	FVco7mI1E0luVmH9450HpVQ1J8FeGfKqRm1JXrHI4vEEqhvnboD9nrIo6X9RuhWPp+mmCe7iRP2
	485H+cA==
X-Gm-Gg: ASbGncsWqdLXXiYutLRtd752FbUin0q1regomYlVpUZB4sGJYCsc0GDERD3x423Z1kW
	2ns2hlyy36s1oZfpaR238RsbsLWFr7XkSrGjOhvw8FUgPOLeWNuEKFz+Bmj/3moHT1Z4bN5fbei
	XXgBKPiNNg3WB5oi65YnrOSyYzIkfcuF7NBz++HYIh4iXiKbkqGph4ADIiNEH4f+gk9pPqcu23D
	H2HypXGGEL9OLOfw8gx1S726lGhpInIHuY1vXcivpwjOvL2G+QqLtemitZP9q8RCZmMq+cJY4Ol
	qMaaoOeSL8jX9suvHGZS31c8exnOPUckLZaTR+vHcrVphT6ABnW/fnNfrYZRZ1XHWSrqTV48qey
	zYlfBw8Nto6sMJcEYp+zOFSIthC3QsOv4SN4I5zotG45R9PekHTozwfnpNuj316eIOvaU9I0sQZ
	syXA2Lz7G9SR7FEGA=
X-Google-Smtp-Source: AGHT+IH1yV5qF+JFSdcRmxcBuPDpaQAsKJC//b8C6mcxmI2sXqJnZXAEpAcPpMpubgQmmUzlsr/1JA==
X-Received: by 2002:a05:600c:8a0c:20b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-46e59c5c91bmr1653685e9.2.1759224445782;
        Tue, 30 Sep 2025 02:27:25 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b576badsm11337405e9.0.2025.09.30.02.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:27:25 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:27:21 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz <danielmentz@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNuieevIo9MuzBq2@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
 <aNp6fJNoehs8hMyF@google.com>
 <20250929124719.GJ2617119@nvidia.com>
 <aNsjFm56D8pnAKDp@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNsjFm56D8pnAKDp@google.com>

On Tue, Sep 30, 2025 at 12:23:50AM +0000, Pranjal Shrivastava wrote:
> On Mon, Sep 29, 2025 at 09:47:19AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 29, 2025 at 12:24:28PM +0000, Mostafa Saleh wrote:
> > > On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> > > > On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > > > > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> > > > >  		.map_pages		= arm_smmu_map_pages,
> > > > >  		.unmap_pages		= arm_smmu_unmap_pages,
> > > > >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > > > > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> > > > 
> > > > Shouldn't this avoid defining the op on coherent systems?
> > > 
> > > Does that mean we need to have 2 iommu_ops, one for
> > > coherent/non-coherent SMMUs, as both can be mixed in the same system.
> > 
> > Yes, I think you'd have to do it with two ops..
> > 
> > It just seems wrong to penalize the normal fast case for these
> > systems.
> > 
> 
> I see we plan to set defer_sync_pte = true always. What if we invoke the
> ops->iotlb_sync_map() only for incoherent IOMMUs? Maybe something like:
> 
> static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
> 				    unsigned long iova, size_t size)
> {
> 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> 	bool is_coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
> 
> 
> 	if (!ops || !ops->iotlb_sync_map || is_coherent)
> 		return 0;
> 
> 	ops->iotlb_sync_map(ops, iova, size);
> 	return 0;
> }
> 
> If needed we can push the coherency check to the io-pgtable op
> iotlb_sync_map() as well. Just an idea..
> 

iotlb_sync_map is already NULL for coherent SMMUs, I beleive
Jason's point is about that the iommu_ops.default_domain_ops
will have the extra pointer which will be called by the core code
anyway, which immediatly returns; wasting some cylces.
To avoid this we can have 2 sets of the default_domain_ops for
coherent and non-coherent devices, to be chosen at domain alloc time.

Though, It would be intersting to measure how much overhead does the
current approach have in practice, maybe through dma_map_benchmark?

Thanks,
Mostafa

> > Jason
> 
> Thanks,
> Praan
