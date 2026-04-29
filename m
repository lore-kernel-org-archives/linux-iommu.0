Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8541C62
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425329; cv=none; b=tGPVgEbewpKPkUYrbqGOwBqDAW1n3Eh+Bjgf6/8N4K+tsIvvGVro1yOkszEnyuSvvnx/mpD6AbAVeNsaRObUgOWWjZpZ2RCVPDwFqxRFnocd8YkcBGYOAqqiQ+y9DeNUI+k9Nr9BE6ZnI3fbelVLZgX3DvkSIb1Xa1gphboasHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425329; c=relaxed/simple;
	bh=r8EbWNXi4J82YFK/uhQ5l2XFpmLroabMXBcb58UjF6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWw66EiHbVJXB5m1TMGYFe/XJrOPdLMx3mw3bAT4Ve+h29M9wKCNpmUrZtvGlhnotSMh6sg06X5LyYLNp49Jjbz1zjbqu5piAfaYl+ny2bbHeTTo8h7kWfG0KQKXFHMBMBfJpizTW6goQAoaVuvr0MIFuUyhUrCN8iI+QR67+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d7AdNmsL; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d7AdNmsL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777425325; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xWnII7NbedrCecv32Wz7AYnJB6oJuNa7XLMjqnf42ng=;
	b=d7AdNmsLQCnRsf+Gv/1Awdemh5I1CO8FJ9EBGw8TvjCMs4Gb3PNmqLSWp75UA2AIB3/UHKE3tRiaDdbyyL8v6CqoRWwhQew2v53Ko5h3V0DLQ7qqULCynqFUCdlSk0YJ7DLo1/pUxLGQFBhCQLdyXvRV0EPVCTQ494xJIvLb/zs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X1vlEBh_1777425321;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1vlEBh_1777425321 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 09:15:23 +0800
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
Subject: Re: Re: [RFC PATCH 02/11] iommu/riscv: report iommu capabilities  
Date: Wed, 29 Apr 2026 09:15:20 +0800
Message-Id: <20260429011520.62812-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428133324.GD849557@ziepe.ca>
References: <20260428133324.GD849557@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
>> +{
>> +	switch (cap) {
>> +	case IOMMU_CAP_CACHE_COHERENCY:
>> +	case IOMMU_CAP_DEFERRED_FLUSH:
>
>IOMMU_CAP_DEFERRED_FLUSH is not needed in v7.1

Thanks, I will drop IOMMU_CAP_DEFERRED_FLUSH.

>
>Jason
