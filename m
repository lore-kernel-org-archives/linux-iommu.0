Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570143C660D
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752201; cv=none; b=Dowi75eh1/kHY5mVKjbpk+QYZxCK4gmD6BUbfbhieoHZnZCNkyR+zFubyJ1+O883nygisPwK/c5O5Bf8ngJmObfJZXcz4ZfGVyzFMQKbFY1phJJWuU29WJf0hRfgEFfbyA9NeFVpNWc0ujt4sNrVrSOVM1IIuKkaUfSg0MjirVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752201; c=relaxed/simple;
	bh=xgddnoxO/L3X9VmRAud6XcT+rSY9ASQ4eV1SCfp6rws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg5XZYJjMt6mdLXfC9xwivwHiuJumfaP2LEBHCvVoy3qfo19TFE2eugjcpGP380eJbhu7mCeMmDjyLLMOk8CGGw4PDfMKFkgV1MPwIcLNO/w7F4NdvWaK+b8uRxq+qGrMPeUCGvzTPRVY/CeB1GH+ZR0Qs0SKnO6j5DcFXATEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=YI2QUJbT; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="YI2QUJbT"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 11F7A1A52C5;
	Tue, 17 Mar 2026 13:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773752199;
	bh=xgddnoxO/L3X9VmRAud6XcT+rSY9ASQ4eV1SCfp6rws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YI2QUJbT/HfiPWFIB5L+EU/MQHMyiNqCvDd7OtjkB+kr3hdL99uPxeEWMm7KKpbR3
	 R8VIjmt1McriTuzUyuErBmJrAGW3zEfEAIGKLhX41pl9UhWm/7w3j2klDmIoj37f0t
	 0SutCjlf8vGWw5X7c1dXElub5IlyxeaMomsVCGvxU4PMkajkuPYoOGoiqYcLupsaFF
	 G9GWc0xhCc98iRad5zUCWf68LMJ8hgqnJM6ZlU4Mm+7Q8+d4RJLtOK+YbRjYHb5CMy
	 PiO2etV3mpI55F1WQemf2BP/7Z+wPbrXoVNsTpKHLGgeTkJH0o5aZpN8bQmRimTdJz
	 hgmNJgiGpZhxA==
Date: Tue, 17 Mar 2026 13:56:37 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: fangyu.yu@linux.alibaba.com
Cc: tjeznach@rivosinc.com, will@kernel.org, robin.murphy@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	andrew.jones@oss.qualcomm.com, baolu.lu@linux.intel.com, zong.li@sifive.com, guoren@kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] iommu/riscv: Stop polling when CQCSR reports an error
Message-ID: <cv3mzx2zvwyqy6v7vxouzzdjvf44thcfdm5u45g2zyb566tcf7@fx3n5m6w4ibs>
References: <20260227112640.20197-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227112640.20197-1-fangyu.yu@linux.alibaba.com>

On Fri, Feb 27, 2026 at 07:26:40PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> The cmdq wait loop busy-polls the consumer index until it advances
> or the software timeout expires. If the IOMMU has already signaled
> a command queue failure in CQCSR, continuing to poll for progress is
> pointless.
> 
> Make riscv_iommu_queue_wait() also terminate the poll when any of these
> CQCSR error bits are observed.
> 
> This helps the caller return earlier in failure cases and avoids
> spinning until the full timeout interval when the hardware has already
> reported an error. On single-core systems in particular, the current
> busy-wait can delay servicing the command-timeout interrupt until the
> software timeout expires (90s by default).
> 
> Fixes: 856c0cfe5c5f ("iommu/riscv: Command and fault queue support")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
