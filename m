Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A9613F
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691576189; x=1723112189;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h5cY00xplnCVKxo8zCQtJf9FxOjyPsmGsh03040yI1Y=;
  b=J4bRfPm9MCC48yYuVBHoNrXErukkMxyIeWfs0aB33Xu5F54Sz/FVDekI
   kSP0KrBMnGpevawsdFc3R3yNDhlIdedl9WODkqjIIvjXFtyIK72ye9q3X
   DA1IR2Ztgu9WSwCIquToxDCj2GHxUtxO06uyDz4GV+piZKsb8v7ZYGr7U
   ToQap4tlj53Iiii64ee9WZVwaKoMqqBhq5oAllGBYCBgPDxkHtqVtT1KX
   OY8g5bVwml9YWbEVjLGNlzrA8khQX+Lwx5sKPA7coXFsw8/6F+Sp607Oz
   wTGO9lU9gT1iyue2NiZkqr0ixyoAPcotSMzPz5Eay4opUoi5nLt9r4Mj3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="361212581"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="361212581"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="978320803"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="978320803"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.171]) ([10.254.210.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:16:21 -0700
Message-ID: <aa455c36-83be-7757-7171-05460a459a2e@linux.intel.com>
Date: Wed, 9 Aug 2023 18:16:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com
Subject: Re: [PATCH v6 3/4] iommufd: Add IOMMU_GET_HW_INFO
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-4-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230808153510.4170-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/8 23:35, Yi Liu wrote:
> +static int iommufd_fill_hw_info(struct device *dev, void __user *user_ptr,
> +				unsigned int *length, u32 *type)
> +{
> +	const struct iommu_ops *ops;
> +	unsigned int data_len;
> +	void *data;
> +	int rc = 0;
> +
> +	ops = dev_iommu_ops(dev);
> +	if (!ops->hw_info) {
> +		*length = 0;
> +		*type = IOMMU_HW_INFO_TYPE_NONE;
> +		return 0;
> +	}
> +
> +	data = ops->hw_info(dev, &data_len, type);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	/*
> +	 * drivers that have hw_info callback should have a unique
> +	 * iommu_hw_info_type.
> +	 */
> +	if (WARN_ON_ONCE(*type == IOMMU_HW_INFO_TYPE_NONE)) {
> +		rc = -ENODEV;
> +		goto err_free;
> +	}
> +
> +	*length = min(*length, data_len);
> +	if (copy_to_user(user_ptr, data, *length)) {

copy_to_user() returns the number of bytes that were successfully
copied, right?

If so, isn't it always failure case? Or I missed anything?

> +		rc = -EFAULT;
> +		goto err_free;

nit: this goto is unnecessary.

> +	}
> +
> +err_free:
> +	kfree(data);
> +	return rc;
> +}

Best regards,
baolu
