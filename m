Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CA33CE88
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205975; cv=none; b=eoSmh81VQ+wTYLbN0jsNSULQLqWfIoDBDLhsHlqfO3PF3PZgjThKOjpQPnuCFb/KU68xq7Wo0aoWYPswkVoGzfNneV8kX1D6nmn6VfxZZGPaSV0sFuDT3VNpBhQg1vlaTE2tXdzx4KYeHz97I4eJt4oUaeJYE5Gh5p88HdYKPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205975; c=relaxed/simple;
	bh=ObUUfsifRjlfBoeZadT6dAQY7dovdxNlTYoFkj2FnrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVN3DMsWcuyjPWbhBA5mq0zI3qnaymqtEBsAYFNWuv2blyWjuhxst1tTDp1fm++S4l9bc+BggFHT5jPSt8is1fj4C6U3QcdCA3HOor3e1/5e9Q+8MSN1AANICwwlPxFlq3OahtveeFqD4ovIRnrPw1nh7qzvv0NgVBQWnsXfsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwMn/gIo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwMn/gIo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b46da8c48eso745ad.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779205973; x=1779810773; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yDtPc7IVu74fsWc9+gkWocaidYIl1HHcjSh1//EIiI=;
        b=NwMn/gIokR3OUIqiTcBHyMNnXLpYXxJWa7Tj2dIDjK6T2f1bgDhkEjEFPfS73+cmMp
         zotLlpeRXVMZ2DDgqAKDeDUIiODg6Ss1Ohdl0vWjRj90I6su+E5K5ZYDfjNPjKPK6nCh
         t3GI+RaxsBCsYJotRFKL/vk3VmHmVU05RVpfQK7hYtTqyYo4nkKepcyqICmrtdID0HK+
         bGqWxj9QtA3NJVgfiXNc32xRm2BYhmWukgogDKfTZgSi4UlQWE60dE7CZs+dn+PRMe0c
         7oXiFmLmSS/NPGqJJXKNZWT+yFW3wyRJuXKV3URF0/QoVRNZg1LF0K+ZNPkoFzo09892
         wRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205973; x=1779810773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yDtPc7IVu74fsWc9+gkWocaidYIl1HHcjSh1//EIiI=;
        b=MSUhehlvwg/5salNVkurR7fDqqBis7M+OptVS14Q8/6V8Wcf7uHKv2vtZgwkl3PaWA
         oBI4pzq5ZFUsjuYA3xeNKcosqb+mOelP6zmNUOVsV2SpxhcW8PCXH2YMwF0iw8+OZCcw
         QvmwsM7NCjmbRat68ds4ddtq+fehk8XY3rzZKZ8V6m3+7cYopwldjFMcH+4Vsa1fgK4C
         7693CW0o3dSjZ7AaNQcS/poiFTtaEGzxy9NNA5nJEja2ZpU0B4A17zCjlml7KM2N7UZg
         hO1vUPrHUmB25joeGE6nKocBnlhfvjL/1PvKwpDgFfnhLE9Or6peS6LbaDqHZh0CuWtR
         /aqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mcPS0l0QnoOrfJUO5pz4ZAdEl8kBvKK5ho3ykcdnQ5Atmd39673vQHJpLUmz8leRM3O40SA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMYYKObulJkGAVC1cUHRh/cWU/IHgUG5xX3oAG0fDWY3d0egyy
	3oF08rtW8cgXq3JR3PylwABBCn7AXrGWwwyMYn9rsLj7pj0qokMJigXuD/3VMUQaOg==
X-Gm-Gg: Acq92OH7GxVItBVKFTlet9W/84etCcVCacXPBVK/fbG7Hf5Mr92PcW3jL1157ZJWY34
	PrQO0ZCfe/5IdJAlMPynzgppIUbJnP1S2UFlkouj6bt1NVtuGf/yfkp03NagPPMrY1cDKmSL59D
	EsUGk/Nf4NuZH04Rth2J66Ic8XBN+JJhnhFOG2mfLnf6j//gsdXiNAYO5WJ0K/T54bimjIHJJG/
	SdOFmXpHGU2H0OvliJGGP2b0+nOt6zdykOSgttHnFVCIOp1YE40hVMY2JZdGBy0MUavEd62AssY
	AaIBAWA0IjtS8B1kWh1JPjJPRfU6Lp/D8drEv+p9cNazfCWulHRqoae5zvGzFTc8y31aCATC4ne
	pJhxgaqLo1LEPabbDAb9YOZLkpCK42GXh9Mw7PlBxeX2Vy3E7gDunfuyTyge/jgZhyv5wF4ibtR
	3dkGHk1CAiz/b10qcIQXXXguPVxCy8WApEc/61q2oMOD0oiU358BPqg+nYb8NHt5D7sbHk
X-Received: by 2002:a17:902:d4c4:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2bdb32c2d37mr5627525ad.11.1779205972767;
        Tue, 19 May 2026 08:52:52 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fe44sm195003525ad.11.2026.05.19.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:52:52 -0700 (PDT)
Date: Tue, 19 May 2026 15:52:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 08/16] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <agyHS2Tmje4LWogY@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-9-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-9-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:25PM +0000, Samiullah Khawaja wrote:
> The preserved state of the device and IOMMU needs to be fetched during
> shutdown and boot in the next kernel. Add APIs that can be used to fetch
> the preserved state of a device and IOMMU. The APIs will only be used
> during shutdown and after liveupdate so no locking needed.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/liveupdate.c       | 57 ++++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h | 31 +++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 765d042e22e3..60ee29b0c6bd 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -17,6 +17,14 @@
>  #define iommu_max_objs_per_page(_array) \
>  	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
>  
> +#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)				\
> +	for (; (_arr);								\
> +	     (_arr) = (_arr)->hdr.next_array_phys ?				\
> +	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)			\
> +		for ((_idx) = 0, (_obj) = (_arr)->objects;			\
> +		     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
> +			if (!(_obj)->hdr.deleted)
> +

Nit: While the usage of this macro is safe right now because we use 
goto out; to short-circuit the scan. Such naked nested loops inside an
iterator macro can be a bit of a trap for the future. 

If anyone tries to reuse this macro down the road and uses a break; 
statement, it will only break the innermost object loop and continue 
scanning subsequent array blocks.

We could nest two macros or it as a helper fn to prevent such bugs.


>  static void *iommu_liveupdate_restore_array(u64 array_phys)
>  {
>  	struct iommu_array_hdr_ser *array_hdr;
> @@ -201,6 +209,55 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>  }
>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>  
> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
> +				    void *arg)
> +{
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_device_array_ser *array;
> +	struct iommu_device_ser *device_ser;
> +	int ret, idx;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return -ENOENT;
> +
> +	array = phys_to_virt(flb_obj->ser->device_array_phys);

Nit: phys_to_virt doesn't return an error for NULL. While we shouldn't
be in a case where serialized ptrs are NULL. I'm wondering how painful
catching such bugs would be.. should we check for NULL phys_addr here?
(and at other places)

> +	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
> +		ret = fn(device_ser, arg);
> +		if (ret)
> +			goto out;
> +	}
> +
> +out:
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return ret;
> +}
> +EXPORT_SYMBOL(iommu_for_each_preserved_device);
> +
 
With those two nits, 

Reviewed-by: Pranjal Shrivastava <praan@google.com>
