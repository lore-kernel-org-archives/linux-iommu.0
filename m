Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B971DE2C6
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172363; cv=none; b=SVx6TpHn7UBb9IH+H7WEo1DlKMZAzCwn0517XleJl4ibF5ARQAlKMlgrD7yugdhEWLAGeztNuktmao8Y86UG1andX/q0GxQdkFNJ9VPJRrrU7sROqfGR78/IbARAF1GmL6adCcMHAejbD5f0KXOgbBBak2bbHcvlnycfNjiE7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172363; c=relaxed/simple;
	bh=i49EmUAf1ohGxeeM8x4UmNwfL4yCIxHLWgWUOM/iP9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cca+LkOzCtcN4XAYJj2Pt1iTSXaLDl8Ndw7al6bP3gVpHytszYplG89JZpXCET4SLIuXy7wyzy9/Dhj6J88pxnbJdzS6ElIugeulLlSemVQip/BllH8/Cg5NqdjKrPMGGAr8BKNOA5oOG+ELtYdXZ6V+2mRCiBcwv070oGFlkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GhXN4aUq; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GhXN4aUq"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so6685036d6.2
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729172360; x=1729777160; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFOPvFmUvMrcCCI6GWnkGToXsm7aD34183MCg5+ujP0=;
        b=GhXN4aUq2OGQHK6bQudk1EfD8yyvy1XQQvVTd2sU4HHUEdA3ofwY4TdwPqaJ1ot+9y
         H59aOWIKvalHBFdvY2b3S3Fyx1c6+zJnhxdVXnX3g5UOBwTjK2L1GI0f7L7svwMDLf4S
         dg8qnXklyVRFNWJB3oU9A4P0EQozDdzB+3OzwFm+YCCrirzWviE8GUcv2KXEJjE54G4J
         303d7m/TYpf0HpEwZlPtK8LqJgD3ZwhnJSBnMAHOpxh8RjIwgfmPYNGb2GBw/9CcuZD7
         DBI+7E/F6O2KnS1qceTvUOA/wwVEhO6cnnu0oZZxFj88WDOrRraJJEr0TZBZFijswDPR
         PowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172360; x=1729777160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFOPvFmUvMrcCCI6GWnkGToXsm7aD34183MCg5+ujP0=;
        b=YdFGlgszl19YohtuYL35i+Odie37ACdndN49N6fzAGTff6FkjSdQE+hsVOTt5NVP32
         myAP5khCAxgxGdvOJ8YOhTnS7bGkwXizTe6iXfMOND1c5eLmNnrJnsEqe8Qo4PBYxit6
         gdLvbGVqhOxcJtUY1mOMwFoTTGyu3sBPB7CGAoxJN/UU4gNjuNelIAy8KzzPlcsgwqcb
         qwfXAmR7BMgfzKuHyVyNVMsSVAy1QEoaEQTOj/vupR6O1bhWd3dwtr3+CXDmsD18U48b
         4XLvFcZWJyeSB7Tug2IzM/DRq8BBE7MFcehUs/bH6ENaT7y/J2D5R7EcdhmVm7vRSjos
         +ITw==
X-Gm-Message-State: AOJu0Ywjrymxv+EDIQuRfN3l9ycjtK5AHyjb+G8zrlxIsNj6RB5eOstT
	4oxs1v9I8HHFsZnkslY0aJtLqycnk/Mo5aZcqXTNfhAy0vZZ/WzkmFzm1sd99aA=
X-Google-Smtp-Source: AGHT+IHjh9e9U1k0tJPEjpgr9pc1r/E2HwavXr3BlfA27vfUlw65IMjMHBFK984S7YH0V1eD8gMSNg==
X-Received: by 2002:a0c:e84f:0:b0:6cc:2c76:d2e4 with SMTP id 6a1803df08f44-6cc2c76d316mr69232956d6.53.1729172359542;
        Thu, 17 Oct 2024 06:39:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2291dbd5sm28380436d6.50.2024.10.17.06.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:39:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1Qik-003yqY-LN;
	Thu, 17 Oct 2024 10:39:18 -0300
Date: Thu, 17 Oct 2024 10:39:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 10/10] iommu/amd: Improve amd_iommu_release_device()
Message-ID: <20241017133918.GT4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-11-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:35:01AM +0000, Vasant Hegde wrote:

> @@ -2251,7 +2234,18 @@ static void amd_iommu_release_device(struct device *dev)
>  	if (!iommu)
>  		return;
>  
> -	amd_iommu_uninit_device(dev);
> +	dev_data = dev_iommu_priv_get(dev);
> +	if (!dev_data)
> +		return;

This can never happen, the core code never calls an op unless
probe_device succeeded.

> +	if (dev_data->domain)
> +		detach_device(dev);

This is also can't happen. The driver sets release_domain then the
core code never calls this with anything other than release_domain
attached.

Suggest just 

 struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);

 WARN_ON(dev->data->domain);

> +	/*
> +	 * We keep dev_data around for unplugged devices and reuse it when the
> +	 * device is re-plugged - not doing so would introduce a ton of races.
> +	 */
> +

Yikes.. Sounds sketchy. Why doesn't any other driver have these races?

Jason
