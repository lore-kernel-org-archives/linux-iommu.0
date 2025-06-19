Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56B27876A
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324484; cv=none; b=qhtDDrrahD2g6purGr6i3leyAJbyuukrzbUWn2d4N5HqdDaoSDVyD9wg7nlMhUrisKlJqNx1TpdGLTWvllyCCDcsYuA/1eQdSFKuGLXYd5FLk2OqsFHOVr0e9evWUu2ggazlS/46QCtFEwMtuyAQMMDBAtAO5/e/o99gU0tYvYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324484; c=relaxed/simple;
	bh=oskZaqewOdI9Q2vgMTv3V9kHOUv/J7lvDhpMHUc35DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epM7mkUoFSF57O084OhZ0CHdmx6O0aYsgXImAntK3p+1e5d/x0q3SwvMWHibpr63CN1Rhfy+5I7+YmCupM9Kr2PL9ESIYaMCiBsB8scbOjrWmdRFqvYD8IMkbUufpu90AOspxLhPJ3oadLn+1b9uFKbZnfqHjdlcV7ya/msLVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIXcItZy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIXcItZy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235e389599fso154965ad.0
        for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750324482; x=1750929282; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWamqH4Qzt1P4RdD6HP7YstMpMkIZRoPsNcDiTnzqKM=;
        b=AIXcItZyYE5jgG534hw/VerbkKKHE3M2iTxPWhG6XZlI8lysLXpr5w0N22aAzXDJ/E
         KRKdgLI2kHthuFySeTMX9f3Znh+TZ1rqM706eldgatVuPmGVLyIxb7bQH8J7IX0xrgmZ
         zxriAymZYspOuoLeay9IWAR41MCZNjWpa3klCu2EMppRBqlyQomMe3+DSHJ+hfPhA08n
         oDGbM5zBJQ1Sb9x6KA4v1UK0q7+UYBkWqStCMzYfMT0tn29/eBlP78rq1alnqhM7Ntj0
         OjSqNnOlk0IxeHkJkPlaCqk52tI4wpqmDGfYwlmi+gPswUCkfSSlYQBol2eRwl24IqB8
         /l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750324482; x=1750929282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWamqH4Qzt1P4RdD6HP7YstMpMkIZRoPsNcDiTnzqKM=;
        b=AQa5AMLtkX4bKFPWqxbfTVn1UTxF0CLmizyCRVpotf7TArVhWUfWK7nVhFRH5Bn51c
         Sq3VNkG4SVdDtLM8QDEPkkNxxO4b94yXg+JLI5Bal24+O0VgjDZJVrjband97sVy6im7
         TbrFBeCiSYbnOsL7gXj3PSIl+VTQxphVF9Yd0cw0zF+GS3NfwbNDWCSxTZJTX5yoMMf1
         EOS+qskQDD6HFvpglrMaPPrR9bs3pYJAy392T23KgZT6DhCm1O+EtFvda+YdQJ5pDIg0
         KOXfkGhZsN9EgdeMMTOZyf1OCK4377etHhXSQFsR75nW6M/sgOsPWy9opZbPAiowm0JH
         Ev0g==
X-Forwarded-Encrypted: i=1; AJvYcCUOSYQXBppXRCAhowSOE77ZQq2sTXpj2vI4KuqtLCi0mWxHyWlBM8oHnn56ET+RH/mt59134g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqcMkeT4FZcaooD3Po77QvMhEugs2nSeGGn7sG5l/HNFz8rnXY
	tBkYLiCV8RH3QgzUb91jhfeSrDvX6/58zVAw/kdEwCWJuY/MkH6pNvgUGaOEn03OIQ==
X-Gm-Gg: ASbGncsk16HasGjCXN6CFVIF3WQRfYQZ+E5VZ710+4dOiQknAPSUgKo3CQpbgstDFjS
	BvKwgJbnylS2riTMWbcqD3pD55E1a77ajGwQSTqha6f8ckGAPF693kK0VD7haFjtSMVfsW+0o0S
	C42zocma7Ug692py75EFSsav3lU/mv1qAmrP32xUdwfU/i1opHYeIkr4wZ+c8ChTzF9k6Yi929c
	M/oVVZFX18jmcbqk3L9T72rZ2mZKMmMMZCuYK7ZM1O47fbK2VTMcfCVFa3DmRmq1VLTp0+CF19s
	vT9Ky715DSuFK8kzyr3JnPVR4jIyK4BNVwpe/DH8oJhfzzGEGkUQJ84r2FChy2iRzc2crgHPKwy
	4girEqdr9lf51Zc66oxVl
X-Google-Smtp-Source: AGHT+IEvh8ntAaeawSzvvAW9v54xfOai3SDk6b1VSkUWtSTdDIzpJHZdPCeE04W9I0TDOLd777OhYA==
X-Received: by 2002:a17:902:da48:b0:234:13ad:7f9f with SMTP id d9443c01a7336-237ccb4af65mr2441805ad.22.1750324481903;
        Thu, 19 Jun 2025 02:14:41 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c029sm114860565ad.26.2025.06.19.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 02:14:41 -0700 (PDT)
Date: Thu, 19 Jun 2025 09:14:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
	will@kernel.org, bagasdotme@gmail.com, robin.murphy@arm.com,
	joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
	nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
	mshavit@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL
 for internal use
Message-ID: <aFPU9TKgU0Lofl-O@google.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
 <20250616133305.GB1174925@nvidia.com>
 <aFDRKEsdVZc2XQ91@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDRKEsdVZc2XQ91@nvidia.com>

On Mon, Jun 16, 2025 at 07:21:28PM -0700, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 10:33:05AM -0300, Jason Gunthorpe wrote:
> > On Sat, Jun 14, 2025 at 12:14:31AM -0700, Nicolin Chen wrote:
> > > @@ -1321,7 +1328,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
> > >  
> > >  	/* Driver's ops don't support pin_pages */
> > >  	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> > > -	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
> > > +	    WARN_ON(access->iova_alignment != PAGE_SIZE))
> > >  		return -EINVAL;
> > 
> > I don't want to loose this check, continuing blocking mdevs is still
> > important. Only the internal access should be able to use this
> > mechanism.
> 
> OK. So, it probably should be 
> 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> 	    WARN_ON(access->iova_alignment != PAGE_SIZE ||
> 		    (access->ictx && !access->ops->unmap))
> 

Nit: Probably worth mentioning in a comment that access->ops shouldn't
be NULL during selftests and hence we avoid checking for !access->ops?

If you feel it's too verbose, you can let be as well.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> Thanks
> Nicolin
