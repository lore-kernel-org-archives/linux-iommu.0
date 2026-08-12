Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87C40B0F9
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577003; cv=none; b=b8cOLQUvpGYUunZDpYaoNNmWqQJ8P3rTE2zR9bsvgo8vkBeEo2FzSZLvFUeCANE0KKbSwUeDj/khkP/Mo5M074BUKvh1naXB+Lj6aohGP8Z7F+4tH8KCir5d5OG1vlFQAEVClG3EosXrNn4sU++UwqYj18v4K+G/a4wT0aWu0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577003; c=relaxed/simple;
	bh=7cpnZ4/+ceUOXND5CI1ohyxaSHOso6PtTWdS3LWSlE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkeAdblOKZcEpn/s5V4KaHNDxjMnecXaf7EL3WZzjAhUH9jWYQEP3kDfsbI1RQnRYK7d9eRP2y4Ii04fcfzKlUS+HMV5m+kqiMSJR7ZN/GPWQAVjUV2CPqQMwMUKzAsDlKjy5s/eRWUMw3L1OONyptVFYFDmjcvGoWb0+OPyTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITJytRfi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITJytRfi"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cab97c86bdso20175ad.1
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786577001; x=1787181801; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=htZ7B2PCM+RfMEpW8esUs7JsYRPq+p1qH0eY16r8P3Y=;
        b=ITJytRfieVpC84VQDwmRGOJOEG+QR3jLoyvvTcRoaVZ3D3GheO4O6sgQ2V0/z0MYT8
         iWd7REqwRlx9mdsBAZGM+9QJ0Mw/h0AIUSRvX3wl2KFXJgHqQIHdvsmlDO80hz2Vcxxp
         r8eRjByHhB8L9zMFacFl4X8bbcQgBPnjcvCPyTInLrR14QcrhtPqIbpUU77CagnLCmVh
         qMZ6RdGNmRfYYE7hfo+L3+fR1f96g4qZXsPkhL14PABp2RieZnxAw68zhr471K2MoT/o
         VS1Du1kBbkd+l3BIU29XBk14wEVhGerqLsZfqlUSm/yJf7YLjyXK6wrwfSgOkCbOvgSI
         ZH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577001; x=1787181801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=htZ7B2PCM+RfMEpW8esUs7JsYRPq+p1qH0eY16r8P3Y=;
        b=di5ttsQTLjm2biBOXtwfWnRa85fMf365CB9h0CEHzcUX70ToqJEXjDMlZS195ZlAD8
         o5lS8rOHpRUyn13WCNSsCgfPRMt1UmZeZ3Slf95s48xm0lMhLp/mPGtboHaCAXuKhquA
         TS+cNmHMTAkbM0UPMxw7tXR3C5HanRiYoQf0r2V97+OgIRN9L6tShntFVS3VmQHAfGPx
         II5XlazH/S5dlu+LgIgKpHK8a2IVvM9SqVwYs122WHlsvafMGjAmjyfAeFykH+hJ2glt
         4tSGuSpMl6OQZpGwz9b9SKEzY+qgiB50egZHtFzMne0LHqfME0hqjegkcPK43qMuYKSs
         mOtg==
X-Forwarded-Encrypted: i=1; AHgh+RpyrRQ6SeyCsKh3F744+tWZwSru0qoBDgKUnIpS02KFSJvhspKb7tJ36r40ZCtrmTeTrcSPEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCF3c89GLp0CZ8VEU0p8pJqHSlLMnU3jhvoqU8+LhGoSJAaiJe
	ZCYbYY8lJ/lcooXqFINPSN7Hm1ZJNRd0T/Lnq6tR1IfOTpsuVBd5Ohd8s5N3Nv3r3w==
