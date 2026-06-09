Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8A3EB0E0
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027556; cv=none; b=mUyT6LoV/Ct/zq4rvplm4/hUHP/+V05WYhz60Jg9IanrcbwwwHrLcQRGldTY0/szEqFAOr3o/BKJrDFhL543L8uX3NEYwpl45gDk8QXUQU2fbm5M/QHn2QaTP7LywE51PRnaNs3o0r6vp0MoBl0TVgludBc+gq8PFuzd+YacszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027556; c=relaxed/simple;
	bh=Ac013OJzAwVej+OVP2LZCtn5OfbQt2Qvy1YCJyc+Jxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEWu8YLFuSEa+Uit1DkctBJ2faX5oTdatqW+aC8lQG2D4NSeQoATPvEKlwWAxdO5gqOQdUbfhsWMXtnDonovqRSeLczoGnzsi2bqrwW8C21t8GD3NF831C/yuoynizJ0WIuB8bdxY4ZcfjN6D0rzbi3rAh5BxV21IwRUYT/ud84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DMz4SmfZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DMz4SmfZ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9df4732cso59972046d6.1
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781027553; x=1781632353; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz1mWQA0X5bITct5GpKOKK787oK9AjLeNSvrgnb5Vlk=;
        b=DMz4SmfZgz4wxndB4fglpmCaEwvuIVdzhIBG/uK72S/KEaptl5hWNq9f4HdiqIg0+v
         MVWq+Q9ic2tmjlAtmJWeXpCm+5+ikIc0IGmI58fEdwOrFv8hHvGfAjgtJ+K/RqOViv7t
         8gvL4gTwaiJwzeflH9XNxxo4CjXJVcty+z6QdaRLODVwKw8e+Sron4Y1pGZv4E9t8ew8
         3qHz0nHVwKMCXUuHAFNo1d2qeURR0kwDoOszB4sIVmPJ8EXDMnjGapu1gYI0pmIlpaqd
         xXwy7Xc++fdFVWqDUz28sWGDPQW9LGsDW9r2ofKjoR/qcpd1EoiuySROFa549ij4MxWL
         VC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027553; x=1781632353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz1mWQA0X5bITct5GpKOKK787oK9AjLeNSvrgnb5Vlk=;
        b=cX2rldYJjxdJBtCI81A8NbZ4+WsfkJuigcq0l9hugDnV/sQJrdfww0c1Li8jpHPyEE
         tpMWuOqYIYKxJAFsZ/BSrtjyMWMsWe3GC0/u6CoY2cjNKsurV6PAZw8GfpFr9Y2b9ssn
         DpjYSfKgF1t0opfuuNfCSjdhAaUx4h854oaC/PTx4e9SMdUL/XTpxNZgyTFqTEjgaRbe
         jAjFEgYKKp3gG4H6lFzxDGKTKwBINj1M1LucM8dswj5fglbzP5dmo/KN8zUK+2ahzqQk
         ocTSXdOFgR0hWW4Th25Nj5K1mpDAGER/qDiy2as/LYn0io6hhH0QcrQ9hWe037y55XAl
         BVVg==
X-Forwarded-Encrypted: i=1; AFNElJ9EUueJKW2To7nDrnNjvYtcYL0BNU3qgNJkCNwk7wJD5AH9ZKPJssoq00bNUo3hVl3XnYIB4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHjxVwTnsI4yUyiAhYfOVRL0miFa9Lo0qLa/toneilbnJ1o1wm
	Eo+BsE7bK6LCnbBLLCJoKsDeK+gluflLwrT6kbL7c1DvA5dQMmcQE6LdK5HnOv01VfQ=
X-Gm-Gg: Acq92OHrlHS7owOElx2wX4DqkTSNnWhvisjTYzoJTCH2htpPy5uTYUe+2QIRMmD1m48
	2UBoRdi8gPo9TkZ7WjhxoP9VGGV6vbCcVFjHpYPJC7NA+OWOcN43WvaqDWhMmWw2qL8anaxXI2Y
	aKXf235MmIZW9wbsu2e9Pk3oUR7oo+nw4k4W3O4wlqpkNcL5ClXnzMQ8XdWRfijXZBDr004bOi6
	0LDUirE1FoJg+9l/3CaXtLhiIjGXMC9FgOJuOnxIMtRf4I1rVV5Iw5Cwv1XySU5y878n6AdEheu
	CP8BEK0PZEQXb70NDcEIlXR/p7CVOuuUwsNPK/ymSp/vMyGofahQYzCncjy1AiGMlrHr2nG/7HM
	pwljXicV2fr42d44VgaYiQ1DDYqFsqiW1CjUdDQg6w01SMrPY5aY7wWxY6PLQvhAnwh9lsSzg7p
	u2VnD35N7R/BqY037YT2SmI8IcJ5CyqlHzmdXN6ZYpkw6bvytBuXN/pSf8n1W8vpqw8vQ62u72F
	hvcEw1nvrIAV9JqPxaOdox6H5c=
X-Received: by 2002:a05:622a:58cf:b0:517:5b79:c109 with SMTP id d75a77b69052e-51795ba35f0mr289094861cf.56.1781027552939;
        Tue, 09 Jun 2026 10:52:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd053032sm216490686d6.24.2026.06.09.10.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:52:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wX0cp-00000002Lrp-3o9X;
	Tue, 09 Jun 2026 14:52:31 -0300
Date: Tue, 9 Jun 2026 14:52:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"open list:IOMMUFD" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/iommufd: avoid selftest dirty bitmap size wrap
Message-ID: <20260609175231.GN2764304@ziepe.ca>
References: <20260609005517.1241471.82360db24575.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609005517.1241471.82360db24575.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>

On Tue, Jun 09, 2026 at 12:55:18AM +0000, Samuel Moelius wrote:
> IOMMU_TEST_OP_DIRTY sizes its temporary dirty bitmap from
> length / page_size.  Very large selftest ranges can make the
> DIV_ROUND_UP() additions wrap before allocation, producing a
> zero-length allocation while the later test_bit() loop still walks the
> original number of bits.
> 
> Reject bitmap sizes whose byte or unsigned-long counts cannot be
> computed without overflow, and use array_size() for the allocation.
> 
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index af07c642a526..08c36d9ba3e4 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -1685,8 +1685,9 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
>  			      unsigned long page_size, void __user *uptr,
>  			      u32 flags)
>  {
> -	unsigned long i, max;
>  	struct iommu_test_cmd *cmd = ucmd->cmd;
> +	unsigned long i, max, nr_bytes;
> +	unsigned long nr_longs;
>  	struct iommufd_hw_pagetable *hwpt;
>  	struct mock_iommu_domain *mock;
>  	int rc, count = 0;
> @@ -1706,14 +1707,22 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
>  	}
>  
>  	max = length / page_size;
> -	tmp = kvzalloc(DIV_ROUND_UP(max, BITS_PER_LONG) * sizeof(unsigned long),
> +	if (check_add_overflow(max, BITS_PER_LONG - 1, &nr_longs) ||
> +	    check_add_overflow(max, BITS_PER_BYTE - 1, &nr_bytes)) {

We can just limit length to something, it isn't like this:

> +	tmp = kvzalloc(array_size(nr_longs, sizeof(unsigned long)),
>  		       GFP_KERNEL_ACCOUNT);
>  	if (!tmp) {

Will work with big numbers anyhow.

I suggest length > SZ_16M * page_size with a check mul overflow

Jason
