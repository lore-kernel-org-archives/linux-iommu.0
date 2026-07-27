Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0F30F531;
	Mon, 27 Jul 2026 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144616; cv=none; b=Oan5Gg3+DQ1a/WMMwpVrhSbtVnunhk5dzFgkQDr7OT6DydEgu0KirZylty+HwLFBoiKHzI8tRC/v/yvjlLxwc5dCfS6GcBcLDV+KS+/BZSFK6b9QqSNzGLZSAJyS0tbxWscepIUHqppnaokN6lZB0UbRvIMPxZqk6TZV29td4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144616; c=relaxed/simple;
	bh=pWsaSR7PTOY1xoTnaJOSTw1idQ3fJm812D7AGDKWejE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpTPx0UUOuftGvmxYbwPNcQPTgtN5O2TsyYq3DJzSIkM27cG0O8eX+jTEdhlo2UfpKowoIYhraktmw/KWoMtqLvq5bCAsT62A0A6KpDxvg6QIQVL3Ox05iRcvKplhRAAWv4PNjbZPX5Yv/HinLhhGsRp1Zs9fsjq9sl/BbO1Bq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdhuBLkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdhuBLkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733581F000E9;
	Mon, 27 Jul 2026 09:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785144614;
	bh=PdGrPMBWB2LDmXiMYyHKbIkWVWxI4vvKCqzpo1Iv3yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EdhuBLkm12U0d92Il/G3+5x/ZajmJ8DOiOO8RjRG2Nxfh23LkYInSAPTYe64YQvvo
	 Guq4C8R5g5CwHLSERW8Vp/qR4+rbG+IkeRaNYq0EPrThQb04dnDZNGhRePj1bSxCL2
	 8+ErJ8pFBniY5nw7DsR6oJVh5DG9CpjbLnjAmtgTNDccU0oV0NpKPRnhOGegMBkUXe
	 45+6bdynidYy6EpxWFIQvOe+MgxwQOsd43yJ8RH5Wd6WYkDYfY8CWaR8aagXcpL1hI
	 j7VfsLWZeLM7S7iypho7SRI1NDnNJ/J24nPnLahZBid4ZZ0znsSyd3PeC1C8dNRCxO
	 o0O/jmGvYE0Jw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id AEBB0F40066;
	Mon, 27 Jul 2026 05:30:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jul 2026 05:30:13 -0400
X-ME-Sender: <xms:JSVnaoI7xWg9sf3DzyTsAS_O8dJXfuAs1HXKzKbM2FEt7hmk3iGCKg>
    <xme:JSVnajk0kmat5QhCYyc2AFH8ZxvRQ_w2Wdhug49PPNdC9-2sHdwOY1rqOVpEimazj
    ztNE4SrHfkzaSNKyPPhrcHLJXYtwxmGqpYTLdGXjJCf6pBAR1vSmPs>
X-ME-Received: <xmr:JSVnanaYqOloQ-NLHOGxj2FLbFMAGd0boxoWsbVPTFCcrx9tPAlUV7pCTPaaVA>
X-ME-Proxy-Cause: dmFkZTEp59gp+mIw67XKk3VpC7CscDwzAHUZZc6/vn9e4uj9zL3YXG77/COa2kzCp966FG
    vFTSPHv4n8gUZrmEJaptzPrYYNVDiUOxZsevH3QK1SGY4t2HOpALnBl4jW8+UxBDusXjJF
    ByJOZ2EOqoHM/RjvP++FkTMSVHoNDkZ6ktSGSsqG69ESfEMv9ZAIciQM4Isui+2dRocaA5
    PE02S3q90iNncVG17rbmg7AE843URlwRNvI/Wla4wpmmgOp/Tzyl7nwuCHFcPvQkiqlO/N
    oJ2YSlsXRLmNV7RtUcVLbgSED7Z9tY8lQjSF/c9WOmfaJyqO+9efy907tHub3jpGgbETDK
    n3aTlDcALhC2HAsJP26l9RzjVesIvFkDNxMDuwVhS4tKDqyTRwqgtISV1Y/zzz3lbItq4e
    5kkrN9Pm1egfO7AQ/jBvq78YtoyxJOXjabvuRhlqCBlR0lmAxsj9e0BpaGx+UjBjFIwIqO
    4Eu1xJuMDiUzJZ97opcGNDrTdw7sb89ssaxiAQls8RfKNzAuJKofZRcDF2J4MDppVxfxUx
    J16siyx8xKhpi7B5xcOk13KcBYZFAZ2MB1Luao+fJjIpinvMEgc7Q+hKonZNHhJy53rW+C
    Uo16GkegGPghvjxPYyA77sXcwaXI65OA0BZkfR9qpJJYZGIQFhOHiyGjtemA
X-ME-Proxy: <xmx:JSVnaigdLS9Qr7twyrJfCiGOIQ0Tkl6WHxM38sY-nBC7SOtd11azNQ>
    <xmx:JSVnalymkVfHLJ6rSpXEDVytfAzg0MKuEe9Bg5D9tMuwykadLXKX9g>
    <xmx:JSVnam8Yp9xsBSvre_czzViFPHJXVw7Gk6yb1DOIcw7Fc-vzAjldMw>
    <xmx:JSVnaizSa9j9fH7_28tW4H4VRysxAkCOCH8hAVjUoq2SGVI3BqGaig>
    <xmx:JSVnanX6ukYFh3q7-mukFSehVWm1ryT-mcqhplTplVm8pwk7VHkmvg91>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 05:30:13 -0400 (EDT)
Date: Mon, 27 Jul 2026 10:30:12 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>, 
	Usama Arif <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <amckPkwKmZlqBQR6@thinkstation>
References: <20260706084708.8072-1-kas@kernel.org>
 <aldy9NMY1dRgJii7@thinkstation>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aldy9NMY1dRgJii7@thinkstation>

On Wed, Jul 15, 2026 at 12:46:13PM +0100, Kiryl Shutsemau wrote:
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
> > 
> > Suggested-by: Kyle McMartin <jkkm@meta.com>
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Reviewed-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Gentle ping?

Hey folks,

Can we get the patch applied?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
