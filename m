Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40621D414F
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171202; cv=none; b=WNynlaE2cIGM5uhg5nIsQ2s6Z0dOR97dclyERnkj1iX+X22zTjl18eaiPcHjmHnshKeuyy4b0H6iA6wepOANps2n/WWoZtkD47YKp1ES0txa3cxTBfB7f8EwLC3bBBfIue9o4XVdekigKK2PynzdBD0Zofmi5pSrhnRVmLCMHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171202; c=relaxed/simple;
	bh=fspanYMdDF2a3TwJNjomXS7wFnYtQTiEYyv42FAIvqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdwCHpv5fB/E42XIAUrOHfND9blVbsKR1nZTaRIyXIIvGDvL20APAm/8SFqpJv+i0O1bg9DU94BpdGRVS1yn2IGlUmz7hJATVt0T5v4oRxn1+/92fLq9iZqCFTod6TiYRscqr/cQUyWlGyhc6TUlC9+ZMqrYUoOYk7xEHIQrdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VKoaSuhT; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VKoaSuhT"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7ac83a98e5eso72997085a.0
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729171198; x=1729775998; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTVEeBaC1J0Li9+QgJSfODfYU+iJK8WKTlX6FyB5xUg=;
        b=VKoaSuhTyIg1N02RYmb5hrJdlgbUvxFAPZYwWHsqXRiQ4vSPkM81O+OnE0UQWZQ+f5
         qdPj/xh9CDRdI7Vl0GWPCNqQ3K7uqgecXrknDjuYtmr2aOS5cF/sJBCin7uFVxRWqVpM
         pXikB69pU3ZAb5JkkUjguDIMjBFrAQaaY4HH+22xCShWj6QAcgDKEXYPISdRkyKCuS55
         T7P0DWOwQgA3Sse/ajaXZ8c3jxMJO6CVGL0YsFfUCYYqg1nRWILu9wwVIaWSSfUmNj+M
         dF5VUIk/mmjbav46W0TA8CsTPoeq24z4DnCR/XZqIEOrs3E8M7himK/JVHG++VF7u13z
         9icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171198; x=1729775998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTVEeBaC1J0Li9+QgJSfODfYU+iJK8WKTlX6FyB5xUg=;
        b=ibXA4hI+LCxOXkrTcdtQhhTNlt/wk9BStTMmgZ4HGDXgIKf/7ObomaiPHuOSjCtYFI
         xCNWaecC+XuNE3GhQEQT/sP74LA8Q/SjJxbhTsvlfRvcw2q1dQYhjQw8pqIC9i7Ruxc9
         JenTu1nVOHs1+ZIfzGuUo+spZACBxtkNYriH6nXh/7YfIEzuYV/9xj72VchaCFbqclf9
         t3ZIRdffrKdnFYfmk2/3QjJG6sDwNibievInLjAek0vX2xi8CXBhZOia3FQPBRNwY/dD
         PaeFKVQXeAxVzFpE62HBrEPSCCozWOeiCqNWkRpdAdag6T6dojhxOh8BEzU30ir73Sa0
         TtvQ==
X-Gm-Message-State: AOJu0YylN3K0mrGkKZFK9/orM6gMAyAHW4xcy2WuBUD7b9fatL/9qFCZ
	Aj486Bp2HaMoNz9wx8vW4q8Bde1lN+MgqEUzK1OcQl1e8G2S3LI2ltgVpULcZxc=
X-Google-Smtp-Source: AGHT+IGNVKBWj7V6WjCk/TNRrZGeL3KFuXKM2T1dDs1ATL+vZ+xaUqMq+88+tef6PNCDYXa2pkXE9Q==
X-Received: by 2002:a05:620a:48d:b0:7a9:aaef:305e with SMTP id af79cd13be357-7b14d4edd81mr421450985a.12.1729171197917;
        Thu, 17 Oct 2024 06:19:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136395508sm292457385a.94.2024.10.17.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:19:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QQ0-003vRZ-VL;
	Thu, 17 Oct 2024 10:19:56 -0300
Date: Thu, 17 Oct 2024 10:19:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 03/10] iommu/amd: xarray to track
 protection_domain->iommu list
Message-ID: <20241017131956.GM4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-4-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:34:54AM +0000, Vasant Hegde wrote:

> +	/*
> +	 * Devices of this domain are behind this IOMMU
> +	 * We need to wait for completion of all commands.
> +	 */
> +	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
> +		iommu_completion_wait(pdom_iommu_info->iommu);

Please add lockdep assertions to all the functions touching the
xarray, the domain->lock must be held for this to be correct.

Some of these are many nested function calls deep from the lock, I
didn't notice a missed lock but I didn't check every path.

Other than that, the logic looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
