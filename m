Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141D2874FC
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763673; cv=none; b=ISCLMb4nfEManNplsffUxAHPGDCZn8c80cX7ybKgWgsrxKn8MW12oXrdxQvcRKlueHvHkeUZfcYQV3vtTMh70cLOjbLFCiWuHKhvT+GpqaodCr/QuNpMWAZkorBqZJHUDAukyJRd8/geahYyAb90ryC2cp+zkAALLPse54MghvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763673; c=relaxed/simple;
	bh=P7q3L9cFl4NvnpsWufccAUkKh6NxRK8XD6itRENZbm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofNmeRAcspPAykUfASRD2g0DrH34ykT0ujkthD6FLP+5qs2dpUp2oU4U4Khj+D+pa+JHxEJNvfJoFd71JlH3uNT23MKOl6WKlE6ZL/vgyh6sjl38iKybDWBo3I1xalrvKKdA52C2J2m6klG/2pVsbaeVxxAIj++unj+NCQLHXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hX46UL9c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hX46UL9c"
Received: from localhost (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6751C211AF2F;
	Mon,  6 Oct 2025 08:14:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6751C211AF2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759763671;
	bh=72+JPJiOqDjJvRgkstdls2WR3nyNfas3QPwyZMW3m9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hX46UL9co1odEUHSfaKn+tsxM4VCxi0h2LU7nq4Lb3j0kFmVGxWVkaUWzf89XYqqc
	 ISU3Y8V8uR+M4Vf57wp+BQx2Kef6qiIEEa+E7fkLG8Vg6rEGUs7omhgVFgW5ErljTM
	 /T7cmdhedgd4BkybvVjbHA4qekpKU1JupDcL5igU=
Date: Mon, 6 Oct 2025 08:14:29 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>
Cc: Zhang Yu <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest
 <Alexander.Grest@microsoft.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251006081429.000002c0@linux.microsoft.com>
In-Reply-To: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, any thoughts on these?

@Jason @Nicolin 

On Wed, 24 Sep 2025 10:54:36 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Hi Will et al,
> 
> These two patches are derived from testing SMMU driver with smaller
> CMDQ sizes where we see soft lockups.
> 
> This happens on HyperV emulated SMMU v3 as well as baremetal ARM
> servers with artificially reduced queue size and microbenchmark to
> stress test concurrency.
> 
> Thanks,
> 
> Jacob 
> 
> 
> Alexander Grest (1):
>   iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
> 
> Jacob Pan (1):
>   iommu/arm-smmu-v3: Fix CMDQ timeout warning
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 85
> +++++++++------------ 1 file changed, 35 insertions(+), 50
> deletions(-)
> 

