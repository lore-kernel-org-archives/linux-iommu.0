Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD31A275
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759191843; cv=none; b=B31j763AjFZuH9hqZL47eT0/OrKquo8HMyqP3T3fpvFcgyXOmZmjSUvr9QVEZYj1e3j0rJmRSYAM1AhpBDIg//sjjR3tTzbFoOFmIYV444DPVlOe3H1FD/kqCWQ3W0XRUtNF8+ofW/FeSahgdGl058mKWLRqBC1QXqYsUYY72X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759191843; c=relaxed/simple;
	bh=wypLS3wbyCJK01dCOFTCad6xFyH+lsxJrjZiqV1ziGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msnxgiKkZ7haJZvGmmdGOblm5GLzPYNGQ25aBqwsuYq4Jen1vMFEIMZDvIMfDXd+J2mGwRk3Mr/XuKKgo99F+qgr4a+Up5R2eO3L7iJ0t0Zm65VSxzeE2L6e/9klPC7pEjIuM43u+nNRqpxtCnip+SVZTr6kBxU2jqil28u/cCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjmF5PkH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjmF5PkH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d67abd215so94695ad.0
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759191840; x=1759796640; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcb0iCTs5qPKJqlBUU/RfCrR5a+tDEsmWBE3CmQO4XQ=;
        b=BjmF5PkHMz3KZbUCpTUZZIfoad4uRd7r3edliw3blraLg2oKvAYkCJiLI2yy9EgmAc
         6eUZDFxirrUzkuRIPUqJPSDaDwEie3ONFahE9ion8Cq5gbe4hzjNr0dmkrInZzY7oxqj
         F+K5tqXWhOWs/g/NKxAJ+1rC9IVzRD5vL/JjcDOIvMpKV0jpjy/Z93w3b8UkQfj2KhFm
         i9sGzUsMEtcXhLlj1ZRzx7pxELppjhM67XNI1923u3ZOJ6XLJcUfrskviKAjOtqSKvVz
         UAvCddruv/YD4VOzh85SyL3hIIFPpu3OwswPlJ6HCJbXaE7zxAzZq4WzfQKdXuBfuuRS
         V1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759191840; x=1759796640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zcb0iCTs5qPKJqlBUU/RfCrR5a+tDEsmWBE3CmQO4XQ=;
        b=SbY+9z58iAJRYifUCjfRDxtovrJHsl2P4Z6O+e2bawlU1KTTPaPdceIosFnsZGMPsb
         MB2feuUsaZ5m2hG6/FZ8vqDhdtIHnPd1B9pQZQ1ktSmabYONjIftvKuAJ3VuhAhSi7Fb
         cxsHAcOB/dBjxDJaAeFmGzmVkkKRuf4fJIt+TcPMqCNuHdi7j4RPbj1dBQEeQEwlS4la
         dUENS35uWG4JX/vs0g5HH4cNfduOkTdY6m2PmtaUTOTEgaTjQAMkHBgzgUahb822oc1B
         4wPXTh0JNzsIdXmc5JB1VARr55dtSfnPKMtzF5NFc/n3kJAD3ErXy2oLLTOYUViu2dYe
         Rw6w==
X-Forwarded-Encrypted: i=1; AJvYcCVlzmer6b1Vdwodw/sY5wiVq6DnBGHx3DeRd4Z5eK5uzVWDt+8+847xmZHJSivOsuw6qJR0qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRmoPkcBNa3PSm6erpsXGWieuxQ/SmjIgA4FVPeiF2aXrUt+/H
	2aw8zR/XoGWAJ/2XeRDVecGaojhuqq9Fsn20pYuNJ8+4M+yz/UbcJ0xjEbw4lLzo1Q==
X-Gm-Gg: ASbGncsS+2tskjoNuu0JHgI5pc6M0xHJrH7c0fhGTmot5/1V1UQtqShhcbRTtmNL6bl
	vLcagulZLkstV/aZo44fyiJ9Q03g6rJPwWhF18E8Rrri57y4WUtmLsCJRi1qG+Oweg4hn3ZybHP
	X7EZS9mKNjwoFZScxxU23k4UN/lHe14cx8gGW+HRCsdRHMlRt5wA/zUdr3yuovImcigDsJSLrb6
	7X0QFP6Dp7EEodUF7KfalvyJgV91ZG4UdOdY6p9hpb4lHlw8dxTgmC7jJfZINDQNNJ2X/OCQ31C
	XKEOj48h40/QfWH8Ej2TYkj3ruilqlXaqINH+1L6rOsArRg3p2ICcsE8waWU0u+IOrtKHm5ftbE
	qWJMeLgAfRpm76dqRBpUsz6gkxFQVTpmrG2D8pOwls4ghYtoVKosH3axIGhN4+amWLDGFWn49gm
	bLW8XTEavyVJ+fI2T8SFwwKQ==
X-Google-Smtp-Source: AGHT+IH47NqR97g8gcG9ndJRncZ5F4jCUXYW7SnBTfKjVMSIbEg5GROwnU7eM5A3pfaaVR13HzSURg==
X-Received: by 2002:a17:902:ce07:b0:26e:ac44:3b44 with SMTP id d9443c01a7336-28e1483bf6bmr2495355ad.10.1759191840076;
        Mon, 29 Sep 2025 17:24:00 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab6547sm143571295ad.129.2025.09.29.17.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 17:23:55 -0700 (PDT)
Date: Tue, 30 Sep 2025 00:23:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNsjFm56D8pnAKDp@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
 <aNp6fJNoehs8hMyF@google.com>
 <20250929124719.GJ2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929124719.GJ2617119@nvidia.com>

On Mon, Sep 29, 2025 at 09:47:19AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 29, 2025 at 12:24:28PM +0000, Mostafa Saleh wrote:
> > On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> > > On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > > > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> > > >  		.map_pages		= arm_smmu_map_pages,
> > > >  		.unmap_pages		= arm_smmu_unmap_pages,
> > > >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > > > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> > > 
> > > Shouldn't this avoid defining the op on coherent systems?
> > 
> > Does that mean we need to have 2 iommu_ops, one for
> > coherent/non-coherent SMMUs, as both can be mixed in the same system.
> 
> Yes, I think you'd have to do it with two ops..
> 
> It just seems wrong to penalize the normal fast case for these
> systems.
> 

I see we plan to set defer_sync_pte = true always. What if we invoke the
ops->iotlb_sync_map() only for incoherent IOMMUs? Maybe something like:

static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
				    unsigned long iova, size_t size)
{
	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
	bool is_coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;


	if (!ops || !ops->iotlb_sync_map || is_coherent)
		return 0;

	ops->iotlb_sync_map(ops, iova, size);
	return 0;
}

If needed we can push the coherency check to the io-pgtable op
iotlb_sync_map() as well. Just an idea..

> Jason

Thanks,
Praan
