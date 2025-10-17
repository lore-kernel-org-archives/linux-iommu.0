Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286C92E5D17
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719835; cv=none; b=eITgwn7eeTCaVc1RpCTcSqaT9HEoOZHJtV4BqAZ2gpu7EklddV06O1UM+mmJgffIR1gMCPaNj2Y89ul8ARrym+cgvuELVKaKXFETZrKIaewt66mo6SiXMAA7p4CdMsf9L9VmRkVf1xmUJKwTTfJE2tk5MhgJuzxtZzPqbQAIOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719835; c=relaxed/simple;
	bh=mtCbXHEAPt2iILdrFLSo9e/AY9Dnd5QIxv4IZlxgLUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zo3DRAY8lghT90my/zsfGhI9L39CLfmbiHv/qJdpBZfXR8wb/1C3tHxOOfIkPxD66rAm+Xr6RhTC3dSfiTHC2G4n7PlpqNuaD/3cFiu3Sa4QkuWmf4Vy0k6LMHBhWhX7uqqtpqgmuYM4bhfefbayX2ybmzBOQpaLSoLohMzD89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Rx5DkkLh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Rx5DkkLh"
Received: from localhost (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0F0C1201726A;
	Fri, 17 Oct 2025 09:50:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F0C1201726A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760719833;
	bh=WuaP/6xvHr8sPltUX+ihhaZydpYE0LvTzCz4z5o5434=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rx5DkkLhSMxz9rqZXdRkTkeh4YUpyDDxrZnxO6EHexshdwlHWQ6Cod58U7s5KiI6k
	 GX8U10UXBDo005auREFjks/g71fW0woQG2bWmitqDnkRkWDTsgAP3az2iuurhJDh+L
	 4Kr+Cwnjl/lt4yS1daPUU4kPqjcwpEWUoM9tk3nE=
Date: Fri, 17 Oct 2025 09:50:31 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Zhang Yu <zhangyu1@linux.microsoft.com>, Jean
 Philippe-Brucker <jean-philippe@linaro.org>, Alexander Grest
 <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251017095031.00000b84@linux.microsoft.com>
In-Reply-To: <20251017135145.GL3901471@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
	<aPIhMGnzHiBkIEam@google.com>
	<20251017135145.GL3901471@nvidia.com>
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

On Fri, 17 Oct 2025 10:51:45 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Oct 17, 2025 at 10:57:52AM +0000, Mostafa Saleh wrote:
> > On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:  
> > > Hi Will et al,
> > > 
> > > These two patches are derived from testing SMMU driver with
> > > smaller CMDQ sizes where we see soft lockups.
> > > 
> > > This happens on HyperV emulated SMMU v3 as well as baremetal ARM
> > > servers with artificially reduced queue size and microbenchmark
> > > to stress test concurrency.  
> > 
> > Is it possible to share what are the artificial sizes and does the
> > HW/emulation support range invalidation (IRD3.RIL)?
> > 
> > I'd expect it would be really hard to overwhelm the command queue,
> > unless the HW doesn't support range invalidation and/or the queue
> > entries are close to the number of CPUs.  
> 
> At least on Jacob's system there is no RIL and there are 72/144 CPU
> cores potentially banging on this.
> 
> I think it is combination of lots of required invalidation commands,
> low queue depth and slow retirement of commands that make it easier to
> create a queue full condition.
> 
> Without RIL one SVA invalidation may take out the entire small queue,
> for example.
Right, no range invalidation and queue depth is 256 in this case.

