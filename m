Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90EA492
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 20:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669668867;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk+d/rFoCYdetXFV05zVEMLzTOsjcYxe9wmFRI7Nhmk=;
	b=atI6k6iDz0MObPILQ+0s1r8d8RbwB5U2i+8jnSccMxT3+xTG4HwadR8dm3G9XUIFgUkAKK
	zsO+cB4ArrqndAamRGzMqDqiZwbJ8CPLxcT4f6ptMz9qYJDTxoDwgEPoYSSiIPJQdXjDIB
	JAmSiptn9E4uloQf6BDLKplmmhPePIY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-128-8rSuioLKMG2azAdD0FvYFQ-1; Mon, 28 Nov 2022 15:54:25 -0500
X-MC-Unique: 8rSuioLKMG2azAdD0FvYFQ-1
Received: by mail-qk1-f198.google.com with SMTP id bj4-20020a05620a190400b006fc7c5d454cso8040822qkb.14
        for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 12:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mk+d/rFoCYdetXFV05zVEMLzTOsjcYxe9wmFRI7Nhmk=;
        b=a8eAVscq7ZNaeJ9R8P4C0ESnEVkX9pQLWTleIZut9gL2xwoJjAlnVjiG9R8oseOmDy
         ds+BQSJNoVB6kSapXF3Sygu7kd4zs/tw6A+0grWbRXMdU1XXh9I96zSxYWWkqwHZoBoq
         W/LxRvHE6uq3hFsN0TJXh2p32zHqH4zu1rYUM2DgWYQDLHhbZFEA/KiIdlSRoPvLLRxg
         1Y6gupUxkMKqHSayB3126C0wbZex0skHYQ+jo60jMAtanDk7R/rYanK1HW7C/EDH5v3b
         9cAeBR7Jcx7rGsSE6Y1NXNyp93XFcVuYRlardDXj9nMqMFAcxZW4ie/9pCYnTBs32ZSF
         azog==
X-Gm-Message-State: ANoB5pkVLwMzXbQthLIJ6H9AonjoJ3bHAWl6FzbM8WiCFji6ZZ6rZVRD
	FvOcwddNYbIcbdn14fEKAeas1rYPF9jcwFVV+tKOlm/Wxnkb9k5PYL6pNDNgMAmzbw3fCh1vdNI
	rC5l59rJjDAe3cB0=
X-Received: by 2002:a05:6214:80c:b0:4c6:c6b5:1188 with SMTP id df12-20020a056214080c00b004c6c6b51188mr25489144qvb.13.1669668865285;
        Mon, 28 Nov 2022 12:54:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6adcRSfyKR21I2fxnpGfrzzGKRaVH1wA0cwJsYkdX3ndgETdx+KZHJZih2LovlXvvfBOZy0g==
X-Received: by 2002:a05:6214:80c:b0:4c6:c6b5:1188 with SMTP id df12-20020a056214080c00b004c6c6b51188mr25489104qvb.13.1669668865045;
        Mon, 28 Nov 2022 12:54:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ay39-20020a05620a17a700b006f7ee901674sm9247466qkb.2.2022.11.28.12.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 12:54:23 -0800 (PST)
Message-ID: <2a0a70e7-be3b-6c7d-2649-d24d06be9855@redhat.com>
Date: Mon, 28 Nov 2022 21:54:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Farman <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>, Joao Martins
 <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <81f898b6-e40f-be72-78d4-b5d836981d8f@redhat.com>
 <Y4UN4qVpNqTP/JEF@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Y4UN4qVpNqTP/JEF@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/28/22 20:37, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 06:53:12PM +0100, Eric Auger wrote:
