Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FD1F4CB1
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749095730; cv=none; b=RrMTSaenEDe4/Rkqums6qual1oI0EcFBDwPPjryW6UuT8Nh4ZJ1RoukMMZtVNn2QD4Oidfp7ruwpVdZNSgYV7k5gmOrdjXcM1K2y1C+z6P1dEvD6CgSENC8lNLr/jUq31E0OFBDCf9Gef44avbuAtsZZ9EDm10LP/UoMhLUDeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749095730; c=relaxed/simple;
	bh=6vV8BBBuLBseH4drZNDS1JiYTzhPY15/Bct2tXlZ1l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y6p6Aih7iKiO2bIM0YxtOqTkAV3odi9UxVv8KmnWg1GouyCAXQHE2V+K3tIycNd8C0Ct/rneob4SQoAu88LNNmeORyA5e4LVGd1QNpEIUZtjCUSQtb03c7hWSmisHpAbA08kW9Jefk7OLyK7ltTAy6vFywDshNGGIAEMSr1lYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTJbI9ph; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTJbI9ph"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so386763f8f.0
        for <iommu@lists.linux.dev>; Wed, 04 Jun 2025 20:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749095726; x=1749700526; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UFw1hVm4aqEwlAr8rCOCLfQ9NHkEpt5q96evQjKko24=;
        b=DTJbI9phjO5pjcFukw6K3vKmnUHd53XS8gy2mFoOkjetzzrVTvWWNAPkx6XAccP3Gc
         lbx+xAIjcUnXrrNpfqSad2RRkRFyMwDlwKCReWBejerIlo2CJvoU8Rs8I5mFxQlK5v33
         nKdsVQGRuwtEn4HQq5EjDW09C7sQjIKRBdBOxgXRb/9kU+Z3GzzED93dLNCgj24rXIFd
         /yAun0ViWpznALr0/jfrnw0sNCQxz74no4WHRAJZcVm3q2aUJ6hJEtCy3bNxF3KwYUZw
         7I9JG/7DS17XKFUV5vtrTQDhk8PSHXTGFMG0zUSs1he12d2IlNnyu5MLWCqQfIWSbg7H
         Drzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749095726; x=1749700526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFw1hVm4aqEwlAr8rCOCLfQ9NHkEpt5q96evQjKko24=;
        b=bWO6oJvy1UtAsgePgr+w/ttKhzrtUyt4p3lDx3C1haMkmpfeR6KPAF4rrb+TMYFmiJ
         tfuMugNNJEB/J8L6fZPP1T1wrCUypgMpyz+U8K/8RUrBhUb1EVfEaCHj/yg9IPstuMs/
         fJNhzDQC/OSWS7Td+rTjLVPdaMmhlGJV64DQYrEVjo9buYUqWnKlNS2I/eG57XKdoBmT
         3oDV6jXAheOCMeZanTl26MepxqNXlj5uge7X2dU3Hsce0RehW62UPjzUmwxQyJmGi2Ei
         BbRvD4B+NQAfiXw2Uh+zz3gWL+5awjy1jcx92xtnZejaclOZCCR0wdO9O+jSqoF6baeu
         cSkg==
X-Forwarded-Encrypted: i=1; AJvYcCXYGeX6Cy+UaKU05f1VizL1E9j87T6tEkE29gztTENAZncLyzorcs5MH6XeyA/7w22g7NT5Ig==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLEZEB7G8br1z68V8AoVgz1OxjBBFgSuUAKEwBWXVtIjxVtOeN
	y/h5wMvUMYFvT5Sv6L9OMP91JM+hnlpluvG+HWjaBaHJ2e+RV/HwVk7f
X-Gm-Gg: ASbGnctv5GGUgHvX/G4yfdj6D60mxiReCP+so0zwJe75QMitkq9BJUqkvluBM44/xcC
	FlFgI9dvQIHQ1cMPPwAFHjcPXMkRxKFZul/+mJ2NikzgwxU7eNsQV6HIo+35urpTmYD8tETCSce
	d/54XBM8888KageF6jDm0/JoUDwmpa3w3+ZeTuXKULdfIgiLr60qBzo/jDJq2ZcPRrv8AnIXGua
	mtauwFUZF42PTSahAgt8x5pQr6FEJeI9SUFnwSNStiEzAm4c2KVeKOYqVfZDPcRPY8u43vZn5wA
	Wj9XRgWJNPzU1giToJHOex021Nioha+nh4TD7m5Qwsj5io5c5o5IS/lSHn+945kw9/n5lfFE79l
	3WcC98y2QuLckGYqyt6ASk0+OdE3T6R0xUXkHHD9RBEVTe0qyG+rpSQgcCnMXZtNh0SQ=
X-Google-Smtp-Source: AGHT+IHs9o7cJ+ssmBhszqk9ddF0qXxrKNkv9fb9GFLwxoeRPawQyEP6ki2Pz/VW8vyNBzgyPg9SqQ==
X-Received: by 2002:a5d:5f51:0:b0:3a4:f430:2547 with SMTP id ffacd0b85a97d-3a51d8f6105mr4140212f8f.6.1749095726307;
        Wed, 04 Jun 2025 20:55:26 -0700 (PDT)
Received: from [26.26.26.1] (ec2-18-153-191-229.eu-central-1.compute.amazonaws.com. [18.153.191.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a52bd85d51sm192467f8f.94.2025.06.04.20.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 20:55:25 -0700 (PDT)
Message-ID: <d32ac499-fadb-401c-bb8c-9c3616da302a@gmail.com>
Date: Thu, 5 Jun 2025 11:55:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/vt-d: Remove dead code in
 intel_iommu_domain_alloc_paging_flags()
To: Baolu Lu <baolu.lu@linux.intel.com>, Wei Wang <wei.w.wang@intel.com>,
 kevin.tian@intel.com, yi.l.liu@intel.com, dwmw2@infradead.org,
 jroedel@suse.de, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250530091325.694456-1-wei.w.wang@intel.com>
 <f1f55968-28e0-4c5d-876b-1c5499b3c01a@linux.intel.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <f1f55968-28e0-4c5d-876b-1c5499b3c01a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/3/2025 10:39 AM, Baolu Lu wrote:
> On 5/30/25 17:13, Wei Wang wrote:
>> When dirty_tracking is enabled, first_stage is set to false to use the
>> second stage translation table. dmar_domain->use_first_level, which is
>> assigned from first_page, is guaranteed to be false when the execution
>> reaches the location of the code to be removed by this patch. So the
>> handling for dmar_domain->use_first_level being true there will never
>> be executed.
>>
>> Signed-off-by: Wei Wang<wei.w.wang@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index cb0b993bebb4..1145567c60f9 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3418,13 +3418,8 @@ intel_iommu_domain_alloc_paging_flags(struct 
>> device *dev, u32 flags,
>>           spin_lock_init(&dmar_domain->s1_lock);
>>       }
>> -    if (dirty_tracking) {
>> -        if (dmar_domain->use_first_level) {
> 
> This *explicit* check enforces that dirty tracking cannot be supported
> for a domain that relies on first-stage translation due to the lack of
> enabling/disabling dirty tracking support.
> 
> While this might appear redundant, this prevents potential issues
> if related code is modified without awareness of this dependency. 
There would always something sooner or later like this to stop the 
improper configuration/coding , under an assumption that caller path 
always coded perfect, indeed, we could remove a lot of error stopper code.

But that world seems never works like that.

Thanks,
Ethan
> 
>> -            iommu_domain_free(domain);
>> -            return ERR_PTR(-EOPNOTSUPP);
>> -        }
> 
> Thanks,
> baolu
> 

