Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5514198F
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887739; cv=none; b=Nu6E7E7Sy7EgX/uBTiAAHSCUZNQ0XTpMeNxWrWa4q3OWvEz6CIlboofVDx6VQHr1NdCBnULr/GyO+DRztzVPh8I37mRVP/0KIf/9UHOEKG+eD/walPsFWfbPbEKeH0ZFUQMNEhPTK6GQua5QQfrRxJSU7hgza3OlQqN3g+LH6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887739; c=relaxed/simple;
	bh=N2m8+JQC1Ll5X7ZXQM4JITQkGILi/HfGaDv1x9rknoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckprdlz09+9ZW6U8Xevlm1wJeScIM0kwHt5MAdWk8G+BtA+QTznvPwcmsJXWg1uwoC0P1wPXpLXRtrD0AERklRT8ehCb3TKbWYBmCfR824H3XGLzoWSIdYN3QrT+ajbynGvfQwHlFo1V4nYB7IPRohZ/8+pfUmL6+3b0p8nrb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e1uBLrNL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e1uBLrNL"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c86cc0df0so3584266d6.0
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706887737; x=1707492537; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4DcQuDWerc7ndxaV1CiXHAOvnEHKUZ+7MVFWSk+ZsE=;
        b=e1uBLrNLusV/TZB3k5YpHi52IBKkSPM76u2+vO/B0pvnRa7Gew9ui8FJmfnp2uxMUo
         GYqLjwt9UW4DcLyRhXnFXTOnDdxsePsZkHusYQVdFesEo3DPr4vFPU2oyDtI8FLlD9TA
         rnww567Sap5vP8ihugVDd7WtI0Um10u18woHyF3qeQE6CY8/xXc5tmdtV0giHZtaLXcF
         5r9n3p9rdKDlYwErD4MABkzpNp9Je1swDAWBYtuZsRlb7S+DXhSe9Gf/ijE+8hWH1SL+
         wj4TNBSfZ3y/KGJ2OYZ9OEk4LIMSO2YPYE1v3yVywaDodNakd8JYLD6UjbwahJ7zeGQ/
         r5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887737; x=1707492537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4DcQuDWerc7ndxaV1CiXHAOvnEHKUZ+7MVFWSk+ZsE=;
        b=kwnMUnf6wlvNcU9OUvszzvz7BNsaLBLiFVv05xpK4jPeIW2L7wu1/cU6zkolyzNibN
         sSt3QarwHe7WZh02Mb54M/magPGMDQF6qFJYb42nViwULw3eqobuQseZGNlk7oTvLczb
         +LHHqknECEKEO8Bh7JORUk0hp4ho/v8XEJI2vZ2UPXRAdtzf9hepxfu998tXlM3dTuUQ
         nbe9hwRzAm0KJzHRqQjee6TyZd7xIXL6PeeMOqjl1rXTZsZSwNHVHJ1dj9NzI+fuV0pV
         pGM3W17RdGWnG0kIjTOLRUMBqAp4/gzWNLqmTSUjtnf9iLdDghruaiTcH8+vDacFxmlH
         nxow==
X-Gm-Message-State: AOJu0Yz/z0GiMCHM0VvLXJ5L2Vm+/wvt3j3wm1zyi8oGhSPkPzkNjwWv
	b3S0u7as/GJC8zB3r/DW6PThvsL9Q6Hc1KrfsTXFQMmajSN/01lzGS6YbcC0vAw=
X-Google-Smtp-Source: AGHT+IEgcrbgcwGT8dXzzc0MQ91/hl0cdED8VtEY+vCRQ/z0CFygTci/7mW3EASKLavH0Ge7PmT8SQ==
X-Received: by 2002:ad4:5c44:0:b0:686:1e2:7480 with SMTP id a4-20020ad45c44000000b0068601e27480mr2883181qva.37.1706887736742;
        Fri, 02 Feb 2024 07:28:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVipM0A59mH2FKPg+5Hr5CiQwmTSxsKUcmvEygnYd5XudLAncZkEf9jNygzkhXIE+C+L/LMYXdtCpzhydoKnJIyCJzVVVcJnAhInsZKEgjRdQyqGWJJsfV1B9uSEOEA8qlmMrgb39PlIukYwzdGGVW4bbbJ5TWYfkCaBDlW+0m8y9X1aQ8kHfQ=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mh12-20020a056214564c00b00686a22aeafasm899306qvb.18.2024.02.02.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:28:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvTL-00AwCx-Nz;
	Fri, 02 Feb 2024 11:28:55 -0400
Date: Fri, 2 Feb 2024 11:28:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 14/14] iommu/amd: Add SVA domain support
Message-ID: <20240202152855.GV50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-15-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-15-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:39AM +0000, Vasant Hegde wrote:
> - Allocate SVA domain and setup mmu notifier. In free path unregister
>   mmu notifier and free protection domain.
> 
> - Add mmu notifier callback function. It will retrieve SVA protection
>   domain and invalidates IO/TLB.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  5 ++
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/iommu.c           | 10 ++--
>  drivers/iommu/amd/pasid.c           | 80 +++++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
