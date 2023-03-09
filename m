Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A3947A
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 13:42:19 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id q16so1920787wrw.2
        for <iommu@lists.linux.dev>; Thu, 09 Mar 2023 05:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678369337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYRhZ+LQKcNjJquoMvKplAWc0Q0BGJcYCcN6PUzcrU0=;
        b=G4hEzH03S6LjSKf3OpeDK0GSaJY6+RnEVsEI34ZGb+KPmZi1JHg1/3wWPX07D7EDb0
         q+zmu3Hd8w1Igy4pfmEN+OGuqnxa16a6XbJjpkZnKYoevxKe/IvU2zW3oHmjo9toFIK1
         VBdCWmv37Wqs1Y3RYn+LkfI2YB6FEba24EKFoqyeJMPvjgPzg93jWqi2GhKamlPikqa3
         7ps9t3681jWMahnZoL45dJkV2NGaCRS7fs8ECdIvdr+ZLC1d48Q7Rd124P0MHnHyGFNR
         PHSwkVAN1GUyCiVx3k4Adk/T7PTt5gG4Uy5tuEIiw85WRkmCOdhmUFS0sV69VKtR/cf/
         09nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYRhZ+LQKcNjJquoMvKplAWc0Q0BGJcYCcN6PUzcrU0=;
        b=kSHeMbKRAOjUE2OYP1R5DJdzgcHt6xlFNn+rMxjxWy39Ouly/52Gxyrn5cdwcSBAzl
         SehXAlLUbVYgCdMmXkTVGLJk6QxZlzp6J56WgIaySqOhciJ3R7o6NIm+u3PmT5QtSeFw
         kaKyck1i4QzkbEiC4CEpmgQ/bsvSoF5wWIGBRYZR3Kjhp4XDaEGeQY3L+2KXjGtYgbPP
         ZRdBX5i2m+Ei9Rovr4Kh/zrfCL3MI5HHO/F2D0hi8TaIYrqXGQtwrhP5+0itxgH4mlWj
         NALDUDXpIoNfPhE8fxIbzO/xBeFYKogNMPcv1Hm8EqUqJSKEgDK61p3mFPe66f6nqyvS
         O6WA==
X-Gm-Message-State: AO0yUKXtHpghCWGt8yPVVVd3QUJsLHkXZlS/D5++zaUj76df/6ut23C0
	lE9DEWKP991CXGLDcEFUzJmprg==
X-Google-Smtp-Source: AK7set9Rn2XbNH+GCzRxmbwEIXEYIywyUUAvuLxkZ7tB/bsYVtC/eaDuRU1SybiJl+td9URPJo0m9Q==
X-Received: by 2002:a5d:4a51:0:b0:2c7:ca2:1a28 with SMTP id v17-20020a5d4a51000000b002c70ca21a28mr13999073wrs.68.1678369336941;
        Thu, 09 Mar 2023 05:42:16 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d61c9000000b002c54911f50bsm18042908wrv.84.2023.03.09.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:42:16 -0800 (PST)
Date: Thu, 9 Mar 2023 13:42:17 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, robin.murphy@arm.com, will@kernel.org,
	eric.auger@redhat.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, joro@8bytes.org,
	shameerali.kolothum.thodi@huawei.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <20230309134217.GA1673607@myrica>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>

Hi Nicolin,

On Thu, Mar 09, 2023 at 02:53:38AM -0800, Nicolin Chen wrote:
> Add the following data structures for corresponding ioctls:
>                iommu_hwpt_arm_smmuv3 => IOMMUFD_CMD_HWPT_ALLOC
>     iommu_hwpt_invalidate_arm_smmuv3 => IOMMUFD_CMD_HWPT_INVALIDATE
> 
> Also, add IOMMU_HW_INFO_TYPE_ARM_SMMUV3 and IOMMU_PGTBL_TYPE_ARM_SMMUV3_S1
> to the header and corresponding type/size arrays.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

> +/**
> + * struct iommu_hwpt_arm_smmuv3 - ARM SMMUv3 specific page table data
> + *
> + * @flags: page table entry attributes
> + * @s2vmid: Virtual machine identifier
> + * @s1ctxptr: Stage-1 context descriptor pointer
> + * @s1cdmax: Number of CDs pointed to by s1ContextPtr
> + * @s1fmt: Stage-1 Format
> + * @s1dss: Default substream
> + */
> +struct iommu_hwpt_arm_smmuv3 {
> +#define IOMMU_SMMUV3_FLAG_S2	(1 << 0) /* if unset, stage-1 */

I don't understand the purpose of this flag, since the structure only
provides stage-1 configuration fields

> +#define IOMMU_SMMUV3_FLAG_VMID	(1 << 1) /* vmid override */

Doesn't this break isolation?  The VMID space is global for the SMMU, so
the guest could access cached mappings of another device

> +	__u64 flags;
> +	__u32 s2vmid;
> +	__u32 __reserved;
> +	__u64 s1ctxptr;
> +	__u64 s1cdmax;
> +	__u64 s1fmt;
> +	__u64 s1dss;
> +};
> +


> +/**
> + * struct iommu_hwpt_invalidate_arm_smmuv3 - ARM SMMUv3 cahce invalidation info
> + * @flags: boolean attributes of cache invalidation command
> + * @opcode: opcode of cache invalidation command
> + * @ssid: SubStream ID
> + * @granule_size: page/block size of the mapping in bytes
> + * @range: IOVA range to invalidate
> + */
> +struct iommu_hwpt_invalidate_arm_smmuv3 {
> +#define IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF	(1 << 0)
> +	__u64 flags;
> +	__u8 opcode;
> +	__u8 padding[3];
> +	__u32 asid;
> +	__u32 ssid;
> +	__u32 granule_size;
> +	struct iommu_iova_range range;
> +};

Although we can keep the alloc and hardware info separate for each IOMMU
architecture, we should try to come up with common invalidation methods.

It matters because things like vSVA, or just efficient dynamic mappings,
will require optimal invalidation latency. A paravirtual interface like
vhost-iommu can help with that, as the host kernel will handle guest
invalidations directly instead of doing a round-trip to host userspace
(and we'll likely want the same path for PRI.)

Supporting HW page tables for a common PV IOMMU does require some
architecture-specific knowledge, but invalidation messages contain roughly
the same information on all architectures. The PV IOMMU won't include
command opcodes for each possible architecture if one generic command does
the same job.

Ideally I'd like something like this for vhost-iommu:

* slow path through userspace for complex requests like attach-table and
  probe, where the VMM can decode arch-specific information and translate
  them to iommufd and vhost-iommu ioctls to update the configuration.

* fast path within the kernel for performance-critical requests like
  invalidate, page request and response. It would be absurd for the
  vhost-iommu driver to translate generic invalidation requests from the
  guest into arch-specific commands with special opcodes, when the next
  step is calling the IOMMU driver which does that for free.

During previous discussions we came up with generic invalidations that
could fit both Arm and x86 [1][2]. The only difference was the ASID
(called archid/id in those proposals) which VT-d didn't need. Could we try
to build on that?

[1] https://elixir.bootlin.com/linux/v5.17/source/include/uapi/linux/iommu.h#L161
[2] https://lists.oasis-open.org/archives/virtio-dev/202102/msg00014.html

Thanks,
Jean

