Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563835EF2
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T9QQQt9s"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67f85fe5632so6635306d6.0
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704481446; x=1705086246; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHQ2/3Tsj0fssUdaF2F1fo7AG4tUGaP4CTo+F1WK0mA=;
        b=T9QQQt9s8xARAepZaQV0OcCjzB8OSJ/+mICaJt1B7BRCHe4YskKibyJ4sXZLVO4SXJ
         zgZuqWsPJbAqt9Fhw5H+uB8r0AyydoeWdt5UciBUvQvtjhGf7bBwqkRzqvzq5UfDA7rm
         YSjq8RKy5zyXziT5AKxzEd7Bifg8EEiQwX6YAXTGhXJhN3hks9Xs7LQG45BJiUUyCgSQ
         t1ltrFOYLSym+svLYgkqSvJngDq6CC87x8IUqW9YQ1QiejDzfGNqJcn7ihpNdsldtLZp
         s93n7myy9QOHLc5TkxzeTDyyNo88fuchQTQXTzObbIcxC9jDt2yLwEyBMZrvZIXXe+OK
         tM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704481446; x=1705086246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHQ2/3Tsj0fssUdaF2F1fo7AG4tUGaP4CTo+F1WK0mA=;
        b=LlttgDCj3cUIBd7e7eqgfNPGIIpgtKbFmv2qTc1BKyD9FUC4ihetL7a83kamd3gmln
         d+9AwJ4GscXSCLvVJQwGQXyAJdYNDIYVKuDXvH/Gmp9HciDVam/2rOPEReOngTZyG9Sa
         Sh2VFjWh9Esr6Feul2Q26pyhVmdd+ep8zNemGld+5FDoAygVowgpMG/Oax85hEmQb8ZQ
         ZXu0qFEblB77oMFwx7XX2sUxWcgrQ6lBTPvM1184K9deiJ/xeXKcxAYKmXXNa+8lG8go
         HKoSgG3uxe58JygRjw4A44Ga23JNTvaZ09NOKgquoFEjyz4uF9N/VVsYdwDIlfRotI8P
         +ERg==
X-Gm-Message-State: AOJu0Yz8PeVj16t8c0ET6vcMKLNmp6a3EMn+tJ/GXs+qVoCqJcv6eEbL
	hDaWkCrZ8L79VVG1cgAPE405TDJkjb05/A==
X-Google-Smtp-Source: AGHT+IEjIBIq0FXsC9SYtw11aaaT356IJk18Q/rqDDp01TJKge9mEApfluep7ndlIX3qFXw88ALDkg==
X-Received: by 2002:a05:6214:401c:b0:680:d1cf:4437 with SMTP id kd28-20020a056214401c00b00680d1cf4437mr3526698qvb.65.1704481446370;
        Fri, 05 Jan 2024 11:04:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id kc22-20020a056214411600b00680b461ec99sm804809qvb.109.2024.01.05.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:04:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLpUD-001VX6-DW;
	Fri, 05 Jan 2024 15:04:05 -0400
Date: Fri, 5 Jan 2024 15:04:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 09/16] iommu/amd: Rearrange GCR3 table setup code
Message-ID: <20240105190405.GO50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-10-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:17AM +0000, Vasant Hegde wrote:
> Consolidate GCR3 table related code in one place so that its easy
> to maintain.
> 
> Note that this patch doesn't move __set_gcr3/__clear_gcr3. We are moving
> GCR3 table from per domain to per device. Following series will rework
> these functions. During that time I will move these functions as well.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 64 +++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Usual comment about doing code motion without a good reason..

Jason
