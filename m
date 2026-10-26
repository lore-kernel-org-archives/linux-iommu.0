Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025482;
	b=Snpoo7us3kEDh+Qyw3oGK9uWCIoYPGys+z0CTHXnMeKL/f9SNlFt454dEIj+FQ3z9DtN
	 YYOt5vl9ltF61iQcfCCd85wxALqvzM9/Af+4LgXluodWC9nPcAOGXuoHHZml6IYQMs20m
	 2E5j4wtdobQpM7TiLmj+Ad/aHHEQ9sG5mDmfNiILXVomTnt0uz6KlCvughUYdlfESL0Ks
	 iRmj+szcRL4bVjPU9D0EXGR4JRqImzImR0kK8s7hn+gX4UFL2S1kv1CU3u7w8T4eJijQP
	 7Y9P3t5oMQ+oE+lLUB2oMiWi6iKRd8KHyjYKY/8qYyWruUYgmpCbwYBIznQHoNgofqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AhMF1tBfJ8dTRfzIo3kwEYnuOUaHaCo5YpY+nl34Bcs=;
	b=2T6/TKorMwpUbk6yBiLx6HU+yTXGSnABszBBzz3PFIAy4PPUv6xPkFRfa0/wX9SXG3Sg
	 odKMudZ6mQw52Bbq4tINknIir4Mpv6HzKiWvwRbHv9PUG9Q38mVTAbKogsBrUWgO3/xDx
	 dxp34+CR3/P3vfwSzJ2YXMaiNITuXZO0TCR6jy15gJoQC55vrpre1tbLsE7Iv5OuP4nc9
	 PjglPDTlf9YZUU+fskEGdsqOGkKGaWXeSiUiIZZdK3OVhXAj0NeNzUfebErB9oChIC8/d
	 5/Hi8kkmE9/hYB37ytJLGZ5cCvw5rjz6lLeRjX5gZdcxLSaIpEMtrPXQRljnd0vL3Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jonD06ZH;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D758606A339
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 14:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D758606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jonD06ZH
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f20c3aaa5so264219685a.2
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793025481; x=1793630281; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AhMF1tBfJ8dTRfzIo3kwEYnuOUaHaCo5YpY+nl34Bcs=;
        b=jonD06ZH6l9nxl8Wv+UOtXLxZFbyo2pM06KC8CGt3YTylx8jmzGPKM+c+Wve0SGFg6
         4PI+BY5DW1BkaFoEKTCi59cQLSS41GILrlIgJBQXijSh8rKtjFzE5XwtmDSft5htP9or
         wnz9ijDnrQ1OH7LNrXHailTyDVu8uB6UKDSwD1YH4AI5Jkk35SYN9OoX9U16cVIQgSd1
         wWTs5NlFqxH5DYDvPY8Fce52DpspCwSWCcOHyOYK0Mc1ILCMWbrKlFd2CYcmz2ytHXJH
         pLXLqS80qzWcbE58kKrx7akgFy4SiYc5bnG6tO0G+tpvxi8vI0bcpsZta4aN9+oGzx6N
         s/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025481; x=1793630281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhMF1tBfJ8dTRfzIo3kwEYnuOUaHaCo5YpY+nl34Bcs=;
        b=HkUJFyASmTDwCau0g3qKb/IJ6SAYx9MaMWIb3qq0DfYg2ItBEV0+342+NfRrZCcltr
         JHuybIGQxddGB1IDPiY9LM3txQGu2nCyzRiVDyGBcjgkrzWYCiWCEFPic48ZCX2K+gxd
         4ZO5QajbriuvK9GZ+VOdhihuvAvcu8TFw9ZgyGivm8drmu9Vz0FO/CFO0g17z/UK3IVT
         1Z8ij1led7O1iERlUCE74kYrjgyd/SMccBxyxzJJNr6YSOesivaoTP5TaW16EPfPVsRh
         0jMoD/pxdjCw/qc7F9e0cukslQ9lJFTsR8M0ehv9PyzzuKVQOWpSioHyg21yR9Yr50bv
         235g==
X-Forwarded-Encrypted: i=1; AKwUvBxoYtZZ1qXzCQrIRO0pEi2coeOhArXLOLOjKWrN1HiXbO8QSv8/W7CNoaRtVvmpwW5MXPkcxg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJqGRRXyBHJ7npombaG4f8eBD7nDSU63zKEoY4JaRREpAlUWl6M
	e2twFfqW1xwmkxg/S20PKqMjizLGBc8xBleh/UI9XoAV8yHPaBHcgXFvsTBOxSnVqYc=
