Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9706AC433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 17:27:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D3F20691
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 17:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D3F20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 94AD886B3B;
	Fri, 15 Jan 2021 17:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFVLx9YMxcTS; Fri, 15 Jan 2021 17:27:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0470186AFD;
	Fri, 15 Jan 2021 17:27:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDD8BC088B;
	Fri, 15 Jan 2021 17:27:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F99FC013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1B47D86B04
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLxVYAoZFOYh for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 17:27:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3E4AE86AFD
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 17:27:51 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id m4so10049907wrx.9
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 09:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XNAkXsuzFF5uut41Z4Aj5p+/hR3E7tQupuXO85WbsYI=;
 b=Gzc9V3KMdOG0TLt/WQd+qg2yIxaor24Z/ET2XQ+PjxqPsc68YpjDXOtMw6MJ6L3mxC
 Uyqtc0qzTanMeUhynfnJlEDScXW6y9Wwl6sBzJFlE+heusxBbwmxwuM9wqQ5JDG2F4wq
 WQ1+1CvTHA5btS9lISrbM7df7BQbGYKYMYpKi84jYSvNvUiTd3ZqhkMMdSPwmJuJTUAK
 lxLjWrIsmXaFUGdWxUU+6Vbpm+xe1+BEMsFTSB8GebmQk156sbLT49Fyoae0a9ZEQA63
 Db30WsCColfTMi07dDeIkRE49u6gTgc2zrc5Wsu3yE2c/6Ol9X1poy/8xX9aeU0i2gXb
 iGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XNAkXsuzFF5uut41Z4Aj5p+/hR3E7tQupuXO85WbsYI=;
 b=HQ5BpYfi7fvfG5UV7ruZxqSb+qgeZt+SGjVC6VXbe0k2M8LvqybHp4yBV0YKPusb+j
 d2ejxe/p1JIWaUprh/10mEntwxr6+pgYqIw+NRMVfZMCc82PERnzSEXreeBWky9eb/V+
 fnhl/GDlsWTLJAje1Lazo+1mN+XKw5Q5Bkk+eDOnmk57ge6rS5uoAdRjYpnIZQhWEhoB
 pl725hnB8hm0W7orqR9M7qGeI3wmiyR8UeXq4IgECfGnjx1THaFscucq5diu3/S8ANPe
 L/faMH4ytgx18pWc9zFG6t0DZVo4q+vjm7FMG7GbVltfntiucBXHdlftbBfJW8vYJt+I
 ZgKg==
X-Gm-Message-State: AOAM532JN556yUL+fbgMwSHnNridMKRwx5eS/+wtI+dltNPtSGTCtbM2
 Hre0+MELHh1PCrGhm+U7te7S0g==
X-Google-Smtp-Source: ABdhPJzEtFsQ+XAOEoNdK8tNswM+5vBs932md5l/dTGp3QPXgJciQJcUotO0dV0614UGWgr+4n6aQw==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr14060273wru.398.1610731669622; 
 Fri, 15 Jan 2021 09:27:49 -0800 (PST)
Received: from larix.localdomain ([2001:1715:4e26:a7e0:ed35:e18a:5e36:8c84])
 by smtp.gmail.com with ESMTPSA id c11sm13888786wmd.36.2021.01.15.09.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 09:27:48 -0800 (PST)
Date: Fri, 15 Jan 2021 18:28:33 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 1/3] iommu/iova: Add free_all_cpu_cached_iovas()
Message-ID: <YAHQwT/chwlO4fYv@larix.localdomain>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1607538189-237944-2-git-send-email-john.garry@huawei.com>
Cc: will@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Dec 10, 2020 at 02:23:07AM +0800, John Garry wrote:
> Add a helper function to free the CPU rcache for all online CPUs.
> 
> There also exists a function of the same name in
> drivers/iommu/intel/iommu.c, but the parameters are different, and there
> should be no conflict.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

(unless we find a better solution for patch 3)

> ---
>  drivers/iommu/iova.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index f9c35852018d..cf1aacda2fe4 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -238,6 +238,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	return -ENOMEM;
>  }
>  
> +static void free_all_cpu_cached_iovas(struct iova_domain *iovad)
> +{
> +	unsigned int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		free_cpu_cached_iovas(cpu, iovad);
> +}
> +
>  static struct kmem_cache *iova_cache;
>  static unsigned int iova_cache_users;
>  static DEFINE_MUTEX(iova_cache_mutex);
> @@ -435,15 +443,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>  retry:
>  	new_iova = alloc_iova(iovad, size, limit_pfn, true);
>  	if (!new_iova) {
> -		unsigned int cpu;
> -
>  		if (!flush_rcache)
>  			return 0;
>  
>  		/* Try replenishing IOVAs by flushing rcache. */
>  		flush_rcache = false;
> -		for_each_online_cpu(cpu)
> -			free_cpu_cached_iovas(cpu, iovad);
> +		free_all_cpu_cached_iovas(iovad);
>  		free_global_cached_iovas(iovad);
>  		goto retry;
>  	}
> -- 
> 2.26.2
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
