Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F104F5CA6
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 16:00:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BA77106F;
	Wed,  7 Sep 2022 09:00:11 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC7603F71A;
	Wed,  7 Sep 2022 09:00:03 -0700 (PDT)
Message-ID: <51e9861b-38c0-0f22-385f-d4b57106d57b@arm.com>
Date: Wed, 7 Sep 2022 16:59:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] iommu/virtio: Fix compile error with viommu_capable()
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220907151154.21911-1-joro@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220907151154.21911-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-07 16:11, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> A recent fix introduced viommu_capable() but other changes
> from Robin change the function signature of the call-back it
> is used for.
> 
> When both changes are merged a compile error will happen
> because the function pointer types mismatch. Fix that by
> updating the viommu_capable() signature after the merge.

I thought I'd called out somewhere that this was going to be a conflict, 
but apparently not, sorry about that.

Acked-by: Robin Murphy <robin.murphy@arm.com>

Lemme spin a patch for the outstanding LKP warning on the bus series 
before that gets annoying too...

> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/virtio-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index da463db9f12a..1b12825e2df1 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1005,7 +1005,7 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	return iommu_fwspec_add_ids(dev, args->args, 1);
>   }
>   
> -static bool viommu_capable(enum iommu_cap cap)
> +static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	switch (cap) {
>   	case IOMMU_CAP_CACHE_COHERENCY:
