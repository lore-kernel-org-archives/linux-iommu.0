Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856913;
	b=N5WCg+zfxSY7ntewZBbwcw68lA914FLya1irqQIEJqh1eqzpQ7ijT2oNWJkke7s3LIqk
	 cR20JVOw7No7TKMjpnWJyxr96GQjCI1k5WXO5eWqoeTMgxrUElV1z94Wwbx4Z/v7vIYdx
	 tJTtKxEei2EilQLd77sIZpURSgK6Dp2RhP09Ma3dx0ASx2SeG45ycUS3314ROyyxjZWAh
	 GH1dzoGxNK7RHINcOCp6JYQE04CkBajcEOLLwsJ337dNAALjeMN+7vKvDZ68320M1HVeg
	 EF+jYbANVmoQICiJLK/DDiO+dsuKq62dVyiSF1EUK/4nORB3tx/CHMyTxVPC+6Yam1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5h7q3+LXSxb7tMF5mvW6Ax5wQfXmLA8ND/986/f/Oi8=;
	b=FO9WpmXi6S1BwIn/vYw4RDl3NKxC55OSxGkbXUfHkoXl2j5KcExc6GRF8aTORCVnk+BD
	 BVmhRnxqCEgwZJWzeMJHPz6u26j1EWZ+IJLJGnnA4zWdS0IhqjqTZ8vAbLksB8Mx3zHEa
	 n2iINuPyOGWiu6h8KTIHRtowsQ6jEnAydoMWf5soOGc/MUXgQbu8Sls0HpSYWMbw89GsS
	 Vd+iL0oPoNAZOGAH5L/hfRmYa6L4CISzL3F/qbnWlSUKiRA+apJASJgYg8gazKxQUcjiU
	 NhRMAYHp+5k9eO6a+v3lD9FHqLde3i80BF2ijSLw44hscIORiXEKQsrhuJimlZr3FNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WOSGAH+h;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB24606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DB24606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=WOSGAH+h
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-94961bfe1a0so175600785a.3
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794856912; x=1795461712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h7q3+LXSxb7tMF5mvW6Ax5wQfXmLA8ND/986/f/Oi8=;
        b=WOSGAH+hKeyIRoe7f8kMl+ETiczzoFN9jR5RZM+WNZl3QL/0PqdIIqjeRiwdeSkNGZ
         5OqZU1bA7Dnt7yHhdKDKNLI9NwrsQROnykVj71hyVGI0VD0cKxHOyP13wdvnmLlaG3Vw
         5IUo13J9F9a2O+p+93xjiF7TRkLjdwOVpzxzybeJBKjkmqJX4aAahEPL3sKSsHiBY1ZG
         pVCYRDEstWR/lh67LOxZkrah3U3DWOen8sETyv0jwM+eJvGsLkccXmzW5jq4wkIYpCbf
         k2DfnR29hJZ0rXLYzxxRb2vQwcWudmXoke7ICBmwsXN1t5n8axIJktIm2mcKdrP+2O3p
         bItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794856912; x=1795461712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h7q3+LXSxb7tMF5mvW6Ax5wQfXmLA8ND/986/f/Oi8=;
        b=uty+LyFHFfvYTPy64DmxfcVpkez2xF2t5gdRZ5A6bFJw0sTWd2kGykm5oIj3kHLEnG
         z+7ySxSDqJ+92zYbLVxIwPUpp8Dp6laZGqONHpyixiJpJQorI8JtRHJZULNxu0ElGuA9
         j9JMF3tytljJINnBrDfUVX8o1v6nlHOJUJlY/jyzYNwwDYg6nYifndCNRuJmh2MnKUxO
         coujWe2C38vbY/sZsdRUMjyFlPbQrTVLNIQf9EXItFlSqWk5PC26fijVzuH8zOUPCI4Y
         fT2iOhQOsHR83BrJcsuVA144B8FHwkFPONpOhbzTmqJbMAFa8ibAhQEsxoZaDgifhjJA
         x4Yg==
