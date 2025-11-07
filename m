Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437D3016E1
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543013; cv=none; b=AAWiqlLr+cR4mLc5vCXtb9xy0YGwM5+G0SyaonwA7JO4ZgdjE7aevhW+ZI9rt0Zi3nGf+pkc+IL7CQaTSnkPkIHORliXmskcsy73ICyzmHPtjkrO8fDnfFOaWRPpSyssy4szbNP/StDK9mruNm4MjjMoy81o8fH+VAOjQz8s7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543013; c=relaxed/simple;
	bh=VOdPNLzT1eZ1NEB09xe83HjehWmI3iXz/M9xFWPtPBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6QFDfUjodvYrZevOpJXu6T/grW9r+o+CcauN2Snw5+Ckt5b+kIkBwrheMoOHs2YIr0XQExnqw/UKCkZIoKJjBji1yYpwsO7arPAhB2u6EuVHeQWb042HKb4yeOOCVVLSOMVHfzxmwbKN0G4WeARkqcrM8Tg15clvmFSne8w7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dr7jLLCJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dr7jLLCJ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-882379c0b14so1601196d6.1
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762543008; x=1763147808; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uecw5GuJ6xKMR/52t0KK0j/pRrv42h6jWvdNot4nYIc=;
        b=Dr7jLLCJTOzDcV9lcnXTt1PlC2fogkPauEC/wKafKTmSl/C8MBN/jqij0k2H4qTgSz
         EuLQVJ7Xgs3xZEpIajQ1dH9U1RxwspwME/jl4wMDrVhDm9EzjubrTtipvAocqtVaiFl3
         37qANDQlMvDfKvkUhYVtXQueKr2XuYMk1LVqbCFloPldFgcPmq6hWFWwB8+ZSlTen2mT
         mACI1gUBjDSwrYINJXGIX2h+G0f5fKjqegTCSDcTZEDZ7Xtay5qvyV3vKm+h1z2xLHOo
         TjowRqPoZKhyHcpAaZdvjZPZ0AlTYPyigNKbu9j2+QtPvQ37/XZVCzMVU+38MLzxGojX
         7v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543008; x=1763147808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uecw5GuJ6xKMR/52t0KK0j/pRrv42h6jWvdNot4nYIc=;
        b=QjjTQIzbs58bRDU1NJB/0yFTtLttZYKLRO+WXnfsYcFMdWm3GdJlQFcIR7iTHfB657
         oDQCPe5jfDHmLEQ6Z59DQfLo60Vwu5HDYmzkCmRfzIKSKIsleg3GZ1HQfQBZ8CnVH5Mq
         2QpjQd65vHG9TYN3f07CZLows3g+iUw1opija/KBBDvqkyaL65YnQ++E/ng18CwyX1NX
         cOFiHMd95SZzHMnV5tnIcde63nSgg2jAqaGvBE4ctECaeGLYU2razLCXTNTC4TZuQ375
         R1x23rE61QtEmYI4UfgQDFJF+P+DR7efg7CSmt39OYWrqMAQFup1Bb2uXcs8v9QuOemv
         UjrA==
X-Forwarded-Encrypted: i=1; AJvYcCU4gfGOOlKAnvV1viZqW5KnsqekgFnPMc1MbW73qHKr0dsTqEU3wzerAX5oLjVBwo4l5X5yiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgdvHM5wTk+48c4UMYignBRfI9wxXBT2icsTH7oF3IbqA6/ope
	pNuAjwacDEnJGp6Ug1mv1aPNNgLscTtO5tUnukTtoEfBIbwLHsm6eaV4E68CH6SNCMc=
X-Gm-Gg: ASbGncto9bBMFeZKY6s9uxE/XC3q7TVocylip5q7Xhs+2RaHLjxSMPewcUq5E8wrxBO
	Xrp+Gx0RECthi2WzVJefci9YghxGpeUw2bNsN1Yn8Sw9FACBssfzZn0YTa/mC01jw4h9AkFST2J
	HMIuF4bm3E9XWsTwtsIHnsf0tbvfN8RgiRjJSU2ONR3gLjIBrhfXcocQfNfFMrNBIvUoLuLG3Cg
	kLLkuU4cwCvnVN8smOaGOmN4RBK7+vo7XxMQsBUNMM3j84KWMdDkcAqy4jLo4wmTM4GbXc95LOz
	CseSu7vvuGczVNOxxVp8FYX5299q2dI1UDjHLhVruBnDD7Sbw6MhhaakEh25ekL1UtUldD4Pt/j
	DJsVqClCz1e8vqX6tyd2A9xS+U+7kxzymyGrVQqi0VCTFomrWU1//YHl8p6r9nFijp6RqXwZ+3C
	B5ReO/Ozq1KRs1W/AGHYPP8c7Ubzk7Hr3MA4J3seDFdWBZFQ==
X-Google-Smtp-Source: AGHT+IFuKO535u2kiOv/DIfBewHOhom5AEVBkvPZuA5a9xJpNKB2nCPzp+ZUXTed1YvzsoYZhtcP/A==
X-Received: by 2002:ad4:5c66:0:b0:880:224e:aab1 with SMTP id 6a1803df08f44-8823871af07mr2487486d6.66.1762543007674;
        Fri, 07 Nov 2025 11:16:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896a8d9sm593576d6.17.2025.11.07.11.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:16:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHRx0-00000008LqN-30pE;
	Fri, 07 Nov 2025 15:16:46 -0400
Date: Fri, 7 Nov 2025 15:16:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ryan Huang <tzukui@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix error check in
 arm_smmu_alloc_cd_tables
Message-ID: <20251107191646.GB1859178@ziepe.ca>
References: <20251107190917.2858684-1-tzukui@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107190917.2858684-1-tzukui@google.com>

On Fri, Nov 07, 2025 at 11:09:17AM -0800, Ryan Huang wrote:
> In arm_smmu_alloc_cd_tables(), the error check following the
> dma_alloc_coherent() for cd_table->l2.l1tab incorrectly tests
> cd_table->l2.l2ptrs.
> 
> This means an allocation failure for l1tab goes undetected, causing
> the function to return 0 (success) erroneously.
> 
> Correct the check to test cd_table->l2.l1tab.
> 
> Fixes: e3b1be2e73db ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Ryan Huang <tzukui@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
