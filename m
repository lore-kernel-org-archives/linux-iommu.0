Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98341433E9C;
	Thu,  2 Jul 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006739; cv=none; b=SLq4lxrU32elXOdLA96Ed+lSi7q3wPxqvnXmXZh9vruNpA+TANBnze+tIaRN6YKOuKsrp3u0aJmsAwHOxk/Fvv1K0HgS/OdvuNrqU7z6kEWOXxaLlxKuMFkXQi7psuzRdTfdA+79oUB6tby+DBCUfzmqnFGTzD3QII0dyKQBRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006739; c=relaxed/simple;
	bh=rGwJB0RR0Cq+UaOIw7kJhMQDZOlfePHOPUM659ERK4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl7A4ywIWaUfoHMAGUrwBqJFfd/LP8By0nJbnWaR2NtQhrtteVlGLXev1rcgC8PomKZ2+spNWp/9ZBs/8mL/JEGTbP3DAi2q1Hw+3B1rnut/RmRD8be4n0Ft6744+ZH8Zq9qffp0TAKx3JoPKMYjz9dbT2WexltN5z7d1/mYrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2V0+7EL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2V0+7EL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8B61F000E9;
	Thu,  2 Jul 2026 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006738;
	bh=IwURMR915CTbYb07LaM/xpAOPf64S6EJL9O/N9i05RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2V0+7ELQGqQAd7sEVIVbP6pFh+c4EMQTIsyOJX3uWWlRR0XC5sqh9iLzgvypZEFr
	 MCYwPJQ1JqUdN2KsXxotRHYTIc7iTlkYz7s6/Lj9Y2G6seTf35mOk2bhYGAO/nKfV+
	 YvR3nedHklCOJI1If3RTDzW0/MsM5hdpnGjuEW312MB9IQBqfZc1HKNbWg6zdLXI2v
	 299Lk7QuyM4kLMu1S82jx3Qj+sjA8OvzICobeZYh7rRgZ5QiExjPFDb42ITzBskVxw
	 73GNr/N00NcYAzfCwFhtGufjo6jy6nFfS4LoEIOe7fXrYvv6GLYpo0LLyJOwxCPkwP
	 wczFHD4n0tSbw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4ED6F40068;
	Thu,  2 Jul 2026 11:38:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 11:38:56 -0400
X-ME-Sender: <xms:EIZGahWeuVA8H8V2CYPQFmEImWdYZeq8xvbAKQwvejWgfFRwpLluvg>
    <xme:EIZGatA-tBORQdhRyNScLUnydoLmE7pnrxsu8kO3fw7YTpsUpzRrMpjvU1MIj1eWz
    EiUOUvrhK9vlkxt6j1vTNz-d0o5uJVOX35gdw4v172hYU4EyCXvmSA>
X-ME-Received: <xmr:EIZGasHE3usmO8SugVccsdSV_klloDxcwHZCuFX7tiaofiPheGk2hd05SQC3mQ>
X-ME-Proxy-Cause: dmFkZTEwQOjPdUgEUF/zj9zIWxYWCudWk5ov27ppwihUDlHHjgYJjMp/Z01BHkffqoH534
    7z+IElUhPIbERwk+0qBfxHoZf3BGgwtTB3pcYXVchNztlxrHJPdAnUnpUmN+sWk9GN3WTV
    uzkPx3WdGew/i45LqmqtkNl2A6rag+vIrFay8WE6BTXqojLkpLYom0vkMglk1+QVyWPC9m
    1NBsEVF/QtyzEzdzqM++vAc0KL8CTLF6jVJldZc4IMFs0Udh7LtZQ16TSxmnhhD6s8R+6A
    QYKOWMci5v+WymLIssgTHuoP+T9Yj1E09VJ5Kw9c35KB9n8+KzKarSJYU1SwlRubSS6AeJ
    i0+hOizX0DFaJ0KRHZ9+fyprtVN/RrNttwKp31mvQd0uTleevKBpuMTxctPERMD2DbmYYH
    JTSj1TnYBOL7mbQ+WdTEgDWr7XaOisRXGNtNKaO8K4ZWFXSjPkk/2O5778HYl75kn9nA3G
    hfDNw7ScMv2NaUtzgRTl0iJt9yVfSzFcmqc4MRZi4XAOrkcbffvnBnToRrPscUri7uyLiL
    kXlQJRtmBEC3ic9QP1JKUUFFKhPIVC8wJEzeOz/5aRnMYw4HRuobZLQTwtUHtujb3QSxER
    psvw3fzFLESgucZzUaZufcYg8SZRC4UR8j3OmfBB/uMlNa+1HDN90pCwNBRA
X-ME-Proxy: <xmx:EIZGahdbLavMIi9zdVSR5X9sAS8Y48TOBqfra8H8TA6eZetoYwwCiQ>
    <xmx:EIZGah-_pLW43hCitLpck93CJjPVYjG8jK6pFGQyexW4izCKZ-z4Gg>
    <xmx:EIZGanbVywB32-aFcoh3NEkOGtT1748pXw_Yb4QvZQtWJd_2k1V4UA>
    <xmx:EIZGaieYWJINgbfGY-b0JzuTVq2jMD4Y3tjl8Uax77vNh509AVyebA>
    <xmx:EIZGalTIzlfw4_YKu9Gq7cTQ8dlFNRHnVfDeHIeV1qFn-joYP3nimcHJ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 11:38:56 -0400 (EDT)
Date: Thu, 2 Jul 2026 16:38:55 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kyle McMartin <jkkm@meta.com>, Breno Leitao <leitao@debian.org>, 
	Usama Arif <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <akaFcwcSHVGeT8PZ@thinkstation>
References: <20260702112825.781750-1-kas@kernel.org>
 <akZ-KIVJlmP4LEcQ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZ-KIVJlmP4LEcQ@google.com>

On Thu, Jul 02, 2026 at 03:05:12PM +0000, Pranjal Shrivastava wrote:
> On Thu, Jul 02, 2026 at 12:28:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> > The command, event and PRI queues are sized from the maxima the hardware
> 
> A minor note here is PRI & EVT queues are disabled for the kdump kernel
> (see arm_smmu_device_reset). We could just mention all SMMU queues are
> sized [...] in the commit message. 

Fair enough.

Here's updated commit message (I will send v3 in few days, if no new
feedback):

Subject: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel

All SMMU queues are sized from the maxima the hardware advertises in IDR1,
which can be several megabytes each, and are allocated at probe. The kdump
kernel already disables the event and PRI queues (arm_smmu_device_reset()
drops CR0_EVTQEN/CR0_PRIQEN) but still allocates them at full size. On
systems with many SMMUv3 instances that cost is paid per instance and adds
up to tens of megabytes of coherent DMA in the capture kernel.

A kdump capture kernel runs from a small crashkernel reservation and only
has to drive the few devices used to save the dump, so deep queues serve
no purpose. The queues are not on the DMA data path, so dump throughput is
unaffected; a shallower command queue only bounds how many commands may be
in flight before a sync, which does not matter for the capture kernel's
small device count and modest I/O.

Clamp every queue to a single page when is_kdump_kernel() is true. Doing
it in arm_smmu_init_one_queue() covers the command, event and PRI queues
in one place. The command queue still holds at least one batch plus a sync
(256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
command batching keeps working.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
