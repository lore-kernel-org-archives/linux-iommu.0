Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156324887E
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205220; cv=none; b=TdHxqHXqa2fSAVD/VtJtYBztRps6oi8wzBPS2EjSSZBHCSCKDhj56FK0mIY03iNYWrLHFsiW576hLRXZ3AoM55LvR72YjLGLnk2+QOjxNg7uy1yICU9IioBE/n/rtmGdk0Gvh6FUGqYl92rLr+s92yjSzhlHM3MTfj4J72NFeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205220; c=relaxed/simple;
	bh=PvXi2UaH2X72C7RXZdhkY44KYCqysJsWDYnH0vlxuTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH14+oznq/DQAfzrevwPgKitIdHGtbfcuQJOkd1AC6HXUJj0UfVaVQ5sygiKheCg6H3wFmzc2cfr7M6L7wXdGvrLT+YUmnbKXJOvRnbwcBbAq4k46ZLdJBM8oc+y39SBw1BNi8+BInsf6K8UxhSAirvKwwnGbwVL3g7GpPY+mZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYgn5fOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYgn5fOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15220C4CEE7;
	Thu, 18 Sep 2025 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758205220;
	bh=PvXi2UaH2X72C7RXZdhkY44KYCqysJsWDYnH0vlxuTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYgn5fOaQ8c1W1KYuQf68SSRzQ/1VdlyAO+C0dVrdc7puXNL4ufBYH/J8aZGoaAaC
	 SKduReWduVX9jkBdMoHafghoLKwjCDukNDMa7IKYlzZMFElG2rhEwVuIGnTHDEiRl9
	 j0XRTEAZl1pBTYIV7050Xk9YcSrUj6XVjlvbu+EWTiDXXjQPnv3y8wiATaZMf4dFF2
	 xJUOMeaH6GfN/fLL5/qPJDiIXRs6ZVTyuY43IMwFstUSpuJ9aY7/Erlx3PmdzIb5zh
	 AT7ocdTWayweor1lWTGLSvxaXAW6HHtxGRSgXBzOqVtt6Am8f0CFPrrQFop1aDh5ea
	 uwSmLPbqc+ogw==
Date: Thu, 18 Sep 2025 15:20:15 +0100
From: Will Deacon <will@kernel.org>
To: =?utf-8?B?6YOt5Lqa5pif?= <guoyaxing@bosc.ac.cn>
Cc: linux-riscv <linux-riscv@lists.infradead.org>,
	iommu <iommu@lists.linux.dev>, tjeznach <tjeznach@rivosinc.com>,
	joro <joro@8bytes.org>, "robin.murphy" <robin.murphy@arm.com>,
	"paul.walmsley" <paul.walmsley@sifive.com>,
	palmer <palmer@dabbelt.com>, aou <aou@eecs.berkeley.edu>,
	alex <alex@ghiti.fr>, anxu <anxu@bosc.ac.cn>,
	wangran <wangran@bosc.ac.cn>
Subject: Re: [PATCH v1 1/3] iommu/riscv: Add iommu perf driver
Message-ID: <aMwVHrhKBZWstPat@willie-the-truck>
References: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>
 <aMfsj1U7NY2m68T4@willie-the-truck>
 <202509161827232434929@bosc.ac.cn>
 <aMqlR4vDOgrFuCUj@willie-the-truck>
 <48b8385a-ad44-4098-a647-109a3cfe3bbb@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48b8385a-ad44-4098-a647-109a3cfe3bbb@bosc.ac.cn>

On Thu, Sep 18, 2025 at 11:20:55AM +0800, 郭亚星 wrote:
> [Sorry, I tried switching a new email client and made some settings...]
> 
> On 9/17/2025 8:10 PM, Will Deacon wrote:
> > [nit: your email client has made a big mess of the thread here]
> > 
> > On Tue, Sep 16, 2025 at 06:27:23PM +0800, guoyaxing@bosc.ac.cn wrote:
> > > > PMU drivers are better placed under drivers/perf/
> > > 
> > > I did a quick reading of SMMU pmu driver in drivers/perf/.  However, If
> > > the RISC-V IOMMU PMU driver is placed under drivers/perf/ as the SMMU did,
> > > it would cause an overlap in the iomem resource region between the two
> > > devices(iommu & iommu pmu), because it needs to share interrupt-related
> > > registers (such as the IPSR register) with the main IOMMU driver.
> > 
> > Is that not something you can resolve with IRQF_SHARED?
> > 
> 
> Actually IOMMU perf is using stand-along interrupt, so might not need
> IRQF_SHARED with IOMMU driver.

Hrm. Two separate interrupts that share the same interrupt-handling
registers is an "interesting" design for a piece of hardware :/

> What I mean is the IOMMU and IOMMU perf share the same registers, such as
> IPSR. This could result in overlap on this iomem regions between them, which
> is highly undesirable.
> 
> For now, two ideas come to my mind:
> 1. Integrate IOMMU perf functionality into IOMMU driver, just as previous
> version patch.
> 
> 2. Let IOMMU driver export external api for IOMMU perf
> (to obtain virtual address of IPSR register) for perf related operations.
> 
> So what's your suggestion?

I wonder if you could create the PMU device as a child of the IOMMU?

I'm sure Robin had fun dealing with shared MMIO regions before, but I
can't remember the details (was it the CMN PMU driver?)

Will
