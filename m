Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0833538E118
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485035; cv=none; b=iR/eXv+7bodWSX8cVMfaB7+8qzozgHD74NY7b+9m17RjH4bqDSZg9TmPjiVG20FxnEG9gBH2xPdU6XRJRzWEbvfyOnEuSonU0rH7mGULjoxroYtPhyIn6PGVAfguOpUAYGqjCgcOvu4CKYau7dJChzcL0Gpjg8jlGiMatkht5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485035; c=relaxed/simple;
	bh=3IzQU9On3xSDH6q3xFZWzbcChOj+g0ahGWfSXXkgN/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljATAGW/l1xuXvzF6BI/29FjVm7U9jwWVG2oUiksVB2zmfGQGDEStTYCCbjqAnPadYAnYgnF3kRx2S1B+njt98dg0y7QLYAae/bic/Laucn6UsKWlwgCMGJHhC4sd6tXDX6lte1kQU1AsixhRLqK+CxIn8a0uQ9qltGpyg3Bf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=zknyM4fU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="zknyM4fU"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7D2731C41F2;
	Mon, 11 May 2026 09:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778485030;
	bh=3IzQU9On3xSDH6q3xFZWzbcChOj+g0ahGWfSXXkgN/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zknyM4fURd//t3TJgseqFgFGAKD1W18xXnwPlUoC28/4zIKx54jxfHSUcmcltovXP
	 XgnOnZjAnqCgpC9Nh6+6az/PfLSW/Sz5IUqb/+PpIGJ3UgR/cTEZMFpvOIoMG6Aj+2
	 jJwVnBv7UM3ZWaeLXN+B2yqDkU8SKpa+wDLAH4FSkhIX4kZI3o5qP476GeqdRhAk5M
	 u7sMDeTzIgOWolxG94QcJx4tuTn/15THz151kJVaZfWAmM3kRt5jUaPeeXv8VrmeK1
	 bRRRBpgmWLM26+BiyIJevQnke5wzm4T8MdIV4yFCCPFNoULGoi+rhke3sakGRtYcxq
	 tYCsPlTXvmwHA==
Date: Mon, 11 May 2026 09:37:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Remove dead code for exclusion ranges in IVMD
Message-ID: <bqfxldxlo27zdlnlcsxkxrrcjg6bep7tgfxdso5mdmqns7bg3e@k3cwzdybx6uk>
References: <20260331152550.479841-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331152550.479841-1-zhangyu1@linux.microsoft.com>

On Tue, Mar 31, 2026 at 11:25:50PM +0800, Yu Zhang wrote:
> Exclusion ranges in IVMD are treated as unity mappings with r&w
> permissions since commit 0bbe4ced53e3 ("iommu/amd: Fix the
> overwritten field in IVMD header"), using 1:1 mappings. And IOMMU
> Exclusion Base & Range Limit Registers (0x0020/0x0028) are actually
> no longer used.
> 
> As a result, several definitions and code paths became dead code:
> 
>  - exclusion_start/exclusion_length in struct amd_iommu are never
>    assigned,
>  - iommu_set_exclusion_range() always returns 0 now.
>  - MMIO_EXCL_ENABLE_MASK & MMIO_EXCL_ALLOW_MASK are only used by
>    the removed iommu_set_exclusion_range().
>  - DEV_ENTRY_EX is no longer set in any DTE.
>  - IOMMU_UNITY_MAP_FLAG_EXCL_RANGE is no longer set, thus the
>    IOMMU_RESV_RESERVED branch in amd_iommu_get_resv_regions() is
>    no longer reachable.
> 
> Just remove all of the dead code. No functional change.
> 
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 12 ------------
>  drivers/iommu/amd/init.c            | 23 -----------------------
>  drivers/iommu/amd/iommu.c           |  3 ---
>  3 files changed, 38 deletions(-)

Applied, thanks.

