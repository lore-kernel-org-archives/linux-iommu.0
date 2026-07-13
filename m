Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66029ACDD
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908555; cv=none; b=iDzq1wqjmx8GlDLszlJyYSCTUmHb3/elpsBWWfqZK2/jOZdUnblDtGow+MEJAV0zLb4sJW+YkI6ryaTOM5wdAjbbn6BPH1nVGtsarwkOTNSiaNlANQcTGFjQrTn4Pb1R9kSU5krEG8EBkFEgWY/Apy13u3Sk/tPDcR+Y6Eu/00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908555; c=relaxed/simple;
	bh=/JMEhlpwsUYjR5uS15mNJQaR2Wf1iccL77FChdSQuLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmYMewFqPbTD+taPcIF+R/jwazdOIDhv7Nvpl14SvTC4gLCuWKc7NWmbwf+i+qP7Ob8VTnqQZr7bVdVc+sL2FMoF0BigZloV9EzgY5Oc6qcOhtqs+QxO6kxMeno+MTnhptsnivn1fFoou8GYhWgzxGg+IiKrQF94ZxixBbmSS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Df8SRiaa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Df8SRiaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783908553; x=1815444553;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/JMEhlpwsUYjR5uS15mNJQaR2Wf1iccL77FChdSQuLw=;
  b=Df8SRiaaUd87dP8tNPsmYgemdB7tvm0/PLqapOTZuTKbnFT3VrY7B4Bd
   ltyLSoIGSOYh9/uiBposIdqwmS4VmKaf3vYBLNZVmt7RmiYtzxXowAunm
   qLpmOuXazpxbJtLzOctCfl7W6fhgT0zQECS5/m7NY35uSL7SJtQreYJFK
   X9UjQ7ipn7oujnXbijcC2bbB8HSEXiovg18mQR9OyrkTpDzFe/I6mOaLc
   UvF1xM43/aOORwGJvz0bE2kzr5JBnCVWjdhne/waPuIqpu/0MiPEU49m7
   U6jDmoISTXJWuYhY019tdz4ZKL3X3zhBZT5XgDaWMqiW9gDhWQCeBLSZp
   g==;
X-CSE-ConnectionGUID: 99qlX7xxS5qIyh2Rj8di7A==
X-CSE-MsgGUID: 3YTN+RD1TIuhapL38v/06A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88340718"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88340718"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 19:09:13 -0700
X-CSE-ConnectionGUID: PWSns4zRQ/WaDj9iQlw16A==
X-CSE-MsgGUID: BkI64FIuSLuMU9pQDyktGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259719003"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 19:09:11 -0700
Message-ID: <5a220346-2beb-4456-881c-27b9825d9cc3@linux.intel.com>
Date: Mon, 13 Jul 2026 10:07:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/virtio: Report faults via report_iommu_fault()
To: weimin xiong <15927021679@163.com>, iommu@lists.linux.dev
Cc: jean-philippe@linaro.org, jgg@nvidia.com,
 xiongweimin <xiongweimin@kylinos.cn>
References: <20260713010442.331096-1-15927021679@163.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260713010442.331096-1-15927021679@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/26 09:04, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> Fault events currently only print a ratelimited error with the endpoint
> ID. Upper layers (VFIO, drivers with domain fault handlers) cannot react.
> 
> Track endpoints in an xarray keyed by endpoint ID at probe/release time,
> and call report_iommu_fault() when a fault carries an address and the
> endpoint is attached to a domain. Keep the existing log as a fallback
> when the endpoint is unknown or detached.
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> Cc: iommu@lists.linux.dev
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> ---
> 
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -19,6 +19,7 @@
>   #include <linux/virtio_config.h>
>   #include <linux/virtio_ids.h>
>   #include <linux/wait.h>
> +#include <linux/xarray.h>
>   
>   #include <uapi/linux/virtio_iommu.h>
>   
> @@ -42,6 +43,8 @@
>   	spinlock_t			request_lock;
>   	struct list_head		requests;
>   	void				*evts;
> +	/* endpoint ID -> viommu_endpoint, for fault reporting */
> +	struct xarray			endpoints;
>   
>   	/* Device configuration */
>   	struct iommu_domain_geometry	geometry;
> @@ -593,7 +596,10 @@
>   static int viommu_fault_handler(struct viommu_dev *viommu,
>   				struct virtio_iommu_fault *fault)
>   {
> +	struct viommu_endpoint *vdev;
> +	struct iommu_domain *domain;
>   	char *reason_str;
> +	int fault_flags = IOMMU_FAULT_READ;
>   
>   	u8 reason	= fault->reason;
>   	u32 flags	= le32_to_cpu(fault->flags);
> @@ -613,16 +619,28 @@
>   		break;
>   	}
>   
> -	/* TODO: find EP by ID and report_iommu_fault */
> -	if (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)
> -		dev_err_ratelimited(viommu->dev, "%s fault from EP %u at %#llx [%s%s%s]\n",
> +	if (flags & VIRTIO_IOMMU_FAULT_F_WRITE)
> +		fault_flags = IOMMU_FAULT_WRITE;
> +
> +	rcu_read_lock();
> +	vdev = xa_load(&viommu->endpoints, endpoint);
> +	if (vdev && vdev->vdomain && (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)) {
> +		domain = &vdev->vdomain->domain;
> +		report_iommu_fault(domain, vdev->dev, address, fault_flags);

Who is the consumer of the fault message reported here?

Thanks,
baolu
