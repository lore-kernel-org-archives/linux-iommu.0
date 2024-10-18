Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076E76C61
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260971; cv=none; b=CQIEe7iJXVRtEgiZYEi1frOmExRCG8KG8MhTFBE5TW3Y2HUEi0UM6gnVMt/spR0v8mNcNWRiRe+N3oMu0HsPCdXhpHsfFgldOXNNpNw6+c0QR7g55pwFOZ1so42Nvw7Y9vdm+SPeqPacQnWFTMcYXTnUm5iwdz81kMYDU9zntdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260971; c=relaxed/simple;
	bh=2gkUppWgJ68hNOB6ojwBxJLprbuJbY7Zgy7MyE8ekCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXxnkDbaEmB41uFoeJ4f2RVVgZ1tOe5KnUFsQO9tlaoPvc+d1FMO0JXT5Kg6jWSnl4kxfLjsyNb1pA0xh3Btc3h106ykVs1NDH7x2sauPzkpdMze3msMwahgOV7PlxDudar9Wy9UuyQk+CDP85xsidTRfBD1LXE5jvfMqCQYTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fQrilCJo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fQrilCJo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbd005d0f9so14570006d6.3
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729260968; x=1729865768; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfwDqGHcHmOgzzqazpsS04NkLxaznjyB/RcmrCY5RxA=;
        b=fQrilCJokfbP2RY4y4AR83bzNedixLE5TVpK038uf85NzNZoU44PV0xHBGPk4DHKbu
         jwWBR0SFL6ZrAZuA9ovLSQz3FvbJ2sMJ2ev0/3C8XjxEeFK5qIbIzsgOJfzO1PKYnB/1
         ZDwDjmQ19KrqXMGtoK6DEza31G2sjv+gLc6DlZKzH3G2TVSuk2bKVQFAeXzXwFu/SVLM
         eiQohKmAKUCGQ/SWeIwFGuID7RVsrJgxT+1UkTNbzO2JzStgG0z8CT17BFDzPUI5aVjk
         k9iJACfwq4RFuiyApH3k839OQfSEUTOPbt0T/xcbvSYMMgdIExWnyry4RAyKbtft9oHk
         f7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729260968; x=1729865768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfwDqGHcHmOgzzqazpsS04NkLxaznjyB/RcmrCY5RxA=;
        b=S5X2rJ/+RAlK7u2porjvRQUG/fZ0w/RhgAN0rDW6RTlKCLNfGTovJV/6Asq2k+YVOZ
         sCgASbwmqu3wLAMD9bHQvBVMaoE1BcOcWTzuLN+/Snnd6qtXOJMA7p00yqtciQ9OoZJz
         cUPVgFfeJegKKZrPna7o5X5P+yt9koOSuBTFNeKwlTn5nKw+qVVPcqsPwVEuYY015KvB
         jwCmo/BQMnCCdzASbm5+XeDmbPg90od/IBV44Z+OYRsn9KttwKx73eIABQtVRmqOyf68
         STxqv8W9C+Z7oH8sLTCgYr6SDQ+zXhcqkKhpoGOXJZt2KhxTP4mz5+uymVUYsZyx4ZAG
         Qw9Q==
X-Gm-Message-State: AOJu0Yx/9U1VuECpObiGVeuriwnMU1776tO+Jm0q6Jd/hXHp085hGNQz
	FEYsvdesfH0dQ+K3PLaTeyjG/y5OlbpSKUx6opzKyzsiOHizN10UZQxOTXxyNr4=
X-Google-Smtp-Source: AGHT+IFgfvxzRd3OqWspe6QMfTcaslu3/C9s9rcC7gvgUXZlSbKorzQBYJ/1S7he8mLiE2XYULxmag==
X-Received: by 2002:a05:6214:5b0d:b0:6cb:e934:db97 with SMTP id 6a1803df08f44-6cde163e41bmr27437266d6.51.1729260968202;
        Fri, 18 Oct 2024 07:16:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde123778esm7249936d6.75.2024.10.18.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:16:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1nlu-008AbT-O9;
	Fri, 18 Oct 2024 11:16:06 -0300
Date: Fri, 18 Oct 2024 11:16:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
Message-ID: <20241018141606.GG948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140137.6028-4-vasant.hegde@amd.com>

On Thu, Oct 17, 2024 at 02:01:28PM +0000, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
> If both IOMMU and device supports PASID it will allocate domain.
> Otherwise return error.

Do we want the "and device" language here?

I guess we need to decide and make it consistent.

This is if the iommu driver/core code should fail the flag if the
device doesn't have a PCI PASID cap.

> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>   *                                   enforced on device attachment
>   * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>   *                             valid.
> + * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
> + *                          domain can be attached to any PASID on the device.
> + *                          Any domain attached to the non-PASID part of the
> + *                          device must also be flaged, otherwise attaching a
> + *                          PASID will blocked.
>   */

And the choice needs to be documented here

Jason
