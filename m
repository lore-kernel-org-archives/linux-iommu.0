Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CEB3CB8F1
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787836243; cv=none; b=Uoyu5xbcgrCgRgGtnutQ2CynlXNDwn93OKas17hfAcBsIQH82/Mj52475yzUXlk9SURoSqdHI7OrowqOe8mdR0naVdqprDoIzRfpv5r5bHCZKpqDXsn0eL5TsInBIjhTYmiq8wsZIDWrRhyHFndSf4unhJjwc4JmiZI2B9wZAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787836243; c=relaxed/simple;
	bh=ODna5VuKF+k/H3KNl1U5Jwcfx/yL3NhPgueLFtXANYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0ZvSv+CtdiXN3cmLk2oYtMAMnU1G/t7NKi5Wvzjbn3AeGoHYROqtZA2CQEAXyCKWUK1zs+3l7fft7rbA+9qaf8lMzqQLnaW5DDBrT3Ir/h0ZCZLBmcjhtTNnndI2G3KH9DWHVfxjj+7TEQ83B1dSfne/LcUBBz2xD0rwenMFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TdV61Hvs; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TdV61Hvs"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90cc372d6b2so17859886d6.3
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787836227; x=1788441027; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ndKIThMIJu+DQfTWfwfS9UtTsZjKDkhTAUOgVWRNeBc=;
        b=TdV61HvsIbxwtFg4Lu+Ps5XvMzdWe7tWfSLxjzhpvSoNMu/aOTuRp/fFxvhfy9QJVU
         1ouD/KuhCZjP3VNuY0uU3HouYbxkjAfnlJ7e5GNr2Q55wFocVl/FJseuUn6oc+Kvgtv5
         n/mzs+Vp/4t2jzLYOG3lYdWM2LfnF7yTKZA0poaOv/igSFlir4CdaXyIVXsZ2YBTH7gH
         xpp1tGbPePYRtWZxUxqJbE5bZIO6KFOBq8/21114VYGuwPgVolVxneqQ1RPqG06kgSO+
         UFbDuA2HbHSaHuVg4WJ3oocg4YartkzTxRRePeKW/ERmIb1Xcx9AOJ/hggsMRYwW1j5j
         mAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787836227; x=1788441027;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndKIThMIJu+DQfTWfwfS9UtTsZjKDkhTAUOgVWRNeBc=;
        b=kQDBFrGoOfESDNE7sSQjEq9k0vr9RfRJ+yYQsOtRn/XHOSyul/oj9cn0YXUMWD2MaZ
         LWbTtex5GR3ggHgQ+cKUFOu6y0+tMKRM7+F7V204kJLdepr27W0QgdwJYYtK6/pybT7+
         3CDxHnRTsb4YENFGwP6ekC47DOIAxYvUpjhwLDMAFvMmurXKqSxSVpfA6WEMQRNkF0z/
         v1sfzAu5lsIBI4ob+Ada1+aRxGUjPPqBvVKw5zb4tHGEVC6yt19Jq8E37Jzsw1FrzNMJ
         fylwRiXTbwl3O5SsYRXMpLwDLaECVgtWHX4VYYeheZNGNSGU7eLjbMfpuWGKEhSBbx1n
         zcAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlM/414jRSKd1zScAUTQa8+/urZlISDNCXqASyg3MSKUsx+fpqVcAHiySMBKmzoNxd7gcJ/A==@lists.linux.dev
X-Gm-Message-State: AFuF++n2ffTcZ+FQ3Dq47E1WJnMgRfUMF1YOjJSqibB+1sFm/h+nZ6VQ
	FEzr+tcI02EIZQUr3AVdQcFE7xwI/cSKOBY7WQFA51JxUl2CDfCckU7K4u6SZwwBOuA=
X-Gm-Gg: AR+sD11vulSLWwl6WJKsXtwYDNY90EWhdCY10gkmoBArpj2pu8yF45AocDajTw/Elv9
	MeOZofhaLeUzdHOxD1bggeIdQpEdT5hfH4USPbORWqQ28wQ3jimomWfRlIjgyB53ilYKEAokupx
	DxvyuLkHICPAQXRph6Hqjm8ydy1KgDGkm0dcSSiQ1Qq4YqgBkDlIsCmcc41kuyG4TelF9GabAu4
	qYbuTp/+mrP/pYq/xUtjydPUS4rvC30Bm2/UrTnwB7VVD0VH7NiHj6+0gpFP7/QZbJU6muzde9p
	mqXTC2JImZod8OSaMnRX4RYvYRUmNkMXeCKf+J++/ERIk1Sm432LeJfjPj3eiiOV6VEln4GYSOr
	zyQ7Fjfiut0sPvmrVVajkUiwa3fG8dXt1nv/XXEOQlMLgIIILAQkesS81K5BOOKg6HDCD5DnukB
	ejSp0oqMlAaZAH37louiT847XVq/KWOzFCcFH4wq/yQ464WouDTCeYn9jvlrVinpMIAlhwLsFgs
	z5EXDjvMKXNCbG0O0JVRf/rJO9rYw2hqarauJ7b54gg2A==
X-Received: by 2002:a05:620a:40c8:b0:939:869:a8bb with SMTP id af79cd13be357-9390869b48bmr364870585a.14.1787836227038;
        Thu, 27 Aug 2026 06:10:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e30adcesm438997585a.4.2026.08.27.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:10:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wzZs9-0000000FntS-2wGs;
	Thu, 27 Aug 2026 10:10:25 -0300
Date: Thu, 27 Aug 2026 10:10:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/sva: remove iommu_sva_present flag
Message-ID: <20260827131025.GF1449020@ziepe.ca>
References: <aoq8VGFL/Mdjd/M5@hostpc>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoq8VGFL/Mdjd/M5@hostpc>

On Sun, Aug 23, 2026 at 05:24:36PM +0800, Zhaoyu Liu wrote:
> The global iommu_sva_present bool merely mirrors
> !list_empty(&iommu_sva_mms) under the same mutex. Remove it and rely
> on list_for_each_entry to handle the empty list case, which is a no-op.
> 
> Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
> ---
>  drivers/iommu/iommu-sva.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
