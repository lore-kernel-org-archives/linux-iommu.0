Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33099270031
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628033; cv=none; b=D3QvKhaFS3n6rH+OldmckQEcNJm4s2c/eai4RlEduNQyR16tVmO6iTwFU1ESapR4Hj9A4WS1C4qlGe3AsCc/fJIKs3srFV9q1xf7QRaO0DS+WB4lEExp375fvJyaJyaQhbH8XQyuIQ3DLkaDV/AtEeWbmMJQrDkumwwaiNi+nL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628033; c=relaxed/simple;
	bh=L0Bdj3w5oikmbHR0qu9DLvcPaZBOx8YVYbh1CC+0JZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I32WXP95Tu97YfT5Dht7oxvO3PwDRfjMLI2Ky+8+bGmJwRhCzfpwUsmmdV9qyr451GO4JDPoeUayWS23Rohdc2z3EbGT4IXQqUxn9VXZYUlo+AVt4rObTU+4MSrGpU2ijJKcsghQY31fCPIvXCbEazLw6TnjQrojnh3sU56n0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZzc6+kZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZzc6+kZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740628031; x=1772164031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L0Bdj3w5oikmbHR0qu9DLvcPaZBOx8YVYbh1CC+0JZw=;
  b=MZzc6+kZGHgvbFf+SI++97+h7GkBsgxmzOj2y3pq7484xWQxZ0nYvBM/
   eMB+v+Lf8LWImnrIf5vOdBNv7+CS8GIQv0vIzkIk0dLnaIAY6c1k+sx0f
   B1eoCOvsM6lElAA5L7iKRRwVC1U46I/CahfgGjJTW1kTKSC5pbwn8GSWP
   MzrLZjY1N2elC2dPd19i6dQ9hZbqAwi256spkPHOwue39rc3SQ/QJvjaN
   1VluNFDUlkLcHpR6JO9re3eIHfMTNYGfFIXgYFoJCx5KTyKHcXARj8wKX
   bjlGDKQ2uSfUiz+fEXLvif3eyPgeYxHO1TdJFU/bg+a8O8zMwdOEsyKde
   A==;
X-CSE-ConnectionGUID: ALGfRvwtSoigj7+McJRh/Q==
X-CSE-MsgGUID: hI8Jjp8HQKWdgCdBpq2KTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51711942"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="51711942"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:47:11 -0800
X-CSE-ConnectionGUID: CqiNRYiRSI+2C5Q6ey9FRg==
X-CSE-MsgGUID: 1mFHSwMEQu+YX2K2wQNaXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116673656"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:47:09 -0800
Message-ID: <428e2657-6427-4aca-8e33-9d87dd9554c2@linux.intel.com>
Date: Thu, 27 Feb 2025 11:43:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/12] iommufd: Enforce PASID-compatible domain for RID
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-8-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226114032.4591-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 19:40, Yi Liu wrote:
> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
> the RID to use PASID-compatible domain if PASID has been attached, and
> vice versa. The PASID path has already enforced it. This adds the
> enforcement in the RID path.
> 
> This enforcement requires a lock across the RID and PASID attach path,
> the idev->igroup->lock is used as both the RID and the PASID path holds
> it.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 30dd2f79491a..e0f097b04467 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -357,6 +357,22 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>   
>   /* The device attach/detach/replace helpers for attach_handle */
>   
> +static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
> +				     struct iommufd_device *idev,
> +				     ioasid_t pasid)
> +{
> +	lockdep_assert_held(&idev->igroup->lock);
> +
> +	if (pasid == IOMMU_NO_PASID &&
> +	    !xa_empty(&idev->pasid_hwpts) && !hwpt->pasid_compat)
> +		return -EINVAL;
> +
> +	if (pasid != IOMMU_NO_PASID &&
> +	    (!idev->igroup->hwpt->pasid_compat || !hwpt->pasid_compat))
> +		return -EINVAL;
> +	return 0;
> +}

I'm not following this. Patch 05/12, which introduced the concept of
PASID-compatible domain, states, "AMD IOMMU requires attaching PASID-
compatible domains to PASID-capable devices." My understanding was that
if PASID is enabled on a device, the RID or PASID of that device should
only be configured with PASID-compatible domains.

However, the logic here differs. It seems that even if a device is
PASID-capable, it's allowed to attach a non-PASID-compatible domain to
the RID, if no domain is currently attached to the device's PASID. This
doesn't seem like a generic property.

Thanks,
baolu
