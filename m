Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE32192F5
	for <iommu@lists.linux.dev>; Wed, 10 Sep 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513751; cv=none; b=b4GSiRVkQOPf2Ut7ijhS2RYJdkV6tPk4OA+1wtomBE+0T/FTSOxbzkmUcGvM1SPJ41zEOgoMOn/f4IOoqF+a8gk89rTxqvbSiGqooK96q4Iy3FGJYrDfqUx3fG/djkmw1bFY/aMHBMg1KxcqoW53fo0iyHuSbfiPmbk1ZI+i3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513751; c=relaxed/simple;
	bh=ESKXExJLIuE1yoebiA/ue+cSaONVpwchtGyuhY5cYRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ6IwSz4PWqOAW4oru9kp/EImLz1YzYWxKIYsA9xvOlDw+pvZt6lxAIFNCJ8aKRPw0iH2jFS2DKtlxzeyhOY/aSJ/yIx9ZgerrSwI9F+A99jK8MNRt4f8HVMYMLELdsFTaD1o13jekbCkx0sHHtBmq9MmKe5hAeJFsG4pZDEM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oZ8lO6tw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oZ8lO6tw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-80e2c527010so395438285a.1
        for <iommu@lists.linux.dev>; Wed, 10 Sep 2025 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757513749; x=1758118549; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESKXExJLIuE1yoebiA/ue+cSaONVpwchtGyuhY5cYRs=;
        b=oZ8lO6twS/yX9aIq7n03cUZhVL9PmgM/iIPMNPQDEEJ67az7MhLxL8dxt5zEuTI3+O
         LHUg+4d3Ncyz7J6Hy5x60wDPGArEhiJnvLxiuP9lGdKkJr/ZNFZGgKh+c3VHcbRSl8rC
         LMwVXikWC5spu0oC9hfcZtI4MpzWVlqpZTbBsfMDnXecnSweG8xV+J0hsBdgW3wm3b7u
         s4Tnj1geIcx2f8gA6p/1v0tohupwCKourZ8SYCscJMyhr8mVkW7ajOkEa5580NAVKgoB
         a92iVdHE0tCTJainig5a8EYe72/+Pe89h57Me+yhWUjDEe9r8+QutjK6gqxjQOfOf+VI
         Dl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513749; x=1758118549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESKXExJLIuE1yoebiA/ue+cSaONVpwchtGyuhY5cYRs=;
        b=RuCH/36P9ZtWpjDBEFBCfOObfg/bvnVRKXMq5L+O+mwPdEfBvYw4xsnVqflR66x0vF
         JtBeQSTAzAXAnTeomelHw+xFS5YEQPGvgW6y/VWAMV/L/lxJsJWcajWG0mE9T5VxtTk5
         +Jt+RvAVy6gf0LOU90xyJAdXWfd0ULPP5KjoJ3AQweMvyAaxqjBN6XqDL7vD4U/RpIHd
         CXwzxZwlqHPO73spHj/pR8jBt5lYu1pDss266nvWUKHZlbldEki9t2s1m1ygHfYGAn2B
         Xh9qqp8hUvq6ZOyeI2Mav+Y/aJm4GWKMjO7eS5yialRRoiOnD3RPt3+v2D21ObaR7flO
         ArUA==
X-Forwarded-Encrypted: i=1; AJvYcCWoHQWlz5TYevIdXbMbMvwwTSmWW4bmmKR5zmhfEu1OESwO8MukL3CMPTzRmcntp1OiXtDmYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCoR/hW/De2BZW+9xholipbjSaMCKDNAYK2UB4LdBtieMNlrMD
	LCMZ7Q0sGP4L3nM0QxYqx744SscVcJHVrSKjsoHb4Z0SYIdbMkwAQhYO5q73SMkKEk0=
X-Gm-Gg: ASbGnct4NzCuhESKCxixnkl9thYUjisK+Ryr0daZ/6FP/ZXunx4USjWVGpxtaELoodg
	bm/eF6x1hWKV6yHi6WFH94UqlWe4Ct7bIoDCKCMkfvWjWNuhOUPHfDL5gpCqD0pxPoJ9EB672bP
	9NRPiWE3apq614O8nYqJEq5KILOJyybYXAGKNsTScXOqVnBRQ1eeRhyvMeolF3mLD+ERgmshtb6
	PnxyRp22tPIoRuKAYtKgxW6qqirXCYPs1HdoL3iG+LrTwio7rRy30/UpRdkw749XlVWHkLE42tM
	sqOBZO/MVk9VSn+lB8pEJgRc4eiQIUaRFqqZ54/l9jdiUfn0Vb09a5xsTdC0qVGDKzzLasR16Po
	Gadaet5VnZOPpnhKrHltBPeqUKEkrPOwrlpCk/L/8HMraOAxEpEN22g8RI+wab1YxVbzfzfq0+d
	Tj0jOeALecqIuUPA==
X-Google-Smtp-Source: AGHT+IFfyhIETCUrm58is+DJKy2K1cA7/NQr1D0/v2K3gk+WAtxi+xyNq/8bDediao12ZQz9GzGhAQ==
X-Received: by 2002:a05:620a:4515:b0:818:2b52:2315 with SMTP id af79cd13be357-8182b522920mr1251451085a.49.1757513748711;
        Wed, 10 Sep 2025 07:15:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5a359305sm292432785a.31.2025.09.10.07.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:15:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwLbv-00000003rnA-0eIs;
	Wed, 10 Sep 2025 11:15:47 -0300
Date: Wed, 10 Sep 2025 11:15:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	yangyicong@huawei.com, wangzhou1@hisilicon.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
Message-ID: <20250910141547.GD882933@ziepe.ca>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250902161028.GC184112@ziepe.ca>
 <f2720f17-5e81-4f69-aaf5-791b47973178@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2720f17-5e81-4f69-aaf5-791b47973178@huawei.com>

On Wed, Sep 10, 2025 at 11:20:08AM +0800, Qinxin Xia wrote:
> Ok, I see, my colleague Wang Zhou also released a version of io_ptdump
> a long time ago, which is implemented in smmu debugfs. Will recommends that
> io_ptdump be implemented in a way similar to CPU page table dump. Using
> debugfs to expose the data and using format-specific callbacks to implement
> specific data dumps, I'll talk to him about this as well.

I feel we should have a iommu subsystem debugfs and per-iommu_domain
directories to dump the page tables.

The smmu debugfs can report what iommu_domains each STE/CD is
referencing.

This also needs RCU freeing of page table levels as a locking
strategy.

Jason

