Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCA25A2A2
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728545; cv=none; b=MEhvTMTOQWSc6uAfhmUkfNJBf2SUjodtpDo4zExk9du+tDbRUynq6zKA6V7ocmz0W2ErbwmxRN46Fn4cPDNtd9nWAWEwkpJSoN6WAGtjMnK9iZsojdclmS7a1+xtJPrfLlSDGy2J/KptrCJK/k63SoOv7M+qHbiZiAlsx+wLTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728545; c=relaxed/simple;
	bh=+wmk6A0SSJQS90x9QvNwHXEyptqKAuBqDDTv/ioQHhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW4fYwmg3uOfpBWeU8ASoF2JrSFKJb4U5aigK7oQLEJsh7bDEJFTyV4hyt68DNCririJPmGk4yBwK/F3Wx5iErOfWviFAmRWTYMyF3GUOMrncfM/+3o+yFOoQmis6/WJJTeIsVgefkrwINO4wE4kPVOwYpyZ1nuG2mfmdw9JPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KV6A6i7q; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KV6A6i7q"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c6a50c17fdso413000085a.2
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 05:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770728543; x=1771333343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CukWcBoPz7v4d6E1diLj/dADiY14CHwtYahwJE8UFu0=;
        b=KV6A6i7ql6RvjfIy5dqC5et7Iierkjm8uuHeGCVaJbS3nCBmKqpTtFqQu+x8V4cYvQ
         IFA4uIORRfEyBVNUEHrOTzgrgSQZGNPWdzfOnhSerEn4cFHk79z60Y74GAvDaHTAovpW
         67dc9ShAPfqTPOAyqQZf3Jmj5pZCf+E4eMb9FL1PS5D7GTQ8RRf87B26FyP6UjtnHfK1
         ZwSmGf/AbkwcJDKcsXwfjbr5t3N+Cr7zi/Jhh6baUDLV2zCMosm2rdtpEG/FAMbOGBrQ
         7jy8FogNPScwIp2+C4vZ1QzYYwKVw4MK+U+Gwl9QKWsPeYui/QgSjhcbGUPx3+WOvqmk
         G+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728543; x=1771333343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CukWcBoPz7v4d6E1diLj/dADiY14CHwtYahwJE8UFu0=;
        b=w5VULeOE1debcgHa14BJC4TdiUzJrh073lH9QUJj/Jr6ootUBeq21+CjxA8kKvk72C
         2Lnkw4mKtpWdElA7oBGGE7mOydz6+Uu8YN97CviTrrKbXfMZ34/6I7SUKRhwx59fkPJ+
         Mj92nRJ7fOa90oGKJAZbCSEgkOEfU1D11DZGej0Nyjxga0QPgtPSARFlLoS3k/qKg0BJ
         yZYIEHZA3dvmYRJwjW/PqdEhzu1C/3IsIy1thtEJMb8+08m7lUf5MQA0qZ3cZuI/hbRb
         Tk52ok71DIFgbm1pmhFO2Iwo0yvud9XNMtJUChRcO/nGDRO6Qub4bVH+Np6TQHY9phqV
         SSRg==
X-Forwarded-Encrypted: i=1; AJvYcCUnDU8v+Pj77B96MVatvyz9IebbLcK4FOyJp1oepyxxEWauPo5rRc70i22JM9hVMUekfhfRwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjNFOwEsByavcpWFPzu367WS83DbeCq++aRy1f+j8/aZL4/cnn
	V4kLM782LE/IIMPb/OB4ICHNdLjXx0X8o+z9t9l5xICEInLBXkcwYi+BAF7+x3suSkZGy62DYuU
	RjfjA
X-Gm-Gg: AZuq6aJOhtVFaXjDi7Rd5vMmDgH1tn/lauN7UZshyG9Y/NF9Xe51HyUWQS+fOu+5Gp6
	YyjjK5h12Kb9lH8dneRVoqvBkPTZrlJADCf3rZT2Tztf5vTD/2m7nRIH7WueWcE5dAyCH+540er
	IKnVQvoshP2/UsQxJBt1AibPCbAsn4lW8OUgcMd36ARtchw+eV+v0v6FXJBJUC3fqa4sKHirHUG
	Zb91iI3eTUMtVXzi4G8srxKla999wcdbx6g3pt5B1vPwF3kq3YUsPFpQj2k1qjZqxw8js1QKkT9
	f2E0s8PIK6aAmgtOK1aI384Ce3Y7NB3tHRtY4iSRYp5HLa4e2wiBGGK4emjLXl9wi6QCHQvbiRk
	gGtm3c1lftvo4jfit8UPyxXz4NzUeZBeuAE+iNwT7jNKOBW81IV0o2a+TPmKTZLLJ2hWs/xhZI+
	1/MXfOB281bEqDmRcGum7Okpm5b4M3fYG6JB522E/cP2LyRAgmcqa+4vs0jxFMtIaYUVvmvc/3+
	mSmsSQ=
X-Received: by 2002:a05:620a:4006:b0:8b5:9f45:cce3 with SMTP id af79cd13be357-8caf13078ecmr1893502485a.69.1770728542911;
        Tue, 10 Feb 2026 05:02:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee8662sm1119957785a.37.2026.02.10.05.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 05:02:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vpnNl-00000003784-1qfn;
	Tue, 10 Feb 2026 09:02:21 -0400
Date: Tue, 10 Feb 2026 09:02:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, andrew.jones@oss.qualcomm.com,
	guoren@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/2] iommu/riscv: support range and non-leaf IOTLB
 invalidation
Message-ID: <20260210130221.GE943673@ziepe.ca>
References: <20260208144213.94856-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208144213.94856-1-fangyu.yu@linux.alibaba.com>

On Sun, Feb 08, 2026 at 10:42:11PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> This series adds support for two RISC-V IOMMU v1.0.1 invalidation extensions in
> the RISC-V IOMMU driver:
> 
>   - Address Range Invalidation (capabilities.S), which allows encoding a NAPOT
>     address range in the IOTINVAL.{VMA,GVMA} ADDR operand when the S bit is set,
>     reducing the number of invalidation commands for large or superpage-backed
>     mappings.
> 
>   - Non-leaf PTE Invalidation (capabilities.NL), which allows IOTINVAL.VMA with
>     AV=1 and NL=1 to invalidate cached non-leaf PTE information for the given
>     IOVA, addressing cases where updating mappings replaces a non-leaf entry.
> 
> Patch 1 introduces the missing capability/operand definitions and switches the
> IOTLB invalidation path to use NAPOT range invalidations when supported.
> 
> Patch 2 adds the NL capability/operand definitions and extends the invalidation
> path to optionally request non-leaf invalidation. When map_pages() replaces
> non-leaf page-table entries, the driver invalidates the affected IOVA range with
> non-leaf semantics.
> 
> No functional changes are expected on hardware that does not advertise these
> capabilities; the driver continues to fall back to the existing invalidation
> behavior.
> 
> Fangyu Yu (2):
>   iommu/riscv: Add NAPOT range invalidation support for IOTINVAL
>   iommu/riscv: Add non-leaf invalidation support

These will need to be redone on top of the new page table code for riscv:

https://patch.msgid.link/r/0-v3-9dbf0a72a51c+302-iommu_pt_riscv_jgg@nvidia.com

It should get picked up early in the next cycle

Jason
