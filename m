Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476913B05BD
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787410555; cv=none; b=S3FNfK3L1WZPNY/V2abGjEc6pj9IrJq0l+GmvMZRVoFGGOezmjgmFIYGQO03zzViEoqoPOT7KBQmlVH7+u2AEkwhDMHcktIWPumvJ/aF0XrqXTq8tP0rGKP1lvuoUcnwJWjztwCKncSuowNOEtxoKsb3IUCBayXo2xY02qYQvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787410555; c=relaxed/simple;
	bh=tzKk5SUiQOx6i5R7r8wpUZrKLMF9ZzMNafKAx6YAcqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvKhXvpYKvKK3pXigNEKYG01NiYjgxC0m9GKNDmv4iQfd66+5WxasujQ1suyvvLNzo/8YUGvmarPdzYJpGkXgBSoElUuswE38U5XQ9rvpttYd7vkI16FXWJPO9zWl66hB1mJJcWlp3Ncl7ChqLPFru8TuKGgs6mW4mStrnzNZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jVW4qyke; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jVW4qyke"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787410542; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2ZCxDvxQ0l5oes9P6kZCTA+Nmj1at6x6MNlnmoiY7JA=;
	b=jVW4qykeQ4sjF2QgWnGCTLmf2ssb6GN6PIhlZ1kX5GLdWORq+YfTuNkFSf9UZZU0mnWM5nZYOIJZ9eNrbYP6ueJoduDvMZp7J7knqi8Wud1n44iTB5MeJrANkXqh55EqsY/y646LvkuSBTTNe0Zgi+yGokoE5u7qZJNa7BxFKC0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X9OkhzD_1787410538;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9OkhzD_1787410538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 22 Aug 2026 22:55:40 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@ziepe.ca
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v3 01/10] iommupt: Add RISC-V Second-stage (iohgatp) page table support 
Date: Sat, 22 Aug 2026 22:55:33 +0800
Message-Id: <20260822145533.26659-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260821135501.GB1114497@ziepe.ca>
References: <20260821135501.GB1114497@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> @@ -126,6 +135,15 @@ riscvpt_entry_num_contig_lg2(const struct pt_state *pts)
>>
>>  static inline unsigned int riscvpt_num_items_lg2(const struct pt_state *pts)
>>  {
>> +	/*
>> +	 * Second-stage (iohgatp) root page tables have 4x the usual number of
>> +	 * entries (2048 = 2^11 instead of 512 = 2^9) to cover the 2 extra GPA
>> +	 * bits in Sv39x4/Sv48x4/Sv57x4.  Only the root (top) level is
>> +	 * enlarged; all other levels remain at the standard 9-bit index width.
>> +	 */
>> +	if (pts_feature(pts, PT_FEAT_RISCV_S2) &&
>> +	    pts->level == pts->range->top_level)
>> +		return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64)) + 2;
>
>You shouldn't need this, see how ARMv8 is constructed which does the
>same thing. Instead
>
>static inline unsigned int armv8pt_num_items_lg2(const struct pt_state *pts)
>{
>	/*
>	 * It is not allowed to call pt_num_items_lg2() at the top level, this
>	 * API restriction is specifically an optimization avoid overheads
>	 * dealing with concatenated tables here.
>	 */
>	PT_WARN_ON(pts->level == pts->range->top_level);
>

Thanks for pointing at ARMv8 for comparison. I hadn't noticed your
newly posted patch [1], Now that I've looked at it, I agree
armv8pt_num_items_lg2() is the right way to implement this and
will follow that pattern for RISC-V in the next version.

>> @@ -272,6 +291,19 @@ riscvpt_iommu_fmt_init(struct pt_iommu_riscv_64 *iommu_table,
>>  	case 57:
>>  		pt_top_set_level(&table->common, 4);
>>  		break;
>> +	/*
>> +	 * Second-stage (iohgatp): Sv39x4 / Sv48x4 / Sv57x4.
>> +	 * The top level is the same as for the first-stage counterpart.
>> +	 */
>> +	case 41:
>> +		pt_top_set_level(&table->common, 2);
>> +		break;
>> +	case 50:
>> +		pt_top_set_level(&table->common, 3);
>> +		break;
>> +	case 59:
>> +		pt_top_set_level(&table->common, 4);
>> +		break;
>
>Are all these widths valid for both S1 and S2? It should reject
>illegal vasz..
>

Agreed, will fix. 39/48/57 are only valid for S1 and 41/50/59 are only
valid for S2 -- I'll gate each group on PT_FEAT_RISCV_S2 and reject the
other combination.

>>  struct pt_iommu_riscv_64_hw_info {
>>  	u64 ppn;
>> -	u8 fsc_iosatp_mode;
>> +	union {
>> +		/*
>> +		 * First-stage (fsc/iosatp) MODE encoding:
>> +		 *   8 = Sv39, 9 = Sv48, 10 = Sv57
>> +		 * Used to program DC.fsc.iosatp.MODE.
>> +		 */
>> +		u8 fsc_iosatp_mode;
>> +		/*
>> +		 * Second-stage (iohgatp) MODE encoding:
>> +		 *   8 = Sv39x4, 9 = Sv48x4, 10 = Sv57x4
>> +		 * Used to program DC.iohgatp.MODE.
>> +		 * The numeric values are identical to fsc_iosatp_mode;
>> +		 * the caller selects the interpretation based on domain type.
>> +		 */
>> +		u8 iohgatp_mode;
>> +	};
>
>suggest not using a union and instead have the get_info populate only
>the one correct for the fmt. It makes it slightly more robust that
>s1/s2 don't get intermixed improperly?
>

Makes sense, will drop the union in favor of two separate fields and
have riscvpt_iommu_fmt_hw_info() only fill in the one that matches the
format's stage.

Thanks,
Fangyu


>Jason

[1] https://lore.kernel.org/linux-iommu/0-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
