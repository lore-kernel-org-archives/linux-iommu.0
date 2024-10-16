Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2820514C
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079216; cv=none; b=pxnIY7EkpzP2Lbjz6H9QobgRq8aMD5bun7fbPGDENe+zyYsvLgNhMcwxDymDTzljD423HT4dvpRLMXPPrdierKIymj3UsIl+jh1Z9NrS2MeGzvQ5wWMeYtN20ItwqMqgPpCzCtzKxQKynz4Id6+NcfxPME0ICKc47KPudVwYLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079216; c=relaxed/simple;
	bh=tM2SMPt6Yj6sQtwcrTf9hY8Bpxwaw/5cOiRFOWwjObM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9Za+vKOf3tWXf1wAXsQb0Jwr9q5dQx5NIZ2xdYvze/ZHAN9NZ19C6ja+U6kmZYLxiHhyh5xSLuGXmDuhsmZ9X7GFxnADDtB4fkcyeafXzpAc8H/JWPTiIUoN3YYIMAwihGSg9XkC2xhg/lwtM/02UScNpLj8pIE9d19q9iwH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jX6TVwJ/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jX6TVwJ/"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46097806aaeso925071cf.2
        for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729079213; x=1729684013; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRpY07cD6l8JGz91R8wxx6R5AMb98e3lBYr39jEEBcA=;
        b=jX6TVwJ/tLE7MncrW3lYS5ZisoiBf0e9sXTUZ8WoHF0QEbXA/d+saSfJq834HBhig+
         vu+hWJZSKT84oTQftVOgkg7V4zRimQdPKfLS3F5DRmIWvgRh00EH40GU/8s0xK2FLdAX
         5nJFuRDLMUX8lvkVRsO9NnQTYS/dBVvV6rdJk8yL4WLQNdszYM3fFCnO1MWb3RaDa9j0
         i4loWvMmUhQ2wkzaGAiqH4hi+BowrBQwlk9UB2CEKaZv9dmf101ESGSBxxSqLviM+mz2
         cRBqkzap/w9B9ncFHIwg+YVCorhQDmNvI+fqkgFnFz8WoDfCEF3j5NcwPFO+G5Tc4FQ6
         OkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079213; x=1729684013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRpY07cD6l8JGz91R8wxx6R5AMb98e3lBYr39jEEBcA=;
        b=r3mcIMwRqdxFPL1Z9cgSa/mlKUcDPvNovGMhHAwOzlZJjMlifzUgODoy6NCIECHfSb
         56XZK/w5jpoNFUq4tBCPkQk3GH2lGK20nMqLSm/OdQeXm+t9/rt49MY0pjZmb3WnUh0+
         AT3joLfYL8FqquT6j+954Ge16/o2aVrsmJnLLmy276BJqaT6SfzfaawNEfkempCsFoQw
         72lwW4/i/myH8nAshnk2EPEO+KMbSqZVgxT5yN9NS7o/jB7gpss90btJSziBDVLsGLFx
         SbRGin/QsGBusW3fdKaZg79lsUFOnQ/zQT+9sN+jTHynmMAtPY8lcvybKtDaZatnGnOn
         Xj7Q==
X-Gm-Message-State: AOJu0YzAu11KBiDj+re6hTwRR/08Du4X9pjl0lfhLOQNfsP4Qtpaf+mw
	PA6lspNsa7oGrGsHXVi1eaDN+R1uPfEoXgaycViElPxCrjZpcujTTr5isk2zhxY=
X-Google-Smtp-Source: AGHT+IEgAzmZjac+mKwqU2HLUKVJIQSL/0jyFJdqV4Q/u+V4kSolmvzDqBF5IpnDg20HbHZAtoHaXw==
X-Received: by 2002:a05:622a:199c:b0:45c:a9fa:dbbc with SMTP id d75a77b69052e-4605842278fmr222695791cf.26.1729079213170;
        Wed, 16 Oct 2024 04:46:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b378b1csm16351631cf.75.2024.10.16.04.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:46:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t12UN-00Gxb0-5D;
	Wed, 16 Oct 2024 08:46:51 -0300
Date: Wed, 16 Oct 2024 08:46:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu: Add support to change domain to blocked domain
 via sysfs
Message-ID: <20241016114651.GA4020792@ziepe.ca>
References: <20240722115553.6005-1-vasant.hegde@amd.com>
 <20240723130507.GK14050@ziepe.ca>
 <e7a6ce53-c473-44d0-9177-b7dafa5c6aa5@amd.com>
 <20240723164448.GM14050@ziepe.ca>
 <110c57d1-1a84-44e6-bf71-ab5cbae12120@amd.com>
 <20240723173228.GN14050@ziepe.ca>
 <dda7c011-d427-48b6-8a1e-7a011f23ed77@amd.com>
 <c98245b4-4c51-4791-8808-673ef7b9c2f5@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98245b4-4c51-4791-8808-673ef7b9c2f5@amd.com>

On Wed, Oct 16, 2024 at 02:26:12PM +0530, Vasant Hegde wrote:
> > I'd expect someone changing domain via sysfs knows what he is doing. Hence I
> > thought its fine to add blocked domain support.
> 
> Can we get this merged?
> 
> Currently other than this patch we don't have any way to force devices to
> attached to blocked domain. So testing BLOCKED domain and confirming we didn't
> break anything becomes difficult.

You can open vfio and get a blocked domain?

I not sure we should merge this, it is confusing to end users to put
the device into a non-functional state..

> I have been carrying this as out of tree patch. I apply this patch and run my
> tests . But its nice if we can get this patch in upstream.

Write your test with VFIO instead?

Joel has a NVMe VFIO driver, and rdma-core has a mlx4 vfio driver, I
think it would be easy enough to make those generate blocked
transfers??

Jason
