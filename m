Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CB383C99
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430255; cv=none; b=KUCz9jjIH+ZMXxZ65rf7r2+xRD+382bViTtRckX+rCDs3nWlI2mwMmv1ESowaVOPiv7hXO9rd5YB+cM2tWUrZ94T2RRvXB8J7l0zBO2a45H7mnoy5RKQiG6f+mgivryCfcZUpqZ1rdBylTUPlE7ZLD4AWjogMTv4PBONQ1pD2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430255; c=relaxed/simple;
	bh=Bog/7E6jfRp6BmN5HcKhuNdt+u2al342vA9vTtIK/c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIGhdEX4r1RHvdLavY9+tXyOJaGhcv6EGiQ5UI6UWU0dYe6aQfv5SgWEpJ1UJm5LXnDcEnkoiZDfwyBZXv1w6kXw8RVe1CrEdrA9bEBZm3u6kgW7FVyRy5gla7k7pTdng69FRNfiScGp77WwfH126Zoc3v9dERjm52tREfkauW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ukYvubN9; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ukYvubN9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777430251; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9vgeJGi4fIz8c1PAExsDJNL3htFpFy8K6PCAfkBpC84=;
	b=ukYvubN9bfsiw+hCgFct0Rh8DuUuGppw2MYGZLHRo52sLLZ7e0G7YQR01oyZygXbd5GwOsawUjU5A3dXju2PAapB8CYKM1JI+pPsNrmhNxS3n8/f4uGOMy0jFUNxleG63RCQ+b9eJGc5ZSNAr8Anqx5jBTDncHjVWQry52PSgP0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X1vzVVG_1777430247;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1vzVVG_1777430247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 10:37:29 +0800
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
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: Re: [RFC PATCH 11/11] iommu/riscv: support nested iommu for getting iommu hardware information 
Date: Wed, 29 Apr 2026 10:37:22 +0800
Message-Id: <20260429023722.79615-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428133942.GI849557@ziepe.ca>
References: <20260428133942.GI849557@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Zong Li <zong.li@sifive.com>
>> 
>> This patch implements .hw_info operation and the related data
>> structures for passing the IOMMU hardware capabilities for iommufd.
>> 
>> Signed-off-by: Zong Li <zong.li@sifive.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/iommu/riscv/iommu.c  | 19 +++++++++++++++++++
>>  include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>
>This has nothing to do with dirty tracking. It should go with a series
>introducing viommu.
>

Thanks for pointing that out.

I added the .hw_info-related patch because, during passthrough testing with a
VM, I observed that QEMU calls iommufd_get_hw_info, so I initially thought it
was required. However, it appears that the .hw_info implementation is not
necessary for this series. I will remove the .hw_info-related patch from my
dirty-tracking series in a follow-up revision.

Thanks,
Fangyu

>Jason
