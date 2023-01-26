Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F823D4
	for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674738792; x=1706274792;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AKZKPeH27oHGhseoweceyVcAvmeMAAOoMRK8FfRouIU=;
  b=OZ1Gl7lLNvxeP2N7ZZm0Kfgk8K/DPkHgXT5omSxHgAzQ3VyYf5b+BHcL
   i/LJ39eH6mUVUXPkTHGIc/pTQisv57ctF7iCv+00JrFNC0fcN8BQblBsT
   29CxOVIAmq+uW5LCEL7J5P6vUnojRojK7vU0zFjh7ZHHMcj8cUM+d6lyQ
   CokxmAGVgCBPqOB1Xr89Dj4bTqXucD8mk8LXY+E0hrOU9W3VCEDBrHx1V
   riINOwVSwwGDF7QShkX+747d/j9o3/ho6didF2gXtj0v+y0P7sIOYvtQR
   TTg8n/XhWEzHG/iAnTutqWatw9JI9r0KvQZk4kU+e28zwEsxa32+vC+OS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="413034179"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="413034179"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:13:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="726272171"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="726272171"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.66]) ([10.252.191.66])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:13:09 -0800
Message-ID: <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
Date: Thu, 26 Jan 2023 21:13:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, hch@lst.de, jgg@nvidia.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/20 3:18, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down
> the road and just rework it to preserve the current behaviour without
> depending on bus ops.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b189ed345057..a77d58e1b976 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1871,9 +1871,24 @@ int bus_iommu_probe(struct bus_type *bus)
>   	return ret;
>   }
>   
> +static int __iommu_present(struct device *dev, void *unused)
> +{
> +	return device_iommu_mapped(dev);
> +}

/**
  * device_iommu_mapped - Returns true when the device DMA is translated
  *                       by an IOMMU
  * @dev: Device to perform the check on
  */
static inline bool device_iommu_mapped(struct device *dev)
{
         return (dev->iommu_group != NULL);
}

Perhaps device_iommu_mapped() should be improved. In some cases, the
device has an iommu_group filled is not enough to indicate that the
device has IOMMU hardware for DMA translation.

For example, VFIO could allocate an iommu_group and add a device into
the iommu_group even there's no IOMMU hardware in
vfio_noiommu_group_alloc().

Basically iommu_group_add_device() doesn't check the presence of an
IOMMU.

> +
> +/**
> + * iommu_present() - make platform-specific assumptions about an IOMMU
> + * @bus: bus to check
> + *
> + * Do not use this function. You want device_iommu_mapped() instead.
> + *
> + * Return: true if some IOMMU is present for some device on the given bus. In
> + * general it may not be the only IOMMU, and it may not be for the device you
> + * are ultimately interested in.
> + */
>   bool iommu_present(struct bus_type *bus)
>   {
> -	return bus->iommu_ops != NULL;
> +	return bus_for_each_dev(bus, NULL, NULL, __iommu_present) > 0;
>   }
>   EXPORT_SYMBOL_GPL(iommu_present);
>   

--
Best regards,
baolu
