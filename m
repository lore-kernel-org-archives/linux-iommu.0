Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42D352002
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115976; cv=none; b=qjTr1XXApG05rDyg6HJlJkwuE8AXX13tDPr8AtNDWxyH1YwNVnMx6OddAIoY3fMltuqLFHvvsoKTcn0SfcX4qKAdPfpmIKPbxMoSiHnDv8MTfZHzZ1AORqab52n8kY4HG/ig5WVPWNupANUhQgvAg1hoIdX/zV2aHtLScvkqSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115976; c=relaxed/simple;
	bh=J7dL52iAp0V6tkBafO4no7h353v0ALe/NVRaCF8fiW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuKOnGARmoSsqG809s0UeacEDrxeoraAzL9zCt5LOv+BQeM7neyMxxo8i4p61APJSpuQ40R+TwsAoVkxuGsUTLtpBe22UP2kofSMu4jvs8/Fja5TN9cJyxRo+ySnvl1wo4xSEf74JOh4D51exKmX1yNzIIZolP2Y9v4DEiP29IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbgbyXHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbgbyXHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805611F00A3D;
	Wed, 15 Jul 2026 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115974;
	bh=f14g3eRyyv8r7gbbzRptTQGbfsDCiij3wkULxA9pH+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbgbyXHl8cUaEz3REEKzALyupk0CFVibINKRLG2uDfaa6k5WSa1ZjsVa0lXEjYrJV
	 mIgfYde0/JNKHbZ6t1L+PyWbEPHaesOkj3iTlSHbBLC/S2TY5L88SdBfed261+FcTp
	 xhIwodabTjxe8Es9YfE43rL+731HMh3MvzIs4fQV1sRULgc3ar4nZTQTWueLfdIMpU
	 Aa0dn6P+ikDQQwjqJO+lfkgcKsFuJuYYbnPjQfh2Ae6Ech2mfjsmYiQVBej1SGOxJt
	 Ht5k5epDJgrhA331QxV+cXjMM/xQ1MYLv3qQvZzz32cgBgA59hUGtH3zxt2MyUCaDl
	 bDHbPVdbnrGLw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 981FAF4006A;
	Wed, 15 Jul 2026 07:46:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 07:46:13 -0400
X-ME-Sender: <xms:BXNXajq-9k8s3sMG4Nr9Le4est4zXtTQ9udNj11ZP5EzLJ8G46qLYw>
    <xme:BXNXapEsuGNn3OLsC4WuOh2Fz3X59-C4EZi0K3pqgRoEOVLIydfV1ZZbqgGUA_PJ1
    2jCLOupkA6OquM8AKJu-HX-pkMzJDYvMVe5T-HSeEDE4CU6pMkWMsM>
X-ME-Received: <xmr:BXNXau5lEhFVfYBb33xHjDrNMxePsOkNxcBXqvN8_PaZcfr8wYNObhR0FXi_vQ>
X-ME-Proxy-Cause: dmFkZTE6lo2AS56jZyzx7GorcfUYrhxiBJWxGWdJtmOsWtXHXx7oT+ZZG0WbO09bxneiMa
    30CkTgTNA8890T4LToWMNPiOXt37bxdE4E/TZKW0P1JxhHb2zrgPIM5r3k8/e3H4j1y+fZ
    8/MTg3DGHXkEcQQQFj56E8oJR+mWMss6Bw9ov4Nk55IjEr/oU/hDfnvr1i2sO4aIl80Mar
    HBJFidpj7fxjrN+3r2/oN2/jemBvZoAiTquYZBY+ZNmf7U4jA5dwEtPmt/JNyu8veLabrf
    9NUHwSJz5cSM964BW3/z59OR8d2bdvTLvqfxAaY2V7bqYkZ5YIV1don3Izxik3JYJJpNFd
    8Ww6rOwBsrvMNUJ8MPAI3Pq3bQbMKWtKXA19o6Y2yMsTriEBsO9Ihwux22K/CpKhSnql5Y
    bL7AhT9jWfPUXeGGd52FmWrL2HIGyyT6GdWMTwL6Lw9z4eFMTdiBFPiaQL69hc5uag0QNR
    qSTuAsE0S1luz9lerRtF8MvR7eMeJsIakd1fossbAurgISBUaYktS+sOt/+wFjlPXCWFme
    ufuTUAsjr9OLq8ZXKfbaKrjKGQnog2e+K05o76vM950CCwy+PCPfsQHpsg+MJG3nI95V05
    1WszXm3TkiMWcgFHK6Aln3QCxLRwUpYx0sj8SHIy8qcgdfsqSILFRTgbH6xw
X-ME-Proxy: <xmx:BXNXakBpc4AUW9ccf0cl6XDdMk6WKJZN8hOzxB9Ae-UUUo9ExbJojw>
    <xmx:BXNXapSc_RC347cAJzQGD7zgFEuNS5tTnA-EbJ1Yrx5by1SP5n_xtg>
    <xmx:BXNXakc-dVritM6FtwFwNZO10tuqPG829ND9fKscruvV4WsZMsS72A>
    <xmx:BXNXaiT_UdLzAd42EGmET30yZkJTAcfAlpznqxJ4cs6t4WLqQEkvmg>
    <xmx:BXNXag3wwv6RFoqhD0z7Azd1uZ-WcMkGydaF_KU-MU2wqsw_C7bww41I>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 07:46:12 -0400 (EDT)
Date: Wed, 15 Jul 2026 12:46:11 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, 
	Usama Arif <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <aldy9NMY1dRgJii7@thinkstation>
References: <20260706084708.8072-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706084708.8072-1-kas@kernel.org>

On Mon, Jul 06, 2026 at 09:47:08AM +0100, Kiryl Shutsemau (Meta) wrote:
> All SMMU queues are sized from the maxima the hardware advertises in IDR1,
> which can be several megabytes each, and are allocated at probe. The kdump
> kernel already disables the event and PRI queues (arm_smmu_device_reset()
> drops CR0_EVTQEN/CR0_PRIQEN) but still allocates them at full size. On
> systems with many SMMUv3 instances that cost is paid per instance and adds
> up to tens of megabytes of coherent DMA in the capture kernel.
> 
> A kdump capture kernel runs from a small crashkernel reservation and only
> has to drive the few devices used to save the dump, so deep queues serve
> no purpose. The queues are not on the DMA data path, so dump throughput is
> unaffected; a shallower command queue only bounds how many commands may be
> in flight before a sync, which does not matter for the capture kernel's
> small device count and modest I/O.
> 
> Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> in one place. The command queue still holds at least one batch plus a sync
> (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> command batching keeps working.
> 
> Suggested-by: Kyle McMartin <jkkm@meta.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Gentle ping?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
