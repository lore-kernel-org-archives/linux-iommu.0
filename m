Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192F645
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 02:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691633163; x=1723169163;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LwSdYv2U/EME+IZ0lQwbvUUwI+VkBqY/yWwfc4nDKLM=;
  b=iWSHh1khG/a7KUCXvo5s4a3h3JqQiroSKhR8M/5Y9cTEvX6kqfb8kc7C
   leCy7c6s/MKQcp3GZ00J+9BNw08U488JeGAvG9zlC7SYSBcxj882X8/sd
   7GMI72hCdr0HkFGi2SlscDIFX7ONp01DoKCYxKRbUz5mpJd2afL5pDsOC
   IRRF48iSiIiB1jxfSlyy0AwPHvLIAziG2u3ZSWO2P4I3Zu1qjjnl7X/Bn
   uBd2e13XemiWTD+ZpQyId7wkdNMJlS1OqJ/az1l5hcnn+9CHt+VthuvS4
   14Q1BC8clB86DNU8YN8K1qx8rISfff5H2c6swJWMFXhocRWwJp9nncbsc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374056987"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374056987"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="801982441"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="801982441"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.239]) ([10.254.214.239])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:05:57 -0700
Message-ID: <e895888f-9984-176b-f5f2-a256b25f61bd@linux.intel.com>
Date: Thu, 10 Aug 2023 10:05:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
 alex.williamson@redhat.com, kevin.tian@intel.com, robin.murphy@arm.com,
 cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com
Subject: Re: [PATCH v6 3/4] iommufd: Add IOMMU_GET_HW_INFO
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-4-yi.l.liu@intel.com>
 <aa455c36-83be-7757-7171-05460a459a2e@linux.intel.com>
 <ZNO75LVZemR0YZUR@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNO75LVZemR0YZUR@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/10 0:16, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 06:16:19PM +0800, Baolu Lu wrote:
>> On 2023/8/8 23:35, Yi Liu wrote:
>>> +static int iommufd_fill_hw_info(struct device *dev, void __user *user_ptr,
>>> +				unsigned int *length, u32 *type)
>>> +{
>>> +	const struct iommu_ops *ops;
>>> +	unsigned int data_len;
>>> +	void *data;
>>> +	int rc = 0;
>>> +
>>> +	ops = dev_iommu_ops(dev);
>>> +	if (!ops->hw_info) {
>>> +		*length = 0;
>>> +		*type = IOMMU_HW_INFO_TYPE_NONE;
>>> +		return 0;
>>> +	}
>>> +
>>> +	data = ops->hw_info(dev, &data_len, type);
>>> +	if (IS_ERR(data))
>>> +		return PTR_ERR(data);
>>> +
>>> +	/*
>>> +	 * drivers that have hw_info callback should have a unique
>>> +	 * iommu_hw_info_type.
>>> +	 */
>>> +	if (WARN_ON_ONCE(*type == IOMMU_HW_INFO_TYPE_NONE)) {
>>> +		rc = -ENODEV;
>>> +		goto err_free;
>>> +	}
>>> +
>>> +	*length = min(*length, data_len);
>>> +	if (copy_to_user(user_ptr, data, *length)) {
>> copy_to_user() returns the number of bytes that were successfully
>> copied, right?
> It returns length on failure and 0 on success

Then it's fine. Thanks for the explanation.

Best regards,
baolu
