Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6B3624A5
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858214; cv=none; b=U+eL3IloCoiWwSYWwTB2VLpzo9rmJtp28NfCXqvRx/V8K1dTgiyDURQPGoefAB85uwN6Cqtz3tvsY+fOVh+D9/smA0VLBQQRNJmy1wc1+TqKlUkfLrFpxKjFrhss1eJR1IbSSxztiaY34D2AZYdZ1c7/HdxDjJChdwTxYZAmKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858214; c=relaxed/simple;
	bh=wCnL6viEy1CesNNIWQQHyBFJylxrQHFF/Yc3GsIfI3M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NcjqXQJuMwfKMMbN7RDuUolzDSMwURjbYp60iDZLOZkl7Yo0NfQidpgkzIR/+zSRu54aPxVm2rjIoHG2BxypGqM4tg/n2opJv3j898x9u65ggugZ7Zw7jU1oUCfUxz8wRDTtXY1paRoynNMrcb7roPGdGyrGKvdBo3W452/ogV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sth5oaSX; arc=none smtp.client-ip=95.215.58.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sth5oaSX"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=wCnL6viEy1CesNNIWQQHyBFJylxrQHFF/Yc3GsIfI3M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791858209; v=1; x=1792463009;
 b=sth5oaSXVmazhbqjMSm9UreItIu7BqfmBHDx3GkxkSOr2A2T6L7KwtBHUW0WLaBq2sQ9efAH
 HznDHucugTQ+K43NcNThdrwVa8LD3m8o78pjyOlQo2yFnjVQ0H8G7dEBK1xPn0h44ta4QG0OPXI
 lk3PosVQwvW+cMpjqXLIUdzg=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c5dacfae51997a19;
	Tue, 13 Oct 2026 02:23:29 +0000
X-Mizu-Trace-ID: c5dacfae51997a19
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] iommu/sva: Charge IOPF allocations to the faulting mm's
 memcg
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261012200823.699316-1-peizheliu@utexas.edu>
Date: Tue, 13 Oct 2026 10:23:14 +0800
Cc: Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 iommu@lists.linux.dev,
 linux-mm@kvack.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <38FAA6E2-15C2-4C1A-9E3F-3F0B079A9D08@linux.dev>
References: <20261012200823.699316-1-peizheliu@utexas.edu>
To: Peizhe Liu <peizheliu@utexas.edu>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 13, 2026, at 04:08, Peizhe Liu <peizheliu@utexas.edu> wrote:
> 
> iommu_sva_handle_mm() runs from the IOPF workqueue and calls
> handle_mm_fault() for the faulting mm, but does not set the active
> memcg. File-backed faults can allocate page cache through
> mem_cgroup_charge(folio, NULL, gfp), which falls back to the root memcg
> when the worker has neither an active memcg nor a current->mm. Page
> cache faulted in by a device is therefore charged to root and escapes
> the task's memory.max.
> 
> Set the active memcg to the one associated with the faulting mm while
> handling the fault, and restore the previous value afterwards.
> 
> Fixes: fc36479db74e ("iommu: Add a page fault handler")
> Signed-off-by: Peizhe Liu <peizheliu@utexas.edu>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

