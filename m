Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83A328616
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954211; cv=none; b=DMFr9Yr9b7xv2s6PqUPJUVq2LwQWx+hgBzFzZk4ap02QyMwih5NqOe3Etj3x8dUg8SdEJ1xmXlEAOW69hwC+VA50uXQTBLXNOl9nqMnNwTeQj1X9wbuHbUUoP5bbOsnBhVa4xl87qXKcgZPdlL95Vy7v/Uh/jjxDMlduK7dLIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954211; c=relaxed/simple;
	bh=m9/+Adp7uzzinYLOPcOlOBCorYgZVbqbRNXtl6rb6hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6SL1UrHjGxwDSV30mmZZ5ddyQySiW9A592MWQ8qX3RZbKr1W+Y0+/58LB5b1qzkhhkiEpYFKsBIYKyThxb7H28fJtxzl9YLbUyQcjbAqNOUvXZunC5/LH4DWh8emDcsjO0kdhybgyBdHsAh81D+MPqxKviT1IDfzKsxYX4Uk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=i1aN8wHp; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i1aN8wHp"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8eea23d01f7so122788785a.0
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776954208; x=1777559008; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qVBvXxlgya89SxaZAr5N0EnIlllRggjnL98TRto1Gs=;
        b=i1aN8wHpDu2k4LQwNdIVPcDZGP27+5fpjg5AEM+GlUJPOSuDb2EXz0NOJCrO9uWDHw
         1kI5SAvGrH1ZMepHFJjBaqYK5AxeldUjs7tmsHZw4MiYsvaquOrygOv+Y5Kg45NLa2lH
         IBbbVd/L1xFAtWoHxHZckwtwtG9o/hu5l7iEzF01z/oDrmMZxvBTvs22m8Ig9Vy+VZoF
         vaGQFVRlD690ZbP5hhG+y2GqxMsIxLYJpLBP7zJXpaby7gd50dMYZluYLtZxRQrNk9cc
         i61FXVrgZ2F0FJrrK/a1MBXSOq6GW9LrmdxVmDT6elccbhC5SOshsDBbM/f91kENhls4
         0hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776954208; x=1777559008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qVBvXxlgya89SxaZAr5N0EnIlllRggjnL98TRto1Gs=;
        b=C/HhLvvuxt8x6FWLZg1C1PWO3qvrNetjWAdMTxb8cO2lS14gRUiQ6x63Xs4I3Z6P04
         VzPnyfYsvGB4LwZFIIqjzKiriqGCkGBDYRXLY4I2jkFjRf99NO2y6eupERH1OK9MfqyZ
         jwlWqEy11lSlDMMRU+EXsbBuUzkIUmHUzR32ycOySDLkw3gqflBXacPGeL99Ku92X16V
         C1Q31uOp9YSo00813d2/+MpP7pTP5WOV8G00PQCNc79bZt1p7UeL4oKkqOmJGwPzm78B
         JRdaeYTwP2sFKsC/fSqExD1kRKb5tOz+JqdFlRKntisqq90xy8WJfMQ6cW650k91mp7z
         Falg==
X-Forwarded-Encrypted: i=1; AFNElJ/zL+ZTllMfFPLLC/hqcftngOTY8cGF71eX96fPNG+LsKZx3JsGWwF8+GY5RDxXfLP/w32F5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvpKzpI88dwPMtdqSezkXWET3nxfuACByDR48QuXDbFAFnY6nU
	vCEYZKBbnsx3r6XRq2aKBJh2zEhGgFSfPNo4mnacuS+ufRBW0+xVM6l5hzeQqq2ceYU=
X-Gm-Gg: AeBDiev8SQDHArthy6zzy0fcAlhtp4QFb9qqhxzNVNDYNWxOfzDoOv5HFaA/yP5REXV
	OgK2T2Zl/vIN0/25QfW7lYU72L2qjIjS4HnTJaJ8tFmsN4l2mq0fpKVrMEAIvnzndOC6Xf8OWB/
	2ECFi6HynLWZsFIJNFidOrpbm9beNeECVkTya1dNFL+m2dGhia0SyFYDaVwOSvP/FBpCxm7H4t/
	MJsG6WbXB29w90d3e9Xp/Vj/IwSbgrxMM68d+1a3J+ibqsKBU/KZk1B1nYvV6Rrx5y6Wo6U/JCR
	nF60XPcg4RaeNuR+Cn8l4fYMx3wK3ZxBKtgYInUl9w7EUiv7QRfS/UDftTJdbwbTBKXL+COSmvn
	i+HFXiW9qXHww2hdB7pF6jRXSEwNSROc9dMDOfcjdFWBrmNIqjacNu8d/YQsFBD5amHuR13QQ7H
	j6cPGxummKVaBe4uOgi9091IgdC7tt2j2L4XmNV4IG55uNZ5HExhd4et158Bt06KW3SRcGOHgvz
	ekHikajHY1GcLXlhT4DRD5N3/E=
