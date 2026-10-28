Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167277;
	b=DvhoMs0V0Geo+jeNTsVo6MRc2AZ4sLyFkAMbjpuXcrsOQzdTxYPe94gONY09yOvDrxsb
	 TVg0IAA8ExhDLQNcC8mSkS4KO2RgUierYj5cWfYiXDuE3ViqJPhDW5JBWYEi60PDQ+xeT
	 gIgZlIUfOF0gfXwpSYUqsU9hifHELHCPsKiYHU3QyBAVyvMUC4vRPBSoERlM79E7Xk9kt
	 YJIZPNg4l0irxg8+izs7iWMsi7EYpaDaW4XAVIPSlPbmHfY40hvHJKq5YNcBSwehjkNwu
	 f1AD7n2i2Ow4lq203EoXOu+Am28iGa8mtTjCdKXa0u5lHN9r36G0os7xXKEldVsWbAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167277;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tvkOawm83twhdq4JidzmKHuTlWLmlEYfP/MMxte24Rk=;
	b=0LK5TU5RZlqbkMQ66kuoUjt6948+hTkMpGXG2EeTw2cPMj6m7xoXJVg+KXq4jMHkZLGc
	 6I7pvfY18sUfoyTLu/ymPVOrJ2bBJuaNKJHxpJKg9Wl35bfRICPT8SNcXfQbT4zXkGfw5
	 IVlWbUxcLHNzyrOcANQ4O0rZmUyZcMj8N2lVLfdE5X19+BTHBkVQ3KYaHOhqJH56DglhA
	 hSBViVhwsU6JUS/ECL6L2VDdKk0ZK3iAgO9xSLB9Y12oJmH0TduIfn/EU+blvunfQSaYE
	 zC9XhAql1ySTgqO+WBvs9gJMIebJn+sFfIl8A/oKjAFEHrvBtuRYQQGz0gHG3qr8loQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dkNmkqCu;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81728606A338
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 06:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81728606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dkNmkqCu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793167276; x=1824703276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xcZ4y1GP1fQheOF1G99rgsos9gP/L78+S0Brp4SO91k=;
  b=dkNmkqCupe+tZPdZsxG1sCkpjyLIdRZUdkABJUYkH0hUk99j43f7qsN5
   fVB9m0JfRhA7ghCvJlti0e3rNjfKpv+Zz1wzNtPlmPl5A8/N7zzAP6hD2
   /GrNYnW1a9N1yrvvP5t3UqerCKF8q8Y1tHXja2XLdLaZd+esxN84/0kyy
   PNNxWG/WCZQ/+TsPnGzp7I68wHul3J9xvduVj+UX1buN3WUJVhl+dPTUw
   b3QPox/q+cX5PlrxiXfgBbH4XMaDHQFQocy2sndEhuahstb+l2kMdOYAi
   /mau4FTjH/Y8gNZZBiH7Hzt0G9SbY+sgevf5Cno9i1WQHBzg3KZw6PPyd
   Q==;
X-CSE-ConnectionGUID: 9leqRIFcR0qVmG5xX3HfhQ==
X-CSE-MsgGUID: tUUV5WVJRSmTtZoSUCj9JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1895260"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1895260"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 23:01:15 -0700
X-CSE-ConnectionGUID: DK3b5CDgSpaAXOpwgte17A==
X-CSE-MsgGUID: drqn8nbQTyy8nKZrCPM9ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5101961"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 23:01:10 -0700
Message-ID: <9e0c1aee-5a4c-4e93-ab26-f7e59b268f2d@linux.intel.com>
Date: Wed, 28 Oct 2026 14:01:08 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/18] iommu/vt-d: Combine disable_dmar_iommu() and
 free_dmar_iommu()
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-10-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-10-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 10:19, Samiullah Khawaja wrote:
> Every caller of disable_dmar_iommu() immediately follows it with a call
> to free_dmar_iommu(). Combine the two helpers into release_dmar_iommu()
> and simplify the teardown and error paths in init_dmars(),
> intel_iommu_add(), and dmar_iommu_hotplug().
> 
> Also drop the early return when
> WARN_ON(!ida_is_empty(&iommu->domain_ida)) triggers so translation is
> still disabled before freeing the IOMMU resources.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 23a1da351ddf..35ec2ae0c8d5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -985,21 +985,17 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>   	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>   }
>   
> -static void disable_dmar_iommu(struct intel_iommu *iommu)
> +static void release_dmar_iommu(struct intel_iommu *iommu)
>   {
>   	/*
>   	 * All iommu domains must have been detached from the devices,
>   	 * hence there should be no domain IDs in use.
>   	 */
> -	if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
> -		return;
> +	WARN_ON(!ida_is_empty(&iommu->domain_ida));
>   
>   	if (iommu->gcmd & DMA_GCMD_TE)
>   		iommu_disable_translation(iommu);
> -}
>   
> -static void free_dmar_iommu(struct intel_iommu *iommu)
> -{
>   	if (iommu->copied_tables) {
>   		bitmap_free(iommu->copied_tables);
>   		iommu->copied_tables = NULL;
> @@ -1867,10 +1863,8 @@ static int __init init_dmars(void)
>   	return 0;
>   
>   free_iommu:
> -	for_each_active_iommu(iommu, drhd) {
> -		disable_dmar_iommu(iommu);
> -		free_dmar_iommu(iommu);
> -	}
> +	for_each_active_iommu(iommu, drhd)
> +		release_dmar_iommu(iommu);
>   
>   	return ret;
>   }
> @@ -2280,12 +2274,12 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   	if (ecap_prs(iommu->ecap)) {
>   		ret = intel_iommu_enable_prq(iommu);
>   		if (ret)
> -			goto disable_iommu;
> +			goto out;
>   	}
>   
>   	ret = dmar_set_interrupt(iommu);
>   	if (ret)
> -		goto disable_iommu;
> +		goto out;
>   
>   	iommu_set_root_entry(iommu);
>   	iommu_enable_translation(iommu);
> @@ -2293,10 +2287,8 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   	iommu_disable_protect_mem_regions(iommu);
>   	return 0;
>   
> -disable_iommu:
> -	disable_dmar_iommu(iommu);
>   out:
> -	free_dmar_iommu(iommu);
> +	release_dmar_iommu(iommu);
>   	return ret;
>   }
>   
> @@ -2310,12 +2302,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
>   	if (iommu == NULL)
>   		return -EINVAL;
>   
> -	if (insert) {
> +	if (insert)
>   		ret = intel_iommu_add(dmaru);
> -	} else {
> -		disable_dmar_iommu(iommu);
> -		free_dmar_iommu(iommu);
> -	}
> +	else
> +		release_dmar_iommu(iommu);
>   
>   	return ret;
>   }

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
