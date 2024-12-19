Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B592594
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607390; cv=none; b=kFTeviL+wQRo3A7dYrb5VLAJErjovuxEK24Jw915XRr9mWQjII68s+K0mJ+7VBW4qZ5l8RzRLoFYL+74ywYQg6wobpV+zswKf5b4Voi49wlma6ScacZeEz8xA5DkDbZnhOR75wOva04qr3u2h3F0tvHCduHYF+fWwu57OIZQUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607390; c=relaxed/simple;
	bh=4zgfT7Xg+JQmuyr3IdhaXo3BVOo4fRBTlxoKmbMDBiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVHcyW3mctNfKd0zklslfvCVCozgnK00Aag+QGz/EPZrWQezLjGkBSObSHPojP4RS07aMZUU4aOoRlobuLhjAj4YJvx25q8BBe3eUfWENsfWIN9FAULv+434dA742kju5HDh4LPLqH7/kEU03+NYEIJoETi29SrRMiVNy5Vupiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lW9dw0gJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lW9dw0gJ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aabfb33aff8so127751166b.0
        for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 03:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734607387; x=1735212187; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNoCLTk5PLrDllVxHnAKqOI/0xe6p3W8/JGr5L06//I=;
        b=lW9dw0gJ+ZtMhbq43uayXZBHkNauVkujzzy/dMpLd4MdZdCIvXgHZwi2jbkO070PjB
         xPwatqR7tsntpfR12vR57Xvmf7cag+CCN1m61/j45+Na/lRbwHbvPvJs6mnD+qGX4aU3
         XtN2bwvCEK6zKM01AU61VDXZrgmkP9LhoNqa+olTfguPXUbdynuHrEXMkC3c7iHeajKG
         5B48zmAZ76KMh4nIX9VHY/mlcHP3SPCdsAi69JGf+ln1dKTXjp+4JHKcs7D8Or1qPYFE
         3RY888/kD8xQ5OnH+LSRR41BWUYMc+h1QMNKzHuIUUtLMgZGGQ+Idf33wduf0yd94ImO
         IJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734607387; x=1735212187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNoCLTk5PLrDllVxHnAKqOI/0xe6p3W8/JGr5L06//I=;
        b=dCn7zMZAgDRx2SoCHbIkTslb8SIPUTNEvvUaJwlUUZtd6QOyTGphBeV6g55ZARVH1r
         CZpBPmvXEBKq4v8mZDKmoGwLx51Irp3x0DJVH5itLfufRTsxjBk6jGneQY3a3jv+Vk5S
         5ri1qs351XArJSrmxX1ZMDDGjF1CVWix2MOZfLl7MClrPO5vCyo1NlCgAvoIV90ixGgu
         yhtb87mCCgIKDFsB2qL8+qynnP0eEbI8vGD/n4ERY4h2xGv88oPZ2H7G8QXfFkGeCgY/
         uAeMqnarNpNkgVoG7WCjYsseDz58L2YP7DfOl0ECNGLSJP9h/EDCfvXrpK+ksFGzFGeL
         mq+w==
X-Gm-Message-State: AOJu0Yw8II5jYRorSxVPAAx0vs45bFYgzs9LnumCARTTowUOVGSRlTTq
	Hjxt/AhRIqbiHw0WEU+S5Y1OK/Xce5eB3SpLu7VwmNBYURMDbdrgf+c05NxYKYqIymj3LA+LhYJ
	fHw==
X-Gm-Gg: ASbGncvy4eh8Oqp2BxT7CmrED8Ie1JRzDqYYn/2O7fSqJ8dFaxhRBqy1FfsV/GZ897e
	7OD7Q80e5IptnhQbr+SOQbYT0lO4hp/rWWUu5geZzgym/G7lN9Bmjm1O2lTuxdSLO+lUU53JjRd
	TSULe6n8uFepQk4mWlObmTniXPC8Ih2W7l66Z8qr2405NuZq7OClb2JE3T4sQ7wlVmQh0mVWm4K
	5NtVAe4Q3ZaP3aGw2xOOaZcpnAfPOQZiTe0Ymdh96E8X9Acl+bM4TeYlMBcnRUPceyuklobHp8x
	mOuoKNpNpdlIP80=
X-Google-Smtp-Source: AGHT+IGBbkrBT1+E3hcflKVgebxmfU7Se8YKjT9HtDdCtUo3a97FGuUSH0zyshOzjTlEgkesB5a4qg==
X-Received: by 2002:a17:907:9615:b0:a9a:6c41:50a8 with SMTP id a640c23a62f3a-aac08155183mr234984166b.17.1734607387303;
        Thu, 19 Dec 2024 03:23:07 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f31bsm54976666b.1.2024.12.19.03.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:23:06 -0800 (PST)
Date: Thu, 19 Dec 2024 11:23:04 +0000
From: Quentin Perret <qperret@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org,
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, vdonnefort@google.com, tabba@google.com,
	danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 12/58] KVM: arm64: Add __pkvm_{use, unuse}_dma()
Message-ID: <Z2QCGFN5V41Vux6Z@google.com>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212180423.1578358-13-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212180423.1578358-13-smostafa@google.com>

On Thursday 12 Dec 2024 at 18:03:36 (+0000), Mostafa Saleh wrote:
> +int __pkvm_host_unuse_dma(phys_addr_t phys_addr, size_t size)
> +{
> +	int i;
> +	size_t nr_pages = size >> PAGE_SHIFT;
> +
> +	if (WARN_ON(!PAGE_ALIGNED(phys_addr | size)))
> +		return -EINVAL;
> +
> +	host_lock_component();
> +	if (!range_is_memory(phys_addr, phys_addr + size))
> +		goto out_ret;

Nit: I think you can do this out of the critical section -- the memblock
list is guaranteed stable by construction.

> +	/*
> +	 * We end up here after the caller successfully unmapped the page from
> +	 * the IOMMU table. Which means that a ref is held, the page is shared
> +	 * in the host s2, there can be no failure.
> +	 */
> +	for (i = 0; i < nr_pages; i++)
> +		__pkvm_host_unuse_dma_page(phys_addr + i * PAGE_SIZE);
> +
> +out_ret:
> +	host_unlock_component();
> +	return 0;
> +}
> +
>  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
>  			    enum kvm_pgtable_prot prot)
>  {
> -- 
> 2.47.0.338.g60cca15819-goog
> 