>
>>> +static int iommufd_vfio_map_dma(struct iommufd_ctx *ictx, unsigned int cmd,
>>> +				void __user *arg)
>>> +{
>>> +	u32 supported_flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
>>> +	size_t minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
>>> +	struct vfio_iommu_type1_dma_map map;
>>> +	int iommu_prot = IOMMU_CACHE;
>>> +	struct iommufd_ioas *ioas;
>>> +	unsigned long iova;
>>> +	int rc;
>>> +
>>> +	if (copy_from_user(&map, arg, minsz))
>>> +		return -EFAULT;
>>> +
>>> +	if (map.argsz < minsz || map.flags & ~supported_flags)
>>> +		return -EINVAL;
>>> +
>>> +	if (map.flags & VFIO_DMA_MAP_FLAG_READ)
>>> +		iommu_prot |= IOMMU_READ;
>>> +	if (map.flags & VFIO_DMA_MAP_FLAG_WRITE)
>>> +		iommu_prot |= IOMMU_WRITE;
>>> +
>>> +	ioas = get_compat_ioas(ictx);
>>> +	if (IS_ERR(ioas))
>>> +		return PTR_ERR(ioas);
>>> +
>>> +	/*
>>> +	 * Maps created through the legacy interface always use VFIO compatible
>>> +	 * rlimit accounting. If the user wishes to use the faster user based
>>> +	 * rlimit accounting then they must use the new interface.
>> s/they/he
> "they" has become a common neutral singular pronoun in English.

Oh OK.
>
>>> +static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
>>> +				  void __user *arg)
>>> +{
>>> +	size_t minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
>>> +	/*
>>> +	 * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is obsoleted by the new
>>> +	 * dirty tracking direction:
>>> +	 *  https://lore.kernel.org/kvm/20220731125503.142683-1-yishaih@nvidia.com/
>>> +	 *  https://lore.kernel.org/kvm/20220428210933.3583-1-joao.m.martins@oracle.com/
>>> +	 */
>>> +	u32 supported_flags = VFIO_DMA_UNMAP_FLAG_ALL;
>>> +	struct vfio_iommu_type1_dma_unmap unmap;
>>> +	unsigned long unmapped = 0;
>>> +	struct iommufd_ioas *ioas;
>>> +	int rc;
>>> +
>>> +	if (copy_from_user(&unmap, arg, minsz))
>>> +		return -EFAULT;
>>> +
>>> +	if (unmap.argsz < minsz || unmap.flags & ~supported_flags)
>>> +		return -EINVAL;
>>> +
>>> +	ioas = get_compat_ioas(ictx);
>>> +	if (IS_ERR(ioas))
>>> +		return PTR_ERR(ioas);
>>> +
>>> +	if (unmap.flags & VFIO_DMA_UNMAP_FLAG_ALL) {
>>> +		if (unmap.iova != 0 || unmap.size != 0) {
>>> +			rc = -EINVAL;
>>> +			goto err_put;
>>> +		}
>>> +		rc = iopt_unmap_all(&ioas->iopt, &unmapped);
>>> +	} else {
>>> +		if (READ_ONCE(ioas->iopt.disable_large_pages)) {
>>> +			unsigned long iovas[] = { unmap.iova + unmap.size - 1,
>>> +						  unmap.iova - 1 };
>>> +
>>> +			rc = iopt_cut_iova(&ioas->iopt, iovas,
>>> +					   unmap.iova ? 2 : 1);
>> please can you add a comment to explain what this is supposed to do?
> iova -1 when iova == 0 will underflow and becomes garbage
>
> 			/*
> 			 * Create cuts at the start and last of the requested
> 			 * range. If the start IOVA is 0 then it doesn't need to
> 			 * be cut.
> 			 */

OK thanks
>
>>> +static int iommufd_vfio_set_iommu(struct iommufd_ctx *ictx, unsigned long type)
>>> +{
>>> +	struct iommufd_ioas *ioas = NULL;
>>> +	int rc = 0;
>>> +
>>> +	if (type != VFIO_TYPE1_IOMMU && type != VFIO_TYPE1v2_IOMMU)
>>> +		return -EINVAL;
>>> +
>>> +	/* VFIO fails the set_iommu if there is no group */
>>> +	ioas = get_compat_ioas(ictx);
>>> +	if (IS_ERR(ioas))
>>> +		return PTR_ERR(ioas);
>>> +	if (type == VFIO_TYPE1_IOMMU)
>>> +		rc = iopt_disable_large_pages(&ioas->iopt);
>> please can you document/explain this setting?
> 	/*
> 	 * The difference between TYPE1 and TYPE1v2 is the ability to unmap in
> 	 * the middle of mapped ranges. This is complicated by huge page support
> 	 * which creates single large IOPTEs that cannot be split by the iommu
> 	 * driver. TYPE1 is very old at this point and likely nothing uses it,
> 	 * however it is simple enough to emulate by simply disabling the
> 	 * problematic large IOPTEs. Then we can safely unmap within any range.
OK makes sense. That's helpful

with those additions,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


> 	 */
>
> Thanks,
> Jason
>

