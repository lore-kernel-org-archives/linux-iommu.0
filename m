Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF91FC7C3
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345897; cv=none; b=QMcHYOtdRYlATSWM/QhxxIdLJstWMgZkJW6Zwr0vmf1xbFD5IlFLyDjoqi7LHU0NMp7qi7cw9sOkS2bsdGnn5VYzsIjlCwVEQvhr7Qixp+Z308wHRTEBnG/9lOlQes6ekAaURMWOvZ51tUCQqAAy7+CaSL7x63ok2zKrLR8wI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345897; c=relaxed/simple;
	bh=oK46zR5EIdWKSjGxAI3CdTManFP+ao1Py1hFfDWezpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7CoSaoXpqKb4LCgIXX+pAzoJrkCxvIiHmf1HCm2bd20X+xRJs6jDxHQf6jX2ZcqKjWUl1etnXOxf5D6b28YWRERYwZF/GREXjWB9B5Y2rkWmf1AVhbFczKFq+pJFXrs3ayXBlVf9BLJ6H/+W6mXv6w1tFE77quaJ79G1AaoVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RJRnD7AM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RJRnD7AM"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7c501bbecso465843066b.2
        for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 23:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739345893; x=1739950693; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wLjQan+KyC+EpAJYQuttIKXaoxesdXErEUY1UHSBnrM=;
        b=RJRnD7AM6/QP+lPNqSxfR+m2lo2oU47Wbqr1+JZ39dyHkmfig/VoP65YPqcUGXfOSl
         ota57IFfkjix63RnfjFHQNhmWHydYU6dXAWzMqks8h+gLnEVLL9KzFHnVIAtxy+IkFHt
         VtuIJs7XHxnqfsB+cczUrf2Jz+OQPzwAZYnU9GY57uUXmrgNdjUzjtvBuV9tYwhjXoBX
         UDmfalt4x/4/s9vk2oHDDjL7axzS/ErJXWlQ3HrmdWkHDLc4Fdf67+Oxzpk+dW9wXl8A
         kfLJPpsae/hcu9MmZRWWOZaOTnwuiGeYq45rqeTV2HLhxO4GFxVxv935Ctdujy2t3De2
         rOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345893; x=1739950693;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLjQan+KyC+EpAJYQuttIKXaoxesdXErEUY1UHSBnrM=;
        b=u0dA4kr0o7T7269R+1SeewqgaMtWGvnnOQBwYqq4H/rgN4SQ6P3/G3b46M6oMbvXm9
         +YJ1WZYSvN/AZOqVVxjQpNnWL83T+ISl6dBOrjP2l6nskrHBUzLvkN649L74SY0LxQfW
         iszsn9glR2bROhT1hXT97j5cc7f4jnxCRQ/BzQw9Qdkav4WpWz6VR0lhD0oUWncin6Zd
         /cuZ61PP8SJ94rLSj55ncOcirub6h2I68AMY64mtUOChLL0oAefeyJy8+/LcA5u/o9Wu
         mqrmjkA/K8tSf6U0g8m4YSBNqpZQShcmmGH7Xfayhvug0HWH+dt6kYb7m+ZQA0KH2C2A
         sRDA==
X-Forwarded-Encrypted: i=1; AJvYcCXoa8uM1+zi9Mji0uvPsTO74xoXlVXIsr011X7YxvG4rWqScxStEq4Ssue8zxUBNWu1/XotFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxydqjNs9g/Dv16hohNngf91Z3Bkplduu9kL80V5Uf2VBCIzn/F
	FYAamR0b8SJuTw4arQBIYO/rPLvEjn3hT5ILylM0Zqy0wzHHYXkH2tg/sH4Kmw==
X-Gm-Gg: ASbGncv9is1nOV2AH+yBllzs8w+ne9nY6+KL9rcdKPoJP3rLBkETlZVz9EFAFt8BABM
	ZqfMb2Ubdav7BVtjfAKBve4aeHv7sNsE6BjfPglfCaAu3MmMBjSufiYxBZQL9mjgyR71SYTB+P8
	rCN7vn+xu5JquiTsqkBv8fNQmA5e8WyT0WRKOztPw4pbgz+i9vqtHyv7KxuRklcIQDb15Zkoh2d
	33AVJLfaFFeuKLjeMZs+rN7+qqtvYcK24MRUg9pSUZX5IAjmGX9pUGeD8wgOXlj2FEjTQ3N6kKh
	jD2R8Aqgh7/otlPvj7wI2/BfspZs3JdiyJmuxWM6Vggpo2jQ4qNMNLdrX7yZ80lzgagDPc4EfU8
	z
