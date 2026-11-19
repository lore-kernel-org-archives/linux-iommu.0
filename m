Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111370;
	b=HJ7+yZrZNHnKLDsRPIbz8/rGCAJ3ifgehwNed6mzNsiCwQj9QE7oOQ+JZ5T0cnyh0upq
	 zvTBhe8JQkGLwhVrEk703FGMOdeDBcpYolPs513tDu3fFrmGiEoe1/S7K6u03mRPw1sQY
	 SKVR8ZYF+MJ9bP7PkWt15Hsa2tqTQfy9Bv7V5GExl7XHP7O2xS9CQzsqFAPNg+PF0X6Ps
	 bzTM/m3EUDoc+fqcOaKbKay8GTGu0YOd1YSr1HtXl4J06T9LRuR+0AXca+IPSb6R6Bmvg
	 vTqenfYXNj4+o57/5R8V1mzOYLfN+XcivIDpP6qzfcREjw0FGUJOyXok1K66Vpu0RqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=InfsSwOKE1v6TV2NrfByqErpltfDYpKmhyEWW16r+Go=;
	b=f+5Mi0IcCj0SE2iZvjaff+I4G0V5P4YZMxjJ78e0bI+P4Nh8S/DNjAahbBCACT0mwnGE
	 LDw+aQQYmgn2ab2w1J/IF5AfWWGoudLEFNclygxRdq6KdXYICDnb8Ra8s+iUiKE3+rtoH
	 kOuunAvV/O/b61J6IsujH/Snf0u7Xlz9yhMWlXokzUeIiqoGPhaoiHl/B5v6PIS0p8N3U
	 RRau/yKIClhIqpgS1bZstA4OkjPLJQ8TumzVMnqu+gSHXuTKwJpg1Mt7QoRqPmssbIvoX
	 1hML6+grdGe6yP5Zec92tfegr21Y76FQYZyYjpXfww5A+9D9jxRh1wyUg5w5XS7IY7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="T4D3UeK/";
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025E606A324
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 18:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9025E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T4D3UeK/
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdd9d0d40a4so13898a12.0
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 10:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795111369; x=1795716169; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=InfsSwOKE1v6TV2NrfByqErpltfDYpKmhyEWW16r+Go=;
        b=T4D3UeK/MYVwXcjgwZ+6sIqP4aA83gJtOtnzctj6Rz+WU7hi68QxyncOuSUNI1SfXD
         Bl/PwyWHapUvQR4CNo1sATVvvferBJTVdKcx5cQmJp4AV4zAyMGijMY3cjV/ap/FNiU8
         wMtxipYzhD3w8oQY7gVgJrAanJ2MzYCtRFMalLI2xO2HYxn7fkV+5DMh8HSQmRWEopcE
         BrmLKQRt8kVREyVu9PtbX9dq/rU/Wbxr9YZw/sLdAC+KHyO4TWsrV2CZxeLuMcmkh6Ko
         ednLdQNYt+c6P5fz6LulJCESwCGJBCQuAl0YKsy//mR4w3AMBUtMqz1kBJLxMIE0wf/3
         vAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795111369; x=1795716169;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InfsSwOKE1v6TV2NrfByqErpltfDYpKmhyEWW16r+Go=;
        b=wDKQS/mzfRUb7K0z3LCSm2AJLESzzryVspTkq/lFkXwK4yMtoOFkkc+R5ZRBC6m6af
         wkn3R23lY172vKYHpmSn9ZrJceUVAkXOu2Z51Bcxr656b/gge+injB6jKypgq2ZH1pi8
         M+qlwZLYsBZUtLKmli490gR2pAT4e4apjSqjyzZIMQkdIq8FKUyCDeJq58zUxWSzvPlL
         5EEMRuti0x2fYejrWFteFW+nER0RQdize3E5YE8uSOoDDS1sSj4ceWPtDF1DH5zLfyCW
         DI8G2+lnxNXUttXsulQKGveAx96YPGxwoyyLAT3BFSeg+Ccf1FWziq597yPk40LY8m+P
         d8CQ==
