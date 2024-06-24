Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA919D889
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245574; cv=none; b=MYDLDZ2B2OcP/pJS68L4aPMZQU411M7xIwingCrpW+4BFbw93fsECXJohH7WR2nZD0MgjaAfwE8rDYidfA4/87ufMXKRTwt4Mt01xyB9kAL3YmtQ6HBHggHMkwDmVzAlHGM3fHdKqLtaYlpD38ErmS0sLjQu6gilEbKg4qAKcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245574; c=relaxed/simple;
	bh=pG1yk7b6XhBcVzpKA4KQz9xCQgnJK5mEnEdrdNWSzC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et4WyqiNIsQJB8CVA4krbHuFwVfqlIxK9mqvUZ6FhABK5Q8wGWclTXTKQ5vd5OK2ZCiUuVpKVSbLOb7K9PxU/7GdnPAiPOshhDyXyTGX2QIVDK9+Ca3QCyjfwRn70TUi+NRewwOSNljzGcwhMF0mKyYHrFskP2DWfalV/81HkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ze/1W47w; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ze/1W47w"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b50c3aeb83so18104156d6.1
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719245572; x=1719850372; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KVh08w6ZHcJMoEyUgVFbZt4nC3NusyFRhTL7+nVKCM=;
        b=Ze/1W47wr6eOdVGouSeG/AtrAMcwO/XOGVjb7dsXVVf2A54Bxemyrdfae5aNFEuWCZ
         s10moqGNpFWm5+d7ZkkK3Il9/Fy8oR4g6w8Za+X51D5apaZ2o/8mbWTsoVxD7v1WvLhH
         B4UdxakVX3j6o7jmMviTRyaY83Y7QdmW11SVCBgKok/cH1UtfeG8I69VjhG3XiEhhTgh
         C8DHUd4aJiG2nS8q3O1/KysS1xut15RpLd+vvDFZB0FT9tOikU8TLt8Ep0Y/VA1npETw
         j03KlmwlsJi+aaLHyvTjCrQyfWuRwdwalXUtj/hmBz3ELKx2TsQsqTr4csciD6EQDP3Z
         EXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719245572; x=1719850372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KVh08w6ZHcJMoEyUgVFbZt4nC3NusyFRhTL7+nVKCM=;
        b=OGCqAhGz1T/dyJeXTHTvijeIIobi5qnemJZeqDG9JO6wmTbIdS9ap+Sc5lQY637yjM
         +sXbyUpQdsZKyFiGXnuTVM1udwlUP2vhz/QU9istdS2mJ5lp+Y08GvwrlOr9ZCgM5p7c
         YgpgBZz/1NJOovF+ZJLiDojAy8IbACK3J4LJYkc1REex97eqL8c64sUTF5mkox9/1iel
         I/8TVw9XRjGZjTBuW4tJc3ul/7Z3YoHarAkfNB4IrrpMvBK1CEGEBNSwkoL4XSteRXrf
         ryUQguh2EMfWO3TEvGz4t7vZVRDbgkr9QS1vbz8mXy5W2EgwTAjkzBtDE3DZtZ/9Ij84
         dZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoAaeO1Felb6JIbthdTDyiqNef71XRuMo/HTZRrVeoGKjBFvk6Q3UgrgSGZ8R3rVskEZ4DIM8liq/ndxIenxyUlfpw94o=
X-Gm-Message-State: AOJu0Yw5idEbzLP7TLEM0ta+T0lVe7Qt7XdB1y8hmGQDj2gLnYCb3DpT
	B+dQQAbmdLh0IvinXx9Lk2NCpNQZhcBFtSQfNTc64Z3FJEB7zvRdI8GDnewT7io=
X-Google-Smtp-Source: AGHT+IEtjMLppvm95Bhcr6Fo3t4bK3e43HafSl6y57NwQxCwuLvy186WvvSNAQulnuXL3iP6wdnezw==
X-Received: by 2002:ad4:4f42:0:b0:6b5:51c2:9808 with SMTP id 6a1803df08f44-6b551c299e1mr33223666d6.26.1719245572248;
        Mon, 24 Jun 2024 09:12:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef5c330sm35415686d6.118.2024.06.24.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:12:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sLmJH-006FXA-6y;
	Mon, 24 Jun 2024 13:12:51 -0300
Date: Mon, 24 Jun 2024 13:12:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <20240624161251.GS791043@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
 <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
 <657c7e03-91ef-4765-be7c-1f57eb45e467@amd.com>
 <20240620140815.GO791043@ziepe.ca>
 <92033ab6-fb55-4206-9cb9-f81b5b6eede6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92033ab6-fb55-4206-9cb9-f81b5b6eede6@amd.com>

On Mon, Jun 24, 2024 at 07:56:03PM +0530, Vasant Hegde wrote:

> >> I remember of this discussion. May be we can provide API from IOMMU driver so
> >> that individual driver can enable/disable ATS (like iommu_dev_enable_feature()).
> > 
> > But I have a feeling if we do that it should be done by re-attaching
> > the domain.
> 
> Right. By default IOMMU will enable the ATS.. But if device driver decides to
> disable it (say due to HW bug), then we have to re-attach domain (in AMD case we
> have to update the DTE and flush the TLB).

SMMUv3 is the same, this is why I like doing it via the existing
re-attach domain interface since it already composes nicely with the
mechanisms the driver should have to update the DTE/etc.

> > Having an additional input to domain attach "inhibit ats", as a flag
> > would be all the support the driver would need to provide for the core
> > code to manage this with some kind of global policy.
> 
> You mean for attach_dev() ?

Yes
 
> .. and what about PRI and PASID? Don't device driver needs similar interface ?

PRI is enabled by attaching a PRI capable domain

PASID should be assumed to be required if the device supports PASID.

Inhibiting PASID support would have to be done during domain
allocation. Soon the dev will always be available there and we could
do a policy like that via the dev structs? Not sure how much value
there is..

Jason
