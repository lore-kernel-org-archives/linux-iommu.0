Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612A2F49
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678447999;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4S3SJNUbgNLYyhpATwshP+7xAKmJ12/+l9BB0p8/V4=;
	b=dEkSk4/vf9jaktPzCY2e8gFSURN2qUjfxB1MJPczr7lExp8iSpu/4EXA4JQQwfxYFuGZXU
	TooGNmFgfFCER+UUrLPM1VAzR04/9gs+AIIjUCEBznBI3dNMqD00zDbDoZbC4jR1LvLV4a
	8bEmPmZnVOrN6yOKqkyVMe5WiyiXXPg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-q9zaCrEPPB2o-5A7QjqciQ-1; Fri, 10 Mar 2023 06:33:18 -0500
X-MC-Unique: q9zaCrEPPB2o-5A7QjqciQ-1
Received: by mail-qt1-f199.google.com with SMTP id g11-20020ac8774b000000b003bfa92f56cbso2732025qtu.3
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 03:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678447998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4S3SJNUbgNLYyhpATwshP+7xAKmJ12/+l9BB0p8/V4=;
        b=RvYLnYs6hsNfxdOGf6tXe2pOdHRy3pnXlMKLqQVwX2Pi8MyKIz4FfDUVPLjak7ens5
         Dwp3NdOORLoqAG47OziFdRWHVL25HOSX895DtZDUciCBi3d+b9rwuaRJ2DLXRHOxiHMh
         7rNdT8pmtd0vCAkZavJ+zMq/MQdbxmNDWd9QvQB/8+AcA/H7kSb7UMnRUorTR585x6ud
         kO2mpyqMbDFqzEwUGiAk3+wbM/wN6vYGmDuVCjqJe1ZwesmfQ5wQ3QL0YI+YKKSMCNOl
         cPRsJbEyHtljFB9MVxojbgXcHi7EIKDX2IVa9oEtDMpFzTP96pzLq7xCYTl1d1LBGZ1p
         g/hQ==
X-Gm-Message-State: AO0yUKUSdWbMCrqOIUhgLtMbdyBhLX9jRjIO6TASE3sk7z+KDV5XQvFL
	/tTo7ZZJKQuwyIFXT/MS3M/9U65grCpTvmrPQ0J+IeB/GHG40rSdbudaMA3vhGVrkGmz+z01zJ9
	dC67GRjp7wj9LAEs=
X-Received: by 2002:a05:6214:252c:b0:56e:fb4c:c1c4 with SMTP id gg12-20020a056214252c00b0056efb4cc1c4mr17633036qvb.14.1678447997929;
        Fri, 10 Mar 2023 03:33:17 -0800 (PST)
X-Google-Smtp-Source: AK7set+ObrN18F32cy+WpRBzCha3lX+Kgx4jipHI9s53RhcUyjRx5aXFaUu+xqai/SF8up4rIR787Q==
X-Received: by 2002:a05:6214:252c:b0:56e:fb4c:c1c4 with SMTP id gg12-20020a056214252c00b0056efb4cc1c4mr17633010qvb.14.1678447997662;
        Fri, 10 Mar 2023 03:33:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id y20-20020a37f614000000b0074308a0124asm1152231qkj.50.2023.03.10.03.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 03:33:17 -0800 (PST)
