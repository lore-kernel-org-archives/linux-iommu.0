Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED967E8
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 00:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684716723; x=1716252723;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=riI12iI9eXEaQbXUV1i5TxI4nm6VjzxhP1/In23NaW0=;
  b=BIXTWrLM2TPYfGl1SHwim/SK/WOib64Y6pOwRwi1EWT1EK/BlsGRwLqT
   UnETgeFe81GpDSYVmnP/VjpANMaqWv0d8rMAIRTfTwJMRE/m5ATkSWj9b
   o3ewNXV+W/7cUvfdLsBom6k79RYw+yY8h7N2nmzeO9TjGPUlq4FZ2q8jB
   tSLKgfBtmxQjEcfVhgA9l9wQaC5LWbDLOjnkqHQOOMBtruh1rrUBQPwpk
   teYmvlDCy8ZVoww0DF1Ds+TaQQTG44CIOVYBVo5c3mQvKSnRRzIFomfZ5
   sJh+jb+1UevzjTnm5C+gHrY+O1LjsQpRNrFSN+wn+Qux875bfLz86abit
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="356019355"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="356019355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 17:52:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="736227420"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="736227420"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2023 17:51:59 -0700
Message-ID: <b9df5551-5856-3b00-f6cc-9b76eb205a20@linux.intel.com>
Date: Mon, 22 May 2023 08:51:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 06/10] iommu: Move the iommu driver sysfs setup into
 iommu_init/deinit_device()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <6-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> It makes logical sense that once the driver is attached to the device the
> sysfs links appear, even if we haven't fully created the group_device or
> attached the device to a domain.
> 
> Fix the missing error handling on sysfs creation since
> iommu_init_device() can trivially handle this.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
