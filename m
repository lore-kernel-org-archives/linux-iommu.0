Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8111A6811
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246801; cv=none; b=rGFP8PU5Q6kgcHRDCTVPW786CC6nB/7g6/gKams5yqTAS5nJL2au+2SNEa4xhRS0EzBpeTSVo+iSmgSAcid8e1Pb0LzmR4GrwzZl7TfX+dp5qim9KwFpE/8c+weoRCJJlC8M2KzmjjDbUaXpAN0CSILSlLwU00NTTzzNzy73Jfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246801; c=relaxed/simple;
	bh=imuE4PNPFHf5oCEer2I166z57PQH+MP2tjkHlVlz5F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9IrG4YMF1K9cs0XRmbGm+r879A1CoyC0/PIn7rNKWFHDA0qHxmfH7uWaqLUmampTGePDFIBgS+pfv1zPdXGNA/XttlFxOyuzSL2gDWTT/Jomm+x6qJ1jdA1QoHyXOOdyfgfidynvLEftuuTwjhC0DrA+loUO/eMEW5cwYj+2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWm0oifX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWm0oifX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C0D1F00A3D;
	Tue, 28 Jul 2026 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785246800;
	bh=zi06wgX4NrhXeDcGXM6A7FKpeV6U5LtjTPi0mPx8QKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GWm0oifXI4fDUr41a9e8ilrfZhHR1uCtAXzugHSjYwDy54+poa9Bn2N4E5Y5sdKSr
	 fG2QhbIFc+8GypB1fsK/h2cZ0aGZ1iBCJqzKtG1k/IYanW8C1Cm4+yQdyWoacQyEWY
	 niODpy/x9SVL8GDM6/LHrAbfpculnvFEiJcSHMJZ/AHaD6BeMiCYD96VzWw7M6218/
	 Sf63MDYkWVndFqJDjuW1Fd3ydwQ2dHDNEZE4g9vw+ppPMzFpRzWn/O3+t8DoD3rsDu
	 sDhf1ITL6G2er8i8aDCg3dIiIIuhhWYKIGaDaPlX9lZzORyefZLCV96XAurQb2BItU
	 b3agORiChJIAw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 962ACF40068;
	Tue, 28 Jul 2026 09:53:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 09:53:18 -0400
X-ME-Sender: <xms:TrRoarpIjNHLMfmY1_X495x0wNuALIv5d60wRaVKrU4lEJsnxymNZQ>
    <xme:TrRoahEl05i9DzyIjFj-afCejCTgOrcXQMTkaMzic1pthC-7JQ5w3LE6mKLOLEyKN
    ZlAKn8r3_8dGrQfRKkb_DgTQVKFakMRR3Oz_bwBFy8Z0TJEJWLXTOA>
X-ME-Received: <xmr:TrRoam400f5udQYFnh12wcUeS4mEwo6MxrHXoiOXzKEaYETbXjDT1_ps7iDk1A>
X-ME-Proxy-Cause: dmFkZTEOfimKXa+dIMDT+2FfHsPQI6Hsl535JXxG6sk7f2fJm2SJtIxsM//yga5mXBviZQ
    OpIM3Ob8Z1T9YovhOYdmEyTG9hU5JbUF9VhmYSp+SzN94pd10sq+Fl/eixu3DAfZUPMqgM
    TlTxajDxvciP2dLaY40WGPj9KGntkiuGVE5uAJ4DV29XaSDAibiOn8IrlsqnpcJ8RY8Kgt
    pmDU27VCsOw2EZf+V9EQiHbZpkYRW57DVGD/JVDlSOmL4OLLjSNxS/EYtTeMDwGjWr5Hk/
    8cMP3kv0PurgNMbDBC/XzNBCIplLL6ipd9DeUnn3nQmK2ptzCTgCEBkzJY8lZGLAOa07ax
    3BTY75884uzGxObLU2KoVBPMq9frh2kaSKedFtqY3Rt0fpUTr9+jvLHZjqq6kdFrIcic29
    1xVRDTvfKoZGsJn6AQXUmxopbiA7HZLQCG5eOr+0tzPVP1ZWfJ618QG85O1v5mrBk2E9pj
    nYBejrEAncxlEEioiTBv8IgBia+5NEmFu5a46aTua7VmIA7TO/mGikY2myZGjG3ds2hiHh
    QzcBb8yFzS7azZW4MW5gQWtdWRW/X7glcJf6gra7Xi7Mdy6jFxPa6lVlsiHxH48kt4jPDQ
    Y1cLDHtoiddoXrBRMjY2Hxb046GanbYpqIJx4a6RQaF2uvwXftYv+PBt7MpQ
