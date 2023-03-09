Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFD628
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678324532; x=1709860532;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n9/BFx00bk/6jqChuJmuyNT87149Jg6frqDApKRvQhA=;
  b=iiHSHgB6MuU0ptIw93KOaHcilpMqRhcuYf2wnWIJVPsWvN8EcB24HxQc
   xz/v8gVrxReTf4xvpi4jv2XO/+VqmzVwFD/tzTLre9HGcn5YJdhgCxSdZ
   64RW8DVO1ZVqeq88AQr4tTVTol/sgzAsRtZVb9PM7YCkrGpwUa4h89g72
   D2lUl4SD2GiTNL27naDySWR2TyvvLc9ykMJULGRgSVyYWMljMQrIjfClj
   O0MNoladuW/Rk3H3QniR9hmSxr3EZ/Wxu30otATTLLrnrH1CaiZrp1Yov
   0MgAoayXForA+nICYN7Zbf/RQuxeH/XzHTPL7z621px3UsWW46lEb9FdP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="401156726"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="401156726"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:15:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="766224010"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="766224010"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 17:15:28 -0800
Message-ID: <94a68384-0541-affb-fb52-9644312c4b95@linux.intel.com>
Date: Thu, 9 Mar 2023 09:14:29 +0800
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
Subject: Re: [PATCH v2 12/17] iommufd: Add iommufd_device_replace()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org
References: <12-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <12-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/23 8:35 AM, Jason Gunthorpe wrote:
> Replace allows all the devices in a group to move in one step to a new
> HWPT. Further, the HWPT move is done without going through a blocking
> domain so that the IOMMU driver can implement some level of
> non-distruption to ongoing DMA if that has meaning for it (eg for future
> special driver domains)
> 
> Replace uses a lot of the same logic as normal attach, except the actual
> domain change over has different restrictions, and we are careful to
> sequence things so that failure is going to leave everything the way it
> was, and not get trapped in a blocking domain or something if there is
> ENOMEM.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
