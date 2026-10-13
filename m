Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862B3CF04C
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908607; cv=none; b=hIz17dCtPS0mwkW3o6kMw6z8ERPe+9FsUJ/gMkhl61TDxx8n3u8nVH3OVFkj+C8mySprhRV/vy75GfpQnScqKDDeBr1nU1I6MdEPsdplpKa7xMXwPUp/tBsGTuL7CDtvc35+E1cnI0KV7ny6FnOQvbP9x3LLvRia70sP3CAf2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908607; c=relaxed/simple;
	bh=KjKzlUft5xNV3o/eqcbVESlWEYwfRH38VPCouMzjfIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWg231IYn5U9y7Qq7Va24KlQ2GnsFuW4sbIUBU/sp2F1Xq7+OQ+lSnsgMXlr9LRdBabdgQeu3k3LtQ+cyLOWjVGuuR+FVEzIRxjmgH8hVq5IrWwLZMJP7k9z/fOBagyKY10MYF3uWCIvy9DoCVlcKFuy1nBUgK23dhxm7FMwO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=R7FsTosr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="R7FsTosr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D03EB169C;
	Tue, 13 Oct 2026 09:23:21 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 295413F871;
	Tue, 13 Oct 2026 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791908605; bh=KjKzlUft5xNV3o/eqcbVESlWEYwfRH38VPCouMzjfIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R7FsTosr3Xgh6POSYmp6YKYdBHjOI4Eg3ZXseaXZo+5lMCpZk3B5wCT84+LhzPjcG
	 Z4sArXt+D+iIqYMMqy2k7kM/w+MGjOhsYm47G0CmeOIz7pcrnKDzflot5kGo1nPOFl
	 RaehSl84mJ5SsiVj/EQ8KwwA5+bi2VSFiM7Tbbwo=
Message-ID: <4d2a05c3-f7f6-4348-a3b4-c8f3ffa79b6c@arm.com>
Date: Tue, 13 Oct 2026 17:23:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Jean-Philippe Brucker <jpb@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>, Krishna Reddy
 <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
 <aszfVNP6DGzWYdK0@shlinux89> <as1zR1wc7ERxvR1F@nvidia.com>
 <e8c22eb2-ed1f-47c7-b2ac-c56ead1cba8b@arm.com>
 <20261013124400.GI14213@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261013124400.GI14213@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 1:44 pm, Jason Gunthorpe wrote:
> On Tue, Oct 13, 2026 at 12:22:06PM +0100, Robin Murphy wrote:
>> If we're not going to support PASID for shared streams (which I suggest we
>> don't...) than we shouldn't strictly need to worry about CD tables anyway.
>> So rather than having to special-case CD table sharing for shared streams,
>> perhaps it might make sense to generalise back to a "default" per-domain CD
>> for non-PASID use, which can then get switched for the private per-stream
>> cd_table if and when a device does enable PASID?
> 
> If we have stared STEs then the group becomes the per-STE data
> structure not the master.. We don't have any way right now to do that,
> but it would make some sense for the group to store the shared CD

That would be precisely the aforementioned special case that I'd hope to 
avoid. My point is that the CD represents the domain context, so we 
really shouldn't have to have multiple copies of that per-device _or_ 
per-group, _unless_ it is attached via a PASID, since in that case it 
does need to be copied into a per-device CD table (since the per-domain 
CD table was indeed the wrong move in hindsight).

So what I'm saying is that if we're going to make anything share CDs, 
then ideally we should just make all non-PASID devices always directly 
share the domain's own CD, then if we just enforce that any devices 
sharing StreamIDs must be non-PASID devices, it should all work out, we 
save some memory in the normal case, and never have to be concerned with 
rewriting any STE with a different S1ContextPtr for the _same_ domain 
except when enabling or disabling PASID for the (single) device owning 
that STE.

Thanks,
Robin.
