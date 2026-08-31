Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDE3AFB07
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157008; cv=none; b=qN33MAg45Zgd1VW017290PPWLS423NBlhs9EBdwP1KObjOfGvxnLQe+UFp5H9w4uUGoyC3IsHkgFOCgMvYChic3y1GwvAB0kP2pf7QAFteWcIez+uq5TJ2zGlhRAV+q4I72LtkaX6zOo35xasDGjnTbGIJ5SBusq7BvnanUHiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157008; c=relaxed/simple;
	bh=WuZkdyKN/x+MMvkKHt+vWao2nKepqydzUABIUDFpYSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWF/RSxj6KFo750VTux4/A3dcTXZYpnc7t9jWblhVRz4fUVq+yUiCbr4vfvz3k0b39e91jq3AkL+6Dr8G/I1yqvWveASOcAUT0q2dWuXmxbXKEOLASkfntMtZtV+5PZrFSe72/sPHNgI81ZDlQCr43qw4drpzElzv5fh29RNCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rq+vmw7o; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rq+vmw7o"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788156997; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=F7PUgZ6rG5RVEqeO1XKlyylkawAdGS5wSTdnvgKctqo=;
	b=Rq+vmw7o9XC4gsDTnXVAXmHXtgn5J1b8M1T2xWbfVjBbIXg9rwhXkG+2jGy76COWaF8vSaXUEFjmt2AfCzS+JOd94jG5KzqipyhsMu7QL7tzagjWN/UCFmA2WC3x/+8Iad1Q+nEMetwmKrn+ITnws+wezfpiZppJPSSp4cXhBbY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X9st-yR_1788156985;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9st-yR_1788156985 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 14:16:36 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yuanhe Shu <xiangzao@linux.alibaba.com>,
	smostafa@google.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	praan@google.com,
	skhawaja@google.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommupt: Drop pagealloc references during domain deinit
Date: Mon, 31 Aug 2026 14:16:20 +0800
Message-ID: <20260831061623.2164384-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260827161828.GA3769797@ziepe.ca>
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com> <20260827145855.1616223-3-xiangzao@linux.alibaba.com> <20260827161828.GA3769797@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 01:18:28PM -0300, Jason Gunthorpe wrote:
> It is not misusing iommupt, but it is definitely misusing any iommu
> API built on top of it. How did you trigger this?

The kunit suite, nothing else.  test_pgsize_boundary() maps 128K at a
hard-coded OA and never unmaps it, so with iommu.debug_pagealloc=1 those
32 pages stay counted after pt_iommu_deinit() and every later allocation
or free of one of them WARNs.  The out-of-tree module in the cover letter
was something I wrote to confirm the mechanism, not a real driver.

The only non-test path I found that frees a populated domain is
iommu_setup_default_domain(), which releases the old domain with its
IOMMU_RESV_DIRECT mappings still installed.  I have not seen that WARN,
presumably because those pages do not come from the page allocator, so it
is not evidence of a bug and I am not proposing to change it.

> If this is the only trigger, then it is different testing things
> interacting badly and I don't think it should be fixed like this.
>
> Probably have the kunits directly unmap as they were being lazy

Agreed, and my "not driver misuse" framing was wrong: the iommupt deinit
contract says nothing about unmapping, but the iommu API above it does.
Dropping this series.

You were right about the tests: adding a count_valids() == 0 check to
pt_kunit_iommu_exit() without touching anything else fails exactly
test_increase_level(), test_pgsize_boundary() and test_mixed(); the other
cases already unmap.  I will send that as a single patch.

Thanks,
Yuanhe
