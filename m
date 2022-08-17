Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C47B
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 02:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660701979; x=1692237979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eAXvkVBxq2Yz0rp1C3vUTZ4WeY9kQ3s6M3PSgH+MdjU=;
  b=SfbIScA7y5p1AFfGZpmZepI77l804BscrNIjOplTwNUwkLKDl1KxKrGd
   qOHBXu5VSh2lWfjHmd0dwJM7sFmaPqu8QAm8AEQm+lIMzhuOKOWP8mOg8
   WftN7j3Uu+ik8/mvFklpcDt3V8GqtcWLZb3mic4AGP2KdC97mGdGllKGj
   OWnbGmBP44q3H5vg6JPHrvejHvhFgf7fqd7wfeeUYjVcUFqUAjRk/aboG
   1916fCsAI6gJcdTbTjdUJAIlTVwttbpoRxUo1u1EfPKMO2R87raZej3c3
   axwxhzLPUq0Vq+FgxNrmaJgtj4TjC4Jh9cADW5e/GEPVyKHtHAARBGYVH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378670559"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378670559"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 19:06:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583563293"
Received: from xinpei-mobl1.ccr.corp.intel.com (HELO [10.255.29.150]) ([10.255.29.150])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 19:06:14 -0700
Message-ID: <a5e2c27e-8990-210e-1d33-c2147de75545@linux.intel.com>
Date: Wed, 17 Aug 2022 10:06:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] iommu: return early when devices in a group require
 different domain type
To: Yuan Can <yuancan@huawei.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
References: <20220816020701.90533-1-yuancan@huawei.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20220816020701.90533-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yuan,

在 2022/8/16 10:07, Yuan Can 写道:
> When alloc default domain for an iommu_group in
> probe_alloc_default_domain, the expected domain
> type of each device in the iommu_group is checked
> in a loop, if two devices require different types,
> the loop can be breaked since the default domain
s/breaked/broken
> will be set to iommu_def_domain_type.
> Return 1 when this happened to break the loop in
> __iommu_group_for_each_dev.
>
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 74bc9111c7be..0d4d78946d31 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1653,6 +1653,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
>   				 dev_name(gtype->dev),
>   				 iommu_domain_type_str(gtype->type));
>   			gtype->type = 0;
> +			return 1; /* end the outer loop */
>   		}
>   
>   		if (!gtype->dev) {

Thanks,

Ethan

-- 
"firm, enduring, strong, and long-lived"