X-Gm-Gg: AR+sD13pD9G067hXXY3YOoK335Vj5FxjRWfFIorUKO99ym+rpw9dEQM0HSZD7wLVMbV
	fAzc1E0cNhJVXFVObG9j2z1iLxZWlUZX7stvsznvMUXJh0oaKHdfXLDcGmP2BibABfwcNU6DNkk
	1v/iqA5SOUjrfPj0vm4QUBOGZlaPUrniRR9oWqTKbcyym32rY8W4jTJL22zUQFNqgMQCV1jOeEt
	I+N+Xf3AiDQxd2jol0Jo+uOxmUy1k6vbYV8G+N3KnZk3ea8pw0el0RuBa/aQEQVHsbkttzfna0S
	+UmHvYY9kdL0JkESVhjPYAbzu4vvebtVAzM26x9OwDRuwp8N3STqUfwlqb0JmW2+hPcMLBQ4vge
	ov9lS4FcNTEt/+5lNskOPx3hnBrw+h06YJok+HS0MTl6T9eN30sDrLklS0zIkzOT8rn383hxeic
	9lYIr77NsODyFALdbcRzJC8lnuVdnp2mfU5fpw4zumqNHh9WwiltBTx4Jkfniseq40ilXIdiDSe
	to/mgZN7kSv/+GT9YR+wBb+ceWNW44/pC6oMFdLgw3WMJl8DGFJDo/9ZgM=
X-Received: by 2002:a17:903:37cd:b0:2c7:f0cc:dafa with SMTP id d9443c01a7336-2d389d983d6mr866935ad.5.1786577000833;
        Wed, 12 Aug 2026 16:23:20 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f44ddf3sm569830a91.14.2026.08.12.16.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:23:19 -0700 (PDT)
Date: Wed, 12 Aug 2026 23:23:16 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 09/18] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <anzf_mOBEdMdyTOD@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-10-skhawaja@google.com>
 <wjt4qqbzwsiaxz7bxog6prag5qvverji5o7dvdsek6frakuptd@urudi4rsvmbk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <wjt4qqbzwsiaxz7bxog6prag5qvverji5o7dvdsek6frakuptd@urudi4rsvmbk>

