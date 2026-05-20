Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB113F4DDA
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297894; cv=none; b=Oh6dhsMOPld2twAUGdpAAC3Dkrc5bKirCv1AF3QKfmTEPPVRpNjWFyDwL6CZMbOArC48CkjXgljnnH4E5GKYQ8851VvVYfcMoNQ0NjI7a3wt2ojSnCI7FGMzfi6wb7watqXMYKfs9qmMgpTOVshecj0r7Pv2Y4AXlv6fxd0SyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297894; c=relaxed/simple;
	bh=y3tjD6rMTxegPZ3G74BAk72u6S11iQNTtJ2D9z/46Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5KktO7do0ckqGRPM5h/TLJwLfo5KzECbWLqopywpQTK9idBtmGLRCuj0qf4hzrh0Q8HHLal/PQaIFncGPMUvKYXMQIVgcn1C9BBHiAw7SzJxdUUyhtCVhgRkwR/W7r2Zwg+L+QvCm5m7pBWD1zE/qqKLuzWjmLlNb5PVoxBC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNHzqQXJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNHzqQXJ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1445ad.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779297892; x=1779902692; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJhl7WJ2lQSroNNhwKFoiQuIjJsM08m4ektSy1+OM9s=;
        b=YNHzqQXJ1Ql2saEkzTtOVecJSAlypjkC9NxqsjVRvfCV8ejJf4198KIBfKU7evnDAa
         IBNpUYdR53omaYIy0XTq7ZPyrrPT5LNfqKGbT21ZkcIrQq7PxqOi0UR1UEJE8FzIZrul
         8Lng8SL9lJWior9H+pO2D+fSyZB3AFT1jzoWK/EeeGD6Lj0OzVkqWrTCfeYtsJd7SKf6
         vOvy6986YaSPg/SCuchsh67gxgR66ndOWCQnlESCkIeWehGyMTVE/2ub5ngYNFIb639u
         A7kJXMx6H+hqPuywnxPO8S+Q8TJTp8TgpSLkKR+alAAuIOxwaysOzv0R288GuNWuJTeD
         Qicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297892; x=1779902692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJhl7WJ2lQSroNNhwKFoiQuIjJsM08m4ektSy1+OM9s=;
        b=Ykz+gleIBz++WphB9ehjP6cKqGrGEwt9aaEdvwwbfcB9APIH1a06TAkKPScebSRb+E
         fKNSQVdkQCFcS8sX8EdqkfpwX62+zf5Tx7KTsxSmsg/al1B3h8LK1EYQLNKTaH0vCrnI
         oM7fJpQ9uY0nLBceVz1Ux4iscR0qCjCfNObPkSzq01HtHb/ZYAnopTvVWhja5nQCQBRG
         EzvesLHc0oT2G3WywLdx3oAUgcUIo+tcQJTiMlnFtdn8MPWPny7lkJu/Wj+lvC2FLw10
         oZWfvdtwfXLaFWyX5Fb8OA67fR9Bl6GdqCCGwXF4BPJHi1Jr3BF8lyRSOcSamrs2QvnE
         BkxA==
X-Forwarded-Encrypted: i=1; AFNElJ8yos3yVFsmvODLaC6DI8ZMmPogTqWGElcYtHX8gsRDZcNuOpGLjdagNdh9zc5GpkLohzo4LA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhsxXEiU3+hwkO6HwXJ2cEdwaab4VcYb+5Xp+F1YnzS6rgalcV
	8CgsUZRzRPsjbdWjCBQfELznM3CaEC62XmdO9FVm8g5DwTSQKW4xvQmq/7VSVKOQ6A==
