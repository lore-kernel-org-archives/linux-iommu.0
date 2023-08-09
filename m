Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C281800B;
	Wed,  9 Aug 2023 12:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87560C433C8;
	Wed,  9 Aug 2023 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691585754;
	bh=0TGWljw2l6/eB/viyhym3AwywMruS5XC4iJu1jmzqZc=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=AAqI6mguPx7dJ3F2ck7FwGBHB01OfbEsMcEX2pL/sw95I28WavHzg/p6SBg+mjQGK
	 l8MBfS+j9EVkG7PmYN2aIwl59leDKKEHY3t9HOB87OuXdOVIxSwTHY2sUv1Y3MzCwA
	 DTBJAXrt4mdwcfmxh05LmbGyWamD9p8tFW/t5pNOqsmVc4QOWou3GH3opqX+IvGB+O
	 XqTW8fK0Mq4jn3n7LWnEI15p7NKh/e8317BEK1//RMuUDH001nyllPoJk9YylLjTjH
	 UrLdWL5M3ZPbTQoTIT5/7wJLPDYT/xrv61GdVHiY9208nMSRbYeziH6shPSegaoAVg
	 QynX9dlWA2t/A==
Message-ID: <47692e15-3b3d-4d42-91dc-a1bd0f436039@kernel.org>
Date: Wed, 9 Aug 2023 14:55:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/10] iommu: Complete the locking for dev->iommu_group
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <9-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-sunxi@lists.linux.dev,
 Alex Williamson <alex.williamson@redhat.com>,
 Samuel Holland <samuel@sholland.org>, Heiko Stuebner <heiko@sntech.de>
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <9-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31.07.2023 19:50, Jason Gunthorpe wrote:
> Revise the locking for dev->iommu_group so that it has three safe ways to
> access it:
> 
>  - It is read by a probe'd device driver. So long as a device driver is
>    probed the dev->iommu_group will be guaranteed stable without further
>    locking.
> 
>  - Read under the device_lock(), this primarily protects against
>    parallel probe of the same device, and parallel probe/remove
> 
>  - Read/Write under the global dev_iommu_group_lock. This is used during
>    probe time discovery of groups. Device drivers will scan unlocked
>    portions of the device tree to locate an already existing group. These
>    scans can access the dev->iommu_group under the global lock to single
>    thread determining and installing the group. This ensures that groups
>    are reliably formed.
> 
> Narrow the scope of the global dev_iommu_group_lock to be only during the
> dev->iommu_group setup, and not for the entire probing.
> 
> Prior patches removed the various races inherent to the probe process by
> consolidating all the work under the group->mutex. In this configuration
> it is fine if two devices race to the group_device step of a new
> iommu_group, the group->mutex locking will ensure the group_device and
> domain setup part remains properly ordered.
> 
> Add the missing locking on the remove paths. For iommu_deinit_device() it
> is necessary to hold the dev_iommu_group_lock due to possible races during
> probe error unwind.
> 
> Fully lock the iommu_group_add/remove_device() path so we can use lockdep
> assertions. Other than lockdep this is redundant, VFIO no-iommu doesn't
> use group clustering.
> 
> For iommu_release_device() it is redundant, as we expect no external
> references to the struct device by this point, but it is harmless so
> add the missing lock to allow lockdep assertions to work.
> 
> This resolves the remarks of the comment in __iommu_probe_device().
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
Hello, this patch breaks booting on at least one Qualcomm platform using
the SMMUv2 driver w/ qcom impl. The board hangs right after SMMU probe.

Reverting it makes the platform boot again.

Konrad
