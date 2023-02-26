Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD7386
	for <iommu@lists.linux.dev>; Sun, 26 Feb 2023 03:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677381713; x=1708917713;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Ub4xNplwsCdyqlJn5ofe69te68wyHVta6/prD6UN/E=;
  b=P/hHGaj976eFt9FprSQAiexJLjd4pcAyry5JZhndg7aVmt1uji/uA3or
   /L8mfkvxHcI6F/Afb21Ug0Q1+PD01OmV0MUPZyFO/9LBldN/1+IoeVyr8
   HZmUfEczVkI+gfGkIae0cHnqkFGdD0lC2JQP3ZVRCc1jIu0QOmj3fIHBF
   R/vy5pdNYpdVS1/a9Js3UHI0sw+RKQ+MYxjt8ZmIkqksNL8vUGZAs6tEV
   1DD9sWh+heh4ehSgjGWoT9pGUW4mgc95AbMf7aPgKTzvC62ntuRRXnhwo
   aX1sZ8KTNNp+eNxNI/yuP7fs51SEjySrApu4fqbJId3z4u+KhvhKCh82f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="314105492"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="314105492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 19:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="623161119"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="623161119"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2023 19:21:50 -0800
Message-ID: <909ee61a-9cbd-eda1-89a2-349348eeb735@linux.intel.com>
Date: Sun, 26 Feb 2023 11:13:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, kvm@vger.kernel.org,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
> +/**
> + * iommufd_device_attach - Connect a device to an iommu_domain
> + * @idev: device to attach
> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID

"Output the hwpt ID" only happens when the caller input an IOAS object
and an auto domain was selected or created for the device.

Do I understand it right?

> + *
> + * This connects the device to an iommu_domain, either automatically or manually
> + * selected. Once this completes the device could do DMA.
> + *
> + * The caller should return the resulting pt_id back to userspace.
> + * This function is undone by calling iommufd_device_detach().
> + */
> +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
> +{
> +	int rc;
> +
> +	rc = iommufd_device_change_pt(idev, pt_id, &iommufd_device_do_attach);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Pairs with iommufd_device_detach() - catches caller bugs attempting
> +	 * to destroy a device with an attachment.
> +	 */
> +	refcount_inc(&idev->obj.users);
> +	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
>   
> +/**
> + * iommufd_device_replace - Change the device's iommu_domain
> + * @idev: device to change
> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID

If my above understanding is correct, then replace will never output a
hwpt id as it only happens after a successful attach.

> + *
> + * This is the same as:
> + *   iommufd_device_detach();
> + *   iommufd_device_attach()
> + * If it fails then no change is made to the attachment. The iommu driver may
> + * implement this so there is no disruption in translation. This can only be
> + * called if iommufd_device_attach() has already succeeded.
> + */
> +int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
> +{
> +	return iommufd_device_change_pt(idev, pt_id,
> +					&iommufd_device_do_replace);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);

Best regards,
baolu
