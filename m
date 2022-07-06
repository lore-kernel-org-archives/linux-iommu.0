Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8D603A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 01:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657071585; x=1688607585;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fJxV3N/r8RRwYOaYdoJK639dTHZ5BBDCFg7PkYP7v3w=;
  b=cTYBlLL6lIry7NYEoVTGdTxGiUOBL1GQ//oKN4e7iIHFjjDNSgVu8ZYT
   HzRGPhvKPoX6EJWwuVqTmlZnScUjXWH7nQxVLuMqNmmZWQKKbtxpar79/
   yQ5X6zpXcV05TeXmf2gzlyqBiNJeTHxYnLtOPd6QEiWUkiMdZakXFOW/u
   D5WkXg3QtC8BkN7b7xoH+t3ZAfPUjO1AI+osBcUy6rFUIUPRm3Sq7U8GH
   zJwA0PSsck7KMvQaLBMWvEzL07fsvuPsleJTpcoNdsB8n1HwvoOL7OjO2
   p9eK+zHSAFVihHBsWfjfdI6IvJzl/PhOVOC0d0HQKBXwbJPydkdDmwbk5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="309158752"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="309158752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 18:39:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="650429732"
Received: from zhuoliu-mobl1.ccr.corp.intel.com (HELO [10.249.174.206]) ([10.249.174.206])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 18:39:42 -0700
Message-ID: <032937a0-ffef-221c-4faf-4680fa09b2af@linux.intel.com>
Date: Wed, 6 Jul 2022 09:39:40 +0800
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
Subject: Re: [PATCH v3 01/15] iommu/vt-d: Handle race between registration and
 device probe
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/6 01:08, Robin Murphy wrote:
> Currently we rely on registering all our instances before initially
> allowing any .probe_device calls via bus_set_iommu(). In preparation for
> phasing out the latter, make sure we won't inadvertently return success
> for a device associated with a known but not yet registered instance,
> otherwise we'll run straight into iommu_group_get_for_dev() trying to
> use NULL ops.
> 
> That also highlights an issue with intel_iommu_get_resv_regions() taking
> dmar_global_lock from within a section where intel_iommu_init() already
> holds it, which already exists via probe_acpi_namespace_devices() when
> an ANDD device is probed, but gets more obvious with the upcoming change
> to iommu_device_register(). Since they are both read locks it manages
> not to deadlock in practice, so I'm leaving it here for someone with
> more confidence to tackle a larger rework of the locking.

Thanks for highlighting this. I will look into it later.

Best regards,
baolu

> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v3: New
> 
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 44016594831d..3e02c08802a0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4600,7 +4600,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   	u8 bus, devfn;
>   
>   	iommu = device_to_iommu(dev, &bus, &devfn);
> -	if (!iommu)
> +	if (!iommu || !iommu->iommu.ops)
>   		return ERR_PTR(-ENODEV);
>   
>   	info = kzalloc(sizeof(*info), GFP_KERNEL);

