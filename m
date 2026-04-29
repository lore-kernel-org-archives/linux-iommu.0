Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0422301
	for <iommu@lists.linux.dev>; Wed, 29 Apr 2026 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425674; cv=none; b=dZJ4uCbAAEsJssnQtJpwMreD8fRAcvOZPkXg4kyfaZbXGsuFaoejuUZT9ymljT8Ks+ltOQYmeQE0u+b48NJERqtPqf1U/1fh4CSD7gjQhxcY89XX8z3qZkmFqKsVOUEIkMyg17Wls8ypw5uBw+Yd9o/vlBUZJTeWVb2ojX0cT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425674; c=relaxed/simple;
	bh=7LnoYXtUgcLK+iuuo/ay/+wU4q11Fd3/PO7qvUkxaPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAm/jjZflhzyO0LFQIO9WiPna05Kp/Jq/A8r9+HFShQAP03fXJRObyXkeqZ/Ood2LyGVGrlfJrjA/o9Jz53t3h90UwuJogVaIAW2NLBISrKNHrrGHHPcLGsaAgaDfmNIGw1hrIEZGEShDHOIghj1vqbP3IgTZkQ+XydNgjLZaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DwCdb47w; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DwCdb47w"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777425670; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7LnoYXtUgcLK+iuuo/ay/+wU4q11Fd3/PO7qvUkxaPc=;
	b=DwCdb47wwaUWfhHR6TWABRu6t5KCyS70F0SXyBS97EPaiJZbvjzfynBtXbmhYiLFglJxO/VXyqj76FHA7YLy6SJxCFfo70o1Gzmbys3c0r2ZoAv/CS/mnN27TFyFa4/PFAV4ULKjX4XI2n5dttR+BVfwClRqN+y+zdrksyOZHjk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X1vuGUZ_1777425666;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1vuGUZ_1777425666 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 09:21:08 +0800
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
Subject: Re: Re: [RFC PATCH 06/11] iommu/riscv: Add domain_alloc_paging_flags for second-stage domain 
Date: Wed, 29 Apr 2026 09:21:06 +0800
Message-Id: <20260429012106.63618-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260428133501.GE849557@ziepe.ca>
References: <20260428133501.GE849557@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Understood. I will rework the flags handling to follow the switch/case pattern
used by other drivers, and remove the dev_err() on the failure path.

Thanks,
Fangyu

>Jason
