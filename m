Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A40215AD95
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741195; cv=none; b=XjhYCNjjdKsDsOneUy6syJN4qYlIxMa7wjBWvE5ge4xYFrdE63p+/4z1r1rCU07Tj49+pmTGcB4YxekjFBRvYy2M414U4M2MByOSEDh08Ub3AfTqogEvVCBw+xX4OimfTLXmFSMQZc0w3Dv+9LU0tipkqVf0IpAoxRCAe9uyyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741195; c=relaxed/simple;
	bh=AaZXRsdVn2tvLYsDOVlyTZEChQrM/esAH6DERNhXAfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgcaMlOV2mDkvwIpW5Ps8T5XE2lR7+uHPBchpyAJJMR3t5vWIjR6/CbVEL8daqhK23w4XDoWkyHYbbxkY9qjzS0Lhme0IZ30tV0Gq5YEshQ+gfPtU4XuhEf3ymBQmzWxuBpguvQQIRRv3hWPwQ5eGxMpe+cpdH7z4Q09QEDXNqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fDGxygTu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fDGxygTu"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a05b4fa525so114169085a.1
        for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720741193; x=1721345993; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFVrrIHp8Vup92boS3hFd9PYBN8YKvRYBK43QitxZkA=;
        b=fDGxygTuQcnZ/cokAEMK/YXmGwJDEY9rfdgK1maqAbr7rt7M1k4ZBAPYmsY+pWx6uu
         oKq1N/bGCWgyI2eOl040Lq4OJ23ckUvrhxzmsknzsLY8+KSaAKtVpFZeJLrzG26fMeS2
         nyBwdY41nqJZXDLgXSaJAnnExjIe7dMBreyMc6W0m9pxciv8VX0OZW394MmGK6OkBQ8t
         f0NtziNsj6KJn1ERRuYUrI+m3pb/QG/xf0oO5v/OTf1eXh0xtQ2qkKfyI/v5br1Nb3Dx
         2ognFakLh/tffN7LibuIvSu3ccTDAtICZuLwRsSv41hym7zd613GCg6o9JENyADCQiKG
         Zj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741193; x=1721345993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFVrrIHp8Vup92boS3hFd9PYBN8YKvRYBK43QitxZkA=;
        b=DgCANzA+F0dLP2q+KNjDbJ+eKAuF74P4LOIBP3P/SMa7/V8YqEuMSbfu2ltF8IGEWJ
         LzMqbBO0YgwFIl9rsAMfofHP4PmMuU67GXqWp4KDGII683y+MA49eIr96bGT4dhXnpD2
         2j7d3S37lUKXto5/m0isHtWeXamc2WkLumZLqh1PWGmYGYEBSfHvOnaDlhFrONe24c/w
         GlHapxD8Sq3Ouw6Znde0NYQPW4zrZMJv/Qm6b39twk5WrzK3bJJLUJnpnPNESUMwJXxJ
         /jXFJIleWiVnJWtyoz9V6xdIYv6XOCyDfR7VXbF3SOA6AprO2FlKQ8broAJyd6XXsCEW
         BD8g==
X-Forwarded-Encrypted: i=1; AJvYcCUdn8bXTsiKhli0d5X+1W8/o2Atco6MYgXekTGqrko1cEhfxxiCa8znj2OSDP0UAwcqCNsCTDX/y9s6765KCc5r3XT6B4o=
X-Gm-Message-State: AOJu0Yy4BW+SLPhsJswocHF/twukmXtN9nVVOIRqayI2sRd2ey2SjjHg
	1nA2XSEJa5+Og2xDbudfQUX2smMhZBhxJGyYku5nihT3QYMS+RO2YS1Q6ACvSmw=
X-Google-Smtp-Source: AGHT+IEvE6NFq20imkRuEEO3x8KpVY70FapRhLgTh97KHKQPOyxmkDqYb4gFKM6bc2M6nmkv7zlTvQ==
X-Received: by 2002:a05:620a:4611:b0:795:60ba:76e9 with SMTP id af79cd13be357-7a152fbcbfcmr290215985a.4.1720741193036;
        Thu, 11 Jul 2024 16:39:53 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff827csm341798685a.4.2024.07.11.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:39:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3OA-00FTEK-Qs;
	Thu, 11 Jul 2024 20:39:50 -0300
Date: Thu, 11 Jul 2024 20:39:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommufd: Add check on user response code
Message-ID: <20240711233950.GU14050@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710083341.44617-3-baolu.lu@linux.intel.com>

On Wed, Jul 10, 2024 at 04:33:40PM +0800, Lu Baolu wrote:
> The response code from user space is only allowed to be SUCCESS or
> INVALID. All other values are treated by the device as a response
> code of Response Failure according to PCI spec, section 10.4.2.1.
> This response disables the Page Request Interface for the Function.
> 
> Add a check in iommufd_fault_fops_write() to avoid invalid response
> code.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/fault.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 54d6cd20a673..044b9b97da31 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -305,6 +305,12 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
>  		if (rc)
>  			break;
>  
> +		if (response.code != IOMMUFD_PAGE_RESP_SUCCESS &&
> +		    response.code != IOMMUFD_PAGE_RESP_INVALID) {
> +			rc = -EINVAL;
> +			break;
> +		}


I added this:

		static_assert(IOMMUFD_PAGE_RESP_SUCCESS ==
			      IOMMU_PAGE_RESP_SUCCESS);
		static_assert(IOMMUFD_PAGE_RESP_INVALID ==
			      IOMMU_PAGE_RESP_INVALID);

As well

Jason
