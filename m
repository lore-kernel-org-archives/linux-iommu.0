Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4BE3E8354
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898039; cv=none; b=sfZsIU88NHQHDEORsFz+ufr32g9F0FpHjyzWWz9lYcWlXnTWTAKpHAYDiVFLZF0LgU6tYY+twqLH1Ih8aRiMlwxs1v9Wq+iNWp2sLbEuPbD3XIBmKxXqqb/mOt+1XgHuLZc0jR66z7BWmSTvw9YleTBczq00vC/AsMY46KtYyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898039; c=relaxed/simple;
	bh=aval9P+49I+gSSuUWbQmWVLEEDNUMRnbLgYtSiXlBo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk0QBJmDHqi+yx6/5CqxavXsR3Hww+uyABwRd39CP6THQJ6fTG7uWpwxNzY8JfnGGVfhjHLTl+MvJXNMmrOylyGfQSufpCwNNqPtsiO2K3FUv4Hk4uCjbIEACItOq5qBZFAZsS9K3RaBY8FxxNstCkPrwcsUSCa7crcV5Hw6+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e5TzTmmT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e5TzTmmT"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914bbfc2464so421564285a.1
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779898037; x=1780502837; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STKe203GtXAmunHIdMeMAq0fDblU9FAY1byc40VlLXM=;
        b=e5TzTmmT1fSpbbUVV3oRTkqT2VODTEI+fIuy/iaXh4ULvB35rRzUnBune5y/8LesT6
         LCjzFlztDZHyw6Pl/6vIKtVCZ5CPby8jw+vwMltyUnmuskaFcjm8UtwAVxTugkRzZZT2
         N1K+c/SPlIBrDyCQXCM/nyZHtsR4jgBRgFlPooB4PW8Ge/Dof5N2TiY4/UwcN6BQJh2O
         DajQUuCJWR7GyrBuJ8pw3fKY7EQiqtu7FSFpd4cHfQh4ljZWVeeAAFXfmkiRi1LdtoBF
         eR9F5/WZ6cjV1ktoC61MdovXHhmHmO9c+VwfBXkVxfAlrMdUI8FUtYDhsgtiJVZkjm7Y
         QN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898037; x=1780502837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STKe203GtXAmunHIdMeMAq0fDblU9FAY1byc40VlLXM=;
        b=dRlO9UBeLyQpUfDMvEHyjhVAB5wrC97bI32PgnrNC11FWPG73l7c5rG9Fbsz/3BfuD
         DSSTsLI8u7Q3QFii23eqFzh/hQWPNch57wLeDZ0U87+xXTRPkcnez4f8sbPmguaJc1o3
         qz8kNc44oL94vriBUxTFss7LxVN8K2DyQ7xVo5FmFJcY1Q5rsU38HKh9Ulqm8KkJTy/7
         5luHczXKhP36+CuZ3VXqdaagOFPfD0Opjqj6HlzGhWWew/vbb605wbvsioCsbP2ZL5iu
         b6YV2Qiw7/SA5GBdhtNoPoRtZUTWdouqo29+9QnVkTBvdFfXa4Md0Sb3D9wKHs3DL8f7
         JzDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cGr4a6UTk/sF9lwnbWHW2l13EflzhlMZvilDG0cnO6HLUGnZjnD5OkIbrDf+SD9LugEZMpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG/fO7T17tQzjjSso3tffkRqtk219bFI5FW72MeAXs2RkR31a8
	K2SPu30+S3GA83uroHlo0coh+zIXXPO1/1lV83bibKSNHXhCglNmHlUYkYQS26wWTok=
X-Gm-Gg: Acq92OHP4dBVPnsdvaC8YIcz18PoA7OGKBKclCFQGd78FHrQatQXxIKOB0/1B4haVnS
	l3mqOUboLxfbqLPlGqGw+rnCf0fCRurqpEL2jc05MB2eRhqmdbggpcALSkMXzT9/0Bzv5xcRrQ/
	X8aSV85ve91YtrDn85TR9FGrYYJLMR2bNC7qkRpk5sxI38liUhQbJ7FT7JIrr57psp7z1Orq+gJ
	/CHH+IfxPODaw7DONknacox+aQIrzHtBjODWYwOtRAsHX5H3E6paw7CZOEG1ShCUWI1zdklQ8qe
	Bw2urVVWfllAGNMPhPnpvFuHrlgj8WJrpFSmVXYDGTa1jhrNyJ9AAOJplrluL0w70P49fcrjrvv
	J1tbyi/8bBwIvPSQUtvm+AT6V1TRux2TsvbsIqSmLtovnB1tkFgWnVmP6NLmtC3BcUIszHKNObF
	TJvlGKNNuT1nPL1hTfqd3bZQTdYByWpboQ+kot24X9AO0fC5EIGuGsI5KPpqTEOMu3ixF9IDTnK
	2uG4A==
X-Received: by 2002:a05:620a:1b89:b0:914:c246:aca0 with SMTP id af79cd13be357-914c246b146mr2808635885a.36.1779898037030;
        Wed, 27 May 2026 09:07:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e8e13sm505133685a.2.2026.05.27.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:07:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSGmq-0000000FI8B-0NaX;
	Wed, 27 May 2026 13:07:16 -0300
Date: Wed, 27 May 2026 13:07:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, mripard@kernel.org,
	sumit.semwal@linaro.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260527160716.GN2487554@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahPqbfH54R3JJyaV@infradead.org>

On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > module") the system dma-buf heaps can be built as a module. The
> > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > but those functions are not exported on powerpc. This can result in a
> > build error like:
> 
> I'd much rather revert the above commit.  Yes, x86 has exported these
> since 2017, but that's a really bad idea, and we should fix it instead
> of spreading the export.
> 
> Setting memory decrypted is a dangerous operations and should only
> be available to core code.  We should have various allocators for
> decrypted code, but not export the functionality to random code.

At the very least an EXPORT_SYMBOL_NS.

Looks like there are about 3 modules using it already..

Jason
