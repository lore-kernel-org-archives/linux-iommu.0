Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE546D540
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057964; cv=none; b=tHDysZGZMkgniNYmQ4vTA4qFBx/50IRUVQFvtgIe2dkR+RYK20jXlIKNY8m8fOa+ARBA16anBJtFBmXevDqXjnTmKp9QhimiLgRkOXVuRpA03sDPHwjyBZxOyx9AChhl95aHPyVGsWMMr3XjT5v5IWJ/4eF/AzYfNN8wf9F/pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057964; c=relaxed/simple;
	bh=YE566pDxD3Osti0R5anIe5F+O2CzvECy1KMfZo7/DGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8QH2AD7y98/us6iePO8MV4OaaxLGOKva8uV+aMbvqRQsEW9390+LJvRolmML9ifREsB0x2fPT3oXK0zMpUybAiCM3QGemRPKc+RYWh24dfVPC73BMeLOC8Kz3hhLPchT3VObDz8C3VgxiWu4d5uair1XtVyi2yRLAJeTDc2eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I+gFwjYW; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I+gFwjYW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787057958; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ES6qoaxH7aDi5DiJCCb446qkTLSYvUQTBdOjpjMPh+M=;
	b=I+gFwjYWNY2vL4bm8aDQSyI3l+1aT5lczjOf1a6W+oeHfwyjQW8drcy1whWAwq9J/IkadErznMZSugnO5EArpFKskyMyv8i0kBCIyAYkooqqT8Nvsdir9rjxt0GhCyqrn7PFRWbO+zRsIDCgi2PVtMsH8uv37AAi5VZ4uxzbXPE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X9DUfkY_1787057955;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9DUfkY_1787057955 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Aug 2026 20:59:16 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: [RFC PATCH v2 01/10] iommupt: Add RISC-V Second-stage (iohgatp) page table support 
Date: Tue, 18 Aug 2026 20:59:10 +0800
Message-Id: <20260818125910.39784-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <lpnxdqyekcczbyxo3n7zxpbj7243gixdzutvngpvr24ozmc4jt@nsoblujgprhe>
References: <lpnxdqyekcczbyxo3n7zxpbj7243gixdzutvngpvr24ozmc4jt@nsoblujgprhe>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On Thu, May 07, 2026 at 07:36:57PM +0800, fangyu.yu@linux.alibaba.com wrote:
>...
>> diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
>> index fc5d0b5edadc..59448125159e 100644
>> --- a/include/linux/generic_pt/common.h
>> +++ b/include/linux/generic_pt/common.h
>> @@ -188,7 +188,10 @@ enum {
>>  	 * Support the 64k contiguous page size following the Svnapot extension.
>>  	 */
>>  	PT_FEAT_RISCV_SVNAPOT_64K = PT_FEAT_FMT_START,
>> -
>> +	/*
>> +	 * Using second-stage / iohgatp address translation.
>> +	 */
>> +	PT_FEAT_RISCV_S2,
>
>Hi Fangyu,
>
>I just sent [1], but I actually discovered that issue when testing this
>patch and finding PT_FEAT_RISCV_S2 was missing from PT_SUPPORTED_FEATURES.
>So this patch needs the same fix as [1] as well.
>

Hi Andrew,

Thanks for catching this. I'll fix it in the next revision.

>Thanks,
>drew
>
>[1] https://lore.kernel.org/all/20260818092444.42755-1-andrew.jones@oss.qualcomm.com/
