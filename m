Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73344378D7D
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303659; cv=none; b=a9OASQYvTphU66G1o/2L7Pz+/d2zIZ901jKyRCUxMpTHsAwFC+9TqNvm+qFBUpW4tTINVCtyoms/zG/O5S6892rxX5NJQlIAzjERktP3Lp2xv6Yu/8xVeUC+M4N0dIkM+lEa/8iL9lS00sYyyNH/kddAsL+Xx1H9juWbqnd6WTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303659; c=relaxed/simple;
	bh=+5NvPwxkd+9i5GiKKfiHltHB6kQ8dritqed/r7e5gEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLVh+W+6/TeViSDt+buobZ41HOrsg5qNuA3DK8NvL7qfJB3Xxvl40pToHRhpqDLPSKhzDc2RB44NTPLgH8GeNDZw5CyUFw2GuFt41wDPn5LeTf6cFB4kRweTSmYusOXf9K3XPKIBtD0EsZBTuWFompUjIBtAsGeVNnO2R5AbWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/PdAx3F; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/PdAx3F"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b052ec7176so14035ad.1
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774303656; x=1774908456; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exBHGWHqN/Fcx1Fk+ursFGf32PtT/7vVoLt/cnZyELU=;
        b=s/PdAx3FEVz3QR6q24xD4YfBo31z5VKhxp0fgiV2JwE2XGbVUqz8gEmChn4z2IWAx9
         TuDZiPjX3i07MWgGZUFfq0pA/mtMeTyO/XohOgp15aSHfrf3T5A4qshaPP/TLB/PO/wX
         kjvm1Hoh/xWrtv2DMyx4PL6GxTbKYgUwFa4NaHVpJAR0/va6H5bGLp1wD1RORQc1QzIS
         7gwbfmOxNyyFFXh3m+LfsNxzoxrmx2U+8V++gFaJ+1laryQ/9HezPSRMWI1mIlPrKAou
         OYmajCjRclD/SqGQn7oEhh2vyKjsMv4TixNLBOr+UfqzIE8WJw/gxX1RCL2z7QN+s3Ul
         up2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303656; x=1774908456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exBHGWHqN/Fcx1Fk+ursFGf32PtT/7vVoLt/cnZyELU=;
        b=LAxZTObDrP1ok6EljADamheP+Aq1D/ITpRdEwhaniIKPLIoTS272Cw0BVb18+VbbMH
         mGFQASEy8BMRd27r3ySfwTaxIAV0fQl+4SQxM+6bn4KBeWCYGHm5Wm7URofEc6PYpdhF
         HezNGbyTXZbF5LsalKVfLoPdk+ybjHT/p9edQ7jXmKADkUTvuhets2aEc0tp9xm41rtI
         TA14wgkZv7At2/RSbW8sFixT7Pr1t1o8senDg0Br1qTHUshoAtJ8JZB2PlqaCoOOikPp
         3ltyEWMVKRdC1mFBeb5vLg3eOpNAyqFu4AYUZkMJ0LDUfXARE0Zqz2dLtL1K6Qn3k0LB
         ti3w==
X-Forwarded-Encrypted: i=1; AJvYcCVsWOQTxBtP3/2ukTzOONZpHMtYuJ5atFki0NRGGPvpJ0WGMsNR4MYBFjU1Y86w+8zh3JHtKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf88T3w4faZ5pKoV4B55Y7XRWjBmwxpSKl2tVWS66EGRMeLGom
	/FhsczCK13Fx99ydTPKmvfpluawAG9nRxc7T2CqNVnAa4aldWUAYLcve1xqqBwZxkQ==
X-Gm-Gg: ATEYQzxEcROYuSH+P8I3bqU5TsgUwC83P/7fzGNY01r2WNs37e75cWhADwec4NeIMMc
	EXK58Xk+LLTP5DWY4vprDJ7s9VLOChlKAdYdCvQn2Vpgh64mPvkcl0rdvlaCgimy5ZvH2g1Jpms
	7upfr8Uyd93DkeVymvMSmsgBfGEdlIKxhQ803xWb0JFX1zrpZS85TGt3IowZLmisp4imzewRT9C
	ls0Rrecx1sBKBAIr1DezjI3ZYD4xggkV70qYu+i4RP2Nbs7QTEH9CfjNTAFBMUL+LxaLhweTWZg
	Dues15QQtevmcAoSQ65jWd61V7oI0Qo3Svn5iGuFOEaZMtxev7YWFt+HHM/qgJ7aJDAkdO9fE3j
	L/0f7wR01BC+w5Usl23CxUVyb5cX1fsQcyFhpBzAKNkBKOqAY23RXuJUcjxPbjWO9qpxvvUeCHA
	PQ12sJKsiXzfrJTDa41sLhvps6lMVi6AvcdPLzTOkKF0L8n/rAk5Yx92KflnCMbg==
X-Received: by 2002:a17:902:ce0a:b0:2b0:4613:2e35 with SMTP id d9443c01a7336-2b0a532cbf5mr1341715ad.0.1774303656096;
        Mon, 23 Mar 2026 15:07:36 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835551c3sm117347225ad.35.2026.03.23.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:07:35 -0700 (PDT)
Date: Mon, 23 Mar 2026 22:07:31 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio
 cdev
Message-ID: <acG3M41Ho96FyJ8V@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-14-skhawaja@google.com>
 <20260323210111.GB2571566.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323210111.GB2571566.vipinsh@google.com>

On Mon, Mar 23, 2026 at 02:17:29PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:47PM +0000, Samiullah Khawaja wrote:
>> If the vfio cdev is attached to an iommufd, preserve the state of the
>> attached iommufd also. Basically preserve the iommu state of the device
>> and also the attached domain. The token returned by the preservation API
>> will be used to restore/rebind to the iommufd state after liveupdate.
>
>Lets add token when it is used in restore/rebind patches in future.

Agreed.
>
>> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>> @@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	if (vfio_pci_is_intel_display(pdev))
>>  		return -EINVAL;
>>
>> +#if CONFIG_IOMMU_LIVEUPDATE
>> +	/* If iommufd is attached, preserve the underlying domain */
>> +	if (device->iommufd_attached) {
>> +		int err = iommufd_device_preserve(args->session,
>> +						  device->iommufd_device,
>> +						  &token);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +#endif
>> +
>>  	ser = kho_alloc_preserve(sizeof(*ser));
>> -	if (IS_ERR(ser))
>> +	if (IS_ERR(ser)) {
>> +		if (device->iommufd_attached)
>> +			iommufd_device_unpreserve(args->session,
>> +						  device->iommufd_device, token);
>> +
>>  		return PTR_ERR(ser);
>> +	}
>
>driver/vfio/pci/iommufd.c has all of the code which interacts with
>iommufd in VFIO, I think we should follow the convention and add a
>function there which can be called from here.

I am assuming you meant driver/vfio/iommufd.c as
drivers/vfio/pci/iommufd.c doens't exist.

I see iommufd_ctx and other iommufd_ functions being used directly in
various places outside drivers/vfio/iommufd.c, so there is not a hard
split I think. This will introduce unnecessary indirection I think.
>
>> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
>> +/**
>> + * struct vfio_iommufd_ser - Serialized state of the attached iommufd.
>> + *
>> + * @token: The token of the bound iommufd state.
>> + */
>> +struct vfio_iommufd_ser {
>> +	u32 token;
>
>This is u32, whereas the token above is u64.

Will update.
>
>

Thanks,
Sami
