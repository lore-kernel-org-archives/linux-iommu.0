Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F2147C71;
	Tue, 19 Nov 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000521; cv=none; b=cUmQ1lR4ibMAZsG5/vEMfQzEFOjL96X5+o26Lr8fyiLSgiTgvchKnzVMs30uwmRAON+FttNAmGN4xQO5Uf3saYL2Q9PVDPP0CgOs2R4ZuZTazLTyao084u6YNmU4YukqGqc5Akkh5/P3dSnAzcME/NXBSlUtFhb2CHhu7C9qbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000521; c=relaxed/simple;
	bh=qtreDBVWSkdnxccPSuy9Gw9HnBBOXHY4d5ADbOivAdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUdZZkF2i5vFf596VIfm+yOY0pVpLyRrhwMyEgnstHgJN0/OggOUheilLAgrxYPq+DtFsi3Kn0KzH18snnlFblKawH9Fw/Ls2UzpeiBXBPjoHk/xnf/P0c4v3nffO6McAckveOHxXTIwWlsMLZST7Qhtd+eDEX16jSbusmoL8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3cVL8lf0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbjdjWM/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3cVL8lf0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbjdjWM/"
Date: Tue, 19 Nov 2024 08:15:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732000512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYHxGu57Vd/67w2lE6iMGTcHGQWrzFlObyNHWuPMT1k=;
	b=3cVL8lf0Gb/HWJXsnjzFswzLt0MXmK8lKTNk9B1V6rvcJzSfEH0dIAcQDVWOb/QV8D+n4N
	m2tr85+9HY+P6/ldmAvE0kL4WeImVJfRxmdgR3TlpxfwEy0BNb4Sra7pqoZ/JA0nnFSrUG
	fJQBSiIAHYNinfY3VZJUu1tnfBSiZaKAMFo2+JXjk3OFVFvv6uh3S08VU8fKEFo7SF9Pso
	jDHRSExl7S5om4W8x+H5JWcyREh0XXZi8+aT1P57YPp/LOdAaWmf2edApTYzZDXkrXycEa
	O5XK8VT1P9wqL2H5XnlvMCG4r+tnuLoYaNCEOyzfVCcUF/9ZLMfL1Om1H44dTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732000512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYHxGu57Vd/67w2lE6iMGTcHGQWrzFlObyNHWuPMT1k=;
	b=fbjdjWM/UYcRFULLa6J86gF2bgO/IHXOCZ7BVYjO3x41u7LqH+rG9jZZt7xRzKioJfCTOf
	xkNWFejviIZuH4Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] iommu/tegra241-cmdqv: do not call smp_processor_id in
 preemptible context
Message-ID: <20241119071510.-6OKEw2q@linutronix.de>
References: <ZzvZkMKhwmJESpdM@uudg.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzvZkMKhwmJESpdM@uudg.org>

On 2024-11-18 21:19:28 [-0300], Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled some of the calls to tegra241_cmdqv_get_cmdq()
> during boot will happen in preemptible context. As this function calls
> smp_processor_id(), these calls will trigger a "BUG: using smp_processor_id()
> in preemptible" backtrace if DEBUG_PREEMPT is enabled.

If this is only on PREEMPT_RT, where is the disabled preemption coming
from on !PREEMPT_RT?

> As tegra241_cmdqv_get_cmdq() only calls smp_processor_id() to use the
> CPU number as a factor to balance out traffic on cmdq usage, it is safe
> to use raw_smp_processor_id() here.
> 
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

Sebastian
