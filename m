Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DBE2E282B
	for <iommu@lists.linux.dev>; Fri,  2 Jan 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767378433; cv=none; b=oQrDM0Yi1r8q6cLO5RBiRue82fZ6Az+zLoGgiVszwmsL+p+nOBXPijDo7ZqL8l93QvaX8A9ewRr/ql5HfYLNxFayUtP1Ot6AdzImaYbTSWZ1smQQxRVMCKQKl4H4U35WxPCTVcLye18HeYGYUO8MB4KOkHs3mh3T5ODQ1nz8eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767378433; c=relaxed/simple;
	bh=+KG0rvRjvpWUzf+8Fucwf++T+2a/ZuEdLRWJMeUpJ0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6J6+WEIK1muk+V/QmCTZPbr8fG8RMplGu7PgDFHge3NADRhp62CJs8nS56uT1tUb38KBZ0XjD2jrOrmeG02HMJfAkcXpwR5U8Jxfx74cGq8lNtOD8pyXdqt4tJ7c9Xoa2XLMQsLu13FOoPoSuil+VefgWqCbRihWXU9K/4hWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCSAgQQm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCSAgQQm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47a95a96d42so1995e9.1
        for <iommu@lists.linux.dev>; Fri, 02 Jan 2026 10:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767378430; x=1767983230; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wggzIh/uyggaVGyCJ7Xg7yzsieoJ97AxIjCXSYL+yg8=;
        b=nCSAgQQmXYAN6Jl0lS7zFhMbtDW9FmP4+bkha5+LuCNR16BDS3Ng5jKfS8nkYxTD+5
         CF5Lg+0JIdgJ/pTucdrf/j4JRVjoeaQUwu64czLyWZhCauaal2hF10ujpLwQVvTpd7l3
         tOqFEiMIJ2+80fGaJkFX0Koqi4NB/53H6L0EPiQb9vGbfCFYJZlkyk+BQW1cPlVmy8WG
         VrCT1qSDqgbR73RZYD1d6zwA1fW9nzEZvDrscei0eEEHnvwjXgp7MoaJ12M9YsSKZqni
         2F8ZoaVk/60GaiiNTvUuogJ95BuZvMDscH/1RcD3ajXIpljxxnSL6ojqPWLR937p6zFN
         ZKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767378430; x=1767983230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wggzIh/uyggaVGyCJ7Xg7yzsieoJ97AxIjCXSYL+yg8=;
        b=L1bgnMZwK2A/U8WYi9Fr3FjJ9DSjl2PfzYc+p7t9DLZzcKgv8m41mTQZVcy4me9zuR
         KspGZqUBwYspy1o+A8Ff7ZkrYKVcgDtiLbbAMvUXsQ/AgUs9146ppljbPfmY86zWU0fb
         25rP1OJsG4ooGKFlcnwF0PtRm7dfbrwXjmRf+R6WGsH8/PGHtHa0YNZv2JyV6X32DnZC
         O4qDZEnSmeoa2inSZXJV9neXcLesPwsPL2oB+3wKO55KN7KqhS9GtMyCaVwo+a/t5mom
         dwVYBkOicQ5oIA2MLFKfIA8cSZnLCzGVnK0gHLnvXJkZqkq/m8D4pwrFNanhm143bEa8
         jDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4hABvnny71Bld6Wo/0NwCe/WXMubp6ssFMYOYuTP1rzEMANYru2UEYXRpRlvNxt7XIG3soA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybeNeP+93wCX3o4+S2xE+xBX3+pIxRl7wJSFkOACGb4GXzIbI1
	pJwA2bGYAl1xxSMTA5rv2f8lU36GywCOmFGq1EmwqKnlRMGgNHpfSz+3zuvVaBYPmQ==
X-Gm-Gg: AY/fxX7WwweXXIGbqpwbX2n3TYeyo5Eu+yO2KtIiTHUOE89RfnOf3T35jgrVHRTF6ar
	2W2n2x+2S+Bv+SokXyrKrbdRKdmJwuQp9IkzPFdxsgPqGuOkSz5FVq/UpuELucuyfAeryTKCGT6
	5AH9c6cLjtGGlqVJ+NTboToTSSW1N3Tv9Uj8F+lSKZ3jsDRXlh3Tg8aL+rgipn4anFeZg6YLUV2
	DvntMbEBfhsPzafMmkFJoGpfxBsNuI1Y3Oj8bpWKhay+NX1/p5YTZMz1N+HfWFiMee3ZEYXpXd7
	aNPoonRh/7KiwCBNC9XuhnTfTLKiZkxSM9p+VAW6HbadcDeJKiG1BVJ9/KfOwD8d/iwnGcc0YSY
	2OI4bzKcKkLO5+ZALDChsuuM2Y5cnZJoQeH1E+Zcb9r8XdRgGvroRb4gf/a+S0da32QWxbBX0sQ
	QS6RjGGMTdWBwwqE96bF+uS/2c5slwAjfAffhiJLXEeBbjsVyo1BAxVW59JvS4X2g=
X-Google-Smtp-Source: AGHT+IFR2BUb1i2YwkzJ6Oviq2NnQ/74j9hvEehkMoSH/0nN8LiscExmmh5dawi9pBS5mAmdCJrXoQ==
X-Received: by 2002:a05:600c:37ca:b0:475:da0c:38a8 with SMTP id 5b1f17b1804b1-47d6c328d1dmr13525e9.4.1767378429991;
        Fri, 02 Jan 2026 10:27:09 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm86824635f8f.0.2026.01.02.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:27:09 -0800 (PST)
Date: Fri, 2 Jan 2026 18:27:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v5 2/4] iommu/arm-smmu-v3: Mark STE MEV safe when
 computing the update sequence
Message-ID: <aVgN-mkyoOcifTjE@google.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <83f991cbbb1331213aabe7c1fc5f725e79f60ecd.1766093909.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f991cbbb1331213aabe7c1fc5f725e79f60ecd.1766093909.git.nicolinc@nvidia.com>

On Thu, Dec 18, 2025 at 01:41:57PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
> the hypervisor. Since MEV is in STE word 1 this causes a breaking update
> sequence that is not required and impacts real workloads.
> 
> For the purposes of STE updates the value of MEV doesn't matter, if it is
> set/cleared early or late it just results in a change to the fault reports
> that must be supported by the kernel anyhow. The spec says:
> 
>  Note: Software must expect, and be able to deal with, coalesced fault
>  records even when MEV == 0.
> 
> So mark STE MEV safe when computing the update sequence, to avoid creating
> a breaking update.
> 
> Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8dbf4ad5b51e..12a9669bcc83 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1085,6 +1085,16 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
>  VISIBLE_IF_KUNIT
>  void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
>  {
> +	/*
> +	 * MEV does not meaningfully impact the operation of the HW, it only
> +	 * changes how many fault events are generated, thus we can relax it
> +	 * when computing the ordering. The spec notes the device can act like
> +	 * MEV=1 anyhow:
> +	 *
> +	 *  Note: Software must expect, and be able to deal with, coalesced
> +	 *  fault records even when MEV == 0.
> +	 */
> +	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
>  
> -- 
> 2.43.0
> 
