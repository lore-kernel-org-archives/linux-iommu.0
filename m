Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734592;
	b=24TWoDYoeZDIkeByRt9DHdwFtTNS3J+FcZYTvPV/60xS4aUcXmic2e9ez4bpkGaqS7mT
	 +zNVZFtRIrXMRQr7OO3E2qTQW6cYncUkryi4XMxUuERiyzSXbpDPEjA42OWuaTqi039XL
	 7joQlGbec0VNeSKo6d1ddu9ZW8mPFjA1OjjEhJ/Z6IFv5JcD6rJf9i1xyRiF2gJv0xeI/
	 PCWUtf/swJQof4TJWS3+kiawBPQd/7m1idgh9/TPrqrU6CucHumNTmIEjsgAFOfQO+5Kh
	 hAVOVAD8QsKM6E6+tS2IjPBXpAzWYa1QV978gLPIrrjqmjpWR7FeC3F5ITj7TUOpxkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uq8YUdEumE4c58BERrSl6Gv5Qqe1I7TfJJee/dW1I8E=;
	b=LBF6OVyDT3hYyNmsfZ7iM38R29nAq5IAAGVEUh6x5rhlhveOr4knrHV3GsNwOdrbQF6Q
	 xrSvtyTYVDLgwaFBiOOqUK8Kx6b1ZwsDXDoitqwQi8kZghOKYrSqg84YhAkl5HcA9fuyC
	 6O8aMQKU0SC5ImVLZHvW4wBVGUQPuiR8cqUwyIANlP65xzBhanZiXhHRMIhIrBUEeR5UF
	 gzRSSLDcTtjnMCJh9uRYZ5vOq225Q3EaiWhYD/Rpt3kgnH1F6RHRB+Q56FcUcwqNxmIZm
	 eK1yJ6Hr9tCzP+OX7DCXZSKwbQ31batlRjjEbe0riWk019ixIcuHN6qxAi3E02M+9EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="LQ3zV/RU";
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A16606A31B
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 19:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A16606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LQ3zV/RU
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-930c0f9c1b1so464138785a.1
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793734590; x=1794339390; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uq8YUdEumE4c58BERrSl6Gv5Qqe1I7TfJJee/dW1I8E=;
        b=LQ3zV/RU1Rc5WbcAq1oVHFbXusRHzOLxK4aUQlD0EDf6UfqBK7cEWpda347K0Aa2HW
         WxCQ6rK66IR+CkM1/epQMajcRVbJ6bxmELe2IXq4AqPTXLxg6F9EUg029p0JqduwQRud
         jdn/Qiv+Gn6ngpFQ6K7v48g6GfXYTVyVEevWEPhuCMzYf5yneFsz3sdYkEpriLHDcDuR
         uu3qL3JrFFC+yoWD5tlsig0z5dyo2f4IO1SH1dQJ+hdkhZRRIYBWqhdZlZWk32rLhjQ2
         f6FamM12tQ/K/XOzjmUqC4JfwmD5NWeO5KeASSDCRyJ2sETFaQ2XsuDmVxlFiZt2MHYq
         BW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734590; x=1794339390;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uq8YUdEumE4c58BERrSl6Gv5Qqe1I7TfJJee/dW1I8E=;
        b=02ntLvkwcC41l+6Szp6vMLSY+dOH8TxXI2gOqFj5nGSyXrPjp2KZh4iPvuI41l9xRe
         lrXF1bo9KhPIz1IZ48YH5yvg8/fE0UTAb8U2qdl30YMg8yR2n+V6FPUtUhD5+8gWIbz5
         oUx1uVdDbGcwm8y19RU6TPKl7WXZHbXMfaBeFv6thBq9ryJTWc0BLGl060lqgZjUPd55
         Nk6xnzLmnVy/u5BOqRwqCe4wWAPd7hzEDEpRgZgacJlTDTUZNZWj0j98mSiJgQF+abG3
         Cu9rdhCxgZaHmrXBZEqnBiQieQpdzgF4YoyXN3LjyXO6agq56gPCb3wXXJRpjU+81sIe
         CudQ==
