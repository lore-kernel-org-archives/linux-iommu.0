Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072A43F091
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392139; cv=none; b=M/W9DyYk5dp6yzD6ka+F8HXyDsbWZMcbbpCj8IDFIO+6WhlJta0MA5eGXV0BHOs+zMi/E1eZR250S63CVZTAA4ELWgM9Vb8V5CztU8TZNO4faHKQq+xcDRd4j9/EnHtr7dbHIngQm6LaFcqmh8pemATdTIBrTq2QSgtQ1e9l2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392139; c=relaxed/simple;
	bh=+9vkNVNvPzcxlfQfdghfV+XHMT4tY8VrvFMNsqBQXUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf2JYrAd4PpkzhgdDstUR+kKHgc7zX5Cjgqan63OTfWbcXyZIqCAgWqkU/8BYgrvysAvy6f50oYCxlSxdkGY7xilsSdvbuwn+MdDd/6BmDKvXw2ThfzYiYCMdTsH7Z1fThkUAb1iIFOoLK7JgtK27AlHxErICjMqVAypLQWBHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J8QtaaPe; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J8QtaaPe"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0cea8883so2864111cf.1
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786392136; x=1786996936; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4+rLRCu6gZDlUjtqIIOCBd9IdZYPdWeKZsJ7JGferjg=;
        b=J8QtaaPel21mC82lAPkEt7DdTFaVGiavI61Cso2qFagwUwxMzy+fxjn0y0IdxVR4aq
         dk7zxto/EIu8foaWTyLlVghgb1xYnBtl3rhr4q75YHSqQXiETL3cPVQjiB0b7N4tJFLK
         8q+5T0ssJMkqi+p97frFwcm24Rq+4rdQfP/u/f8JwTXgpJwDAce0fzVLjU2eeyYVqE9r
         dcggKveJg9edosj2p8Mes4maivet2Z01sGPg8H1kqbIBcaZwFNnMlfR8K9nDsGbw84XK
         hrSos9ouCYV43Zrf15z3M+sBfGdObrh+SxnrG4RZg99mbMprXuy4GyjLVSubiKxZ+ow1
         jSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786392136; x=1786996936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4+rLRCu6gZDlUjtqIIOCBd9IdZYPdWeKZsJ7JGferjg=;
        b=jqlYJAjqslfEBK1ChtLVVE9n11Y4EiBovZx409PhuvOit3nI11mB2SDs0botCljPQT
         6ufkALkI3O6FP8WyPirTMAlKPHhxhKkHJ8wEn66TE8Kobh/g6zFrwyOUcQIdtWxB6Aif
         /xVbIqluuBrYTSMVbyPVW1W4PSAfLI6fBAjkPnlx/4L0zY1kTOMi4Z1sHTQ5y+WF0HhK
         3pOz2W1nHy35HeZ2EEpr9QYG9Qe4V8eGK+rdI28Jn2oq9r5Fq9tIXNNssglEwFmsSM60
         OJ8RoLrSJQoor3gU1aEy02T/1LtYJ3CxdiqmA7Ztm0AfXd5Hh2HNzlWV9tGHglWoUWuh
         +L4g==
X-Forwarded-Encrypted: i=1; AHgh+RoGcQ4n+z1za/yk3lnljTrEZJF6N+iVbiYLcNJIXJE0C4xnytFOIJKf3Wj9I6aENLtKQ3tmnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyENeGaTI9T3HTW70pLPRNZnO/uBT526HpQ/ZtaJsgkTLvQwf7c
	rCXKqt7jB/JJWW8sKltbaOW+w/vPZybBV2jY+MD6Jfvo+K48a9/qjjPj9DJtJay7uhM=
X-Gm-Gg: AR+sD10oH3nTUkmRzLoj7wUId9R+mjkkx9Kl8ZG6bR06+wgGFHlBnscOplXiNar+epy
	RsWXWm0Tc6tRf/WGwzyQYa3CsOQUXX/R+q24H1YJlWFjGUxOI4kbvwzNsyMijvt5GFbd95U+j6f
	uNw32eFCcBOL2AlE9TBcu8wA/gsfYAQrn3l03guPAYXcCsthJIrcK2JsdIfuZMxkKRp2fDNgcqM
	lL3xBHu3NINXgu6fxlCK4BioqkgxkwPAKB0k8i/hF/UdBRwRGdVjJtTyA/p0vbRpW/Olax36YQx
	lpe2+u0iIFN155uNpT9hRb705f4Zfs56F3QvOqg+UgUWh+VpRVr815JDO1/fjqj3x4FYIZ725MA
	dtRnNySVor6PU2MLnR75psOklG1OYrDCDJQsU8PsH72x28Q3BbAiUJe7D3Pl1T3X1HaLvx8uBMb
	HtTV/m2eYfbzZq/t78ZdA/h4PxzostMOTmmwKKBA==
X-Received: by 2002:a05:622a:e0d5:10b0:527:69ad:fceb with SMTP id d75a77b69052e-52d512575e3mr10177061cf.0.1786392136248;
        Mon, 10 Aug 2026 13:02:16 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d1637dd4dsm78983291cf.8.2026.08.10.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:02:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtWCN-00000002D1s-0cYc;
	Mon, 10 Aug 2026 17:02:15 -0300
Date: Mon, 10 Aug 2026 17:02:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: [BUG] iommufd/selftest: KASAN slab-use-after-free in
 iommu_report_device_fault
Message-ID: <20260810200215.GA518032@ziepe.ca>
References: <D5E3AA41600B2056+f4e15662-bd2b-43ea-91cb-518de429e72c@smail.nju.edu.cn>
 <CO1PR11MB48353016C02FDA31BEEB274D8CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <ACFE02E91C9C4025+1b43727a-2964-4c96-8a6b-bf732a7c5620@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ACFE02E91C9C4025+1b43727a-2964-4c96-8a6b-bf732a7c5620@smail.nju.edu.cn>

On Tue, Jul 28, 2026 at 01:32:09PM +0800, Peiyang He wrote:
> On 2026/7/27 17:41, Tian, Kevin wrote:
> >> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> >> Sent: Wednesday, July 22, 2026 5:52 PM
> >>
> > [...]
> >  > Since iommu_attach_handle_get() explicitly says that the caller should be
> >> responsible for "synchronize the call of iommu_attach_handle_get()
> >> with domain attachment and detachment", maybe we shouldn't add extra
> >> lifetime
> >> management mechanism around iommu_attach_handle, instead we should
> >> fix this at the caller side.
> >>
> >> Fault report can run concurrently with PASID detach and replacement, but
> >> before the old attach handle is removed and freed, mockdev must block new
> >> reports
> >> for that PASID and wait for in-flight iommu_report_device_fault() calls to
> >> finish.
> >>
> > 
> > yes the mock driver should drain in-flight fault requests before the
> > actual detachment, just like other iommu drivers do.
> 
> Hi Kevin,
> 
> Thanks for your reply. I looked into the code in more detail. Would this
> approach make sense?
> 
> In iommufd_test_trigger_iopf(), call iommu_report_device_fault() under the protection
> of idev->igroup->lock. Since detach and replace also require the same lock, they can
> be serialized with fault reporting. This would ensure that a mock fault report either
> completes before detach/replace starts, or starts only after the old handle has been removed.
> Thus it should prevent the UAF.
> 
> Would this simple serialization meet the design intention of mock dev? Or would you prefer
> an explicit quiesce/drain mechanism instead?

The mock driver should follow the expected design of a real driver, so
I'd put an internal rwsem or something like that to protect this

Jason
