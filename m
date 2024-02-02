Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5D145B38
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887796; cv=none; b=n2bPjIxgOw4zRNOTpzEfn88jfEP7JCTROOx1gY0s9wx2AraVSe9BhBDuy3jSArIEdx83OB2wb6H6udrRGg3729wl3bImaGBfphtEjFqQ0E7k37GFBXLOIDmFgR8LsVj95T1FHchhPl0nSYVg5DlAbX2hfJ5io8xTYluaZ8Wftgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887796; c=relaxed/simple;
	bh=AYE5qndsQ0Ev8if+5BVPZ775ZGvXENXbdxtLVfJV9C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw+A0b30sYcEh1rZQYX74DQY6KxZvlhbgjEnfpPro6U16charVDejwvB8bs6VYqvgt73NHo4pjmmCIe4snEn+6QyjAK7Y65Dmq8qrqnke3YN23cXYHQw9/HpCo0g+l0ai8QQovS5y5IApIEyb3goc1sPHtXbqirfdWwSpha9VX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cm6Ky3SR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cm6Ky3SR"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783f27300b1so120074385a.1
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706887793; x=1707492593; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zQXCITWJjq+V83zxL+Kl/mgP7bWdYXeayzabvrQffU=;
        b=Cm6Ky3SRa3tqTMZKKRUS/UN8xjqaCGcmovFw1FTjfTTpk26y4yQRYEUsiwyK58sfuN
         V5LwN8WKD3AWkUIlcKFZ9BfV9RElUfP/fKuso4QkaJo28iCLf/xHR3Q0eeIEhZVpYm1r
         eSb+LlbdD5LUmT+ptYOVfH2RFFAmS7bEM6np7zI3pSLOmxKvRiCD82blLkSpolsT9ahs
         XpyW5O4mwx5TY2T1vINfMbm47nttgAL1i7rqktJjqxbZprBrFQUarsPV6Mib37beZffB
         UIH9C/rcEJwbXpttu2vKEXnFFiSVc5fk0P+wkpJr3oNspzJv3VgRUEfFygtWX9kHQB/p
         TsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887793; x=1707492593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zQXCITWJjq+V83zxL+Kl/mgP7bWdYXeayzabvrQffU=;
        b=PTo9ns4/qfbkw5RFQnrOCRmBmQcOW5L+Sie3fCNx4O+p+ODavAehqja7bqGr4cVZkh
         vTxCnjqdsPgLpXaMg6+fVrkA4vFqX9+DRBSxk7E8fy+0pywhTNPGnF8WowDCO2I6tbp7
         iEiRe85eQbjJb2etSDeHZx4/opr9jyi1GptaZh0ji9HUip3sRZeBwEoudozfU+MsoEXX
         AReAJBATPVN0jgeyXbHNZ2w8NRZngRZNL5qsvhV5tP0fUE+or6b7vHXkRFBtj3tVAFsp
         1xTtnjDQB1s+92CNO/4TwOvjTs7hek/Jgb86NcypcQIAPKBwl7ccsrb4/8/DuL2G6FPs
         xQjw==
X-Gm-Message-State: AOJu0YysafsDj3RSxgLE7SOfjJaiAEASB7aTyAIb3A2LJh5Er2fUk0up
	iBCPEQkN6zTz+tmEF8wY4up/ZRexVgkbctnFjnC5hsG5LsFYNy3gXda+aOXZfHLej4iXb7r3KWq
	e
X-Google-Smtp-Source: AGHT+IFUZTdeJrOF3gtpNjWZlAxL6BybHtSiygo6MqmX7eQ0tdlsdoALvyP8WFAHCgfynFgLPL5hjg==
X-Received: by 2002:a05:620a:4081:b0:785:5e0d:3ec6 with SMTP id f1-20020a05620a408100b007855e0d3ec6mr1063408qko.73.1706887793411;
        Fri, 02 Feb 2024 07:29:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUiYQX1CVj1CubYJVYedezBDC1Wo30degdvGBqhW0/LGgkx/sZDTVdUxeXUh4z7ObHmi6g9NLzlzpcsrN05OO6W+XeyTTiy4/7dpTESux0TpH1HZAf6b1grqXs+NeEyUNOZzPGk86HsG5twaNPIb3BXhZJAHdHFpY/LB167MyIzoXfBTrgxY80=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a080f00b00785559d1b46sm545660qks.6.2024.02.02.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:29:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvUG-00AwEH-Fu;
	Fri, 02 Feb 2024 11:29:52 -0400
Date: Fri, 2 Feb 2024 11:29:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 04/14] iommu/amd: Move PPR-related functions into ppr.c
Message-ID: <20240202152952.GX50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-5-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:29AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> In preparation to subsequent PPR-related patches, and also remove static
> declaration for certain helper functions so that it can be reused in other
> files.
> 
> Also rename below functions:
>   alloc_ppr_log        -> amd_iommu_alloc_ppr_log
>   iommu_enable_ppr_log -> amd_iommu_enable_ppr_log
>   free_ppr_log         -> amd_iommu_free_ppr_log
>   iommu_poll_ppr_log   -> amd_iommu_poll_ppr_log
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/Makefile    |   2 +-
>  drivers/iommu/amd/amd_iommu.h |  17 +++++-
>  drivers/iommu/amd/init.c      |  65 +++-----------------
>  drivers/iommu/amd/iommu.c     |  55 +----------------
>  drivers/iommu/amd/ppr.c       | 112 ++++++++++++++++++++++++++++++++++
>  5 files changed, 137 insertions(+), 114 deletions(-)
>  create mode 100644 drivers/iommu/amd/ppr.c

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
