Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9FA49B201
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471264; cv=none; b=YPZw3d+CacpIfbn8i+wwPUKjr8eGe0824+81kBUSO1zgvfPsjMYRgskd47fvSJuV4Xkq1wSFYqEKGAuwNj3HuKZQw4qBzBMHD1MA1FBvYBC4nZPrSU4BmCeEbUWKY9Tvkq1HPYvSorvPANusdsIrDKfb1+0f2EV7ppyJal5egWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471264; c=relaxed/simple;
	bh=uqIgqIxz2MYxpYQY//sxZKjBZmFrVGjSYU/hzUgktt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX9uoCneEO0POYpaZcCaOKMS4kr39kP+lsMCMawKxbz9IdppAl2fqbkHijY6CCS48akSH0UOQzj6DKkbBSw27zkfJv0wmxznBXDuaCNBNLw+aPZNCsUCJ3dY68pg6X+dBuigLvIiqhXK3t9u+xSVdbU4kGOLYDjM9XKAzLXbJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yme4vGVo; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yme4vGVo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789471257; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pJ9Rr9CykAOIDKHJD/CzvfpeB8yYEsova679wlOFG74=;
	b=yme4vGVoBl2QGh6JGypvXCT/Iw9Ib3fYE/4s01F1tDF6W/hVHqtSVG375BSZ/go8Dx4q4SdZcf44P7yYiEhOjmKs0w8NekmrxnXTbUldjGCFarrXd94kpvqaDl0f+97sK7G1ehLKsU4RqKkHTvMt2xxOjLAhOHyhKmuUBfCMMkk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XB1X-IG_1789471237;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XB1X-IG_1789471237 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 19:20:56 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel
Date: Tue, 15 Sep 2026 19:20:36 +0800
Message-ID: <20260915112037.1495272-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260909095228.2174031-3-kas@kernel.org>
References: <20260909095228.2174031-1-kas@kernel.org> <20260909095228.2174031-3-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested-by: Yuanhe Shu <xiangzao@linux.alibaba.com>

We hit the same problem on our arm64 platform: the kdump capture kernel
runs out of memory because the SMMUv3 queues are still allocated at full
hardware size. We had started looking into it ourselves, then came across
this series, so we tested it on the affected hardware rather than prepare
a duplicate fix.

It resolves the problem for us - details below.

Test platform: an arm64 server, 128 cores, 2 NUMA nodes, 512 GiB RAM,
exposing 6 SMMUv3 instances. 64K-page kernel (PAGE_SHIFT=16) based on
Linux 7.0.14 with the series applied on top; crashkernel reservation is
512 MiB.

On this platform kdump FAILS without the patch, and the series fixes it.

Before - capture kernel WITHOUT the series:
  All 6 SMMUv3 instances still allocate the hardware-maximum queues:
    arm-smmu-v3 arm-smmu-v3.0.auto: allocated 524288 entries for cmdq
    arm-smmu-v3 arm-smmu-v3.0.auto: allocated 524288 entries for evtq
    arm-smmu-v3 arm-smmu-v3.0.auto: allocated 524288 entries for priq
    (... same for all 6 instances)
  That is 8 + 16 + 8 = 32 MiB per instance, 192 MiB total - 37.5% of the
  512 MiB reservation. The capture kernel OOMs before makedumpfile runs:
    swapper/0 invoked oom-killer: gfp_mask=0x2040cc0(GFP_KERNEL|...), order=0
    Out of memory and no killable processes...
    Rebooting in 10 seconds..
  => no vmcore is saved.

After - capture kernel WITH the series:
  All three queues are floored to one page per instance:
    arm-smmu-v3 arm-smmu-v3.0.auto: allocated 4096 entries for cmdq
    arm-smmu-v3 arm-smmu-v3.0.auto: allocated 2048 entries for evtq
    arm-smmu-v3 arm-smmu-v3.0.auto: allocated 4096 entries for priq
    (... same for all 6 instances)
  => ~1.1 MiB total (~191 MiB freed). All 6 instances re-probe cleanly
  (no -ENXIO, no allocation failure) and a 608 MB vmcore is saved.

Same machine, same 512 MiB reservation; the only difference is the v6
series, so this is a controlled before/after.

Thanks,
Yuanhe