X-Received: by 2002:a05:620a:649b:b0:8ea:b4d3:b19c with SMTP id af79cd13be357-8eab4d3b2d6mr2477211985a.28.1776954208170;
        Thu, 23 Apr 2026 07:23:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc6c3sm1028305785a.39.2026.04.23.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:23:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFuxi-0000000EEOw-3RUE;
	Thu, 23 Apr 2026 11:23:26 -0300
Date: Thu, 23 Apr 2026 11:23:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <20260423142326.GP3611611@ziepe.ca>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
 <aenp6FHzx9rtUQkZ@willie-the-truck>
 <aenqxasLJ8yKYqbT@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aenqxasLJ8yKYqbT@willie-the-truck>

On Thu, Apr 23, 2026 at 10:47:49AM +0100, Will Deacon wrote:
> On Thu, Apr 23, 2026 at 10:44:08AM +0100, Will Deacon wrote:
> > On Wed, Apr 22, 2026 at 01:23:51PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 22, 2026 at 06:44:31AM +0000, Evangelos Petrongonas wrote:
> > > > The motivation is live update of the hypervisor: we want to kexec into a
> > > > new kernel while keeping DMA from passthrough devices flowing, which
> > > > means the SMMU's translation state has to survive the handover. The Live
> > > > Update Orchestrator work [1] and the in-progress  "iommu: Add live
> > > > update state preservation" series [2] are building exactly this plumbing
> > > > on top of KHO; [2]'s cover letter calls out Arm SMMUv3 support as future
> > > > work, and an earlier RFC from Amazon [3] sketched the same idea for
> > > > iommufd.
> > > 
> > > It would be appropriate to keep this patch with the rest of that out
> > > of tree pile, for example in the series that enables s2 only support
> > > in smmuv3.
> > > 
> > > > For this use case, Stage 2 is materially easier to persist than Stage 1,
> > > > for structural rather than performance reasons: 
> > > 
> > > I don't think so. The driver needs to know each and every STE that
> > > will survive KHO. The ones that don't survive need to be reset to
> > > abort STEs. From that point it is trivial enough to include the CD
> > > memory in the preservation.
> > > 
> > > It would help to send a preparation series to switch the ARM STE and
> > > CD logic away from dma_alloc_coherent and use iommu-pages instead,
> > > since we only expect iommu-pages to support preservation..
> > 
> > Does iommu-pages provide a mechanism to map the memory as non-cacheable
> > if the SMMU isn't coherent? 

No, it has to use CMOs today.

It looks like all the stuff dma_alloc_coherent does to make a
non-cached mapping are pretty arch specific. I don't know if there is
a way we could make more general code get a struct page into an
uncached KVA and meet all the arch rules?

I also think dma_alloc_coherent is far to complex, with pools and
more, to support KHO.

> > I really don't want to entertain CMOs for > the queues.
> 
> Sorry, I said "queues" here but I was really referring to any of the
> current dma_alloc_coherent() allocations and it's the CDs that matter
> in this thread.

queues shouldn't change they are too performance sensitive

> The rationale being that:
> 
> 1. A cacheable mapping is going to pollute the cache unnecessarily.
> 2. Reasoning about atomicity and ordering is a lot more subtle with CMOs.

The page table suffers from all of these draw backs, and the STE/CD is
touched alot less frequently. It is kind of odd to focus on these
issues with STE/CD when page table is a much bigger problem.

STE/CD is pretty simple now, there is only one place to put the CMO
and the ordering is all handled with that shared code. We no longer
care about ordering beyond all the writes must be visible to HW before
issuing the CMDQ invalidation command - which is the same environment
as the pagetable.

> 3. It seems like a pretty invasive driver change to support live update,
>    which isn't relevant for a lot of systems.

That's sort of the whole story of live update.. Trying to keep it
small means using the abstractions that support it like iommu-pages.

IMHO live update is OK to require coherent only, so at worst it could
use iommu-pages on coherent systems and keep using the
dma_alloc_coherent() for others.

I also don't like this "lot of systems thing". I don't want these
powerful capabilities locked up in some giant CSP's proprietary
kernel.  I want all the companies in the cloud market to have access
to the same feature set. That's what open source is supposed to be
driving toward. I have several interesting use cases for this
functionality already.

It will run probably $50-100B of AI cloud servers at least, I think
that is enough justification.

Jason
