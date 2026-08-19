Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651E3F3280
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128463; cv=none; b=MOIOKA3ZwD2Crclw0ZwezpR+2lwifgCCPdbS3zX+t3Q5BqCKHXY1ZFiTURxsksow5gZeLPp15b+ged7w5ndDC8sRbzarJgxIh++UBAr1eV3+s9WQaYyhprpetGljkE+ZlfAs3UUO2qCMz9ksFpA8CbVw5r+TRNmmmUKldZXgjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128463; c=relaxed/simple;
	bh=EaGw682j6MlUv++8RDnZioYv1J5TcRZAv15rsB71zKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqsMSxE84LykyZED9eZ+KT1aXiK9Nbp0NfW9luT4wbjXgWG2hGiC8KXKzrRlrWDSyOyv1OjgEALRyg9sMJ6zqMOqBvgysHI5aWCCSQJGWvmWQ31LnwE8taDaQyXgZo5LEu5RiW82LqCShUDtfYpzWNA3LdMN0nomzqQSPmGTvzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xRpOEscy; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xRpOEscy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787128451; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u/0xqxfijubrFyICLEnBEqMNciRFom3VvwPTe9jq26o=;
	b=xRpOEscymu7A/AygBy82QH/Gwe2nppjl6XghJtUY5NhSUK0YbfRybU5+Fa4yfbsLReG35QpcSkxjNcoIcA5Oqb+AVbGj/mRVOBWK8UplEnorn48++svrqOb4Dvf0s4jJ4G6hOX7Mh7KjMUWfnrr+zdNEahKytDRK13LJIFvh06Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9G499f_1787128449;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9G499f_1787128449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 16:34:10 +0800
Message-ID: <0bc1f0c9-b52b-4369-83f1-822c67bf1151@linux.alibaba.com>
Date: Wed, 19 Aug 2026 16:34:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] iommu/amd: Introduce Reset vMMIO Command
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-9-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-9-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:28, Suravee Suthikulpanit 写道:
> Introduce new IOMMU commands for vIOMMU to reset
> virtualized MMIO registers of a particular guest.
>
> Reviewed-by: Weinan Liu <wnliu@google.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu.h       |  1 +
>   drivers/iommu/amd/amd_iommu_types.h |  1 +
>   drivers/iommu/amd/iommu.c           | 22 ++++++++++++++++++++++
>   drivers/iommu/amd/iommufd.c         |  3 +++
>   4 files changed, 27 insertions(+)
>
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 044bc9a634a1..2ce207529ea0 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -11,6 +11,7 @@
>   
>   #include "amd_iommu_types.h"
>   
> +void iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid);
>   extern int amd_iommu_evtlog_size;
>   extern int amd_iommu_pprlog_size;
>   
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index cc7049bbfa14..44fa1d6c64d6 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -218,6 +218,7 @@
>   #define CMD_INV_IRT		0x05
>   #define CMD_COMPLETE_PPR	0x07
>   #define CMD_INV_ALL		0x08
> +#define CMD_RESET_VMMIO		0x0A
>   
>   #define CMD_COMPL_WAIT_STORE_MASK	0x01
>   #define CMD_COMPL_WAIT_INT_MASK		0x02
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 73fba8be40d1..6f5ecc48f4ad 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1428,6 +1428,18 @@ static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
>   	CMD_SET_TYPE(cmd, CMD_INV_IRT);
>   }
>   
> +static void build_reset_vmmio(struct iommu_cmd *cmd, u16 gid,
> +			      bool vcmd, bool all)
> +{
> +	memset(cmd, 0, sizeof(*cmd));
> +	cmd->data[0] = gid;
> +	if (all)
> +		cmd->data[0] |= (1 << 28);
> +	if (vcmd)
> +		cmd->data[0] |= (1 << 31);
> +	CMD_SET_TYPE(cmd, CMD_RESET_VMMIO);
> +}

This looks like a bug. Per the AMD IOMMU Specification (Rev 3.10,
Section 2.4.10), the 'All' bit of the RESET_VMMIO command is at bit
position 27, not bit 28. Writing bit 28 targets a reserved field and
may either trigger an ILLEGAL_COMMAND_ERROR or silently fail to reset
the full vIOMMU context. This should be:

     if (all)
         cmd->data[0] |= (1 << 27);


> +
>   /*
>    * Writes the command to the IOMMUs command buffer and informs the
>    * hardware about the new command.
> @@ -1668,6 +1680,16 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
>   	}
>   }
>   
> +void iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid)
> +{
> +	struct iommu_cmd cmd;
> +
> +	build_reset_vmmio(&cmd, gid, 1, 1);
> +
> +	iommu_queue_command(iommu, &cmd);
> +	amd_iommu_completion_wait(iommu);
> +}
> +

Both iommu_queue_command() and amd_iommu_completion_wait() return
status, but iommu_reset_vmmio() returns void and ignores them. A
failed reset during vIOMMU init would go unnoticed. Consider
propagating the error to the caller.


>   /*
>    * Command send function for flushing on-device TLB
>    */
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 9f76bfa1d6ea..81e0244348a2 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -80,6 +80,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>   
>   	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
>   
> +	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
> +	iommu_reset_vmmio(iommu, aviommu->gid);
> +
>   	ret = iommu_copy_struct_to_user(user_data, &data,
>   					IOMMU_VIOMMU_TYPE_AMD,
>   					out_vfmmio_mmap_offset);