X-Forwarded-Encrypted: i=1; AL+hErE+ESGH1ww4YEe6dG/1oxB8fm8whBv0tUVUInv/FBJOX3BQ1p1J24Xr6bjsn9IfHOfZ3A/qMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/8icUboT8uWQTghW3ZMfaHhOf1DQZGvDi+YfZJl1KVhqBsOGR6
	AGqRzmanAivQhU6cpMWEXfm/zP/Y5mQOaDe3hjURssJtmFYPi4LFJ/hy9Yi1uOVf9ys=
X-Gm-Gg: AYBFou1JWPNNK5CA6X13H0tvdhrjU2iTdjlLYxFrhhDhh6XPW1GnRCagvKSItrLGPTx
	3pfoLdxQXYtetaN4DrXJsD/6I9VJD5vbbbTqzRBVkSHX0Gu9YWb9ae08diKCoHx1I8bawb59zRn
	hZtcpq6DjAC6xSohZB2zDuhWgcNAVMhSkWP2AXh2LG7Mx02XujOr0bjdjZN4p9fIekxA728w4qY
	x8gJLqJv+6ssA21zf07kSGTiTdtQu4HLD2yBU3CroiQW6yzT6qgapn2XurWcSF1XcKiWz2txfKY
	l8+iyyI2jZ9qtdNctppSoRo7+gQK2QxhUtfeI6DmYYZLixJ6KiNfWpYzBmfxPovNYX2ILFJZR5y
	h2bk4w4wi+fn0AdsZTVCSNGLYFm/h3ikPZ5jEDcBQgBWRT+pptWX5ceq8fm5WySSb7q60v6ZABl
	S+2IReDmvaHymgW/MwELZ7chMbCqq3RQs86RYrVp7nx17XPGKoDoQaz4wVL183P4H+Hvstt6Cec
	AXJpVHjyJz52J80W693AiXdTXdDvXSj1wvQTC5JIV5UYZ2TW2Y6L5gdQM26OKIaG9B/2MaPtQBh
	4j9N9A==
X-Received: by 2002:a05:620a:688f:b0:93f:3482:e326 with SMTP id af79cd13be357-9494bbea448mr1869030085a.42.1794856911450;
        Mon, 16 Nov 2026 11:21:51 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949627520c1sm676973085a.10.2026.11.16.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:21:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2H0-0000000AIG8-0jqn;
	Mon, 16 Nov 2026 15:21:50 -0400
Date: Mon, 16 Nov 2026 15:21:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	joerg.roedel@amd.com, dan@reactivated.net, vasant.hegde@amd.com,
	kevin.tian@intel.com, Ankit.Soni@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, guoren@kernel.org
Subject: Re: [PATCH v2] iommupt/kunit: Skip the page-table leak check on SMP
Message-ID: <20261116192150.GA2452510@ziepe.ca>
References: <20261031085536.18555-1-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031085536.18555-1-fangyu.yu@linux.alibaba.com>

On Sat, Oct 31, 2026 at 04:55:36PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> NR_SECONDARY_PAGETABLE is batched per-CPU on SMP, so the global counter
> can change as pending updates are folded, even when a test has freed all
> its page tables. Comparing the global counter before and after a test
> can therefore report a false leak. A failed teardown assertion also
> aborts cleanup, causing subsequent tests to fail because the test driver
> is still registered.
> 
> Only perform the leak-check assertion on non-SMP configurations, where
> there are no per-CPU vmstat deltas. Keep the tests and resource cleanup
> enabled on SMP without accessing MM's internal vmstat data structures.
> 
> Fixes: bc5233c0904e ("iommupt: Add a kunit test for the IOMMU implementation")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
> Changes in v2:
>   - Replace the hand-written vmstat snapshot with a non-SMP-only
>     assertion, as suggested by Jason.
> 
> Link to v1:
>   https://lore.kernel.org/linux-iommu/20261015132024.43998-1-fangyu.yu@linux.alibaba.com/
> ---
>  drivers/iommu/generic_pt/kunit_iommu_pt.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
