Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795241742;
	b=3axmDUkoJcPoL+WNCMf3y0VX38LdpBhWOPcP7d3npLkevlHUw3jrLOAeon1PwslroG6R
	 xfGrny1s6yfMDGfaBqI1Dg0Pthml7pyagVaGtoOBTZh9C3y7PA23r7DRP75zGxpfcSPMd
	 yy0bLxWKJZmpxm9XF2AuVaHobsYBPgaY/h2FeD5cM//bhfdbYGFLKQUwWTo/ukTYisCS3
	 l7FnlQrKUC1yz/2cqpm1ujecYqM1VO5gy2oDDkXYowFRpQtLGoE93XuqQB30kkUBku2zk
	 4m/CvShR53cXbMRkqGMtWUGWIPnkbX7kyTRuWRCTp8QjuJ8qUhIqNDL1E2i6OKA+GDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795241742;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YShQ51CxPN05RyeAJpAM1rmHPAWCYeDv107+BzXh+IU=;
	b=qyMw+9t/SAqR7ljLhENT8zwfuOS25y8A6zQDLSQmoGgDPtkVo2NRUgUKAo5hkmlw9KWB
	 bI/xkmZEpOVOqMRIi8Apw+hkyzU8ktbS29Gfm9a7oFZASf0eO5AXP6cQtNnzzx7wlwYUb
	 mrRTKYIny+OUM75xnHpJLjhBpUZ1ZozX7zyZWuQ3VhKXn78xumk5SXmWvnoSg2D0ySHPA
	 +7O9rVK5fjnXdG0LZ+d6bGr1W2Je6Qo9IY/0tnsGLMb0TfOXxlFaKGhVXOI9KGgAnOVYb
	 CrESiiBRVE5vOgv7ZG1PHO5xo3iFCFYau+d5NB5JmnLkfmlFRhRfPHCTNsR0Qc8JDZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=quEavZpk;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21556606A336
	for <iommu@lists.linux.dev>; Sat, 21 Nov 2026 06:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21556606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=quEavZpk
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795241737; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YShQ51CxPN05RyeAJpAM1rmHPAWCYeDv107+BzXh+IU=;
	b=quEavZpkcBiqWp4jM5eSpJUnMKwKxXRYz0LCOu1THynZs3Z4lUPCqmzfX9wRMcT/+QBTY/eG6FoapNikawV5NRhhSO7ojq355jeyeb42eyZuAELJTwfTZa+QK9lR6uyPQNeUYlSlv1SHFJ6T2WnntG8ZRvP1YEcQ4V9BoYb6HHM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XF83hNL_1795241733;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XF83hNL_1795241733 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 14:15:35 +0800
