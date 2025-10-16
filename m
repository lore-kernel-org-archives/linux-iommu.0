Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41234BA37
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628670; cv=none; b=Z69cRRwgXIuC4mSf2cXMmVi6mhfl6crSnwaD8edkMlRDd7SlbpLfsOvg1IbMjq+Dw9RGdyPMSLUgRlFDtQYDEhUd63Hd+6dXXJHFBV3QZWQozy2mrKQUJ+i3GOQ11rJ8ktx2L2IOs4bZV0Qx8YE/aBy11amNBrpL+Gpcl0BepXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628670; c=relaxed/simple;
	bh=tG5OOuXeUWI2eXizLChcud8024S6FbBMNLQjqqyGqIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTBN2uA3cKMMyCZku9zQLD+n+luyRMdva66qPE6tlvbOjulXLp7zaxNOiwBrmjf2yeBnjyQTrovR3kMnLCT+DGdOnQsnIpO9wdvpsHufm58gn6tkNdiDBMHZ/yZl1G2QlWPgFNEMEdR4oKQjslg78hK64mjb9eYui2pRdBL39iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jlp4AvJ/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jlp4AvJ/"
Received: from localhost (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id AFC47211CFB4;
	Thu, 16 Oct 2025 08:31:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFC47211CFB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760628664;
	bh=ARfP24dBUs8fSS257602OfB6P4HZvIrohgAIMGINijo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlp4AvJ/7LCGOgJMVRUVivYl2TI6DabNsAlRS4knhdVygR2NeC9VPzpe9nAynzcei
	 U+Bd1tR12YEVe+YffqyNE2Bu2k9RE/UHGOvZQ275MGjLA+5of4XxNtYoVhTwxrqyE4
	 2zMRPPjX9yTn6PiljyTFoBIveuz7nMbSnrghp2ik=
Date: Thu, 16 Oct 2025 08:31:02 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Zhang Yu <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251016083102.0000585d@linux.microsoft.com>
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

Hi Will,

Just wondering if you had a chance to review these?

Thanks,

Jacob

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