X-Forwarded-Encrypted: i=1; AL+hErE6PSGYF+4mhyzzx9YXPuLHFKqCEG06oPn+684ZmbhVsWVbQY/3yznzY+XfXUDq3etbR1shhg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/FjbYLdGFn4Ea6lyA5LUKDR9TLHwcwtYFVk9gPaRrqQDQj8x+S
	jDNSDf8x+8dytgvUqwtJkCuBYzspQUOREDK/doizFBiZVQZsje/7/k83
X-Gm-Gg: AYBFou0re1QQjDN0VyK6hrWPpLYzgOXQME4rXGjCocRdWWRibT37kUBALNuBl481c5f
	cY6neSeyfECAG7q/MQMYTJ0o9iLdKoNW8mNieeI2djz5UGncfsiAfm9cjetuOskePumt7pWWgVh
	nwktR8R6jv5k+1I+NLeHCUIF1BgaWA6fGd0aTI+8tU1D4HbUEB4jrl8faL+nypaP4TMcFpidnaO
	WFqpgtNdO6Je4eF+eVLSbO4qaSw93mJcAEsUqAuM7kgEvM2z7onipvE4Cd45L2mHaZXR/W0T47x
	T60RMSTXvcOTyzwK90AspiMdlnnXxO7HxVVp/fJtaR+g4WVSCOQ7COAKHighAiry7rhpPl+NM0H
	F1u7Nf4hsXK7wYhl98zDBaOw3nZCTeKhh0Pa7YvdOFcVMRWM4xrNzlpzY9VyjkpoSTbCdsH7MIH
	Lu3iDC4YQbdI9dYXwSCDbgDBT+gZ41EI8wq9ET7Of1kTkHJjCX16DTMzg2k4PqxsgWOycAi/7cX
	mGPygawoWR681oZeIoQEeHxNn+an4COB0Uc+Sd+IcXVZ0dUcFmqehEub8Z1Oi/zQ6wHKr95hv6i
	vFcEb66JeWDYeqiVsnj13vIhu6L12l4jilTan5DB7yf26ycg/PEuYpyXJS66EDmTs2Yr
X-Received: by 2002:a05:6a00:4c15:b0:8a0:73d7:aa7f with SMTP id d2e1a72fcca58-8c87ca50568mr392685b3a.41.1795111368332;
        Thu, 19 Nov 2026 10:02:48 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b27900sm258038b3a.47.2026.11.19.10.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 10:02:47 -0800 (PST)
Message-ID: <23b033cb-1b98-48cf-a089-4e710dfe3e15@gmail.com>
Date: Fri, 20 Nov 2026 02:02:00 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] iommu/riscv: support GSCID and GVMA invalidation
 command
To: fangyu.yu@linux.alibaba.com, gong.shuai@sanechips.com.cn
Cc: alex@ghiti.fr, andrew.jones@linux.dev, anup@brainfault.org,
 aou@eecs.berkeley.edu, atish.patra@linux.dev, baolu.lu@linux.intel.com,
 guoren@kernel.org, iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca,
 joerg.roedel@amd.com, joro@8bytes.org, jroedel@suse.de,
 kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 nutty.liu@hotmail.com, palmer@dabbelt.com, pjw@kernel.org,
 robin.murphy@arm.com, skhawaja@google.com, tanchi25@mails.ucas.ac.cn,
 tomasz.jeznach@linux.dev, vasant.hegde@amd.com, will@kernel.org,
 zong.li@sifive.com
References: <20261104092111.119394-1-gong.shuai@sanechips.com.cn>
 <20261104112712.68199-1-fangyu.yu@linux.alibaba.com>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20261104112712.68199-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/2026 7:27 PM, fangyu.yu@linux.alibaba.com wrote:
