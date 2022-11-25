Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A55C9B
	for <iommu@lists.linux.dev>; Fri, 25 Nov 2022 15:19:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id v7so3723225wmn.0
        for <iommu@lists.linux.dev>; Fri, 25 Nov 2022 07:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZxVZyzuCq/7TKW0PGUA94kRptUFc8WRLxofFIt0CnI=;
        b=P3+z0KF8dsMt0qrAxIEGZXo07bNXWiO/huhu3CNRAhpcK9dmTJW/KePojtyhK15YHc
         gkfbyR0HY5KO6XE1rKvJkzm6V9sO11b5FR0p5QgNra4qH0tBfoh+LO/6mboK9H/ewWof
         xZrlviHwtp6A+kSqUdMOAER066eEOlupBBPFV7Gi8gQmmMXNns+2QUJ4LkW4zBDPsb8y
         jQmMrkdltUin2AKOov+oup+YrA0XmO8O9x/HEzOqtdvzSm5O9JlxoKs6A8QUEAdbql6u
         hvCUiMu28k2lLiOVUaYtbNlpmksbpy86r/zCCQAxyFkxRXpNDALNWyacE8utj8PfmWEM
         f95Q==
X-Gm-Message-State: ANoB5pnVCyG7UCUlNPLlzUhJg4YfnmVQIkLEvH2Wk2ADE6bSI/mGCRWP
	QcwH11cWB/NTVTtkrd//+6o=
X-Google-Smtp-Source: AA0mqf6RdksmLN5860hkrp3lxt4PM3nDpnu7U9LFfaxxW9+solGQCcJhVDWAaW44mPX5LbxbF1jj8A==
X-Received: by 2002:a05:600c:4b10:b0:3cf:eaf5:77c6 with SMTP id i16-20020a05600c4b1000b003cfeaf577c6mr27241123wmp.56.1669389578960;
        Fri, 25 Nov 2022 07:19:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003c64c186206sm6133436wmn.16.2022.11.25.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:19:38 -0800 (PST)
Date: Fri, 25 Nov 2022 15:19:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, luto@kernel.org,
	peterz@infradead.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lpieralisi@kernel.org,
	robh@kernel.org, kw@linux.com, bhelgaas@google.com, arnd@arndb.de,
	hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
	thomas.lendacky@amd.com, brijesh.singh@amd.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	Tianyu.Lan@microsoft.com, kirill.shutemov@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
	isaku.yamahata@intel.com, dan.j.williams@intel.com,
	jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v4 1/1] x86/ioremap: Fix page aligned size calculation in
 __ioremap_caller()
Message-ID: <Y4DdCD7555d2SpkZ@liuwe-devbox-debian-v2>
References: <1669138842-30100-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669138842-30100-1-git-send-email-mikelley@microsoft.com>

On Tue, Nov 22, 2022 at 09:40:42AM -0800, Michael Kelley wrote:
> Current code re-calculates the size after aligning the starting and
> ending physical addresses on a page boundary. But the re-calculation
> also embeds the masking of high order bits that exceed the size of
> the physical address space (via PHYSICAL_PAGE_MASK). If the masking
> removes any high order bits, the size calculation results in a huge
> value that is likely to immediately fail.
> 
> Fix this by re-calculating the page-aligned size first. Then mask any
> high order bits using PHYSICAL_PAGE_MASK.
> 
> Fixes: ffa71f33a820 ("x86, ioremap: Fix incorrect physical address handling in PAE mode")
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> ---
> 
> This patch was previously Patch 1 of a larger series[1].  Breaking
> it out separately per discussion with Dave Hansen and Boris Petkov.
> 
> [1] https://lore.kernel.org/linux-hyperv/1668624097-14884-1-git-send-email-mikelley@microsoft.com/
> 
>  arch/x86/mm/ioremap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 78c5bc6..6453fba 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -217,9 +217,15 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>  	 * Mappings have to be page-aligned
>  	 */
>  	offset = phys_addr & ~PAGE_MASK;
> -	phys_addr &= PHYSICAL_PAGE_MASK;
> +	phys_addr &= PAGE_MASK;
>  	size = PAGE_ALIGN(last_addr+1) - phys_addr;
>  
> +	/*
> +	 * Mask out any bits not part of the actual physical
> +	 * address, like memory encryption bits.
> +	 */
> +	phys_addr &= PHYSICAL_PAGE_MASK;
> +
>  	retval = memtype_reserve(phys_addr, (u64)phys_addr + size,
>  						pcm, &new_pcm);
>  	if (retval) {
> -- 
> 1.8.3.1
> 