Message-ID: <5288c0e9-b806-370d-e7de-8d69d5b8e902@redhat.com>
Date: Fri, 10 Mar 2023 12:33:12 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, robin.murphy@arm.com, will@kernel.org,
 kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 shameerali.kolothum.thodi@huawei.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, yi.l.liu@intel.com
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230309134217.GA1673607@myrica>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
On 3/9/23 14:42, Jean-Philippe Brucker wrote:
> Hi Nicolin,
>
> On Thu, Mar 09, 2023 at 02:53:38AM -0800, Nicolin Chen wrote:
>> Add the following data structures for corresponding ioctls:
>>                iommu_hwpt_arm_smmuv3 => IOMMUFD_CMD_HWPT_ALLOC
>>     iommu_hwpt_invalidate_arm_smmuv3 => IOMMUFD_CMD_HWPT_INVALIDATE
>>
>> Also, add IOMMU_HW_INFO_TYPE_ARM_SMMUV3 and IOMMU_PGTBL_TYPE_ARM_SMMUV3_S1
>> to the header and corresponding type/size arrays.
>>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> +/**
>> + * struct iommu_hwpt_arm_smmuv3 - ARM SMMUv3 specific page table data
>> + *
>> + * @flags: page table entry attributes
>> + * @s2vmid: Virtual machine identifier
>> + * @s1ctxptr: Stage-1 context descriptor pointer
>> + * @s1cdmax: Number of CDs pointed to by s1ContextPtr
>> + * @s1fmt: Stage-1 Format
>> + * @s1dss: Default substream
>> + */
>> +struct iommu_hwpt_arm_smmuv3 {
>> +#define IOMMU_SMMUV3_FLAG_S2	(1 << 0) /* if unset, stage-1 */
> I don't understand the purpose of this flag, since the structure only
> provides stage-1 configuration fields
>
>> +#define IOMMU_SMMUV3_FLAG_VMID	(1 << 1) /* vmid override */
> Doesn't this break isolation?  The VMID space is global for the SMMU, so
> the guest could access cached mappings of another device
>
>> +	__u64 flags;
>> +	__u32 s2vmid;
>> +	__u32 __reserved;
>> +	__u64 s1ctxptr;
>> +	__u64 s1cdmax;
>> +	__u64 s1fmt;
>> +	__u64 s1dss;
>> +};
>> +
>
>> +/**
>> + * struct iommu_hwpt_invalidate_arm_smmuv3 - ARM SMMUv3 cahce invalidation info
>> + * @flags: boolean attributes of cache invalidation command
>> + * @opcode: opcode of cache invalidation command
>> + * @ssid: SubStream ID
>> + * @granule_size: page/block size of the mapping in bytes
>> + * @range: IOVA range to invalidate
>> + */
>> +struct iommu_hwpt_invalidate_arm_smmuv3 {
>> +#define IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF	(1 << 0)
>> +	__u64 flags;
>> +	__u8 opcode;
>> +	__u8 padding[3];
>> +	__u32 asid;
>> +	__u32 ssid;
>> +	__u32 granule_size;
>> +	struct iommu_iova_range range;
>> +};
> Although we can keep the alloc and hardware info separate for each IOMMU
> architecture, we should try to come up with common invalidation methods.
>
> It matters because things like vSVA, or just efficient dynamic mappings,
> will require optimal invalidation latency. A paravirtual interface like
> vhost-iommu can help with that, as the host kernel will handle guest
> invalidations directly instead of doing a round-trip to host userspace
> (and we'll likely want the same path for PRI.)
>
> Supporting HW page tables for a common PV IOMMU does require some
> architecture-specific knowledge, but invalidation messages contain roughly
> the same information on all architectures. The PV IOMMU won't include
> command opcodes for each possible architecture if one generic command does
> the same job.
>
> Ideally I'd like something like this for vhost-iommu:
>
> * slow path through userspace for complex requests like attach-table and
>   probe, where the VMM can decode arch-specific information and translate
>   them to iommufd and vhost-iommu ioctls to update the configuration.
>
> * fast path within the kernel for performance-critical requests like
>   invalidate, page request and response. It would be absurd for the
>   vhost-iommu driver to translate generic invalidation requests from the
>   guest into arch-specific commands with special opcodes, when the next
>   step is calling the IOMMU driver which does that for free.
>
> During previous discussions we came up with generic invalidations that
> could fit both Arm and x86 [1][2]. The only difference was the ASID
> (called archid/id in those proposals) which VT-d didn't need. Could we try
> to build on that?

I do agree with Jean. We spent a lot of efforts all together to define
this generic invalidation API and if there is compelling reason that
prevents from using it, we should try to reuse it.

Thanks

Eric
>
> [1] https://elixir.bootlin.com/linux/v5.17/source/include/uapi/linux/iommu.h#L161
> [2] https://lists.oasis-open.org/archives/virtio-dev/202102/msg00014.html
>
> Thanks,
> Jean
>