X-Gm-Gg: AYBFou32FfUpFic0DlBCjnCnrqv6c3hI1xhljGZyH4EuDiR8lQQQVlGaB3MMjajwQlU
	fY76IrLDh5Rm3ov4Gwdy727VHLN+5gUBiVDDD83Rw/c9crCUYun0Uz01fMQxn4KVndW+wSekVGr
	+dKxsNYqhALLUcG3oUsAuBOGewpVlfzQGnCjJP98aWHJEUKLod5o8K31oHxmJyxRddMHZ9pIYSy
	Xu2ghrOu/PxWw327HoGufcQhTz78gE09/ePlq3RoEaI8qdvA0cQPkl4IgdZcYUtVKHHD2C7YXOH
	KVfXrJfcSkz4EwjOyMR4s5s3mW3El7wD5VdmuW1mpYI+wdS50cAC54FCIWA3WnvxXDxRzpvsuM3
	14JEcsNOO6PEkVBp2JPo9cCTUh/tjy6WFicj+KjbijnHSfBiufOP7RzLGhwgPdICqBnqhFkmLbq
	ORP9SJ9t6Vs1aRRWI5/HT8pzUVMsfSeUXnjAJp1zJFtj6PEt8u6LEr6o8nz2FgxPFOtxF2z2jAa
	HWD7nDTzxeR/NI6aFZHY1AGjn6LG6rFI5X6G13OUDlAqQzCpcP2mWavUOgLOCsVpvwuePW3KYLw
	Y+vgUWDkVwkHdbzqICqewf4HY/IEVuWEgjoYqA==
X-Received: by 2002:a05:620a:6881:b0:93e:74b4:3115 with SMTP id af79cd13be357-940ef8db935mr956013785a.38.1793025480452;
        Mon, 26 Oct 2026 07:38:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067c0dasm697089185a.17.2026.10.26.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:37:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLLpm-00000007425-3W6s;
	Mon, 26 Oct 2026 11:37:58 -0300
Date: Mon, 26 Oct 2026 11:37:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Li Ximo <lixicaicai@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Wang Haoran <haoranwangsec@gmail.com>
Subject: Re: [PATCH] iommu: Guard iommu_group_first_dev() against an empty
 device list
Message-ID: <20261026143758.GA1674867@ziepe.ca>
References: <20261023065705.2854692-1-lixicaicai@gmail.com>
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
In-Reply-To: <20261023065705.2854692-1-lixicaicai@gmail.com>

On Fri, Oct 23, 2026 at 02:57:05PM +0800, Li Ximo wrote:
> From: Wang Haoran <haoranwangsec@gmail.com>
> 
> iommu_group_first_dev() calls list_first_entry(&group->devices, ...) and
> immediately dereferences the result with ->dev, without checking whether
> the group's device list is empty. list_first_entry() does not return NULL
> on an empty list: it returns container_of() applied to the list head,
> i.e. a non-NULL wild pointer pointing at &group->devices itself. Since
> "list" is at offset 0 in struct group_device, the ->dev read then lands
> on whatever struct iommu_group fields happen to follow the list head,
> yielding a garbage struct device pointer that the callers
> (__iommu_group_alloc_default_domain(), iommu_group_alloc_default_domain(),
> __iommu_attach_group(), __iommu_group_alloc_blocking_domain()) go on to
> dereference, e.g. via dev_iommu_ops() -> dev->iommu->ops, resulting in a
> page fault / kernel oops. An empty group is a legitimate end state: the
> list becomes empty when the group's last device is removed under
> group->mutex, and nothing in the helper itself prevents it from being
> called on such a group. Note that the sibling helper
> iommu_group_for_each_dev() in the same file iterates the very same list
> with the empty-safe list_for_each_entry(), which suggests the missing
> guard here is an oversight rather than a deliberate design. This
> potential issue was found during a code audit.
> 
> Fix this by making iommu_group_first_dev() return NULL when the device
> list is empty - which is the semantically correct answer for "the group
> has no devices" - and by teaching all four callers to handle NULL:
> __iommu_group_alloc_default_domain() and iommu_group_alloc_default_domain()
> return ERR_PTR(-ENODEV), while __iommu_attach_group() and
> __iommu_group_alloc_blocking_domain() return -ENODEV, consistent with the
> existing error handling in each function. Behaviour on non-empty groups
> is unchanged.
> 
> Reported-by: Wang Haoran <haoranwangsec@gmail.com>
> Reported-by: Li Ximo <lixicaicai@gmail.com>
> Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
> ---
>  drivers/iommu/iommu.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ed..5f26785bb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1386,6 +1386,8 @@ EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
>  static struct device *iommu_group_first_dev(struct iommu_group *group)
>  {
>  	lockdep_assert_held(&group->mutex);
> +	if (list_empty(&group->devices))
> +		return NULL;
>  	return list_first_entry(&group->devices, struct group_device, list)->dev;

list_first_entry_or_null()

>  }
>  
> @@ -1723,6 +1725,9 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>  	struct device *dev = iommu_group_first_dev(group);
>  	struct iommu_domain *dom;
>  
> +	if (!dev)
> +		return ERR_PTR(-ENODEV);
> +

Are any of these even possible to be called with an empty group? How?

The giant wall of text at the top failed to explain how this could
ever even happen.

Jason