>>Hi Fangyu,
>>
>>> From: Zong Li <zong.li@sifive.com>
>>>
>>> This patch adds a ID Allocator for GSCID and a wrap for setting up
>>> GSCID in IOTLB invalidation command.
>>>
>>> Set up iohgatp to enable second stage table and flush stage-2 table if
>>> the GSCID is set.
>>>
>>> The GSCID of domain should be freed when release domain. GSCID will be
>>> allocated for parent domain in nested IOMMU process.
>>>
>>> Signed-off-by: Zong Li <zong.li@sifive.com>
>>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>>> ---
>>>  drivers/iommu/riscv/iommu-bits.h |  7 ++++
>>>  drivers/iommu/riscv/iommu.c      | 62 ++++++++++++++++++++++++++------
>>>  2 files changed, 58 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
>>> index f2ef9bd3cde9..65d1f2250011 100644
>>> --- a/drivers/iommu/riscv/iommu-bits.h
>>> +++ b/drivers/iommu/riscv/iommu-bits.h
>>> @@ -720,6 +720,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
>>>  	cmd->dword1 = 0;
>>>  }
>>>
>>> +static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
>>> +{
>>> +	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
>>> +		      FIELD_PREP(RISCV_IOMMU_CMD0_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
>>> +	cmd->dword1 = 0;
>>> +}
>>> +
>>>  static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
>>>  						  u64 addr)
>>>  {
>>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>>> index 918fce4aa8c4..5546dfcd976c 100644
>>> --- a/drivers/iommu/riscv/iommu.c
>>> +++ b/drivers/iommu/riscv/iommu.c
>>> @@ -49,6 +49,10 @@
>>>  static DEFINE_IDA(riscv_iommu_pscids);
>>>  #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
>>>
>>> +/* IOMMU GSCID allocation namespace. */
>>> +static DEFINE_IDA(riscv_iommu_gscids);
>>> +#define RISCV_IOMMU_MAX_GSCID		(BIT(16) - 1)
>>> +
>>>  /* Device resource-managed allocations */
>>>  struct riscv_iommu_devres {
>>>  	void *addr;
>>> @@ -842,6 +846,7 @@ struct riscv_iommu_domain {
>>>  	struct list_head bonds;
>>>  	spinlock_t lock;		/* protect bonds list updates. */
>>>  	int pscid;
>>> +	int gscid;
>>>  };
>>>  PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
>>>
>>> @@ -1004,7 +1009,7 @@ static void riscv_iommu_tlbi_calc(struct riscv_iommu_tlbi *tlbi,
>>>  }
>>>
>>>  static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
>>> -					  int pscid,
>>> +					  int pscid, int gscid,
>>>  					  struct riscv_iommu_tlbi *tlbi)
>>>  {
>>>  	bool use_nl = tlbi->non_leaf &&
>>> @@ -1012,8 +1017,13 @@ static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
>>>  	struct riscv_iommu_command cmd;
>>>  	unsigned int i;
>>>
>>> -	riscv_iommu_cmd_inval_vma(&cmd);
>>> -	riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
>>> +	if (gscid) {
>>> +		riscv_iommu_cmd_inval_gvma(&cmd);
>>> +		riscv_iommu_cmd_inval_set_gscid(&cmd, gscid);
>>> +	} else {
>>> +		riscv_iommu_cmd_inval_vma(&cmd);
>>> +		riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
>>> +	}
>>
>>As I understand it, the same choice is needed in
>>riscv_iommu_bond_unlink().
>>
>>The missing GVMA command does not break anything today, because every
>>caller of bond_unlink() runs iodir_update() just before it, and that
>>already sends the GVMA for the old GSCID. But depending on that
>>ordering seems fragile, and the comment in bond_unlink(), "invalidate
>>all cached entries for domain's PSCID", is no longer true now that we
>>have S2 domains.
>>
> 
> There is no functional issue with the current code, since
> iodir_update() already performs the required invalidation.
> 
> That said, as this series adds S2 domain support,
> bond_unlink() should indeed be updated accordingly.
> Good catch.

Hi Fangyu,

I've included this code in patch 10 of the v3 nested series [1].

BTW, if you have time, would you mind reviewing the nested series?
I'd greatly appreciate your help.

[1] https://lore.kernel.org/linux-riscv/20261119132744.396426-11-gong.shuai@sanechips.com.cn/

Thanks,
Shaui

> 
> Thanks,
> Fangyu
> 
>>The change, if you think it is needed, fits better in the last patch,
>>"iommu/riscv: Add IOTINVAL.GVMA invalidations". I am replying here
>>only because the code is very similar.
>>
>>Thanks,
>>Shuai
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

