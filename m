Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB6F3BD23E
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749569; cv=none; b=rQWJIYLScxSF/PqC3ycGa7pDbcoekN21qH/T9A8Ba+aTdz0S7DtG9nHbHAvKqKFS5CJDBv5KuBhFwSiyxCP8nhIArrKESILsUJbzbOSkwPMDD3NPuf2CWHvVlm632+f8F3CGz3SRxz/A8lhrLl+xRcDaLQpXs0z5pA41I9IxKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749569; c=relaxed/simple;
	bh=VUwYbEC32ZyPKvaLYMgQTItjIPWxHmoviMx7i8ZsxGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2J3Y/Cybajxj+/uIy7fXZcSEpkX+dHb1UysTqr74CMN0XRrXQIwgqbfZRdcczEK1Vu2kEcS1T8Z7zQrlCvjP+bHaGZnQP85A6xIomV9FOUa82rT0I4GhM8yzZUjkyK/7ic+RTavCxRApxPkkDXcqKZnP24qeCIXslcNNC3JqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=yZE6o8qA; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="yZE6o8qA"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4E8581A3FD6;
	Tue, 17 Mar 2026 13:12:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773749567;
	bh=VUwYbEC32ZyPKvaLYMgQTItjIPWxHmoviMx7i8ZsxGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yZE6o8qAPSqooYV4cRtlDoJOy/x62VC/y/8gnZVFtVpdH+g2TDC3dZGfp3LDDkM2s
	 ODrXQd4W2A/38530Xmgw/3adCFuKIyJcv7j3N65r0TTdEm9LiwubLqLosH2Zk1KAtc
	 LAl9q3zYkhfnDX/Xhld4VnD84AdvxzASxV7QPs3owec9JLrLgKua85gvKrXjDdAtV/
	 rd5nvG8MRgXALw7PLq/gs28+RqTZ8UUtx3Gy0wx0YYEOolfYtEiR+M9LLeEaO0a4TP
	 rzuLe5J7XOdVHhgy0/lwvk+3Bm3eRAQNg/ZT+oQaZulTYDwsoCgbA6ap2UJuax7tSq
	 FrNkJC36coBoQ==
Date: Tue, 17 Mar 2026 13:12:46 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: tjeznach@rivosinc.com, will@kernel.org, robin.murphy@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/riscv: Skip IRQ count check when using MSI
 interrupts
Message-ID: <ydj2t6zshj4ncr7hhummpcyk75tjatgjhgw7zfmpehvyp2hqxd@n6q4o264yvka>
References: <20260130065420.16811-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130065420.16811-1-guoyaxing@bosc.ac.cn>

On Fri, Jan 30, 2026 at 02:54:20PM +0800, Yaxing Guo wrote:
> In RISC-V IOMMU platform devices that use MSI interrupts (indicated by the
> presence of 'msi-parent' in the device tree), there are no wired interrupt
> lines, so calling platform_get_irq_count() returns 0 or -ENXIO, causing the
> driver to fail during probe.
> 
> However, MSI interrupts are allocated dynamically via the MSI subsystem and
> do not appear in the device tree 'interrupts' property. Therefore, the
> driver should not require a non-zero IRQ count when 'msi-parent' is present.
> 
> This patch fixes the bug where probe fails when using MSI interrupts
>  (which do not have an 'interrupts' property in the device tree)..
> 
> Fixes: <d5f88acdd6ff> ("iommu/riscv: Add support for platform msi")
> 
> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Applied, thanks.
