Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7530C60D
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301947; cv=none; b=dEF0GpR7X5Y+NUX25rhLLnHY2ZJC/S+OvW1EB0VtaRkJsJ0s8Yno1KpwbvESVxS+LoBZPCCNBdMenL+HCFo/Ex8n/7kxeF05/aAbgvEs9dtiG9ZH/0Ozxaclu6jVO6BworVsCpK1I1FXXMVOtBXlOKHPsKDMj1TX7ytTCynDBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301947; c=relaxed/simple;
	bh=o0qaudtJwkdvra1onVwfX5CiVQMZXk6eoY0Q9IzIjPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQi8gjw+E+YE18yfpOR1PvxE670AarO2vHn83xIpx0J8dXgkjIMHMPsRHicru4XvEm4jhBmgtp8dUQlYHp5HICBh9YHlmLYY60hlRneDr0PaZcOdsXFZ7TAC2eL/+A4yKN4AaXsDSfk0Wp9qTRPc2ZEPbHJ3L0+QzjTHrfKMJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Imq4Ez0j; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Imq4Ez0j"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so30075ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774301945; x=1774906745; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUqIg+cj5irYNTC1RJNBQG3tQF9wR23we+1oc9KaM6g=;
        b=Imq4Ez0jJmOzECBwc9qGWiWWqrJC6KRsp2jjdk4KA/i4PMxYUFN3gn/uPLk0/naiIW
         aKPIzubmZKvVihiCBJiLP2Rtc72st9D7DZZERJB1DJ6++UIOz2aEMMgDdkaa3KH2UZer
         vuxEBE+SMShW/ZjUN3XRKeDIm7xTtA+uEdCGzuJhxDwvLjHk8cmBoBo2gf1D8xtAw2Hw
         r1/OHNI8LeJ5WNwSzoNbv71Z0uh3v0i0myAQgecFWyY3qK+NTkLO49KMrHhVZb0gHMN1
         skb9iZ/Bijc28aQz7R1jDmUFEZE1yImWMoKg+kTsMjTTBgJ2lcf/10Ty5a7VLkQyg01l
         h9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774301945; x=1774906745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUqIg+cj5irYNTC1RJNBQG3tQF9wR23we+1oc9KaM6g=;
        b=lRJYerluHF2tqteV75y10/N5itG1O2WViBChJezWydRKcfwYeK96WydPvJhV5NptJ0
         dFHF0h3GQSi5QdR6O5obbxWQe5tIU744vmFyQEliIid5Ak5b8ipCiFMdTNKlf2a9xxi3
         4XgWdpumV45n75LiTACGHkjb8Kawpes+zgOPwkL1sZien4uneiiqo5t1PAje3trDOaju
         6HhH8eC8lqKJsJC5Ra6BzXTr4tp0vBbKQwossf/UEVzHfVEuAP4KzaziS9RLQ5AMu27A
         mJmKV7cIElrlK0w7nqpgZyDKGOFkLlF5DJJwkgwAUncyRnUyzwmgEsvLLe4iAY0jD1i9
         1E9A==
X-Forwarded-Encrypted: i=1; AJvYcCXuGoWwXV+MJeS1spkTKQXwgiTjNUAIWI2tb9bNNT24f7o2voTlT9N0EeFYdPLEq8QHXat8HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJV4jVGDLPRK1AwXoOYTfu4XX9S8O+FTchU5iiCMoi+QpcOyYW
	QFOtOxFU0yU7qcxbHDteH4ZaO4GMSuCxZcGXY9hSW4LUQ9qI6WefAJioGpxuw7ASCw==
X-Gm-Gg: ATEYQzw05mDgC2ajoEORXU+Tmf+lp5p4DPeJLhmme7PNbAoLAyi+1lTkNMWx/NRnunD
	hYF5uIedDnkQIAPUND9n75gA8t59PjaFUWJlu/HWeQNpoVK8KBTof+aEeJrCDo8sBNfh3iYGHls
	LZbBtRItlRS3Rmtc4pmSF22bd0A1HVcu7S+AHMWAA0Gzkdo65EHycSt9zn5NahBxdXdHb6Febpw
	J8X7Jl5rahWKdksZl5EJUeF8iRCtEV+nI7yrzk5IykP00hl1TsPtHdgbWHOQNyjy0GfI/fOT8Jh
	avyPYZ+KatGkIdPpKnV9fOYr/ieoe7mtt3iXeBCn8k+ZkhfNPQ9ph2ZcnGDPSAQ++kymIW/VJ75
	gP/0a1A0FRqN+yc+hS3NwVyjm8a9ab1CTcm8KSSGYhDyykZ3svt830bH36ZGbgecMdSvnYBiVXu
	czgQgijRF6kDuQ5CjgFAZ/UOv3FYkEWtTMTYx4cFOXZ1PWX1up0FyoStQ3GqHBUQ==
X-Received: by 2002:a17:902:ecc9:b0:2b0:5ba3:2416 with SMTP id d9443c01a7336-2b0a670728fmr370665ad.7.1774301944787;
        Mon, 23 Mar 2026 14:39:04 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc1ddasm10734026b3a.19.2026.03.23.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:39:04 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:38:59 +0000
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
Subject: Re: [PATCH 12/14] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <acGytNA4gn7ePQ6k@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-13-skhawaja@google.com>
 <20260323203818.GA2571566.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323203818.GA2571566.vipinsh@google.com>

On Mon, Mar 23, 2026 at 01:59:13PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:46PM +0000, Samiullah Khawaja wrote:
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +int iommufd_device_preserve(struct liveupdate_session *s,
>> +			    struct iommufd_device *idev,
>> +			    u64 *tokenp)
>> +{
>> +	struct iommufd_group *igroup = idev->igroup;
>> +	struct iommufd_hwpt_paging *hwpt_paging;
>> +	struct iommufd_hw_pagetable *hwpt;
>> +	struct iommufd_attach *attach;
>> +	int ret;
>> +
>> +	mutex_lock(&igroup->lock);
>> +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
>> +	if (!attach) {
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>
>Should VFIO in its can_preserve() add this check?

Good Point. We can move this check over there.
>
>> +void iommufd_device_unpreserve(struct liveupdate_session *s,
>> +			       struct iommufd_device *idev,
>> +			       u64 token)
>
>Where is token used in this function?

Will remove.
>
