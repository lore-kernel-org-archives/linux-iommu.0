Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0343F8AF
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037821; cv=none; b=PY77K2YTw0XiHre0+9rZKkvkxS5gRVHKl12qsZP+He8xU06z0UtqzfcAJLEiWHmXvdrHnUZU81YEPIlcoh9BcNoYzVoqbeU3nPmyw65MKYBHqH+kyUqMRvtd42QC88EFrRjyD+c50i9flg9e9729WWJl7FvbWCJyQ7PuBQnXBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037821; c=relaxed/simple;
	bh=x7vkr5xuv03n5zI2/6X6/P9TOOIWoiQal4W8kv8GZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4+qq4LJJJVZVJWPlar0fpMQVdZJYr1g1RwYOj4ULNCkdqMarFe9eJKhFiCHV2/5TsGcT38Ip7g8Ys3UJBp48qfyd0XCK7oZL6VCE65/fAr/wkgZnEfXwPTMIF7mSZZpf8MXW6qabA6vrfTcuM6kP6B1bSnExrXrdNQEyAUglos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UZShKBK9; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UZShKBK9"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a376ad8fc0so1457418eaf.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784037817; x=1784642617; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lIWNtYbjtsZ0PQI9/iIL6fWurRq5Hy1V2922aR85kK4=;
        b=UZShKBK9bk4MD4T51haZYkeiipCd9dtgLB6fjkP1OwpP3etEsHQxgf/kYFt1TRRE6d
         t4uo1nhSl6M32VYoql/G95d9YhGE8OlAbjPxFsYIDkTs+ebNAsd6MKmk1FS31NYFg3vR
         lDkMZd6346tVm/CTO8xDlgoEMbHAbKJWgGadKWgpODwukP7uFtHlG/LdYdhGKyLZYlUX
         d6po7nMiABfwsPkdt+vupudToe4ldQdvpVhCTfE3IzK8gFtTdO5lcTJxnk85D8af3E8S
         VHhsia/n3371Vq6dW2QQtnspzH2ogg/cv/mBRYshPTzvabyzO3o843c919LfMM0cbhzf
         mmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784037817; x=1784642617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lIWNtYbjtsZ0PQI9/iIL6fWurRq5Hy1V2922aR85kK4=;
        b=QsHA3hZPz27/Dh9wM3hKkW/0nHRQvgUw8Y6CzXJuicnDS87mn5YQrxXfTdl7G26bik
         WixCBfdV/Rjnzboc0iCco/h0zaFSjPVCKzlTWD2vsHNC0z1p37HqLsg66QN3wk3lDCj/
         4CfF/yeAHicifTtf8PxZmGfNxvKpto4LjHnHwd6nG8wzrYVY6M3Z4UeboUAxgrt+3XGJ
         nKuhHA4TdnwjseJVuznPHNIu8fCtZJAjsFY0PgzWqRou5GEAXodJhqTmxOb15zS6xz8/
         WCq/Mk7YQkkTyUsYWDxE+nC/0dnXCqmo85mYfDF/Tl+4Zb5jhOZ+T2ac/o2Sli40YLQa
         928g==
X-Forwarded-Encrypted: i=1; AFNElJ89fobYXF3K3iPilqJ50STuFnuuzcQakQLsTTOSVXqvVMMQ4WMbgK4L7cUq/GtRUP71Z4vM2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOe2syUQ0StSkPR4lBCtyakczNXFh0uwP0eCZkUNbRRRJJEL/D
	W8A2tm0ZNThIjiHvrjkcG4nIHrza9fdTxqgznqo5euLpyTOWXEty+Hnd9x/gzlf5Qlw=
X-Gm-Gg: AfdE7cmNCRRFm16xtYX+i6mZ0e1t+XvOt72S/FFN/EoZhrrhpQ2e41D5qIAsNvCfu1A
	SR4RhJhxNJ8/7yrw0KE38raoC5tDg+R8I6r1GNzgKggxiCNz0rgHh+bAvet5l8TB3N3xcRNakCD
	pUZae/1qU5ZWe0hHRHCw2EqxBNeH8vLzg3e4NhuBhdCwEnBIQ54rUkM6nNvJ1k2pC6W6S4Zyr8S
	hc0NWSgqgov0OermM8MvAUyaRKZPg08v8ul72WZtALCUiZrO8SrQ8rIhGhLqsaD+Iuf1FZ/tm9/
	/D/uanFH9izjXU7f4QW4/lsDdb3KO2CEyO5FdTz72QD1DbwnrPMb1UsU8pyXwXm2qZ8YMbvqwmW
	hIQW/pLmi22CWq1Ysp2T4ohQUBAVEzO/2i28dI3mXDj8nO3xz5KTOvdIZ6h0b+mO9DG9v/5w=
X-Received: by 2002:a05:6820:1f12:b0:6a3:1dc5:3557 with SMTP id 006d021491bc7-6a39a5b34bbmr8055289eaf.16.1784037817485;
        Tue, 14 Jul 2026 07:03:37 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6a77csm1521115685a.45.2026.07.14.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:03:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjdjU-0000000FeUS-19dr;
	Tue, 14 Jul 2026 11:03:36 -0300
Date: Tue, 14 Jul 2026 11:03:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev,
	will@kernel.org, robin.murphy@arm.com, fustini@kernel.org,
	pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com,
	corbet@lwn.net, shuah@kernel.org, kevin.tian@intel.com,
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 1/7] iommu: Add group lookup by ID
Message-ID: <20260714140336.GA3716926@ziepe.ca>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-2-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130657.46963-2-zhangzhanpeng.jasper@bytedance.com>

On Tue, Jul 14, 2026 at 09:06:51PM +0800, Zhanpeng Zhang wrote:
> Add iommu_group_get_by_id() so callers can resolve an IOMMU group from
> the numeric ID used in /sys/kernel/iommu_groups.
> 
> An ID lookup must keep the group object alive without also keeping an
> otherwise empty group active. Embed the devices kobject in struct
> iommu_group so its address remains valid until the parent group is
> released, and return a reference on the parent kobject to ID lookup
> callers. Add iommu_group_put_by_id() to release that reference and
> iommu_group_is_active() to detect when the devices kobject has become
> inactive.
> 
> Serialize lookup against group teardown with iommu_group_kset_mutex and
> only return groups whose devices kobject still has a live reference.
> This prevents a concurrent lookup from dereferencing a stale child
> kobject while allowing external users to discard bindings to empty
> groups.
> 
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>  drivers/iommu/iommu.c | 107 +++++++++++++++++++++++++++++++++++++-----
>  include/linux/iommu.h |  17 +++++++
>  2 files changed, 113 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e8f13dcebbde..da269d10f6bf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -40,6 +40,7 @@
>  #include "iommu-priv.h"
>  
>  static struct kset *iommu_group_kset;
> +static DEFINE_MUTEX(iommu_group_kset_mutex);
>  static DEFINE_IDA(iommu_group_ida);

I think it would be better to change the ida to an xarray than to use
a string search on a kset..

Jason