X-Google-Smtp-Source: AGHT+IEFvNs8uOtbXE41Ln0wTMYaIqbADY6HMkDnwvoMjcBj/NSWHknj+g9ufEucmWh6ko9ZNtziNA==
X-Received: by 2002:a17:907:7d88:b0:ab7:8d23:1fef with SMTP id a640c23a62f3a-ab7f334583amr189319666b.9.1739345892840;
        Tue, 11 Feb 2025 23:38:12 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d243bba5sm394894666b.71.2025.02.11.23.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 23:38:12 -0800 (PST)
Message-ID: <abe2138d-b1a7-4e53-ae5f-ea3c393d50c5@suse.com>
Date: Wed, 12 Feb 2025 08:38:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xen/swiotlb: don't destroy contiguous region in all
 cases
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, iommu@lists.linux.dev
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-3-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20250211120432.29493-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.02.2025 13:04, Juergen Gross wrote:
> In case xen_swiotlb_alloc_coherent() needed to create a contiguous
> region only for other reason than the memory not being compliant with
> the device's DMA mask, there is no reason why this contiguous region
> should be destroyed by xen_swiotlb_free_coherent() later. Destroying
> this region should be done only, if the memory of the region was
> allocated with more stringent placement requirements than the memory
> it did replace.

I'm not convinced of this: Even the mere property of being contiguous
may already be enough to warrant freeing when possible. The hypervisor
may not have that many contiguous areas available. The bigger the
chunk, the more important to give it back once no longer needed in
this shape.

Plus also take into account how Xen behaves here: It specifically tries
to hold back, during boot, lower addressed memory to later satisfy such
requests. Hence even if you don't ask for address restricted memory,
you may get back such. You'd need to compare input and output addresses,
not input addresses and requested restriction to alleviate this.

> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2208,19 +2208,22 @@ void __init xen_init_mmu_ops(void)
>  static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];
>  
>  #define VOID_PTE (mfn_pte(0, __pgprot(0)))
> -static void xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
> -				unsigned long *in_frames,
> -				unsigned long *out_frames)
> +static int xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
> +			     unsigned long *in_frames,
> +			     unsigned long *out_frames)
>  {
>  	int i;
> +	u64 address_bits = 0;

First I was inclined to suggest to use paddr_t here, but ...

>  	struct multicall_space mcs;
>  
>  	xen_mc_batch();
>  	for (i = 0; i < (1UL<<order); i++, vaddr += PAGE_SIZE) {
>  		mcs = __xen_mc_entry(0);
>  
> -		if (in_frames)
> +		if (in_frames) {
>  			in_frames[i] = virt_to_mfn((void *)vaddr);
> +			address_bits |= in_frames[i] << PAGE_SHIFT;

... why do a shift on every loop iteration when you can ...

> +		}
>  
>  		MULTI_update_va_mapping(mcs.mc, vaddr, VOID_PTE, 0);
>  		__set_phys_to_machine(virt_to_pfn((void *)vaddr), INVALID_P2M_ENTRY);
> @@ -2229,6 +2232,8 @@ static void xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
>  			out_frames[i] = virt_to_pfn((void *)vaddr);
>  	}
>  	xen_mc_issue(0);
> +
> +	return fls64(address_bits);

... simply add in PAGE_SHIFT here, once?

> @@ -2321,7 +2326,8 @@ static int xen_exchange_memory(unsigned long extents_in, unsigned int order_in,
>  
>  int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
>  				 unsigned int address_bits,
> -				 dma_addr_t *dma_handle)
> +				 dma_addr_t *dma_handle,
> +				 unsigned int *address_bits_in)
>  {
>  	unsigned long *in_frames = discontig_frames, out_frame;
>  	unsigned long  flags;
> @@ -2336,7 +2342,7 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
>  	spin_lock_irqsave(&xen_reservation_lock, flags);
>  
>  	/* 1. Zap current PTEs, remembering MFNs. */
> -	xen_zap_pfn_range(vstart, order, in_frames, NULL);
> +	*address_bits_in = xen_zap_pfn_range(vstart, order, in_frames, NULL);

Nit: Converting plain int to unsigned int, when there's no real reason
to do any conversion. Since xen_zap_pfn_range() can't return a negative
value for the caller caring about the return value (yet more obviously
so with the suggested adjustment, and then true for both callers), the
function could easily return unsigned int.

Jan
