Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4733F38A
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658638; cv=none; b=Fb3v5lq3QDfEYlA1ZDbr3sCa+MePk1h73RdZrRxniBLdbyjGqz122SYrDHszyITBQBnLCOVS3czTehIk9KVBYYLEaD22RaNopVjRK0EaiuEzKFMw5tnP7zQ9fkr+UlHI+IBoEtjOgOLWmDfaLS6iIXvl1srBsdIA4+/P0MkO/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658638; c=relaxed/simple;
	bh=CMvpJBgX8ZzMBUlEOCfs40YOh9rtwAumpLZqWU4mPaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FE00KIaeb2DPlD3Strqqj/QhgsU4UYZbWXorC0Wk4B66KnDjri82SiZOF+88Fsa24UMsqRfrNz50acE4r5y6e/OZPuu9k/9fF5DRZTIPTdN1teYSfldJYon3Xuo+2KxgSinwp8+Q44wA7W/9A5EwRehnJ7d9ClGNog+ZgBsrOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rcm4gESd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rcm4gESd"
Received: from localhost (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 22CFB211FEA3;
	Thu, 20 Nov 2025 09:10:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22CFB211FEA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763658636;
	bh=KOu1lPm57V1ETU6Ul1bNO6igxLehs0MzvTJ9B4RFNTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcm4gESdIExowPMwpEkZV/DQXGRJyYjW/iiRCIUQhIQNpthL1QV0jL2z2wjzWWsZt
	 QEd59WG3riwRY8dfBE4oQRO9Fw1FfkhAFyuus9GC/8I+NnZ6gxNo9OwbYKldQwGHRS
	 3tgT5O64Vj8wFK2SesOVNsL++dVyssIOeHk3n+LQ=
Date: Thu, 20 Nov 2025 09:10:35 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>
Cc: Zhang Yu <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v4 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251120091035.000011c2@linux.microsoft.com>
In-Reply-To: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
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

Hi Joerg/Will,

Any more comments on these? I could spin another version to add
Nicolin's Reviewed-by tag for patch 1/2.

Thanks,

Jacob

On Fri, 14 Nov 2025 09:17:16 -0800
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> Hi Will et al,
> 
> These two patches address logic issues that occur when SMMU CMDQ
> spaces are nearly exhausted at runtime. The problems become more
> pronounced when multiple CPUs submit to a single queue, a common
> scenario under SVA when shared buffers (used by both CPU and device)
> are being unmapped.
> 
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
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72
> +++++++++++---------- 1 file changed, 37 insertions(+), 35
> deletions(-)
> 

