Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3229408
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157298; cv=none; b=tlLUS279m+73XHCaovHDocgx8O0nB0QPbudUi+Q8o1Y3htrp/QSYUoWZKDJ1RNCQwDoh8eejuihRRp4Pr9Dc6NTD0mER5H/VtD8RNq+O6FYTCMzPYN1VMzwHt7XEyp+GVrFYn8svvucs1rQLLPoYFcqoANxO4q+BtdC26L317oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157298; c=relaxed/simple;
	bh=eUvsAfzz+e5aNY/TsIfJgNeqShM5YG+g4j1nbqEC5lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeAAZRV0Ww+gTIFDbqIyDHSO2fzIc+eI3H4vUDwZUXrJyJOK7rTJHgZQac7agofXo4SMhN2ICGlMGG6+F7PTas5qtipNc2XAQqOi9tkj47uzyWLxjIVQPLxyaWgdcy+LXC1BJbZRvRBqkZIIpcZrjezmXtfWDTACE9PfHt3TBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bi/lSzJU; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bi/lSzJU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788157287; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dHNppGEbHFmiYLlqOhoL9xC65y2QF19Ima5W5LWEsiI=;
	b=Bi/lSzJUMHuT3ydgkKgi8rn+za1bC+N7KN0T7tbj95p5OeNsOLBxC8fqHIkx+eF9434E6gEhnlX1Q9R18Oe/qPbgQ42G0iy4xpxdedSoY/TXmMDgwj3ao8cyhECCh45qmZgIkS/Qgnk6ZfWfPIrWVhYDlwr76gX2n8FGv+gRnrU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X9tzDsa_1788157277;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9tzDsa_1788157277 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 14:21:26 +0800
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
Subject: Re: [PATCH 1/2] iommu: Add __iommu_debug_unmap_phys() to drop refs by physical address
Date: Mon, 31 Aug 2026 14:21:14 +0800
Message-ID: <20260831062116.2173451-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260827162148.GB3769797@ziepe.ca>
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com> <20260827145855.1616223-2-xiangzao@linux.alibaba.com> <20260827162148.GB3769797@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 01:21:48PM -0300, Jason Gunthorpe wrote:
> Every pts has the iova of its current iteration location. Call
> pt_index_to_va() and then pts->range->va is the current spot.

You're right, and pt_next_entry() already keeps it current, so there was
never a need for a phys based helper.  Both patches dropped, see my reply
on 2/2.

Thanks,
Yuanhe
