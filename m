Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24B2E6CB3;
	Tue, 28 Jul 2026 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233777; cv=none; b=UeZN7WctcCRVjbqk+CNdM6q7s09AMlU5Zgm23wu5oH0YOHXG3KTPawVzql0ine/JGYJNozIV3Gcd4YN6gwpqbrHkEUsiRknGWLq3eUfYs7/Ab0KovkePFiBWHN7GRRcZBQOPx0/co8kxK0UJ0KJBtdPjGOJmvw88dWSEjEMjJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233777; c=relaxed/simple;
	bh=ZiWPpOrsiyBU8yxa/Bzzrsdpf11XavNNDZP2nvLSQG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK+1U4j1zBUu6UpNX83oG00uu7b6fiWrLr6ChEKb75+naA4MFl3XoocZXhGIaDPslX3HCNDQ8taPao7UjrrDr6+BzjH4tmjENQd+PXN0VwhS9OPws1cpROPJwhjgUjpy+tJUhyAyafIAy/0dXoriRe3dnTA876A0eiaVXpEGFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkH3YMcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkH3YMcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376451F00A3A;
	Tue, 28 Jul 2026 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785233776;
	bh=daMRxS0Kh2ADzZ81QAFwLgz+aTvbJ+pwPAdc3QnTWcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fkH3YMcMn01l47wwaEb8VD+GAjV+dJyhGyQNvwBvPAjHeNlrNSfyBNREXcgCR+Byi
	 CqjbjkTpXMVJQfL+FG75ilrQLjZRbjWztjlpQ8uDmcKPkaXaQ10lCnQ6NoIS3O/VHZ
	 7vObQ5/SbTGlecuqInz9vM+DrYy4VGejABU+KvZJWpufN72jsPy/hZeoU4u25NM8xq
	 nC4UKnNi1e6mpy2r8/X3+hInjvydsZDP0gY2Hl2OqDiBfvDS1kxP9Wcs558nARf9xO
	 unUFh2X5huq9oth1yBKLho9irUqBPhL8FAOcVYI0l6FflOr6LA9medmpBr3uw/28uB
	 0celxi54LVx+Q==
Date: Tue, 28 Jul 2026 11:16:10 +0100
From: Will Deacon <will@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <amiBagGKn-Aym1DK@willie-the-truck>
References: <20260706084708.8072-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706084708.8072-1-kas@kernel.org>

On Mon, Jul 06, 2026 at 09:47:08AM +0100, Kiryl Shutsemau (Meta) wrote:
> All SMMU queues are sized from the maxima the hardware advertises in IDR1,
> which can be several megabytes each, and are allocated at probe. The kdump
> kernel already disables the event and PRI queues (arm_smmu_device_reset()
> drops CR0_EVTQEN/CR0_PRIQEN) but still allocates them at full size. On
> systems with many SMMUv3 instances that cost is paid per instance and adds
> up to tens of megabytes of coherent DMA in the capture kernel.
> 
> A kdump capture kernel runs from a small crashkernel reservation and only
> has to drive the few devices used to save the dump, so deep queues serve
> no purpose. The queues are not on the DMA data path, so dump throughput is
> unaffected; a shallower command queue only bounds how many commands may be
> in flight before a sync, which does not matter for the capture kernel's
> small device count and modest I/O.
> 
> Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> in one place. The command queue still holds at least one batch plus a sync
> (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> command batching keeps working.

Wouldn't we be better of not allocating unused queues in the first place?
That's what this patch does:

https://lore.kernel.org/r/0b035c53cb401acde8244b805d4b6a0312b83708.1782799827.git.nicolinc@nvidia.com

so help reviewing that series would be much appreciated!

If you want to reduce the cmdq size, I'd prefer a cmdline option rather
than special-casing kdump (as I've had other folks ask about configuring
the cmdq size for other reasons).

Will
