Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBB1841
	for <iommu@lists.linux.dev>; Thu, 23 Jun 2022 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655948826; x=1687484826;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5aSD0DjHyYnzIIUB6IzUxLlam0GmvLF8zHoN0ofDDZ0=;
  b=ESKZ3rdQrlXvYMKmjkZIGJxsj7rH5wUNV3MdVAjMpcbDCil7iHXTzs0l
   ct2y/7fsxanNsA0Tgnt9yJ5ZjG3me+fOwr9V9N5U7HOukXbieqwadw8r9
   Pa2OmAvZmagE5aGh2tTZtgiCzSQpcK5WOotQEelUSmNGQYq1Ev4Nv5ybr
   v5J3Cukew1l706tLbXTrOgRu80ulD5xop4Vp+rLe0tSkE4daVPzZ6Dtw7
   rI7mRGGGLOb29LEHnOmv6Qlin7CjJ3LVc0WOQ1HIqsEADw1x/bagl5CIn
   oSuFQk2EcZZLmDJO37uWUfwI4dpdwVy5ZqWvI0Dfb1PNRfrgCC9kq+Q7j
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="279362968"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="279362968"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 18:47:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644487288"
Received: from yutaoxu-mobl.ccr.corp.intel.com (HELO [10.249.172.190]) ([10.249.172.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 18:47:04 -0700
Message-ID: <809315c8-67b3-c4ce-a1de-bddbe7ec9770@linux.intel.com>
Date: Thu, 23 Jun 2022 09:47:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, jgg@nvidia.com, iommu@lists.linux.dev,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfio: Use device_iommu_capable()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
 <910aef11138e3b6702b29a3e78415235aa4bf773.1655898523.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <910aef11138e3b6702b29a3e78415235aa4bf773.1655898523.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220623014702.JQgHzWCReHHishK__Ym1iMCpM9BlA4QJlso3qI8aSEQ@z>

On 2022/6/22 20:04, Robin Murphy wrote:
> Use the new interface to check the capabilities for our device
> specifically.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/vfio/vfio.c             | 2 +-
>   drivers/vfio/vfio_iommu_type1.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 73bab04880d0..765d68192c88 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -621,7 +621,7 @@ int vfio_register_group_dev(struct vfio_device *device)
>   	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
>   	 * restore cache coherency.
>   	 */
> -	if (!iommu_capable(device->dev->bus, IOMMU_CAP_CACHE_COHERENCY))
> +	if (!device_iommu_capable(device->dev, IOMMU_CAP_CACHE_COHERENCY))
>   		return -EINVAL;
>   
>   	return __vfio_register_dev(device,
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e38b8bfde677..2107e95eb743 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2247,7 +2247,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   	list_add(&group->next, &domain->group_list);
>   
>   	msi_remap = irq_domain_check_msi_remap() ||
> -		    iommu_capable(iommu_api_dev->dev->bus, IOMMU_CAP_INTR_REMAP);
> +		    device_iommu_capable(iommu_api_dev->dev, IOMMU_CAP_INTR_REMAP);
>   
>   	if (!allow_unsafe_interrupts && !msi_remap) {
>   		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
