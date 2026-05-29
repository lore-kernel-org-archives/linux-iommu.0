Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60D3783A0
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074215; cv=none; b=uVaTEWZq/2gJgBLBhtqzslFoxVkw9e4bgFTFrsafTKsk6DfSB4V3M2AYJm0WqXSYEHcnEfQ7H0DBLzUD7AxNsxFmLe5ed/v1qzvGHFKFOqMspSmvVRGy8dp1BEvOQfz+vMCfFScdDHZOvmQrXsfWAelHS0Wb+NZCddKZozaozIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074215; c=relaxed/simple;
	bh=uYdO0Zb0EMGnJnig6FT1XOpGRq5xI3F+BHn+7Ktj+UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hlc1/8yPrd0mJDPX2hGCXrWOjlCOVNHqI9nMVs0W3yg72HllzMkWmGgFhvzzx3mTkgYu0/2FQcV5w7rHKUs/fsfJ7pYxTQ6Q2jYfY0DrUJoWav4zoRx4uCtPhgpueqTBFHTrb+MUp5EXG0BGrFcLsemM+z0wrSXyHHwHRC5LnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u07Q634C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u07Q634C"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2d865383so1615ad.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780074213; x=1780679013; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvcYM9yAFt1S3eUjneK8l3ddApYMEHlD7c1/gPxFFF8=;
        b=u07Q634CuxRgx7ZkyAkP5M7yuuCB8KcNhdSb0uYVZtVyfTl0ZOkXDVEuPvZ2dghmSv
         m5gzedYGEyYt7E8M2JpkcceN5BjTQoDh/dVySHQI1sfSQpgRPluR3Q2g6taapE9wgogf
         Qq56CDfupE9+dP6WhuBsXAQQnfmxlnidJJF9/LvXD7WOfNlxLJ6zb6I0QQK2pWyTNBlQ
         YJGx4fZuxaDr2gBMsJdhaAgfaNG8idGAhZxmrTDMT0SlM45DU94YPmZ9Se2c4yNoz6GE
         d+A2AI83Dr0Uh5I4T0+IBz1HMIBSAR05H2bGtmQbPMbOyS8LzPhBwlXEFjThwn/pYghu
         bGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074213; x=1780679013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvcYM9yAFt1S3eUjneK8l3ddApYMEHlD7c1/gPxFFF8=;
        b=e+tW0+9qbqUtRqtdD+/FelKrt0QavjnYJGUSjfV+wvc4tgibpC3DQdz4LXcxPSRz/s
         21Jv3YiVJIvMsfGWYwxYPANMnc3uF+ly9YCBKJjm8uBB+gfOLnVOtdDkJ81/DbNBQrD4
         Q81VuXK9i0q7urZ7i+DVLMokEZdNzdJ1HpSSAtiZNoWJxuGY5GTwgy7y7o9wrFgvj9fx
         806kODghhD0K7iU6sRlLXt89Nizs6MMoGudnp5qkQcJi/+Byva/ZKlSKRqeAuTB38sPa
         n7H+DL4KhsDyrvt6EUp/8N+hxy3O7s6vDoNrZLEWPosmP3IY8xhlEXxYxhKLcQM9TCqt
         HJpg==
X-Forwarded-Encrypted: i=1; AFNElJ/r5gz5+keJnewGQtyZOHqNl+CS6gJkXyE+PHmwsiLBKuKga+/EFWBWrSi+wtJgVDhDt/ZWHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTUnMBz44LYplXfLI1wEFbjpMtreZSC4tG1b8RLYGKnreETWyV
	f9URLSInDVyi5RacR6YlxpnWjigMBMsbxqwo9hVm4mE9zruDow7+KsOSVpndMqDNuA==
