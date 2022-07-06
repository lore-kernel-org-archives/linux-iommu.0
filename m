Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B36015
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 02:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657074927; x=1688610927;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/qKfGncLBodraY8iG9SYn0Nbai2B5nyW3PrxStAGttw=;
  b=IrVja+pQ+SYzyjNCom8dci9YVBvC5Oqh8IATeihSDOBajnpP51NBg58T
   ZEFg5thziC8bmw1a4E23VjjBkv1PCSBvYgXeJ3i7tGbDIxTDNMMBxbuKO
   7cqBxgspkb9zrxvEB3B6BQGZqipMrucptT9dZhqjl8/8q54gpv3qRDynT
   a6Lj9rjqlH3tZ4bCfsNtJV/BiYA8L0aUcnj87hX0pdoVEdbthLe7ZPyTw
   +Bft9W8qW8qsV8Y9ny+I/CgcsVCbaitB4sXYZ8jMzBIF+5u6VbKsfPAfj
   PkYA3LGS1/rWiHsFGoa3k5YxXToRuxCXL6vK75tbv1x2hJsMIl+awNIxa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="264042132"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="264042132"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 19:35:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="650447066"
Received: from zhuoliu-mobl1.ccr.corp.intel.com (HELO [10.249.174.206]) ([10.249.174.206])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 19:35:24 -0700
Message-ID: <d6a8e85b-ab7d-f5c9-a8cb-79dd8e68c967@linux.intel.com>
Date: Wed, 6 Jul 2022 10:35:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/15] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <5b9b608af21b3c4353af042355973bac55397962.1657034828.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5b9b608af21b3c4353af042355973bac55397962.1657034828.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/6 01:08, Robin Murphy wrote:
> @@ -202,12 +210,32 @@ int iommu_device_register(struct iommu_device *iommu,
>   	spin_lock(&iommu_device_lock);
>   	list_add_tail(&iommu->list, &iommu_device_list);
>   	spin_unlock(&iommu_device_lock);
> +
> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
> +		struct bus_type *bus = iommu_buses[i];
> +		int err;
> +
> +		if (bus->iommu_ops && bus->iommu_ops != ops) {
> +			err = -EBUSY;
> +		} else {
> +			bus->iommu_ops = ops;
> +			err = bus_iommu_probe(bus);
> +		}
> +		if (err) {
> +			iommu_device_unregister(iommu);
> +			return err;
> +		}
> +	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(iommu_device_register);

With bus_set_iommu() retired, my understanding is that now we embrace
the first-come-first-serve policy for bus->iommu_ops setting. This will
lead to problem in different iommu_ops for different bus case. Did I
overlook anything?

Best regards,
baolu
