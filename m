Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69E5C033
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808948; cv=none; b=u9T87DdHPcjTJfOy61cS5PVxWNkxTr46JkdHFMOY9q7Id9vf7NYpuqV5DJ8M3hzcYMagVsCohN9aBY1SBrEDXLfkABazbTJO2skSvfW619cFQveq77dGYxfpYKZjdYn0mEcD2afwXwzB2gN6scam3b4DR+R0Ge6D2SO1vcR8834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808948; c=relaxed/simple;
	bh=TnoQPxkS1ob+C2pq8MNtg2hQcj2VT9G52nCSwYJBH0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4mefC98Dd0uXdoNNEgZjWPz3Hb4tlShuX3gmi+6c8EJy2guxjPRnZwp1h4UYDLv1RlvNwKct0HXCos9jks1q8Puz/xbzSLjtTbImT8cixJopCu3BaK6sN9lgecIsrvCW9FdoUg2QcUkOvbOj5WLf8QepqWkQ3ocBdSlSj88kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VogCcy7S; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VogCcy7S"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-218dd3fdb7cso664521fac.2
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 09:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706808946; x=1707413746; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ig3ANawaSTmzBF2PZMTr4H17zHeXQtjR9HYMT2cp3/8=;
        b=VogCcy7S1kMT6vOkAo073Uv8O0ZowjTyySwFY4kDJv3HAzDtWs8eJJPMM3F16MlUXe
         tH+FikJAEKV+uE00JfxGixHwRSiP4nps1na20ZLnnOd08br1reiLpYesElcyWT5SHjpm
         NPLJktQ79nm3oVh+IwGyiSB5eChbxBjQAX4dx7cP9LQLNNZA6izKmOeuMkELsQbG2K1z
         HMntMOzRSkwFBReGe8UPtbR/EWWXL6YWUg/BrF3BP/zUcm6IUwyFSMjg35+kRLohgWMN
         WTI/oIbBzeWGS55XwTXM3XMnc9VqcMgj6i4ds3VKZ8+NBvmXl3pbmzkYwFuA8zz7DBKg
         PL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808946; x=1707413746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig3ANawaSTmzBF2PZMTr4H17zHeXQtjR9HYMT2cp3/8=;
        b=DQe8Ruf+ijs+pTsobOckW4UsZUaj/CteZZGaP+g9wFBeOXIHYSBbvyYgmJN1nw1MoN
         /9klnSmhk4/fk5MZDcU0iQ2JTaOA2Dqw4VbUTiVMU7iGX2wAoiqyhuvqjQ21oSHePeuW
         kgTYs4FKCsZPHJ645vtTHEqQhbuy0MpIjZAlW+X2SXEVm0b7CGEBAkPJEYSx4/j8RF2s
         39xE5O9J3lK5XGQfH65fRJ8i3wZ3V3tazak5d29LsmQDSeYTWeptqBW2omU19WMKGbUh
         +8CAP6VBmdgncO1pW/Il37uYBIO1s9YwYBVxdR3LA35z7v3wDeyJjVzF6eh3GQrx76Ms
         TP6w==
X-Gm-Message-State: AOJu0YwVE0cyBNIqsn27pAJ0aXP+P3UDpe7qN78Q+j4QnzoLkYNv7luZ
	XwkHXyYqSo3vG6saHEBqnhiIT8M7vGN6CDhazpIAA3QeQ0/HqllEC6iV8TwVb3E=
X-Google-Smtp-Source: AGHT+IFlOPkuDtNaDlq9KfGNmFLeNioEpJCtFIvKPCxWY4QwonaXTLwayzAeUGLQ61iVmDQ5PLbPmQ==
X-Received: by 2002:a05:6870:ac0f:b0:210:8383:c26f with SMTP id kw15-20020a056870ac0f00b002108383c26fmr6066402oab.34.1706808945790;
        Thu, 01 Feb 2024 09:35:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUe6d62roOP6bVayLK8zsJq03Tcen3Cs9fte51zMdOGpDXDZxAUtggSiSanNElgATIZiP3rTn1nT+yNh0rN+xXUy2SYomeZlPT/VaF/JpTaZtqBUHzmWcdSxVEZUWCa8ThbxXXEDhNiaFEU+1cvel3pfl+TvLQhoGDgXqc+QU++acIBLSOJa/Q=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o3-20020a05620a228300b00783f4a4e07fsm3232qkh.43.2024.02.01.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:35:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVayW-00AnDe-J8;
	Thu, 01 Feb 2024 13:35:44 -0400
Date: Thu, 1 Feb 2024 13:35:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 10/17] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Message-ID: <20240201173544.GK50608@ziepe.ca>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125121135.8217-11-vasant.hegde@amd.com>

On Thu, Jan 25, 2024 at 12:11:28PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Refactor GCR3 helper functions in preparation to use per device
> GCR3 table.
>   * Add new function update_gcr3 to update per device GCR3 table
> 
>   * Remove per domain default GCR3 setup during v2 page table allocation.
>     Subsequent patch will add support to setup default gcr3 while
>     attaching device to domain.
> 
>   * Remove amd_iommu_domain_update() from V2 page table path as device
>     detach path will take care of updating the domain.
> 
>   * Consolidate GCR3 table related code in one place so that its easy
>     to maintain.
> 
>   * Rename functions to reflect its usage.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h     |   8 ++-
>  drivers/iommu/amd/io_pgtable_v2.c |  21 +-----
>  drivers/iommu/amd/iommu.c         | 113 ++++++++++++++----------------
>  3 files changed, 59 insertions(+), 83 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid,
> +		       unsigned long gcr3)
> +{
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	int ret;
> +
> +	iommu_group_mutex_assert(dev_data->dev);
> +
> +	ret = update_gcr3(dev_data, pasid, gcr3, true);
> +	if (!ret)
> +		gcr3_info->pasid_cnt++;
> +
> +	return ret;

Try to follow success-oriented-flow when possible:

if (ret)
   return ret;
gcr3_info->pasid_cnt++;
return 0;

Not worth a v7

Jason
