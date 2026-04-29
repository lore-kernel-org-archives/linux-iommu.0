Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A92571C7
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426877; cv=none; b=jBNz9q0sC7/09cWwP8jUdL4tZahAobzS/eiO7LeZf3uNUCY8QhQnNi3pTqCNR8S4VHGhYp6rpAZRb+GQGJc6C4DqEGeCqNzyQ5SFE1KLFeJrhZ02oQaNtdKv2NvZWKm0c54cXajVwxEo67YD3h81UtgU1VXm823W/lotW8lhxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426877; c=relaxed/simple;
	bh=wPuM6GSAiwn9WeQbO7tmNCM/nxxzFmQlxKxqb4UHH3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGuJN9p9UEn0+tj1DFXo5f7URoe5YTLvgIP+/0gwuUkSaP3bc9ezmpo2PLpIg07XtIT4Tg8dZ/TobXCliW1krxans777ijQpBeiljltxbxjHbPfobcoTBiNSuBLKkWkhRGnUH6bxF84jnFI6hmZ0jW9wJcxV0VWNJZUoG5WFab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wXF3aooD; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wXF3aooD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777426873; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Oq4NJwjoZstdZY8Yv5UU3SU2nsmNBMRQGsHhZADtKDA=;
	b=wXF3aooDP+Xul+9uuuJ/g6fQVW5fpxB2pz6fwEmw1u0agOr19jFfsfVOccXKbe78f2VYJZKmh7WIHXpWvm25ITJLyDGZeo3xYK2TK6C3XJOTFHJrcwtxAWkXjUkypBAuRA9F32ZZWHCHamfb0vToHeAGluLK744C5CJO7/OqECQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X1vlN.5_1777426869;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1vlN.5_1777426869 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 09:41:11 +0800
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
Subject: Re: Re: [RFC PATCH 07/11] iommupt: Don't preset D when RISC-V IOMMU dirty tracking on 
Date: Wed, 29 Apr 2026 09:41:05 +0800
Message-Id: <20260429014105.66404-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428133641.GF849557@ziepe.ca>
References: <20260428133641.GF849557@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> 
>> When mapping writable pages, the RISC-V format code currently
>> pre-sets the PTE D bit unconditionally.
>> 
>> If hardware dirty tracking is active (DC.tc.GADE set), the IOMMU
>> sets D autonomously on the first write. Pre-setting D makes every
>> new mapping appear dirty immediately and breaks dirty tracking.
>> 
>> Introduce PT_FEAT_RISCV_DIRTY_TRACKING_ACTIVE and, when set, leave
>> D cleared for new writable mappings so hardware can capture the
>> first write. Keep pre-setting D when dirty tracking is inactive.
>> 
>> Only meaningful for second-stage (iohgatp) page tables.
>
>You shouldn't need anything like this, the D bit is managed by the
>iommufd core appropriately. It *should* start out pre-set as that is
>faster when not tacking. Only once dirty tracking is started does D
>get cleared. User space is supposed to assume that everything is dirty
>prior to its first D clear.
>

Thanks, that makes sense. I will drop PT_FEAT_RISCV_DIRTY_TRACKING_ACTIVE
and rely on the iommufd core to manage D bit.

Fangyu

>Jason
