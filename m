Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFFF1CF29F
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442586; cv=none; b=EXcvYFRhwIY3jn2T4di2sQDpNfEVcS+6WRaPvMxVUXeUqYt0CNWT97V980nGP/RrxHJmE6wdGzsgciFot2Aj8+crw6PAYnGtBrFrmP2SHXXu3pqALyn/3rbhCAAhSc/+XTNIG3Gji+xnPX5hmj9Sq3CY7myO5f9pf+xBQLz20EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442586; c=relaxed/simple;
	bh=BPxZ1tqOubENUCv+i1gitzWRKrMbZC/ltiDEhpYNj50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS+kWIZLRAXDB73kcuDEVLTUBi6Zb1U3IBBrtNIVGJXRRslaagTiJh7IN2D9STAcwRNTlN5M7T1BLEVY9lKQOEv46UfqveCwbARvVxRHy0cepL4/Q9w2ARKpRAMYPKhKyn7QEM6t4lY6XGTlkbQsfPth+IXkg7Ex1w5eYt+DJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Wtl4XRDA; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Wtl4XRDA"
Received: from 8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5A1D8285A43;
	Wed,  4 Sep 2024 11:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725442583;
	bh=BPxZ1tqOubENUCv+i1gitzWRKrMbZC/ltiDEhpYNj50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wtl4XRDA+yNm4mB+GkbH1hhGuAx7Q0v8s/QzkzYd9UiR7jvggbXW1693qHROYHAUc
	 s5rkLjp6JfFtFInE/ErNUy1OEz+QCirsDH0sVdkKjVjJszAjTcIlnYli77DanfUBEc
	 OjhWHlkLRDqf4LL+/AtC56qik9VMnEwVWtW9fKGoIoNKhly0fxJ9FP/R68aGVp9P/A
	 uS3zvOZUhfYHYwjn/1G93006BeTeMzZr2i2l/OkyicNZbD0d57WmYDmcduIzvG2aW0
	 XOdRgxAJOVFT7EdRu9rJpNG1gbo4sfoFZkYZ5/GvgMElm+H6hURHLj1HBsrreG32sf
	 6gQ5scZqt1Pnw==
Date: Wed, 4 Sep 2024 11:36:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 0/8] iommu/amd: Misc cleanup and trivial fixes
Message-ID: <ZtgqFjaC4VS8k_oi@8bytes.org>
References: <20240828111029.5429-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828111029.5429-1-vasant.hegde@amd.com>

On Wed, Aug 28, 2024 at 11:10:21AM +0000, Vasant Hegde wrote:
> Vasant Hegde (8):
>   iommu/amd: Update event log pointer as soon as processing is complete
>   iommu/amd: Make amd_iommu_is_attach_deferred() static
>   iommu/amd: Remove unused DTE_GCR3_INDEX_* macros
>   iommu/amd: Handle error path in amd_iommu_probe_device()
>   iommu/amd: Make amd_iommu_dev_flush_pasid_all() static
>   iommu/amd: Make amd_iommu_domain_flush_complete() static
>   iommu/amd: Rework amd_iommu_update_and_flush_device_table()
>   iommu/amd: Make amd_iommu_dev_update_dte() static

Applied, thanks.