From: fangyu.yu@linux.alibaba.com
To: gsh517025@gmail.com
Cc: alex@ghiti.fr,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joerg.roedel@amd.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	nutty.liu@hotmail.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tanchi25@mails.ucas.ac.cn,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [PATCH v7 05/10] iommu/riscv: support GSCID and GVMA invalidation command 
Date: Sat, 21 Nov 2026 14:15:32 +0800
Message-Id: <20261121061532.23534-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <23b033cb-1b98-48cf-a089-4e710dfe3e15@gmail.com>
References: <23b033cb-1b98-48cf-a089-4e710dfe3e15@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>>Hi Fangyu,
>>>
>>>> From: Zong Li <zong.li@sifive.com>
>>>>
>>>> This patch adds a ID Allocator for GSCID and a wrap for setting up
>>>> GSCID in IOTLB invalidation command.
>>>>
>>>> Set up iohgatp to enable second stage table and flush stage-2 table if
>>>> the GSCID is set.
>>>>
>>>> The GSCID of domain should be freed when release domain. GSCID will be
>>>> allocated for parent domain in nested IOMMU process.
>>>>
>>>> Signed-off-by: Zong Li <zong.li@sifive.com>
>>>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>>> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>>>> ---
>>>>  drivers/iommu/riscv/iommu-bits.h |  7 ++++
>>>>  drivers/iommu/riscv/iommu.c      | 62 ++++++++++++++++++++++++++------
>>>>  2 files changed, 58 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
>>>> index f2ef9bd3cde9..65d1f2250011 100644
>>>> --- a/drivers/iommu/riscv/iommu-bits.h
>>>> +++ b/drivers/iommu/riscv/iommu-bits.h
>>>> @@ -720,6 +720,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
>>>>  	cmd->dword1 = 0;
>>>>  }
>>>>
>>>> +static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
>>>> +{
>>>> +	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
>>>> +		      FIELD_PREP(RISCV_IOMMU_CMD0_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
>>>> +	cmd->dword1 = 0;
>>>> +}
>>>> +
>>>>  static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
>>>>  						  u64 addr)
>>>>  {
>>>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>>>> index 918fce4aa8c4..5546dfcd976c 100644
>>>> --- a/drivers/iommu/riscv/iommu.c
>>>> +++ b/drivers/iommu/riscv/iommu.c
>>>> @@ -49,6 +49,10 @@
>>>>  static DEFINE_IDA(riscv_iommu_pscids);
>>>>  #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
>>>>
>>>> +/* IOMMU GSCID allocation namespace. */
>>>> +static DEFINE_IDA(riscv_iommu_gscids);
>>>> +#define RISCV_IOMMU_MAX_GSCID		(BIT(16) - 1)
>>>> +
>>>>  /* Device resource-managed allocations */
>>>>  struct riscv_iommu_devres {
>>>>  	void *addr;
>>>> @@ -842,6 +846,7 @@ struct riscv_iommu_domain {
>>>>  	struct list_head bonds;
>>>>  	spinlock_t lock;		/* protect bonds list updates. */
>>>>  	int pscid;
>>>> +	int gscid;
>>>>  };
>>>>  PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
>>>>
>>>> @@ -1004,7 +1009,7 @@ static void riscv_iommu_tlbi_calc(struct riscv_iommu_tlbi *tlbi,
>>>>  }
>>>>
>>>>  static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
>>>> -					  int pscid,
>>>> +					  int pscid, int gscid,
>>>>  					  struct riscv_iommu_tlbi *tlbi)
>>>>  {
>>>>  	bool use_nl = tlbi->non_leaf &&
>>>> @@ -1012,8 +1017,13 @@ static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
>>>>  	struct riscv_iommu_command cmd;
>>>>  	unsigned int i;
>>>>
>>>> -	riscv_iommu_cmd_inval_vma(&cmd);
>>>> -	riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
>>>> +	if (gscid) {
>>>> +		riscv_iommu_cmd_inval_gvma(&cmd);
>>>> +		riscv_iommu_cmd_inval_set_gscid(&cmd, gscid);
>>>> +	} else {
>>>> +		riscv_iommu_cmd_inval_vma(&cmd);
>>>> +		riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
>>>> +	}
>>>
>>>As I understand it, the same choice is needed in
>>>riscv_iommu_bond_unlink().
>>>
>>>The missing GVMA command does not break anything today, because every
>>>caller of bond_unlink() runs iodir_update() just before it, and that
>>>already sends the GVMA for the old GSCID. But depending on that
>>>ordering seems fragile, and the comment in bond_unlink(), "invalidate
>>>all cached entries for domain's PSCID", is no longer true now that we
>>>have S2 domains.
>>>
>>
>> There is no functional issue with the current code, since
>> iodir_update() already performs the required invalidation.
>>
>> That said, as this series adds S2 domain support,
>> bond_unlink() should indeed be updated accordingly.
>> Good catch.
>
>Hi Fangyu,
>
>I've included this code in patch 10 of the v3 nested series [1].
>

Hi Shuai,

Thanks for the pointer. If possible, I'd suggest keeping this
change in the current patch rather than splitting it out --
it makes the functionality look more complete, and splitting
it into two patches seems a bit odd.

>BTW, if you have time, would you mind reviewing the nested series?
>I'd greatly appreciate your help.
>

Regarding the nested series, it looks like a solid set of
patches that already provides the basic nested IOMMU
functionality. I'd be glad to help with the review and hope
I can be of some help.

Thanks,
Fangyu

>[1] https://lore.kernel.org/linux-riscv/20261119132744.396426-11-gong.shuai@sanechips.com.cn/
>
>Thanks,
>Shaui
>
>>
>> Thanks,
>> Fangyu
>>
>>>The change, if you think it is needed, fits better in the last patch,
>>>"iommu/riscv: Add IOTINVAL.GVMA invalidations". I am replying here
>>>only because the code is very similar.
>>>
>>>Thanks,
>>>Shuai
>>>
