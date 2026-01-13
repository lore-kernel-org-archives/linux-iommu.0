Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4702DC349
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316912; cv=none; b=LoMH1RPtPuvpenYHGnvkJKBfk2yMjZG3cceSZpfm1ryIF7hY03FmU2tlWhssPv8aAxaXt2XmDUSFa5PfEzKItdRKnEO2De1iv+5X/C8veFu/12njrT1sQGwg4beKbL3Tzh5rICl21xJbjphPckN+Xzw169D8vKHtuUK2WYPRDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316912; c=relaxed/simple;
	bh=Zby18NWIZd9LikNKagpy2NdD5nLGxACKPIZ2QhLKgIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvygJxcrW4ppzEYuL/HCi41tIb4JP3RbR/QbM5/Eju5oDsGrHYqip7EYBhMvHKKlO0WVz2tdQXKgiQUwwgjlzVZmS4SsAbJF9Ppuw0lC9zqMfOZ1v7rAt/+7OVQPkSv/jxLSmze4SBvrtp1pzGJrDXP9Oai8vzJSlXPo0eC9u6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HlxMbAo4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HlxMbAo4"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2a4b6876fso1175787185a.3
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 07:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768316910; x=1768921710; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zby18NWIZd9LikNKagpy2NdD5nLGxACKPIZ2QhLKgIE=;
        b=HlxMbAo4tWc09IEdmkAZjGPjgJIIBh5faCvCqNhoEPLFaNBHpQEEDdu7w30a+7ShNx
         3xE0NPvZyGft3GxF/3udf8XyQv5FZ3BDHe7w6MWOBG72CJeAUKwDXADIRQ2yyGF5Xl/l
         qYxdw1POmw4qttuyOurrMGRLwZt/hLwPvrBa4iKlBdQgbj7086Xepg+VK4LL1s9wTI3i
         UaLxv+pxqvgWT1COmGhkpH5rPhHpKSeNJR2ByfFbaZONR9rVOHi+QoVge8DoQJvFgYVI
         Zq899PQ2Xxx3kmEONr3aRsZhQ3EhMQZYX9k3EseeGKnXtYkE0nl+avnqDsPI/hfoSBZE
         iOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316910; x=1768921710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zby18NWIZd9LikNKagpy2NdD5nLGxACKPIZ2QhLKgIE=;
        b=qQJhkL0db5r0CdHna7a1u32IMBr1Rey3Md7w4qyvMgMqJq0ID90jOjuMFkipgSXCX+
         xj5EjbVj3AOPSFITaDjn3x0PgQxGV962PTM9ygu+XRvmm0HLlN7IfIWq9L7cBySzzGmY
         x3/lbfIQ1kX4d2D5VJNDN/qecfTMVuRQHrl4OT9zYhm/oglgWG9Aj7DNQrGqMvi6E7fT
         HSzfm9pBuVnPzK9bArn3SLrIC5PXNVj8tZLlZ1RM/vDmjXLEjUTpt+VN/VYGSu/R5F3d
         mp9exV1yGzczVwd3bGutpb6szPHXi1MAY/jtsiAxgsgB3HZzipiUNLjrGmqJMM/qlAwU
         ikzA==
X-Forwarded-Encrypted: i=1; AJvYcCV4uysXviMfQOoN1/RJnT63aIZJ/OmWzlJH3ZJQDM/MRX4q68izbmQnetUEsfi+Ntco3BZcqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwPWklHKcaSS8xuqn1Y+EgZrN/t6Jv7DFABkDgzQIWrIP27/Sr
	asYr5jkM4WDhxt8l+2cN01Mte65VEZoi2vjFRVfKYq1OPqdXJG1dMefjFbCHo2lunNY=
X-Gm-Gg: AY/fxX4x070vnbAuRKM9gFJCqEQmjVHhsFvhYfCHTbBulFQDcdcyv5XGGKchpwDhlnQ
	WJKn2pmxJFjhOmX6iTSj89Gw0/C2Rw7YBNWUTuVPGUODDRwsa+NYuZewhyU8XJlbS4FBNE7qz6G
	za+XvPoZ2s1PFcGtmxl9ehQvC2JzXInO9ClHyl24+ANlEDAwQq0flsWxZjk5z+aqZYKW10TrLaW
	6vBiWUbBFLMBqcNERs+nmoFIwhGu0xX8Pzir1iiu25PxHrcQZSCWxmN6qL1I439eeZnRVcAqOCf
	OTYZv7HYJvU1eX+HvQpggTf0KBj+05omgVwGfPAhQr1yOerprcyp7noTIvCwQzY1Ix65pe/Ma1N
	70H1Ym2PK+lK5q+YaO6koZHwwSWEyDWpOc0ETbX+C9KJZmf/O5Cu1/NOurCPLbCof8Y36E/UgVF
	eGaXHlLKamwWYgVGpHdcP/R87EtqjjaLSV48yc5lqbBdyi7dJyTIB867IimYqo1slFZY8=
X-Google-Smtp-Source: AGHT+IEXQELOkUASiIG47wGrsPIeAZgzyEl1xKDO2iVvMsRIfq+sXO7FgFplrL2YHUPM6Jt0YgNMYQ==
X-Received: by 2002:a05:620a:44cf:b0:8b2:74e5:b3e with SMTP id af79cd13be357-8c3893a9e9fmr3015531385a.36.1768316909508;
        Tue, 13 Jan 2026 07:08:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51b732sm1696908185a.25.2026.01.13.07.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:08:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfg0S-00000003udw-1o8a;
	Tue, 13 Jan 2026 11:08:28 -0400
Date: Tue, 13 Jan 2026 11:08:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, xiaqinxin@huawei.com, baolu.lu@linux.intel.com,
	rdunlap@infradead.org, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
Message-ID: <20260113150828.GP745888@ziepe.ca>
References: <20260109195111.GQ545276@ziepe.ca>
 <CAFgf54r_au6isA10Nrve=MHL455X=tKhNsSwH1ej-TX08J3xLA@mail.gmail.com>
 <20260112133256.GB745888@ziepe.ca>
 <CAFgf54psxPrsvujStPNtrzxiKOsJF+aVrN7BcNxxmAF4wDmRXA@mail.gmail.com>
 <20260112135208.GD745888@ziepe.ca>
 <CAFgf54q+9Y5TtGJDB=8q_BW-0F=TM7zBbCcMzvtvr_N2WMnd-w@mail.gmail.com>
 <746f5adb-1d91-4ca2-8ae0-a2d171203b66@kernel.org>
 <CAFgf54pbkfdFr6biE8BiNKBnTBFWxXGmvxsZ0E+C1C44c9AW_g@mail.gmail.com>
 <482f2f36-e906-492a-a80c-987bf7359d83@kernel.org>
 <CAFgf54ovfnTHmMuZGk73SEEKsP3k-_exR1wqUE4W9tLYKv_iDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgf54ovfnTHmMuZGk73SEEKsP3k-_exR1wqUE4W9tLYKv_iDw@mail.gmail.com>

On Tue, Jan 13, 2026 at 10:49:28AM +0000, Mostafa Saleh wrote:
> Would you have a problem if we added a new function in page_ext
> "page_ext_from_phys()" as Jason suggested?

Given the hidden complexity that David just pointed out I think this
is essential to encapsulate it in a function.

The function must be able to accept any phys_addr_t and safely returns
NULL if page_ext cannot be used for some reason.

Jason