On Wed, Aug 12, 2026 at 06:29:18AM +0000, Ankit Soni wrote:
>On Sat, Aug 08, 2026 at 02:27:14AM +0000, Samiullah Khawaja wrote:
>> The preserved state of the device and IOMMU needs to be fetched during
>> shutdown and boot in the next kernel. Add APIs that can be used to fetch
>> the preserved state of a device and IOMMU. The APIs will only be used
>> during shutdown and after liveupdate so no locking needed.
>>
>> Reviewed-by: Pranjal Shrivastava <praan@google.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/liveupdate.c       | 122 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  45 ++++++++++++
>>  2 files changed, 167 insertions(+)
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 7f349ae5a124..20acf123b47a 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>
>../..
>
>> @@ -262,6 +273,117 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>>
>> +/*
>> + * iommu_liveupdate_flb_get_incoming() - Helper function to get FLB state
>> + * @flb_objp: Pointer to get the restored FLB object
>> + *
>> + * Return: 0 if FLB state found and restored, error if no data found
>> + */
>> +static int iommu_liveupdate_flb_get_incoming(struct iommu_flb_obj **flb_objp)
>> +{
>> +	struct iommu_flb_obj *flb_obj;
>> +	int ret;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)flb_objp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	flb_obj = *flb_objp;
>> 	mutex_lock(&flb_obj->lock);
>> +
>> +	/*
>> +	 * FLB version mismatch is considered fatal for security reasons for
>> +	 * now.
>> +	 */
>> +	if (flb_obj->ser->version != IOMMU_LUO_FLB_VERSION)
>> +		goto err_fatal;
>> +
>> +	/*
>> +	 * Array Phys of each type should be valid if the FLB was created for
>> +	 * preservation. This is true even if no devices, iommus or domains were
>> +	 * preserved.
>> +	 */
>> +	if (!flb_obj->ser->iommu_array_phys ||
>> +	    !flb_obj->ser->device_array_phys ||
>> +	    !flb_obj->ser->iommu_domain_array_phys)
>> +		goto err_fatal;
>> +
>> +	mutex_unlock(&flb_obj->lock);
>> +	return 0;
>> +
>> +err_fatal:
>> +	panic("Failed to restore IOMMU Live Update FLB\n");
>> +}
>
>../..
>
>> +/**
>> + * iommu_get_preserved_data() - Get preserved data for an IOMMU HW
>> + * @token: Token used to preserve this IOMMU HW
>> + * @type: IOMMU type in preserved state
>> + *
>> + * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
>> + *
>> + * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
>> + */
>> +struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>> +{
>> +	struct iommu_hw_ser *iommu_ser = NULL;
>> +	struct iommu_hw_array_ser *array;
>> +	struct iommu_flb_obj *flb_obj;
>> +	int ret, idx;
>> +
>> +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
>> +	if (ret)
>> +		return NULL;
>
>Hi,

Hi,

Thanks for looking at this.
>
>Returning NULL for every failure loses a distinction the caller needs.
>"Nothing was handed over" and "something was handed over and the lookup
>failed" are different states, and this helper is the only place that can
>tell them apart.
>

My intention is to handle these details in the helper function
iommu_liveupdate_flb_get_incoming() to keep the driver code clean.
Basically to allow the caller to decide whether the state is available
or not. The various error handling cases can be covered internally, and
I based it on the errors that the liveupdate_flb_get_incoming() can
return.

>Of the errors reachable here, three mean nothing was handed over:
>
>        -EOPNOTSUPP     live update disabled or not built

This means that the is state not available so returning NULL
>        -ENODATA        no incoming handover data
>        -ENOENT         the handover carried no IOMMU FLB

Both mean that no data is available from IOMMU point of view as version
is moved into FLB state, so returning NULL.

Now down the road we might have cases where the available data has a
different version as compared to what this kernel expects. We can handle
all those things in this function and if possible hand over data to the
caller in the right format it expects. Otherwise we panic() considering
mismatch fatal. I will add these details in the documentation.

>
>An -ENOMEM out of a .retrieve() callback means the opposite, and returns
>the same NULL.

Ah yes... This needs to be handled internally also. Probably in the
.retrieve() callback as -ENOMEM when getting the FLB should be fatal.
>
>The distinction matters because callers read NULL as a cold boot and act
>on it. Both VT-d call sites in 10/18 do. init_dmars():
>
>        if (!iommu_ser)
>                init_translation_status(iommu);
>
>        if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>                iommu_disable_translation(iommu);
>                clear_translation_pre_enabled(iommu);
>                pr_warn("Translation was enabled for %s but we are not in kdump mode\n",
>                        iommu->name);
>        }
>
>and intel_iommu_add():
>
>        if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
>                iommu_disable_translation(iommu);
>
>On an -ENOMEM both disable an IOMMU that the previous kernel left
>translating, underneath devices still doing DMA through it. The warning
>attributes it to a stale enable outside kdump, so the log points away from
>the actual cause.
>
>The helper already treats this class of failure as fatal a few lines
>lower. A version mismatch and a missing array pointer both reach err_fatal
>and panic(), because data was handed over and cannot be trusted. A failed
>fetch is the same class -- something was handed over and could not be read
>back -- but it returns an error that becomes NULL, and callers read that
>as a cold boot.
>
>A single failure also spreads. luo_flb_retrieve_one() caches a failed
>.retrieve() in incoming.retrieve_status and returns it directly on every
>later call, so one -ENOMEM makes the lookup return NULL for every IOMMU in
>the system, not just the one that hit it.
>
>Is returning NULL for all of them intentional? If callers are meant to
>treat every failure as "nothing was handed over", that is worth saying in
>a comment here.
>
>If not, the smallest fix is to return NULL for the absent cases only and
>an ERR_PTR for everything else:

This is what I was doing in previous version, but it gets too messy.
Moving it into the helper handles fatal errors, and versioning down the
road, cleanly.

Thanks,
Sami

