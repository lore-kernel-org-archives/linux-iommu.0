Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9C1C84B4
	for <iommu@lists.linux.dev>; Sun, 23 Feb 2025 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740316964; cv=none; b=keaqeeS3N1z9Ti4o/vvQ7n+b9ceofsmcdy6iBRme9FtK5MapJ2Z6RUGs2ju9gjE5BtO0Z3bXkepyeZsYUMAqs80bMl017esREblA09qzPwNaARAT5Qmt67KM/QK/JOtkH/Y7GTvzl0zWtHBzr0LC58b0br1vRTPUMqyG5H/f/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740316964; c=relaxed/simple;
	bh=7mYfwDO+ZB7ecmf29ndZ5ZaBLa1mkXh6Ad2w3T0AzFw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VD53SWvfb6GVsQy8bfAy96/6dFwoUZSzcbnspbhwCiS2BA4EKDxo1rA8uWAXOz9vOLl5MGbx2HD/ivpFR7pcQ1hRn2/XehTYdRk/wMazezb7kSQoxuJO/7WnnMMZYNgbKfw3jynmUTHgk0snR9spnWB27cYV/n2htfsUZOlZVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNfUfP2z; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNfUfP2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740316963; x=1771852963;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7mYfwDO+ZB7ecmf29ndZ5ZaBLa1mkXh6Ad2w3T0AzFw=;
  b=hNfUfP2zLMXiDT5F74dj0nqhRAusT3GFCy0jqkYymX0ORwkTBqy8UXIA
   Qiah8iqNeDeaZVxl2w3sTIBDXt1SJjeans3tRvYQU62FdrIsWKBXwZAvA
   P5tZxElBJJdZ52vXfIUK7/8vjIypM3R4Zk0IsRxwS9nGLz8XHlAitsuZ0
   ipetgycWPx3dFlkFZQCQNhToVDtUR928vTIOPYnlQi5DPzahUsTiolnNO
   YDb89pScGoOvxk5nkEcMqQoZbv+I7Bqpri2acSx2r2YtgwYyvlU+Py4r/
   Lx1n7mglbvL9cNG5NKM9bqnoo+CezyJ5+WwEBduIGlnjIw6K74v5pQHtN
   g==;
X-CSE-ConnectionGUID: mpJ4qA5hTaCD8AuS3t1I9Q==
X-CSE-MsgGUID: /jIXyDRnTYCmMh6XsQ+0lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40317717"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40317717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:22:43 -0800
X-CSE-ConnectionGUID: GZWxEpx/TJ2QTy/oGDNOrA==
X-CSE-MsgGUID: F4qvyveSTHWbQD/P7cx14Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="139049433"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.93]) ([10.124.240.93])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 05:22:40 -0800
Message-ID: <a4a1e65e-3614-419c-a5e3-6ff2aa4f1369@linux.intel.com>
Date: Sun, 23 Feb 2025 21:22:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, iommu@lists.linux.dev,
 robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org
Subject: Re: [PATCH v2 3/4] iommu: Store either domain or handle in
 group->pasid_array
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250221143335.49874-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/21 22:33, Yi Liu wrote:
> @@ -3454,13 +3468,17 @@ struct iommu_attach_handle *
>   iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int type)
>   {
>   	struct iommu_attach_handle *handle;
> +	void *entry;
>   
>   	xa_lock(&group->pasid_array);
> -	handle = xa_load(&group->pasid_array, pasid);
> -	if (!handle)
> +	entry = xa_load(&group->pasid_array, pasid);

Could entry be NULL? If so, a null check might be needed here.

> +	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_HANDLE) {
> +		handle = xa_untag_pointer(entry);
> +		if (type && handle->domain->type != type)
> +			handle = ERR_PTR(-EBUSY);
> +	} else {
>   		handle = ERR_PTR(-ENOENT);
> -	else if (type && handle->domain->type != type)
> -		handle = ERR_PTR(-EBUSY);
> +	}
>   	xa_unlock(&group->pasid_array);
>   
>   	return handle;

Thanks,
baolu
