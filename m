Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B51B2193
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877055; cv=none; b=ucl7XI1egGkoUtMUc+gUg+oeJ18TSM9zSRC3mRX86erBJzo3GdLPC/hBq9r/ybt8wJRxmz9u8GFtNqQHvNXy1vLF+QpOOa1oDISNSapmYW8KqIhH0a93AYCm5BykC9OKPMsVQv5YHkvTg179MVhIwYnHIIN7t9a/XdIcSjKjJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877055; c=relaxed/simple;
	bh=jhiLPLQ5EHJGFM5RBiKmAhzce5B9e4PtmrKhVR6E/dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc5ICxZ+IxIIZq1pPPXdXy6D/eEfAG9i284ZbXPZMN/eDm5+7PFUh/5uVTQ4VusXz3tcx63+PX3c1A5pqCMh8KcfLVY6uNYvhBYem0YY/X0EMCvAqNBGDJGUCK8d79PgOSbR+ko9kDTBH5yGF8lick0XzAWQOiyD9yhhqncWX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ljg7Fut6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ljg7Fut6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6f75f61f9so805004485a.0
        for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 09:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1736877053; x=1737481853; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mHlM1K+9X8sxV3MK2j7gYZulmWvrxq73m0lB+iLJ+0=;
        b=ljg7Fut6ZbwEWRsPSN4URFh7Q/Oi89UI7zgQiChO6KSmZkFfVWuMwrOI21ic7YPWo5
         SPYvHehC1hFgKC5UawscDhbXSO4z6uK7Mis6POFVBwVgcZ2jurwHfp/11VnXZs4FKFZR
         AJwQrt0uh1x/S6dwKMH9PLGaszOBAnJWf5Abru+dXY0xc89ze1t6W5HVKVKTUDto8sI8
         TUjsy7M+saw0hSr/wswOxRKdWz0hgYL2QyMxMeVy7e4nmaUZ0it7WFNfh/gmEA3xBYRB
         IoSwo1frg4/mYxMv9tBN1fFzTcacRsJm0ICfWD/eWKJ/oexq6S8x/teIuLIAxn7pSc/w
         VuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736877053; x=1737481853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mHlM1K+9X8sxV3MK2j7gYZulmWvrxq73m0lB+iLJ+0=;
        b=QNsXghzADNO95vkBQJ0GWbmAvwheFGyKN0S6gX/lYCNJJZAqvH/QM9sM3HBmenPtwz
         xRPfKW+ZNPejsDS7pb6yQXGDVCTtonCg2ld+GXh3fNWwAjkp+qVeRRjkH0kpLIohYgjs
         lTnuz0jtiN6tsFqFpseK5eECuZSPkgMeJV8bGv8cWyNJCXOzxEQqwr6uLKnWEyl2oetp
         S0EYoxbvTuH7vCjyEoGaizqBmKg5WJI8oRiEXUX2N9evF0CThU/WtepdMhh6VCj01V4u
         8EfXJ2RoMyjrX5AvuvENDJn8WqqeYCT+Kj4+W8sw+F59aVeH+r/1gtZDT2ox4kuNFlLv
         x/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1uETRDCuIisjIbcY69E9dGrga1OI8NJHnoidwPMI7mplxUax+zdHZH1/K7bRaI2mgdkruww==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFNqt4d7ilqAll2EnGq6kd+pCTbRkWVMCW7WTJHE2kgM8HwWtJ
	B23CkB3atBfuiQARwRCxP+/7xcOjrKmbB/a1M55w9h+m6MiQ/NUlpsuYUVVZ0wc=
X-Gm-Gg: ASbGncusrJen0Axpm1Tnn59NarytQeLzQRwKFsLydt5UumjAztNRQLHeK4r2soUPTiO
	Rwx08EagQLVHNPpwMCsZhD0oH1F2zVvkW6k8Ghb9ajHyXW8MpsqsU+Gsv5MX+/W0oyS5w+T6Ovh
	h5sFPt5zgdsgZbMpnt7Rsmx4t2odtGwC0XMKSgCY8aPGrLmP+dKcFceGAecvZ+Cy18KtR+0mJ+T
	ylF0ZklTSaY/VDRs+pElqpydh70qD6ed8IeaGfZXyOAgm430y7RQBe68gpIHNULKv2ymZgsmsbS
	uldByxLLlx8rBhyvuulXx/fBsU2R2w==
X-Google-Smtp-Source: AGHT+IGcnjBYqccjRvfVMLpLXB6dxkCIiAPDhGAFKgZ2fyt68V+DVumq+1hNAC2/fAhif9tRhJg70Q==
X-Received: by 2002:a05:620a:4102:b0:7b7:106a:19a8 with SMTP id af79cd13be357-7bcd973eed6mr4268570385a.22.1736877052733;
        Tue, 14 Jan 2025 09:50:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce327b8besm626661385a.59.2025.01.14.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:50:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tXl3z-00000002P4E-30HE;
	Tue, 14 Jan 2025 13:50:51 -0400
Date: Tue, 14 Jan 2025 13:50:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommu: iommufd: fix WARNING in iommufd_device_unbind
Message-ID: <20250114175051.GN26854@ziepe.ca>
References: <20241123195900.3176-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123195900.3176-1-surajsonawane0215@gmail.com>

On Sun, Nov 24, 2024 at 01:29:00AM +0530, Suraj Sonawane wrote:
> Fix an issue detected by syzbot:
> WARNING in iommufd_device_unbind
> iommufd: Time out waiting for iommufd object to become free
> 
> Resolve a warning in iommufd_device_unbind caused by a
> timeout while waiting for the shortterm_users reference
> count to reach zero. The existing 10-second timeout is
> insufficient in some scenarios, resulting in failures
> and the following warning:
> 
> WARNING in iommufd_device_unbind
> iommufd: Time out waiting for iommufd object to become free
> 
> Increase the timeout in iommufd_object_dec_wait_shortterm
> from 10 seconds to 12 seconds (msecs_to_jiffies(12000))
> to allow sufficient time for the reference count to drop
> to zero. This change prevents premature timeouts and reduces
> the likelihood of warnings during iommufd_device_unbind.
> 
> The fix has been tested and validated by syzbot. This patch
> closes the bug reported at the following syzkaller link.
> 
> 
> Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com 
> Closes: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db 
> Tested-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com 
> Fixes: 6f9c4d8c468c ("iommufd: Do not UAF during iommufd_put_object") 
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
>  drivers/iommu/iommufd/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've taken this but I increased the timeout to 60s, which is similar
to other such timeouts in the kernel

Though I do wonder what syzkaller has done to hit this..

Thanks,
Jason
