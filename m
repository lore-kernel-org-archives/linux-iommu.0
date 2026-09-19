Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BA36683B
	for <iommu@lists.linux.dev>; Sat, 19 Sep 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789830682; cv=none; b=K21ytx75iRpRqA8yAXnvsnc/ymbS8qLvSm+FBgJYwsMcnfSL3Q1Qwsc1YZtyRy0FTxpJzzwMLovXRVxo8E2MgXZFTKVw2ZLj3B5ylVh+o6rSBACcWRVhXJYk8j6UYyuKDSlMCqto282sPsr2YP5IJMJIm9B9AmiuKH93aUheCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789830682; c=relaxed/simple;
	bh=8wZJqZSzSHRygup1Zu7f1TDpbL+IqHKmSLFho4jUrjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggGVsK/qmSOyaPD5RTiOUY8+Z6Jj7q3kg/lQEZeem0sAi53M+RR7QizA2DEGKX4O8nh04Qq4y6B6gKYC9eTDo/b7fqSZubQL6s+WMi6X15fOqroH61tMp0A3F1CDG0V1BghlSwzjtxJFjhPb8e/OujwUiYpgJYITBhLS/fDQVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tRQEGsVg; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tRQEGsVg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789830670; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DGcNQVeXU9W3ier1CRk2vDl7OEviBed1e4AAP6u7S3w=;
	b=tRQEGsVgWZIvOOJuBgeA1H59MdC1tUvCTMRXazMYdDsV8zJg4d/zVxHoglRuD8R+kDpatyGctKT0HoZWKXewlOrfWNqPTz0u+KJCzY/94Yl4vMJFUAC36SLNFIKUxqA2rz9zQLtvb9k+FAEBaR48QryfDsfyeFaLy0VAvFjxLMw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0XBDlcBm_1789830666;
Received: from 30.42.81.123(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XBDlcBm_1789830666 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 19 Sep 2026 23:11:08 +0800
Message-ID: <d1f568a0-a273-4e4b-853d-5c826b2af50c@linux.alibaba.com>
Date: Sat, 19 Sep 2026 23:11:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/24] iommu/amd: Introduce Reset vMMIO Command
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-9-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260914184750.222939-9-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/15 2:47, Suravee Suthikulpanit 写道:
> Introduce new IOMMU commands for vIOMMU to reset
> virtualized MMIO registers of a particular guest.
> 
> Always program RESET_MMIO_ALL_FLAG and RESET_MMIO_VCMD_FLAG.
> Propagate iommu_completion_wait() errors to the caller.
> 
> Reviewed-by: Weinan Liu <wnliu@google.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu.h       |  1 +
>   drivers/iommu/amd/amd_iommu_types.h |  3 +++
>   drivers/iommu/amd/iommu.c           | 21 +++++++++++++++++++++
>   drivers/iommu/amd/iommufd.c         |  5 +++++
>   4 files changed, 30 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 51e4364e8564..8c298e090889 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -233,4 +233,5 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>   /* Guest ID for vIOMMU */
>   int amd_iommu_gid_alloc(struct amd_iommu *iommu);
>   void amd_iommu_gid_free(struct amd_iommu *iommu, int gid);
> +int amd_iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid);
>   #endif /* AMD_IOMMU_H */
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 3aaaf69a1e7d..9eb9a0c190de 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -209,6 +209,9 @@
>   #define CMD_INV_IRT		0x05
>   #define CMD_COMPLETE_PPR	0x07
>   #define CMD_INV_ALL		0x08
> +#define CMD_RESET_VMMIO		0x0A
> +#define RESET_MMIO_ALL_FLAG	BIT(28)

RESET_MMIO_ALL_FLAG is defined at the wrong bit position?

Per spec Section 2.4.10 (RESET_VMMIO Command), the data[0] dword layout is:
Bit 31     : VCmd  - Reset virtual command buffer for the specific Guest
Bits 30:28 : Reserved
Bit 27     : All (IAll) - Reset the whole virtual IOMMU for the specific 
Guest
Bits 26:16 : Reserved
Bits 15:0  : GuestID

The "All" bit is at position 27, not 28. Bit 28 falls within the 
Reserved field (30:28).As currently coded, build_reset_vmmio() sets bit 
28 (Reserved) and leaves bit 27 (All) clear. This means:
The intended "reset the whole virtual IOMMU" semantics (including 
clearing VMVld in VF Control MMIO Offset 10h) is never actually triggered.
Writing 1 to a Reserved bit has undefined behavior per the spec - it may 
be silently ignored or trigger an ILLEGAL_COMMAND_ERROR event depending 
on the implementation.

-#define RESET_MMIO_ALL_FLAG    BIT(28)
+#define RESET_MMIO_ALL_FLAG    BIT(27)


> +#define RESET_MMIO_VCMD_FLAG	BIT(31)
>   
>   #define CMD_COMPL_WAIT_STORE_MASK	0x01
>   #define CMD_COMPL_WAIT_INT_MASK		0x02
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index fa9708af258e..94c59f503662 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1517,6 +1517,13 @@ static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
>   	CMD_SET_TYPE(cmd, CMD_INV_IRT);
>   }
>   
> +static void build_reset_vmmio(struct iommu_cmd *cmd, u16 gid)
> +{
> +	memset(cmd, 0, sizeof(*cmd));
> +	cmd->data[0] = gid | RESET_MMIO_ALL_FLAG | RESET_MMIO_VCMD_FLAG;
> +	CMD_SET_TYPE(cmd, CMD_RESET_VMMIO);
> +}
> +
>   /*
>    * Writes the command to the IOMMUs command buffer and informs the
>    * hardware about the new command.
> @@ -1770,6 +1777,20 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
>   	}
>   }
>   
> +int amd_iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid)
> +{
> +	int ret;
> +	struct iommu_cmd cmd;
> +
> +	build_reset_vmmio(&cmd, gid);
> +
> +	ret = iommu_queue_command(iommu, &cmd);
> +	if (ret)
> +		return ret;
> +
> +	return iommu_completion_wait(iommu);
> +}
> +
>   /*
>    * Command send function for flushing on-device TLB
>    */
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 7f358e57efde..2e34491e3cf7 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -92,6 +92,11 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>   
>   	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
>   
> +	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
> +	ret = amd_iommu_reset_vmmio(iommu, aviommu->gid);
> +	if (ret)
> +		goto err_init;
> +
>   	ret = iommu_copy_struct_to_user(user_data, &data,
>   					IOMMU_VIOMMU_TYPE_AMD,
>   					out_vfmmio_mmap_offset);

