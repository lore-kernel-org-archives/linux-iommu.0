Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49A280A5B
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811646; cv=none; b=P7Th8TCmUgN9uExVm6PkmOQkwkat9GxfB3hoKd5Z/ZLl/0d0YSIQGGfDzPfr/ROcN8o67NlsjIulATC9rbfo4thy0KH7dbNExnfjxT0gQQZKuPAgFQD9hfPlRuUqAOIjkcm6nAXxt7SpkPQn5orbemLdRYsVF8j8L2mZwguRyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811646; c=relaxed/simple;
	bh=qM1xyxAPY0QB1w7xOZbA+rEH6oVOJQDBZB+e0yLeEtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQp9O4UIoyrhjZ1lqkcqK0WNYYsbbkVaKHtSj1VR1aJK8jcSmh8EzdtVFP3XivGJHeg3Yj/y3rtpg0eNptqCjrfEcUfB0lu2RuoEnfoKkb/SjXlqLaTOSyt7IdED+6TQWiTUIMmJAK0B8jJt05es7JzTFrGYJAc0BDqvDt5zedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KAE5NYWi; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KAE5NYWi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770811634; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=F/xti1QAvF9cEi5hXsm9eD/PRlUwjRYPQBfR6jIjJ0o=;
	b=KAE5NYWinqyIf9BhcAtpKHMLWSSGADQyVaTvztsBihi7zx7jNxSQHwO0g2THwDJ5aI5laKmTu45UwsWfeADiSub4NugAifGgCnLZryvCSgXNvGITf5RaLfGkCcVnLlA/LUrXiv9s/NYryiWtMoKoCrexvp1zf1f5VN/h2hKA9+E=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0Wz13zdh_1770811631 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 20:07:13 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@ziepe.ca
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	will@kernel.org
Subject: Re: Re: [PATCH 0/2] iommu/riscv: support range and non-leaf IOTLB invalidation 
Date: Wed, 11 Feb 2026 20:07:09 +0800
Message-Id: <20260211120709.51070-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260210130221.GE943673@ziepe.ca>
References: <20260210130221.GE943673@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> This series adds support for two RISC-V IOMMU v1.0.1 invalidation extensions in
>> the RISC-V IOMMU driver:
>>
>>   - Address Range Invalidation (capabilities.S), which allows encoding a NAPOT
>>     address range in the IOTINVAL.{VMA,GVMA} ADDR operand when the S bit is set,
>>     reducing the number of invalidation commands for large or superpage-backed
>>     mappings.
>>
>>   - Non-leaf PTE Invalidation (capabilities.NL), which allows IOTINVAL.VMA with
>>     AV=1 and NL=1 to invalidate cached non-leaf PTE information for the given
>>     IOVA, addressing cases where updating mappings replaces a non-leaf entry.
>>
>> Patch 1 introduces the missing capability/operand definitions and switches the
>> IOTLB invalidation path to use NAPOT range invalidations when supported.
>>
>> Patch 2 adds the NL capability/operand definitions and extends the invalidation
>> path to optionally request non-leaf invalidation. When map_pages() replaces
>> non-leaf page-table entries, the driver invalidates the affected IOVA range with
>> non-leaf semantics.
>>
>> No functional changes are expected on hardware that does not advertise these
>> capabilities; the driver continues to fall back to the existing invalidation
>> behavior.
>>
>> Fangyu Yu (2):
>>   iommu/riscv: Add NAPOT range invalidation support for IOTINVAL
>>   iommu/riscv: Add non-leaf invalidation support
>
>These will need to be redone on top of the new page table code for riscv:
>
>https://patch.msgid.link/r/0-v3-9dbf0a72a51c+302-iommu_pt_riscv_jgg@nvidia.com
>
>It should get picked up early in the next cycle

Thanks. Acknowledged—I’ll rework the series on top of the new RISC-V IOMMU page
table patches once they’re in for the next cycle.

>
>Jason

Fangyu,
Thanks
