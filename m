Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A223E95A8
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787410942; cv=none; b=ZKdkGZyHlEwjfzjVbiLlQsZHm4u2/iMJFcKAgRpsbsFh5hGwfRir0xAq1M4v63kjviQiDmpL99muYPKw0tG38I9wW+eyME9fBBdWneSiBQPTtvZxVY55Ac7Bp+lpTumbWqEESsWU8Zxh7FYsZz8wGh/xngZ8H8GcIdVqDfdLLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787410942; c=relaxed/simple;
	bh=QM14jpU+UeNmn1fBd3Fc7GUbfFmzl65XgvRL8CiBa4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JK378oR5iYUd2PPgjBG75NMdwXpkzXpvlIE5nfBYFImb7JdUkV7i/kSww0H/MdWjJbToISwmDo9ibwP6rSHjemWspue2o7PtR5EWOObBQBRHABIW9w7iWU8wKEGOGTiDqhNipUMimj0WR5tvROrUcezk44sKfMh7nm1Mq6vegyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Et6YiXyO; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Et6YiXyO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787410928; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wSA+U68kMi1vHAuDTRRzoLt1djKESRXXHhCMc7teURU=;
	b=Et6YiXyOy92piKVEf92ykjakg0IszkJYu2nnlr0OFc3Uq4tMXW6DxtkOtRNUkPTlnzFvTlb1lt4z3ZEHzpkvbmiBh56s2kju+Sv1dYNDyu7yoKqcZaSJlMeMvJTxpKPSKd1xRaXmyYy5Nwlwk81OnVRwON6M6Jq96JIJ/eATamE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X9Ok1h0_1787410924;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9Ok1h0_1787410924 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 22 Aug 2026 23:02:06 +0800
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
Subject: Re: [RFC PATCH v3 02/10] iommupt: Add RISC-V dirty tracking PTE ops
Date: Sat, 22 Aug 2026 23:01:57 +0800
Message-Id: <20260822150157.27501-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260821140341.GC1114497@ziepe.ca>
References: <20260821140341.GC1114497@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> Implement the three dirty-tracking hooks required by the generic page
>> table framework for the RISC-V format:
>>
>>   pt_entry_is_write_dirty():
>>     Check the D bit (bit 7) in the PTE.
>>
>>   pt_entry_make_write_clean():
>>     Clear the D bit across the full contiguous range.
>>
>>   pt_entry_make_write_dirty():
>>     Atomically set D via try_cmpxchg64() on a single PTE.
>>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/iommu/generic_pt/fmt/riscv.h | 43 ++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
>> index 5692c033dbde..09581798e753 100644
>> --- a/drivers/iommu/generic_pt/fmt/riscv.h
>> +++ b/drivers/iommu/generic_pt/fmt/riscv.h
>> @@ -226,6 +226,49 @@ static inline void riscvpt_attr_from_entry(const struct pt_state *pts,
>>  }
>>  #define pt_attr_from_entry riscvpt_attr_from_entry
>
>Does this work for all stages or does it need  pt_dirty_supported ?

Good catch, no it doesn't. This patch didn't add a pt_dirty_supported(),
so it falls back to the default "always true", which isn't right --
iommu.c only sets TC.GADE and wires up dirty_ops for second-stage
domains, first-stage never gets TC.SADE set.

Thanks,
Fangyu

>
>Jason
>