X-Gm-Gg: Acq92OF6frI3CetIV5AFf5qm2h+trrNyWsdhN7+aiIG9NBqjaoEw95Ni4xALVR5rlaf
	XZxYqWLwI/BYzpkBFlDBch4p/RQeCkzqwFmHzorUAPviHtbwwW85aOZsaht4jHmON743V7fao39
	Tince6DnBSxmDNC+qfLBOUBxUi1SffVOVB5qa4eY4URaQCaE5fFXszT9JUEPBTJ67uA8YnEZ4S2
	W0utO6aAXbqs36ztZqKyIsGNzwgMsg0oqIQEiCOYYtg0jLblGqmE5Nc4aXTkPgltMZsRMi0ySh0
	UgEj5NnpUTm5YWoz4Zb5kEKbxMK3/aaAMBL/nqFezo9iMTJsTDuUdHRVw5D2+NeBhJYsrPQrZ5w
	G5PJEzrUydDkY92MG2tefLyxY+FbsY50lrx1M32ENxejeuA4MD6pifnWnDQxnIMsNREadk/U5iz
	s3wdaWut5rz8eLqamUEnkjJtu4YzgpO2I5njCi8OAyiWHDvFX9jlxHS8Y+a7F2qKg+6jMj0g==
X-Received: by 2002:a17:903:3545:b0:2bd:6dad:7cce with SMTP id d9443c01a7336-2be9f448422mr86475ad.26.1779297891648;
        Wed, 20 May 2026 10:24:51 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ffbesm232289015ad.27.2026.05.20.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:24:51 -0700 (PDT)
Date: Wed, 20 May 2026 17:24:47 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 08/16] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <ag3nD8NW9khqxMNS@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-9-skhawaja@google.com>
 <agyHS2Tmje4LWogY@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agyHS2Tmje4LWogY@google.com>

On Tue, May 19, 2026 at 03:52:43PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:25PM +0000, Samiullah Khawaja wrote:
>> The preserved state of the device and IOMMU needs to be fetched during
>> shutdown and boot in the next kernel. Add APIs that can be used to fetch
>> the preserved state of a device and IOMMU. The APIs will only be used
>> during shutdown and after liveupdate so no locking needed.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/liveupdate.c       | 57 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 31 +++++++++++++++++
>>  2 files changed, 88 insertions(+)
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 765d042e22e3..60ee29b0c6bd 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -17,6 +17,14 @@
>>  #define iommu_max_objs_per_page(_array) \
>>  	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
>>
>> +#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)				\
>> +	for (; (_arr);								\
>> +	     (_arr) = (_arr)->hdr.next_array_phys ?				\
>> +	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)			\
>> +		for ((_idx) = 0, (_obj) = (_arr)->objects;			\
>> +		     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
>> +			if (!(_obj)->hdr.deleted)
>> +
>
>Nit: While the usage of this macro is safe right now because we use
>goto out; to short-circuit the scan. Such naked nested loops inside an
>iterator macro can be a bit of a trap for the future.
>
>If anyone tries to reuse this macro down the road and uses a break;
>statement, it will only break the innermost object loop and continue
>scanning subsequent array blocks.
>
>We could nest two macros or it as a helper fn to prevent such bugs.

Agreed on all points. I will change this to two nested macros.
>
>
>>  static void *iommu_liveupdate_restore_array(u64 array_phys)
>>  {
>>  	struct iommu_array_hdr_ser *array_hdr;
>> @@ -201,6 +209,55 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>>
>> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>> +				    void *arg)
>> +{
>> +	struct iommu_flb_obj *flb_obj;
>> +	struct iommu_device_array_ser *array;
>> +	struct iommu_device_ser *device_ser;
>> +	int ret, idx;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return -ENOENT;
>> +
>> +	array = phys_to_virt(flb_obj->ser->device_array_phys);
>
>Nit: phys_to_virt doesn't return an error for NULL. While we shouldn't
>be in a case where serialized ptrs are NULL. I'm wondering how painful
>catching such bugs would be.. should we check for NULL phys_addr here?
>(and at other places)


Agreed. Will update.
>
>> +	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
>> +		ret = fn(device_ser, arg);
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
>> +out:
>> +	liveupdate_flb_put_incoming(&iommu_flb);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(iommu_for_each_preserved_device);
>> +
>
>With those two nits,
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>i

Thanks,
Sami
