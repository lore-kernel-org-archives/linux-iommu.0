Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFC5B04A
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808376; cv=none; b=p2Z9y4vCZpEFDwsVTg6RmDqiKL6W/J+BogrE3cBSivmUWh2Ql7jgyI63g3LkVK/n4DoHq8h7eBdLDeIlZlRT2nL1cV2/oby5nYM/nFZQZBWY4a2rHvOOkhXRwbkl2WAPJ9bwGSB0arE7JaL308cg3b1gchEtgxBWpzB8wJYUsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808376; c=relaxed/simple;
	bh=MzmY3SBI2br29d1VFVbDoofUufC8pLV6DU+n28wFuJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEWBOsco/trhKpM/yayD8lygrQx5Ipf1x/RIZVmv/6+rtbKjxtpiyMdjmOfEoNOh+qNLCg6oY7OCCC4+CQtd5lfHWn97EFyOVS14tZMcaS8TsbicjxGVf7VcBkm18LsOIK3GxmAEIWIFCeRk3S4ZkBEQVA2+9XZOT66hsWJ9VQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Idh3Q/Fk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Idh3Q/Fk"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78406c22dc7so85600585a.0
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706808372; x=1707413172; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5c0EpU350iBDFSATyuSG1CD8ky34ufQHjzsSSk6jEA8=;
        b=Idh3Q/Fk+Si80EFDVJJK5yQ93jzFw90dtMigmcJNDo0G7uN4CcYnNKFy4Jf4lbobEn
         FVUn2LTRctcUzGU6joREDXciiItH+9Zw+iy3IU5ke8ZqAEIaLv3AQuWflulXTNdc3dCJ
         VmJvB1NfMEwbXtX0xSXk9mAh+QhClkKWyRsqKKfViYi/S7DS/VyQ4QJKAndy5Y2BSj0g
         ShPxA9g/py3j5e0qEn6RDBtXopDOWXO4VE5DNyE+pQ1MFztU01sKQNvH3xJac7dR4Csf
         brn4HiA+XzjqnvNQr0qJijqSXtY1Z/lwnBzd1djZ7pGLdMW3maXcWl/oz7Bh66oLfcwN
         n8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808372; x=1707413172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c0EpU350iBDFSATyuSG1CD8ky34ufQHjzsSSk6jEA8=;
        b=hdXDSPeLAjgcKHzOD16VjcSWRzIIR7zsp8/FGzULkq0y/PaOYf3KXimfdi+HzXlWvO
         TIeLDfGtUgQEiqh1RG+gHA18wkDtTvBvLOJo5bycANjuPHCAuUG0NKVtvZ4mV8YlBen3
         BFZGPujA17FiEG6vvoTvTCsagih5cCdmf4rx0ThjW7+9XRUuPthSVQEwqUx/162lYIle
         JGq1kGSP0HCiV9WcofbjRh7oD08kdKP4oI3AaDYquAaGqi8P9Dnyf/WjnNp2pfumnsjy
         TrR8qu4NK9ttrZkeS0fzhSwcPWAuwF6hUy1xO+zkBUfKcn17AotdHNZMgkCrpkXc7ze/
         ht6g==
X-Gm-Message-State: AOJu0Yx0jTKlMnKpdTqQaLsC/2yvvY9mHGxeG9da+nPoHlQx8h7CF3Hu
	jAg4VLjPtZ931X9jlMOwFSAbaQSAKevYqg3t0/E8/la1S7knMd+37vVniH0G671bmnV7sim8Pmn
	z
X-Google-Smtp-Source: AGHT+IFIs+RLxvPW5tvKZw9UujLhIIQ4eFppwe2+OQxIbST3DC+mW+SuNbUAbGBK+HQtS5LTwaicbw==
X-Received: by 2002:a0c:f2d2:0:b0:68c:40d2:2031 with SMTP id c18-20020a0cf2d2000000b0068c40d22031mr2863905qvm.19.1706808372628;
        Thu, 01 Feb 2024 09:26:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWOWCbuimZlua4rAexgABJh73dYcsjmoHR5F39ZP4FtYJt+8dFGIHqLHJ72nsxSywIRFZTIF3Jricno3gLlX0r5lXiY1MnxqfqsoVl7Ljhvjizi0BrTpooiaaKKlC0/NGDEnmG95y8I11kgX0clJZ5hvlDyyJ9FNFWK9UNFqbcQ+EpeKAsrk1M=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id md18-20020a056214589200b0068c520c310esm3871181qvb.88.2024.02.01.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:26:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVapH-00An7W-DE;
	Thu, 01 Feb 2024 13:26:11 -0400
Date: Thu, 1 Feb 2024 13:26:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 09/17] iommu: Introduce iommu_group_mutex_assert()
Message-ID: <20240201172611.GJ50608@ziepe.ca>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125121135.8217-10-vasant.hegde@amd.com>

On Thu, Jan 25, 2024 at 12:11:27PM +0000, Vasant Hegde wrote:
> Add function to check iommu group mutex lock. So that device drivers can
> rely on group mutex lock instead of adding another driver level lock
> before modifying driver specific device data structure.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  include/linux/iommu.h |  8 ++++++++
>  2 files changed, 27 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +#if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
> +extern void iommu_group_mutex_assert(struct device *dev);

The extern is not necessary, there is a general shift away from using
it, not a reason for a v7, but FYI

Jason
