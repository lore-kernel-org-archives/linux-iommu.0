Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B141BF3A
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404628; cv=none; b=I3LBJEM/q+BTGGS7NgepyvP3dmlEOAyAZARD0dXNtQLUCHirBem1h9zOLQaRh5vQ8cW4zOaw1R3o1pEG0gERHqYKhKaZ9aNnxcE7NT1PybX2ZIlZqTEg92N58oacYqFhrZk65Ik2GSXHhCvPyzPJ/inIrKla335F6sUd7KNwQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404628; c=relaxed/simple;
	bh=N++ENT7qtddi2glkqo456SlqMd/k8/AFVJMiKFZ5DKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGdVgrn/2XL6ickAz4vCRUd1xmmtX0R21WMWNQq2g1guIKu072Dzqr/cI5+XGQPgP5/M2bgCwhCtNyUjhg1MhjuVV5lMJf1GpzO3/CjcR8p6iCFPDBlNCnM/NNoZLUV5MXNS5c/MMAAYmR9dRZ1R3ajkHGKFRlCfWoyIBeIfzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IHX6Y4gQ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IHX6Y4gQ"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2B7E82A7BA5;
	Fri, 23 Aug 2024 11:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724404618;
	bh=N++ENT7qtddi2glkqo456SlqMd/k8/AFVJMiKFZ5DKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHX6Y4gQCobozTK5gwXV8/ycga/MhhvoqG85+kI8f8Rr/DqhLcrgQ9TIzKdDmJL/I
	 Zk9k0GhIXxrSKmMKtSeOGwQJcE49NyB8C7zZ/YghLGYdLD4xLoFBVJ0qGkdpP2kyUK
	 ISlgiE7A+oD6dIRuE8chzPTryqjHa9hxUBoVGzWn992hdgRwxd6I+J0VybkUyUMdtu
	 EVHITy2MqfT7uBdfISPGNZ4hsnZC666gwVnEM65flRLbeuO9XEwNPNgBxiP9t0beiA
	 ocxwFYGr/7f/fnnLFGCrCswTaz5JJ6hKNMwnNYsdAE9QRrmde5qZQlO9RAH5LTgwHh
	 D6EIPX5A0Q24g==
Date: Fri, 23 Aug 2024 11:16:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rc v4] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <ZshTiaugeEu0Jmk9@8bytes.org>
References: <20240816104906.1010626-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816104906.1010626-1-praan@google.com>

On Fri, Aug 16, 2024 at 10:49:06AM +0000, Pranjal Shrivastava wrote:
> The iommu_report_device_fault function was updated to return void while
> assuming that drivers only need to call iommu_report_device_fault() for
> reporting an iopf. This implementation causes following problems:
> 
> 1. The drivers rely on the core code to call it's page_reponse,
>    however, when a fault is received and no fault capable domain is
>    attached / iopf_param is NULL, the ops->page_response is NOT called
>    causing the device to stall in case the fault type was PAGE_REQ.
> 
> 2. The arm_smmu_v3 driver relies on the returned value to log errors
>    returning void from iommu_report_device_fault causes these events to
>    be missed while logging.
> 
> Modify the iommu_report_device_fault function to return -EINVAL for
> cases where no fault capable domain is attached or iopf_param was NULL
> and calls back to the driver (ops->page_response) in case the fault type
> was IOMMU_FAULT_PAGE_REQ. The returned value can be used by the drivers
> to log the fault/event as needed.
> 
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Closes: https://lore.kernel.org/all/6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com/
> Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
>  drivers/iommu/io-pgfault.c                  | 121 ++++++++++++++------
>  include/linux/iommu.h                       |   5 +-
>  3 files changed, 87 insertions(+), 41 deletions(-)

Applied, thanks.
