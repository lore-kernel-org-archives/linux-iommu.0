Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515210A26
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810623; cv=none; b=Esc0Pz+oXuclC+3X6idUJ+xD4DNxiZ9Q1cV7rV1n9wrimjXXs7KcDB3VVn97wIBo9CZJQNtnedrc1XCQMaCG09FLdH5XaPfhzIn77OCYg44TJDq6JnXfxf/N8mxiKetS8fLA+RvAIgn/WxIEE8D1jjR/C6uYqxFE1KkV2ABxLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810623; c=relaxed/simple;
	bh=5KLQ5djW6HtWwiT2B9Pb+poWNF+1A6VF1v+gQJIH0bM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgPAzwlg4FtXfHA9tj8MfFRRwkaROMHWaVgNLCbjD0vhLRkzr6gF2awp6rON8bKbgk1HKfnEjKG7UY/839gRxoCMu9EUEq7HqZyfzr/7zNIGAY/u1+jFV7t2uxqIxoerejNn9iksvHzvSued1NbxvLbleNtKO4B5Wkks0YhVPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=DV+Xe+9J; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="DV+Xe+9J"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 060441BA1D9;
	Sat,  4 May 2024 10:16:52 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1714810612; bh=HIQTiZruIzF8K/sYeFSJkzkfpUCRGh0NaHzc0R77M4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DV+Xe+9JkNy6B/5oNxKh9ZDZSsY1jtZZ6kQwSp+2wLf2OuF0HFTOw0w6z1Tv3OR80
	 TQwBP6j/fwqAkMrg3Lj8JimDRpkYlqN2czE6jNikZSWzP1pyAPH+ua+LXisk7VSxSw
	 mbQ+hP4l7EITxV7zt8BWkJ/Yz66kC/tONhSyjc+Lse3YhEDmbpvu04Q5dlEPVtrb3v
	 NJ5EeEnAHeizDOUwfAMZp2LN1QK5HTOTpNM9C7FFh+hUroQgFYLU9Y6zT5Z2EHhkBi
	 eJxhMDU6HNDsFn6vXteIH4jxFShl3PTMyYf4LP46W2ZTs33hXWxssYzDlFlef0eaHF
	 0d+1+JigElsDA==
Date: Sat, 4 May 2024 10:16:51 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, hch@infradead.org, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, akpm@linux-foundation.org, isaacmanjarres@google.com,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH] swiotlb: iommu/dma: Clarify swiotlb options apply only
 to dma-direct
Message-ID: <20240504101651.7de5106f@meshulam.tesarici.cz>
In-Reply-To: <20240503183527.1548119-1-tjmercier@google.com>
References: <20240503183527.1548119-1-tjmercier@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 May 2024 18:35:26 +0000
"T.J. Mercier" <tjmercier@google.com> wrote:

> IOMMU implementations now sometimes bounce memory through SWIOTLB to
> achieve cacheline alignment [1], or prevent DMA attacks by untrusted
> devices [2]. These uses of SWIOTLB differ conceptually from historical
> use which was a solution to the problem of device addressing
> limitations that prevent DMA to some portion of system memory
> (typically beyond 4 GiB). IOMMUs also solve the problem of device
> addressing limitations and therefore eliminate the need for SWIOTLB for
> that purpose. However as mentioned, IOMMUs can use SWIOTLB for other
> purposes.
> 
> The swiotlb kernel command line parameter does not impact IOMMU related
> use of SWIOTLB, and that is intentional. IOMMUs cannot be forced to use
> SWIOTLB for all buffers. Update the documentation for the swiotlb
> parameter to clarify that SWIOTLB use can only be forced in scenarios
> where an IOMMU is not involved.
> 
> [1] https://lore.kernel.org/all/20230612153201.554742-16-catalin.marinas@arm.com
> [2] https://lore.kernel.org/all/20190906061452.30791-1-baolu.lu@linux.intel.com/
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  Documentation/arch/x86/x86_64/boot-options.rst  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 213d0719e2b7..84c582ac246c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6486,6 +6486,7 @@
>  				 to a power of 2.
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
> +			         where a hardware IOMMU is not involved
>  			noforce -- Never use bounce buffers (for debugging)
>  
>  	switches=	[HW,M68k,EARLY]

Yes, this part is correct. SWIOTLB cannot be forced if there is an IOMMU.

> diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
> index 137432d34109..066b4bc81583 100644
> --- a/Documentation/arch/x86/x86_64/boot-options.rst
> +++ b/Documentation/arch/x86/x86_64/boot-options.rst
> @@ -285,7 +285,7 @@ iommu options only relevant to the AMD GART hardware IOMMU:
>        Always panic when IOMMU overflows.
>  
>  iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
> -implementation:
> +implementation where a hardware IOMMU is not involved:
>  
>      swiotlb=<slots>[,force,noforce]
>        <slots>

But this part needs some improvement. The "swiotlb" option is not
entirely ignored if there is a hardware IOMMU. For example, the size of
the SWIOTLB can be adjusted using "swiotlb=<slots>", and since SWIOTLB
can be used by IOMMUs for other purposes (as you correctly note in the
commit message), this setting is relevant even where a hardware IOMMU
is involved.

Petr T
