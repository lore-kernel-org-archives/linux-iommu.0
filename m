Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A915357A
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974689; cv=none; b=bE0S+QzilMgVVpbdmzd08WAbNn4H4kiB8qIhBKUJu9SE88XhvPhck/1cOF07LErQ0quqnbEh9rG5DIPSbnjwJfo9IMJCkmv4EgildGHDX3VVZS3sIDa4gpiFaIY92LNKCwmBCinZaVjaMsGCMrw3avoQxkLDOqF/LuLqBIX4/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974689; c=relaxed/simple;
	bh=XkE2aXGQ3OEWHgZBCTmUVRQboZ6XByanLbqpezLnWfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV+FwtfHcIuOUbjfIsjFWICEh/P8FxzABp48cY3tMLk3GjvVPrWORapdexWqzxA/WVY1rnddkWsZoWrx2ILT2ZjhGk7+kr4OqF2vSo/M/xpI6zyhQGXILXyYpEWMWBkvh4AcafvHmy406AFhGLlkanh8F3qOzifoCQ5qvdCpasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hdFrm2g1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hdFrm2g1"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7955aaf8006so141453285a.1
        for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718974686; x=1719579486; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkE2aXGQ3OEWHgZBCTmUVRQboZ6XByanLbqpezLnWfI=;
        b=hdFrm2g1qnwx7b1fpq6fO4v008NnzsUt3M21BCyYs/2TgHwmmud7AvzUdZOxGywmY5
         4LvOWWhIH5edFeelSywawXNI4paBuF00VB6t86nYv+20Ks/OMm6GjMSM0N4XF5+U9e6U
         k1HTFz1bYoDZhv0kzcP3Ydqf4CMo4lG3ayWiT0mNp4alJRTqwECf4h5b8kXYoejXVUkV
         Q7S2gi+t6fBpaFoUM2UXV5l1ogb6omdrivsiU3jcSZQ36a/iqrPhfu1L3wZUg4wZnfM0
         SNntLwMzYcg63qkWMxfU9c7ZOhFmwJGcNUlCWwfJ0zEsjQT1gJS3n+4N72kPbgvW8bQf
         nAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974686; x=1719579486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkE2aXGQ3OEWHgZBCTmUVRQboZ6XByanLbqpezLnWfI=;
        b=Cvv+stpM8LukujsSmCk/vTjO83nI+2HYm9PbqhZ/vSM9QRwkJvaC/LI+/fuoLS0+Cl
         sSIPGyqz5EZwRa80rrvIWexMxQ3fB1N3DFxrGUdp0EXAEou33IhUxBOURMCLvC28VC9k
         Wzya2lZ0tOrMUpJw9qTfi1e3Idpa7MS7iSyP4/V5eiX5pDUtgs9NEPUK90IZrXOOB0eM
         OsiARzMGdSyUqX5Pun7d5iMa6cP77cSrKLw0/6V1pahqxQFEHWap6selHPox31bd8PQd
         Up8MHMVZbh0AnC4kLbsWprn0am8feMrVX/ftPIJMsFQ1qV4NR33sWDuYSRBtadscH1TG
         Dzfw==
X-Forwarded-Encrypted: i=1; AJvYcCUB+5VlZp/ucyVD8kxVlp1OqCzNkKZJrGk4bYygxbTE+UsqZF0ark8FSCf3fTQ6TZl3zHN8Lz9lHibMChPvWFHPyIhlXuY=
X-Gm-Message-State: AOJu0Yy9Rz+RVYUa6Ocr2HAGNM5mGCqstXzbkQb3uLvWVP8H6ycjZNb+
	CNFFIPlpB2BLO0RYaPTKhe+Qg0UamTKmcL5YdR5zQGQqQ5IBdI7LaUQI5AfRdZY=
X-Google-Smtp-Source: AGHT+IG9jNeBtKv51T5M28R8MsVDZfSjCHGL8xN8o3mydLDx3b7W4tWjsJeePqsv7hRJTtyXM00cbQ==
X-Received: by 2002:a05:620a:28d1:b0:795:758d:fba4 with SMTP id af79cd13be357-79bb3e5b960mr913512085a.46.1718974686404;
        Fri, 21 Jun 2024 05:58:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89a3b1sm84602985a.26.2024.06.21.05.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:58:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sKdq8-00HS0b-Rq;
	Fri, 21 Jun 2024 09:58:04 -0300
Date: Fri, 21 Jun 2024 09:58:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <20240621125804.GP791043@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
 <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
 <657c7e03-91ef-4765-be7c-1f57eb45e467@amd.com>
 <20240620140815.GO791043@ziepe.ca>
 <3d709185-2065-4cb8-9d69-a7a34edd249e@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d709185-2065-4cb8-9d69-a7a34edd249e@linux.intel.com>

On Fri, Jun 21, 2024 at 09:44:27AM +0800, Baolu Lu wrote:

> Enabling/Disabling ATS on domain attach seems like a feasible approach.
> The ATS requirement information (required/disallowed/neutral) could be
> included as an opt-in option in the domain attach path. This likely
> applies to PASID attachments and VF/PF devices. The iommu driver
> maintains the per-device ATS refcount and enables it for the first
> request and disables it after the last one. The attachment fails
> accordingly if the hardware capability doesn't match the domain attach
> requirement.

Yes. if we do this the core code would have to take some
responsibility to manage ATS and PASID needs together. It is a bit
tricky potentially, but probably better than having drivers repeat the
same logic.

But it probably does require the drivers actually implement hitless
replace. I'd imagin a core driven flow is something like:

 - Install an identity domain without ATS
 - Decide we want a SVA pasid
 - Replace the identiy domain with the same identity domain and ATS
 - Install the SVA pasid

(assuming we want some policy like only enable ATS when needed)

> Perhaps we could further include PRI as a domain attach option,
> indicating that the domain requires IOPF functionality. This would allow
> us to simplify the SVA and IOMMUFD by hiding device and IOMMU details
> within the IOMMU driver.

This is my desire, if the domain has a fault handler then the driver
should just make PRI work on attach or fail attach.

None of the weird feature stuff is needed. We are getting closer, I
think the SVA enable stuff is almost all NO-OP'd.

Jason
