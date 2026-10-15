Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3363DDDDB
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108444; cv=none; b=PmJVKmg8/ZT2nQtf5pJHW+ygxSpaoumwHCvTyQq1X9cmrO+WjFZr7NLCHRVIkYeyiAni6gNPjcWS1xkrX4md5X9DznJGV0QiRyb2XPtUcZYki0kGH3FLApOtgP3VWwJOI6HuQrnACK6WmtttRph+9bAiKgiTLeAQx9uakPQFCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108444; c=relaxed/simple;
	bh=O9I7s0SiZTNmPSjPh1Npkb7UZEefmXjtj9RzEUi5lqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuLSKefbp5XfIckJkeT95O+3U2/OF5D4GFwuaa9MHdqcOaeUtZGnqwOylQFfVUvs2hmicibGutn8WDUOIYfxGlK28et7p40XJR+ldjHDVxj+g7NZX0mx779uVjJl5F5eZlN1HlnV4TvNxsqmig8S9wp+7MtEjGnyD+sILyzVXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EfjaWZsW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EfjaWZsW"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93efc0452b5so144949185a.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 16:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792108442; x=1792713242; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WmHIZZgl56SndGmE7ZHoozI3Bjh3H3Lm9ikaXzIGcaI=;
        b=EfjaWZsW68iaFUYLaLxmDVagbbAzAHW0RBZ0dD7WuUKEOcKja9Big9vyULqOEiAIWe
         as8E0y7vM+bZHOBSf+Z0dWiVzf+MPPU0ztK87BMK8Z99zJFwgCDHPyiC47hTwgcVVIol
         vYgC1dsV0PiBNRVK0zr4d6ppkqGU0G3E8nB/qk6cbPdYUve59hgFcLYF93D11/QFSxQh
         Um4jz7xsiH9U1ym60vgJwX34izsTheJ6KPjAm3BCdivq8uy39cDQTLaS/l6WhmUiesRC
         nTCW5Sth+/FZrmHJunjAudrkwbaY1l0DjUcT9ohUNjsjIta5/9ZgJ0cqv7+r49rt3nMK
         qPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792108442; x=1792713242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmHIZZgl56SndGmE7ZHoozI3Bjh3H3Lm9ikaXzIGcaI=;
        b=MMQMJriD1yX/6w2kYKgjshpho8NOzlbue6y5cZT8zS/6NZo9pTNppLVfGQssvmJZy+
         37vKqcX46G26D5lXNjkGcYoKWa5NkpLgTt9h/i0eiqM5C5Iqh7+zr7xONWeOfR7KHoXl
         5ZuDXhQ3F/YCTbdqhvUEwTNIfTrPaoGPEoYFN6Ifdy365S3OXLgH+pN5mhj2YQI8b6QM
         Dqv2UfzZFe0ezkuOzyr9Xt8ScqUGdEtEC9B0wFYqLFpG6fpYrjX0Ds3eu6xWFqpE6r+3
         niCDBkOKRAdMV9Q2YRgHTcaQe4MVNeWnrjrvQHH5iQCRWYuGo0HMgvgwFEN/DM9e4Z8E
         XwGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPXBARlU0tdMSuAp9pEofFJHGhFAahrJuNn4QRy45S3CnkMaKEdZXPL+uOEmNcIOBJmGhvSQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ4O5VtUXmXpWZrrePq7f2iGrqcObKSn7DOhdkmUCbK724hbleE
	RuTDnf33FyZHZ819kRXn3+HdHMTXxqRtD6D5WslWEYgYyRdUBnCxbfJLj7aQNJRwpXA=
X-Gm-Gg: AYBFou22SHy87YdzQ8OaYc0U8ZnG7dndsN/Uq/Rv2b/WTfUezq3K9jfWzURUwFdGm0s
	E+9t0pJ7WFBh34qok0/1hbe/b+PoL6VzOgjcV73FviRrTwOeHD+iG02E5oOnGUKwoMzK0nrkTyY
	Q/k/S9V9p+fmmQb6wRqPCYgdRo8qmroeErMbMy6C19mleTxgSZzHYmoQ5IX46EsIJynfQCPtIZF
	0eqTGfLUKIW8NKEM76qbSvefX1Yd1uFaxCdml0Tg+2+jlruSJ8WljJIhBQnvs+LWFyh4dAyfGeQ
	6qpTYSK4o8wL9klPALBYUgF6XIDgcDMjXQ99KYTaE0KjsIIGjRaN0nQ3eixQ+s3YBdIOjLQULJs
	WmX06MWzLE4OzlnMMRUbPjqCM2PAVjdjrmktXNQZoN2HTGTuBLWNu3nub6Lsfp2sK9nTBm1svkr
	/JgTBOnWNPdD0GuPj6r8Ro7EXVn/DwMKriFSWFYxxUotHR/hWiOJRzBcUehNg3F0BTBxdnIs2UE
	Sd7yLUQbkVXwSUNTUBfUYXAIb5XQVdxJA/4jKaBrgGY95/XCO9u7CH99V6Tk43VCrI=
X-Received: by 2002:a05:620a:6086:b0:93c:b7f3:9f5b with SMTP id af79cd13be357-93ebd24cda0mr3455302785a.45.1792108442214;
        Thu, 15 Oct 2026 16:54:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a19bb32sm62233685a.33.2026.10.15.16.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:54:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHVGq-00000000GRr-1dQk;
	Thu, 15 Oct 2026 20:54:00 -0300
Date: Thu, 15 Oct 2026 20:54:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Zhao Qingye <zhao.qingye@sanechips.com.cn>,
	Gong Shuai <gsh517025@gmail.com>
Subject: Re: [RFC PATCH 02/12] iommufd: Add RISC-V IOMMU hwpt and vIOMMU types
Message-ID: <20261015235400.GZ14213@ziepe.ca>
References: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
 <20261015065232.604503-3-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015065232.604503-3-gong.shuai@sanechips.com.cn>

On Thu, Oct 15, 2026 at 02:52:22PM +0800, Gong Shuai wrote:

> +/**
> + * struct iommu_hwpt_riscv - RISC-V IOMMU stage-1 page table data
> + *			     (IOMMU_HWPT_DATA_RISCV_S1)
> + * @tc: Guest device context translation control
> + * @iosatp: Guest device context stage-1 root page table pointer
> + */
> +struct iommu_hwpt_riscv {
> +	__aligned_u64 tc;
> +	__aligned_u64 iosatp;
> +};

Like the others you need a spec reference explaining exactly what
these fields are.

Usually it should be the entire guest structure, is it only 16 bytes?

But this looks broadly right otherwise

Jason
