Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C221B394A
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784153; cv=none; b=t2/qUBSn3n5rSqVl6vu50oNeC8Ldmak2HMqRPssTqTWeu2TpRx6Cb0UR7h4xQ6G+1fpsZ/UwOdrogyHqKoD8t17FKM6dQSpgVzg31vax5OqJYyTnZ/4VKzAiLf50A4iCPFGLvqW0cs0o2PPeZjsOgkEpeI0BDKNr1+0zVvqph48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784153; c=relaxed/simple;
	bh=BDfTGHxE0MDdR7Mt4nvx9WDWn3AlWZmWjMx4m/nD9Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP1trbSmxIqDS474Rh+T54YN85yUPI7HNmKNU72rkA3vD1YPu5evpedPRtSCZpmtPH3tJNdToRbPdznGNlgRabpzNMU5Ep+Gn++4epBA8YyrgqUkioG1E8pJkMOl7gz1uaEoronwc2Gsyzp6OtGJYdirpkgzJSNeZBtorOWHfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5MiJi+8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5MiJi+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730784151; x=1762320151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BDfTGHxE0MDdR7Mt4nvx9WDWn3AlWZmWjMx4m/nD9Yk=;
  b=D5MiJi+8YUOrONdYTde9OEfE5L0lq6NqojzAz8BXdRZI6+za5IIjcq0j
   gMh0EUGHRlINC6CkqYk7aVGvOPdmchwDSvlsHYxgg5rLpFyg70C+0fm0Z
   pfME/BA/62SPlOkTYNbJ6WW13Axjew6783mcG1itjzIh9IcvkTiBdi4vq
   Yz37e87xw633++dTZA6lFSpoYQ+x8jD3dp0fpKcLmTMjP+ah/O5AJFQ6H
   Hy59uLmzAb3AjntQ+GVRj4PE0VBZvhwNll/eeX+FpH5v8VIqZyJ9Dti3j
   DrEP8ASnNvwjilcdbh5a3T1OzPXSXsXR2xirc8qjLxiXOqVh6ySYHKWKg
   A==;
X-CSE-ConnectionGUID: 4DiAoE4/TlOCRb3HqE8kvA==
X-CSE-MsgGUID: ZBdsl0I+R3mxFW0a0SIrjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41907743"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="41907743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:22:30 -0800
X-CSE-ConnectionGUID: REe24FLCQz2k5gMDljJuvg==
X-CSE-MsgGUID: VIpAlR4gRSyfiIJHCTT8Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="87810937"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:22:27 -0800
Message-ID: <41de13f5-c1c3-49a3-a19e-1e1d28ff1b2f@linux.intel.com>
Date: Tue, 5 Nov 2024 13:21:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] iommufd: Move the iommufd_handle helpers to
 device.c
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com
References: <20241104132513.15890-1-yi.l.liu@intel.com>
 <20241104132513.15890-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241104132513.15890-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 21:25, Yi Liu wrote:
> The iommu_attach_handle is now only passed when attaching iopf-capable
> domain, while it is not convenient for the iommu core to track the
> attached domain of pasids. To address it, the iommu_attach_handle will
> be passed to iommu core for non-fault-able domain as well. Hence the
> iommufd_handle related helpers are no longer fault specific, it makes
> more sense to move it out of fault.c.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 51 ++++++++++++++++++++++
>   drivers/iommu/iommufd/fault.c           | 56 +------------------------
>   drivers/iommu/iommufd/iommufd_private.h |  8 ++++
>   3 files changed, 61 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 5fd3dd420290..823c81145214 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -293,6 +293,57 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, IOMMUFD);
>   
> +struct iommufd_attach_handle *
> +iommufd_device_get_attach_handle(struct iommufd_device *idev)
> +{
> +	struct iommu_attach_handle *handle;
> +
> +	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
> +	if (IS_ERR(handle))
> +		return NULL;
> +
> +	return to_iommufd_handle(handle);
> +}

I would suggest placing this helper closer to where it is used. Because,
there is currently no locking mechanism to synchronize threads that
access the returned handle with those attaching or replacing the domain.
This lack of synchronization could potentially lead to use-after-free
issue.

By placing the helper near its callers and perhaps adding comments
explaining this limitation, we can improve maintainability and prevent
misuse in the future.

--
baolu

