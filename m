Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D20B67F
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695298268; x=1726834268;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HY1sm+rBkYtBd+6vBns4g32g88NP2b9P0RK55lZf5eM=;
  b=K5Zn77Vt2OMtpRYAHLzOkEJ1ute2tFBVdh0JhMPBwRvZzcyxaqZWuHJp
   vqdX8Yk7ElKAXl/nEtvV3xMWDpxdJs7y4Auy9D9FcMC+WNmhB2roX1asH
   7yN9ju/NKe9Au3R9DgQO8Ddm6BRsVa8FfyxkH2tsGLVDSus3rtabYuZvk
   QwsQorc7eltEaxLKWGAIgX/SzjJqxcD3ywx8J2DfR0vqMieeOf/2i4Fsh
   NRjD87Qec7b1TVYHus45rnWVryXhS5C9hn+kmZz5Tz9ZbzteCUv3kuhow
   zhrEbzM426L88ylOT4ATYJ1HXAuBjeuPhLF+yzuPov8kLqIm1L3VchVjx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377792034"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="377792034"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="747070867"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="747070867"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.213]) ([10.254.213.213])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:11:01 -0700
Message-ID: <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
Date: Thu, 21 Sep 2023 20:10:58 +0800
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
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230921075138.124099-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/9/21 15:51, Yi Liu wrote:
> +/**
> + * iommu_copy_user_data - Copy iommu driver specific user space data
> + * @dst_data: Pointer to an iommu driver specific user data that is defined in
> + *            include/uapi/linux/iommufd.h
> + * @src_data: Pointer to a struct iommu_user_data for user space data info
> + * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
> + * @min_len: Initial length of user data structure for backward compatibility.
> + *           This should be offsetofend using the last member in the user data
> + *           struct that was initially added to include/uapi/linux/iommufd.h
> + */
> +static inline int iommu_copy_user_data(void *dst_data,
> +				       const struct iommu_user_data *src_data,
> +				       size_t data_len, size_t min_len)
> +{
> +	if (WARN_ON(!dst_data || !src_data))
> +		return -EINVAL;
> +	if (src_data->len < min_len || data_len < src_data->len)
> +		return -EINVAL;
> +	return copy_struct_from_user(dst_data, data_len,
> +				     src_data->uptr, src_data->len);
> +}

I am not sure that I understand the purpose of "min_len" correctly. It
seems like it would always be equal to data_len?

Or, it means the minimal data length that the iommu driver requires?

Best regards,
baolu
