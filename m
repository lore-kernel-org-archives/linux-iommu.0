Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B872D6E5C
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427559; cv=none; b=iE/0Bv58ZFOaAOq+W8l/TxXaGXizUFnVTG3WzTP2xSzCC7AWnNtcDeRvhWF+UT/rRvVA3HzBs5b6JNwgMFm8lyzEs9O1dlGkb1hW/s4Z+XwcoiPiBViQUDYtuNPLS/lHtFb22kSY5SswlKG5GYOiKqs/w+WJ0oZybOM0/JiTEuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427559; c=relaxed/simple;
	bh=ornTY5WgzLqGdzZ4NJtM7emLNStefMI1TDq/dr3FAK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXKHihZm+yNnXbVx+viEt6hdnqm0KV3GN/KN8RlWvUrBbP7o96KRw5LJxASNfEFE3S+wyi5A3+2qWfo4VJhvEyvvr0LyeYOgLvZh8tkvlJV87+tdW6KxAyrCdV+fKrWgaFw7+U7dnfM4pwgkpBHHkqI9TZK8Oq1G6BWO9k1l46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ai99fKM1; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ai99fKM1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777427555; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=M1CcrdQtHn2gSvCSo6JX/03PiEKIGjscS1LiRTMKJVg=;
	b=Ai99fKM1fPPwzo0w+6ADN4/4628so65cAD343BfNbsVYirz4p60x5dx/hIUTJcpTugTbFRqoj/22Pid6k//HPYEfpOpTmPXB43NutKyY+8mruXk0YhzK2xGQNpLDSAyV1qcKwhYx4X+YY/dAqcaYUZjMTol5wk3lGh6GeVJOKLI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X1vlR.H_1777427551;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1vlR.H_1777427551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 09:52:33 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@ziepe.ca
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
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
Subject: Re: Re: [RFC PATCH 10/11] iommupt: Add RISC-V dirty tracking PTE ops 
Date: Wed, 29 Apr 2026 09:52:27 +0800
Message-Id: <20260429015227.67909-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428133909.GH849557@ziepe.ca>
References: <20260428133909.GH849557@ziepe.ca>
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
>
>This patch should probably go earlier in your series, before adding
>the alloc_paging flags at least.
>

Agreed. I will reorder the series and place this patch earlier.

Thanks,
Fangyu

>Jason
