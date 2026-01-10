Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9372C11D3
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768038900; cv=none; b=UXMmVHki1VSqNFOZjjFhPihsEAckFReYACh+z8bht8AdlhVtdHf4nUHZeBVWZV11ippAfHU05tiALUyHK9oOoDY2rmTx9sV2ymI/USo+nMMnYTElOQfRkUZdwNzHmpcztigFl/iTzhdsgoO01SwERcBooQGLwg91Ix4sbju6DsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768038900; c=relaxed/simple;
	bh=NyVKM7MzG2B1EFbs5BO6COfh8OyBtU1fT+f6Oat0vTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5/XgjY8NoY/u2+i5wJPAV/fy4gmkUs/vlcEJFv3qP76FWwacMlT71dkGmcDgBOfeV55qgQepqBpfFsbjs3NuCNSPwX4bWU9EK9zuenPxjzqWrFZSO9bDlDI0LKoM2wIblSnWTFH3ae0+ys8/I4uhNGMGUTSLsx1eLZbaYXjg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kXr7LkBU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kXr7LkBU"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 445615F02F;
	Sat, 10 Jan 2026 10:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768038898;
	bh=NyVKM7MzG2B1EFbs5BO6COfh8OyBtU1fT+f6Oat0vTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXr7LkBUx5Y/s0k5Mw7ov8H88F8LWh+watKg0t4dMVrpSVghx/PLQ8fcRIRHXAqxU
	 hRdGf6EQixG44XSgn0AnoL2UsSmiqbYCQOENlx59bpWKo2ivdJ3ts1pzmHPRQuqEhY
	 Qat4Cau4YFSOb6Q0QkHglF3Ze8L98uYHyPGHBZ3pNDgthsBvaZV6jElqeE0va77aim
	 Cd8gHcuoW35xVd/HDSFlO3V3eaXnx+++znp5w3vfX/CkwBRJi0AwbNVi+5h2gexTWr
	 JdVL6DdF5RDtZm7PBSMTMmGiiAObySwsLOdzhEpFQ+XYMeURIVseqj7ZkMcm2f2xwf
	 xlsWD9RiAwRpQ==
Date: Sat, 10 Jan 2026 10:54:57 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com, 
	suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: move wait_on_sem() out of spinlock
Message-ID: <is5wyo3x5ynjjjhqbpbzdbqcqvht45xrdfmy64osi3a7rzkx4g@bpuj5n32a54p>
References: <60d2601b17c7008834fe393e75990371cdac74b5.1764591214.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d2601b17c7008834fe393e75990371cdac74b5.1764591214.git.Ankit.Soni@amd.com>

On Mon, Dec 01, 2025 at 02:39:40PM +0000, Ankit Soni wrote:
> With iommu.strict=1, the existing completion wait path can cause soft
> lockups under stressed environment, as wait_on_sem() busy-waits under the
> spinlock with interrupts disabled.
> 
> Move the completion wait in iommu_completion_wait() out of the spinlock.
> wait_on_sem() only polls the hardware-updated cmd_sem and does not require
> iommu->lock, so holding the lock during the busy wait unnecessarily
> increases contention and extends the time with interrupts disabled.
> 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Applied, thanks.