X-ME-Proxy: <xmx:TrRoasBVOIbdYHx_T4QlJs70I-UWtWVH2Jvbt4jf8smo2pu10S5MMw>
    <xmx:TrRoahRPUXhdbWZDcqtUY8o08oPobuaKP_aJrV5O7Qr_r-Pa8RaEow>
    <xmx:TrRoasc-dxkBby-UK6k9kpiC62efbwHYaSxRm7spbc8AqHdBdl0Azg>
    <xmx:TrRoaqQ1n2iR0Oe0KykbzzINdDlfRaCI9mIye9E1egqB9gNPaAVkDQ>
    <xmx:TrRoao0kmppHgEgYo1rVPItvKSoG4RcI6cLTb4uQ6Zb2WMgP4a9jh-PZ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 09:53:18 -0400 (EDT)
Date: Tue, 28 Jul 2026 14:53:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, 
	Usama Arif <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <amiz6GQZ-XGlH706@thinkstation>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amiBagGKn-Aym1DK@willie-the-truck>

On Tue, Jul 28, 2026 at 11:16:10AM +0100, Will Deacon wrote:
> On Mon, Jul 06, 2026 at 09:47:08AM +0100, Kiryl Shutsemau (Meta) wrote:
> > All SMMU queues are sized from the maxima the hardware advertises in IDR1,
> > which can be several megabytes each, and are allocated at probe. The kdump
> > kernel already disables the event and PRI queues (arm_smmu_device_reset()
> > drops CR0_EVTQEN/CR0_PRIQEN) but still allocates them at full size. On
> > systems with many SMMUv3 instances that cost is paid per instance and adds
> > up to tens of megabytes of coherent DMA in the capture kernel.
> > 
> > A kdump capture kernel runs from a small crashkernel reservation and only
> > has to drive the few devices used to save the dump, so deep queues serve
> > no purpose. The queues are not on the DMA data path, so dump throughput is
> > unaffected; a shallower command queue only bounds how many commands may be
> > in flight before a sync, which does not matter for the capture kernel's
> > small device count and modest I/O.
> > 
> > Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> > it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> > in one place. The command queue still holds at least one batch plus a sync
> > (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> > command batching keeps working.
> 
> Wouldn't we be better of not allocating unused queues in the first place?
> That's what this patch does:
> 
> https://lore.kernel.org/r/0b035c53cb401acde8244b805d4b6a0312b83708.1782799827.git.nicolinc@nvidia.com

Maybe I'm reading it wrong, but I couldn't find the allocation change in
there. That patch seems to only touch arm_smmu_device_reset() -- skipping
the EVTQ/PRIQ base/prod/cons writes and the CR0_EVTQEN/CR0_PRIQEN enables
instead of the current enable-then-mask-out.

I went through the rest of the series too and didn't see
arm_smmu_init_queues() or arm_smmu_init_one_queue() touched anywhere, so
as far as I can tell the kdump kernel still allocates full-size
evtq/priq, and the cmdq is not affected either.

Is the allocation side handled somewhere else that I've missed?

> so help reviewing that series would be much appreciated!
> 
> If you want to reduce the cmdq size, I'd prefer a cmdline option rather
> than special-casing kdump (as I've had other folks ask about configuring
> the cmdq size for other reasons).

Fair enough for the cmdq. I'm less sure what to do about evtq/priq: they
get disabled in the kdump kernel anyway, so I don't know what a size knob
would mean for them, other than every kdump config having to pass it to
get back the memory.

Would skipping their allocation when is_kdump_kernel() be acceptable on
its own, or would you rather see it done differently?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
