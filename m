Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33C14E2E9
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788195; cv=none; b=MNVmwnzsK/pJp4ldylHhB6U782CwD70C2sivJAdGWX2SNYaZgj2FTzst3AIWjy6rSbLrziyB08AOdzhTxcRcIYQ0RfUmG+rnZ8cs47Vb3ycLRN/pcOuMyxiVSM8reBmsP6JIKeaLnYrvI+kY/MasfZJDWw7blpoLAx3eCHtwjes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788195; c=relaxed/simple;
	bh=fT+Bhjgp9vjGiECuUQwPkyEv/BsipRr4+reXgqzsDIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQTiafsFDjiLY98yer4YnmhSMqx1q2u97JAgk3HRPDcfrzCuJMnq8iF2tHUzZbvqbCeQWXoBvRUIoCDF5T2r+iTQCFoorj768BU+xoCjc85WHrm+oPIhRshdPJG9Gnrp3wWxqvxMgK+ZR/gtTtUVHqXL8fkrPKkqqDbOg6wTU6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y+PWhaxY; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y+PWhaxY"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0354459844so2003569276.3
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720788193; x=1721392993; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCLw51Ov+fzPQqS/+3p89aoPh13Gnr3eNhlUOT4KGkY=;
        b=Y+PWhaxYpfchB0gdnU4iPQ4m2Vy/tlssTkSKTPAkgtRWky1TGffKMMVmLjojsY89cE
         tDy3ZGg040hrZsnmrUpJhjagT90wpN7O4AqUnkNT7tQI373PH3mwuipSbLMIH09qiYWZ
         FvuZQis2zjN/wzrRxAGmIipmXFJOfNimcOMQiYEjmj3L3ytCdzqF5rJiQM2gP3w+V1UY
         XUt5yIPUSREljh7anacbNKMSDPt1HsQCXJUOj8qBAPEfNsRG8sz2iWB1MPaOHdD7tnwE
         Je0Nkv6JtsncVIwVoo7wUKq90jwjbtXxKu0cpgnkJXBzJ0Is/UYRQLY9hbFxZHCA6zlk
         9DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788193; x=1721392993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCLw51Ov+fzPQqS/+3p89aoPh13Gnr3eNhlUOT4KGkY=;
        b=Dcr0G2gG/arVf52G5mzGsUf4FLU7UWu3objUKQgXkGBWiVwCSJa0f4NAI5ucqa7IxS
         VAqJOGVDbO7uIPW/13+lEy75Ue1gwxwn4GKo2pxoZG/p+AeL+f0hjXM8a73GN8P+++6H
         hY0xLHqTqrB1Vm1X2IbbssxACkw67g3f1BhQjOo+gL20Xa91IuwVrh6nKQx9hwZS/XFR
         hxHFTt3e0sGjHzYDQ1+cGMUYiNGowEfovz6beGCRG06Z2FBVgw8xf8f1i3tXNSvk2Y7Q
         pZBAx9RtxZflE1IZ5Pxok4WUPA106u50XFD0h7VU0Hyluy4pj1hus7mT/nX/zojSd1gp
         E8pA==
X-Forwarded-Encrypted: i=1; AJvYcCWWkiOA6sdDQVkH3QH6YHGOQwG9+KbQAPzn4aA234pEAwgt8DvrIRWPLjvHKqeq0AsjXizumtLbyX/MzqVB9DgjLrY7pU4=
X-Gm-Message-State: AOJu0YzLlcsPh0Iq76rcMFQYJ6DVKM7SjBsEuzOLqEqKyToLTupi5lnx
	gRm+oBh5ikBNHhmbPg/zPmHS+s3GxSEIAD1sqqk48pVjvtil9w0WQu66gpkK/Os=
X-Google-Smtp-Source: AGHT+IEdvjEYH3YJfdXqM+Dc9L3bXQquOW4fau6cdS1Z+dA+ArZi7tFzhHqA4MvsKaCznd0OQ52Lgw==
X-Received: by 2002:a25:874f:0:b0:e03:60b4:1311 with SMTP id 3f1490d57ef6-e041b032e00mr10507728276.9.1720788192827;
        Fri, 12 Jul 2024 05:43:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26c9dsm40245411cf.14.2024.07.12.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 05:43:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFcF-000FbT-SJ;
	Fri, 12 Jul 2024 09:43:11 -0300
Date: Fri, 12 Jul 2024 09:43:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommufd: Add check on user response code
Message-ID: <20240712124311.GY14050@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-3-baolu.lu@linux.intel.com>
 <20240711233950.GU14050@ziepe.ca>
 <b4758476-6de2-4d3e-91b2-10599a37d00e@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4758476-6de2-4d3e-91b2-10599a37d00e@linux.intel.com>

On Fri, Jul 12, 2024 at 10:54:11AM +0800, Baolu Lu wrote:
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 29f522819759..a643d5c7c535 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -305,10 +305,10 @@ static ssize_t iommufd_fault_fops_write(struct file
> *filep, const char __user *b
>                 if (rc)
>                         break;
> 
> -               static_assert(IOMMUFD_PAGE_RESP_SUCCESS ==
> -                             IOMMU_PAGE_RESP_SUCCESS);
> -               static_assert(IOMMUFD_PAGE_RESP_INVALID ==
> -                             IOMMU_PAGE_RESP_INVALID);
> +               static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
> +                             (int)IOMMU_PAGE_RESP_SUCCESS);
> +               static_assert((int)IOMMUFD_PAGE_RESP_INVALID ==
> +                             (int)IOMMU_PAGE_RESP_INVALID);
>                 if (response.code != IOMMUFD_PAGE_RESP_SUCCESS &&
>                     response.code != IOMMUFD_PAGE_RESP_INVALID) {
>                         rc = -EINVAL;

Yep, my compiler doesn't warn on that apparently..

Jason
