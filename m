Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10A1514D3
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264874; cv=none; b=Mcu+cG0w7Ei9UXDbF2eXI3WyI7eVPrGS0ZCSaQ+Ep3IkKnWiCpMeapf9He9wCLwk9IXcyKreZJ6nzXirZ4fl+aYeHdNZL7qZpczwdlNAYveotVhGK/p8BWzxBVP4jAxwo2ykFJla8BeuYnkVL/9BQ3APWmIpJBK7CLmTX/1nmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264874; c=relaxed/simple;
	bh=1uhfhafS4VV4PHgoUQ5TuHqPZNqpK2JZEVOjHwXCYO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muuFRUh+lWeJd73CW85OMstAQrwjtzuniuDlQBnc7CM+ZADZ4nYuIu2eSEze8gdfWzam4M/nJWcYNqeHHyp2EJmL5vo7qIx4iROBtE83x8D6v4Qg5PbZrh31hIPuichudoP6yIvRbS0lZi0CxYnKC5GYhEbHklx+CS7KjW4yOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bsr26b+8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bsr26b+8"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a0ff97a9c7so15586746d6.0
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715264872; x=1715869672; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4S6reri4cKofwFkAd+jT6QPIjidYk8ttTypd2kM9f8=;
        b=bsr26b+833h1TWlo6c0nfzZWeXrgQ89bi9qj54CHUSfiX90Q6UWu8XwlvG1Pgsapk1
         wqNp0oG7tUnHatN5kPs9WyyCpZIK8VycJvhF6GkQtPaVOoaFARXILOZGl6bh4hN3KEoN
         5jl+zjAw/cpZy0vTwQIgjuibyIdtBbTtOPJgYhj9hK+A0j1z02gFshJGUx1KgKiXenq4
         cHyn61IqEK2DRacLUldKB5BDr9N/Q0ryzH9GB96m9aWibc7/kVQVGo7VaJRTBrUO4V9a
         eSk4hFACyPlkmwboa7paxVrALJ2RS9OFhGQ6UXtLuAZHAjIyeptkahy5HV8a6fmpo9Mp
         qJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264872; x=1715869672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4S6reri4cKofwFkAd+jT6QPIjidYk8ttTypd2kM9f8=;
        b=MGv2AYUIP2kOplicIvtV9m2whTewG9iwCXJ8V2ypw0ma5z22jqlz4iPFUz5aOTBU/1
         zZa1UmzkxY5IPy8/o5k8t/hR+BVp9rjStEeXaRgpQYmXHeeFA5Cayc6Bf8Yj2EcjjEKh
         qqWCW5zCyaXvX/x3ReyjDTZCRYGhd3l9/W/1/LrchcUEF3zkKf4ulVp50TNQ6Lq3v4TX
         Ou+jkxnaO6YDjhEOXZ9MhDq02dl2sB98IDTJecDblvc3Jz6burhNfOy9t3uliJwUw+8E
         Z7Omf80knd2s/WOPhpBsRjwucN8XXZf72KXEO89xLAcoKPA4AWe9rzSDMc9g+4KEKv2+
         4PGQ==
X-Forwarded-Encrypted: i=1; AJvYcCURhgzTUUDCSvq0Awjs4NzJH2jR9AFZDnFOxBYhvv20Vxx1UVp7W9fEEDGYJYHdE85l7JhV/7rbTURtY6xTsqIzZ5NAyyg=
X-Gm-Message-State: AOJu0YzqCOOoIZBjXVKhTIzneNPCIEKeME8XqDIeI06RjqKNZJTrvG1V
	VKrulGd77jqUSPLwwTR0kOkMdAApcYVR7/wcY35F7wNvtiZnod6+NywyDPCTkXc=
X-Google-Smtp-Source: AGHT+IHRAhh8tN9+EXuub2af5CR+HcDFKY8azEps8iXW3JQRPsiXf15qVWgu8qQM1DMkblJTYCrgJQ==
X-Received: by 2002:a05:6214:5299:b0:6a0:c123:8a78 with SMTP id 6a1803df08f44-6a15cbbdecemr53529646d6.6.1715264871839;
        Thu, 09 May 2024 07:27:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f195018sm7556076d6.74.2024.05.09.07.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:27:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s54kQ-004VPm-Kb;
	Thu, 09 May 2024 11:27:50 -0300
Date: Thu, 9 May 2024 11:27:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v1 1/1] iommu/arm-smmu-v3: Use *-y instead of *-objs in
 Makefile
Message-ID: <20240509142750.GT4718@ziepe.ca>
References: <20240508151611.1444352-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508151611.1444352-1-andriy.shevchenko@linux.intel.com>

On Wed, May 08, 2024 at 06:15:55PM +0300, Andy Shevchenko wrote:
> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Note, the original approach is weirdest from the existing.
> Only a few drivers use this (-objs-y) one most likely by mistake.
> 
>  drivers/iommu/arm/arm-smmu-v3/Makefile | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