X-Gm-Gg: Acq92OEFImsz6cSsQ4ouNPzsnVBt0oDA06qo04uSyw796dcpe+cWQQugvpT6v8+ACCC
	DVHkLTguGooNcil8knM1LzvStkNmmaIBZaBwERw6MjnETVXMiPgE99BIn/5dqm8YGmxgyIoRqko
	LmGKS8BY5IfQet5dO4ya0zWIKluSVfi9urCC3z/cl6nNXGc3Zy6nC53g6EepJoTF9+mCEdljzHI
	Y0LWz3QBPvBnHe9aN0/S7z5bQJumGrSZKCwYyhqoxR8N/rhdJjwR+OGTLWa6kr4SqWdpegvtG0j
	1ptai8rkdkAIZPmpbUIoHPMpRZYCR9DfYmt1OimAGeeSg+E6CDjOzZ6KEYHWXibLFpqcEbaPzw1
	X9GWUBMdLj8bLr1HWthXki3oCgiy7VTqz3BBsau5Dj79B4b0xfhuZL0OA0W9iDBztqUZiJ2dKnQ
	Zz5+e7pIVTsg77bzzD8rnzHh67irbIU+NFEV6YNAyHontQoHhutPrXEC2HiXofiVjmib81Rw==
X-Received: by 2002:a17:902:e889:b0:2ba:4749:c9a2 with SMTP id d9443c01a7336-2bf97507257mr30445ad.2.1780074212695;
        Fri, 29 May 2026 10:03:32 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a10165sm24198555ad.31.2026.05.29.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:03:32 -0700 (PDT)
Date: Fri, 29 May 2026 17:03:28 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 10/16] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <ahnGsfuKSwgt3b_T@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-11-skhawaja@google.com>
 <zgdfgca45ealra5cckvsgeugfkuwdv6kima5f7hbun4m6lnjjo@bqxhvyoeovyz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <zgdfgca45ealra5cckvsgeugfkuwdv6kima5f7hbun4m6lnjjo@bqxhvyoeovyz>

On Fri, May 29, 2026 at 04:43:42PM +0000, Ankit Soni wrote:
>On Mon, Apr 27, 2026 at 05:56:27PM +0000, Samiullah Khawaja wrote:
>> Restore the preserved domains by restoring the page tables using restore
>> IOMMU domain op. Reattach the preserved domain to the device during
>> default domain setup. While attaching, reuse the domain ID that was used
>> in the previous kernel. The context entry setup is not needed as that is
>> preserved during liveupdate.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c      | 49 ++++++++++++++------
>>  drivers/iommu/intel/iommu.h      |  3 +-
>>  drivers/iommu/intel/nested.c     |  2 +-
>>  drivers/iommu/iommu.c            | 61 ++++++++++++++++++++++++-
>>  drivers/iommu/liveupdate.c       | 78 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 50 ++++++++++++++++++++
>>  6 files changed, 224 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 4118a0861f38..b90757164cd8 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1031,7 +1031,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>>  	return true;
>>  }
>>
>> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
>> +			int restore_did)
>>  {
>>  	struct iommu_domain_info *info, *curr;
>>  	int num, ret = -ENOSPC;
>> @@ -1051,8 +1052,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>>  		return 0;
>>  	}
>>
>> -	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>> -			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>> +	if (restore_did >= IDA_START_DID)
>> +		num = restore_did;
>> +	else
>> +		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>> +				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>>  	if (num < 0) {
>>  		pr_err("%s: No free domain ids\n", iommu->name);
>>  		goto err_unlock;
>> @@ -1320,10 +1324,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>> +	struct device_ser *device_ser = NULL;
>
>Typo here? iommu_device_ser.
>compiles because dev_iommu_restored_state() returns void * and the
>variable is only null-checked, never dereferenced.

Agreed. Will update this.
>
>Ankit
>
>>  	unsigned long flags;
>>  	int ret;
>>
>> -	ret = domain_attach_iommu(domain, iommu);
>> +	device_ser = dev_iommu_restored_state(dev);
>> +
>> +	ret = domain_attach_iommu(domain, iommu,
>> +				  dev_iommu_restore_did(dev, &domain->domain));
>>  	if (ret)
>>  		return ret;
>>

[snip]
>>  static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>  {
>>  	return NULL;
>> --
>> 2.54.0.545.g6539524ca2-goog
>>

Thanks,
Sami
