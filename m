Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1096CA5D
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 08:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695628926; x=1727164926;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2BzDBwKAVGWZW5bjYPETPn/FpFO36BDHugTlU76Wjg0=;
  b=V7N4fMXs557EdjHNmzwoFxlv71i029LZ31fb3k1MzNxk6YDSkDV6l6Ba
   9SN/mMAsJ3Gxte3iJqyz3ffL2hF3SoAmymJSLlFY3nOXH/EdeA1Oklmj7
   UsXo3BI4W2eJqvPs4XjEZQ9PP3vqh8yi3zGGl7GfXe/pA5RA9Fad+TqRH
   aG2uYTwXtvtHdBrKtjRi6Hn/NuLmdIu3qyIVz+ZKenGk+XOGQGnsfGKlw
   ftnlAsip8ijd9eo2KUJ38SHiURQdzwSdP/lxu4xbCgQrOoPQtWv62mcNX
   YjFFXSYO4dnFQ9GLisftrOCCTWXGIQ90PYEdlLanvtRDAoXK/tYymM1m0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="383956262"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="383956262"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 01:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783388156"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="783388156"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.168.76]) ([10.249.168.76])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 01:01:58 -0700
Message-ID: <473d4050-2f2a-f9a2-6c40-3efd5b582b4e@linux.intel.com>
Date: Mon, 25 Sep 2023 16:01:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
 <15831871-cace-f954-6af1-328039ffda16@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <15831871-cace-f954-6af1-328039ffda16@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/9/25 14:22, Yi Liu wrote:
> On 2023/9/21 20:10, Baolu Lu wrote:
>> On 2023/9/21 15:51, Yi Liu wrote:
>>> +/**
>>> + * iommu_copy_user_data - Copy iommu driver specific user space data
>>> + * @dst_data: Pointer to an iommu driver specific user data that is 
>>> defined in
>>> + *            include/uapi/linux/iommufd.h
>>> + * @src_data: Pointer to a struct iommu_user_data for user space 
>>> data info
>>> + * @data_len: Length of current user data structure, i.e. 
>>> sizeof(struct _dst)
>>> + * @min_len: Initial length of user data structure for backward 
>>> compatibility.
>>> + *           This should be offsetofend using the last member in the 
>>> user data
>>> + *           struct that was initially added to 
>>> include/uapi/linux/iommufd.h
>>> + */
>>> +static inline int iommu_copy_user_data(void *dst_data,
>>> +                       const struct iommu_user_data *src_data,
>>> +                       size_t data_len, size_t min_len)
>>> +{
>>> +    if (WARN_ON(!dst_data || !src_data))
>>> +        return -EINVAL;
>>> +    if (src_data->len < min_len || data_len < src_data->len)
>>> +        return -EINVAL;
>>> +    return copy_struct_from_user(dst_data, data_len,
>>> +                     src_data->uptr, src_data->len);
>>> +}
>>
>> I am not sure that I understand the purpose of "min_len" correctly. It
>> seems like it would always be equal to data_len?
> 
> no, it will not be equal to data_len once there is extension in the
> uAPI structure.
> 
>> Or, it means the minimal data length that the iommu driver requires?
> 
> it is the minimal data length the uAPI requires. min_len is finalized
> per the upstream of the first version of the uAPI.

So, it looks like a constant. Perhaps we should document it in the
uapi/iommuf.h and avoid using it as a parameter of a helper function?

Best regards,
baolu
