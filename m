Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4127E1A1;
	Fri, 12 Jun 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275284; cv=none; b=nJ01kPRb4+yRrNyTdrx1yvns3xCSe4MafJ25FwMTxLTSGEAcId07Xga7bGxOHY5cJVX6XKUz6IcZufobUUHTvEAnz9Ae/8XqPFZL6VD+OaFyee7LxfGi1grzGwNP9DxexH7voDgj90hZF6T2laQQ9v60Jl6c68FVqsEgtwb9inc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275284; c=relaxed/simple;
	bh=n5+Cmdgm2jLPDbj7FRnkvAE18YhMQLHXALFOzU1uQTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRLJTB5h/atLtqu3eTcBbI3Lq3xCU0NOgtr22Vlo8Kic3dSRaQPSNatCQBJHySs7ObvZxvJ898PF1kEz8CK1hvskfhLSFzsRqzPmSSUVWCvpq49hm5cE7KA/8IlO+GWr1Lxhv5JHmIZTbbSmKJGhpLxVoVATAFElqfq014SB1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpZHwZpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpZHwZpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1B61F00A3A;
	Fri, 12 Jun 2026 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275283;
	bh=hmAXHxNUwUqsynWpUSTF048mwQXqT/HeYN0OxRXzNeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fpZHwZpFSlFKHdhrHL86Fm31xIkwf0H4w8rmAoLhBCpFarhQbgz1y1KdDDny+d2sW
	 susCcVgWIy78O5jtOqfUedAA7WR1FePmSBXfBRk+R1QpKN865CL2/9Pu1gxXaTRBD1
	 zVRchja2vC9CymI6zJsjihLL+LMuUvIVbPrgKZSeG3uuI/D1jJUHlOVfSsVmfMT5ua
	 nvq7iwjkRhZlpWc+G09dcxbLATjEYGRqCZsCf/wSws1+zdTthAh4aZ/aM3NkufQA/8
	 U+EsuVdjp/ODco/aPFY0X3QPqSkhWFg1aUTUQNjzMarRSr1pV2t7Syd1vl9wvU8qB4
	 FaocY33c9ejVg==
Date: Fri, 12 Jun 2026 09:41:22 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 05/11] of: reserved_mem: split
 alloc_reserved_mem_array() from fdt_scan_reserved_mem_late()
Message-ID: <20260612144122.GA974326-robh@kernel.org>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-6-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527032917.3385849-6-chenwandun1@gmail.com>

On Wed, May 27, 2026 at 11:29:11AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Prepare for storing /memreserve/ entries in the reserved_mem array.
> alloc_reserved_mem_array is skipped if the device tree lacks a
> /reserved-memory node, pointer 'reserved_mem' continues to reference
> the reserved_mem_array which lives in __initdata, storing
> /memreserve/ entries into reserved_mem_array would result in metadata
> loss, and an out-of-bounds memory access will occur if the device
> tree contains more than MAX_RESERVED_REGIONS /memreserve/ entries.
> 
> So split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late(),
> and call alloc_reserved_mem_array() whether or not there is a
> /reserved-memory node.
> 
> No functional change.
> The actual /memreserve/ population is added in a follow-up patch.
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> ---
>  drivers/of/fdt.c             | 7 +++++--
>  drivers/of/of_private.h      | 1 +
>  drivers/of/of_reserved_mem.c | 6 +-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 82f7327c59ea..83a2a474831e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1284,8 +1284,11 @@ void __init unflatten_device_tree(void)
>  {
>  	void *fdt = initial_boot_params;
>  
> -	/* Save the statically-placed regions in the reserved_mem array */
> -	fdt_scan_reserved_mem_late();
> +	/* Attempt dynamic allocation of a new reserved_mem array */
> +	if (fdt && alloc_reserved_mem_array()) {
> +		/* Save the statically-placed regions in the reserved_mem array */
> +		fdt_scan_reserved_mem_late();

Can we make this just:

alloc_reserved_mem_array();
fdt_scan_reserved_mem_late();

We already check !fdt in fdt_scan_reserved_mem_late().

Rob
