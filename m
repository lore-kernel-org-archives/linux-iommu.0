Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871821E092
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619169; cv=none; b=Jx0wYXoD82N8GGHVzer+mTK4isxTO7Ntih1G/eWb+1MGC+/qRygy5xza8k0kB0232ydTcmFZj7ZML3OHGxhgIBgjvJr5eiOys110GmrIzCZU6AAkjXMI1PV6vC2060dmP4cdIDtGI5x6xSCmou03D74Y45wOaPrzkzoFXb+KLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619169; c=relaxed/simple;
	bh=WnCQv/xgSpGCbHwz6yDpf1vARBG8hTZ3pYokNi2kzqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNvr1rmNVHT7ZJyP8hmholEe1yb2Ad7jQonAobviioS0Xcg2DF5bY0Bl5v1MABSFziPQRERzAOcSI6SSdjYFUPuoBQ7dicYSKwqo0HkIKeudCTp4jAJoXkWp3mE5Z/RrzKVl/hzZPvIVFwE1tFSFtbCtm2s8v0FC1y2O6TrcmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E10516F2;
	Mon, 10 Mar 2025 08:06:18 -0700 (PDT)
Received: from [10.57.39.174] (unknown [10.57.39.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15A23F5A1;
	Mon, 10 Mar 2025 08:06:02 -0700 (PDT)
Message-ID: <8bb8dfcb-bc44-48f2-acdb-58e6d259d25b@arm.com>
Date: Mon, 10 Mar 2025 15:06:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/12] drm/gem: Add cgroup memory accounting
To: Maxime Ripard <mripard@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tomasz Figa <tfiga@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20250310-dmem-cgroups-v1-0-2984c1bc9312@kernel.org>
 <20250310-dmem-cgroups-v1-11-2984c1bc9312@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250310-dmem-cgroups-v1-11-2984c1bc9312@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-10 12:06 pm, Maxime Ripard wrote:
> In order to support any device using the GEM support, let's charge any
> GEM DMA allocation into the dmem cgroup.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_gem.c            | 5 +++++
>   drivers/gpu/drm/drm_gem_dma_helper.c | 6 ++++++
>   include/drm/drm_device.h             | 1 +
>   include/drm/drm_gem.h                | 2 ++
>   4 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index ee811764c3df4b4e9c377a66afd4967512ba2001..e04733cb49353cf3ff9672d883b106a083f80d86 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -108,10 +108,11 @@ drm_gem_init(struct drm_device *dev)
>   	dev->vma_offset_manager = vma_offset_manager;
>   	drm_vma_offset_manager_init(vma_offset_manager,
>   				    DRM_FILE_PAGE_OFFSET_START,
>   				    DRM_FILE_PAGE_OFFSET_SIZE);
>   
> +
>   	return drmm_add_action(dev, drm_gem_init_release, NULL);
>   }
>   
>   /**
>    * drm_gem_object_init_with_mnt - initialize an allocated shmem-backed GEM
> @@ -973,10 +974,14 @@ drm_gem_release(struct drm_device *dev, struct drm_file *file_private)
>    * drm_gem_object_init().
>    */
>   void
>   drm_gem_object_release(struct drm_gem_object *obj)
>   {
> +
> +	if (obj->cgroup_pool_state)
> +		dmem_cgroup_uncharge(obj->cgroup_pool_state, obj->size);
> +
>   	if (obj->filp)
>   		fput(obj->filp);
>   
>   	drm_gem_private_object_fini(obj);
>   
> diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
> index 16988d316a6dc702310fa44c15c92dc67b82802b..6236feb67ddd6338f0f597a0606377e0352ca6ed 100644
> --- a/drivers/gpu/drm/drm_gem_dma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_dma_helper.c
> @@ -104,10 +104,16 @@ __drm_gem_dma_create(struct drm_device *drm, size_t size, bool private)
>   	if (ret) {
>   		drm_gem_object_release(gem_obj);
>   		goto error;
>   	}
>   
> +	ret = dmem_cgroup_try_charge(dma_get_dmem_cgroup_region(drm->dev),
> +				     size,
> +				     &dma_obj->base.cgroup_pool_state, NULL);
> +	if (ret)
> +		goto error;

Doesn't that miss cleaning up gem_obj? However, surely you want the 
accounting before the allocation anyway, like in the other cases. 
Otherwise userspace is still able to allocate massive amounts of memory 
and incur some of the associated side-effects of that, it just doesn't 
get to keep said memory for very long :)

Thanks,
Robin.

> +
>   	return dma_obj;
>   
>   error:
>   	kfree(dma_obj);
>   	return ERR_PTR(ret);
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index c91f87b5242d7a499917eb4aeb6ca8350f856eb3..58987f39ba8718eb768f6261fb0a1fbf16b38549 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -1,8 +1,9 @@
>   #ifndef _DRM_DEVICE_H_
>   #define _DRM_DEVICE_H_
>   
> +#include <linux/cgroup_dmem.h>
>   #include <linux/list.h>
>   #include <linux/kref.h>
>   #include <linux/mutex.h>
>   #include <linux/idr.h>
>   
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index fdae947682cd0b7b06db5e35e120f049a0f30179..95fe8ed48a26204020bb47d6074689829c410465 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -430,10 +430,12 @@ struct drm_gem_object {
>   	 * @lru:
>   	 *
>   	 * The current LRU list that the GEM object is on.
>   	 */
>   	struct drm_gem_lru *lru;
> +
> +	struct dmem_cgroup_pool_state *cgroup_pool_state;
>   };
>   
>   /**
>    * DRM_GEM_FOPS - Default drm GEM file operations
>    *
> 

