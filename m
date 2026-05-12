Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32423C3432
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572444; cv=none; b=rN2aZtEMBxWDh5Y+vUhWEeTZMLPB2WVnF0KpDxezrybo/T6Vo6AM3jktqJbKxjS3NPfxgJM5MNPo/7W3/YXIdvK2ySpdPv6Ppbz+2pbEy4P0F8F2uF8AVfuIkID0ctX1wS+RpA+ALeuGH0srUT6SNgakkDDpa6KaHYCU+1esoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572444; c=relaxed/simple;
	bh=jd3BRnUhYfyMbNMAa9090B4J35ELhDJfkvxVMor7K18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8VkYTtVIM+lpiDyqggae6oGHjdMEgelrt+p43Po/VqwjBsFhJWyDwROT60c8VMZkNrCZTjUfG5k5TFhGLtWtv5JMnKEFTw8oCDL7P+pKlC7sDxY5z4MVerCiD3i8oghi15ntmmWbmFFIC+rqkmg14FB4sLSs2NHw/MoFctRLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fNqX6+ly; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fNqX6+ly"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778572433; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=IKv62Crr+//VydOqD1xiLuBvfxqPwPa7ePrB63fI5fQ=;
	b=fNqX6+lyGae8WEjjKlfiszPHgYB6qsGBjzRLdWE1MzlPr/H/cRO7AuoxKpsxqdKjjQe7P2YIxFJ0yEGCHQz60unfxaA21Shs/coW0iksSP/dH0hdU63qoODlYqiLnFBfAaMXn147nvknVFQ+XXpXcemmXk7R+DoPtC7xxT4rFGQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X2prY0B_1778572430;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2prY0B_1778572430 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 15:53:52 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	nutty.liu@hotmail.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: Re: [PATCH v3 0/2] iommu/riscv: Support Svpbmt memory types in generic_pt  
Date: Tue, 12 May 2026 15:53:39 +0800
Message-Id: <20260512075339.18339-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <k6k2ufkol6trxucf32qxj5i2v7safcyososquomqr7vavqwvr7@s4b6h26htu4x>
References: <k6k2ufkol6trxucf32qxj5i2v7safcyososquomqr7vavqwvr7@s4b6h26htu4x>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> Fangyu Yu (2):
>>   iommu/riscv: Advertise Svpbmt support to generic page table
>>   iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
>>
>>  drivers/iommu/generic_pt/fmt/riscv.h | 11 ++++++++++-
>>  drivers/iommu/riscv/iommu.c          |  2 ++
>>  include/linux/generic_pt/common.h    |  4 ++++
>>  3 files changed, 16 insertions(+), 1 deletion(-)
>
>Applied this one instead of v2.

Thanks for the review and for applying this version. I’ve sent a v4
update to fix the 32-bit build warning, so please use the v4 series
going forward.

v4: https://lore.kernel.org/linux-riscv/20260512074142.16356-1-fangyu.yu@linux.alibaba.com

Reported-by: kernel test robot <lkp@intel.com> in [1].
[1] https://lore.kernel.org/oe-kbuild-all/202605121350.wZxB51k0-lkp@intel.com/

Thanks,
Fangyu
