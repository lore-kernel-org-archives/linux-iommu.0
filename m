Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEF61FCF
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566159; cv=none; b=mquyvFH1o7EP8QzXGhP2aBKZTu98KJ21sl5dSTrrLBAgek1r+R7pcfLBFOlBUNVrzUCLTs4GK4tZP5001EQZ5K3tznhXccAqDiFAdhuwjurd+51vV5VYE/feP3B8f0OLygjqS1kbk2Hy57nWEILDCC/Xa/xmNlxJ/NHUPtPihdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566159; c=relaxed/simple;
	bh=qtDY1QlEwivta1Z9s7bbxzEqsw70rJ0e5k/l5NM86as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK7D5UNvfuPsLhS57zndME/MNfxcQiUTBB/tNTNjX1I/kfNk6TfxtgDlcCf+tayyRiFr9QulLWWA9QTQfyecgOs1Le80cION240D66621SVpwkgXpxv6fqmTtZUJPJ5ZEtoZUJOKKoC9couFwhUHjHuv5GnKTESjSnHU2UwDwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jhaxVbYp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jhaxVbYp"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a4df9dc885so3374585a.0
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723566156; x=1724170956; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M94qq2H49DA5KtLghr95O4W2AFmJzCxf4PAEMIU2NIw=;
        b=jhaxVbYpDx3i+6DCL1etZFnQa/UYj4N7gf7JNzMomXbCYpeA+0UH6xiYyFL6BYjnRl
         HLaBNSK/AyKwQWpYr8FL2UY8UxuL867PKiUk39zpsH3kZvHIoPoBYxCMX+c9yvjRX7Ic
         97LAz4ePr2wJ4nMdK1flxcS7zb5vUvQ8mOqnsKNTBp+Hl9pPcmAxUzex0a/U0hnUirH8
         9ZsVJCDbSBTnmcX4tJmlz58oUIvkTqmFH0NyA+4Z+bzHKdgoEIhvFxgXZMoF3+y5tEnl
         Rj92iJR3Scnq6SO+IGxfqSrM5AHjDXbad3HXSh9ED7Wsz+5c68lXCgD51XENxT0uQFWb
         JWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566156; x=1724170956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M94qq2H49DA5KtLghr95O4W2AFmJzCxf4PAEMIU2NIw=;
        b=uAg+q+2229DfwH/jbjtTTEYss/JHwh5j9WzkBj9xfsG8181jtk5UU6sTbCau4L4gvL
         YjAWOZbEpkkE0nCf/u/55wVimRYiUVnI8BGNJI+PVtaaRexrDKHXbC3iFnya2Mz4sMz8
         GPwLb459O9aiMrywjk2zn1fVkRQgvUExjuHQNooxLmfUSMKNFdeTCI9ipaH12quT+XHR
         ppbMPGbPcUhzSwgGOGrJG9bbSD/oNp5KLOyJHOJXFvFRmhqFOeOimf8qFeYtx0MZ7CVf
         BBMvjNDiuWchORYvJj7V07Y3rywTIALWkiP5fl8OV/WVDcLpQgdnOE1x+uUnv38viVr3
         v26w==
X-Forwarded-Encrypted: i=1; AJvYcCXXWsg28OEj4bNAlufRII5lgaoooDBivw7tyjU/bybc5p9OzqIAUuQESgONq2wJJc3EnjyPcPvKZmomsZJFq8qJUv6ZiLI=
X-Gm-Message-State: AOJu0YxeTqKmmPqY23OL/mIuKmuqKF2orZ7TPTrklYtgUi92EEVVgoiz
	HnS1RQa1F3N2GJg2ZVZwtbCkuxl3VTrV1Rzcp0RVkyJFLt3ed8QyOWGmCwCtYCA=
X-Google-Smtp-Source: AGHT+IGHIaip/mLSORZoNNEk3TA3roHbz8Q3UKe6En5lHAsTdzbRGKpq3JJopvJVokFifCh/lA41Ig==
X-Received: by 2002:a05:620a:2989:b0:79e:ff18:a510 with SMTP id af79cd13be357-7a4ee11c9b2mr38126985a.2.1723566156438;
        Tue, 13 Aug 2024 09:22:36 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7df4eefsm353396785a.85.2024.08.13.09.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:22:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sduI6-008OEn-VY;
	Tue, 13 Aug 2024 13:22:34 -0300
Date: Tue, 13 Aug 2024 13:22:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240813162234.GJ1985367@ziepe.ca>
References: <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <20240808011629.GJ8473@ziepe.ca>
 <20240808130814.GA1985367@ziepe.ca>
 <11b95737-e0d5-43de-80ba-69923ee8b249@amd.com>
 <20240809134454.GF1985367@ziepe.ca>
 <fe275b31-41ad-4d7f-89bd-bef4788f58bf@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe275b31-41ad-4d7f-89bd-bef4788f58bf@amd.com>

On Mon, Aug 12, 2024 at 02:51:56PM +0530, Vasant Hegde wrote:

> Let me summarize and see if I got everything right.
> 
> - Enhance iommufd_get_hw_info ioctl to get device PASID capability
>   HW driver will implement iommu_ops->capable() to check PASID capability
>
> - Userspace will use above info and calls iommu_ops->domain_alloc_user() with
>   appropriate flag (If PASID capability present then pass
>   IOMMU_HWPT_ALLOC_DEV_PASID as flag).
> 
> - HW driver : If IOMMU and dev supports PASID then allocate PASID capable
>   domain, else allocate normal domain.
> 
> - When attaching PASID to device (RID), PASID attachment will pass only domain
> supports PASID, else it will fail.
> 
> - IOMMU_HWPT_ALLOC_PASID  flag is optional:
>   If we endup implementing this flag, then it will allocate PASID capable domain
> if HW IOMMU supports it (It will not check device capability).

So how do you get a PASID domain with only one flag? You specify
IOMMU_HWPT_ALLOC_DEV_PASID and expect it to work for PASID attach too?

Jason