X-Forwarded-Encrypted: i=1; AKwUvByj0EiIgHElwOVWYff1mBgJdVxWlS7RiMt9jvm7DgVuWATGXxQtHZ2hmuOHceuIHJszH8MKRw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sIM5ejVLJ1t6XR8TOutGz7Ra5H/NjL86+WqTdYfTprluUfwBW
	hacH+RUvqcR3mmgVeLGsHXmlI+9iPVVrGaj26N+98O/cQTz6A9H/BOvj98x1UQTOrGU=
X-Gm-Gg: AYBFou138bWuhK4aJyE0+aLvfLSl7m7hM2taw20EtC8xDqrLpJuu+mwy72bskMlYbrh
	3d7Wxg2vCaO/vsfm7mCsktOKL+j8fmOyTvzGSV0JmkPxN8l/MhX+Wyu6Zvl1E0SHVBeLVP1VsfG
	TzRkNu0B8q9oiaWu/ONK1BNYxkSN1sGTPmG1L2Z7U6v7Sv8ii3g2vPm1NbB33/iC1GfQMIHcjRU
	BXQCuIlq6e0BYTAVKlMOcuDyz6w/jdEJHpwQyR6LSjFYzV+87z5xbCUSKdupJxv7VS2SSv5BLjI
	3yy+oFG8r98iq2qmQZGcKAdxOONzQ0BGRcAU4B27h4j3TIL78pcnN/Hfcji7V2Sy2Mnhm5mhFmZ
	+zgq9/Nfel+licmBENH9V0aDttFXOjrTj/F+pcf8ovWMkXR26pgpLWnw958v5SefG7caaeDvC8c
	9NPiwEyxA2jr0wDtNnwvFSccBwjV8mryWAPjtvkC1g6qqTLnTy3LviicoOJoOzHcsRC5kPi4+zw
	Jv8e8U2qzcajRm6FY9yPgTKopjU/Hb93/PyGBP4mfkmES5L51GdEjZ5jeQSilYfUgxhu0SXBpn6
	svY7Zo5Jethzve2CHf1B00KuQPDLBLC1mX8RjNILspgFECdO82kmeHci2zmeArrEsibHV319h6+
	EpT0o9M9kKw==
X-Received: by 2002:a05:620a:8013:b0:93c:2726:77ec with SMTP id af79cd13be357-944214cba5emr2106461085a.5.1793734590511;
        Tue, 03 Nov 2026 11:36:30 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4852ba3sm9839685a.31.2026.11.03.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:36:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOKJ3-0000000Dn4k-1aHz;
	Tue, 03 Nov 2026 15:36:29 -0400
Date: Tue, 3 Nov 2026 15:36:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean-Philippe Brucker <jpb@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd: copy to and from folios in batch_rw()
Message-ID: <20261103193629.GO3889730@ziepe.ca>
References: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
 <20261031-iommufd-folio-dirty-v1-2-2cef66d2d6d1@columbia.edu>
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
In-Reply-To: <20261031-iommufd-folio-dirty-v1-2-2cef66d2d6d1@columbia.edu>

On Sat, Oct 31, 2026 at 04:33:19PM -0400, Tal Zussman wrote:
> batch_rw() copies one page at a time and, for writes, dirties each page
> with set_page_dirty_lock(). Walk the pfn batch a folio at a time
> instead, copying with memcpy_to_folio() and memcpy_from_folio() and
> marking each folio dirty once. Convert the single-page copy in
> iopt_pages_rw_page() to the same helper.
> 
> iopt_pages_rw_access() rejects dmabuf pages, so only pinned user memory
> and memfd pages can reach batch_rw(), and those are always folios.
> 
> memcpy_to_folio() also flushes the dcache after the write, which the
> open-coded memcpy() didn't.
> 
> This removes the last use of set_page_dirty_lock() in iommufd.
> 
> With ftrace timing iopt_pages_rw_slow() through the mock driver on a
> non-debug kernel, slow-path writes to THP-backed pages drop from ~1310 to
> ~930 ns/page (now the same cost as a read), and writes to 4K folios drop
> ~9%.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  drivers/iommu/iommufd/pages.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)

This looks reasonable to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
