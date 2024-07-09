Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476811B86CA
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544443; cv=none; b=PptifAMpkZrKmE2YaUqAOyku7h27/HCJunu5ztL+YAo3fu1NoT0HZl3zydOVceN1rvNd7mhB78LcQFWDvbGCVJnRSjGUfRoF1G11oW/mn+FqYy+cxXV20Iy36Yoyp6k39WE4rW2MR73cuR3beEizB1iNZCdxprqW9qCLru2MbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544443; c=relaxed/simple;
	bh=JgrYzVA7jCxQEkWilrTpq8hpV6Gml8vxozEpNZ2BRzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+vCGjXJyJ9Yd9Tk9Ond0CWaeeT/HLcHtMze72dWFTfZpUr16CzqHbJZ6AHYSB4vrDt4RXY21Hh83falPdqpLrsKZBvnvINWj2QwkEkPvuJSzi8QnEtBW2u8GXG+gwsmGA3sfdOSe5cTRuG83WNTQppYvYnjaO07DMB5OtA0pto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EoWAmlur; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EoWAmlur"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79f0e7faafcso204288685a.3
        for <iommu@lists.linux.dev>; Tue, 09 Jul 2024 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720544440; x=1721149240; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoKh6CbSkvE5uLHVYrlgWMx47IaolAIb/KMsl791ino=;
        b=EoWAmlurgoB+TI7t/I5gCY1x5Z0NGSXcM8025OjsZyac2xhjzwwP/e7AXJCsZDjGwW
         BmDJUHo8veRv8vxnYOWw71OX3E8dMD8r4ACJtKOFQ+EB5hk+ZmzyxbEqrAs+oFMKRTek
         WYcf6NcitEJIxVantWSM/T5CYZCofhq6B+on7mR8MDx6ZbA25MaghrHoIldrdLxKLxdm
         6DMd4XfT0lwWV0U5j9L9JyLxB2mzTUd/MTkjqtIuI3A+6tsaqhhtTBFN7o1Zqi4QQjMY
         Jqvdfad8KU7Plex3yrKrakfLngKCUH7awMSLHBFJYBOv3+bS50j4KUFYg/6kzDwAZg7+
         unWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720544440; x=1721149240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoKh6CbSkvE5uLHVYrlgWMx47IaolAIb/KMsl791ino=;
        b=JQ2y39M7e8Q177ggGoAmpJXlIIXkCLGYXWsTPrX4N6e3kUy1SZgxdUc3lwzzKfsH4a
         X1PbF1sBkx83ZNd12kzNHzRwChc2RIqp9nrzC/xz+PSSekncChyiYhmq3INZrfS1XPyk
         13mD81fFrCopNN1RqkwtORgUOGLCXSl36cgIr9AfqKcABcW0c4Pq3cavzWFnF8Bwc8b9
         Xzsv6icPT3xnIugSg1qU8U9nkLmURSArjnA2JMmv5VOJA6g+TDgfoBlruH/L4kyQ7mLj
         ZoW4vyB5oEYwv8YrFWCW684SzKXIxxUZCH/bMWKWqQ5mUg0GcM6DZTdHOPcfxeqN7szA
         GlXw==
X-Forwarded-Encrypted: i=1; AJvYcCXiPH4oeBlv/v60ReTt79me2ZWSqmBcf3evjPCQQ9WUZrdB2oydgZDROGhbpOfK8XUOqQdEyZiJb3kpZtMmWV+/A5/5IVE=
X-Gm-Message-State: AOJu0Yxi2PRTOD3AHmRlYO0B9aMt4uPSEPc4SwJ948f++WMDXb/3Lzv1
	TJ8qajC9CB1hlPPpWyYBktUh1NDJHtgjIFBl6G6+ktO4NSISGI/QEMmpDA3YolA=
X-Google-Smtp-Source: AGHT+IHQAqJ8Fss5qEp93E1gpLOGUNuxyAoBEmzUnNgYypyxw8q6HqRIgm5hrD+KkbzXQKOzZkmpdA==
X-Received: by 2002:a05:6214:21e9:b0:6b4:7910:2b60 with SMTP id 6a1803df08f44-6b61bc7f032mr32420906d6.6.1720544439969;
        Tue, 09 Jul 2024 10:00:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b59dfbsm12153401cf.52.2024.07.09.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:00:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRECk-002WM4-Ao;
	Tue, 09 Jul 2024 14:00:38 -0300
Date: Tue, 9 Jul 2024 14:00:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240709170038.GG14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <20240708162957.GB14050@ziepe.ca>
 <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>

On Mon, Jul 08, 2024 at 11:36:57AM -0700, Nicolin Chen wrote:
> Maybe something like this?
> 
> struct iommu_viommu_event_arm_smmuv3 {
> 	u64 evt[4];
> };
> 
> struct iommu_viommu_event_tegra241_cmdqv {
> 	u64 vcmdq_err_map[2];
> };
> 
> enum iommu_event_type {
> 	IOMMM_HWPT_EVENT_TYPE_IOPF,
> 	IOMMU_VIOMMU_EVENT_TYPE_SMMUv3,
> 	IOMMU_VIOMMU_EVENT_TYPE_TEGRA241_CMDQV,
> };
> 
> struct iommu_event_alloc {
> 	__u32 size;
> 	__u32 flags;
> 	__u32 out_event_id;
> 	__u32 out_event_fd;
> 	__u32 type;
> 	__u32 _reserved;
> };
> 
> It can be "report" if you prefer.

Yeah, something like that makes sense to me. The other question is if
you want to multiplex the SMMUv3 and CMDQV on the same FD?

Or multiplex physical smmus on the same FD.

We are potentially talking about 5-10 physical smmus and 2-3 FDs per
physical? Does that scare anyone?

Jason
