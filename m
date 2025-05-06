Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA3281529
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546018; cv=none; b=CWQiE9eONj/epMOjzUlNMYPO0eQ+cTaBWCXuCfAstgYFEeICkp8lBjEaNqqa5jy9g6Pt5oeM/imkVss/q1zwf8/yEWNLHmK9g0r9i7i4BL35C7JdvSCiuD+ojPSxK+fNiUj3Y6DTSEcZdfAeYuGZ9UjJ2TYBJ6Dbr6mGJcPySX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546018; c=relaxed/simple;
	bh=bY6kWgoeHMO+pQ1hmESq/ka/7uYffdd8ryGj98Lx5C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgHs05i/scP2kQFYRQzLoubSvgxZoIW9VBT8dXDHcs75F/Yj6wM7GF9CmIOoMyO7C3QgJ7ar4/wmufJQKnZLoKrY0W9UmSODE7lx4Qx8GVAff0/OmEM1mTKgiByTilgQKEWqWHji8/3AXLyj1RyuPyjsF+2kLp6sE2n3XMWxDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gAv50EOQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gAv50EOQ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f94c2698so33451936d6.0
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746546015; x=1747150815; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rT47EbPl5rmGmBtm4poGbS4wq2tYGccwoLr0keQJKRg=;
        b=gAv50EOQKQps1HkDO0PYaDOElvqC8RM6eNyVqKbR2F3tquxZrRR3JcG+XqBBx6nNjA
         TrvGZvX0TEfllJc5CNQPudoQMVZbLZ9dauZJC1655nYab3Mkplv5Q6YcshB1C9CeJ/Ow
         PzyZqwMCBgAn9oeIVOnuFel5TlIDppnN0sIf3YY3bUYWLYmYC8aZlyK6mQynd/YfZO3p
         Q4aB31aVD9j9bsCR1Aga7JqAKGF5j1xElyNzvkDPIFwLrmkRpDpFhVDzi2LgB7OYKEvy
         ED0kEYeQDTg+9T7Tq7cwLeoJYsJQ5ByIEvM/lZGeNCAc7Jkpqa+Tv5PUKvL4Wv5C0iaG
         /ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746546015; x=1747150815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT47EbPl5rmGmBtm4poGbS4wq2tYGccwoLr0keQJKRg=;
        b=bbVDPrYARc4OR+GollpLDJV3JiAdz9xnkX0tN1FVo+brdZERazWw07JCyx/S9UYntn
         IgFlgRpcga++5S8y1q455omI2P23Td5Y3QN1ha+FmrqN63GtMRoZV/a9UE9w5H/zuERK
         STnM1lVkFHFw8aTB87WqX3S1oLl3PQ22Ct42SRWHMYMc/FRVoQwVHexvNgflzv7hmKJI
         Gt0mOpTPC6mKRg0kDwreG3wB5EhHRLTI84RBCzo4dmdHhZIySPvTmtg8Qhej0bsHxzKW
         6oqDxwE6HUydUtF6gmoLWdIwRzhYwh+d0pm0BNyLuV6zo/arbuxX9x+bfeK07YgABihE
         J6Ug==
X-Gm-Message-State: AOJu0YyUL8LSv4LGxcpXCQzd3A1c1ZHMwcKbytzFMGhX43SziPVKtX69
	vwUqHnItVTK0Y4lHgALH4t6nBezJ3b3pZutDaRWGNb3KSduKHfxquS4hXkCvS1sIj/IcCENBdWs
	G
X-Gm-Gg: ASbGncvXZuGynHZDQkl73pWrWyuPlQl+Qp6rMC7PDbwfQtB+li2gbj5NcKe9Mc0S5PF
	QpmH5xEE2xpadXZjGfPjOY1QqRrwQkhhh0hPWLMEiMiCdZvHvK3sn00fSaAWsL8krpLHYqikoLu
	H8CYwu2CAnGC+wTEW5mxhM34rKRIZw0EQnwDdKVEcBdJfs6VTyqqWsXda0d5PmrnYyH62M0YOnE
	mgF0wOxaRf4OSU7GZpjijYu0Bt2P2cKQiIfKG3j99hAnVFZzkqLhraZZFOaz8DKIQSUATYwISOV
	kyr+wZmxfqKa3ZxoAoR28IGyEQPtgiMZ+P8o0fw3jqz/qz2vukZNY+9w8Wabj4qKZT2lsYFCS8j
	Mv3WjzpmUkdL/7CCEC0jwGdezD4Y2gg==
X-Google-Smtp-Source: AGHT+IEQ/a7j5Q9dt/+TXCErTmGmvU74xW7gWFXsaqhe3tHBRjnQSeuP9g4SIDonoyL/nuksjNTl4g==
X-Received: by 2002:ad4:5aa7:0:b0:6e4:2f7f:d0bb with SMTP id 6a1803df08f44-6f528c3b587mr198664136d6.4.1746546015230;
        Tue, 06 May 2025 08:40:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c4492sm71689566d6.35.2025.05.06.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:40:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCKP0-000000008dJ-1HMo;
	Tue, 06 May 2025 12:40:14 -0300
Date: Tue, 6 May 2025 12:40:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Support contiguous bit in
 translation tables
Message-ID: <20250506154014.GM2260621@ziepe.ca>
References: <20250430231924.1481493-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430231924.1481493-1-danielmentz@google.com>

On Wed, Apr 30, 2025 at 11:19:24PM +0000, Daniel Mentz wrote:
> The contiguous bit in translation table entries can be used as a hint to
> SMMU that a group of adjacent translation table entries have consistent
> attributes and point to a contiguous and properly aligned output address
> range. This enables SMMU to predict the properties of the remaining
> translation table entries in the same group without accessing them. It
> also allows an SMMU implementation to make more efficient use of its TLB
> by using a single TLB entry to cover all translation table entries in
> the same group.
> 
> In the case of 4KB granule size, there are 16 translation table entries
> in one group.
> 
> This change sets the contiguous bit for such groups of entries that are
> completely covered by a single call to map_pages. As it stands, the code
> wouldn't set the contiguous bit if a group of adjacent descriptors is
> completed by separate calls to map_pages.

Nor should it

This seems like a pretty hacky implementation, it doesn't set the
pgsize bitmap to indicate support and it doesn't have a safety check
on unmap to protect against partial unmap of a huge page.

Wouldn't it be better to use the pgsize bit map and rely on the core
code to tell a contig page size is being used and then it can
trivially set the PTE bit without having to do all this extra work?

Jason
