Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1912F585
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130034; cv=none; b=mCFexrteXVkMJTUqlaVUkPTo6BUgySqyfVBx+bocxgzqPusMjfYghGV2zr6teuggSES0/nhCCUCslA60hoaY298z9sd/cHmfCrigJ64Lp4HTX3HHo9Q3ye8PQSRMaDhuJxcqEmoZmpi4GucqKxwT5JRbCMCj53K0bP9mp2zaZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130034; c=relaxed/simple;
	bh=bkVuqY0ONT2oDYiG4yHMJ5jwtf5QwPCEBUNNTyTV3Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8w2CSXcYAWnJLDGAuqjByZtNtysnsbJRNfF2swnzvkaRryAPRyYeF8Llycc/t9DouFZmp+Kb0ABlUrHm7Y5d7mF0CKp8zDMVYIZmN0xiD9z4f7fRG7Yq0HB2RN/FB1/G+wVshyXHLpNO1WaTD2TWy+lQvDJ+X8a6+gaY0zFNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NSRKzw5C; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NSRKzw5C"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso44984016d6.1
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730130031; x=1730734831; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTo2XCvzBG4PjzD+SP6/4tj2F3CS5bOZP7jpl1BOZIA=;
        b=NSRKzw5CUFmhx3A83QC0c80bneQ8d3UShWx+Xl405KsHusIOWDZ0CC97M05rUxlt/z
         3lpGCSOr2Ie9DyvDD3MDtggrhvxkmr4UdldVtiGKJ29diVRDp4QkYUPWov2c23xBdOVt
         8SBdgg54BTvbQcOjaBbmR9363SAbUtlKyiphRzGwDxaNKwTln3g8a3Cm61D8LkS70toy
         /xI0XGXu/3cg6pQ+T3J5W6DbJVhGny8LMy99UlVZdaa0vWSEAC+maT3ojRBTk+d8uUqU
         8SlPgApMyVYR9PZvnh/tt5QxgZ1ZPnM6PB0mjaV4v7rIrrTwd6Y5GeAHMBw3mhy7df3G
         SXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130031; x=1730734831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTo2XCvzBG4PjzD+SP6/4tj2F3CS5bOZP7jpl1BOZIA=;
        b=i4ROYyj/5z88aTSvnhJFt9T2tWd62H4+UfagiAceL27viCfRCXQoUPY2+bT/6aj9dj
         kcweOwzFlQt75vvYJ7pNUvWeX3o10+ujvG1djfJUDU4Y80eXXvdYJ7Y7LkyE/Jt55TGR
         /o+kBVdKZZLF86CafgkhJunjB0UOs7nuLsoSoUzC116iHaUC/NQT+2A+vweHZg/kwcDm
         9aazRcyiUEwmgIc+1XVMY4BBRPO4bqUQEzyeYrC/E4PhY9GgSJqMT6J9DXCenRFLsmQv
         8blZPvke5zx34Y233yD6FofNOIuUFFDtxhkJcG9QchGseRXW+RCis9q4xdjpBTEhQ8Tn
         I9ow==
X-Gm-Message-State: AOJu0YxOVB8aNb4bZ7E3jr1lcPLIFW5NMTEXgFbBy0zER3AnwGNYmfuP
	G/PmBnOyJ9P1/9XrzP5RBJL8uUMcE7afCcQDam2kWlTDVlhlNRhYo0GxamZoiIo=
X-Google-Smtp-Source: AGHT+IGB0puOfGBlZXbicw/CYwklW92HvRAlyWls9hx/r5zlmvv7tbuDNFacWNlGmJQHdPqupf4qTA==
X-Received: by 2002:a05:6214:2f0a:b0:6cb:cc30:1b0a with SMTP id 6a1803df08f44-6d19ed276b5mr513046d6.14.1730130031133;
        Mon, 28 Oct 2024 08:40:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a0c398sm33399166d6.82.2024.10.28.08.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:40:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5Rr3-00000000Qrd-3LmA;
	Mon, 28 Oct 2024 12:40:29 -0300
Date: Mon, 28 Oct 2024 12:40:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v4 12/12] iommu/amd: Improve amd_iommu_release_device()
Message-ID: <20241028154029.GG20281@ziepe.ca>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
 <20241028113148.5774-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028113148.5774-13-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 11:31:48AM +0000, Vasant Hegde wrote:
> Previous patch added ops->release_domain support. Core will attach
> devices to release_domain->attach_dev() before calling this function.
> Devices are already detached their current domain and attached to
> blocked domain.
> 
> This is mostly dummy function now. Just throw warning if device is still
> attached to domain.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 33 ++++++---------------------------
>  1 file changed, 6 insertions(+), 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
