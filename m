Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122045;
	b=eNyDHEc18rWc55RqOsbR1yTBmdS+d8s2EUItLKhh4CbSGIKOENN2808WBJrgcFmVxJCv
	 eJ16qwb7OMtnqSwWm7cZvzHHoag0lXw73UZKrpx+JKHVylJdHgtsSpUo+gZk60SbYkrkZ
	 ztFDPYYRJQKkII4dKbUsrdzBiQaYpzlKwFJjT5/Gzfl9eezEn0t+rGenwPzm0lDDb5EXB
	 /CHIEZaY+92OEkd8f94+T6Hmz5iuwNyp4gwFSgnCKIQRGhq85cVbqbfdj2+rk0h7aqcCp
	 wjRiTKjnq2+xLh0P0P6NX21cxbplSJBH8sQzmLdFCz9GpWrB9C8+0V0+qPRCqXKlhbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122045;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jRzgudTO1qkSGuzOPfaR+Ba0Lwqyafb02x6YrJau0gQ=;
	b=O88lby62fcb/0aEMgfr5yD95UJpdBGDzqwRR88o6Xn/OeQcYToxNvnLEdvT75HYx+ySX
	 osBg/vAXQ0X4elAQilDd32Lugf/rTLVgqcKd8Bh2sprW7iKBgUVa2TAjKICDaIRtEauNM
	 o3Duhfhy/8kuvZXp1gH2hViSWMXWM6y8awbQHzKtCVjuyafxTCUlNvm/B3kw1E1gyHV8h
	 vdTciy/D21Qq0wXqsEjypJ4W/tJ5Swfz4wsDwCe80c9TYs9gx9L2qmuMQYlR8dA7dsj7P
	 e2i5/jLV3k1An8HNgFHTNX6DkCOrYhvGaI2quhTn6lP5CEoSw5kjpbX5uOooPEFEZFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orn6ElUm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF6606A324;
	Thu, 19 Nov 2026 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orn6ElUm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A7F1F000C6;
	Thu, 19 Nov 2026 21:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122045;
	bh=jRzgudTO1qkSGuzOPfaR+Ba0Lwqyafb02x6YrJau0gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=orn6ElUmwk+wOC3TWMCK1D63fKBmQ66tvx/fNy/R1n50ZqHw1OpgnTw5sSOZkyaJG
	 f9qQu/IDo5aUE4eEs5j0qIIiK9CO727Ltm4ttNMYWC7BR8WTmLDhNjl6EjjRG7gADl
	 MMq9ZKC5M6XMbPTNjxCelZpzuwUG1uW0mRbrRpHm5GgDNYl4s/J+YfRjMRKk7uN1/o
	 Af9WF86DUIRObuR/qpoNARO65+rd318lrMb1OP5tbT25DR1rYP+FxCALKxN2tXCkHp
	 ZX0eaBUzRlkedL6sFRSqNvtScDw+qMyXF3wdCGDCOgep6jJ6Cyi9FQPJCCGeoOP6CD
	 Djtx2LjVYD2xw==
Date: Thu, 19 Nov 2026 15:00:43 -0600
From: Rob Herring <robh@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: saravanak@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	baoquan.he@linux.dev, pasha.tatashin@soleen.com,
	pratyush@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, kexec@lists.infradead.org
Subject: Re: [PATCH 2/4] of: reserved_mem: keep the reservation when
 node_init returns -EBUSY
Message-ID: <20261119210043.GA532410-robh@kernel.org>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
 <20261103162429.2053989-3-radhey.shyam.pandey@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103162429.2053989-3-radhey.shyam.pandey@amd.com>

On Tue, Nov 03, 2026 at 09:54:27PM +0530, Radhey Shyam Pandey wrote:
> fdt_init_reserved_mem_node() treats any error from a region's init function
> as "this node is unusable" and calls memblock_phys_free() on the whole
> range, although the range was reserved earlier during the FDT scan by code
> unrelated to that init function. Give -EBUSY the meaning "cannot be used as
> described, but must stay reserved" and skip the release for it. Nothing
> returns -EBUSY from node_init today. The next patch does, to refuse a CMA
> pool overlapping the kernel image, which without this would free
> [_text, _end) rather than protect it.
> 
> Suggested-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes since RFC:
> - New patch
> ---
>  drivers/of/of_reserved_mem.c    | 14 ++++++++++++++
>  include/linux/of_reserved_mem.h |  5 +++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 0fd1683cba01..d67a2b3a4d44 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -621,6 +621,20 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
>  
>  	err = __reserved_mem_init_node(rmem, node);
>  	if (err != 0 && err != -ENODEV) {
> +		/*
> +		 * The region was reserved before its init function ran, so it
> +		 * is not ours to release. -EBUSY says the init function is
> +		 * declining it for a reason that outlives this node; freeing
> +		 * it would hand the range to the page allocator even though
> +		 * something else still owns it.
> +		 */
> +		if (err == -EBUSY) {
> +			pr_info("node %s init failed, keeping reservation\n",
> +				rmem->name);
> +			rmem->name = NULL;
> +			return;
> +		}

I would move this out of the outer 'if' and and make the outer if an 
'else if'.

Rob
