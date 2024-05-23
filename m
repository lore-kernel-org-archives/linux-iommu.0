Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E4433C3
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474996; cv=none; b=aVodoD1xb6O3S9rRbrwQARSZD0vbqqy/wifAsU0w9V9HZAVBUcHzhbysbPdf8StVqiXxiQinMV/bJ8qZoxGF2pQ7xnKY6urgYnnwgi3X1QIdAAyOT6oKiHNB0OwY0ahLrbP51cuFEeq9++vGNzbHRj3eor03w1cR7MSs0Y1EzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474996; c=relaxed/simple;
	bh=9sS78x2ZdckMIB2ktWRxsrmJpPyzQYRCURWv7oKVTdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPob9SngPjArAsJnwlwgScGam11T9eXedjQKm9tqNBWYudoRR5NFGwMD71H8zyvDy1Ulv858PWdZO3UpokIvrgU34BKfoyzmFX3+r6orTOBWxDR5gGm4/GN3Gpgfzv5YBegAugUjfgTycjVTObTBHPNZs9Fj4h4f3wGUBZIZLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uNwBYL7e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uNwBYL7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716474992;
	bh=9sS78x2ZdckMIB2ktWRxsrmJpPyzQYRCURWv7oKVTdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uNwBYL7eeBCRiwhJoArAWBijyr722eWCnaXDG72gHvyA0Ao3uvd9iqn0XvIygcB47
	 XWldqcAS/CLL5wX0Yh3O9yVI2WQ0u3vowpL3mr8M69+0Vx/4Y4BHpYh8c7k00cn06d
	 ysm4kXfzZh2zKimil0ZGPPFqOsoPEgM/rH3uu+xgsdoGTxav3jtwye14fHUGHAHLjx
	 DP5olZUQaRVi0kyYeEfdUsnCLpawtkGX2vmkut/pvpiuRyTpQx8qz+iNsOd+ys/i+X
	 5fGZoX/sQ+P+gpQ3bn/pZWUv4mo5eZXSSiU8PdvjKeQt/YZLNCv8J/BVJLQC10INrz
	 Ebs1cM7S6Rydw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BC5F637820FA;
	Thu, 23 May 2024 14:36:31 +0000 (UTC)
Date: Thu, 23 May 2024 16:36:30 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 vdumpa@nvidia.com, linux-tegra@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu: Optimize IOMMU UnMap
Message-ID: <20240523163630.24992c28@collabora.com>
In-Reply-To: <6b707eb4-5cf3-4b66-8152-5ba252f5df39@arm.com>
References: <20240523031935.90856-1-amhetre@nvidia.com>
	<6b707eb4-5cf3-4b66-8152-5ba252f5df39@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 14:41:12 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 23/05/2024 4:19 am, Ashish Mhetre wrote:
> > The current __arm_lpae_unmap() function calls dma_sync() on individual
> > PTEs after clearing them. By updating the __arm_lpae_unmap() to call
> > dma_sync() once for all cleared PTEs, the overall performance can be
> > improved 25% for large buffer sizes.
> > Below is detailed analysis of average unmap latency(in us) with and
> > without this optimization obtained by running dma_map_benchmark for
> > different buffer sizes.
> > 
> > Size	Time W/O	Time With	% Improvement
> > 	Optimization	Optimization
> > 	(us)		(us)
> > 
> > 4KB	3.0		3.1		-3.33
> > 1MB	250.3		187.9		24.93  
> 
> This seems highly suspect - the smallest possible block size is 2MB so a 
> 1MB unmap should not be affected by this path at all.
> 
> > 2MB	493.7		368.7		25.32
> > 4MB	974.7		723.4		25.78  
> 
> I'm guessing this is on Tegra with the workaround to force everything to 
> PAGE_SIZE? In the normal case a 2MB unmap should be nominally *faster* 
> than 4KB, since it would also be a single PTE, but with one fewer level 
> of table to walk to reach it. The 25% figure is rather misleading if 
> it's only a mitigation of an existing erratum workaround, and the actual 
> impact on the majority of non-broken systems is unmeasured.
> 
> (As an aside, I think that workaround itself is a bit broken, since at 
> least on Tegra234 with Cortex-A78, PAGE_SIZE could be 16KB which MMU-500 
> doesn't support.)
> 
> > Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++++++---------
> >   1 file changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 3d23b924cec1..94094b711cba 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -256,13 +256,15 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
> >   				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
> >   }
> >   
> > -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
> > +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
> >   {
> > +	int i;
> >   
> > -	*ptep = 0;
> > +	for (i = 0; i < num_entries; i++)
> > +		ptep[i] = 0;
> >   
> >   	if (!cfg->coherent_walk)
> > -		__arm_lpae_sync_pte(ptep, 1, cfg);
> > +		__arm_lpae_sync_pte(ptep, num_entries, cfg);
> >   }
> >   
> >   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> > @@ -633,13 +635,25 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
> >   	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> >   		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
> >   		num_entries = min_t(int, pgcount, max_entries);
> > -
> > -		while (i < num_entries) {
> > -			pte = READ_ONCE(*ptep);
> > +		arm_lpae_iopte *pte_flush;
> > +		int j = 0;
> > +
> > +		pte_flush = kvcalloc(num_entries, sizeof(*pte_flush), GFP_ATOMIC);  
> 
> kvmalloc() with GFP_ATOMIC isn't valid. However, I'm not sure if there 
> isn't a more fundamental problem here - Rob, Boris; was it just the map 
> path, or would any allocation on unmap risk the GPU reclaim deadlock 
> thing as well?

Unmap as well, because of the 'split huge page into small pages'
logic when the unmap region is not aligned on 2MB.
