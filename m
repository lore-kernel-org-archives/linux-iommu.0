Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3506446853
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031765; cv=none; b=NuuAoIBWITWruo3s3nhC0V+o9gTxFTO4pmqkORAwFQUR2D48zlzwLtX+4EVKz6Ht2gCxw2IanrwKTsgljEdS102XdQh54fcdS82N9Qw1xYL1biHrBD+ahjPlghY/weq1xH+t+Bt6MuoPdWGDs7jr9JXC1zbyRxrvA/cZ3xQ92iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031765; c=relaxed/simple;
	bh=Gu04W+cCiiM26ZsyHUMdXjMPrm/Duv/aZB+CYp/Nq1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFGhNc58VjuUpfzAoczxR6srwnO/3j3xbkTdD0MKCfiZ0BxwXD4Pe3jJr32g2AzfGhO5pKeuEDdxZv/h2pWJq/b2kzFhamnx+Z/cgLj9/Uh7tZOXngH7BTBAug4u6Ea2kok7yYs0bmbnDfJVxR6olPnxW9bRoC3snA0WDT0sFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hn86S0Qb; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hn86S0Qb"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e50979c71so409045885a.3
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 05:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784031754; x=1784636554; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5CIAv+UZ8t7s5h+WlDS73yJMkdztMQ3zXG2Fxq/to8M=;
        b=hn86S0QbmD4alhFSQozEcnBS2MRkJA4nq5baGWYRsQTP/h352hBpvMs0e2GCo7c0w4
         jP/EdT8tEcI+5tglyli9KU1t+v+TMCCXU/EgjAtUrhyYoQva9qYQSwOjbLhriE3WfDTF
         17AmuPUhVfCM2e8CEtyYmEbYdDeWEViiC1JQxnT+GpfeDIDcln87ym2AQx9YlG/Hz346
         6Tk0lajpefubuFmmUaBUxTfeTzxli2mNBqwM2eVR4TA1QB3WpzQZrlKxDpHP5+2rs+pJ
         a0DNfL4j/iH7XpS5nB9XW/6zsb7X4X8bVtEDwMgek4QP5n+iNxuBx+bingHtif7rnyDJ
         LBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031754; x=1784636554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CIAv+UZ8t7s5h+WlDS73yJMkdztMQ3zXG2Fxq/to8M=;
        b=IhBbjJE79fAX0/VxYgbHmL0pFChb/RD0AXPC3udstUe+y3rSuj9b1ZhjRIpjppQtyP
         2Not2KK08rSxxP57WDnuXtcvIJZV42nOD8szuqkH/sEKCE4JYcRG0NTsSjtAqlwrXq5e
         ZCWGYU/afQrAfuEHznB4XC6FZi/vvg9I3j4La3AK6JgKUaiMlprbFpbnF9HQmxetwSQ3
         xmTIhvfkf1u3juv3RU/NkA56T0aHCh7q+XPU9Zxh+UiVPT9G5ljjXvshtsZm+9p5abet
         Gl/4fQ37tH5IwSQDYiIzOTykvV8wH9uLzjljjeuw5amueckayj/9qrKOX7bBlVKkAfDJ
         NaIg==
X-Gm-Message-State: AOJu0YxC9XbiKkRrbajozBrKcTXuWD3fnryiyVoZZMFA85oVOS8mOv0b
	k4a5+QhJiKWGOhXOYF3I+EMpCWyDHOe84vh455vABp89O4wZf4++i3mJew95nEF1OBM=
X-Gm-Gg: AfdE7cn0g60HiUXPOcgIRHR4BurnHucRaz6K0jb9sB3/I+m8w7tiWm1BXKrL3CH1KwQ
	z+v67LSruK97znwK4P2Si9Tr8intQHSFUfhjsaW+8vp8BCVRP/NVxns8u9l+QYsxCbHiY7pGjzR
	maZdJVjyi0CBuErBzGs4ieNwZLKXwdFr8x5TcCSMPI4oSf5rNpiK1uAhxlL+FSLOoaXYCRtwVU3
	kWhjjCBkdzehUt7CyIBCeLTzjp22ixAiYRHRI3BT1eTwbTBsFuMX5Sgv6z2wnW3aiSrK2mJoKFm
	N3eh1lzm6aHA8IM8wclZRBIKSviWHc7USkcD0dVGPsozCYXjlYfWlL667uLX51FgOYK3TFSQGS/
	8yrh6fCycCFC8MoaLUoxbI88VQsdkqBSc0co0TIzB84WC+Kpfdz/PrQkEoHEh
X-Received: by 2002:a05:620a:7085:b0:92e:6bbf:966e with SMTP id af79cd13be357-92ef2cb202cmr1211484585a.45.1784031754284;
        Tue, 14 Jul 2026 05:22:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm164927486d6.42.2026.07.14.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:22:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjc9g-0000000FRaG-0ohM;
	Tue, 14 Jul 2026 09:22:32 -0300
Date: Tue, 14 Jul 2026 09:22:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 02/22] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260714122232.GE3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-3-aneesh.kumar@kernel.org>
 <20260713175433.GI3133966@ziepe.ca>
 <yq5azezumef6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5azezumef6.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:05:25AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Jul 01, 2026 at 11:19:06AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> >>  	 */
> >>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> >>  				   1 << order);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		leak_pages = true;
> >>  		goto remove_mapping;
> >> +	}
> >
> > Truely these _set_memory_decrypted() things are an insane API. So a if
> > it fails to decrypt it can be in any messy state?
> >
> 
> Yes, we could possibly try to encrypt the page again and, if that
> succeeds, avoid leaking it. We might want to do that tree-wide in a
> separate patch.

IMHO it is a horrid API if failure leaves thing in an indeterminate
state. For something like this I don't see why the arch FW implementation
would be unable to restore things back to as they were on failure.

But whatever, everything about set_memory_xx is really bad it could
use a cleaning

Jason
