Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D52E4257
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007120; cv=none; b=qS66G0s+uhxom9AVUFPmvTm+MLrhD3+Lo5Yc17OSimkljDhhu73Z3QqxajMzxgnJYQan9w8to8eG6G7UGANV6OH9+/ijQjQ0KYBjEKY+EdofcSWsidHu3afmR/Y1n/XpIyMo42nW22FYvU3r2w6Nl5iFVegkAiNhWVx7xvImwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007120; c=relaxed/simple;
	bh=zYxnUWoxzsLfDARQUd4y71jgV6OD9Q+8M6hZ6AH1mnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1YZGBbd/S00ZkNx+PJSm1qxVFS8aXLW9FMSjG9SfrZaazPLtMtB3LYz9Y6LZ1rIih3yQteZfTT38Ao97ABxpruaUQJiqdRJ3CC4o+xmI+G7sVDyAiHb/eNZumP5eZdhYsDHn5VkJLe6WOu8DT4wlTxWiLWs197hh6xlF71YqvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ezj2cJgh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ezj2cJgh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso565ad.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780007118; x=1780611918; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3lH3cjkzIHlx4Slw2VWW5sli+Rig7PDMVIlCqK59Mc=;
        b=Ezj2cJghIbHYE0G9DpamUJSxLsHQ+lYbPRm5u+wfa81fCa3sYaoYcTsVdCBSKqQ+U+
         sD2hUiD/ersvV6XMubNSBJIIjo84P7I9S1TyTHz9KdVcpEcBK8Du7MuQ1mke+invwwgz
         T7bu7/4M9zQ8WHGgDJrU7SWopPihUGLAtwABBmsu43/l0Qpgu+fw2ifXAqmtw4zLTogi
         GB+8NQqfmxdbjzN5jtHMf3crS7dnEmT2sSfgGfxwHQwhIJABpPezGZcD/XK5juQmLS19
         CyvyXpguCRxtf2zkcIDe/tBe/Ww1UfpHSTQjxx4WD3Kmmbzaaux2yq13nVGBRQ9vMJJi
         1S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007118; x=1780611918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3lH3cjkzIHlx4Slw2VWW5sli+Rig7PDMVIlCqK59Mc=;
        b=XwKnGByVZ/ZOYLcCtxgdHtMPzcrQdiaqfhL2Ns9Ofzo3q+aOQKN439PeG9NWRS/my6
         D5YnAFMLYxuS6mE8o7D9zhVqz/P0ocfb3vRh5FnWOpm7o8FxvaNCY0l+VhJaCMjc/KjJ
         tN6LkQMu+0Of65lpMlCHE1/Fydjmq1tOhbtZaZXJQPnd/73kb/gn9nKA+1I9DIoO/1kL
         8vNUylqMj/+ptE3N8wZzbLIfxICNe0DJkTmBghb0wuPP1LxGsBQdA4IJlylUhJ0+xlw6
         qJw58iIpwr32Op8RJ1YbBhnCyBz41yQzJICiClZyp7KEQjDYQpvtTgMhUoJPmGfJmixF
         fibw==
X-Gm-Message-State: AOJu0Ywgss9jytbNrCkhcE8tIfzt4USZZhCWBo/+kyAGVDCg9rZo5BQF
	Pq0GyazbtZUqvx+w/M5oCFAhjUg2RLCyBhfyRYqkO66tChOY5RViA2helWO+Bi8S/A==
X-Gm-Gg: Acq92OE3NJkx54CfZE7Crel0u9+dX6tfFhHtVfzy7zHYZX7+8wZVvostXTdKr0naQsU
	KOzQ0io68rBQJJz5QBQrScC181kCSuRCrnfBijygC7a2wgFeeiC/cHM751BdMEKiTSJ/Z+VRYXa
	yJarH5Y+IMDoctOBvQ/CJSRDjXj+ko0I2UgGJy0deZO33VtDNsQqp8KHEZsKHat+l4AiOS53szw
	lwfgqZL+j+5OICZqTu8N6U/m1wme1uIS3pbZQbmjm2O3a1Ud3y5aCn1mD7s2fffGkKfBKq+P3pM
	0cK8BrbsP7XvlK9rwoU/+4/m4l/8EC2QxaU37kI4kTn65BPOSxupBoS8607pDdaZLHcLmHQdhPV
	PgYFwr1l3eDRcotTlZ08Da7Kr3X/YxWc9gsvqleYpNSwdTWjl8Q7leNwhZaLopVK3pBG/AFkDVU
	V2f7tXS8bGsCgVrGfGqtC4fvSSijScgZsAztwOwLw2IkOjI/fhuWM5g0qt6KisGEHBmU5TSZ9wr
	6dQy7E=
X-Received: by 2002:a17:902:e884:b0:2bf:28d:87ad with SMTP id d9443c01a7336-2bf204cdd20mr428735ad.0.1780007118059;
        Thu, 28 May 2026 15:25:18 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf218530c0sm647205ad.20.2026.05.28.15.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:25:17 -0700 (PDT)
Date: Thu, 28 May 2026 22:25:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ahjAxx-cyww2va__@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-11-praan@google.com>
 <ahilX8Za1NRCH3ik@Asurada-Nvidia>
 <ahi3uY9YZZtR1Lq5@google.com>
 <ahi7KWov1+GC3xVx@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahi7KWov1+GC3xVx@Asurada-Nvidia>

On Thu, May 28, 2026 at 03:01:13PM -0700, Nicolin Chen wrote:
> On Thu, May 28, 2026 at 09:46:33PM +0000, Pranjal Shrivastava wrote:
> > On Thu, May 28, 2026 at 01:28:15PM -0700, Nicolin Chen wrote:
> > > On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote:
> > > > TLB and CFG invalidations are
> > > > elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG via
> > > > the arm_smmu_can_elide() helper.
> > > 
> > > All the arm_smmu_can_elide() call sites here would eventually elide
> > > the commands in arm_smmu_cmdq_issue_cmdlist() that is already gated
> > > by CMDQ_PROD_STOP_FLAG? It doesn't seem necessary to gate again?
> > 
> > While issue_cmdlist() would eventually elide these commands, the 
> > can_elide() check is necessary to return early during suspension. 
> > 
> > This avoids unnecessary stack allocation, cmd building, and spinlock
> > contention on the cmdq->lock for threads that are anyway about to be 
> > elided. 
> 
> We aren't in the perf sensitive path.. most of those aren't going
> to be that bad.
> 
> arm_smmu_cmdq_shared_lock() on the other hand is taken at step 2,
> and the STOP flag in the same function is gated at step 1?

DMA unmaps frequently occur from atomic contexts, interrupt handlers etc
Thee Step 1 check in issue_cmdlist() happens under local_irq_save().
We may argue that it doesn't happen for long though..
> 
> > By dropping these requests immediately, we significantly reduce cacheline
> > bouncing and contention during unmap storms.
> 
> How significantly, so as to justify invading every command issue()
> call site, which would be difficult to maintain? If we really need
> an early return, it would be nicer to have a common place at least.

Eliding early is more of an early-exit from the DMA unmap paths really..
If maintaining these high-level elision checks at 4 or 5 call sites is
a maintenance burden, maybe we could move the logic into the issue_cmd
macros? 

Thanks,
Praan
