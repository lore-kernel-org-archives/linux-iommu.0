Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7D2579
	for <iommu@lists.linux.dev>; Wed, 27 Sep 2023 02:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695781252; x=1727317252;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AydsJicsTjhS4lwN66GX3GcPaMOacXh1JO4dOr+xExI=;
  b=CNWAkozFOnZK0TQx+TWekb1EpftQPpZMcxVFPZKVET051WRO4rlW6Y4t
   NqWgq4IkNfsnCODP03c/7jZriwI1dQhlbvFMYVVjHhCKeXuB8uPDnwz1U
   EYYyxT5VT+m0cxg5RPIzoAchgUNxbs+oWmPBb0dvYQMxv146NljUK+s/2
   DuiwH9otWd4JGJhT0a7312yrp42qRpL0XhJkcrETVQ7CegUa4omLRkMXF
   pem8RNwK04VY6uYpmrEUHiQS3t5wZcA7YwKHnhDPWfv+p3xi+5NQM9PwR
   7JF+zv+/HDJc3Pagbr+izcmMvjDpgQq1B4K+hAC1PEd8tlwCEHHnNYLvs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381611483"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381611483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864616370"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="864616370"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2023 19:20:45 -0700
Message-ID: <e73f3a0e-5c1b-674e-7ef1-53d963a540d3@linux.intel.com>
Date: Wed, 27 Sep 2023 10:17:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [RFC 2/8] iommufd: replace attach_fn with a structure
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-3-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230926092651.17041-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/23 5:26 PM, Yi Liu wrote:
> Most of the core logic before conducting the actual device attach/
> replace operation can be shared with pasid attach/replace. Create
> a new structure so more information (e.g. pasid) can be later added
> along with the attach_fn.
> 
> Signed-off-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 35 ++++++++++++++++---------
>   drivers/iommu/iommufd/iommufd_private.h |  8 ++++++
>   2 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 645ab5d290fe..4fa4153c5df7 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -597,8 +597,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>   	return ERR_PTR(rc);
>   }
>   
> -typedef struct iommufd_hw_pagetable *(*attach_fn)(
> -	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
> +static struct iommufd_hw_pagetable *do_attach(struct iommufd_device *idev,
> +		struct iommufd_hw_pagetable *hwpt, struct attach_data *data)
> +{
> +	return data->attach_fn(idev, hwpt);
> +}

I assume that this change was made because we need to pass the pasid
value to the attach_fn() callback.

If so, how about passing it directly to attach_fn() function?

typedef struct iommufd_hw_pagetable *(*attach_fn)(
		struct iommufd_device *idev,
		struct iommufd_hw_pagetable *hwpt,
		ioasid_t pasid);

In no pasid case, use IOMMU_NO_PASID.

Best regards,
baolu
